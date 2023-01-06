// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TrankersToken is ERC20,Ownable{
    constructor() ERC20("TrankersToken", "TRT"){
        _mint(msg.sender,1000);
    }

    function mint(address to,uint amount)onlyOwner public{
     require(amount >= 0,"put some amount");
     require(to != address(0),"address is zero");
     _mint(to,amount);
    }

    function burn(address from,uint amount)public{
     require(amount > 0,"put some amount");
      require(from != address(0),"address is zero");
     _burn(from,amount);   
    }

    function decimals() public view virtual override returns (uint8) {
    return 0;
}

    }
