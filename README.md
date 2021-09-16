# NFTChallenge Introduction

NFTChallenge(NFTC) is an interactive platform where any NFT Project (referred to as third NFTP in the following context) can depoly its contract. On NFTC, any user can join to have fun with any NFTP and eligible users can easily mint.

On NFTC, all NFTPs are integrated with their own NFTs and can be shared with each other. NFTP can also build projects with the help of other existing NFTP. The user's NFTs in each item are not isolated. NFTC encourages user to use the NFTs of other NFTPs to complete the tasks required under a current project.

NFTC makes NFTs truly have circulation value. Besides, it will play a vital role in the metaverse.

## Installing Prerequisites

Node.js 12+ and Yarn are required to use this repo. 
Please refer to the [Yarn installation how-to](https://classic.yarnpkg.com/en/docs/install) if you don't yet have the `yarn` command installed locally.

To install the prerequisite packages,  clone the repository and then run `yarn`:

### Install Truffle

```bash
npm install -g truffle 
```

### Install dependencies

```bash
git clone https://github.com/mircial/NFTChallenge.git

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

```bash
aurora: {

  provider: () => setupWallet('https://testnet.aurora.dev'),

  network_id: 0x4e454153,

  gas: 10000000,

  from: '0x256807C23d5085ad22CC124c00852eE60989fC3E' // CHANGE THIS ADDRESS

},
```

 The  `truffle-config.js` configuration will read your `MNEMONIC` environment variable and recover the address that will be used for sending or signing transactions on the Aurora network.

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

## Interface

A mature front-end (webpack, grunt, etc.) was not used so as to get from scratch as easy as possible. 

Open ternminal and Run `liteserver` development server (outside the development console) for front-end hot reloading. Smart contract changes must be manually recompiled and migrated. Open http://localhost:3000 for the web contents.

```bash
yarn dev
```

**note**: By far, we just finished a simple work to show how NFTC runs. For more details, go to [examples](https://github.com/mircial/CollectNFT).

## Summary

Above all, NFTC is an awesome platform for both developers and players. Anyone can depoly their contracts and anyone can have fun with it. For more details, please kindly refer to our slides.

To Make Metaverse More Wonderful. To Make NFT More Valuable!