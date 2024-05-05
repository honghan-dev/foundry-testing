pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Error} from "../src/Error.sol";

contract ErrorTest is Test {
    Error public err;

    function setUp() external {
        err = new Error();
    }

    // Using testFail prefix function name
    function testFail() external view {
        err.throwError();
    }

    // Using vm.expectRevert instead of testFail prefix
    function testRevert() public {
        vm.expectRevert();
        err.throwError();
    }

    // Test for correct error message
    function testRequiredMessage() public {
        vm.expectRevert(bytes("not authorized"));
        err.throwError();
    }

    function testCustomError() public {
        vm.expectRevert(Error.NotAuthorized.selector);
        err.throwCustomError();
    }

    function testErrorLabel() public pure {
        assertEq(uint256(1), uint256(1), "1");
        assertEq(uint256(1), uint256(1), "2");
    }
}
