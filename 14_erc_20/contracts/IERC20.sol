//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IERC20 {
    function name() external view returns(string memory);
    
    function symbol() external view returns(string memory);
    
    // количество знаков после ,
    // 18 - соответствие 1 wei
    function decimals() external pure returns(uint);

    // Количество токенов в обороте
    function totalSupply() external view returns(uint);

    // Узнать количество токенов на аккаунте
    function balanceOf(address account) external view returns(uint);

    // пересылка токенов по адресу
    // пересылка с кошелька инициатора транзакции на некоторый адрес
    function transfer(address to, uint amount) external;

    // Владелец кошелька позволяет забрать у владельца забрать X количество токенов в пользу некоторого аккаунта
    // Проверить может ли сторонний аккаунт списать с моего аккаунта в чью-то пользу
    function allowance(address _owner, address spender) external view returns(uint);

    // Метод позволяет подтверждать операции allowance()
    function approve(address spender, uint amount) external;

    // Операция списания с моего аккаунта в пользу 3 лица X количества токенов
    function transferFrom(address sender, address recipient, uint amount) external;

    event Transfer(address indexed from, address indexed to, uint amount);

    event Approve(address indexed owner, address indexed to, uint amount);
}