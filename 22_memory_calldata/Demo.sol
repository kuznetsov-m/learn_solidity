// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    // function work(string memory _str) external pure returns(bytes32 data){
    //     // пробуем обратиться в free memory pointer
    //     assembly {
    //         // читаем указатель на free memory
    //         // если _str == "test" то ptr = 192
    //         let ptr := mload(64)
    //         // значит в слоте 192 - 32 лежит "test"
    //         data := mload(sub(ptr, 32))
    //     }

    //     // вернет
    //     // 0x7465737400000000000000000000000000000000000000000000000000000000

    //     // > ethers.utils.parseBytes32String('0x7465737400000000000000000000000000000000000000000000000000000000')
    //     // > 'test'
    // }

    function work2(uint[3] memory _arr) external pure returns(bytes memory){
    //     return msg.data; // calldata
    //     // возвращает:
    //     // 0xfb142e3b000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003
        
    //     // 0xfb142e3b          <- сетектор функции (4 байта)
    //     //   0000000000000000000000000000000000000000000000000000000000000001
    //     //   0000000000000000000000000000000000000000000000000000000000000002
    //     //   0000000000000000000000000000000000000000000000000000000000000003
        // вернуть только первые 4 байта - селектор
        return bytes(msg.data[0:4]);
    }

    function selector() external pure returns(bytes4) {
        // в сигнатуре явно указывать используемый тип данных, например не uint, а uint256
        return bytes4(keccak256(bytes("work2(uint256[3])")));
    }

    function work3(uint[3] calldata _arr) external pure returns(bytes32 _el1){
        assembly {
            // 0-3 байты - занимает селектор
            _el1 := calldataload(4)
        }

        // вернет:
        // bytes32: _el1 0x0000000000000000000000000000000000000000000000000000000000000001
    }

    // со строками несколько сложнее:
    // _str=="test"
    function work4(string calldata _str) external pure returns(bytes32 _el3){
        assembly {
            // 0-3 байты - занимает селектор
            let _el1 := calldataload(4)
            // 0x0000000000000000000000000000000000000000000000000000000000000020
            // 0x20 == 32
            // значит через 32 байта начало строки
            
            let _el2 := calldataload(add(4, 32))
            // 0x0000000000000000000000000000000000000000000000000000000000000004
            // указыват длинну строки 4 байта (латинский алфавит)
            // эта перменная еще 32 байта

            _el3 := calldataload(add(add(4, 32), 32))
            // 0x7465737400000000000000000000000000000000000000000000000000000000
        }

        // > ethers.utils.parseBytes32String('0x7465737400000000000000000000000000000000000000000000000000000000')
        // > 'test'
    }

    // массив
    function work5(uint[] calldata a) external pure returns (
        bytes32 _startIn, bytes32 _elCount, bytes32 _el1
    ) {
        assembly {
            _startIn := calldataload(4)
            _elCount := calldataload(add(_startIn, 4))
            _el1 := calldataload(add(_startIn, 36))
        }
    }
}