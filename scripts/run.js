

const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();// get total waves
    console.log(waveCount)

    let waveTxn = await waveContract.wave("A message");// call d wave function in our smart contract
    await waveTxn.wait();// wait for the txn to be mined

    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn = await waveContract.connect(randomPerson).wave("Another message!");// call d wave fn but this time using a random user gen address
    await waveTxn.wait();

    let allWaves = await waveContract.getAllWaves()
    console.log(allWaves)

};


const runMain = async () => {
    try {
        await main();
        process.exit(0); // exit Node process without error
    } catch (error) {
        console.log(error);
        process.exit(1); // exit Node process while indicating 'uncaught fatal Exception' error
    }
};

runMain();