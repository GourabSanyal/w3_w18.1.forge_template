// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/GCoin.sol";

contract TestGCoin is Test {
    GCoin c;

    function setUp() public {
        c = new GCoin();
    }

    function testMint() public {
        // mints token to myself
        c.mint(address(this), 100);
        // check ig the balance of my adress is same as
        // the amount minted
        assertEq(c.balanceOf(address(this)), 100, "ok");

        // checks balance of other random address
        assertEq(c.balanceOf(0x904025Cfcbe81947A92501D0857F0E33267a2b4F), uint256(0), "ok");

        // mints to annew address
        c.mint(0x904025Cfcbe81947A92501D0857F0E33267a2b4F, 100);
        assertEq(c.balanceOf(0x904025Cfcbe81947A92501D0857F0E33267a2b4F), 100, "ok");

    }
}
