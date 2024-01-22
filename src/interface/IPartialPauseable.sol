// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// @title IPartialPauseable
/// @author wiasliaw
interface IPartialPauseable {
    /// @dev The operation failed because the contract is paused.
    error EnforcedPause();

    /// @dev The operation failed because the contract is not paused.
    error ExpectedPause();

    /// @dev Emitted when the pause is triggered by `account`.
    event Paused(address account);

    /// @dev Emitted when the pause is lifted by `account`.
    event Unpaused(address account);
}
