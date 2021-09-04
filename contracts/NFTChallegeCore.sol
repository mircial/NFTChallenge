// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/INFTChallegeCore.sol";
import "./NFTChallengeERC721.sol";
import "../interfaces/IERC721.sol";

/**
 * add extension
 */
contract NFTChallegeCore is NFTChallengeERC721, INFTChallegeCore{

    address public override manager;

    constructor(address _minter) {
        manager = _minter;
    }

    modifier onlyManager {
        require(msg.sender == manager, 'only can manager can call this.');
        _;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(NFTChallengeERC721, INFTChallengeERC721) returns (bool) {
        return
            interfaceId == type(INFTChallegeCore).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function mint(address to, uint256 tokenId) public virtual override onlyManager returns(bool) {
       // @dev
        _mint(to, tokenId);
        return true;
    }

    function safeMint(address to, uint256 tokenId) public virtual override onlyManager {
        this.safeMint(to, tokenId, "");
    }

    function safeMint(address to, uint256 tokenId, bytes calldata data) public virtual override onlyManager returns(bool) {
        _safeMint(to, tokenId, data);
        return true;
    }

    function burn(uint256 tokenId) public virtual override {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721Burnable: caller is not owner nor approved");
        _burn(tokenId);
    }

}