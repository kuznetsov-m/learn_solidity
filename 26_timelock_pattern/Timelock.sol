// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Timelock {
    uint constant MIN_DELAY = 10;
    uint constant MAX_DELAY = 1 days;
    uint constant GRACE_PERIOD = 1 days;
    address public owner;
    string public message;
    uint public amount;

    mapping(bytes32 => bool) public queue;

    event Queued(bytes32 indexed txId);
    event Executed(bytes32 txId);
    event Discarded(bytes32 indexed txId);

    modifier onlyOwner() {
        require(msg.sender == owner, "not an ;owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function demo(string calldata _msg) external payable {
        message = _msg;
        amount = msg.value;
    }

    function getNextTimestamp() external view returns(uint) {
        return block.timestamp + 60;
    }

    function prepareData(string calldata _msg) external pure returns(bytes memory) {
        return abi.encode(_msg);
    }

    function addToQueue(
        address _to,
        string calldata _func,
        bytes calldata _data,
        uint _value,
        uint _timestamp
    ) external onlyOwner returns(bytes32) {
        // возвращает идентификатор транзакции поставленной в очередь
        
        require(
            _timestamp > block.timestamp + MIN_DELAY &&
            _timestamp < block.timestamp + MAX_DELAY,
            "invalid timestamp"
        );

        bytes32 txId = keccak256(abi.encode(
            _to,
            _func,
            _data,
            _value,
            _timestamp
        ));

        require(!queue[txId], "already queued");

        queue[txId] = true;

        emit Queued(txId);

        return txId;
    }

    function execute(
        address _to,
        string calldata _func,
        bytes calldata _data,
        uint _value,
        uint _timestamp
    ) external payable onlyOwner returns(bytes memory) {
        require(
            block.timestamp > _timestamp,
            "to early"
        );
        require(
            _timestamp + GRACE_PERIOD > block.timestamp,
            "tx expired"
        );

        bytes32 txId = keccak256(abi.encode(
            _to,
            _func,
            _data,
            _value,
            _timestamp
        ));

        require(queue[txId], "not queuted!");

        delete queue[txId];

        bytes memory data;
        if(bytes(_func).length > 0) {
            data = abi.encodePacked(
                bytes4(keccak256(bytes(_func))),
                _data
            );
        } else {
            data = _data;
        }

        (bool success, bytes memory resp) = _to.call{value: _value}(data);
        require(success);

        emit Executed(txId);
        return resp;
    }

    function discard(bytes32 _txId) external onlyOwner {
        require(queue[_txId], "not queued");

        delete queue[_txId];

        emit Discarded(_txId);
    }
}