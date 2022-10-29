


const log = require('chalk-log'); 
const  hre  = require("hardhat"); 

async function deploy() { 
  await hre.run("compile") ; 

  // Getting the contract to deploy:
    const NftDutchAuction = await ethers.getContractFactory("NFTDutchAuction"); 
    const nftDutchAuction  = await NftDutchAuction.deploy();
    await nftDutchAuction.deployed(); 

    log.note(`The contract is deployed at ${nftDutchAuction.address}`) ; 

    
} 

// Recommended pattern to be able to use async/await
//everywhre and properly handle errors.

deploy()
.then( () => prcess.exit(0)) 
.catch( (error) => { 
  log.error(error) ; 
  process.exit(1); 


});
