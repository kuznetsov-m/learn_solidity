# Console usage

```
> truffle migration
> truffle console
truffle(development)> var hw
undefined
truffle(development)> HelloWorld.deployed().then(function(d){hw = d;});
undefined
truffle(development)> hw.setUserName("KM")
{
  tx: '0x350f4026b0ea1e33b4260816a58a9f9d73b7707e07eb0123a7f69eda0947d728',
  receipt: {
    transactionHash: '0x350f4026b0ea1e33b4260816a58a9f9d73b7707e07eb0123a7f69eda0947d728',
    transactionIndex: 0,
    blockNumber: 5,
    blockHash: '0x6b4e900d0bfc9bef56ab1c72b903f33c94e3639ee9ec71cafa95dfa844094562',
    from: '0x633baa005c8ff4bebd4b4eb50afb9aa2c6188e59',
    to: '0x7955f040f7db53a70e9bf70d289c20770eb5f395',
    cumulativeGasUsed: 44946,
    gasUsed: 44946,
    contractAddress: null,
    logs: [],
    logsBloom: '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
    status: true,
    effectiveGasPrice: '0xb3cbde64',
    type: '0x2',
    rawLogs: []
  },
  logs: []
}
truffle(development)> hw.printMessage.call()
'Hello KM!'
truffle(development)> 
```

# Test

```
truffle test
Using network 'development'.


Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.


  Contract: HelloWorld
    1) should print out hello
    > No events were emitted


  0 passing (65ms)
  1 failing

  1) Contract: HelloWorld
       should print out hello:

      should print out hello to entered name
      + expected - actual

      -Hello !
      +Hello KM!
      
      at /Users/user/solidity-project/2/test/HelloWorld.test.js:9:11
      at processTicksAndRejections (node:internal/process/task_queues:96:5)


```

# Links
(https://github.com/ahmetozlu/smart_contract_helloworld)[https://github.com/ahmetozlu/smart_contract_helloworld]