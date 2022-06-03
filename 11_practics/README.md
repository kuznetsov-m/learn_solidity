# Auction
Продавцы выставляют свои лоты по максимальной цене - стартуют аукцион. Каждую секунду цена снижается. Процесс продолжается в течении некоторого времени. В это время покупатели дожидаются подходящей для них цены и выкупают лот.

# Tests coverage
solidity-coverage - измерение покрытия тестами
1. 
```
npm install --save-dev solidity-coverage
# или добавить пакет в package.json и выполнить установку npm install
```
2. Добавить в конфигурацию `hardhat.config.js`
```
require("solidity-coverage");
```
3. Теперь доступна команда `npx hardhat coverage`
Пример:
```
> npx hardhat coverage                    

Version
=======
> solidity-coverage: v0.7.21

Instrumenting for coverage...
=============================

> AucEngine.sol

Compilation:
============

Compiled 1 Solidity file successfully

Network Info
============
> HardhatEVM: v2.9.7
> network:    hardhat



  AucEngine
    ✔ sets owner


  1 passing (174ms)

----------------|----------|----------|----------|----------|----------------|
File            |  % Stmts | % Branch |  % Funcs |  % Lines |Uncovered Lines |
----------------|----------|----------|----------|----------|----------------|
 contracts/     |     4.35 |        0 |       25 |     4.35 |                |
  AucEngine.sol |     4.35 |        0 |       25 |     4.35 |... 75,76,80,84 |
----------------|----------|----------|----------|----------|----------------|
All files       |     4.35 |        0 |       25 |     4.35 |                |
----------------|----------|----------|----------|----------|----------------|

> Istanbul reports written to ./coverage/ and ./coverage.json
```

4. (опционально) Для простоты можно добавить свой "shortcut" для команды `npx hardhat coverage`: Добавить в `package.json`
```
  "scripts": {
    "test": "npx hardhat coverage"
  },
```
Далее в консоли становится доступно выполнить
```
npm test
```

## HTML format
`coverage/index.html`