# Origami Oracle Adapters

Origami Oracle Adapters are Chainlink-interface-complianat feeds to provide price data. These can be used within Origami Finance, [Morpho Blue Oracles](https://github.com/morpho-org/morpho-blue-oracles).

## Getting Started

Install dependencies

```bash
git submodule update --init --recursive
```

Set `MAINNET_RPC_URL` to the URL of an Ethereum RPC (with archive), eg Alchemy.

Run test: `forge test`

## Deployments

|  Oracle |  Chain  | Address |
|:-------:|:-------:|:-------:|
| Ether.fi weETH/ETH | Mainnet | [0x4270E1817576bbA4b640466bE79A408Ef128F828](https://etherscan.io/address/0x4270e1817576bba4b640466be79a408ef128f828) |
| Renzo ezETH/ETH | Mainnet | [0xb2Ca3C47b1BeA4AD7Cfd187A522be0F1bfc8652B](https://etherscan.io/address/0xb2ca3c47b1bea4ad7cfd187a522be0f1bfc8652b) |
| KelpDAO rsETH/ETH | Mainnet | [0xBAc9fC6917c067F763eDa63f569e0C6A7dBbCD80](https://etherscan.io/address/0xbac9fc6917c067f763eda63f569e0c6a7dbbcd80) |
| Swell swETH/ETH | Mainnet | [0x88154F69959E6c2D1a453Ab60cec15A8965D06e3](https://etherscan.io/address/0x88154f69959e6c2d1a453ab60cec15a8965d06e3) |
| Swell rswETH/ETH | Mainnet | [0xb2b18E668CE6326760e3B063f72684fdF2a2D582](https://etherscan.io/address/0xb2b18e668ce6326760e3b063f72684fdf2a2d582) |

## Audits

All audits are stored in the [audits](./audits/)' folder.

## License

Morpho Blue Oracles are licensed under `GPL-2.0-or-later`, see [`LICENSE`](./LICENSE).
