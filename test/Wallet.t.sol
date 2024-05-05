// SPDX-License-Identifier: No license
pragma solidity ^0.8.18;

import {Test} from 'forge-std/Test.sol';
import {console} from 'forge-std/console.sol';
import {Wallet} from '../src/Wallet.sol';

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() external {
        wallet = new Wallet{value: 1e18}();
    }

    function _send(uint256 amount) private {
        (bool ok,) = address(wallet).call{value: amount}('');
        require(ok, 'Send ETH failed');
    }

    function testEthBalance() view public {
        console.log('ETH balance', address(this).balance / 1e18);
    }

    function testSendEth() public {
        uint balance = address(wallet).balance;
        // Send eth
        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        deal(address(1), 10);
        // Eth only equals to 10 not 110 from previous call.
        assertEq(address(1).balance, 10);


        deal(address(1), 123);
        // Prank sets the msg.sender, otherwise the msg.sender will be the contract address
        vm.prank(address(1));
        _send(123);

        hoax(address(1), 456);
        _send(456);
        assertEq(address(wallet).balance, balance + 123 + 456);
    }
}