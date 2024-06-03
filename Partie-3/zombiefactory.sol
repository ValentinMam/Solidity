// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

// 1.	Modifiez notre code pour import le contenu de ownable.sol. Si vous ne vous rappelez plus comment faire, regardez zombiefeeding.sol.
import "./ownable.sol";
// 2.	Modifiez le contrat ZombieFactory pour qu'il hérite de Ownable. Pareillement, regardez zombiefeeding.sol si vous ne vous rappelez plus comment faire.

contract ZombieFactory is Ownable {
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;

    function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
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
