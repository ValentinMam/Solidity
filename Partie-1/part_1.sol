// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4; // 1. Entrez la version de Solidity ici

// 2. Créez le contrat ici
contract ZombieFactory {
    // Notre ADN Zombie va être déterminé par un nombre à 16 chiffres.
    // Déclarez un uint nommé dnaDigits ayant pour valeur 16.
    uint dnaDigits = 16;
    // Pour être sûr que notre ADN Zombie est seulement de 16 chiffres, définissons un autre uint égal à 10^16.
    // Comme ça, nous pourrons plus tard utiliser l'opérateur modulo % pour raccourcir un entier à 16 chiffres.
    // Créez un uint appelé dnaModulus, et définissez-le égal à 10 à la puissance dnaDigits.
    uint dnaModulus = 10 ** dnaDigits;
    // Dans notre application, nous allons vouloir créer des zombies ! Et les zombies ont plusieurs propriétés, une structure est parfaitement adaptée pour ça.
    // 1.	Créez une struct nommée Zombie.
    // 2.	Notre structure Zombie aura 2 propriétés : name (un string) et dna (un uint).
    struct Zombie {
        string name;
        uint dna;
    }
    // Nous allons vouloir stocker une armée de zombies dans notre application.
    // Et nous allons vouloir montrer tous nos zombies à d'autres applications, cette armée devra donc être publique.
    // 1.	Créez un tableau public de structures Zombie, et appelez le zombies.
    Zombie[] public zombies;
    // Dans notre application, nous allons avoir besoin de créer des zombies. Pour cela, créons une fonction.
    // 1.	Créez une fonction appelée createZombie. Elle devra prendre deux arguments : _name (un string), et _dna (un uint).
    function _createZombie(string _name, uint _dna) private {
        // Faisons faire quelque chose à notre fonction createZombie !
        // 1.   Remplissez le corps de la fonction afin qu'elle crée un nouveau Zombie et qu'elle l'ajoute au tableau zombies.
        // Les noms name et dna pour le nouveau Zombie devraient provenir des arguments de la fonction.
        // 2.   Faites-le en une ligne de code pour garder les choses concises.
        zombies.push(Zombie(_name, _dna));
        // La fonction createZombie de notre contrat est par défaut publique
        // cela veut dire que n'importe qui peut l'appeler et créer un nouveau Zombie dans notre contrat ! Changeons-la en privée.
        // 1.	Modifiez createZombie pour que ce soit une fonction privée. N'oubliez pas la convention de nom !
    }
    // Nous allons vouloir une fonction d'aide pour générer un nombre ADN aléatoire à partir d'une chaîne de caractères.
    // 1.	Créez une fonction private appelée _generateRandomDna. Elle prendra un paramètre nommé _str (un string), et retournera un uint.
    // 2.	Cette fonction affichera des variables de notre contrat sans les modifier, marquez-la comme view.
    // 3.	Laissez le corps de la fonction vide pour l'instant - nous le remplirons plus tard.
    function _generateRandomDna(string _str) private view returns (uint) {
        // Complétons le corps de notre fonction _generateRandomDna ! Voila ce qu'elle devrait faire :
        // 1.	La première ligne de code doit prendre le hachage keccak256 de _str pour générer un nombre pseudo-aléatoire hexadécimal,
        // le convertir en un uint, et enfin stocker le résultat dans un uint nommé rand.
        // 2.	Nous allons vouloir que notre ADN fasse seulement 16 chiffres de long (vous vous rappelez notre dnaModulus ?).
        // La deuxième ligne de code devra retourner la valeur ci-dessus modulo (%) dnaModulus.
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }
    // 1.	Créez une fonction public nommée createRandomZombie. Elle devra prendre seulement un paramètre _name (un string).
    // Remarque : déclarez cette fonction public. de la même manière que vous avez déclaré la fonction précédente private)
    // 2.	La première ligne de la fonction devra exécuter la fonction _generateRandomDna avec comme argument _name and stocker le résultat dans un uint nommé randDna.
    // 3.	La deuxième ligne devra exécuter la fonction _createZombie avec comme arguments _name et randDna.
    // 4.	La solution devra faire 4 lignes de code (en comptant le } de fin de fonction).
    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
