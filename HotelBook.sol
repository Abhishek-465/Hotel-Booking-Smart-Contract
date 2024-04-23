// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
 contract HotelBook{
    address payable public owner;
    enum Status{
        Vacant,
        Full
        }
    Status public flag;
    constructor(){
        owner=payable (msg.sender);
        flag=Status.Vacant;
    }
    function book() public payable{
        require(flag==Status.Vacant,"Currently not occupied");
        require(msg.value >= 2 ether, "Not enough Ether provided.");
                (bool sent, //bytes memory data
                ) = owner.call{value: msg.value}("");
        require(sent);
        flag=Status.Full;

    }
        // Function to send Ether from this contract to a specified address
    function sendEther(address payable recipient) external payable {
         require(flag==Status.Full,"Currently occupied");
        require(msg.sender==owner,"Owner is only allowed");
        // Ensure that the owner has sent enough Ether
        require(msg.value > 0, "Insufficient Ether sent");

        // Transfer the Ether to the recipient address
        recipient.transfer(msg.value);
        flag=Status.Vacant;
    }


 }
