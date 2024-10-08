// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { IRenzoRestakeManager } from "src/interfaces/renzo/IRenzoRestakeManager.sol";
import { IRenzoOracle } from "src/interfaces/renzo/IRenzoOracle.sol";
import { IERC20 } from "src/interfaces/IERC20.sol";
import { IMinimalAggregatorV3Interface } from "src/interfaces/IMinimalAggregatorV3Interface.sol";

/// @title EzEthToEthExchangeRateAdapter
/// @author Origami Finance
/// @custom:contact team@origami.finance
/// @notice ezETH/ETH exchange rate price feed.
/// @dev This contract should only be deployed on Ethereum.
contract EzEthToEthExchangeRateAdapter is IMinimalAggregatorV3Interface {
    /// @inheritdoc IMinimalAggregatorV3Interface
    // @dev The calculated price has 18 decimals precision, whatever the value of `decimals`.
    uint8 public constant override decimals = 18;

    /// @notice The description of the price feed.
    string public constant description = "ezETH/ETH exchange rate";

    /// @notice The address of the Renzo restake manager in Ethereum.
    IRenzoRestakeManager public constant RENZO_RESTAKE_MANAGER =
        IRenzoRestakeManager(0x74a09653A083691711cF8215a6ab074BB4e99ef5);

    /// @notice The address of the Renzo ezETH token in Ethereum
    IERC20 public constant EZ_ETH = IERC20(0xbf5495Efe5DB9ce00f80364C8B423567e58d2110);

    /// @inheritdoc IMinimalAggregatorV3Interface
    /// @dev Returns zero for roundId, startedAt, updatedAt and answeredInRound.
    /// @dev Silently overflows if `calculateRedeemAmount`'s return value is greater than `type(int256).max`.
    function latestRoundData() external view override returns (uint80, int256, uint256, uint256, uint80) {
        (,, uint256 _currentValueInProtocol) = RENZO_RESTAKE_MANAGER.calculateTVLs();

        // This returns the percentage of TVL that matches the percentage of ezETH being burned
        // baseAsset is safely assumed to be the ezETH ERC20
        uint256 rate = IRenzoOracle(RENZO_RESTAKE_MANAGER.renzoOracle()).calculateRedeemAmount(
            1 ether, EZ_ETH.totalSupply(), _currentValueInProtocol
        );

        return (0, int256(rate), 0, block.timestamp, 0);
    }
}
