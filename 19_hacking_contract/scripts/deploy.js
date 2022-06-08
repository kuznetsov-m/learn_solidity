const hre = require("hardhat");
const ethers = hre.ethers

async function main() {
  const [owner] = await ethers.getSigners()

  const Secret = await ethers.getContractFactory("Secret", owner)
  const secret = await Secret.deploy()
  await secret.deployed()

  console.log("Secret deployed to:", secret.address);
  //console.log(await erc.token())
  
  let secretPwd1 = await ethers.provider.getStorageAt(secret.address, 1);

  const Hack = await ethers.getContractFactory("Hack", owner)
  const hack = await Hack.deploy(secretPwd1)
  await hack.deployed()

  console.log("Hack deployed to:", hack.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
