// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../interfaces/IERC721.sol";
import "../interfaces/INFTChallengeFactory.sol";
import "../interfaces/INFTChallegeCore.sol";
import "../libraries/Address.sol";
import "./ICollectNFT.sol";

/**
 * example using NFTChallege platform.
 */
contract CollectNFT is ICollectNFT {

    using Address for address;

    // struct nft {
    //     address item;
    //     uint256 tokenId;
    // }

    mapping (address => mapping(uint256 => address)) private _StoreTokenId;
    mapping (address => bool) private _allowedApply;
    address[] private _AllSupportItems; //totalitems
    mapping(address => uint256) private _AllSupportItemsIndex;
    // mapping(address => nft[]) private _applyerNFT;
    mapping(address => mapping(address => uint256)) public applyerNftInfo;

    address public override factory;
    address public override core;
    address public override manager;

    constructor(address _factory, address _core, address _manager) {
        factory =_factory;
        core = _core;
        manager = _manager;
    }

    modifier onlyManager {
        require(msg.sender == manager, 'only manager can call it.');
        _;
    }

    function addItem(address item) external override onlyManager returns(bool) {
        _AllSupportItemsIndex[item] = _AllSupportItems.length;
        _AllSupportItems.push(item);
        return true;
    }

    function removeItem(address item) external override onlyManager returns(bool) {
        uint256 lastItemIndex = _AllSupportItems.length - 1;
        uint256 itemIndex = _AllSupportItemsIndex[item];

        address lastItem = _AllSupportItems[lastItemIndex];

        _AllSupportItems[itemIndex] = lastItem; 
        _AllSupportItemsIndex[lastItem] = itemIndex; 

        delete _AllSupportItemsIndex[item];
        _AllSupportItems.pop();
        return true;
    }

    function indexByItem(address item) public view override returns (uint256) {
        return _AllSupportItemsIndex[item];
    }

    function totalItems() public view override returns (uint256) {
        return _AllSupportItems.length;
    }

    function itemByIndex(uint256 index) public view override returns (address) {
        require(index < totalItems(), "global index out of bounds");
        return _AllSupportItems[index];
    }

    function GetItemOwner() public override view returns(address Owner){
        Owner = INFTChallengeFactory(factory).owners(core);
        return Owner;
    }

    function StorageUesdNFT(address applyer) public override returns(bool) {
        for(uint i =0; i < _AllSupportItems.length; ++i) {
            address item = _AllSupportItems[i];
            uint256 tokenId = applyerNftInfo[msg.sender][item];
            _StoreTokenId[item][tokenId] = applyer;
        }
        return true;        
    }

    function IsNotUsed(address item, uint256 tokenId) public override returns(bool){  
        require(_exist(item, msg.sender, tokenId)); 

        emit Query(item, msg.sender, tokenId);

        return true;
    }

    /*
    function applyerNFT(address item, uint256 tokenId) public override {
        _applyerNFT[msg.sender].push(
            nft({
                item: item,
                tokenId: tokenId
            })
        );
    }*/

    function selectNFT(address item, uint256 tokenId) public override {
        applyerNftInfo[msg.sender][item] = tokenId;
    }

    function Verify(address applyer) private view returns(bool) {
        for(uint i =0; i < _AllSupportItems.length; ++i) {
            address item = _AllSupportItems[i];
            uint256 tokenId = applyerNftInfo[msg.sender][item];
            require(_exist(item, applyer, tokenId));
        }
        return true;
    }

    /// 
    function ApplyNFT(INFTChallegeCore item, uint256 tokenId) public override returns(bool) {
        require(item.balanceOf(msg.sender) == 0, 'You have applied one NFT once.');
        require(Verify(msg.sender), "Please achieve the apply qualifications firstly.");
        item.mint(msg.sender, tokenId);
        require(StorageUesdNFT(msg.sender), 'Storage failed.'); 

        emit Apply(address(item), msg.sender, tokenId);

        return true;
    }

    function _exist(address item, address applyer, uint256 tokenId) private view returns(bool){
        require(item.isContract() == true, 'contract address does not exist!');
        uint256 num = IERC721(item).balanceOf(applyer);
        require(num > 0, 'You do not have enough NFT.');
        require(_StoreTokenId[item][tokenId] == address(0),' tokenId used!');
        return true;
    }

}