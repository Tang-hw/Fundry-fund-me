-include .env

# Clean the repo
clean  :; forge clean

build:; forge build

test :; forge test

deploy-sepolia:
	@forge script script/DeployFundMe.s.sol:DeployFundMe $(NETWORK_ARGS)