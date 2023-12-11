# BetBlock Smart Contracts

This repo contains all the smart contract for betblock.

These are some helpful snippets of code that compiles and deploys.

```shell
npx hardhat compile
npx hardhat setup-nft-contract --network fuji
npx hardhat setup-fuji-lending-contract --network fuji
```
Note: All contracts on Mumbai network were deployed with Remix. 

## Deployments

### Polygon Mumbai Network

| Contract               | Address                                           |
| ---------------------- | --------------------------------------------------|
| roulette               | [`0x77D6119479Ec5aE22081E359c0004ebc8Ec1a040`][1] |
| slots                  | [`0x7c3EC70A5E196e5C3600D225e223162897d17679`][2] |
| lend/borrow            | [`0x0969ab26e7e06FEa347d293821Dcf53DB836865c`][3] |

### Avalanche Fuji Network

| Contract               | Address                                            |
| ---------------------- | ---------------------------------------------------|
| lend/borrow            | [``][] |
| ccip-sender            | [`0x8276C6236De14002C4750eE21C6169D29e78AA60`][] |
| nft-minting            | [``][] |

### Sepolia Network

| Contract               | Address                                            |
| ---------------------- | ---------------------------------------------------|
| ccip-protocol           | [`0x865B3358db605d839E64EeE2eb501986eE777D6b`][] |


## Contract Overview 
### Roulette Contract 
#### Uses Chainink VRF and Chainlink Automation

The game logic includes the functionality for players to place bets, initiate the roulette spin, and receive payouts. This contract maintains mapping of *rollers*, tracking who triggered each Chainlink VRF request. 

Chainlink VRF is integrated in the *rollDice* function, which requests a random number. The fulfillRandomness function is called automatically with the random result once it's ready.

The payout logic is handled in fulfillRandomness. This roulette game is European Roulette and covers all possible bet types (straight, split, street, corner, six line, column, dozen, red, black, high, low, even. odd) and the payout will be calculated based on the respective odds of each win. 

Chainlink Automation is implemented when a user places a bet. The upKeep is triggered after the bet is placed to automatically roll the dice (really spin the roulette wheel) then automatically calculate winnings and withdraw them to your wallet. 

### Slot Machine Contract
#### Uses Chainink VRF and Chainlink Automation

This is a simple slot game where a user bets a certain amount of ether, and if they hit the jackpot (represented by a specific random number), they win a multiplier of their bet. For future improvements, implement different winning combinations, varying rewards, and a house edge.

### DeFi Cross-Chain Lending 
#### Uses Data Feeds

You can either deposit MATIC as collateral and borrow LINK on the Mumbai network or you can deposit AVAX as collateral and borrow LINK tokens on the Fuji network. These lending contracts use chain link data feeds to fetch the latest price for each asset and uses that price to calculate max LTV. In the future we would also need to calculate 

Since the lomg term vision for BetBlock is to enable cross-chain gaming, we want to enable players to be able to come to BetBlock and get any asset they may need for the game of their choice. 

Future improvements would be leveraging Chainlink's CCIP for secure asset transfers to create a robust lending protocol that allows gamers on both Polygon and Avalanche to seamlessly borrow assets cross-chain. This would enhance the gaming experience by enabling players to access the resources they need without selling on of their assets.

### NFT Minting Contract 
#### Uses Functions and Data Feeds

NFTs are AI generated using chainink functions

[1]: https://mumbai.polygonscan.com/address/0x77D6119479Ec5aE22081E359c0004ebc8Ec1a040
[2]: https://
[3]: https://mumbai.polygonscan.com/address/0x0969ab26e7e06FEa347d293821Dcf53DB836865c
[4]:  