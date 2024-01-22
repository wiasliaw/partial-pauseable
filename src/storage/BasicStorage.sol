// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {LibPauseableSlot} from "../library/LibPauseableSlot.sol";

/// @title BasicStorage
/// @author wiasliaw
abstract contract BasicStorage {
    using LibPauseableSlot for LibPauseableSlot.PauseableSlot;

    LibPauseableSlot.PauseableSlot internal slot;

    function layout() internal view returns (LibPauseableSlot.PauseableSlot storage l) {
        l = slot;
    }
}
