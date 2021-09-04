// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/INFTChallegeCore.sol";

interface ICollectNFT{
    //// events
    event Query(address indexed item, address indexed Inquirer, uint256 tokenId);
    event Apply(address indexed item, address indexed applyer, uint256 tokenId);

    //// application functions
    function owner() external view returns(address);
    function allowedApply(address) external view returns(bool);

    function UserQuery(address item, uint256 tokenId) external returns(bool);
    function UserApply(address item, uint256 tokenId) external returns(bool);
}