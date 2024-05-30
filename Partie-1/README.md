# Chapitre 1: Aperçu de la Leçon

Dans la Leçon 1, vous allez faire une "Usine de Zombies" pour avoir une armée de zombies.

Notre usine maintiendra une base de données de tous les zombies de notre armée
Notre usine aura une fonction pour créer de nouveaux zombies
Chaque zombie aura une apparence aléatoire et unique
Dans les leçons suivantes, nous ajouterons plus de fonctionnalités, comme donner aux zombies la capacité d'attaquer des humains ou d'autres zombies ! Mais avant d'en arriver là, nous devons commencer par la fonctionnalité de base pour créer de nouveaux zombies.

Comment marche l'ADN Zombie
L'apparence du zombie va dépendre de son "ADN Zombie". L'ADN d'un Zombie est simple - c'est un entier de 16 chiffres, comme :

8356281049284737
Tout comme l'ADN réel, différentes parties de ce nombre représenteront différents traits. Les 2 premiers chiffres correspondent au type de tête du zombie, les 2 derniers chiffres aux yeux du zombie, etc.

Remarque : Pour ce tutoriel, nous avons fait simple, et nos zombies peuvent avoir seulement 7 types de têtes différentes (même si 2 chiffres permettent 100 options possibles). Plus tard, nous pourrions ajouter plus de types de têtes si nous voulions augmenter le nombre de zombies possibles.

Par exemple, les 2 premiers chiffres de notre ADN exemple sont 83. Pour les faire correspondre à un type de tête, nous devons faire 83 % 7 + 1 = 7. Ce Zombie aura donc le 7ième type de tête.

Dans le panneau de droite, essayez de déplacer le curseur head gene (gène pour la tête) sur la 7ème tête (le bonnet de Noël) pour voir à quel trait correspond le 83.

## A votre tour

Jouez avec les curseurs sur le côté droit de la page. Testez pour voir comment les différentes valeurs numériques influent sur les différents aspects de l'apparence du zombie.
Allez, assez jouer. Lorsque vous êtes prêt à continuer, cliquez sur "Chapitre Suivant" ci-dessous, et plongeons dans l'apprentissage de Solidity !

# Chapitre 2: Contrats

Commençons par les bases :

Un contrat (contract) permet d'encapsuler du code Solidity, c'est la composante fondamentale de toutes applications Ethereum - toutes les variables et fonctions appartiennent à un contrat, et ce sera le point de départ de tous vos projets.

Un contrat vide nommé HelloWorld ressemblerait à ceci :

```
contract HelloWorld {

}
```

Pragma version
Tout code source en Solidity doit commencer par un "pragma version" - une déclaration de la version du compilateur Solidity que ce code devra utiliser. Cela permet d'éviter d'éventuels problèmes liés aux changements introduits par des futures versions du compilateur.

Cela ressemble à ça : pragma solidity ^0.4.19; (la dernière version de Solidity au moment de la rédaction de cet article étant 0.4.19).

Pour résumer, voici un contrat de base - la première chose que vous devez écrire à chaque fois que vous commencerez un nouveau projet :

```
pragma solidity ^0.4.19;

contract HelloWorld {

}
```

## A votre tour

Pour commencer à créer notre armée de Zombies, créons un contrat de base appelé ZombieFactory.

Dans la section à droite, définissez la version Solidity de notre contrat à 0.4.19.

Créez un contrat vide appelé ZombieFactory.

Lorsque vous avez terminé, cliquez sur "Vérifier La Réponse" ci-dessous. Si vous êtes bloqué, vous pouvez cliquer sur "Indice".
