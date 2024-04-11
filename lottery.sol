// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.7.0 <0.9.0;


contract lottery{
    address public manager;
    address payable[] public players;
    address payable public winner;
    constructor() {
        manager=msg.sender;
    }

    function participate() public payable{
        require(msg.value==1 ether ,"Please pay 1 ether");
        players.push(payable(msg.sender));
    }

    function getBalance() internal view returns(uint){
        require(manager==msg.sender,"You are not the manager");
        return address(this).balance;
    }
    function random() public view returns(uint){
      return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
   }
   function pickWinner() public{
     require(manager==msg.sender,"You are not the manager");
     require(players.length>=3,"Players are less than 3");

     uint r=random();
     uint index=r%players.length;
     winner=players[index];
     winner.transfer(getBalance());
     players=new address payable[](0);

   }
}