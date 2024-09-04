// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { ISwETH } from "src/interfaces/swell/ISwETH.sol";
import { IMinimalAggregatorV3Interface } from "src/interfaces/IMinimalAggregatorV3Interface.sol";

/// @title SwEthToEthExchangeRateAdapter
/// @author Origami Finance
/// @custom:contact team@origami.finance
/// @notice swETH/ETH exchange rate price feed.
/// @dev This contract should only be deployed on Ethereum.
contract SwEthToEthExchangeRateAdapter is IMinimalAggregatorV3Interface {
    /// @inheritdoc IMinimalAggregatorV3Interface
    // @dev The calculated price has 18 decimals precision, whatever the value of `decimals`.
    uint8 public constant override decimals = 18;

    /// @notice The description of the price feed.
    string public constant description = "swETH/ETH exchange rate";

    /// @notice The address of the Swell Network swETH contract in Ethereum.
    ISwETH public constant SWETH = ISwETH(0xf951E335afb289353dc249e82926178EaC7DEd78);

    /// @inheritdoc IMinimalAggregatorV3Interface
    /// @dev Returns zero for roundId, startedAt, updatedAt and answeredInRound.
    /// @dev Silently overflows if `swETHToETHRate`'s return value is greater than `type(int256).max`.
    function latestRoundData() external view override returns (uint80, int256, uint256, uint256, uint80) {
        return (0, int256(SWETH.swETHToETHRate()), 0, block.timestamp, 0);
    }
}
