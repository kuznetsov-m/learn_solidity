import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-deploy";
import "hardhat-gas-reporter";
import "solidity-coverage";

// custom tasks
import './tasks/sample_tasks'

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.13",
  networks: {
    // ropsten: {
    //   url: process.env.ROPSTEN_URL || "",
    //   accounts:
    //     process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    // },
    hardhat: {
      chainId: 1337
    }
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS ? true :false,
    coinmarketcap: process.env.COINMARKET_CAP_KEY,
    currency: "USD",
    // outputFile: 'gas-reporter.txt'
  },
  // etherscan: {
  //   apiKey: process.env.ETHERSCAN_API_KEY,
  // },
  
  // именованные аккаунты. Нумерация hardhat test аккаунтов (20 шт)
  namedAccounts: {
    deployer: 0,
    user: 1,
  },
  // typechain: {
  //   outDir: 'typechain-types',
  //   target: 'ethers-v5',
  // },
};

export default config;
