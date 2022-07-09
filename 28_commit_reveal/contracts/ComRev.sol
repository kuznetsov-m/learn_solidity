// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ComRev {
    address[] public candidates = [
        0xdAC17F958D2ee523a2206206994597C13D831ec7,
        0x4Fabb145d64652a948d72533023f6E7A623C7C53,
        0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
    ];

    // голоса
    // отправитель => хеш голоса
    mapping(address => bytes32) public commits;
    // хранит колличество голосов за каждого кандидата
    mapping(address => uint) public votes;
    bool votingStopped;
    // '0x893e8877732536ee0d8d6643f83863fa374781deeda9a3328cf6ff4be6df45bc'

    // принимает голос в виде хеша с frontend
    // keccak256(abi.encodePacked())
    function commitVote(bytes32 _hashedVote) external {
        require(!votingStopped);
        require(commits[msg.sender] == bytes32(0));

        commits[msg.sender] = _hashedVote;
    }

    // reveal
    // Раскрытие голоса происходит при вызове метода одним из проголосовавших пользователей
    // на основе передаваемых данных в метод - должны соответствовать данным
    // записанным при голосовании
    function revealVote(address _candidate, bytes32 _secret) external {
        require(votingStopped);

        bytes32 commit = keccak256(abi.encodePacked(_candidate, _secret, msg.sender));
        
        require(commit == commits[msg.sender]);

        delete commits[msg.sender];

        votes[_candidate]++;
    }

    // TODO: onlyOwner
    function stopVoting() external  {
        require(!votingStopped);

        votingStopped = true;
    }
}