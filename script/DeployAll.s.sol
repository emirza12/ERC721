// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/MyERC20.sol";  // Assuming correct path and filename
import "../src/MyERC223.sol";
import "../src/MyERC721.sol";

contract DeployAllTokens is Script {
    function run() public {
        vm.startBroadcast();

        // Deploy ERC20 Token and store instance
        MyERC20 erc20 = new MyERC20();  // Adjust class name if necessary
        console.log("Deployed ERC20 Token at:", address(erc20));

        // Deploy ERC223 Token and store instance
        MyERC223 erc223 = new MyERC223();  // Adjust class name if necessary
        console.log("Deployed ERC223 Token at:", address(erc223));

        // Deploy ERC721 Token and store instance
        MyERC721 erc721 = new MyERC721(address(erc20), address(erc223));  // Adjust class name if necessary
        console.log("Deployed ERC721 Token at:", address(erc721));

        vm.stopBroadcast();
    }
}
