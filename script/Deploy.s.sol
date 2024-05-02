// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/ZuniswapV2Factory.sol";
import "../src/ZuniswapV2Pair.sol";
import "../src/ZuniswapV2Router.sol";
import "../src/mocks/ERC20Mintable.sol";

/* 
    source .env && forge script script/Deploy.s.sol:DeployScript --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY --broadcast --verify --verifier blockscout --verifier-url $VERIFIER_URL
*/

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ZuniswapV2Factory factory = new ZuniswapV2Factory();
        ZuniswapV2Router router = new ZuniswapV2Router(address(factory));

        ERC20Mintable tokenA = new ERC20Mintable("Token A", "TKNA");
        ERC20Mintable tokenB = new ERC20Mintable("Token B", "TKNB");
        ERC20Mintable tokenC = new ERC20Mintable("Token C", "TKNC");

        tokenA.mint(20 ether, address(this));
        tokenB.mint(20 ether, address(this));
        tokenC.mint(20 ether, address(this));

        vm.stopBroadcast();
    }
}