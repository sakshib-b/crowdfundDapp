// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// this is library 

library PriceConverter {
  function getPrice(AggregatorV3Interface priceFeed)
    internal
    view
    returns (uint256) 
    // uint256 is value it will return 
  {
    (, int256 answer, , , ) = priceFeed.latestRoundData();
// in above 5 space we have as the address return 5 function however here we just need the data so we will use only oneuint
 // answer has 8 decimal as solidity did not support floating point so it will be in form of int 

    // ETH/USD rate in 18 digit --> 1ether = 10 to the power 18 wai 
    return uint256(answer * 10000000000); // to covert usd in eth  18 decimal -8 =10 so multiple to 10 with 10 zeroes
   
  }

  // 1000000000
  // call it get fiatConversionRate, since it assumes something about decimals
  // It wouldn't work for every aggregator


  function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed)
    internal
    view
    returns (uint256)
  {
    uint256 ethPrice = getPrice(priceFeed);
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
    // the actual ETH/USD conversation rate, after adjusting the extra 0s.
    return ethAmountInUsd;
  }
}
