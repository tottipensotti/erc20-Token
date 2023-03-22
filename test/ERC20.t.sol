// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {ERC20} from "../src/ERC20.sol";

contract ERC20Test is Test {
    ERC20 myToken;
    function setUp() public {
        myToken = new ERC20("myToken", "TKN", 18);
    }

    function test_name() public {
        assertEq(myToken.name(), "myToken");
    }

    function test_balanceOf() public {
        assertEq(myToken.balanceOf(address(0)), 0);
    }

    function test_totalSupply() public {
        assertEq(myToken.totalSupply(), 0);
    }

    function test_mint() public {
        address bob = makeAddr("bob");
        myToken.mint(bob, 100 ether);
        assertEq(myToken.balanceOf(bob), 100 ether);
    }

    function test_burn() public {
        address bob = makeAddr("bob");
        myToken.mint(bob, 100 ether);
        myToken.burn(bob, 100 ether);
        assertEq(myToken.balanceOf(bob), 0);
    }

    function test_transfer() public {
        address john = makeAddr("john");
        address alice = makeAddr("alice");

        deal(address(myToken), john, 10 ether);
        assertEq(myToken.balanceOf(john), 10 ether);

        vm.prank(john);
        myToken.transfer(alice, 5 ether);
        
        assertEq(myToken.balanceOf(john), 5 ether);
        assertEq(myToken.balanceOf(alice), 5 ether);
    }

    function test_allowance() public {
        address satoshi = makeAddr("satoshi");
        address vitalik = makeAddr("vitalik");
        assertEq(myToken.allowance(satoshi, vitalik), 0);
    }

    function test_trasferFrom() public {
        address ross = makeAddr("ross");
        address chandler = makeAddr("chandler");
        address joey = makeAddr("joey");

        deal(address(myToken), ross, 100 ether);
        vm.prank(ross);
        myToken.approve(chandler, 10 ether);
        assertEq(myToken.allowance(ross, chandler), 10 ether);
        
        vm.prank(chandler);
        myToken.transferFrom(ross, chandler, 5 ether);

        assertEq(myToken.balanceOf(ross), 95 ether);
        assertEq(myToken.balanceOf(chandler), 5 ether);
        assertEq(myToken.balanceOf(joey), 0 ether);
    }
}
