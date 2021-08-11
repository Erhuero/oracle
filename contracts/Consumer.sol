pragma solidity ^0.8.6;
//SPDX-License-Identifier:UNLICENSED

import './IOracle.sol';

contract Consumer {
    //pointer to the oracle
    IOracle public oracle;

    constructor(address _oracle) {
        oracle = IOracle(_oracle);
    }

    function foo() external {
        //compute the key of the data we want
        //keccak needs bytes in input
        //hash of the price
        bytes32 key = keccak256(abi.encodePacked('BTC/USD'));
        //oracle contract
        (bool result, uint timestamp, uint data) = oracle.getData(key);
        require(result == true, 'could not get price');
        require(timestamp >= block.timestamp  - 2 minutes, 'price too old');
        //do something with the price
    }
}