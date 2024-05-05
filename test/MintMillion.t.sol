//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {IERC20} from "../src/interfaces/IERC20.sol";

contract ForkTest is Test {
    IERC20 public dai;

    function setUp() public {
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testDeposit() public {
        address han = address(123);

        uint256 balanceBefore = dai.balanceOf(han);
        uint256 totalBefore = dai.totalSupply();
        console.log("balance before", balanceBefore / 1e18);
        console.log("total before", totalBefore / 1e18);

        deal(address(dai), han, 1e6 * 1e18, true);

        uint256 balanceAfter = dai.balanceOf(han);
        uint256 totalAfter = dai.totalSupply();
        console.log("balance after", balanceAfter / 1e18);
        console.log("total after", totalAfter / 1e18);
    }
}
