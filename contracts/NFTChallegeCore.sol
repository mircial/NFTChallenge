// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/INFTChallegeCore.sol";
import "./NFTChallengeERC721.sol";
import "../interfaces/IERC721.sol";

/**
 * add extension
 */
contract NFTChallegeCore is NFTChallengeERC721, INFTChallegeCore{
    using Address for address;

    mapping(address => mapping(uint256 => address)) private _StoreTokenId;

    function supportsInterface(bytes4 interfaceId) public view override(NFTChallengeERC721, INFTChallengeERC721) returns (bool) {
        return
            interfaceId == type(INFTChallegeCore).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function mint(address to, uint256 tokenId) external override  {
       // @dev
        require(_exists(tokenId), 'tokenId minted!');
        _mint(to, tokenId);

        emit Mint(to, tokenId);

    }

    function burn(uint256 tokenId) external override {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721Burnable: caller is not owner nor approved");
        _burn(tokenId);

        emit Burn(tokenId);
    }
    
    function NFTExist(
        address contract_address, 
        address user, 
        uint256 tokenId
    ) external override returns(bool){

        require(contract_address.isContract() == true, 'contract address does not exist!');
        require(IERC721(contract_address).ownerOf(tokenId) == user, 'Invalid user');
        require(_StoreTokenId[contract_address][tokenId] == address(0),' tokenId used!');
        _StoreTokenId[contract_address][tokenId] = user;
        return true;
    }

    function UserQuery(uint256 tokenId) public override returns(bool){  
        require(_exists(tokenId),'tokenId used'); 
        emit Query(tokenId);
        return true;
    }

    function UserApply(address contract_address, address user, uint256 tokenId) public override{
        require(UserQuery(tokenId),'token has been taken away');
        emit Apply(tokenId);
        transferFrom(contract_address, user, tokenId);
    }
}