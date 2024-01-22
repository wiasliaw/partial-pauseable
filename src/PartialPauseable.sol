// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IPartialPauseable} from "./interface/IPartialPauseable.sol";
import {LibPauseableSlot} from "./library/LibPauseableSlot.sol";

/// @title PartialPauseableInternal
/// @author wiasliaw
abstract contract PartialPauseable is IPartialPauseable {
    using LibPauseableSlot for LibPauseableSlot.PauseableSlot;

    /**
     * modifier
     */
    modifier whenNotPaused(LibPauseableSlot.PauseableSlot storage s, uint128 mask) {
        if (isPaused(s, mask)) {
            revert EnforcedPause();
        }
        _;
    }

    modifier whenPaused(LibPauseableSlot.PauseableSlot storage s, uint128 mask) {
        if (!isPaused(s, mask)) {
            revert ExpectedPause();
        }
        _;
    }

    /**
     * stateful functions
     */
    function pause(LibPauseableSlot.PauseableSlot storage s, uint128 mask) internal {
        s._set(mask);
        emit Paused(msg.sender);
    }

    function unpause(LibPauseableSlot.PauseableSlot storage s, uint128 mask) internal {
        s._unset(mask);
        emit Unpaused(msg.sender);
    }

    /**
     * view functions
     */
    function isPaused(LibPauseableSlot.PauseableSlot storage s, uint128 mask) internal view returns (bool) {
        return s._isPaused(mask);
    }
}
