// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ERC20} from "../src/ERC20.sol";

contract Token {
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) ERC20(_name, _symbol, _decimals) {}
}

/*
source .env
forge script script/Token.s.sol:TokenScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv
*/

contract TokenScript is Script {
    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("DEV_PRIVATE_KEY");
        address account = vm.addr(privateKey);

        console.log("Account", account);

        vm.startBroadcast(privateKey);

        Token = new Token("My Token", "TKN", 18);
        token.mint(account, 100);

        vm.stopBroadcast();
    }
}
