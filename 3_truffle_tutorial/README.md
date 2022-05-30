# Console
```
truffle console

truffle(development)> VendingMachine.deployed().then((x) => { contract = x})
undefined
truffle(development)> contract.getVendingMachineBalance().then((b) => { bal = b })
undefined
truffle(development)> bal
BN {
  negative: 0,
  words: [ 100, <1 empty item> ],
  length: 1,
  red: null
}
truffle(development)> bal.toString()
'100'
truffle(development)> 
```

# Deploy
## to Rinkeby testnet
https://rinkeby.etherscan.io/address/0xA3b50907Fbb3a74d1090Aa00C4AAF54505399c95

```
truffle migrate --network rinkeby

Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.


Starting migrations...
======================
> Network name:    'rinkeby'
> Network id:      4
> Block gas limit: 29970705 (0x1c95111)


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x28ef5f7afdef838aada9ec62683d60a3f727336f654fa9e8c58b5070ecc1e428
   > Blocks: 1            Seconds: 16
   > contract address:    0x2b182E19Cc1a0E61CA82e934617B5c3240bdF7C6
   > block number:        10766127
   > block timestamp:     1653910405
   > account:             0xc7116D7AbF08e200FA379F51053f0C3A160d8367
   > balance:             0.09937461499624769
   > gas used:            250154 (0x3d12a)
   > gas price:           2.500000015 gwei
   > value sent:          0 ETH
   > total cost:          0.00062538500375231 ETH

   Pausing for 2 confirmations...

   -------------------------------
   > confirmation number: 1 (block: 10766128)
   > confirmation number: 2 (block: 10766129)
   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:     0.00062538500375231 ETH


2_vending_machine_migration.js
==============================

   Deploying 'VendingMachine'
   --------------------------
   > transaction hash:    0x2ed3593d09ef367194f94fcadab054bf6967181bc1dad3f35cc53b3dad8cadf9
   > Blocks: 1            Seconds: 12
   > contract address:    0xA3b50907Fbb3a74d1090Aa00C4AAF54505399c95
   > block number:        10766131
   > block timestamp:     1653910467
   > account:             0xc7116D7AbF08e200FA379F51053f0C3A160d8367
   > balance:             0.09787081748838203
   > gas used:            555606 (0x87a56)
   > gas price:           2.500000013 gwei
   > value sent:          0 ETH
   > total cost:          0.001389015007222878 ETH

   Pausing for 2 confirmations...

   -------------------------------
   > confirmation number: 1 (block: 10766132)
   > confirmation number: 2 (block: 10766133)
   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:     0.001389015007222878 ETH

Summary
=======
> Total deployments:   2
> Final cost:          0.002014400010975188 ETH
```

## to mainnet
```
truffle migrate --network mainnet

Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.


Starting migrations...
======================
> Network name:    'mainnet'
> Network id:      1
> Block gas limit: 30000000 (0x1c9c380)


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
 *** Deployment Failed ***

"Migrations" -- insufficient funds for gas * price + value.


Exiting: Review successful transactions manually by checking the transaction hashes above on Etherscan.


Error:  *** Deployment Failed ***

"Migrations" -- insufficient funds for gas * price + value.

    at /usr/local/lib/node_modules/truffle/build/webpack:/packages/deployer/src/deployment.js:379:1
    at processTicksAndRejections (node:internal/process/task_queues:96:5)
    at Migration._deploy (/usr/local/lib/node_modules/truffle/build/webpack:/packages/migrate/Migration.js:68:1)
    at Migration._load (/usr/local/lib/node_modules/truffle/build/webpack:/packages/migrate/Migration.js:54:1)
    at Migration.run (/usr/local/lib/node_modules/truffle/build/webpack:/packages/migrate/Migration.js:202:1)
    at Object.runMigrations (/usr/local/lib/node_modules/truffle/build/webpack:/packages/migrate/index.js:152:1)
    at Object.runFrom (/usr/local/lib/node_modules/truffle/build/webpack:/packages/migrate/index.js:117:1)
    at Object.run (/usr/local/lib/node_modules/truffle/build/webpack:/packages/migrate/index.js:94:1)
    at module.exports (/usr/local/lib/node_modules/truffle/build/webpack:/packages/core/lib/commands/migrate/runMigrations.js:10:1)
    at Object.module.exports [as run] (/usr/local/lib/node_modules/truffle/build/webpack:/packages/core/lib/commands/migrate/run.js:41:1)
    at Command.run (/usr/local/lib/node_modules/truffle/build/webpack:/packages/core/lib/command.js:189:1)
Truffle v5.5.15 (core: 5.5.15)
Node v16.15.0
```

# Source
[Video tutorial](https://www.youtube.com/watch?v=YYJgeV7sOvM)

https://github.com/jspruance/block-explorer-tutorials/blob/main/smart-contracts/solidity/VendingMachine.sol

[https://faucet.rinkeby.io/](https://faucet.rinkeby.io/)

https://infura.io/

https://ethgasstation.info/