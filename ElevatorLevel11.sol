// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Building {

  uint public round;

  constructor () {}

//there are two calls for islastFloor, one after the other!
//first returns false, then it should return true.
function isLastFloor(uint _floor) external view returns(bool) {
    if(round == 0) {
      return false;
    } else {
      return true;
    }
  }
}

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}