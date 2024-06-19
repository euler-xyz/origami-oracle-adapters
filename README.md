# Origami Oracle Adapters

Origami Oracle Adapters are Chainlink-interface-complianat feeds to provide price data. These can be used within Origami Finance, [Morpho Blue Oracles](https://github.com/morpho-org/morpho-blue-oracles).

## Getting Started

Install dependencies

```bash
git submodule update --init --recursive
```

Set `MAINNET_RPC_URL` to the URL of an Ethereum RPC (with archive), eg Alchemy.

Run test: `forge test`

## Audits

All audits are stored in the [audits](./audits/)' folder.

## License

Morpho Blue Oracles are licensed under `GPL-2.0-or-later`, see [`LICENSE`](./LICENSE).
