var NFTChallengeFactory = artifacts.require("NFTChallengeFactory");

module.exports = async function(deployer) {
    await deployer.deploy(NFTChallengeFactory);
};
