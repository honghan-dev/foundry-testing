// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";
import {console} from "forge-std/console.sol";

/**
 * Note: setup function will be run when each function runs
 */
contract AuthTest is Test {
    // Declares that wallet is a type of Wallet contract - Similiar to typescript.
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
        console.log("Set up address", wallet.owner());
    }

    function testSetOwner() external {
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
        console.log("New owner", wallet.owner());
    }

    /**
     * testFail means expecting this test to fail. So the test is successful if the code fails.
     */
    function testFailNotOwner() public {
        vm.prank(address(1));
        wallet.setOwner(address(1));
    }

    function testFailSetOwnerAgain() public {
        // msg.sender = address(this) = 0xabcdefg12345678 for example
        wallet.setOwner(address(1));
        console.log(wallet.owner());

        // Artificially set it to address(1) until it stops
        vm.startPrank(address(1));

        for (int256 i = 0; i < 3; i++) {
            wallet.setOwner(address(1));
            console.log(wallet.owner());
        }

        vm.stopPrank();
        console.log(wallet.owner());
        // After stop prank the address is the test contract
        wallet.setOwner(address(1));
    }
}
