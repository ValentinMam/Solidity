// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

// 1.	Modifiez notre code pour import le contenu de ownable.sol. Si vous ne vous rappelez plus comment faire, regardez zombiefeeding.sol.
import "./ownable.sol";
// 2.	Modifiez le contrat ZombieFactory pour qu'il hérite de Ownable. Pareillement, regardez zombiefeeding.sol si vous ne vous rappelez plus comment faire.

contract ZombieFactory is Ownable {
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    // 1.	Déclarez un uint appelé cooldownTime égal à 1 days. (si vous la mettez égale à "1 day", cela ne compilera pas !)
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        // 1.	Ajoutez deux propriétés à notre structure Zombie : level (un uint32), et readyTime (aussi un uint32).
        // Nous voulons emboîter ces types de données ensemble, pour cela mettez-les à la fin de la structure.
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;

    function _createZombie(string _name, uint _dna) internal {
        // 2.	Vu que nous avons ajouté level et readyTime à notre structure Zombie dans le chapitre précédent, nous devons mettre à jour _createZombie() pour utiliser le bon nombre d'arguments quand nous créons une nouvelle structure Zombie.
        // Mettez à jour la ligne de code zombies.push en ajoutant 2 arguments : 1 (pour level), et uint32(now + cooldownTime) (pour readyTime).
        // Remarque : Le uint32(...) est nécessaire car now renvoie un uint256 par défaut. nous devons donc le convertir en un uint32.
        // now + cooldownTime sera égal à l'horodatage unix actuel (en secondes) plus le nombre de secondes d'un jour - qui sera égal à l'horodatage unix dans 24h.
        // Plus tard, nous pourrons comparer si le readyTime du zombie est supérieur à now pour voir si assez de temps s'est écoulé pour utiliser le zombie à nouveau.
        uint id = zombies.push(
            Zombie(_name, _dna, 1, uint32(now + cooldownTime))
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
