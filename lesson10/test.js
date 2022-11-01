const { expect, assert } = require("chai");
const hre = require("hardhat");
const { time } = require("@nomicfoundation/hardhat-network-helpers");
const { assertHardhatInvariant } = require("hardhat/internal/core/errors");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
describe("VolcanoNFT deployment", function () {
    let volcanoNFT, nftContract, owner, addr1, addr2;
    beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    volcanoNFT = await hre.ethers.getContractFactory("MyToken");
    nftContract = await volcanoNFT.deploy();

  });
  it('Should mint an nft to address', async function () {
      const initial_balance = await nftContract.balanceOf(addr1.address);
      await nftContract.Mint(addr1.address)
      const expectedBalance = initial_balance+1;
      const balanceAfter = await nftContract.balanceOf(addr1.address);
      //assert.equial(currentSupply, expectedSupply);
      expect(balanceAfter).to.equal(expectedBalance);
  });
  it('Should transfer an nft from addr1 to addr2', async function () {
    await nftContract.Mint(addr1.address),
    await expect(
        nftContract.connect(addr1).transferFrom(addr1.address, addr2.address, 0)
      ).to.changeTokenBalances(nftContract, [addr1, addr2], [-1, 1]);
  })
})
