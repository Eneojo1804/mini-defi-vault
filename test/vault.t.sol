//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/vault.sol";

contract vaultTest is Test {
    vault vaultContract;
    address alice = address(1);
    address bob = address(2);

    function setUp() public {
        vaultContract = new vault();
    // Give Alice and Bob some ETH
    vm.deal(alice, 10 ether);
    vm.deal(bob, 5 ether);   
    }
    /*//////////////////////////////////
           DEPLOYMENT TESTS
    /////////////////////////////////*/
    function testContractStartWithZeroBalance() public{
        assertEq(vaultContract.contractBalance(), 0);

    }
    function testUserStartWithZeroBalance() public {
        assertEq(vaultContract.getBalance(alice), 0);

 }
 /*//////////////////////////////////
           DEPOSIT TESTS
    /////////////////////////////////*/
    function testDepositETH() public {
        vm.prank(alice);
        vaultContract.deposit{value: 1 ether}();
        assertEq(vaultContract.getBalance(alice), 1 ether);
        assertEq(vaultContract.contractBalance(), 1 ether);   
    }
    function testMultipleDeposits() public {
        vm.startPrank(alice);
        vaultContract.deposit{value: 1 ether}();
        vaultContract.deposit{value: 2 ether}();
        vm.stopPrank();
        assertEq(vaultContract.getBalance(alice), 3 ether);
        assertEq(vaultContract.contractBalance(), 3 ether);
    }
    function testDifferentUsersCanDeposit() public {
        vm.prank(alice);
        vaultContract.deposit{value: 2 ether}();
        vm.prank(bob);
        vaultContract.deposit{value: 1 ether}();
        assertEq(vaultContract.getBalance(alice), 2 ether);
        assertEq(vaultContract.getBalance(bob), 1 ether);
        assertEq(vaultContract.contractBalance(), 3 ether);
    }
    function testCannotDepositZeroETH() public {
        vm.prank(alice);
        vm.expectRevert("send ETH");
        vaultContract.deposit{value: 0}();
    }
    /*//////////////////////////////////
           WITHDRAW TESTS
    /////////////////////////////////*/
    function testWithdrawETH() public {
        vm.startPrank(alice);
        vaultContract.deposit{value: 2 ether}();
        uint256 balanceBefore = alice.balance;
        vaultContract.withdraw();
        uint256 balanceAfter = alice.balance;
        assertEq(balanceAfter, balanceBefore + 2 ether);
        assertEq(vaultContract.getBalance(alice), 0);
        assertEq(vaultContract.contractBalance(), 0);
        vm.stopPrank();
    }
    function testCannotWithdrawWithoutDeposit() public {
        vm.prank(alice);
        vm.expectRevert("Nothing to withdraw");
        vaultContract.withdraw();
    }
    function testBalanceResetAfterWithdraw() public {
        vm.startPrank(alice);
        vaultContract.deposit{value: 1 ether}();
        vaultContract.withdraw();
        assertEq(vaultContract.getBalance(alice), 0);
        vm.stopPrank();
    }
    /*//////////////////////////////////
           CONTRACT BALANCE TESTS
    /////////////////////////////////*/
    function testContractBalanceAfterSeveralDeposit() public {
        vm.prank(alice);
        vaultContract.deposit{value: 2 ether}();
        vm.prank(bob);
        vaultContract.deposit{value: 3 ether}();
        assertEq(vaultContract.contractBalance(), 5 ether);
    }
    function testContractBalanceAfterSeveralWithdrawal() public {
        vm.prank(alice);
        vaultContract.deposit{value: 1 ether}();
        vm.prank(bob);
        vaultContract.deposit{value: 4 ether}();
        vm.prank(alice);
        vaultContract.withdraw();
        assertEq(vaultContract.contractBalance(), 4 ether);
    }



}