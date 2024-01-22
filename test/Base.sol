// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// interface
// error and event
import {IPartialPauseable} from "../src/interface/IPartialPauseable.sol";

// source
import {LibPauseableSlot} from "../src/library/LibPauseableSlot.sol";
import {PartialPauseable} from "../src/PartialPauseable.sol";

abstract contract Base is Test {
    function setUp() public virtual {}
}
