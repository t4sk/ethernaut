pragma solidity ^0.8;

interface IMagicNum {
    function solver() external view returns (address);
    function setSolver(address) external;
}

interface ISolver {
    function whatIsTheMeaningOfLife() external view returns (uint256);
}

contract Hack {
    constructor(IMagicNum target) {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address addr;
        assembly {
            // create(value, offset, size)
            addr := create(0, add(bytecode, 0x20), 0x16)
        }
        require(addr != address(0));

        target.setSolver(addr);
    }
}

// https://www.evm.codes/playground
// https://stermi.xyz/blog/ethernaut-challenge-18-solution-magic-number

/*
Run time code - return 42
602a60005260206000f3

// Store 42 to memory
PUSH1 0x2a
PUSH1 0
MSTORE

// Return 32 bytes from memory
PUSH1 0x20
PUSH1 0
RETURN

Creation code - return runtime code
69602a60005260206000f3600052600a6016f3

// Store run time code
PUSH10 0X602a60005260206000f3
PUSH1 0
MSTORE

// Return 10 bytes from memory starting at offset 22
PUSH1 0x0a
PUSH1 0x16
RETURN*/
