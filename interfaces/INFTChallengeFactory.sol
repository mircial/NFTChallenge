// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC721.sol";

interface INFTChallengeFactory is IERC721{
    //// events
    event Mint(address indexed to, uint256 indexed tokenId);
    event Burn(uint256 indexed tokenId);

    //// metadata extension
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 tokenId) external view returns (string memory);

    //// enumeration extension
    function totalSupply() external view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);
    function tokenByIndex(uint256 index) external view returns (uint256);

    //// 
    function mint(address to, uint256 tokenId) external;
    function burn(uint256 tokenId) external;
}