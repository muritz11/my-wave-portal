

const main = async () => {
    const [owner, jneDoe] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();// get total waves

    let waveTxn = await waveContract.wave();// call d wave function
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();// get total waves again

    waveTxn = await waveContract.connect(jneDoe).wave();// call d wave fn but this time using a random user gen address
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();
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