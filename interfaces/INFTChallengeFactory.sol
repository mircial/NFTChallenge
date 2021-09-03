// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface INFTChallengeFactory{
    //// 
    event ItemCreated(uint256 indexed itemId, address item, uint);

    function Creator() external view returns (address);

    function getItem(uint256) external view returns (address item);
    function allItems(uint) external view returns (address item);
    function allItemsLength() external view returns (uint);

    function createItem(uint256 itemId) external returns (address item);

}