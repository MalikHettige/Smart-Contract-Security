// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {ExampleVault} from "../src/ExampleVault.sol";
import {Handler} from "./Handler.sol";

/// @notice Invariant: sum of all tracked user balances must always equal
///         the vault's totalDeposited counter, no matter what sequence
///         of deposits/withdrawals the fuzzer throws at it.
contract ExampleVaultInvariantTest is Test {
    ExampleVault public vault;
    Handler public handler;

    function setUp() public {
        vault = new ExampleVault();
        handler = new Handler(vault);

        // Restrict the fuzzer to only call functions through the handler,
        // not directly on the vault with unbounded/unrealistic inputs.
        targetContract(address(handler));
    }

    function invariant_sumOfBalancesEqualsTotalDeposited() public view {
        uint256 sum;
        for (uint256 i = 0; i < 3; i++) {
            sum += vault.balanceOf(handler.actors(i));
        }
        assertEq(sum, vault.totalDeposited());
    }

    function invariant_vaultBalanceCoversTotalDeposited() public view {
        assertGe(address(vault).balance, vault.totalDeposited());
    }
}
