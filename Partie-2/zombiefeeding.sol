// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

// Maintenant que nous avons une structure avec plusieurs fichiers,
// nous allons avoir besoin d'utiliser import pour lire le contenu de l'autre fichier :
// 1.	Importer zombiefactory.sol dans notre nouveau fichier zombiefeeding.sol.

import "./zombiefactory.sol";

// 1.	Définissez une interface appelée KittyInterface. C'est comme déclarer un nouveau contrat - nous utilisons le mot clé contract.
// 2.	Dans l'interface, définissez une fonction getKitty (copier/coller de la fonction, mais avec un ; après la déclaration returns au lieu de tout ce qu'il y a entre les {}).

contract KittyInterface {
    function getKitty(
        uint256 _id
    )
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

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
        // 1.	Pour commencer, nous devons nous assurer que _targetDna n'est pas plus long que 16 chiffres.
        // Pour cela, nous pouvons définir _targetDna égal à _targetDna % dnaModulus pour ne garder que les 16 derniers chiffres.
        // 2.	Ensuite, notre fonction devra déclarer un uint appelé newDna,
        // et faire en sorte qu'il soit égal à la moyenne de l'ADN de myZombie et de _targetDna (comme dans l'exemple ci-dessus).
        // Remarque : Vous pouvez accéder aux propriétés de myZombie en utilisant myZombie.name et myZombie.dna
        // 3.	Une fois que nous avons le nouvel ADN, appelons _createZombie.
        // Vous pouvez regarder l'onglet zombiefactory.sol si vous avez oublié quels arguments cette fonction a besoin pour être appelée.
        // Cette fonction a besoin d'un nom, appelons notre nouveau zombie NoName pour l'instant - nous pourrons écrire une fonction pour changer les noms des zombies plus tard.

        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        // 1.	Changez _createZombie() de private à internal pour que les autres contrats puissent y accéder (fichier zombiefactory.sol).
        _createZombie("NoName", newDna);
    }
}
