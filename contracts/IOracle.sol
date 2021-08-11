pragma solidity ^0.8.6;
//SPDX-License-Identifier:UNLICENSED

//function to get data
interface IOracle {
    function getData(bytes32 key) 
    external 
    view 
    returns(bool result, uint date, uint payload);
}