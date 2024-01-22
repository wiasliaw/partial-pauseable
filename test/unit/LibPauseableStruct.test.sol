// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../Base.sol";

contract TestLibPauseableStruct is Base {
    using LibPauseableSlot for LibPauseableSlot.PauseableSlot;

    uint128 private constant mask = uint128(1);
    LibPauseableSlot.PauseableSlot private __test_variable;

    function setUp() public override(Base) {
        __test_variable._init(mask);
    }

    function testSet() external {
        __test_variable._set(mask);

        assertEq(__test_variable._isPaused(mask), true);
    }

    function testUnset() external {
        __test_variable._set(mask);
        __test_variable._unset(mask);
        assertEq(__test_variable._isPaused(mask), false);
    }
}
