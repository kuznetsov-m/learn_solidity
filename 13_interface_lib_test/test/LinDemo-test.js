const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("LibDemo", function () {
  let owner
  let demo

  beforeEach(async function() {
    [owner] = await ethers.getSigners()

    const LibDemo = await ethers.getContractFactory("LibDemo", owner)
    libDemo = await LibDemo.deploy()
    await libDemo.deployed()
  })

  it("compares string", async function () {
    const result = await libDemo.runnerStr("cat", "cat")
    expect(result).to.eq(true)

    const result2 = await libDemo.runnerStr("cat", "dog")
    expect(result2).to.eq(false)
  })

  it("finds uint in array", async function () {
    const result = await libDemo.runnerArr([1,2,3], 2)
    expect(result).to.eq(true)

    const result2 = await libDemo.runnerArr([1,2,3], 42)
    expect(result2).to.eq(false)
  })
});
