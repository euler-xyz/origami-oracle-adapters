// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { Test, StdChains } from "forge-std/Test.sol";

/// @notice A forge test base class which can setup to use a fork, deploy UUPS proxies, etc
abstract contract OrigamiTest is Test {
    uint256 internal forkId;
    uint256 internal blockNumber;
    StdChains.Chain internal chain;

    // Fork using .env $<CHAIN_ALIAS>_RPC_URL (or the default RPC URL), and a specified blockNumber.
    function fork(string memory chainAlias, uint256 _blockNumber) internal {
        blockNumber = _blockNumber;
        chain = getChain(chainAlias);
        forkId = vm.createSelectFork(chain.rpcUrl, _blockNumber);
    }
}
