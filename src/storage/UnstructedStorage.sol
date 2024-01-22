// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {LibPauseableSlot} from "../library/LibPauseableSlot.sol";

/// @title UnstructedStorage
/// @author wiasliaw
abstract contract UnstructedStorage {
    using LibPauseableSlot for LibPauseableSlot.PauseableSlot;

    bytes32 internal constant STORAGE_SLOT = bytes32(uint256(keccak256("storage.PartialPausable")) - 1);

    function layout() internal pure returns (LibPauseableSlot.PauseableSlot storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly ("memory-safe") {
            l.slot := slot
        }
    }
}
