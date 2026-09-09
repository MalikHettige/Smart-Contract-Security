// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title ExampleVault
/// @notice Minimal deposit/withdraw vault used as a template target for invariant testing.
/// @dev The core invariant: sum of all user balances must always equal totalDeposited.
contract ExampleVault {
    mapping(address => uint256) public balances;
    uint256 public totalDeposited;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        totalDeposited += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "insufficient balance");

        balances[msg.sender] -= amount;
        totalDeposited -= amount;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "transfer failed");
    }

    function balanceOf(address user) external view returns (uint256) {
        return balances[user];
    }
}
