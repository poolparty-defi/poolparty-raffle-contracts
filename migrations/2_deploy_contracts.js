// SPDX-License-Identifier: UNLICENSED
const { deployProxy, upgradeProxy, admin } = require('@openzeppelin/truffle-upgrades');
require('dotenv').config();

/* var DAIVault = artifacts.require('./pool/token/StableTokenVault.sol')
var TokenDistributor = artifacts.require("./pool/token/TokenDistributor.sol");
var Migrations = artifacts.require("./Migrations.sol");
var StableTokenOracle = artifacts.require("./oracle/AggregateStableTokenOracle.sol"); */
var MultiTokenVault = artifacts.require("./vault/MultiTokenVault.sol");
var PoolPartySubscriptionManager = artifacts.require("./subscriber/PoolPartySubscriptionManager.sol");
var PartyToken = artifacts.require("./token/PartyToken.sol");
/* var DAI = artifacts.require("./mocks/DAI.sol");
const erc20Abi = require('../test/abi/ERC20.json');
const currencies = require("../test/fixtures/currencies.json"); */

module.exports = async function(deployer, network, accounts) {

    if(network == 'rinkeby_test' || network == 'avax_c_test')  {
        return;
    }

    //await deployer.deploy(Migrations);

    /* await deployer.deploy(DAI, 4);
    const dai = await DAI.deployed();
    await dai.mint('0x99e8a17101c4722898A0aeE3E3EB2A19735dfdB0', 1000000);

    let supply = await dai.totalSupply();
    await dai.approve('0x99e8a17101c4722898A0aeE3E3EB2A19735dfdB0', 100 );
    console.log(supply); */

   /*  const daiVault = await deployProxy(DAIVault, ['DAI', 'DAI', '0x6B175474E89094C44Da98b954EedeAC495271d0F'],
        {deployer, unsafeAllowLinkedLibraries: true});

    var erc20Contract = new web3.eth.Contract(erc20Abi, currencies['DAI'].tokenAddress);
    console.log(erc20Contract);
    const controller = await deployProxy(TokenDistributor, {deployer, unsafeAllowLinkedLibraries: true});
    await controller.addSupportedStableToken('DAI', currencies['DAI'].tokenAddress, currencies['DAI'].decimals);
 */
    await deployProxy(PartyToken, [333333333], {deployer, overwrite: false, unsafeAllowLinkedLibraries: true});

    console.log("deploying?")

    const existing = await PartyToken.deployed();
    /* const instance = await upgradeProxy(existing.address, PartyToken, [333333333]);

    console.log("Upgraded PartyToken: ", instance.address); */

   /*  let instance = await MultiTokenVault.deployed();

    //let multiVault = await upgradeProxy(instance, MultiTokenVault, ['PARTY', existing.address]);

    //await multiVault.addToken('DAI', '0x6f5390a8cd02d83b23c5f1d594bffb9050eb4ca3', true, false, 0);

    console.log('Got here');

    const bal = await instance.vaultBalance('DAI');

    console.log("DAI Vault Balance: ", bal);

    let symbol = await existing.symbol();

    console.log("party symbol", symbol);

    let subManager = await deployProxy(PoolPartySubscriptionManager, [MultiTokenVault.address, symbol, existing.address, 10], { deployer, overwrite: true });

    console.log(subManager); */

   // const vault = await deployProxy(TokenVault, {deployer, unsafeAllowLinkedLibraries: true});
   // const oracle = await deployProxy(StableTokenOracle, {deployer, unsafeAllowLinkedLibraries: true});
};