// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IPartialPauseable} from "../interface/IPartialPauseable.sol";

library LibPauseableSlot {
    uint256 private constant REGISTRY_MASK = 0xffffffffffffffffffffffffffffffff00000000000000000000000000000000;
    uint256 private constant STATE_MASK = 0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff;

    /**
     * | registry | state   |
     * | -------- | ------- |
     * | uint128  | uint128 |
     */
    struct PauseableSlot {
        uint256 value;
    }

    /**
     * stateful functions
     */
    function _init(PauseableSlot storage slot, uint128 mask) internal {
        if (mask == uint128(0)) {
            revert IPartialPauseable.Registry_InvalidValue();
        }
        uint256 cacheValue = slot.value;
        uint256 registry = cacheValue & REGISTRY_MASK;
        uint256 maskValue = uint256(mask) << 128;

        if (registry & maskValue != uint256(0)) {
            revert IPartialPauseable.Registry_AlreadyInUsed(mask);
        }
        registry |= maskValue;
        slot.value = registry;
    }

    function _set(PauseableSlot storage slot, uint128 mask) internal {
        slot.value |= uint256(mask);
    }

    function _unset(PauseableSlot storage slot, uint128 mask) internal {
        slot.value &= ~uint256(mask);
    }

    /**
     * view functions
     */
    function _isPaused(PauseableSlot storage slot, uint128 mask) internal view returns (bool) {
        uint256 value = slot.value & STATE_MASK;
        return (value & uint256(mask)) > uint256(0);
    }
}
