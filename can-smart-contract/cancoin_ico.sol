//Cancoin ICO

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract cancoin_ico {

    //Introducing the maximum number of Cancoins available for sale
    uint public max_cancoins = 1000000;

    //Introducing to USD to Cancoins conversion rate
    uint public usd_to_cancoins = 1000;

    //Introducing the total number of Cancoins that have been bought by the investors
    uint public total_cancoins_bought = 0;

    //Mapping from the investor address to its equity in Cancoins and USD
    mapping(address => uint) equity_cancoins;

    mapping(address => uint) equity_usd;

    //Checking if an investor can buy Cancoins
    modifier can_buy_cancoins(uint usd_invested) {
        require(usd_invested * usd_to_cancoins + total_cancoins_bought <= max_cancoins);
        _;
    }
}