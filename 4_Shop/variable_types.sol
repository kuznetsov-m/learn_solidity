// SPDX-License-Identifier: MIT

// https://www.youtube.com/watch?v=alK0PY-Qa4Q

pragma solidity ^0.8.0;

contract Demo {
    bool public myBool; // state (default value: false)

    function myFunction(bool _inputBool) public {
        // local tmp vatiable
        bool localBool = false;

        localBool && _inputBool;
        localBool || _inputBool;
        localBool == _inputBool;
        localBool != _inputBool;
        !localBool;

        if (localBool || _inputBool) {}
    }

    // ----------------------
    // unsigned integers
    // default value: 0
    uint public myUint = 42; // or uint256
    function demo(uint _inputUint) public {
        uint localUint = 42;
    }

    // 2 ** 8 = 256
    // 0 -- (256-1)
    uint8 public mySmallestUint = 2;
    //uint16 24 32 ... 256


    // signed intagers
    int256 public myInt = -42;
    int8 public mySmallInt = -1;
    // 2 ** 7 = 128
    // -128 -- (128-1)

    uint public minimum;
    uint public maximum;

    function demo() public {
        minimum = type(uint8).min;
        maximum = type(uint8).max;
    }



    // ---------------
    uint8 public myVal = 254;

    function inc() public {
        // unchecked: 254 -> 255 -> error
        // myVal += 1;
        
        // unchecked: 254 -> 255 -> 0 -> 1
        unchecked {
            myVal++;
        }
    }
}

// ---------------------------

contract Demo2 {
    string public myStr = "test"; // storage
    mapping (address => uint) public payments;  // storage

    function demo(string memory newValueStr) public {
        string memory myTempStr = "temp";

        myStr = newValueStr;
    }

    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function getBalance(address targetAddr) public view returns(uint){
        return targetAddr.balance;
    }

    function reciveFunds() public payable {
        payments[msg.sender] = msg.value;
    }

    function transferTo(address targetAddr, uint amount) public {
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }
}