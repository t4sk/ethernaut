pragma solidity ^0.8;

// 0x8186f965Fb89F4Ca221d2F62d92A6E33a7d4e8c6?
interface ISimpleToken {
    function name() external view returns (string memory);
    function destroy(address to) external;
}

// 0x99CE90aEae1DcFC3A5E0050287e4ea3788799854
interface IRecovery {}

contract Dev {
    function recover(address sender) external pure returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), sender, bytes1(0x01)));
        address addr = address(uint160(uint256(hash)));
        return addr;
    }
}
