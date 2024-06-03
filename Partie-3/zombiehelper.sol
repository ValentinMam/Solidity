// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    // 1.	Dans ZombieHelper, créez un modifier appelé aboveLevel. Il prendra 2 arguments, _level (un uint) et _zombieId (aussi un uint).
    // 2.	Le corps devra s'assurer que zombies[_zombieId].level soit plus grand ou égal à _level.
    // 3.	Rappelez vous que la dernière ligne d'un modificateur doit appeler le reste de la fonction avec _;.
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }
    // 1.	Créez une fonction appelée changeName qui aura 2 paramètres : _zombieId (un uint), et _newName (un string), et la rendre external.
    // Elle devra avoir le modificateur aboveLevel, et lui passer 2 pour l'argument _level. (N'oubliez pas de lui passer aussi le _zombieId).
    // 2.	Dans cette fonction, premièrement nous allons vérifier que msg.sender est égal à zombieToOwner[_zombieId].
    // Utilisez une déclaration require.
    // 3.	Ensuite la fonction devra définir zombies[_zombieId].name égal à _newName.

    function changeName(
        uint _zombieId,
        string _newName
    ) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }
    // 4.	Créez une autre fonction changeDna en dessous de changeName.
    // Sa définition et son contenu seront presque identiques à changeName, excepté pour le second argument
    // qui sera _newDna (un uint), et qu'elle devra passer 20 pour l'argument _level à aboveLevel.
    // Et bien sur, elle devra définir le dna zombie égal à _newDna au lieu de définir le nom du zombie.

    function changeDna(
        uint _zombieId,
        uint _newDna
    ) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }
    // 1.	Créez une nouvelle fonction appelée getZombiesByOwner avec un paramètre, une address appelée _owner.
    // 2.	Ce sera une fonction external, afin que nous puissions l'appeler depuis web3.js sans que cela nous coûte de gas.
    // 3.	La fonction devra retourner un uint[] (un tableau de uint).

    function getZombiesByOwner(address _owner) external view returns (uint[]) {}
}
