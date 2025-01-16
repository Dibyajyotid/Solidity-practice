// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

//the contract allows only the creators create new coins
//anyone can send coins to each other without the need for registering
contract coin {
    //one for the mentor who can create/mint the coin
    address public minter;

    //the keyword public is making the variables here accessible from other contracts
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    //constructor only runs when we deploy the contract
    constructor() {
        minter = msg.sender;
    }

    // make new coins and send them to an address
    //and only the owner can send these coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    //send any amount of coins to an existing address
    error insufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        
        //require the amount to be greater than x and the run this
        if (amount > balances[msg.sender])
            revert insufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}