// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {
    uint256 TotalSupply = 10000;
    //address public owner;
    mapping(address=>uint256) public balances;
    mapping(address=>Payment[]) public transfersHistory;
    // uint256 balances;

    constructor() {
        //owner = msg.sender;
        balances[msg.sender] = TotalSupply;
    }


    event SupplyChange(uint256 newSupply);
    event TokenTransfer(uint256 _amount, address _recipient);

    struct Payment {
        uint256 amount;
        address recipent;
    }

    function get_supply() public view returns(uint256) {
        return TotalSupply;
    }

    function set_supply() public onlyOwner {
        TotalSupply += 1000;
        emit SupplyChange(TotalSupply);
    }

    function transfer(uint256 _amount, address _recipient) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit TokenTransfer(_amount, _recipient);
        // Payment[] storage _payment = transfersHistory[msg.sender];
        // _payment.push(Payment(_amount, _recipient));
        recordPayment(msg.sender, _recipient, _amount);
    }
    function viewPaymentHistory (address _sender) view external returns(Payment[] memory) {
        return transfersHistory[_sender];
    }

    function recordPayment(address _sender, address _receiver, uint256 _amount) internal {
        transfersHistory[_sender].push(Payment(_amount, _receiver));
    }
}
