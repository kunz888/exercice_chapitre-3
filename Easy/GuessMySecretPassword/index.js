import Web3 from "web3";

// la fonction utils.soliditySha3 permet de reproduire le fonctionnement de keccak256 en local
// Il faut trouver le bon hash (Dans quel encadrement de chiffre chercher ? Voir les paramettre de la fonction)

// Vous pouvez travailler sans aucune connexion a la blockchain pour trouver la solution.

var crypted= 0x0082a7fe5a578f7e8b41851c3f922f4aadc6cc57395d858bb57426e02b4db36a;

var password;
var count;
for (  count=0;count<65536;count++ ) 
{
    password=Web3.utils.soliditySha3({type:'uint16',value:count}).toString();
    if (password==crypted)
    {
        console.log(`count: ${count}`);
        console.log(`password: ${password}`);

        break;
    }
}