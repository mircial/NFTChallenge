// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./INFTChallengeERC721.sol";

interface INFTChallegeCore is INFTChallengeERC721 {

    //// 
    function owner() external view returns(address);
    function ApproveForMint(address) external;
    function isApprovedForMint(address) external view returns(bool);

    function mint(address to, uint256 tokenId) external returns(bool);
    function safeMint(address to, uint256 tokenId) external;
    function safeMint(address to, uint256 tokenId, bytes calldata data) external returns(bool);
    function burn(uint256 tokenId) external;

}