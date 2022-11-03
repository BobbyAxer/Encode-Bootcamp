// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
contract MyToken is Ownable, ReentrancyGuard, ERC721URIStorage {
    using Counters for Counters.Counter;
    uint256 public Price;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyToken", "MTK") {
        Price = 0.1 ether;
    }

    function safeMint(uint256 amount, string memory tokenURI) external payable nonReentrant {
        uint256 neededAmount = amount * Price;
        require(msg.value == neededAmount, "you dont have enough eth");
        for (uint256 i=0; i<amount+1; i++) {
            uint256 tokenId = _tokenIdCounter.current();
            _safeMint(msg.sender, tokenId);
            _setTokenURI(tokenId, tokenURI);
            _tokenIdCounter.increment();
        }
    }
}
