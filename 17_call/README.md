# Call()
## receive()
```
(bool success, ) = otherContract.call{value: msg.value}("");
```
value - сумма средств которые хотим отправить в вызываемый метод
("") - передаваемые в метод данные

возвращаемое значение:
1. success - результат вызова call()
2. - возвращаемое значение вызова метода (всегда в виде bytes)

В отличии от transfer() не прерывает работу, в случае ошибки. Просто возвращает success - false.
Transfer() - лимитирован по gas = 2300. Принимаемая функция receive() будет лимитирована на выполнение операций. Остается подвержен reentrancy.

## function with args
Вызов метода через низкоуровневый call() без пересылки средств.
```
(bool success, bytes memory responce) = otherContract.call(
    abi.encodeWithSignature("setName(string)", _name);
);
```
`abi.encodeWithSignature()` - хеширует вызов. Аргументы:
1. Строка с именем метода и аргументами
2. Аргументы для вызываемого метода

Если имеется исходный код контракта, в котором вызывается метод, то вызов возможен следующим образом:
```
(bool success, bytes memory responce) = otherContract.call(
    abi.encodeWithSelector(AnotherContract.setName.selector, _name)
);

```

### decode responce
```
    (bool success, bytes memory responce) = otherContract.call(
        abi.encodeWithSignature("setName(string)", _name)
    );

    require(success, "cant set name");

    emit Responce(abi.decode(responce, (string)));  // декодирования байт в строку
```

# delegatecall()
пользователь -> contract_1 -> contract_2
Позволяет сделать вызов метода из целевого контракта (contract_2) в контексте нашего контракта (contract_1).
```
function delCallGetData() external payable {
    (bool success, ) = otherContract.delegatecall(
        abi.encodeWithSelector(AnotherContract.getData.selector)
    );

    require(success, "failed");
}

contract AnotherContract {
    event Received(address sender, uint value);

    function getData() external payable {
        emit Received(msg.sender, msg.value);
    }
}
```
Таким образом целевой контракт получит msg.sender == адресу пользователя. Так же можно отправить средства в метод целевого контракта.

## Установка переменных
Если в целевом контракте внутри метода идет задание значений переменных, то при объявлении тех же переменных внутри нашего контракта (contract_1) мы можем поменять контекст к котором выполняется метод. Таким образом внутри вызываемого метода целевого контракта (contract_2) переменные подменятся на переменные нашего контракта (contract_1).
Важное условие для воспроизведения данного эффекта - последовательность объявления переменных в нашем контракте должна соответствовать последовательности объявления переменных в целевом контракте (раскладка в памяти).

Этим эффектом можно воспользоваться и перезаписать переменные в атакуемом контракте.
Пример передачи адреса в метод, который принимает uint:
```
contract Hack {
    //(...)
    function attack() external {
        toHack.delCallGetData(uint(uint160(address(this))));
    }
}

contract MyContract {
    //(...)
    function delCallGetData(uint timestamp) external payable {
        (bool success, ) = otherContract.delegatecall(
            abi.encodeWithSelector(AnotherContract.getData.selector, timestamp)
        );

        require(success, "failed");
    }
}
```

Защита от атаки:
- использовать одинаковый порядок переменных внутри контрактов MyContract и AnotherContract
- минимизация использования методов delegatecall()

# Links

https://www.youtube.com/watch?v=QzdMZbcn3o4