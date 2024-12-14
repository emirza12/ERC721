// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./ERC223.sol";
import "./IERC223.sol";
import "./IERC223Recipient.sol";
import "./Address.sol";

contract MyERC223 is ERC223Token {

    uint8 public _decimals = 18;
    uint256 public _totalSupply = 1000000 * (10 ** uint256(_decimals));

    constructor() ERC223Token("MegaToken", "MEG", 18) {
        mint(_totalSupply); 
    }
}