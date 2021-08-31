// SPDX-License-Identifier: MIT
 
pragma solidity ^0.8.0;

import "../interfaces/INFTChallengeCore.sol";
import "../interfaces/IERC721.sol";
import "../libraries/Address.sol";
import "./NFTCollectorERC721.sol";
 
contract NFTChallengeCore is INFTChallengeCore{​​​​
    using Address for address;  
    mapping(address => mapping(uint256 => address)) private _StoreTokenId;
    
    function NFTExist(
        address contract_address, 
        address user, 
        uint256 tokenId
    ) external override returns(bool){​​​​

        require(contract_address.isContract() == true, 'contract address does not exist!');
        require(IERC721(contract_address).ownerOf(tokenId) == user, 'Invalid user');
        require(_StoreTokenId[contract_address][tokenId] == address(0),' tokenId used!');
        _StoreTokenId[contract_address][tokenId] = user;
        return true;
    }​​​​
}