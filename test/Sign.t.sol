// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

contract SignTest is Test {
    function testSignature() external pure {
        uint256 privateKey = 123;
        address pubKey = vm.addr(privateKey);

        bytes32 messageHash = keccak256("Secret message");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        address signer = ecrecover(messageHash, v, r, s);

        assertEq(signer, pubKey);

        bytes32 invalidMessageHash = keccak256("Invalid message");
        address signer2 = ecrecover(invalidMessageHash, v, r, s);

        assertTrue(signer2 != signer);
    }
}
