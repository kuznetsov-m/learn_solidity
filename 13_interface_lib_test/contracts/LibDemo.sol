//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Ext.sol";

// Контракт пример использования библиотеки
contract LibDemo {
    // Конструкция using расширяет тип данных. Добавляет методы, описанные в library
    using StrExt for string;
    using ArrayExt for uint[];

    function runnerArr(uint[] memory numbers, uint number) public pure returns(bool) {
        return numbers.inArray(number);
    }

    function runnerStr(string memory str1, string memory str2) public pure returns(bool) {
        return str1.eq(str2);
        //or
        //return StrExt.eq(str1, str2);
    }
}