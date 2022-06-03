//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Ownable {
    address public owner;
    
    // Example 1-2
    // constructor(address ownerOverride) {
    //     owner = ownerOverride == address(0) ? msg.sender : ownerOverride;
    // }

    // Example 3-4
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "not an owner");
        _;
    }

    // virtual - allows method to be overridden in child contracts
    function withdraw(address payable _to) public virtual onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

}