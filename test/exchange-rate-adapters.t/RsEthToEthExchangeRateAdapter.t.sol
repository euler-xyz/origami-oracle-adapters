// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { OrigamiTest } from "../OrigamiTest.sol";
import { RsEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/RsEthToEthExchangeRateAdapter.sol";
import { IKelpLRTConfig } from "src/interfaces/kelp/IKelpLRTConfig.sol";
import { IKelpLRTOracle } from "src/interfaces/kelp/IKelpLRTOracle.sol";

contract RsEthToEthExchangeRateAdapterTest is OrigamiTest {
    IKelpLRTConfig public constant KELP_LRT_CONFIG = IKelpLRTConfig(0x947Cb49334e6571ccBFEF1f1f1178d8469D65ec7);
    bytes32 public constant LRT_ORACLE = keccak256("LRT_ORACLE");

    RsEthToEthExchangeRateAdapter internal adapter;

    function setUp() public {
        fork("mainnet", 20_066_000);
        adapter = new RsEthToEthExchangeRateAdapter();
    }

    function test_decimals() public view {
        assertEq(adapter.decimals(), uint8(18));
    }

    function test_description() public view {
        assertEq(adapter.description(), "rsETH/ETH exchange rate");
    }

    function test_latestRoundData() public view {
        IKelpLRTOracle lrtOracle = IKelpLRTOracle(KELP_LRT_CONFIG.getContract(LRT_ORACLE));
        uint256 expectedRate = lrtOracle.rsETHPrice();

        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            adapter.latestRoundData();
        assertEq(roundId, 0);
        assertEq(uint256(answer), expectedRate);
        assertEq(uint256(answer), 1.014115456823606415e18); // Exchange rate queried at block 20066000
        assertEq(startedAt, 0);
        assertEq(updatedAt, 0);
        assertEq(answeredInRound, 0);
    }
}
