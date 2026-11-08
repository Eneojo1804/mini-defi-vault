//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/vault.sol";

contract DeployVault is Script{
    function run() external {
        vm.startBroadcast();
        vault vaultContract = new vault();
        vm.stopBroadcast();

        console.log("vault deployed at:", address(vaultContract));
    }
}