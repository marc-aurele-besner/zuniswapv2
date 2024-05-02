// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/ZuniswapV2Factory.sol";
import "../src/ZuniswapV2Pair.sol";
import "../src/ZuniswapV2Router.sol";
import "../src/mocks/ERC20Mintable.sol";

/* 
    source .env && forge script script/DeployAndSetup.s.sol:DeployAndSetupScript --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY --broadcast --verify --verifier blockscout --verifier-url $VERIFIER_URL
*/

contract DeployAndSetupScript is Script {

    event LogBalance(address token, address owner, uint256 balance);
    event LogAllowance(address token, address owner, address spender, uint256 allowance);

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ZuniswapV2Factory factory = new ZuniswapV2Factory();
        ZuniswapV2Router router = new ZuniswapV2Router(address(factory));

        address owner = address(this);
        address spender = address(router);

        ERC20Mintable tokenA = new ERC20Mintable("Token 1", "TKN1");
        ERC20Mintable tokenB = new ERC20Mintable("Token 2", "TKN2");

        tokenA.mint(20 ether, owner);
        tokenB.mint(20 ether, owner);

        emit LogBalance(address(tokenA), owner, tokenA.balanceOf(owner));
        emit LogBalance(address(tokenB), owner, tokenB.balanceOf(owner));

        tokenA.approve(spender, 2 ether);
        tokenB.approve(spender, 2 ether);

        emit LogAllowance(address(tokenA), owner, spender, tokenA.allowance(owner, spender));
        emit LogAllowance(address(tokenB), owner, spender, tokenB.allowance(owner, spender));

        router.addLiquidity(
            address(tokenA),
            address(tokenB),
            1 ether,
            1 ether,
            1 ether,
            1 ether,
            owner
        );

        vm.stopBroadcast();
    }
}