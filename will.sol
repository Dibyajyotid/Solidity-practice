// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract will {
    address owner;
    uint fortune;
    bool deceased;
    //uint i;

    //it is a special type of function
    //we don't need public keyword for constructor as it is not a function which will be run again nad again
    constructor() payable {
        //payable enables this constructor to send and receive ether
        owner = msg.sender; //msg.sender represents the address that is being called
        fortune = msg.value; //msg.value tells us how much ether is being sent
        deceased = false;
    }

    //creating a modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _; //the underscore tells to shift back to the function
    }

    //creating a modifier so that we only allocate funds if friend's gramps deceased
    modifier mustBeDeceased {
        require(deceased == true);
        _;
    }

    // list of family wallets
    address payable [] familyWallets;

    //map through inheritence
    mapping (address => uint) inheritence;

    //set inheritence for each address
    function setInheritence(address payable wallet, uint amount) public onlyOwner {
        // to add wallets to the family wallets
        familyWallets.push(wallet);
        inheritence[wallet] = amount;
    }

    //pay each family member based on their wallet address
    function payout() private mustBeDeceased {
        for (uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritence[familyWallets[i]]);
            //transfering the funds from contract address to receiver address
        }
    }

    //oracle switch simulation
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }

}