// pragma solidity ^0.8.0;  // set min solidity version 
pragma solidity >0.8.0 < 0.9.0;

contract Marketplace {
    // State variable
    // public / internal / private
    uint price;

    address public seller;

    // Function
    // public / private / internal / external
    function buy(uint price) public returns (uint) {
        //...
    }

    // Modifier
    // for checking require before function execution
    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can put an item up for sale");
        _; // function will be here, after require()
    }

    // pure — function not use state
    // view — state readonly 
    // payable -
    function listItem() public view onlySeller {
        // ...
    }

    // Event
    // write transaction on blockchain
    event PurchasedItem(address buyer, uint price);

    function buy2(uint price) payable public {
        //...
        emit PurchasedItem(msg.sender, msg.value);
    }
}

contract BaseTypes {
    // Value types
    // int, bool, string, address, enum

    // int
    // int: 8-256 bit, default - 256 bit
    int32 price2 = 25; // signed 32 bit intager
    uint256 balance = 1000; // unsigned 256 bit integer
    // balance - price; // 975
    // 2 * price; // 50
    // price % 2; // 1

    bool forSale; //true if an item is for sale
    bool purchased; //true if an item has been purchased

    function buy(int price) public returns (bool success) {
        // ...
    }

    // string
    String shipped = "shipped"; // shipped
    String delivered = 'delivered'; // delivered
    String newItem = "newItem"; // newItem

    // address
    // 20 byte (160 bit)
    // Ethereum account
    // address payable - address for transfer ethereum
    address payable public seller; // account for the seller
    address payable public buyer; // account for the user

    function transfer(address buyer, uint price) public {
        buyer.transfer(price); // the transfer member transfers the price of the item
    }

    // enum
    enum Status {
        Pending,
        Shipped,
        Delivered
    }

    Status public status;

    constructor() public {
        status = Status.Pending;
    }
}

contract C {
    // ---------------
    // Reference types
    // struct, array, mapping
    // create autonomous data copy

    // locations:
    // - memory (location: function arguments; life cycle: callback function live )
    // - storage (location: state variables; life cycle = contract live)
    // - calldata (like memory; need for outside functions parameters)

    uint[] x;
    
    function g(uint[] storage) internal pure {}
    function h(uint[] memory) public pure {}

    // the data location of values is memory
    function buy(uint[] memory values) public {
        x = values; // copies array to storage
        uint[] storage y = x; //data location of y is storage
        g(x); // calls g, handing over reference to x
        h(x); // calls h, and creates a temporary copy in memory
    }

    // array
    uint[] itemIds; // Declare a dynamically sized array called itemIds
    uint[3] prices = [1, 2, 3]; // initialize a fixed size array called prices, with prices 1, 2, and 3
    uint[] prices2 = [1, 2, 3]; // same as above

    // Create a dynamic byte array
    bytes32[] itemNames;
    itemNames.push(bytes32("computer")); // adds "computer" to the array
    itemNames.length; // 1

    // struct
    struct Items_Schema {
        uint256 _id;
        uint256 _price;
        string _name;
        string _description;
    }

    // mapping
    uint256 item_id = 0;

    mapping(uint256 => Items_Schema) public items;

    struct Items_Schema {
        uint256 _id:
        uint256 _price:
        string _name;
    }

    function listItem(uint256 memory _price, string memory _name) public {
        item_id += 1;
        item[vehicle_id] = Items_Schema(item_id, _price, _name);
    }

}