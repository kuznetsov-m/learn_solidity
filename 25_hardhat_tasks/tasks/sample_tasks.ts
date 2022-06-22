import { task, types } from 'hardhat/config';
import { Demo } from '../typechain';
import { Demo__factory } from '../typechain';

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
    const accounts = await hre.ethers.getSigners();
  
    for (const account of accounts) {
      console.log(account.address);
    }
  });

// 0x5FbDB2315678afecb367f032d93F642f64180aa3


task("balance", "Display balance")
    .addParam('account', 'Account address')
    .addOptionalParam('greeting', 'Greeting to print', 'Default greeting', types.string)
    // hre - hardhat runtime envirenment
    // .setAction(async (taskArgs, hre) => {
    .setAction(async (taskArgs, { ethers }) => {
        // console.log(taskArgs);

        const account = taskArgs.account;
        const msg = taskArgs.greeting;
        console.log(msg);

        const balance = await ethers.provider.getBalance(account);
        // const balance = await hre.ethers.provider.getBalance(account);

        console.log(balance.toString());

        // console.log(accounts);
    });

task('callme', 'Call demo func')
    .addParam('contract', 'Contract address')
    .addOptionalParam('account', 'Account name', 'deployer', types.string)
    .setAction(async (taskArgs, { ethers, getNamedAccounts }) => {
        const account = (await getNamedAccounts())[taskArgs.account];
        // console.log(account);

        const demo = await Demo__factory.connect(
            taskArgs.contract,
            await ethers.getSigner(account)
        );
        
        console.log(await demo.callme());
    });

task('pay', 'Call pay func')
    .addParam('value', 'Value to send', 0, types.int)
    .addOptionalParam('account', 'Account name', 'deployer', types.string)
    .setAction(async (taskArgs, { ethers, getNamedAccounts }) => {
        const account = (await getNamedAccounts())[taskArgs.account];
        console.log('Account:', account)

        const demo = await ethers.getContract<Demo>('Demo', account);
        console.log('Demo address:', demo.address)
    
        const tx = await demo.pay(`Hello from ${account}`, {value: taskArgs.value});
        await tx.wait();
    
        console.log(await demo.message());
        console.log((await ethers.provider.getBalance(demo.address)).toString());
    });

task('distribute', 'Distribute funds')
    // .addParam('addresses', 'Addresses to distribute')
    .setAction(async (taskArgs, { ethers }) => {
        const demo = await ethers.getContract<Demo>('Demo');
    });