// SPDX-License-Identifier: MIT
pragma solidity ^0.4.22;

contract owned{
    address owner;

    constructor() public {
        owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == owner,
        "Only the owner can call this function");
        _;
    }
}
contract mortal is owned{
    function destroy() public onlyOwner{
        selfdestruct(owner);
    }
}


contract Faucet is mortal{
    event Withdrawal(address indexed to,uint ammount);
    event Deposit(address indexed from,uint ammount);

    function withdraw(uint withdraw_amount) public{
        require(withdraw_amount <= 0.1 ether);
        require(this.balance >= withdraw_amount,
        "insuficiente");

        msg.sender.transfer(withdraw_amount);
        emit Withdrawal(msg.sender, withdraw_amount);
    }
    function () public payable {
        emit Deposit(msg.sender, msg.value);
    }
}