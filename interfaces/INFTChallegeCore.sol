// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./INFTChallengeERC721.sol";

interface INFTChallegeCore is INFTChallengeERC721 {
    //// events
    event Query(address indexed item, address indexed Inquirer, uint256 tokenId);
    event Apply(address indexed item, address indexed applyer, uint256 tokenId);

    //// 
    function manager() external view returns(address);

    function mint(address to, uint256 tokenId) external returns(bool);
    function safeMint(address to, uint256 tokenId) external;
    function safeMint(address to, uint256 tokenId, bytes calldata data) external returns(bool);
    function burn(uint256 tokenId) external;

    //// application functions
    function UserQuery(address contract_address, uint256 tokenId) external returns(bool);
    function UserApply(address contract_address, address user, uint256 tokenId) external returns(bool);
    

}