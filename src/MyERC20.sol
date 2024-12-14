// SPDX-Licence-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import"@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20 is ERC20 {

    uint8 public _decimals = 18;
    uint256 public _totalSupply = 1000000 * (10 ** uint256(_decimals));

    constructor() ERC20("SuperToken", "SUP") {
        _mint(msg.sender, _totalSupply); 
    }
}