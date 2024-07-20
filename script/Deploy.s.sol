// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Script } from "forge-std/Script.sol";
import { EzEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/EzEthToEthExchangeRateAdapter.sol";
import { RsEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/RsEthToEthExchangeRateAdapter.sol";
import { RswEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/RswEthToEthExchangeRateAdapter.sol";
import { SwEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/SwEthToEthExchangeRateAdapter.sol";
import { WeEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/WeEthToEthExchangeRateAdapter.sol";

contract DeployScript is Script {
    function run() public {
        vm.startBroadcast();
        deploy();
        vm.stopBroadcast();
    }

    function deploy() internal {
        new EzEthToEthExchangeRateAdapter();
        new RsEthToEthExchangeRateAdapter();
        new RswEthToEthExchangeRateAdapter();
        new SwEthToEthExchangeRateAdapter();
        new WeEthToEthExchangeRateAdapter();
    }
}
