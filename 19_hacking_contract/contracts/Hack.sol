//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Hack {
    bytes32 private immutable pwd2;
    address private factory;
    uint24 public nonce;
    bytes32 private pwd1;

    // constructor() {
    constructor(bytes32 _pwd1) {
        // pwd1 = 0xa097646de778accb462d6593c18082346d3f3cd355fe8cbf6f1b3551b5c6044d;
        pwd1 =_pwd1;
        pwd2 = 0x5f668062be9682387cd8957f8339033192b55962f2280292c705e5811dd8df8a;
        factory = 0x1F98431c8aD98523631AE4a59f267346ea31F984;
    }

    function _hash(uint256 value) internal returns (bytes32) {
        uint256 seed = block.timestamp + block.gaslimit + block.difficulty + uint256(uint160(msg.sender)) + value;
        bytes memory b = new bytes(32);
        uint256 n = nonce + 1;
        assembly {
            seed := mulmod(seed, seed, add(n, 0xffffff))
            let r := 1
            for { let i := 0 } lt(i, 5) { i := add(i, 1) } 
            {
                r := add(r, div(seed, r))
                mstore(add(b, 0x20), r)
                r := keccak256(add(b, 0x20), 0x20)                
            }
            mstore(add(b, 0x20), r)
        }
        nonce += 1;
        return keccak256(b);
    }

    function setNonce(uint24 _nonce) external {
        nonce = _nonce;
    }

    function calcSecret1() public returns(bytes32) {
        uint256 secret;
        address f = factory;
        uint256 n = nonce;
        bytes memory data = abi.encodePacked(bytes4(0x22afcccb), uint256(3000));
        bytes memory buffer = new bytes(32);
        assembly {
            // загрузка данных из storage (slot 0: переменная pwd2) в локальную переменную secret
            secret := sload(0x0)
            let bufref := add(buffer, 0x20)
            pop(call(gas(), f, 0, add(data, 0x20), 0x24, bufref, 0x20))
            let y := mload(bufref)
            mstore(bufref, add(add(secret, y), n))
            secret := keccak256(bufref, 0x20)  
        }
        return bytes32(secret);
    }    

    function calcSecret2_3(bytes32 secret, uint _nonce) public pure returns(bytes32) {
        return keccak256(abi.encode(secret, _nonce));
    }

    function attack(address toHack) public {
        (bool success, ) = toHack.call(
            abi.encodeWithSignature(
                "submitApplication(string,bytes32,bytes32,bytes32)",
                "kuznetsov-m.github.io, publicKM@yandex.ru, Hi, there :)",
                calcSecret1(),
                calcSecret2_3(pwd1, uint(nonce + 1)),
                calcSecret2_3(pwd2, uint(nonce + 2))
            )
        );
        require(success == true, "unsuccess");
    }

    function attack1(address toHack) public {
        (bool success, ) = toHack.call(
            abi.encodeWithSignature(
                "secret1(bytes32)",
                calcSecret1()
            )
        );
        require(success == true, "unsuccess");
    }

    function attack2(address toHack) public {
        (bool success, ) = toHack.call(
            abi.encodeWithSignature(
                "secret2(bytes32)",
                calcSecret2_3(pwd1, uint(nonce + 1))
            )
        );
        require(success == true, "unsuccess");
    }

    function attack3(address toHack) public {
        (bool success, ) = toHack.call(
            abi.encodeWithSignature(
                "secret3(bytes32)",
                calcSecret2_3(pwd2, uint(nonce + 2))
            )
        );
        require(success == true, "unsuccess");
    }
}