// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/INFTChallengeFactory.sol";
import "./NFTChallegeCore.sol";

/**
 * 
 */
contract NFTChallengeFactory is INFTChallengeFactory {

    address public override Creator;

    mapping(uint256 => address) public override getItem;
    address[] public override allItems;
    mapping(address => address) public override managers;

    constructor() {
        Creator = msg.sender;
    }

    modifier onlyCreator {
        require(msg.sender == Creator, 'You have no access to create a applicaiton.');
        _;
    }

    function allItemsLength() external view override returns (uint) {
        return allItems.length;
    }

    function createItem(address manager, uint256 itemId) external override onlyCreator returns (address item) {
        require(getItem[itemId] == address(0), "This itemId is used, Please change another one.");

        //// create a contract ref to uniswap
        /** 
        bytes32 salt = keccak256(abi.encodePacked(itemId));
        bytes memory bytecode = type(NFTChallegeCore).creationCode;
        assembly {
            item := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        */

        /// new method
        bytes32 salt = keccak256(abi.encodePacked(itemId));
        item = address( new NFTChallegeCore{salt: salt}(manager) );

        managers[item] = manager;
        getItem[itemId] = item;
        allItems.push(item);
        emit ItemCreated(itemId, item, allItems.length);
    }
    
}