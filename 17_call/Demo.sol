// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {
    address otherContract;
    // event Responce(bytes responce);
    event Responce(string responce);

    constructor(address _otherContract) {
        otherContract = _otherContract;
    }

    function callReceive() external payable {
        (bool success, ) = otherContract.call{value: msg.value}("");
        require(success, "cant send funds!");
    }

    function callSetName(string calldata _name) external {
        (bool success, bytes memory responce) = otherContract.call(
            // если нет исходного кода контракта
            //abi.encodeWithSignature("setName(string)", _name)
            // or
            // если есть исходный код вызываемого контракта
            abi.encodeWithSelector(AnotherContract.setName.selector, _name)
        );

        require(success, "cant set name");

        emit Responce(abi.decode(responce, (string)));
    }
}

contract AnotherContract {
    string public name;
    mapping(address => uint) public balances;

    // function setName(string calldata _name) external returns(bool){
    function setName(string calldata _name) external returns(string memory){
        name = _name;
        // return true;
        return name;
    }

    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}