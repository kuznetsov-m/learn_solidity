const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AucEngine", function () {
  let owner
  let seller
  let buyer
  let auct
  
  beforeEach(async function() {
      [owner, seller, buyer] = await ethers.getSigners() 

      const AucEngine = await ethers.getContractFactory("AucEngine", owner)
      auct = await AucEngine.deploy()
      await auct.deployed()
  })

  it("sets owner", async function() {
      const currentOwner = await auct.owner();
      // console.log(currentOwner)
      expect(currentOwner).to.eq(owner.address)
  })
  
  async function getTimestamp(blockNumber) {
    return (
      await ethers.provider.getBlock(blockNumber)
    ).timestamp
  }

  // Для группировки можно добавить вложенные describe(), например, под конкретную функцию
  describe("createAction", function () {
    it("creates action correctly", async function() {
      const duration = 60;
      const tx = await auct.createAuction(
        ethers.utils.parseEther("0.0001"),
        3,
        "test item",
        duration
      )

      const cAuction = await auct.auctions(0)
      // console.log(cAuction)
      expect(cAuction.item).to.eq("test item")

      // console.log(tx)
      const timestamp = await getTimestamp(tx.blockNumber)
      expect(cAuction.endAt).to.eq(timestamp + duration)
    })
  })

  function delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
  }

  describe("createAction", function () {
    it("allows to buy", async function() {
      const duration = 60;
      const tx = await auct.connect(seller).createAuction(
        ethers.utils.parseEther("0.0001"),
        3,
        "test item",
        duration
      )

      // настраиваем в данном тесте параметр таймаут для фреймворка mocha, чтобы не завершиться досрочно 
      this.timeout(5000) // 5s

      // ожидаем 1 сек, чтобы изменилась цена в аукционе
      await delay(1000)

      const buyTx = await auct.connect(buyer).
        buy(0, {value: ethers.utils.parseEther("0.0001")})

      const cAuction = await auct.auctions(0)
      const finalPrice = cAuction.finalPrice
      
      //waffle
      await expect(() => buyTx).
        to.changeEtherBalance(
          seller, finalPrice - Math.floor((finalPrice * 10) / 100)
        )

      await expect(buyTx)
        .to.emit(auct, "AuctionEnded")
        .withArgs(0, finalPrice, buyer.address)

      await expect(
        auct.connect(buyer).
          buy(0, {value: ethers.utils.parseEther("0.0001")})
      ).to.be.revertedWith("Auction stopped")
    })
  })
});
