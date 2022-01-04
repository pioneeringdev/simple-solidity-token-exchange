// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./SwapableToken.sol";

/// @title Token Swapper!
/// @author
/// @notice You can use this contract to Swap Alpha and Beta tokens with Charlie tokens.
/// @dev All function calls are currently implemented without side effects


contract Wrapper is SwapableToken {
    address owner;
    address alphaToken;
    address betaToken;

    /**
     * @dev Sets Alpha Token Contract Address, Beta Token Contract Address, and Charlie Token Contract Address (which is this contract)
     *
     *
     * @param _alphaToken Alpha Token Contract Address
     * @param _betaToken Beta Token Contract Address
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(address _alphaToken, address _betaToken)
        SwapableToken("Charlie Contract", "CHA")
    {
        owner = msg.sender;
        alphaToken = _alphaToken;
        betaToken = _betaToken;
    }

    /**
     * @notice Convert an amount of input token_ to an equivalent amount of the output token
     *
     * @param token_ address of token to swap
     * @param amount amount of token to swap/receive
     */
    function swap(address token_, uint256 amount) external {
        require(msg.sender != owner, "Sender and recipient should be different.");
        require(amount > 0, "Can't swap non-positive amount");
        require(token_ == alphaToken || token_ == betaToken, "Invalid token address");
        require(balanceOf(owner) >= amount, "Insufficient Tokens");
        require(IERC20(token_).balanceOf(msg.sender) >= amount, "Insufficient Tokens");
        require(IERC20(token_).allowance(msg.sender, address(this)) >= amount, "Ecedeed Maximum allowance");
        bool success = IERC20(token_).transferFrom(msg.sender, owner, amount);
        require(success, "Failed to send tokens");
        _transfer(owner, msg.sender, amount);
    }

    /**
     * @notice Convert an amount of input token_ to an equivalent amount of the output token
     *
     * @param token_ address of token to unswap
     * @param amount amount of token to unswap/send
     */
    function unswap(address token_, uint256 amount) external {
        require(msg.sender != owner, "Sender and recipient should be different.");
        require(amount > 0, "Can't unswap non-positive amount");
        require(token_ == alphaToken || token_ == betaToken, "Invalid token address");
        require(balanceOf(msg.sender) >= amount, "Insufficient Tokens");
        require(IERC20(token_).balanceOf(owner) >= amount, "Insufficient Tokens");
        require(IERC20(token_).allowance(owner, address(this)) >= amount, "Ecedeed Maximum allowance");
        bool success = transfer(owner, amount);
        require(success, "Failed to send tokens");
        IERC20(token_).transferFrom(owner, msg.sender, amount);
    }
}
