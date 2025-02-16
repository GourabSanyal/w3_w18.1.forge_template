// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract Counter {

    uint private num;

    constructor(uint _num){
        num = _num;
    }

    function increase() public   {
        num++;
    }

    function decrease() public {
        num--;
    }
    
    function getNum() public view returns (uint256) {
        return num;
    }

 }
