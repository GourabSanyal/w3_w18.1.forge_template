// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Counter.sol";

contract TestContract is Test {
    Counter c;

    function setUp() public {
        c = new Counter(5);
    }

    function testIncreament() public {
        c.increase();
        c.increase();
        assertEq(c.getNum(), uint256(7), "ok");
    }

    function testDecrease() public {
        c.decrease();
        c.decrease();
        assertEq(c.getNum(), uint256(3), "ok");
    }
}
