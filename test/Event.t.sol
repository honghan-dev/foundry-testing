pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {Event} from '../src/Event.sol';

contract EventTest is Test {
    Event public e;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() external {
        e = new Event();
    }

    function testEmitTransferEvent() external {
        // 1. Tell Foundry which data to check
        vm.expectEmit(
            // Checktopic1 - compare the first emit data
            true,
            // Checktopic2 - compare the 2nd emit data
            true,
            // Checktopic3 - whether there are more than 2 indexed param
            false,
            // Check data
            true
        );

        // 2. Emit the expected event
        emit Transfer(address(this), address(123), 456);

        // 3. Call the emit funtion
        e.transfer(address(this), address(123), 456);

        // Check index 1 only.
        vm.expectEmit(
            true,
            false,
            false,
            false
        );
        emit Transfer(address(this), address(123), 456);
        e.transfer(address(this), address(123), 456);
    }

    function testEmitManyTransferEvent() external {
        address[] memory to = new address[](2);
        to[0] = address(123);
        to[0] = address(456);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 777;
        amounts[1] = 888;

        for (uint256 i; i < to.length; i++) {
            // 1. Tell foundry which data to check
            // 2. Emit the expected event
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amounts[i]);
        }
        // 3. Call the function that should emit the event
        e.transferMany(address(this), to, amounts);
    }
}