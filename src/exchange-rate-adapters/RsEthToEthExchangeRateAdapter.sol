// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import { IKelpLRTConfig } from "src/interfaces/kelp/IKelpLRTConfig.sol";
import { IKelpLRTOracle } from "src/interfaces/kelp/IKelpLRTOracle.sol";
import { IMinimalAggregatorV3Interface } from "src/interfaces/IMinimalAggregatorV3Interface.sol";

/// @title RsEthToEthExchangeRateAdapter
/// @author Origami Finance
/// @custom:contact team@origami.finance
/// @notice rsETH/ETH exchange rate price feed.
/// @dev This contract should only be deployed on Ethereum.
contract RsEthToEthExchangeRateAdapter is IMinimalAggregatorV3Interface {
    /// @inheritdoc IMinimalAggregatorV3Interface
    // @dev The calculated price has 18 decimals precision, whatever the value of `decimals`.
    uint8 public constant override decimals = 18;

    /// @notice The description of the price feed.
    string public constant description = "rsETH/ETH exchange rate";

    /// @notice The address of the Kelp LRT Config contract in Ethereum.
    IKelpLRTConfig public constant KELP_LRT_CONFIG = IKelpLRTConfig(0x947Cb49334e6571ccBFEF1f1f1178d8469D65ec7);

    bytes32 public constant LRT_ORACLE = keccak256("LRT_ORACLE");

    /// @inheritdoc IMinimalAggregatorV3Interface
    /// @dev Returns zero for roundId, startedAt, updatedAt and answeredInRound.
    /// @dev Silently overflows if `rsETHPrice`'s return value is greater than `type(int256).max`.
    function latestRoundData() external view override returns (uint80, int256, uint256, uint256, uint80) {
        IKelpLRTOracle lrtOracle = IKelpLRTOracle(KELP_LRT_CONFIG.getContract(LRT_ORACLE));
        uint256 rate = lrtOracle.rsETHPrice();
        return (0, int256(rate), 0, 0, 0);
    }
}
