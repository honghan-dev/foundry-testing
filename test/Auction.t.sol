pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {Auction} from '../src/Auction.sol';

contract AuctionTest is Test {
    Auction public auction;
    uint256 private startAt;

    function setUp() external {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFailsBeforeStartTime() external {
        vm.expectRevert(bytes('Cannot bid'));
        auction.bid();
    }

    function testBid() external {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailsAfterEndTime() external {
        vm.expectRevert(bytes('Cannot bid'));
        vm.warp(startAt + 2 days);
        auction.bid();
    }

    function testTimestamp() external {
        uint t = block.timestamp;

        // skip
        skip(100);
        assertEq(block.timestamp, t + 100);

        //rewind
        rewind(10);
        assertEq(block.timestamp, t + 100 - 10);
    }

    function testBlockNumber() public {
        // vm.roll() - set block.number
        vm.roll(999);
        assertEq(block.number, 999);
    }
}