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
        // Mettons à jour notre fonction _createZombie de la leçon 1 pour désigner comme propriétaire d'un zombie celui qui appellerait cette fonction.
        // 1.	Après avoir récupéré l'id du nouveau zombie, mettons à jour notre mappage zombieToOwner pour stocker msg.sender sous cet id.
        // 2.	Ensuite, augmentons notre ownerZombieCount pour ce msg.sender.
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        // Dans notre jeu de zombie, nous ne voulons pas qu'un utilisateur puisse créer une infinité de zombie pour son armée en appelant continuellement createRandomZombie - le jeu ne serait pas très amusant.
        // Nous allons utiliser require pour être sur que la fonction s'exécute seulement une fois par utilisateur, quand il crée son premier zombie.
        // 1.	Ajouter une déclaration require au début de createRandomZombie.
        // La fonction devra vérifier que ownerZombieCount[msg.sender] soit égal à 0, et renvoyer une erreur au cas contraire.
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
