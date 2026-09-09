// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {ExampleVault} from "../src/ExampleVault.sol";

/// @notice Handler restricts the fuzzer to realistic, bounded actions.
/// @dev Without a handler, Foundry's invariant fuzzer calls functions with
///      wild random inputs (e.g. withdrawing amounts no one deposited),
///      which produces noise instead of meaningful counterexamples.
///      Inheriting from Test gives access to vm.deal / vm.prank / bound.
contract Handler is Test {
    ExampleVault public vault;
    address[] public actors;

    constructor(ExampleVault _vault) {
        vault = _vault;
        for (uint256 i = 0; i < 3; i++) {
            actors.push(address(uint160(0x1000 + i)));
        }
    }

    function deposit(uint256 actorSeed, uint256 amount) external {
        address actor = actors[actorSeed % actors.length];
        amount = bound(amount, 0, 10 ether);

        vm.deal(actor, amount);
        vm.prank(actor);
        vault.deposit{value: amount}();
    }

    function withdraw(uint256 actorSeed, uint256 amount) external {
        address actor = actors[actorSeed % actors.length];
        uint256 bal = vault.balanceOf(actor);
        if (bal == 0) return;
        amount = bound(amount, 0, bal);

        vm.prank(actor);
        vault.withdraw(amount);
    }
}
