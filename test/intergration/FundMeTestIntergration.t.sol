// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract IntergrationTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");

    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 public constant SEND_VALUE = 1 ether; // just a value to make sure we are sending enough!
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deployFunMe = new DeployFundMe();
        fundMe = deployFunMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    // function testUserCanFundInteraction() public {
    //     FundFundMe fundFundMe = new FundFundMe();
    //     fundFundMe.fundFundMe(address(fundMe));
    //     address funder = fundMe.getFunder(0);
    //     assertEq(funder, USER);
    // }

    function testUsercanWithdrawInteraction() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));
        assertEq(address(fundMe).balance, 0);
    }
}
