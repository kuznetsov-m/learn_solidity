# Memory и calldata

За счет копирования данных в memory, действия с memory требуют газ.
calldata - это данные, которые отправляются через msg. Данные не изменяемые. Поэтому требует меньше газа

`mload()` и `calldataload()` функции для чтения из соответствующего хранилища

# Notes

https://docs.soliditylang.org/en/v0.8.14/internals/layout_in_memory.html

Память представлена 32 bytes слотами.
0-1 слоты - служебное пространство
2 слот - указатель на свободное место в памяти (free memory pointer)
3 слот - zero slot
4-... слоты для записи данных в память

Передавая данные в метод через memory - данные будут скопированы в memory.
Типы вроде uint, bool, address попадают на в память, а в специальный стек, который также является временным хранилищем.

## Селектор
Расчитанный селектор можно сверить с artifacts/ContractName.json интерфейсом
```
// 0xfb142e3b    <- work2()

		"methodIdentifiers": {
			"selector()": "ea3d508a",
			"work(uint256[3])": "1c28968b",
			"work2(uint256[3])": "fb142e3b"
		}
```

# Links 

https://www.youtube.com/watch?v=xsV9FkDKcJY