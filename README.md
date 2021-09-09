# NFTChallenge Introduction

NFTChallenge(NC) is a widely interconnected platform where any project party can depoly their contracts and any user can join to play whatever project they want. The project party can easily mint NFTs to eligible users.

On this platform, all projects are integrated with their own NFTs and those NFTs can be shared with each other. The project party can build a new project with the help of other existing projects. The user's NFTs in each item are not isolated. NC encourages users to use the NFTs of other items to complete the tasks required under a current project.

NC makes NFTs truly have circulation value. Besides, it will play a vital role in the metaverse.

## Installing Prerequisites

This repo assumes that you have Node.js 12+ and Yarn. Please refer to the [Yarn installation how-to](https://classic.yarnpkg.com/en/docs/install) if you don't yet have the `yarn` command installed locally.

To install the prerequisite packages,  clone the  repository and then run `yarn`:

### Install Truffle

```bash
npm install -g truffle 
```

### Install dependencies

```bash
git clone https://github.com/MetaBUILD/NFTChallenge.git

cd NFTChallenge

yarn
```

## Connecting Truffle to Aurora

Export your `MNEMONIC` as follows:

```bash
export MNEMONIC='YOUR MNEMONIC HERE'
```

Now in `truffle-config.js`, you will need to change the `from` address as shown

below in the `aurora` network section:

```json
aurora: {

  provider: () => setupWallet('https://testnet.aurora.dev'),

  network_id: 0x4e454153,

  gas: 10000000,

  from: '0x256807C23d5085ad22CC124c00852eE60989fC3E' // CHANGE THIS ADDRESS

},
```

 The  `truffle-config.js` configuration will pick up your `MNEMONIC` environment variable and recover the address that will be used for sending and signing transactions on the Aurora network.

## Deploying Contracts

To deploy the `NFTChallenge` contract,  you can run the `yarn` command as follows:

```bash
yarn deploy:aurora

....
1_initial_migration.js
=====================

   Deploying 'Migrations'
   -----------------------------

   > transaction hash:    0x282012c791d65d0ce2fd1fd9fcc41179dba5bd06c3b02e31e53dbe9cc8af62c1

   > Blocks: 7            Seconds: 

   > contract address:    0x3635D999d8CdA2fAf304b390fb26a9c2f364dFbd

   > block number:        59151611

   > block timestamp:     1622034185

   > account:             0x256807C23d5085ad22CC124c00852eE60989fC3E

   > balance:             0

   > gas used:            2576274 (0x274f92)

   > gas price:           20 gwei

   > value sent:          0 ETH

    
    
2_deploy_contracts.js
=====================

   Deploying 'NFTChallengeFactory'
   -----------------------------
   ...
....
```

## Example

CollectNFT contract is a simple example to be deployed at our platform. This project becomes one item to our platform and does not need to program ERC721 code. It just focus on how to design wonderful actions. Our platform help create NFT core code for each one item who is deployed at this platform.

This example describes that if a user collected all the NFTs, he will get a medal of honor. It sounds like the collect card game we played when we were young.

**note**: Before we interact with this contract, we need some pre-steps. See code to learn how to complete them firstly.

1. NFTChallegeCore needs to approve this example to mint NFTs.
2. CollectNFT needs to add some Items what it wants user to collect.

## Interface for CollectNFT example

The front-end doesn't use a build system (webpack, grunt, etc.) to be as easy as possible to get started. 

Open another ternminal and Run the `liteserver` development server (outside the development console) for front-end hot reloading. Smart contract changes must be manually recompiled and migrated. It serves the front-end on http://localhost:3000

```bash
yarn dev
```

**note**: By far, we just finished a simply version to show how the CollectNFT example run. For tokenId, we default use the first if the use has more than one.

## Summary

Above all, NC is an awesome platform for both developers and customs. Anyone can depoly their contracts and everyone can play it.  For more details, you can see our slices.

Make Metaverse more wonderful, make NFT more valuable!