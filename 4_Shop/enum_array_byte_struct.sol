pragma solidity ^0.8.0;

// array, bytes, enum, struct

contract Demo {
    // Enum
    enum Status {       // uint
        Paid,           // 0
        Delivered,      // 1
        Received        // 2
    }

    Status public currentStatus;

    function pay() public {
        currentStatus = Status.Paid;
    }

    function delivered() public {
        currentStatus = Status.Delivered;
    }

    // Array
    uint[10] public items = [1, 2, 3];
    string[5] public stringsArray;

    function demo() public {
        items[0] = 100;
        items[1] = 200;
        items[2] = 500;
    }

    uint[3][2] public nestedArray;

    function demo2() public {
        nestedArray = [
            [3, 4, 5],
            [6, 7, 8]
        ];
    }

    // dynamic array
    uint[] public dynamicArray;
    uint public len;

    function demo3() public {
        dynamicArray.push(4);
        dynamicArray.push(5);
        len = dynamicArray.length;
    }

    function sampleMemory() public view returns(uint[] memory){
        // 10 - nested array length
        uint[] memory tempArray = new uint[](10); 
        tempArray[0] = 1;
        return tempArray;
    }

    // Byte (Array)
    bytes1 public myVar;
    // 1 -- 32 bytes
    // 32 bytes * 8 bit = 256 bit       uint256

    bytes32 public myBytes = "test";

    bytes public dynamicBytes = "test len = 12";
    function dynamicBytesLength() public view returns(uint) {
        return dynamicBytes.length;
    }

    // value: 0xd18ed0bdd0b8d0bad0bed0b420d181d182d180d0bed0bad0b0
    bytes public dynamicBytesWithUnicode = unicode"юникод строка";
    // returned: 25
    function dynamicBytesWithUnicodeLength() public view returns(uint) {
        return dynamicBytesWithUnicode.length;
    }

    // Struct
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        // payments count => payment
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function pay(string memory message) public payable {
        uint paymentNumber = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNumber] = newPayment;
    }

    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }
}