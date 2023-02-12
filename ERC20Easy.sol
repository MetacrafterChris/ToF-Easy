// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("Spicy Hotdog", "HOT") {
        _mint(msg.sender, 500000 * 10 ** decimals());
    }
}
