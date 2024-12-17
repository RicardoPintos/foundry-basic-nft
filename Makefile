-include .env

.PHONY: build test fork install deploy anvil sepolia

build :; forge build

test :; forge test

fork-test :; forge test --fork-url $(SEPOLIA_RPC_URL)

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

# ANVIL

deploy-anvil:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url $(LOCAL_RPC_URL) --account anvilKey --broadcast -vvvv

mint-anvil:
	@forge script script/Interactions.s.sol:MintBasicNft --rpc-url $(LOCAL_RPC_URL) --account anvilKey --broadcast -vvvv


# SEPOLIA

deploy-sepolia:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url $(SEPOLIA_RPC_URL) --account testKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

mint-sepolia:
	@forge script script/Interactions.s.sol:MintBasicNft --rpc-url $(SEPOLIA_RPC_URL) --account testKey --broadcast -vvvv
