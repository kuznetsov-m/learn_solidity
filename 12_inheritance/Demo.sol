//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Ownable.sol";

abstract contract Balances is Ownable{
    function getBalance() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

    // override - override parrent method
    function withdraw(address payable _to) public override virtual onlyOwner {
        _to.transfer(address(this).balance);
    }
}

// Example 1
// contract MyContract is Ownable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), Balances {
// }

// Example 2
// contract MyContract is Ownable, Balances {
//     constructor() Ownable(msg.sender){
//     }
// }

// Example 3
// contract MyContract is Ownable, Balances {
//     constructor(address _owner) Ownable(_owner) {

//     }
// }

// Example 4
// contract MyContract is Ownable, Balances {
//     constructor(address _owner) {
//         // overide variables from parrent contract
//         // not best practice
//         owner = _owner;
//     }
// }

contract MyContract is Ownable, Balances {
    constructor(address _owner) {
        owner = _owner;
    }

    function withdraw(address payable _to) public override(Ownable, Balances) onlyOwner {
        // call parent method
        // Balances.withdraw(_to);
        
        // or

        // super - go up ONE level of inheritance and call the medod
        // super = Balances
        super.withdraw(_to);

        // not same
        // Ownable.withdraw(_to);
    }
}