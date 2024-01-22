// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IPartialPauseable} from "./IPartialPauseable.sol";

/// @title IPartialPauseableExternal
/// @author wiasliaw
interface IPartialPauseableExternal is IPartialPauseable {
    function paused() external view returns (bool status);
}
