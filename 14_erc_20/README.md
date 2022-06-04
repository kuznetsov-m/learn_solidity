# MShop and ERC20 example token

Схема взаимодействия с контрактами:

<img src="https://github.com/kuznetsov-m/learn_solidity/blob/master/14_erc_20/scheme.drawio.png" height="700" />

# Проверка работы
- запустить локальную node
- выполнить deploy
- подключить Metamask
- импортировать аккаунт
- испортировать токен (aдрес контракта токена распечатан в процессе deploy)

# Notes
- Set Solidity version
Версия Solidity задается в файле `hardhat.config.js`
```
module.exports = {
  solidity: "0.8.13",   // here
};
```

- Start hardhat node
```
npx hardhat node
```

- hardhat deploy via script
```
npx hardhat run scripts/deploy.js --network localhost
```

- Подключив Metamask к локальной node - можем импортировать аккаунт через указание закрытого ключа (hardhat node распечатал их в консоли)