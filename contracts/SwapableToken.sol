// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title Swapable Token - To be used with token swapper
/// @author Ebrahim Elbagory
/// @notice You can use this contract to Create tokens that can be swapped using the token swapper contract (Wrapper).
/// @dev All function calls are currently implemented without side effects

contract SwapableToken is ERC20 {
    string private _name;
    string private _symbol;
    address wrapper;

    /**
     * @dev creates Alpha Token Contract, Beta Token Contract
     *
     *
     * @param name is the name of the SwapableToken
     * @param symbol is the symbol of the SwapableToken
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 10000000000000000000000);
        _name = name;
        _symbol = symbol;
    }
}

contract AlphaToken is SwapableToken {
    constructor() SwapableToken("Doge Alpha", "dogeAlpha") {}
}

contract BetaToken is SwapableToken {
    constructor() SwapableToken ("Doge Beta", "dogeBeta") {}
}
