// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { OrigamiTest } from "../OrigamiTest.sol";
import { WeEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/WeEthToEthExchangeRateAdapter.sol";
import { IWeEth } from "src/interfaces/etherfi/IWeEth.sol";

contract WeEthToEthExchangeRateAdapterTest is OrigamiTest {
    IWeEth public constant WEETH = IWeEth(0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee);

    WeEthToEthExchangeRateAdapter internal adapter;

    function setUp() public {
        fork("mainnet", 20_066_000);
        adapter = new WeEthToEthExchangeRateAdapter();
    }

    function test_decimals() public view {
        assertEq(adapter.decimals(), uint8(18));
    }

    function test_description() public view {
        assertEq(adapter.description(), "weETH/ETH exchange rate");
    }

    function test_latestRoundData() public view {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            adapter.latestRoundData();
        assertEq(roundId, 0);
        assertEq(uint256(answer), WEETH.getRate());
        assertEq(uint256(answer), 1.040393022914859755e18); // Exchange rate queried at block 20066000
        assertEq(startedAt, 0);
        assertEq(updatedAt, block.timestamp);
        assertEq(answeredInRound, 0);
    }
}
