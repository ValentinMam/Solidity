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
}
