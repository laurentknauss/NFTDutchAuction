

//SPDX-License-Identifier:MIT 

pragma solidity 0.8.13; 




interface IERC721 { 
  function transferFrom( 
    address _from, 
    address _to, 
    uint _nftId
  ) external; 
}



contract NFTDutchAuction    {
    uint private  constant DURATION  = 120 minutes ;  // Constant are vars that can not be modified , their value is hard coded & using constant can help save gas. 



    ///////// STATE VARIABLES ////////////
    IERC721 public immutable nft; // "immutable" means once the contract is deployed, this vars can not be modified . 
    uint public immutable nftId; // nftId is the identifier of the nft we are selling. 




    address payable public immutable seller; // immutable means the address of the seller will not change during the duration of the auction. 
    uint public immutable startingPrice; 

    // Below are timestamp for when the auction starts & when it ends. 
    uint public immutable startsAt; 
    uint public immutable endsAt; 


    uint public immutable discountRate; 



    // Initialize the vars described below in the constructor 
    constructor  ( 
      uint _startingPrice,
      uint _discountRate, 
      address _nft, // address  of the nft contract to be sold.
      uint _nftId
    ) 

    { 
      seller = payable(msg.sender); // The seller of the nft is the deployer of the contract & "apayable" is because when the auction ends we will need to send funds to the buyer of the nft
      startingPrice =_startingPrice; 


      startsAt = block.timestamp;  // The auction starts when this contract is deployed. 
      endsAt = block.timestamp +   DURATION; 
      discountRate = _discountRate; 


      /* The "require" below is to make sure the price of the nft is equal or greater than ZERO. 
      We use "_statringPrice" from the input and not from the state variable because for immutable state variables it can not be accessed within the constructor. 


      */

      require(_startingPrice >= _discountRate * DURATION ,
       "starting price < discount" ); 




      nft = IERC721(_nft); 
      nftId = _nftId; 
     

    }

    function getPrice() public view returns (uint256) { 
      uint timeElapsed = block.timestamp -startsAt; 
      uint discount  = discountRate * timeElapsed; 
      return startingPrice - discount ; 

    }

    function buy() external payable  { // "payable " because the buyer will have to be able to send funds 
      // We require that the auction has not ended yet . 
      require(block.timestamp < endsAt, "Auction Expired !! ") ; 

      uint price =  getPrice(); 
      // We require that the potential buyer have sent  enough funds in his/her  wallet
      require(msg.value > price, " ETH SENT NOT ENOUGH < PRICE ! ") ; 




      nft.transferFrom (
       seller, // The address of the current owner of the nft.
       msg.sender, // The address of the new owner of the nft aka the winner of the dutch auction.
       nftId  // The id of the nft that has been auctionned 
        ); 



      uint refund = msg.value - price; 
      if (refund > 0 ) { 
        payable(msg.sender). transfer(refund) ; 
      }
    }



}


