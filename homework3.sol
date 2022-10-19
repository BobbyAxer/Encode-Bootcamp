// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    uint256 number;
    address public owner;
    address coded;

    constructor () {
        owner = msg.sender;
        coded = 0x000000000000000000000000000000000000dEaD;
    }


    function getOwnerAddres () public view returns (address) {
        if (msg.sender == owner) {
            return owner;
        } else {
            return coded;
        }
    }

    function store(uint256 num) public {
        number = num;
    }


    function retrieve() public view returns (uint256){
        return number;
    }
}
