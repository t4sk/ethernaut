### Hello Ethernaut

Tutorial

```shell
await contract.password()
await contract.authenticate("ethernaut0")
```

```
FORK_URL=https://eth-goerli.g.alchemy.com/v2/613t3mfjTevdrCwDl28CVvuk6wSIxRPi

forge test -vvvv --fork-url $FORK_URL --match-path test/13-gate-keeper-one.test.sol
```
