# BetBlock Smart Contracts

This repo contains all the smart contract for betblock.

AI-generating NFTs on Avalanche Fuji Network using Chainlink Functions.

These are some helpful snippets of code that compiles and deploys.

```shell
npx hardhat compile
npx hardhat setup-nft-contract --network fuji
```

## Deployments

### Polygon Mumbai Network

| Contract               | Address                                           |
| ---------------------- | --------------------------------------------------|
| roulette               | [`0xe99aA391B3C73A31Cc3e493dEC656cb32F3DA932`][1] |
| slots                  | [`0x7c3EC70A5E196e5C3600D225e223162897d17679`][2] |
| pricing                | [`0x03e1B02901579f731D2e5150134d0FB792d44708`][3] |
| lend/borrow            | [`0x3a424f11E1A9C04c8AFE5bf853653EBb94EAF3A3`][4] |

### Avalanche Fuji Network

| Contract               | Address                                            |
| ---------------------- | ---------------------------------------------------|
| pricing                | [``][] |
| mars-account-nft       | [``][] |
| mars-credit-manager    | [``][] |


## Contract Overview 
### Roulette Contract 
#### Uses Chainink VRF and Chainlink Automation

The game logic includes the functionality for players to place bets, initiate roulette spins, and receive payouts. This contract maintains mapping of *rollers*, tracking who triggered each Chainlink VRF request. 

Chainlink VRF is integrated in the *rollDice* function, which requests a random number. The fulfillRandomness function is called automatically with the random result once it's ready.

The payout logic is handled in fulfillRandomness. If the player bet on a specific number and it matches the result, they win their bet times 35. If they bet on a color (even or odd number) and it matches, they win double their bet.

### Slot Machine Contract
#### Uses Chainink VRF and Chainlink Automation

This is a simple slot game where a user bets a certain amount of ether, and if they hit the jackpot (represented by a specific random number), they win a multiplier of their bet. For future improvements, implement different winning combinations, varying rewards, and a house edge.

### Pricing Contract
#### Uses Chainlink Data Feeds 

This is a simple smart contract that gathers real time asset pricing by using Chainlink Price Feeds

### DeFi Cross-Chain Lending 
#### Uses Chainlink CCIP and Data Feeds

By leveraging Chainlink's CCIP for secure asset transfers and reliable price oracles and Data Feeds for real-time reliable asset prices, you can create a robust lending protocol that allows gamers on both Polygon and Avalanche to seamlessly borrow assets. This would enhance the gaming experience by enabling players to access the resources they need without liquidating their positions.

### NFT Minting Contract 
#### Uses Functions and Data Feeds

[1]: https://
[2]: https://
[3]: https://
[4]: https://