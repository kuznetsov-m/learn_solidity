const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Hack", function () {
  let owner
  let secret
  let hack

  beforeEach(async function() {
    [owner] = await ethers.getSigners()
    
    const Secret = await ethers.getContractFactory("Secret", owner)
    secret = await Secret.deploy()
    await secret.deployed()
    // console.log("Secret deployed to:", secret.address);

    let secretPwd1 = await ethers.provider.getStorageAt(secret.address, 1)

    const Hack = await ethers.getContractFactory("Hack", owner)
    hack = await Hack.deploy(secretPwd1)
    await hack.deployed()
    // console.log("Hack deployed to:", hack.address);

    // let secretPwd2 = await ethers.provider.getStorageAt(secret.address, 0)
    // let hackPwd2 = await ethers.provider.getStorageAt(hack.address, 0)
    // expect(secretPwd2).to.eq(hackPwd2)

    // let secretFactory = await ethers.provider.getStorageAt(secret.address, 1)
    // let hackFactory = await ethers.provider.getStorageAt(hack.address, 1)
    // expect(secretFactory).to.eq(hackFactory)

    await hack.setNonce(await secret.nonce())
    expect(await secret.nonce()).to.eq(await hack.nonce())
    // console.log("secret.nonce():", await secret.nonce());
    // console.log("hack.nonce():", await hack.nonce());

    let hackPwd1 = await ethers.provider.getStorageAt(hack.address, 1)
    expect(secretPwd1).to.eq(hackPwd1)
  })

  it("set nonce", async function () {
    let nonce = 3
    await hack.setNonce(nonce)
    expect(await hack.nonce()).to.eq(nonce)
  });

  it("calc secret1", async function () {
    let secret1 = await hack.callStatic.calcSecret1()
    await secret.secret1(secret1)
  });

  it("calc secret2", async function () {
    let hack_secret2 = await hack.callStatic.calcSecret2_3(
      await ethers.provider.getStorageAt(hack.address, 1), hack.nonce()
    )

    await secret.secret2(hack_secret2)
  });

  it("calc secret3", async function () {
    let pwd2 = "0x5f668062be9682387cd8957f8339033192b55962f2280292c705e5811dd8df8a";
    let hack_secret3 = await hack.callStatic.calcSecret2_3(
      pwd2, hack.nonce()
    )

    await secret.secret3(hack_secret3)
  });

  it("attack", async function () {
    await hack.attack(secret.address)
  });
});
