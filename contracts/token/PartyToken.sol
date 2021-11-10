// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import { ERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import { ERC20BurnableUpgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import { SafeERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import { SafeMath } from "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PartyToken is ERC20Upgradeable, ERC20BurnableUpgradeable, OwnableUpgradeable {
    using SafeMath for uint256;
    using SafeERC20Upgradeable for ERC20Upgradeable;

    uint256 private _initialSupply;

       /////////////////////////////
      ///        Events         ///
     /////////////////////////////


    function initialize(uint256 initialSupply) 
        public 
        initializer
    {
        __Ownable_init();
        __ERC20_init("Pool Party", "PARTY");
        __ERC20Burnable_init();

        if(_initialSupply == 0) {
            _initialSupply = initialSupply;
            _mint(msg.sender, _initialSupply);
        }
    }

    function mint(address to, uint256 amount)
        public
        onlyOwner
    {
        require(to != address(0), "validation_error:mint:zero_address");
        _mint(to, amount);
    }

    function burn(address burnFor, uint256 amount)
        public
        onlyOwner
    {
        require(burnFor != address(0), "validation_error:mint:zero_address");
        require(amount <= balanceOf(burnFor), "validation_error:burn:insufficient_funds");
        _burn(burnFor, amount);
    }
}