// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../interfaces/IERC721.sol";
import "../interfaces/INFTChallegeCore.sol";
import "../libraries/Address.sol";
import "./ICollectNFT.sol";

/**
 * example using NFTChallege platform.
 */
contract CollectNFT is ICollectNFT{

    using Address for address;

    mapping (address => mapping(uint256 => address)) private _StoreTokenId;
    mapping (address => bool) private _allowedApply;

    function allowedApply(address user) public override view returns(bool) {
        return _allowedApply[user];
    }
        
    function _exist(address item, address user, uint256 tokenId) private returns(bool){
        require(item.isContract() == true, 'contract address does not exist!');
        require(IERC721(item).ownerOf(tokenId) == user, 'Invalid user');
        require(_StoreTokenId[item][tokenId] == address(0),' tokenId used!');
        _StoreTokenId[item][tokenId] = user;
        return true;
    }

    function IsNotUsed(address item, uint256 tokenId) public override returns(bool){  
        require(_exist(item, msg.sender, tokenId)); 

        emit Query(item, msg.sender, tokenId);

        return true;
    }

    function ApplyNFT(INFTChallegeCore item, uint256 tokenId) public override returns(bool) {
        require(_allowedApply[msg.sender], "Please achieve the qualifications firstly.");
        item.mint(msg.sender, tokenId);

        emit Apply(address(item), msg.sender, tokenId);

        return true;
    }
    
}