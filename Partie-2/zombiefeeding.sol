// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

// Maintenant que nous avons une structure avec plusieurs fichiers,
// nous allons avoir besoin d'utiliser import pour lire le contenu de l'autre fichier :
// 1.	Importer zombiefactory.sol dans notre nouveau fichier zombiefeeding.sol.

import "./zombiefactory.sol";

// Dans les prochains chapitres, nous allons implémenter les fonctionnalités pour nourrir et multiplier nos zombies.
// Mettons cette logique dans sa propre classe qui hérite de toutes les méthodes de ZombieFactory.
// 1.	Créez un contrat nommé ZombieFeeding en dessous de ZombieFactory. Ce contrat devra hériter de notre contrat ZombieFactory.

contract ZombieFeeding is ZombieFactory {
    // Il est temps de donner à nos zombies la capacité de se nourrir et de se multiplier !
    // Quand un zombie se nourri d'une autre forme de vie, son ADN se combine avec l'autre forme de vie pour créer un nouveau zombie.
    // 1.	Créez une fonction appelée feedAndMultiply qui aura deux paramètres : _zombieId (un uint) et _targetDna (aussi un uint).
    // Cette fonction devra être public.
    // 2.	Nous ne voulons pas que d'autres personnes puissent nourrir notre zombie !
    // Nous allons vérifier que nous sommes bien le propriétaire de ce zombie.
    // Ajoutez une déclaration require pour vérifier que msg.sender est égal au propriétaire du zombie (de la même manière que dans la fonction createRandomZombie).
    // 3.	Nous allons avoir besoin de l'ADN de ce zombie.
    // La prochaine chose que notre fonction devra faire c'est de déclarer un Zombie local nommé myZombie (qui sera un pointeur storage).
    // Définissez cette variable égale à l'index _zombieId de notre tableau zombies.
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
    }
}
