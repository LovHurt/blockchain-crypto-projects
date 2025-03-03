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

    //Getting the equity in Cancoins of an investor
    function equity_in_cancoins(address investor) external view returns (uint) {
        return equity_cancoins[investor];
    }

    //Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    //Buying Cancoins
    function buy_cancoins(address investor, uint usd_invested) external can_buy_cancoins(usd_invested) {
        uint cancoins_bought = usd_invested * usd_to_cancoins;
        equity_cancoins[investor] += cancoins_bought;
        equity_usd[investor] = equity_cancoins[investor] / usd_to_cancoins;
        total_cancoins_bought += cancoins_bought;
    }
}