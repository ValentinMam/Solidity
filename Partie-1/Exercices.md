# Chapitre 2: Contrats

## avant

```
pragma solidity // 1. Entrez la version de Solidity ici

// 2. Créez le contrat ici
```

## après

```
pragma solidity ^0.4.19; // 1. Entrez la version de Solidity ici

// 2. Créez le contrat ici
contract ZombieFactory {

}
```

# Chapitre 3: Variables d'état et entiers

## avant

```
pragma solidity ^0.4.19;

contract ZombieFactory {

    // commencez ici

}
```

## après

```
pragma solidity ^0.4.19;

contract ZombieFactory {
     // commencez ici
uint dnaDigits = 16;

}

```

# Chapitre 4: Opérations Mathématiques

## avant

```
pragma solidity ^0.4.19;

contract ZombieFactory {

    uint dnaDigits = 16;
    // commencez ici

}
```

## après

```
pragma solidity ^0.4.19;

contract ZombieFactory {

    uint dnaDigits = 16;
    // commencez ici
uint dnaModulus = 10 ** dnaDigits;
}

```

# Chapitre 5: Structures

## avant

```
pragma solidity ^0.4.19;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // commencez ici

}

```

## après

```
pragma solidity ^0.4.19;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // commencez ici
struct Zombie {
    string name ;
    uint dna;
}
}

```

# Chapitre 6: Tableaux

## avant

```
pragma solidity ^0.4.19;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    // commencez ici

}
```

## après

```
pragma solidity ^0.4.19;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    // commencez ici
    Zombie[] public zombies;

}
```
