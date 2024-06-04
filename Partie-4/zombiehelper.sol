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

    // 1.	Créez une fonction withdraw dans notre contrat, qui devra être identique à l'exemple GetPaid ci-dessus.

    function withdraw() external onlyOwner {
        owner.transfer(this.balance);
    }

    // 2.	Le prix de l'Ether a été multiplié par plus de 10 l'année dernière.
    // Donc si c'est encore multiplié par 10, 0.001 ETH vaudront 10$ et notre jeu deviendra beaucoup plus cher.
    // C'est donc une bonne idée de créer une fonction qui nous permet en tant que propriétaire de changer le levelUpFee.
    //      a. Créez une fonction appelée setLevelUpFee avec un paramètre, un uint _fee, elle sera external et utilisera le modificateur onlyOwner.
    //      b. Cette fonction devra définir le levelUpFee égal à _fee.
    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

    // 2.	Créez une fonction appelée levelUp. Elle aura un paramètre, _zombieId, un uint. Elle devra être external et payable.
    // 3.	La fonction devra d'abord utiliser un require pour vérifier que msg.value soit égal à levelUpFee.
    // 4.	Elle devra ensuite incrémenter le level du zombie : zombies[_zombieId].level++.
    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }
    // 1.	Mettez à jour changeName() pour utiliser ownerOf
    function changeName(
        uint _zombieId,
        string _newName
    ) external aboveLevel(2, _zombieId) ownerOf(_zombieId) {
        // require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    // 2.	Mettez à jour changeDna() pour utiliser ownerOf
    function changeDna(
        uint _zombieId,
        uint _newDna
    ) external aboveLevel(20, _zombieId) ownerOf(_zombieId) {
        // require(msg.sender == zombieToOwner[_zombieId]);
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
