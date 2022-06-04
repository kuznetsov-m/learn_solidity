//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Контракту добавляется наследование от интерфейса
// (не обязательное действие)
import "./ILogger.sol";

// При наследовании от ILogger возникает ошибка:
// TypeError: Overriding function is missing "override" specifier.
// contract Logger is ILogger {
// убрал наследование
contract Logger {
    mapping(address => uint[]) payments;

    function log(address _from, uint _amount) public {
        require(_from != address(0), "zero address");

        payments[_from].push(_amount);
    }

    function getEntry(address _from, uint _index) public view returns(uint) {
        return payments[_from][_index];
    }
}