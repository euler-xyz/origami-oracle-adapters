// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { IWeEth } from "src/interfaces/etherfi/IWeEth.sol";
import { IMinimalAggregatorV3Interface } from "src/interfaces/IMinimalAggregatorV3Interface.sol";

/// @title WeEthToEthExchangeRateAdapter
/// @author Origami Finance
/// @custom:contact team@origami.finance
/// @notice weETH/ETH exchange rate price feed.
/// @dev This contract should only be deployed on Ethereum.
contract WeEthToEthExchangeRateAdapter is IMinimalAggregatorV3Interface {
    /// @inheritdoc IMinimalAggregatorV3Interface
    // @dev The calculated price has 18 decimals precision, whatever the value of `decimals`.
    uint8 public constant override decimals = 18;

    /// @notice The description of the price feed.
    string public constant description = "weETH/ETH exchange rate";

    /// @notice The address of the weETH token on Ethereum.
    IWeEth public constant WEETH = IWeEth(0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee);

    /// @inheritdoc IMinimalAggregatorV3Interface
    /// @dev Returns zero for roundId, startedAt, updatedAt and answeredInRound.
    /// @dev Silently overflows if `getRate()`'s return value is greater than `type(int256).max`.
    function latestRoundData() external view override returns (uint80, int256, uint256, uint256, uint80) {
        return (0, int256(WEETH.getRate()), 0, block.timestamp, 0);
    }
}
