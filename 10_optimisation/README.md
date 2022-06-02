1. Инициализация переменной требует доп газ;
```
contract Op {
    uint a;     // 67066
}

contract Un {
    uint a = 1; // 69324
}
```

2. Упаковка переменных в ячейки по 32 byte (256bit)
Так же работает для строк. Желатьльно чтобы их длина укладываласть в 32 byte.
```
contract Op {
    uint128 a = 1;      //
    uint128 b = 1;      // a и b упакуются в 32 byte
    uint256 c = 1;
    // Данные займут 32 * 2 byte
    // 113512 gas
}

contract Un {
    uint128 a = 1;
    uint256 c = 1;
    uint128 b = 1;     // a и b не упакуются в 32 byte
    // Данные займут 32 * 3 byte
    // 135362 gas
}
```

3. Урезание размерности переменной требует доп. газ
```
contract Op {
    uint a = 1;    // 89240 gas
}

contract Un {
    uint8 a = 1;   // 89629 gas
}
```

4. State переменные, по возможности, следует инициализировать статическими данными. Т.к. лишние вызовы - требуют лишний газ.
```
contract Op {
    bytes32 public hash = 0x9c22ff5f21f0b81b113e63f7db6da94fedef11b2119b4088b89664fb9a3cb658
// 114791
}

contract Un {
    bytes32 public hash = keccak256(
        abi.encodePacked("test")
    )
// 116440
}
```

5. Создание промежуточных переменных тоже требует лишний газ
Например тут в функции pay() добавим переменную _from. Вызов функции будет потреблять больше газа

```
contract Op {
    mapping(address => uint) payments;
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[msg.sender] = msg.value;
        // 23498
    }
}

contract Un {
    mapping(address => uint) payments;
    function pay() external payable {
        address _from = msg.sender;
        require(_from != address(0), "zero address");
        payments[_from] = msg.value;
        // 23512
    }
}
```

6. Массивы более дорогостоющие в работе, чем mapping. А динамические массивы почти x2. 
```
contract Op {
    mapping(address => uint) payments;
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[msg.sender] = msg.value;
        // 23498
    }
}

contract Un {
    uint[10] payments;
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[0] = msg.value;
        // 23438 + затраты на доп переменную index и ее увеличение
    }
}

contract Un {
    uint[] payments;
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments.push(msg.value);
        // 45618
    }
}
```

7. При использовании массивов урезанного типа можно съэкономить газ на хранении. Т.к. будет работать упаковка данных в ячейки.
```
contract Op {
    uint8[3] array = [1, 2, 3];     // 127248
}

contract Un {
    uint[3] array = [1, 2, 3];      // 158612
}
```

8. Большая дробленность функций так же повышает стоимость их вызова. Нужно искать баланс между размером тела функции и колличества функций

```
contract Op {
    uint c = 5;
    uint d;
    function calc() public {
        uint a = 1 + c;
        uint b = 2 * c;
        d = a + b;
    }
    // 46124
}

contract Un {
    uint c = 5;
    uint d;
    function calc() public {
        uint a = 1 + c;
        uint b = 2 * c;
        calc2(a, b);
    }
    function calc2(uint a, uint b) private {
        d = a + b;
    }
    // 46158
}
```

9. Следует избегать частых изменений state переменных. В пользу создания временных переменных под такие операции.
Например при передаче массива [1, 2, 3] получим след результат:
```
contract Op {
    uint public result = 1;
    function doWork(uint[] memory data) public {
        uint temp = 1;
        for(uint i = 0; i < data.length; i++) {
            temp *= data[i];
        }
        result = temp;
        // 29698
    }
}

contract Un {
    uint public result = 1;
    function doWork(uint[] memory data) public {
        for(uint i = 0; i < data.length; i++) {
            result *= data[i];
        }
        // 30128
    }
}
```