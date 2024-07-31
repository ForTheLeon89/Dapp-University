// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {

    event Occupy(address _occupant, uint _value);

    // room status options
    enum Statuses{Vacant, Occupied}
    Statuses public currentStatus;

    address payable public owner;

    constructor(){
        //Hotel Owner
        owner = payable (msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyifVacant{
        // check room status
        require(currentStatus == Statuses.Vacant, "Sorry, this room Is Occupied.");
        _;
    }

    modifier RoomPrice(uint _price) {
        // set room price
        require(msg.value >= _price, "Insufficent Ether");
        _;
    }

    function BookRoom() payable public onlyifVacant RoomPrice(2 ether) {
        // complete transaction
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);

        //require(owner.send(msg.value), "Transfer failed.");

        emit Occupy(msg.sender, msg.value);
        //return BookRoom();
    }
}