// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {MintBasicNft} from "../script/Interactions.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract BasicNftInteractionsTest is Test {
    BasicNft public basicNft;
    DeployBasicNft deployer;
    MintBasicNft public mintBasicNft;
    string public pugTokenId;

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testMintBasicNft() public {
        mintBasicNft = new MintBasicNft();
        pugTokenId = mintBasicNft.getPug();
        console.log(pugTokenId);
        mintBasicNft.mintNftOnContract(address(basicNft));
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(pugTokenId)));
    }
}
