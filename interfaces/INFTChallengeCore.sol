// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 *  NFTChallenge core code interface
 */
interface INFTChallengeCore {
    
    function NFTExist(
        address contract_address, 
        address user,
        uint256 tokenId
        ) external returns(bool);

    

}