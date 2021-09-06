// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/INFTChallegeCore.sol";

interface ICollectNFT{
    //// events
    event Query(address indexed item, address indexed Inquirer, uint256 tokenId);
    event Apply(address indexed item, address indexed applyer, uint256 tokenId);

    // struct nft{address item; uint256 tokenId;}

    //// application functions
    function factory() external view returns(address);
    function core() external view returns(address);
    function manager() external view returns(address);
    function GetItemOwner() external view returns(address);
    
    function addItem(address) external returns(bool);
    function removeItem(address) external returns(bool);
    function totalItems() external view returns (uint256);
    function indexByItem(address item) external view returns (uint256);
    function itemByIndex(uint256 index) external view returns (address);

    function StorageUesdNFT(address) external returns(bool);
    function selectNFT(address item, uint256 tokenId) external;
    function IsNotUsed(address item, uint256 tokenId) external returns(bool);
    function ApplyNFT(INFTChallegeCore item, uint256 tokenId) external returns(bool);
}