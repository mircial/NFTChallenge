var NFTChallengeFactory = artifacts.require("NFTChallengeFactory");
var CollectNFT = artifacts.require("CollectNFT");

var itemOwner = "0x0a44987179fbcE8D3847d7EA5a31B4f05a39328A";
var itemManager = "0x0a44987179fbcE8D3847d7EA5a31B4f05a39328A";
var itemId = 0;


module.exports = async function(deployer) {
    await deployer.deploy(NFTChallengeFactory);
    const instance = await NFTChallengeFactory.deployed();
    await instance.createItem(itemOwner, itemId);
    await deployer.deploy(CollectNFT, instance.address, instance.getItem(itemId), itemManager);
};
