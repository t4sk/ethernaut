pragma solidity ^0.8;

contract Privacy {
    // 0
    bool public locked = true;
    // 1
    uint256 public ID = block.timestamp;
    // 2
    uint8 private flattening = 10;
    // 2
    uint8 private denomination = 255;
    // 2
    uint16 private awkwardness = uint16(block.timestamp);
    // 3, 4, 5
    bytes32[3] private data;

    constructor(bytes32[3] memory _data) {
        data = _data;
    }

    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[2]));
        locked = false;
    }
}

/*
addr = "0xF0Bea74fD87326a553a49E19dd3C9eF876Ac2bde"
data = await web3.eth.getStorageAt(addr, 5)
key = data.slice(0, 34)*/

interface IPrivacy {
    function locked() external view returns (bool);
    function unlock(bytes16 _key) external;
}
