// SPDX-License-Identifier: No license
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {WETH} from "../../src/WETH.sol";

// For handler function
import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

// Handler function to set certain condition before testing it
contract Handler is CommonBase, StdCheats, StdUtils {
    WETH private weth;
    uint public wethBalance;

    constructor(WETH _weth) {
        weth = _weth;
    }

    // So it's able to receive ETH
    receive() external payable {}

    function sendToFallback(uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        wethBalance += amount;
        (bool success, ) = address(weth).call{value: amount}("");
        require(success, "sendToFallback failed");
    }

    function deposit(uint256 amount) public {
        // Limit the amount from 0 to the amount available, otherwise the function will be reverted if insufficient amount
        amount = bound(amount, 0, address(this).balance);
        wethBalance += amount;
        weth.deposit{value: amount}();
    }

    function withdraw(uint256 amount) public {
        amount = bound(amount, 0, weth.balanceOf(address(this)));
        wethBalance -= amount;
        weth.withdraw(amount);
    }

    function fail() public pure {
        revert("Fail");
    }
}

contract WETH_Handler_Based_Invariant_Test is Test {
    WETH public weth;
    Handler public handler;

    function setUp() public {
        weth = new WETH();
        handler = new Handler(weth);

        deal(address(handler), 100 * 1e18);
        // Only run the functions in the handler contract
        targetContract(address(handler));

        // Target only a certain function to be called instead of randomly calling any functions
        bytes4[] memory selectors = new bytes4[](3);
        selectors[0] = Handler.deposit.selector;
        selectors[1] = Handler.withdraw.selector;
        selectors[2] = Handler.sendToFallback.selector;
        targetSelector(
            FuzzSelector({addr: address(handler), selectors: selectors})
        );
    }

    function invariant_eth_balance() public view {
        assertGe(address(weth).balance, handler.wethBalance());
    }
}
