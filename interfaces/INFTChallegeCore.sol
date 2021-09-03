// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./INFTChallengeERC721.sol";

interface INFTChallegeCore is INFTChallengeERC721 {
    //// events
    event Mint(address indexed to, uint256 indexed tokenId);
    event Burn(uint256 indexed tokenId);

    //// 
    function mint(address to, uint256 tokenId) external;
    function burn(uint256 tokenId) external;

    //// application functions
    function NFTExist(
        address contract_address, 
        address user,
        uint256 tokenId
        ) external returns(bool);

}