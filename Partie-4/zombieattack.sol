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
    function randMod(uint _modulus) internal returns (uint) {
        randNonce++;
        return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
    }
}
