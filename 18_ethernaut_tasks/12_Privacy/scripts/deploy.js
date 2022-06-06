const hre = require('hardhat')
const ethers = hre.ethers

async function main() {
  const [deployer] = await ethers.getSigners()

  const Privacy = await ethers.getContractFactory("Privacy", deployer)
  // нужно передать bytes32[] как аргумент
  // https://docs.ethers.io/v5/single-page/#/v5/api/utils/strings/-%23-Bytes32String
  const privacy = await Privacy.deploy([
    ethers.utils.formatBytes32String("secret1"),
    ethers.utils.formatBytes32String("secret2"),
    ethers.utils.formatBytes32String("secret3"),
  ])
  await privacy.deployed()

  console.log("Privacy address:", privacy.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })