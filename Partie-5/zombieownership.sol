// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

// Nous allons nous pencher sur l'implémentation ERC721 dans le prochain chapitre.
// Mais pour l'instant, nous allons mettre en place la structure de nos fichiers pour notre leçon.
// Nous allons stocker toute la logique ERC721 dans un contrat appelé ZombieOwnership.
// 1.	Déclarez notre version pragma en haut du fichier (regardez les fichiers des leçons précédentes pour la syntaxe).
// 2.	Le fichier devra importer, avec import, zombieattack.sol.
// 3.	Déclarez un nouveau contrat, ZombieOwnership, qui héritera de ZombieAttack / ZombieBattle.
// Laissez le corps du contrat vide pour l'instant.

// Nous avons créé erc721.sol avec son interface en avance.
// 1.	Importez erc721.sol dans zombieownership.sol
// 2.	Déclarez que ZombieOwnership hérite de ZombieAttack ET de ERC721

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieBattle, ERC721 {
    function balanceOf(address _owner) public view returns (uint256 _balance) {
        // 1.	Implémentez balanceOf pour renvoyer le nombre de zombies qu'un _owner a.
        return ownerZombieCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        //    2.	Implémentez ownerOf pour renvoyer l'adresse du propriétaire du zombie avec l'ID _tokenId.
        return zombieToOwner[_tokenId];
    }

    function transfer(address _to, uint256 _tokenId) public {}

    function approve(address _to, uint256 _tokenId) public {}

    function takeOwnership(uint256 _tokenId) public {}
}
