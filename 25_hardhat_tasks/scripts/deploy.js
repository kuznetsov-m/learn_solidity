const hre = require("hardhat");
const ethers = hre.ethers

async function main() {
  const [signer] = await ethers.getSigners()

  const Demo = await ethers.getContractFactory("Demo", signer)
  const demo = await Demo.deploy()
  await demo.deployed()

  console.log("Demo deployed to:", demo.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
