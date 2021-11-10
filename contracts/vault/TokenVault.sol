// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {IERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import {SafeERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";

contract TokenVault is Initializable, OwnableUpgradeable {
    using SafeERC20Upgradeable for IERC20Upgradeable;

    mapping(string => address) private _supportedTokensAddresses;

    mapping(string => IERC20Upgradeable) private _supportedTokenContracts;

    mapping(string => bool) private _supportedTokensEnabled;

    function initialize() public initializer {
        __Ownable_init();
    }

    function addTokenToVault(string memory symbol, address tokenContractAddress) 
        external
        onlyOwner
    {
        IERC20Upgradeable erc20Token = IERC20Upgradeable(tokenContractAddress);
        require(
            _supportedTokenContracts[symbol] != erc20Token,
            "Token already added to vault.");
        _supportedTokenContracts[symbol] = erc20Token;
        _supportedTokensAddresses[symbol] = tokenContractAddress;
        _supportedTokensEnabled[symbol] = true;
    }

    modifier supportsToken(string memory symbol) {
        address contractAddress = _supportedTokensAddresses[symbol];
        require(contractAddress != address(0), "Token contract not supported.");
        require(
            _supportedTokenContracts[symbol] == IERC20Upgradeable(contractAddress),
            "Stable token not supported."
        );
        _;
    }

    function enableToken(string memory symbol) 
        external
        onlyOwner
    {
        require(_supportedTokensEnabled[symbol] == false, "Token already enabled.");
        _supportedTokensEnabled[symbol] = true;
    }
    
    function disableToken(string memory symbol) 
        external
        onlyOwner
    {
        require(_supportedTokensEnabled[symbol] == true, "Token already disabled.");
        _supportedTokensEnabled[symbol] = false;
    }

    function approve(string memory symbol, uint256 amount)
        external
        supportsToken(symbol)
    {
        IERC20Upgradeable token = _token(symbol);
        uint256 allowance = token.allowance(address(this), msg.sender);
        if (allowance == amount) return;
        if (amount > 0 && allowance > 0) token.safeApprove(msg.sender, 0);
        token.safeApprove(msg.sender, amount);
    }

    function withdraw(string memory symbol, uint256 amount) 
        public
        payable
        supportsToken(symbol)
    {
        IERC20Upgradeable erc20Contract = _token(symbol);
        uint256 amountTobuy = msg.value;
        uint256 dexBalance = erc20Contract.balanceOf(address(this));
        require(amountTobuy > 0, "You need to send some ether");
        require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
        erc20Contract.safeTransferFrom(address(this), msg.sender, amount);
    }

    function deposit(string memory symbol, uint256 amount) 
        public
        payable
        supportsToken(symbol)
    {
        IERC20Upgradeable erc20Contract = _supportedTokenContracts[symbol];
        uint256 allowance = erc20Contract.allowance(msg.sender, address(this));
        require(allowance >= amount, "You need more tokens.");
        erc20Contract.safeTransferFrom(msg.sender, address(this), amount);
    }

    function _token(string memory symbol) internal view returns (IERC20Upgradeable) {
        return _supportedTokenContracts[symbol];
    }

}