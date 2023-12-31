// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <= 0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe{


     using  SafeMathChainlink for uint;

    mapping(address => uint256) public addressToAmountFunded;

    address[] public funders;

    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function fund() public payable {
       addressToAmountFunded[msg.sender] += msg.value;
       funders.push(msg.sender);
    }

    function getPrice() public view returns(uint){
        //la direccion puesta esta mal hay q poner una valida
        //ver bien el codigo en el video o repositorio de github
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        (,int price,,,) = priceFeed.latestRoundData();  
        return uint(price); 
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function withdraw() payable onlyOwner public {
       msg.sender.transfer(address(this).balance);
       for (uint funderIndex =0 ; funderIndex < funders.length; funderIndex++) 
       {
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;

       }
       funders = new address[](0);
    }
}