// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "./zombiehelper.sol";

// 1.	En haut du fichier, indiquez que nous utilisons la version ^0.4.19 de Solidity.
// 2.	Importez avec import depuis zombiehelper.sol.
// 3.	Déclarez un nouveau contract appelé ZombieBattle qui hérite de ZombieHelper. Laissez le corps du contrat vide pour l'instant.

contract ZombieBattle is ZombieHelper {
    // 1.	Donnez à notre contrat un uint appelé randNonce égal à 0.
    // 2.	Créez une fonction appelée randMod (Modulo aléatoire).
    // Elle sera internal, aura un paramètre uint appelé _modulus, et renverra avec returns un uint.
    // 3.	La fonction devra d'abord incrémenter randNonce (en utilisant la syntaxe randNonce++).
    // 4.	Enfin, elle devra (en une ligne de code) calculer un uint à partir du hachage keccak256 de now, msg.sender et randNonce -
    // et renvoyer avec return cette valeur modulo %_modulus. (Ouf! C'était un gros morceau, si vous n'avez pas tout suivi, jetez un œil à l'exemple ci-dessus où nous avons généré un nombre aléatoire - la logique est très similaire).
    uint randNonce = 0;
    // 1.	Donnez au contrat une variable uint appelée attackVictoryProbability égale à 70.
    uint attackVictoryProbability = 70;

    function randMod(uint _modulus) internal returns (uint) {
        randNonce++;
        return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
    }
    // 2.	Créez une fonction appelée attack qui aura deux paramètres : _zombieId (un uint) et _targetId (aussi un uint).
    // Elle devra être external.

    // 1.	Ajoutez le modificateur ownerOf à attack, pour être sûr que l'appelant possède _zombieId.
    function attack(
        uint _zombieId,
        uint _targetId
    ) external ownerOf(_zombieId) {
        // 2.	La première chose que notre fonction doit faire, c'est d'obtenir un pointeur storage de nos deux zombies
        // pour interagir plus facilement avec eux :
        //      a. Déclarez un Zombie storage appelé myZombie égal à zombies[_zombieId].
        //      b. Déclarez un Zombie storage appelé enemyZombie égal à zombies[_targetId].
        // 3.	Nous allons utiliser un nombre aléatoire entre 0 et 99 pour déterminer le résultat du combat.
        // Déclarez un uint appelé rand égal au résultat de la fonction randMod avec comme argument 100.
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint rand = randMod(100);
        // 1.	Créez une déclaration if qui va vérifier si rand est plus petit ou égal à attackVictoryProbability.
        // 2.	Si c'est le cas, notre zombie gagne ! Donc :
        //      a. Incrémentez winCount de myZombie.
        //      b. Incrémentez le level de myZombie.
        //      c. Incrémentez le lossCount de enemyZombie.
        //      d. Exécutez la fonction feedAndMultiply.
        // Regardez zombiefeeding.sol pour voir la syntaxe pour l'appeler.
        // Pour le 3ème argument (_species_), mettez "zombie". Cela ne fait rien pour l'instant,
        // mais plus tard nous pourrons ajouter des fonctionnalités supplémentaires pour les zombies générés à partir d'autres zombies.
        if (rand <= attackVictoryProbability) {
            myZombie.winCount++;
            myZombie.level++;
            enemyZombie.lossCount++;
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        }
        // 1.	Ajoutez une déclaration else. Si notre zombie perd :
        //      a. Incrémentez lossCount de myZombie.
        //      b. Incrémentez winCount de enemyZombie.
        else {
            myZombie.lossCount++;
            enemyZombie.winCount++;
        }
        // 2.	En dehors de la déclaration else, exécutez la fonction _triggerCooldown sur myZombie.
        // De cette manière le zombie ne peut attaquer qu'une fois par jour.
        _triggerCooldown(myZombie);
    }
}
