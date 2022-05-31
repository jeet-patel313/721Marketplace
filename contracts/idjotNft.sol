// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Nft is ERC721, Ownable {

    constructor() ERC721("NFTnft", "NFT") {
    }

    function safeMint(uint256 tokenId) public onlyOwner {
        _safeMint(owner(), tokenId);
    }
}