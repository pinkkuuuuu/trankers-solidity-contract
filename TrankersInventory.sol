// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./TrankersToken.sol";

contract TrankersInventory is ERC1155,Ownable{
    using Counters for Counters.Counter;
      Counters.Counter private _tokenIds;

       address token;

     constructor(address _token) ERC1155("ipfs://bafybeihha7rjxcddj7u5wnysjafsmz2bnmvxnnblukeueokxg5immhrkxi/{id}.json"){
         token = _token;
     }

    function updateToken(address _token)public onlyOwner{
        token = _token;
    }

        struct Inventory {
        uint tokenId;
        uint price;
        uint256 tokeninTRT;
        }

     mapping(uint => Inventory) private idToInventory;

    function mint(uint256 price,uint256 tokeninTRT) public payable onlyOwner {
        _tokenIds.increment();
         uint256 tokenId = _tokenIds.current();
         _mint(msg.sender, tokenId,1,"");

         idToInventory[tokenId] = Inventory(
          tokenId,
          price,
          tokeninTRT
      );
    }

    function mint(uint256 tokenId) public payable {
    require(balanceOf(msg.sender,tokenId) == 0,"already minted");
     if(msg.value != idToInventory[tokenId].price){
    TrankersToken(token).burn(msg.sender,idToInventory[tokenId].tokeninTRT);

 _mint(msg.sender,tokenId,1,"");
        }
    else{
    _mint(msg.sender, tokenId,1,"");
    }
    }

    function getPrice(uint256 tokenId) public view returns(uint256,uint256){
        return(idToInventory[tokenId].price,idToInventory[tokenId].tokeninTRT);

    }

}
