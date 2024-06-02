// WEB 3.JS FRONT END

var abi = /* abi générée par le compilateur */
var ZombieFeedingContract = web3.eth.contract(abi)
var contractAddress = /* l'adresse de notre contrat sur Ethereum une fois déployé */
var ZombieFeeding = ZombieFeedingContract.at(contractAddress)

// En supposant que nous ayons l'ADN de notre zombie et l'ID du chaton que l'on veut attaquer
let zombieId = 1;
let kittyId = 1;

// Pour obtenir l'image CryptoKitty, nous avons besoin d'interroger leur API web.
// Cette information n'est pas stockée sur la blockchain, seulement sur leur
// serveur web. Si tout était stocké sur la blockchain, nous n'aurions pas
// besoin de s'inquiéter que les serveurs tombent en panne, qu'ils changent leur
// API ou que la compagnie décide de nous bloquer l'accès à leurs images s'ils
// n'aiment pas notre jeu de zombie ;)
let apiUrl = "https://api.cryptokitties.co/kitties/" + kittyId
$.get(apiUrl, function(data) {
  let imgUrl = data.image_url
  // faire quelque chose pour afficher l'image
})

// Quand l'utilisateur clique sur un chaton :
$(".kittyImage").click(function(e) {
  // Appeler la fonction `feedOnKitty` de notre contrat
  ZombieFeeding.feedOnKitty(zombieId, kittyId)
})

// Écoute un évènement NewZombie de notre contrat pour l'afficher :
ZombieFactory.NewZombie(function(error, result) {
  if (error) return
  // Cette fonction va afficher le zombie, comme dans la leçon 1 :
  generateZombie(result.zombieId, result.name, result.dna)
})