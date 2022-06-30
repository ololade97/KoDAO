// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

/**
 * @title KoDAO Passes Contract
 * @dev Extends ERC1155 Token Standard basic implementation
 */
contract KoDAO is ERC1155Supply, Ownable {
    string public name;
    string public symbol;
    uint256 private constant tokenID = 0;
    uint256 public constant maxSupply = 2600;
    uint256 public constant maxPurchase = 5;
    uint256 public constant buyPrice = 0.01 ether;
    uint256 public reserveMaxAmount = 100;


    constructor(string memory _uri) ERC1155(_uri) ERC1155Supply() {
        name = "KoDAO";
        symbol = "KODAO";
    }

    modifier onlyEOA() {
        require(msg.sender == tx.origin, "Must use EOA");
        _;
    }

    function mint(address account, uint256 amount) public {
        require(amount < maxPurchase, "Max purchase exceeded");
        require(totalSupply(tokenID) + amount < maxSupply, "Purchase would exceed max supply");

        _mint(account, tokenID, amount, "");
    }

}
