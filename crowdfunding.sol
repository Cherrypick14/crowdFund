// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Multiple contributors can be able to pool funds, set funding goals and
// get to withdraw or refund funds based on the campaign's success.

contract CrowdFunding {
    // State variable
    address public owner;
    uint public goal;
    uint public deadline;
    uint public totalFunds;
    mapping(address => uint) public contributions;
    address public mostGenerousContributor; 

    event FundReceived(address indexed contributor, uint amount);
    event GoalReached(uint totalFunds);
    event FundsWithdrawn(address indexed owner, uint amount);
    event RefundIssued(address indexed contributor, uint amount);
    event MostGenerousContributorUpdated(address indexed contributor, uint totalFunds);

    // Constructor to initialize the contract

    constructor(uint _goal, uint _duration) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + _duration;
        totalFunds = 0;
    }

    // Modifier to restrict access to the owner

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Function to contribute funds

    function contribute() public payable {
        require(block.timestamp < deadline, "Campaign has ended");
        require(msg.value > 0, "Contribution must be greator than zero");

        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;

        emit FundReceived(msg.sender, msg.value);

        if (contributions[msg.sender] > contributions[mostGenerousContributor]){
            mostGenerousContributor = msg.sender;
            emit MostGenerousContributorUpdated(msg.sender, contributions[msg.sender]);
        }

        if (totalFunds >= goal) {
            emit GoalReached(totalFunds);
        }
    }

    // Function to withdraw funds if the goal is met

    function withdrawFunds() public onlyOwner {
        require(totalFunds >= goal, "Goal not reached");
        require(block.timestamp >= deadline, "Campaign is still ongoing");

        uint amount = address(this).balance;
        payable(owner).transfer(amount);

        emit FundsWithdrawn(owner, amount);
    }

    // Function to issue refunds if the goal is not met

    function refund() public {
        require(block.timestamp >= deadline, "Campaign is still ongoing");
        require(totalFunds < goal, "Goal was reached");

        uint contributeAmount = contributions[msg.sender];
        require(contributeAmount > 0, "No contributions to refund");

        contributions[msg.sender] = 0;

        payable(msg.sender).transfer(contributeAmount);

        emit RefundIssued(msg.sender, contributeAmount);

    }
    
    // Function to get the most generous contributor
    function getMostGenerousContributor() public view returns (address){
        return mostGenerousContributor;
    }
}