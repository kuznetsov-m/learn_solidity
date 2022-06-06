const hre = require('hardhat')
const ethers = hre.ethers

async function main() {
  const [deployer] = await ethers.getSigners()

  const Vault = await ethers.getContractFactory("Vault", deployer)
  // нужно передать bytes32 как аргумент
  // https://docs.ethers.io/v5/single-page/#/v5/api/utils/strings/-%23-Bytes32String
  const vault = await Vault.deploy(ethers.utils.formatBytes32String("secret"))
  await vault.deployed()

  console.log("Vault address:", vault.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })