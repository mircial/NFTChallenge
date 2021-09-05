// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/INFTChallegeCore.sol";
import "./NFTChallengeERC721.sol";
import "../interfaces/IERC721.sol";

/**
 * add extension
 */
contract NFTChallegeCore is NFTChallengeERC721, INFTChallegeCore{

    address public override owner;
    mapping(address => bool) public approve_mint;

    constructor(address _owner) {
        owner = _owner;
    }

    modifier onlyOwner {
        require(msg.sender == owner, 'only can owner can call this.');
        _;
    }

    modifier OwnerOrApproved {
        require(msg.sender == owner || isApprovedForMint(msg.sender), 
        'You have no access to mint. Please get the approve first!');
        _;
    }

    function ApproveForMint(address item) public override onlyOwner {
        approve_mint[item] = true;
    }

    function isApprovedForMint(address item) public override view returns(bool) {
        return approve_mint[item];
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(NFTChallengeERC721, INFTChallengeERC721) returns (bool) {
        return
            interfaceId == type(INFTChallegeCore).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function mint(address to, uint256 tokenId) public virtual override OwnerOrApproved returns(bool) {
       // @dev
        _mint(to, tokenId);
        return true;
    }

    function safeMint(address to, uint256 tokenId) public virtual override OwnerOrApproved {
        this.safeMint(to, tokenId, "");
    }

    function safeMint(address to, uint256 tokenId, bytes calldata data) public virtual override OwnerOrApproved returns(bool) {
        _safeMint(to, tokenId, data);
        return true;
    }

    function burn(uint256 tokenId) public virtual override {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721Burnable: caller is not owner nor approved");
        _burn(tokenId);
    }

}