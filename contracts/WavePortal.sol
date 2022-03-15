// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 totalShellies = 10000;

    constructor () {
        console.log("Woaaaaah, I just wrote a smart contract and also made my own coin'ish");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
    }

    function buyShelly(uint256 amt) public {
        totalShellies -= amt;
        console.log("%s bought %d shellies", msg.sender, amt);
    }

    function getTotalShellies() view public returns (uint256) {
        console.log("There are %d shellies left", totalShellies);
        return totalShellies;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }


}