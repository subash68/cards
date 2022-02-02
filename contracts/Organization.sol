//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// should maintain all employee contract
contract Organization {

    using Counters for Counters.Counter;
    Counters.Counter private _resourceIds;

    address owner;

    constructor() {
        // creator of this contract is the owner
        owner = msg.sender;
    }
    
    struct ResourceCard {
        uint resourceId;
        address resourceContract; // address of NFT contract
        uint256 tokenId;
    }

    // add mapping for name card contracts
    mapping(uint256 => ResourceCard) private idToCard;

    event NewResourceCreated (
        uint indexed resouceId,
        address indexed resourceContract,
        uint256 indexed tokenId
    );

    event deleteResource(
        address indexed resourceContract,
        uint256 indexed tokenId
    );

    function addResource(
        address resourceContract,
        uint256 tokenId
    ) public {
        // perform checks for admin -- ?

        _resourceIds.increment();
        uint256 resourceId = _resourceIds.current();

        idToCard[resourceId] = ResourceCard(
            resourceId,
            resourceContract,
            tokenId
        );

        IERC721(resourceContract).transferFrom(msg.sender, address(this), tokenId);

        emit NewResourceCreated(
            resourceId, 
            resourceContract, 
            tokenId
        );
   }


   function fetchAllResources() public view returns(ResourceCard[] memory) {
       uint resourceCount = _resourceIds.current();

       uint currentIndex = 0;

       ResourceCard[] memory cards = new ResourceCard[](resourceCount);

       for(uint i = 0; i < resourceCount; i++) {
           uint currentId = idToCard[i + 1].resourceId;
           ResourceCard storage currentResource = idToCard[currentId];
           cards[currentIndex] = currentResource;
           currentIndex += 1;
       }

       return cards;
   }

   function remove(uint256 resourceContract) public returns(bool) {
    //    remove from mapping 
    //  and burn the token


   }
}