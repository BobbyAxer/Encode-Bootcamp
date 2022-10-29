const { expect, assert } = require("chai");
const hre = require("hardhat");
const { time } = require("@nomicfoundation/hardhat-network-helpers");
const { assertHardhatInvariant } = require("hardhat/internal/core/errors");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
describe("Volcano deployment", function () {
    let volcano, vCoin, owner, addr1, addr2;
    beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    volcano = await hre.ethers.getContractFactory("VolcanoCoin");
    vCoin = await volcano.deploy();

  });
  it('Total supply should be 10000', async function () {
      const currentSupply = await vCoin.get_supply();
      const expectedSupply = 10000;
      //assert.equial(currentSupply, expectedSupply);
      expect(currentSupply).to.equal(expectedSupply);
  });
  it('Should incrrase supply by 1000', async function () {
    const expectedValue = 1000;
    const currentSupply = await vCoin.get_supply();
    const changeSupply = await vCoin.set_supply();
    await changeSupply.wait(1);
    const newSupply = await vCoin.get_supply();
    const supplyDelta = newSupply - currentSupply;
    //assert.equial(supplyDelta, expectedValue);
    expect(supplyDelta).to.equal(expectedValue);
  })
  it('Should fail if caller is not an owner', async function () {
    await expect(
        vCoin.connect(addr1).set_supply()
  ).to.be.revertedWith('Ownable: caller is not the owner')
  })
})

