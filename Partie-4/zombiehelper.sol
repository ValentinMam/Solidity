// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "./zombiefeeding.sol";

// Nous allons créer une fonction payable pour notre jeu de zombie.
// Disons que notre jeu permet aux utilisateurs de faire passer un niveau à leurs zombies en payant des ETH.
// Les ETH seront stockés dans le contrat, que vous possédez -
// c'est un exemple simple de comment faire de l'argent avec vos jeux !

contract ZombieHelper is ZombieFeeding {
    //   1.	Définissez un uint appelé levelUpFee égal à 0.001 ether.
    uint levelUpFee = 0.001 ether;

    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    // 2.	Créez une fonction appelée levelUp. Elle aura un paramètre, _zombieId, un uint. Elle devra être external et payable.
    // 3.	La fonction devra d'abord utiliser un require pour vérifier que msg.value soit égal à levelUpFee.
    // 4.	Elle devra ensuite incrémenter le level du zombie : zombies[_zombieId].level++.
    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }

    function changeName(
        uint _zombieId,
        string _newName
    ) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    function changeDna(
        uint _zombieId,
        uint _newDna
    ) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    function getZombiesByOwner(address _owner) external view returns (uint[]) {
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}
