// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {SafeMathUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract AggregateStableTokenOracle is Initializable, OwnableUpgradeable {
    using SafeMathUpgradeable for uint256;

    /**
     * @notice Aggregate of multiple price feeds.
     */
    mapping(string => AggregatorV3Interface) private _stableTokenAggregators;

    /**
     * @notice Stable token contracts that are identifiable by this contract.
     */
    mapping(string => address) private _supportedStableTokenContracts;

    /**
     * @notice Stable tokens that are enabled for this contract.
     * @dev bool represents enabled status.
     */
    mapping(string => bool) private _supportedStableTokens;

    function initialize() public initializer {
        __Ownable_init();
    }

    modifier supportsToken(string memory symbol) {
        require(
            _supportedStableTokens[symbol] == true,
            "Stable token not supported."
        );
        _;
    }

    function addStableToken(string memory symbol, address contractAddress)
        external
        onlyOwner
        supportsToken(symbol)
        returns (bool)
    {
        require(
            _supportedStableTokenContracts[symbol] != contractAddress,
            "Stable token already added."
        );
        _supportedStableTokenContracts[symbol] = contractAddress;
        _supportedStableTokens[symbol] = true;
        _stableTokenAggregators[symbol] = AggregatorV3Interface(contractAddress);
        return true;
    }

    function disableStableToken(string memory symbol)
        external
        onlyOwner
        supportsToken(symbol)
    {
        require(
            _supportedStableTokens[symbol] == true,
            "Stable token is already disabled."
        );
        _supportedStableTokens[symbol] = false;
    }

    function enableStableToken(string memory symbol)
        external
        onlyOwner
        supportsToken(symbol)
    {
        require(
            _supportedStableTokens[symbol] == false,
            "Stable token is already enabled."
        );
        _supportedStableTokens[symbol] = true;
    }

    function getStablePrice(string memory symbol)
        external
        view 
        supportsToken(symbol)
        returns (uint256) 
    {
        AggregatorV3Interface aggregator = _stableTokenAggregators[symbol];
        (, int256 price, , , ) = aggregator.latestRoundData();
        return price >= 0 ? uint256(price).mul(1e10) : 0;
    }
}
