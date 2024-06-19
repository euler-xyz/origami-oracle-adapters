// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { OrigamiTest } from "../OrigamiTest.sol";
import { SwEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/SwEthToEthExchangeRateAdapter.sol";
import { ISwETH } from "src/interfaces/swell/ISwETH.sol";

contract SwEthToEthExchangeRateAdapterTest is OrigamiTest {
    ISwETH public constant SWETH = ISwETH(0xf951E335afb289353dc249e82926178EaC7DEd78);

    SwEthToEthExchangeRateAdapter internal adapter;

    function setUp() public {
        fork("mainnet", 20_066_000);
        adapter = new SwEthToEthExchangeRateAdapter();
    }

    function test_decimals() public view {
        assertEq(adapter.decimals(), uint8(18));
    }

    function test_description() public view {
        assertEq(adapter.description(), "swETH/ETH exchange rate");
    }

    function test_latestRoundData() public view {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            adapter.latestRoundData();
        assertEq(roundId, 0);
        assertEq(uint256(answer), SWETH.swETHToETHRate());
        assertEq(uint256(answer), 1.061942797958435491e18); // Exchange rate queried at block 20066000
        assertEq(startedAt, 0);
        assertEq(updatedAt, 0);
        assertEq(answeredInRound, 0);
    }
}
