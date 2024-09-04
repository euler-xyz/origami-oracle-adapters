// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { OrigamiTest } from "../OrigamiTest.sol";
import { WstEthStEthExchangeRateAdapter } from "src/exchange-rate-adapters/WstEthStEthExchangeRateAdapter.sol";
import { IStEth } from "src/interfaces/lido/IStEth.sol";

contract WstEthStEthExchangeRateAdapterTest is OrigamiTest {
    IStEth internal constant ST_ETH = IStEth(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);

    WstEthStEthExchangeRateAdapter internal adapter;

    function setUp() public {
        fork("mainnet", 20_066_000);
        adapter = new WstEthStEthExchangeRateAdapter();
    }

    function testDecimals() public view {
        assertEq(adapter.decimals(), uint8(18));
    }

    function testDescription() public view {
        assertEq(adapter.description(), "wstETH/stETH exchange rate");
    }

    function testLatestRoundData() public view {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            adapter.latestRoundData();
        assertEq(roundId, 0);
        assertEq(uint256(answer), ST_ETH.getPooledEthByShares(1 ether));
        assertEq(uint256(answer), 1.169346470791166406e18); // Exchange rate queried at block 20066000
        assertEq(startedAt, 0);
        assertEq(updatedAt, block.timestamp);
        assertEq(answeredInRound, 0);
    }
}
