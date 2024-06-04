// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

// Nous allons nous pencher sur l'implémentation ERC721 dans le prochain chapitre.
// Mais pour l'instant, nous allons mettre en place la structure de nos fichiers pour notre leçon.
// Nous allons stocker toute la logique ERC721 dans un contrat appelé ZombieOwnership.
// 1.	Déclarez notre version pragma en haut du fichier (regardez les fichiers des leçons précédentes pour la syntaxe).
// 2.	Le fichier devra importer, avec import, zombieattack.sol.
// 3.	Déclarez un nouveau contrat, ZombieOwnership, qui héritera de ZombieAttack / ZombieBattle.
// Laissez le corps du contrat vide pour l'instant.

import "./zombieattack.sol";

contract ZombieOwnership is ZombieBattle {}
