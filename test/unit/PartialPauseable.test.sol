// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../Base.sol";

contract TestPartialPauseable is IPartialPauseable, Base, PartialPauseable {
    using LibPauseableSlot for LibPauseableSlot.PauseableSlot;

    uint128 constant mask = uint128(1);

    LibPauseableSlot.PauseableSlot private __test_variable;
    bool private __test_state;

    function setUp() public override {
        __test_variable._init(mask);
    }

    function testPause() external {
        vm.expectEmit(false, false, false, false);
        emit Paused(address(this));
        pause(__test_variable, mask);
        assertEq(isPaused(__test_variable, mask), true);
    }

    function testUnpause() external {
        pause(__test_variable, mask);

        vm.expectEmit(false, false, false, false);
        emit Unpaused(address(this));
        unpause(__test_variable, mask);
        assertEq(isPaused(__test_variable, mask), false);
    }

    function testWhenNotPause() external {
        assertEq(_modifierNotPause(), true);

        pause(__test_variable, mask);
        vm.expectRevert(EnforcedPause.selector);
        _modifierNotPause();
    }

    function testWhenPause() external {
        vm.expectRevert(ExpectedPause.selector);
        _modifierPause();

        pause(__test_variable, mask);
        assertEq(_modifierPause(), true);
    }

    function _modifierNotPause() internal view whenNotPaused(__test_variable, mask) returns (bool) {
        return true;
    }

    function _modifierPause() internal view whenPaused(__test_variable, mask) returns (bool) {
        return true;
    }
}
