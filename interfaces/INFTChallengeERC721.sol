// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./IERC721.sol";

/**
 * refer to OpenZeppelin/openzeppelin-contracts
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}

interface INFTChallengeERC721 is IERC721{
    event Mint(address indexed to, bool indexed succeed);
    event Burn(uint256 indexed tokenId, bool indexed succeed);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);

    function tokenURI(uint256 tokenId) external view returns (string memory);
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}