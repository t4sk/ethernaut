pragma solidity ^0.8;

interface IDelegate {
    // send extra gas
    function pwn() external;
    function owner() external view returns (address);
}
