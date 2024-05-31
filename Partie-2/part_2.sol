// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // Pour savoir à qui appartient un zombie. Nous allons utiliser 2 mappages
    // un qui va stocker l'adresse associée à un zombie, et l'autre qui va stocker combien de zombies un utilisateur possède.
    // 1.	Créez un mappage appelé zombieToOwner. La clé est un uint (nous stockerons et rechercherons le zombie avec son id) et la valeur est une address.
    // Ce mappage sera public.
    // 2.	Créez un mappage appelé ownerZombieCount, où la clé est une address et la valeur un uint.
    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
