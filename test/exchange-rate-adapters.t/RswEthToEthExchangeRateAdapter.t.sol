// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { OrigamiTest } from "../OrigamiTest.sol";
import { RswEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/RswEthToEthExchangeRateAdapter.sol";
import { IRswETH } from "src/interfaces/swell/IRswETH.sol";

contract RswEthToEthExchangeRateAdapterTest is OrigamiTest {
    IRswETH public constant RSWETH = IRswETH(0xFAe103DC9cf190eD75350761e95403b7b8aFa6c0);

    RswEthToEthExchangeRateAdapter internal adapter;

    function setUp() public {
        fork("mainnet", 20_066_000);
        adapter = new RswEthToEthExchangeRateAdapter();
    }

    function test_decimals() public view {
        assertEq(adapter.decimals(), uint8(18));
    }

    function test_description() public view {
        assertEq(adapter.description(), "rswETH/ETH exchange rate");
    }

    function test_latestRoundData() public view {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            adapter.latestRoundData();
        assertEq(roundId, 0);
        assertEq(uint256(answer), RSWETH.rswETHToETHRate());
        assertEq(uint256(answer), 1.010001498638344043e18); // Exchange rate queried at block 20066000
        assertEq(startedAt, 0);
        assertEq(updatedAt, 0);
        assertEq(answeredInRound, 0);
    }
}
