// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    // public
    // callable in/out contract

    // external (внешний)
    // callable outside contract
    // for example callable from frontend or wallets

    // internal (внутренний)
    // callable from inside contract only or inheritor contracts

    // private
    // callable inside contract only. child contracts have no access


    // CALL functions
    // view - read only without modif (callable with call() - free for using)
    // pure - same view but cant read state variables (blockchain data)

    // naming functions with mixed case

    // expliced
    function getBalanceExpliced() public view returns(uint){
        return address(this).balance;
    }
    //or  Impliced
    function getBalanceImpliced() public view returns(uint balance){
        balance = address(this).balance;
        return balance;
    }

    string message = "hello!"; // state

    function getMessage() external view returns(string memory) {
        return message;
    }

    function rate(uint amount) external pure returns(uint) {
        return amount * 3;
    }


    // TRANSACTION functions
    // returns - nothing. Decoded output anytime is empty
    // shuld use EVENTS for return data from transaction
    function setMessage(string memory newMessage) external {
        message = newMessage;
    }

    // PAYABLE modifer.
    // it let to use msg.value and increase contract balance
    uint public balance;

    function pay() external payable {
        balance += msg.value;
    }

    // just recive amount to balance
    // used when sender not set call function
    receive() external payable {
        //any actions
    }

    // will be call if sender call non-existent function
    fallback() external payable {

    }
}