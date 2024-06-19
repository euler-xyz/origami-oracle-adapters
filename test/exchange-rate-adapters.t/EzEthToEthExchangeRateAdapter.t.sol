// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { OrigamiTest } from "../OrigamiTest.sol";
import { EzEthToEthExchangeRateAdapter } from "src/exchange-rate-adapters/EzEthToEthExchangeRateAdapter.sol";
import { IRenzoRestakeManager } from "src/interfaces/Renzo/IRenzoRestakeManager.sol";
import { IRenzoOracle } from "src/interfaces/Renzo/IRenzoOracle.sol";
import { IERC20 } from "src/interfaces/IERC20.sol";

contract EzEthToEthExchangeRateAdapterTest is OrigamiTest {
    IRenzoRestakeManager public constant RENZO_RESTAKE_MANAGER =
        IRenzoRestakeManager(0x74a09653A083691711cF8215a6ab074BB4e99ef5);
    IERC20 public constant EZ_ETH = IERC20(0xbf5495Efe5DB9ce00f80364C8B423567e58d2110);

    EzEthToEthExchangeRateAdapter internal adapter;

    function setUp() public {
        fork("mainnet", 20_066_000);
        adapter = new EzEthToEthExchangeRateAdapter();
    }

    function test_decimals() public view {
        assertEq(adapter.decimals(), uint8(18));
    }

    function test_description() public view {
        assertEq(adapter.description(), "ezETH/ETH exchange rate");
    }

    function expectedRate() private view returns (uint256) {
        (,, uint256 _currentValueInProtocol) = RENZO_RESTAKE_MANAGER.calculateTVLs();
        uint256 totalSupply = EZ_ETH.totalSupply();
        return IRenzoOracle(RENZO_RESTAKE_MANAGER.renzoOracle()).calculateRedeemAmount(
            1 ether, totalSupply, _currentValueInProtocol
        );
    }

    function test_latestRoundData() public view {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            adapter.latestRoundData();
        assertEq(roundId, 0);
        assertEq(uint256(answer), expectedRate());
        assertEq(answer, 1.011474492485111833e18); // Exchange rate queried at block 20066000
        assertEq(startedAt, 0);
        assertEq(updatedAt, 0);
        assertEq(answeredInRound, 0);
    }
}
