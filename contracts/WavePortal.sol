// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    //events r used to inform calling application about the current state of the contract and change mad to the contract
    event NewWave(address indexed from, uint256 timestamp, string message);

    // A struct is basically a custom datatype where we can customize what we want to hold inside it.
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    // declare a varible waves for storing the array of structs
    // this is where we'll store all the waves anyone ever's sent to me
    Wave[] waves;


    constructor () {
        console.log("Woaaaaah, I just wrote a smart contract");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved w/ message %s!", msg.sender, _message);

        //push the wave data to the array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    // a function to return the waves array
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }


}