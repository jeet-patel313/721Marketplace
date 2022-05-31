// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

import "./idjotToken.sol";
import "./idjotNft.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Marketplace is Nft {

    struct Nft {
        bool isAvailable;
        uint tokenAmt;  
        // address payable tokenOwner;
        address payable currentOwner;
        // bool isResale;
    }

    mapping(uint => Nft) public nftId;

    function listNft(uint _tokenId, uint _Amt) public {
        // check if nft is already listed for sale
        require(nftId[_tokenId].isAvailable == false, "Nft already listed for sale");
        
        // check the caller is the owner of the NFT
        require(msg.sender == super.ownerOf(_tokenId), "You are not the owner of the NFT");
        nftId[_tokenId] = Nft(
            true,
            _Amt,
            // payable(owner()),
            payable(msg.sender)
            // false
        );
    }

    function buyNft(uint _tokenId) public {
        // check if nft is available to buy
        require(nftId[_tokenId].isAvailable == true, "Nft not listed for sale");

        // put a condition if the sale is a resale or not

        // update the ownership
        console.log(nftId[_tokenId].currentOwner);
        _transfer(nftId[_tokenId].currentOwner, msg.sender, _tokenId);

        // transfer the tokens to the owner for now
        nftId[_tokenId] = Nft(
            false,
            0,
            payable(msg.sender)
        );

    }
}