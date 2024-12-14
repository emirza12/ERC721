// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MyERC20.sol";
import "../src/MyERC223.sol";
import "../src/MyERC721.sol";

contract MyERC721Test is Test {
    MyERC20 public erc20;   
    MyERC223 public erc223;    
    MyERC721 public erc721;  


    address user = address(1);       

    function setUp() public {
        // Deploy ERC20, ERC223, and ERC721 tokens
        erc20 = new MyERC20();
        erc223 = new MyERC223();
        erc721 = new MyERC721(address(erc20), address(erc223));

        // Create a test user
        
        vm.prank(address(this));

        // Mint ERC20 and ERC223 tokens to the user
        uint256 erc20Amount = 100 * 10 ** erc20.decimals();  // Minting 100 ERC20 tokens with 18 decimals
        uint256 erc223Amount = 1000 * 10 ** 18;  // Minting 100 ERC223 tokens with 18 decimals

        // Transfer ERC20 and ERC223 tokens to the user
        erc20.transfer(user, erc20Amount);
        erc223.mint(200* 10 ** 18);
    }

    // Enhanced test for buying an ERC721 with ERC20
    function testBuyERC721WithERC20() public {
        vm.startPrank(user);
        uint256 initialSupply = erc721.totalSupply();
        uint256 initialTokenId = erc721.nextTokenId();

        // Approve ERC20 tokens for spending (approve 2 ERC20 tokens with 18 decimals)
        uint256 approvalAmount = 2 * 10 ** erc20.decimals();  // 2 tokens with 18 decimals
        erc20.approve(address(erc721), approvalAmount);

        // Mint an ERC721 token using ERC20 tokens
        erc721.mintWithERC20(1);

        vm.stopPrank();

        // Verify ERC721 token ownership
        assertEq(erc721.ownerOf(initialTokenId), user, "ERC721 token not minted correctly");

        // Verify ERC721 total supply increment
        assertEq(erc721.totalSupply(), initialSupply + 1, "ERC721 total supply not incremented correctly");


        // Verify token ID increment
        assertEq(erc721.nextTokenId(), initialTokenId + 1, "ERC721 token ID not incremented correctly");
    }

    // Enhanced test for buying an ERC721 with ERC223
    function testBuyERC721WithERC223() public {
        vm.startPrank(user);
        uint256 initialSupply = erc721.totalSupply();
        uint256 initialTokenId = erc721.nextTokenId();

        // Mint an ERC721 token using ERC223 tokens
        erc721.mintWithERC223(1);

        

        // Verify ERC721 token ownership
        assertEq(erc721.ownerOf(initialTokenId), user, "ERC721 token not minted correctly");

        // Verify ERC721 total supply increment
        assertEq(erc721.totalSupply(), initialSupply + 1, "ERC721 total supply not incremented correctly");

        // Verify token ID increment
        assertEq(erc721.nextTokenId(), initialTokenId + 1, "ERC721 token ID not incremented correctly");

        vm.stopPrank();
    }
}
