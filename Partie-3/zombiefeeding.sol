// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "./zombiefactory.sol";

contract KittyInterface {
    function getKitty(
        uint256 _id
    )
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

contract ZombieFeeding is ZombieFactory {
    // 1.	Supprimez la ligne de code où nous avons écrit en dur ckAddress.
    // 2.	Changez la ligne où nous avons créé kittyContract pour simplement déclarer une variable - c.-à.-d. ne pas la rendre égal à quelque chose.
    // 3.	Créez une fonction appelée setKittyContractAddress qui aura un paramètre, _address (une address), et qui devra être une fonction external.
    // 4.	Dans la fonction, ajoutez une ligne de code qui définit kittyContract égal à KittyInterface(_address).

    KittyInterface kittyContract;

    // Maintenant nous pouvons restreindre l'accès à setKittyContractAddress pour que nous soyons le seul à pouvoir le modifier plus tard.
    // 1.	Rajoutez le modificateur onlyOwner à setKittyContractAddress.

    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    // 1.	Commencez par définir une fonction _triggerCooldown.
    // Elle aura 1 paramètre _zombie, un pointeur Zombie storage. la fonction devra être internal.
    // 2.	Le corps de la fonction devra définir _zombie.readyTime égal à uint32(now + cooldownTime).
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    }
    // 3.	Ensuite, créez une fonction appelée _isReady.
    // Cette fonction aura aussi 1 paramètre Zombie storage appelé _zombie.
    // Elle sera une fonction internal view et retournera un bool.
    // 4.	Le corps de cette fonction devra retourner (_zombie.readyTime <= now), qui sera soit true soit false.
    // Cette fonction nous dira si assez de temps s'est écoulé depuis la dernière fois que le zombie à mangé.
    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= now);
    }

    function feedAndMultiply(
        uint _zombieId,
        uint _targetDna,
        string _species
    ) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        if (keccak256(_species) == keccak256("kitty")) {
            newDna = newDna - (newDna % 100) + 99;
        }
        _createZombie("NoName", newDna);
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
