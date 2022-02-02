//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";


contract NameCard is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractAddress;

    constructor(address _orgAddress) ERC721("HoneyCombWeb3", "HCW3") {
        contractAddress = _orgAddress;
        // create(_metaURI);
    }

    function create(string memory metaURI) public returns(uint) {
        _tokenIds.increment();
        uint256 newItem = _tokenIds.current();

        _mint(msg.sender, newItem);
        _setTokenURI(newItem, metaURI);
        setApprovalForAll(contractAddress, true);

        return newItem;
    }

    function burn(uint256 tokenId) public {
        _burn(tokenId);
    }
}
