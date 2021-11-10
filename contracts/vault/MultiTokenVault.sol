// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import { IERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import { SafeERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import { ReentrancyGuardUpgradeable } from "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import { SafeMath } from "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MultiTokenVault is OwnableUpgradeable, ReentrancyGuardUpgradeable {
    using SafeMath for uint256;
    using SafeERC20Upgradeable for IERC20Upgradeable;

    /* struct VaulToken {
        address contractAddress;
        string symbol;
        bool enabled;
        bool hasMaximumCap;
        uint256 maximumCap;
        bool supporteds;
    }

    mapping(address => string) internal _storedTokens;

    /// @dev Holds statuses of tokens. IE: { Enabled(0), Disabled(1) }.
    mapping(address => bool) internal _tokenStatuses;

    /// @dev Optional: Maximum token caps for the vault.
    mapping(address => uint256) internal _maximumTokenCaps;

    /// @dev Defines whether or not the token has a maximum cap.
    mapping(address => bool) internal _tokensHasMaximumCap;

    /// @dev Stores the balances of the underlying tokens.
    mapping(address => uint256) internal _tokenBalances;

    /// @dev Holds the default token for the vault.
    address internal _defaultTokenContract;

      ///////////////////////////////
     ///          Events         ///
    /////////////////////////////// 
    event MultiTokenVaultInitialized(address defaultContractAddress);

    event TokenAddedToVault(address erc20Contract, bool enabled, bool hasMaximumCap, uint256 maximumCap);

    event TokenStatusUpdated(address erc20Contract, bool newStatus);


    function initialize(address defaultTokenContract) 
        public 
        initializer 
    {
        require(defaultTokenContract != address(0), "validation_error:initialize:defaultTokenContract_zero_address");
        __Ownable_init();
        __ReentrancyGuard_init();

        _defaultTokenContract = defaultTokenContract;

        _addToken(_defaultTokenContract, true, false, 0);

        emit MultiTokenVaultInitialized(_defaultTokenContract);
    }

    function _token(address erc20Contract)
        internal
        tokenExists(erc20Contract)
        view
        returns(IERC20Upgradeable) 
    {
        return IERC20Upgradeable(_storedTokens[erc20Contract]);
    }

    modifier tokenEnabled(address erc20Contract) {
        require(_tokenStatuses[erc20Contract] == true, "validation_error:tokenEnabled:token_disabled");
        _;
    }

    function updateTokenStatus(address erc20Contract, bool enabled) 
        external 
        onlyOwner 
    {
        require(erc20Contract != address(0), "validation_error:_updateTokenStatus:token_not_stored");
        require(_tokenStatuses[erc20Contract] != enabled, "validation_error:_updateTokenStatus:token_status_already_set");

        _tokenStatuses[erc20Contract] = enabled;

        emit TokenStatusUpdated(erc20Contract, enabled);
    }

    modifier tokenExists(address erc20Contract) {
        require(_tokenStatuses[erc20Contract] == true, "validation_error:tokenExists:token_nonexistant");
        _;
    }

    function _tokenExists(address erc20Contract) 
        internal 
        view
        returns (bool)
    {
        return _tokenStatuses[erc20Contract] == true;
    }

    function _addToken(
        address erc20Contract, 
        bool enabled, 
        bool hasMaximumCap,
        uint256 maximumCap
    ) 
        internal
    {
        require(_storedTokens[erc20Contract] != erc20Contract && _storedTokens[erc20Contract] == address(0), "validation_error:addToken:invalid_token_address");   
        require(hasMaximumCap ? maximumCap > 0 : maximumCap == 0, "validation_error:addToken:maximum_cap_cannot_be_zero");
        _storedTokens[erc20Contract] = erc20Contract;
        _tokenStatuses[erc20Contract] = enabled;
        _tokensHasMaximumCap[erc20Contract] = hasMaximumCap;
        _maximumTokenCaps[erc20Contract] = maximumCap;
    }

    function addToken(
        string memory symbol, 
        address erc20Contract, 
        bool enabled, 
        bool hasMaximumCap,
        uint256 maximumCap
    ) 
        external
        onlyOwner
    {
        _addToken(symbol, erc20Contract, enabled, hasMaximumCap, maximumCap);

        emit TokenAddedToVault(symbol, erc20Contract, enabled, hasMaximumCap, maximumCap);
    }

    function notReachedCap(string memory symbol, uint256 amount)
        internal
        view
        tokenExists(symbol)
        returns (bool) 
    {
        bool tokenHasCap = _tokensHasMaximumCap[symbol];
        if(!tokenHasCap) return true;
        if(amount <= 0) return false;
        uint256 tokenCap = _maximumTokenCaps[symbol];
        uint256 currentBalance = _tokenBalances[symbol];
        if(currentBalance.add(amount) > tokenCap) return false;
        return true;
    }

    modifier canDepositLiquidity(string memory symbol, uint256 amount) {
        require(notReachedCap(symbol, amount), "validation_error:canDepositLiquidity:deposit_error");
        _;
    }

    modifier canWithdraw(string memory symbol, uint256 amount) {
        require(_tokenBalances[symbol] >= amount, "validation_error:canWithdraw:vault_short_token_amount");
        _;
    }

    function depositToken(string memory symbol, address takeFrom, uint256 amount) 
        external
        tokenExists(symbol)
        canDepositLiquidity(symbol, amount)
        nonReentrant
    {
        _token(symbol).safeApprove(address(_token(symbol)), amount);
        _token(symbol).safeTransferFrom(takeFrom, address(this), amount);
        _tokenBalances[symbol].add(amount);
    }

    function withdrawToken(string memory symbol, address withdrawTo, uint256 amount)
        external 
        tokenExists(symbol)
        canWithdraw(symbol, amount)
        nonReentrant
    {
        _token(symbol).safeTransferFrom(address(this), withdrawTo, amount);
        _tokenBalances[symbol].sub(amount);
    }

    function vaultBalance(string memory symbol) 
        external
        tokenExists(symbol)
        view
        returns (uint256)
    {
        return _tokenBalances[symbol];
    } */
}