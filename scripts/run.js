
// because it's hard to test our SC with the frontend code
// run.js is where we test out our SC to make sure everything is working fine before deploying
const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1") // deploy contract and fund with 0.1 ether
    });
    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);

    // get contract balance
    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
    console.log('contract balance: ', hre.ethers.utils.formatEther(contractBalance))

    let waveCount;
    waveCount = await waveContract.getTotalWaves();// get total waves
    console.log(waveCount)

    let waveTxn = await waveContract.wave("This is wave #1");// call d wave function in our smart contract
    await waveTxn.wait();// wait for the txn to be mined
    
    let waveTxn2 = await waveContract.wave("This is wave #2");
    await waveTxn2.wait();
    
    // get contract balance
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
    console.log('contract balance: ', hre.ethers.utils.formatEther(contractBalance))


    // const [_, randomPerson] = await hre.ethers.getSigners();
    // waveTxn = await waveContract.connect(randomPerson).wave("Another message!");// call d wave fn but this time using a random user gen address
    // await waveTxn.wait();

    // let allWaves = await waveContract.getAllWaves()
    // console.log(allWaves)

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