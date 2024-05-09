//Get funds from users
//withdraw funds
//set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    uint256 public minimumUsd = 50 * 1e18;

    address public owner;

    constructor(){
        owner=msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= minimumUsd,
            "Didn't send enough!"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        // require(msg.sender == owner,"Sender is not owner!");
        /* starting index,ending index,step amount*/
        for(uint256 funderIndex=0;funderIndex< funders.length;funderIndex++){
            //code
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        //reset the array
        funders=new address[](0);
        // //transfer 2300gas throw err
        // payable(msg.sender).transfer(address(this).balance);
        // //send 2300gas bool
        // bool sendSuccess=payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Send failed");
        //call allgas bool
       (bool callSuccess,)= payable(msg.sender).call{value:address(this).balance}("");
       require(callSuccess,"call failed");
    }

    function getVersion() public view returns (uint256) {
         // ETH / USD 
        // sepolia
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256) {
         // ETH / USD 
        // sepolia
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    modifier onlyOwner{
       require(msg.sender == owner,"Sender is not owner!");
       _;
    }

    // function withdraw(){}
}
