// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

contract IntroInvariant {
    bool public flag;

    function func_1() external {}
    function func_2() external {}
    function func_3() external {}
    function func_4() external {}
    function func_5() external {
        flag = true;
    }
}

contract IntroInvriantTest is Test {
    IntroInvariant private target;

    function setUp() external {
        target = new IntroInvariant();
    }

    function invariant_flag_always_false() external view {
        assertEq(target.flag(), false);
    }
}