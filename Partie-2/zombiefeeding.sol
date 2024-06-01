// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

// Maintenant que nous avons une structure avec plusieurs fichiers,
// nous allons avoir besoin d'utiliser import pour lire le contenu de l'autre fichier :
// 1.	Importer zombiefactory.sol dans notre nouveau fichier zombiefeeding.sol.

import "./zombiefactory.sol";

// Dans les prochains chapitres, nous allons implémenter les fonctionnalités pour nourrir et multiplier nos zombies.
// Mettons cette logique dans sa propre classe qui hérite de toutes les méthodes de ZombieFactory.
// 1.	Créez un contrat nommé ZombieFeeding en dessous de ZombieFactory. Ce contrat devra hériter de notre contrat ZombieFactory.

contract ZombieFeeding is ZombieFactory {}
