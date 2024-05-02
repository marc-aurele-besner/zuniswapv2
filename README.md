# ZUniswapV2, a clone of UniswapV2 made in educational purposes

## Using this repo

1. `git clone git@github.com:Jeiwan/zuniswapv2.git`
1. Ensure you have installed Rust and Cargo: [Install Rust](https://www.rust-lang.org/tools/install)
1. Install Foundry:
   `cargo install --git https://github.com/gakonst/foundry --bin forge --locked`
1. Install dependency contracts:
   `git submodule update --init --recursive`
1. Run tests:
   `forge test`

## Add deployment and setup script

To allow for live or testing again, a localhost RPC

### Instruction

`cp .env.sample .env`

Set a private key and address in `DEPLOYER_PRIVATE_KEY` and `DEPLOYER_ADDRESS`

Deploy contracts:

`source .env && forge script script/Deploy.s.sol:DeployScript --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY --broadcast --verify --verifier blockscout --verifier-url $VERIFIER_URL`

Create 1 pair:
`source .env && cast send $FACTORY "createPair(address,address)" $TOKEN1 $TOKEN2  --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY`

Approve Spending for each token:
`source .env && cast send $TOKEN1 "approve(address,uint256)" $ROUTER 1000000000000000000 --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY`
`source .env && cast send $TOKEN2 "approve(address,uint256)" $ROUTER 1000000000000000000 --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY`
`source .env && cast send $TOKEN2 "approve(address,uint256)" $ROUTER 1000000000000000000 --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY`

Add liquidity:
`source .env && cast send $ROUTER "addLiquidity(address,address,uint256,uint256,uint256,uint256,address)" $TOKEN1 $TOKEN2 1000000000000000000 1000000000000000000 1000000000000000000 1000000000000000000 $DEPLOYER_ADDRESS  --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY`

Add liquidity (with override gas limit)

`source .env && cast send $ROUTER "addLiquidity(address,address,uint256,uint256,uint256,uint256,address)" $TOKEN1 $TOKEN2 1000000000000000000 1000000000000000000 1000000000000000000 1000000000000000000 $DEPLOYER_ADDRESS  --rpc-url $NOVA_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY  --gas-limit 100000`

## Reference

This repo was a fork of  [Zuniswap2](https://github.com/Jeiwan/zuniswapv2)