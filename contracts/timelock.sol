// SPDX-License-Identifier: MIT
pragma solidity ^0.4.2;
contract TimeLock{
     mapping (address => uint) balances;
     mapping (address => uint) locktime;

     function deposit() public payable {
        balances[msg.sender] += msg.value;
        locktime[msg.sender] += now + 1 weeks;
     }

     function increaseLockTime(uint _seconds) public {
        locktime[msg.sender] += _seconds;
     }

     function withdraw() public {
        require(balances[msg.sender] > 0);
        require(now > locktime[msg.sender]);
        balances[msg.sender] = 0;
        msg.sender.transfer(this.balance);
     }
}