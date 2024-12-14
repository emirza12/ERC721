// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IERC223.sol";

contract MyERC721 is ERC721 {
    uint256 public nextTokenId = 0;                
    uint256 private _totalSupply;  // Track total supply of minted tokens
    uint256 public constant ERC20ratio = 2;        // 1 ERC721 = 2 ERC20 tokens 
    uint256 public constant ERC223ratio = 1;       // 1 ERC721 = 1 ERC223 tokens     
    IERC20 public immutable paymentTokenERC20;     // ERC20 token used for payments
    IERC223 public immutable paymentTokenERC223;   // ERC223 token used for payments

    constructor(address _paymentTokenERC20, address _paymentTokenERC223) ERC721("UltraToken", "ULT") {
        require(_paymentTokenERC20 != address(0), "Invalid ERC20 token address.");
        require(_paymentTokenERC223 != address(0), "Invalid ERC223 token address.");
        paymentTokenERC20 = IERC20(_paymentTokenERC20);         
        paymentTokenERC223 = IERC223(_paymentTokenERC223);      
    }

    // Expose totalSupply
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // Mint ERC721 with ERC20 tokens
    function mintWithERC20(uint256 amount) public {
        uint256 totalCost = ERC20ratio * amount;

        require(paymentTokenERC20.balanceOf(msg.sender) >= totalCost, "Not enough ERC20 tokens.");

        // Transfer ERC20 tokens from the user to this contract
        require(paymentTokenERC20.transferFrom(msg.sender, address(this), totalCost), "Payment failed.");

        // Mint the requested number of NFTs
        for (uint256 i = 0; i < amount; i++) {
            _mint(msg.sender, nextTokenId++);
            _totalSupply++; 
        }
    }

    // Mint ERC721 with ERC223 tokens
    function mintWithERC223(uint256 amount) public {
        uint256 totalCost = ERC223ratio * amount;

        require(paymentTokenERC223.balanceOf(msg.sender) >= totalCost, "Not enough ERC223 tokens.");

        // Transfer ERC223 tokens from the user to this contract
        require(paymentTokenERC223.transfer(address(this), totalCost), "Payment failed.");

        // Mint the requested number of NFTs
        for (uint256 i = 0; i < amount; i++) {
            _mint(msg.sender, nextTokenId++);
            _totalSupply++;
        }
    }
}
