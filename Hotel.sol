// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Hotel{

    enum status {occupied, vacent}
    event Occupy( address occupent, uint value );

    status public currentstat;
    address payable owner;

    constructor() {
        owner= payable (msg.sender);
        currentstat = status.vacent;
    }

    modifier cost ( uint _amount){
        require(msg.value < _amount, "enter approriate amount");
        _;


    }

    modifier onlybook (){
        require(currentstat == status.vacent,"the room is occupied");
        _;
    }

    function Book() public payable onlybook cost(2 ether){
       currentstat = status.occupied;

        owner.transfer(msg.value);
        //  (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        // require(sent);
        
        
        emit Occupy (msg.sender, msg.value);


    }

}