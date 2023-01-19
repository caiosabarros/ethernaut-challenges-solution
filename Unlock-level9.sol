// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
  bool public locked;
  bytes32 private password;

  constructor(bytes32 _password) {
    locked = true;
    password = _password;
  }

//Go to: https://composer.alchemy.com/
and get the storage at index 1. Index 0 is a true...
  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}

