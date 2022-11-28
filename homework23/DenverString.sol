// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "https://github.com/Arachnid/solidity-stringutils/blob/master/src/strings.sol";

contract Test {
    using strings for *;
    string Denver = " from ETH Denver";
    function addString(string memory _input) external view returns(string memory, uint){
        string memory result = _input.toSlice().concat(Denver.toSlice());
        uint resultLen = result.toSlice().len();
        return (result, resultLen);
    }
}
