//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Интерфейс
// Содержит список методов контракта. Все методы обязательно external,
// даже если в коде контракта у методов были другие модификаторы доступа

interface ILogger {
    function log(address _from, uint _amount) external;

    function getEntry(address _from, uint _index) external view returns(uint);
}