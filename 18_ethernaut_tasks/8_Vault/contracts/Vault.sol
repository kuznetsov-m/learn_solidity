// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    // 0 slot
    bool public locked;
    // 1 slot
    bytes32 private password;

    constructor(bytes32 _password) {
        locked = true;
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
           locked = false;
        }
    }
}