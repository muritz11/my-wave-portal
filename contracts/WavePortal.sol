// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // variable to store random no
    uint256 private seed;

    //events r used to inform calling application about the current state of the contract and change mad to the contract
    event NewWave(address indexed from, uint256 timestamp, string message);

    // A struct is basically a custom datatype where we can customize what we want to hold inside it.
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    // declare a variable waves for storing the array of structs
    // this is where we'll store all the waves anyone ever's sent to me
    Wave[] waves;


    mapping(address => uint256) public lastWavedAt;

    constructor () payable {
        console.log("Woaaaaah, I just wrote a smart contract");
        // init seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

        require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");

        // update current user's timestamp
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved w/ message %s!", msg.sender, _message);

        //push the wave data to the array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // generate new seed for each new user that waves
        seed = (block.timestamp + block.difficulty + seed) % 100;
        console.log("Random # generated: %d", seed);

        // give user 30% chance of winning d prize
        if(seed <= 30){
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            //check if SC's balance is greater prize amount
            require(
                prizeAmount <= address(this).balance, 
                "Trying to withdraw more money than the contract has."
            );
            // try to send amount to sender and return status value to bool variable success
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");

        }

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