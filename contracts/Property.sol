//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Property is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenidCounter;
    uint256 public fees;

    constructor(
        string memory name_,
        strin memory symbol_,
        uint256 fees_
    )ERC721(name_, symbol_){
        fees = fees_;
    }

    function safeMint(address to, string memory uri) public payable{
        require(msg.value >= fees,'Not enough MATTIC');
        payable(owner()).transfer(fees);

        uint256 tokenId  = _tokenidCounter.current();
        _tokenidCounter.increment(); 
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        // return oversupplied fees
        uint256 constractBalance = address(this).balance;
        if(constractBalance > 0) {
            payable(msg.sender).transfer(address(this).balance);
        }
    }
       
}