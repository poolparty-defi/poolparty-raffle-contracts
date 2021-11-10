pragma solidity ^0.8.9;

import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import { ReentrancyGuardUpgradeable } from "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import { SafeERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import { SafeMathUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import { SafeCastUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/math/SafeCastUpgradeable.sol";
import { ERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import { MultiTokenVault } from "../vault/MultiTokenVault.sol";

contract PoolPartySubscriptionManager is OwnableUpgradeable, ReentrancyGuardUpgradeable {
    using SafeERC20Upgradeable for ERC20Upgradeable;
    using SafeMathUpgradeable for uint256;
    using SafeCastUpgradeable for uint256;

    string internal _subscriptionTokenSymbol;

    address internal _subscriptionTokenContract;

    /* MultiTokenVault internal _vaultContract;

    uint32 internal _subscriptionCost;

    struct Subscription {
        uint32 cost;
        uint32 startTimestamp;
        uint32 expirationTimestamp;
        bool expired;
    }

    mapping(address => Subscription) internal _subscriptions;

    mapping(address => bool) internal _currentSubscribers;

    event PoolPartySubscriptionManagerInitialized(address vaultContract, string subscriptionTokenSymbol, address subscriptionTokenContract, uint32 subscriptionCost);

    event SubscriptionActivated(address subscriber, Subscription subscription);

    function initialize(
        MultiTokenVault vaultContract,
        string memory subscriptionTokenSymbol,
        address subscriptionTokenContract,
        uint32 subscriptionCost
    )   
        public 
        initializer 
    {
        require(address(vaultContract) != address(0), "validation_error:initialize:vaultContract_zero_address");
        require(address(subscriptionTokenContract) != address(0), "validation_error:initialize:subscriptionTokenContract");
        require(bytes(_subscriptionTokenSymbol).length != 0, "validation_error:initialize:_subscriptionTokenSymbol_empty");
        require(subscriptionCost > 0, "validation_error:initialize:subscriptionCost_zero_or_less");
        __Ownable_init();
        __ReentrancyGuard_init();

        _vaultContract = vaultContract;
        _subscriptionTokenSymbol = subscriptionTokenSymbol;
        _subscriptionTokenContract = subscriptionTokenContract;
        _subscriptionCost = subscriptionCost;

        emit PoolPartySubscriptionManagerInitialized(address(_vaultContract), subscriptionTokenSymbol, _subscriptionTokenContract, _subscriptionCost);
    }

    modifier activeSubscription(address subscriber) {
        require(_currentSubscribers[subscriber] == true,  "validation_error:activeSubscription:inactive_subscription");
        _;
    }

    function activateSubscription(address subscriber)
        external
        payable 
    {
        require(_currentSubscribers[subscriber] == false, "validation_error:activateSubscription:subscription_active");
        _currentSubscribers[subscriber] = true;

        Subscription memory _subscription = Subscription(
            _subscriptionCost, 
            block.timestamp.toUint32(), 
            _getExpirationTimestampOffset(), 
            false
        );
        _subscriptions[subscriber] = _subscription;

        _vaultContract.depositToken(_subscriptionTokenSymbol, msg.sender, _subscriptionCost);

        emit SubscriptionActivated(subscriber, _subscription);
    }

    function expireSubscription(address subscriber)
        external
        activeSubscription(subscriber)
    {
        _currentSubscribers[subscriber] = false;
        Subscription memory _subscription = _subscriptions[subscriber];
        _subscriptions[subscriber] = Subscription(
            _subscription.cost, 
            _subscription.startTimestamp, 
            _subscription.expirationTimestamp, 
            true
        );

    }

    function _getExpirationTimestampOffset()
        public
        view
        returns (uint32) 
    {
        return block.timestamp.toUint32() + 30 days;
    } */

}