// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Payments {
    // Struct
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        // payments count => payment
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function pay(string memory message) public payable {
        uint paymentNumber = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNumber] = newPayment;
    }

    // Get payment info
    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }

    // Current balance of smart contract
    function currentBalance() public view returns(uint) {
        return address(this).balance;
    }

    // withdraw all funds from contract to caller ballance
    function withdrawAll() public payable {
        payable(msg.sender).transfer(address(this).balance);
    }
}