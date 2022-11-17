pragma solidity 0.8;

contract Hack {
    constructor(address _target) {
        Target(_target).withdraw();
        require(called, "not called");
    }

    bool called;
    fallback() external payable {
        called = true;
    }

    uint public val;
    function setVal(uint v) external {
        val = v;
    }
}

contract Target {
    function withdraw() external {
        // This does not fail
        (bool ok, ) = msg.sender.call("");
        require(ok, "call failed");

        // This fails
        // Hack(payable(msg.sender)).setVal(123);
    }
}