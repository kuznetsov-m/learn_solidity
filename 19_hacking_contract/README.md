# Keypoints
- private переменные можем вычитать из blockchain через web3.
```
web3.eth.getStorageAt(address, slot_number)
ethers.provider.getStorageAt(address контракта, номер слота для чтения данных)
```
- immutable переменные в blockchain хранятся уже с расчитанным значением. Это значение можно глянуть на etherscan. Раздел Contract Creation Code, decompile bytecode.

# Notes
```
npx hardhat clean
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost
npx hardhat console --network localhost

// Вызов методов и переменных развернутого контракта:
> const MyContract = await ethers.getContractFactory("Test")
> const contract = await MyContract.attach("0x5FbDB2315678afecb367f032d93F642f64180aa3")
> await contract.assemblyTest()
> await contract.storageVar()
BigNumber { value: "255" }
// https://ethereum.stackexchange.com/questions/95023/hardhat-how-to-interact-with-a-deployed-contract
```

# Links

- https://www.youtube.com/watch?v=NDCOkaB4dHM

- https://kovan.etherscan.io/address/0x1f98431c8ad98523631ae4a59f267346ea31f984#code