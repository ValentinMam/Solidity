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
    //     Nous allons configurer notre contrat pour qu'il puisse lire le smart contract CryptoKitties !
    // 1.	J'ai sauvegardé l´adresse du contrat CryptoKitties dans le code pour vous, sous une variable appelée ckAddress.
    // A la prochaine ligne, créer une KittyInterface nommée kittyContract, et initialisez la avec ckAddress.

    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // initialisez kittyContract ici en utilisant `ckAddress` ci-dessus
    KittyInterface kittyContract = KittyInterface(ckAddress);

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
    function feedAndMultiply(
        uint _zombieId,
        uint _targetDna,
        string _species
    ) public {
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
        if (keccak256(_species) == keccak256("kitty")) {
            newDna = newDna - (newDna % 100) + 99;
        }
        // 1.	Changez _createZombie() de private à internal pour que les autres contrats puissent y accéder (fichier zombiefactory.sol).
        _createZombie("NoName", newDna);
    }
    // Il est temps d'interagir avec le contrat CryptoKitties !
    // Nous allons créer une fonction qui récupère les gènes d'un chaton à partir du contrat :
    // 1.	Créez une fonction appelée feedOnKitty. Elle prendra 2 paramètres uint, _zombieId et _kittyId et elle devra être public.
    // 2.	La fonction devra d'abord déclarer un uint nommé kittyDna.
    // Remarque : Dans notre KittyInterface, genes est un uint256 - mais si vous vous rappelez de la leçon 1, uint est un alias pour uint256 - c'est la même chose.
    // 3.	La fonction devra ensuite appeler la fonction kittyContract.getKitty avec _kittyId et stocker les genes dans kittyDna.
    // N'oubliez pas - getKitty retourne une tonne de variables. (10 pour être précis). Mais nous voulons récupérer seulement la dernière, genes.
    // Comptez vos virgules soigneusement !
    // 4.	Enfin, la fonction devra appeler feedAndMultiply avec _zombieId et kittyDna.

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
    //     Nous allons implémenter les gènes de chat dans notre code zombie.
    // 1.	Premièrement, changez la définition de la fonction feedAndMultiply pour qu'elle prenne un 3ème paramètre : un string nommé _species
    // 2.	Ensuite, après avoir calculé le nouvel ADN zombie, rajoutez une déclaration if pour comparer le hachage keccak256 de _species et la chaîne de caractère "kitty".
    // 3.	Dans cette déclaration if, nous voulons remplacer les 2 derniers chiffres de l'ADN par 99.
    // Une façon de le faire est d'utiliser cette logique : newDna = newDna - newDna % 100 + 99;.
    // Explication : Si newDna est 334455. Alors newDna % 100 est 55, donc newDna - newDna % 100 est 334400. Enfin on ajoute 99 pour avoir 334499.
    // 4.	Enfin, nous avons besoin de changer l'appel de la fonction à l'intérieur de feedOnKitty.
    // Quand elle appelle feedAndMultiply, ajoutez l'argument "kitty" à la fin.
}
