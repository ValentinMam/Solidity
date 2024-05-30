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
    function createZombie(string _name, uint _dna) {}
}
