// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    // require
    // revert
    // assert

    address owner;

    constructor() {
        owner = msg.sender;
    }

    // indexed - for serching events in events jornal
    // 3 indexed max
    event Paid(address indexed _from, uint _amount, uint _timestamp);

    function pay() public payable {
        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(address payable _to) external {
        require(msg.sender == owner, "You are not an owner");
        //or
        if (msg.sender != owner) {
            revert("You are not an owner");
        }

        // error - panic type
        // just condition checking without error message
        // assert(msg.sender != owner);

        _to.transfer(address(this).balance);
    }

    modifier onlyOwner(address _to) {
        require(msg.sender == owner, "You are not an owner");
        require(_to != address(0), "incorrect address!");
        _;
        //require()
    }

    function withdrawWithModifier(address payable _to) external onlyOwner(_to) {
        _to.transfer(address(this).balance);
    }

    receive() external payable {
        pay();
    }
}