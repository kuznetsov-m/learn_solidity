# Project creation
```
npx hardhat
Create an advanced sample project that uses TypeScript

npm install --save-dev hardhat-deploy                         

# rename config
mv hardhat.config.js hardhat.config.ts
```

# Hardhat tasks
https://hardhat.org/guides/create-task

Hardhat have tasks, example, `clean`. You can create custom task inside file `hardhat.config.ts` or create new file, for example `tasks/sample_tasks.ts`. For using custom tasks from file, you must import file to `hardhat.config.ts`.

# New task
`tasks/sample_tasks.ts`

```
import { task } from 'hardhat/config';

task("balance", "Display balance")
    .setAction(async (taskArgs) => {
        console.log(taskArgs);
    })
```
`balance` task created!
```
npx hardhat   # Check task list
npx hardhat help balance    # help
```

# Typechain
```
# install
npm install --save-dev typechain @typechain/hardhat @typechain/ethers-v5

# creation typechain
npx hardhat typechain
```

# Usage
```
# Compile contract and generate typechain
npx hardhat compile

npx hardhat node
npx hardhat run scripts/deploy.js --network localhost

# call tasks:
npx hardhat callme --contract 0x5FbDB2315678afecb367f032d93F642f64180aa3 --account user --network localhost
npx hardhat pay --value 3000 --account user --network localhost         
npx hardhat distribute --network localhost
```

# Links and Notes
https://www.youtube.com/watch?v=h8i1hfeGDAA

https://github.com/dethcrypto/TypeChain/tree/master/packages/hardhat#installation

`npm i` install all dependencies from package.json dependancy list 