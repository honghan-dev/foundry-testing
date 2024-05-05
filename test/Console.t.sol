pragma solidity ^0.8;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract ConsoleTest is Test {
    function testLogSomething() external view {
        console.log("Log something here", 123);
    }
}
