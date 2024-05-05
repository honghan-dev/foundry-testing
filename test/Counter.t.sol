// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Test, stdError} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() external {
        counter = new Counter();
    }

    function testIncrement() external {
        counter.increment();
        assertEq(counter.count(), 1);
    }

    function testFailDecrement() external {
        counter.decrement();
    }

    function testDecrementUnderflow() external {
        vm.expectRevert(stdError.arithmeticError);
        counter.decrement();
    }

    function testDecrement() external {
        counter.increment();
        counter.increment();
        counter.decrement();
        assertEq(counter.count(), 1);
    }
}
