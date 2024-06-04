// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "./ownable.sol";

contract ZombieFactory is Ownable {
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        // 1.	Modifiez la structureZombie en lui ajoutant 2 propriétés :
        //      a. winCount, un uint16
        //      b. lossCount, aussi un uint16
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;

    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;

    // 2.	Maintenant que nous avons de nouvelles propriétés pour notre structure Zombie,
    // nous devons changer la définition de notre fonction _createZombie().
    // Changez la définition de création de zombie pour que chaque nouveau zombie créé est 0 victoire et 0 défaite.

    function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(
            Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)
        ) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - (randDna % 100);
        _createZombie(_name, randDna);
    }
}
