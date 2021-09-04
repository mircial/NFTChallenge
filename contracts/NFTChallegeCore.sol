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
    address public override manager;

    constructor(address _minter) {
        manager = _minter;
    }

    modifier onlyManager {
        require(msg.sender == manager, 'only can manager can call this.');
        _;
    }

    function supportsInterface(bytes4 interfaceId) public view override(NFTChallengeERC721, INFTChallengeERC721) returns (bool) {
        return
            interfaceId == type(INFTChallegeCore).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function mint(address to, uint256 tokenId) external override onlyManager returns(bool) {
       // @dev
        _mint(to, tokenId);
        return true;
    }

    function safeMint(address to, uint256 tokenId) external override onlyManager {
        this.safeMint(to, tokenId, "");
    }

    function safeMint(address to, uint256 tokenId, bytes calldata data) external override onlyManager returns(bool) {
        _safeMint(to, tokenId, data);
        return true;
    }

    function burn(uint256 tokenId) external override {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721Burnable: caller is not owner nor approved");
        _burn(tokenId);
    }
    
    function _exist(address item, address user, uint256 tokenId
    ) private returns(bool){

        require(item.isContract() == true, 'contract address does not exist!');
        require(IERC721(item).ownerOf(tokenId) == user, 'Invalid user');
        require(_StoreTokenId[item][tokenId] == address(0),' tokenId used!');
        _StoreTokenId[item][tokenId] = user;
        return true;
    }

    function UserQuery(address item, uint256 tokenId) public override returns(bool){  
        require(_exist(item, msg.sender, tokenId),'tokenId used'); 

        emit Query(address(this), msg.sender, tokenId);

        return true;
    }

    function UserApply(address item, address user, uint256 tokenId) public override returns(bool) {
        require(UserQuery(item, tokenId),'token has been taken away');
        transferFrom(item, user, tokenId);

        emit Apply(item, msg.sender, tokenId);

        return true;
    }
}