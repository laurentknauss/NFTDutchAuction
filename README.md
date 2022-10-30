<br>
<br>
<br>





##        🚀 **_Goal of The Repository_**   🚀<br>

**1. Seller of the NFT deploys this contract that sets a starting price for the auction.**<br>
**2. Auction last for 7 days or any duration you wish.**<br>
**3. Price of the NFT decreases as the  core principle of a "dutch auction".**<br>
**4. Participants can buy by depositiong funds greater the the current price compted by the smart contract.**<br>
**5. The dutch auction ends when a highest bidder buys the NFT.**<br>
<br>


## ☑️ Compiling the contract


yarn hardhat compile<br>

##  ☑️Testing the contract logic 
<br>
yarn hardhat test-unit<br>
yarn hardhat test-staging<br>

## ☑️ Deploying the contract on Goerli Testnet network<br>

yarn hardhat  run scripts/deploy.js --network goerli<br>