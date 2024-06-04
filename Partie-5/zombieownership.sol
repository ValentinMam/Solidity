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

    // 1.	Définissez une fonction appelée _transfer.
    // Elle prendra 3 arguments, address _from (de), address _to (à), et uint256 _tokenId.
    // Elle devra être une fonction private.
    // 2.	Nous avons 2 mappages qui vont changer quand un propriétaire change :
    // ownerZombieCount (qui stocke combien de zombies un utilisateur a) et zombieToOwner (qui stocke le propriétaire de chaque token).
    // La première chose que notre fonction devra faire est d'incrémenter ownerZombieCount pour la personne qui reçoit le zombie (address _to).
    // Utilisez ++ pour incrémenter.
    // 3.	Ensuite, nous allons devoir réduire le ownerZombieCount de la personne qui envoie le zombie (address _from).
    // Utilisez -- pour réduire.
    // 4.	Enfin, nous allons vouloir changer le mappage zombieToOwner de ce _tokenId afin qu'il pointe vers _to.
    // 5.   Les specs ERC721 contiennent un évènement Transfer (transfert).
    // La dernière ligne de notre fonction devra déclencher Transfer avec les bonnes informations -
    // regardez erc721.sol pour voir quels arguments doivent être donnés et mettez le en place ici.

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerZombieCount[_to]++;
        ownerZombieCount[_from]--;
        zombieToOwner[_tokenId] = _to;
        Transfer(_from, _to, _tokenId);
    }

    // 1.	Nous voulons être sûr que seulement le propriétaire du token/zombie puisse le transférer.
    // nous avons déjà un modificateur qui fait ça. Ajoutez donc le modificateur onlyOwnerOf à cette fonction.

    function transfer(
        address _to,
        uint256 _tokenId
    ) public onlyOwnerOf(_tokenId) {
        // 2.	Maintenant le corps de la fonction se réduit à seulement une ligne... il a simplement besoin d'appeler _transfer.
        // Assurez-vous de passer msg.sender pour l'address _from comme argument.
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public {}

    function takeOwnership(uint256 _tokenId) public {}
}
