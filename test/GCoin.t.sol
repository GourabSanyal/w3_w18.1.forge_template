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
        assertEq(
            c.balanceOf(0x904025Cfcbe81947A92501D0857F0E33267a2b4F),
            uint256(0),
            "ok"
        );

        // mints to annew address
        c.mint(0x904025Cfcbe81947A92501D0857F0E33267a2b4F, 100);
        assertEq(
            c.balanceOf(0x904025Cfcbe81947A92501D0857F0E33267a2b4F),
            100,
            "ok"
        );
    }

    function testTransfer() public {
        //  mint to myself
        c.mint(address(this), 100);
        // mint to a diff address half the money
        c.transfer(0x904025Cfcbe81947A92501D0857F0E33267a2b4F, 50);

        // check if I have half left
        assertEq(c.balanceOf(address(this)), 50);
        // check if the other person reciveid the half
        assertEq(
            c.balanceOf(0x904025Cfcbe81947A92501D0857F0E33267a2b4F),
            50,
            "ok"
        );

        // changes who is calling this contract
        vm.prank(0x904025Cfcbe81947A92501D0857F0E33267a2b4F);
        // retusn the moeny to the first sender
        c.transfer(address(this), 25);
        // checks if the 2nd sender has half the money
        assertEq(
            c.balanceOf(0x904025Cfcbe81947A92501D0857F0E33267a2b4F),
            25,
            "ok"
        );
        // checks if the 1nd sender has rest of the money
        assertEq(c.balanceOf(address(this)), 75, "ok");
    }

    function testApprovals() public {
        // minted to my address
        c.mint(address(this), 100);
        // approved 2nd address to aceess 50 of my tokens
        c.approve(0x904025Cfcbe81947A92501D0857F0E33267a2b4F, 50);

        // check if they are allowed from my address to acess 50 tokens
        assertEq(
            c.allowance(
                address(this),
                0x904025Cfcbe81947A92501D0857F0E33267a2b4F
            ),
            50
        );
        // check if I am allowed to access tokens from their address
        assertEq(
            c.allowance(
                0x904025Cfcbe81947A92501D0857F0E33267a2b4F,
                address(this)
            ),
            0
        );

        // change the address
        vm.prank(0x904025Cfcbe81947A92501D0857F0E33267a2b4F);
        // 2nd address trying to transfer to themselves (for now, this can be other address)
        // 25 tokens from my address
        c.transferFrom(
            address(this),
            0x904025Cfcbe81947A92501D0857F0E33267a2b4F,
            25
        );

        // check my balance
        assertEq(c.balanceOf(address(this)), 75, "ok");
        // check balance of 2nd address
        assertEq(
            c.balanceOf(address(0x904025Cfcbe81947A92501D0857F0E33267a2b4F)),
            25,
            "ok"
        );
        // check how much allowence is lfet for them
        assertEq(
            c.allowance(
                address(this),
                0x904025Cfcbe81947A92501D0857F0E33267a2b4F
            ),
            25
        );
    }

    function test_Revert_Approvals() public {
        c.mint(address(this), 100);
        c.approve(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f, 10);
        
        vm.prank(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f);
        c.transferFrom(address(this), 0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f, 100);
    }
}
