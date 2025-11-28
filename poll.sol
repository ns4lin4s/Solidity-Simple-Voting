// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract SimplePoll {

    constructor() {
        owner = msg.sender;
        hasPermissionToVote[owner] = true;
    }

    //It will represent a single Proposal
    struct Proposal {
        string name;
        int256 voteCount; //number of accumulated votes
        bool exist; //If true, the proposal already exists
    }

    address public owner;

    //proposals Id 
    mapping(int256 => Proposal) public proposals;

    mapping(address => bool) public hasVoted;

    mapping(address => bool) public hasPermissionToVote;

    //modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyVoter() {
        require(hasPermissionToVote[msg.sender], "Address is not authorized to vote.");
        _;
    }

    //events
    event CreateProposal(string name);
    event Vote(address indexed voter, string proposalName);
    event AuthorizeVoter(address voter);
    event LogMessage(string message);

    //external function
    function createProposal(string memory _name) public onlyOwner {

        proposals[0] = Proposal({
            name: _name,
            voteCount: 0,
            exist: true
        });

        emit CreateProposal(_name);
    }

    function authorizeVoter(address _voter) public onlyOwner {
        hasPermissionToVote[_voter] = true;
        emit AuthorizeVoter(_voter);
    }

    function vote() public onlyVoter {
        require(proposals[0].exist, "the proposal has not been already created."); // if exist, pass to the next require
        require(hasVoted[msg.sender] == false, "you have voted already"); // if the user has voted, deny execution

        console.log("vote function ...");
        
        hasVoted[msg.sender] = true;

        proposals[0].voteCount++;

        emit Vote(msg.sender, proposals[0].name);

    }

    function getResults() public view returns (string memory, int256) {
        require(proposals[0].exist, "the proposal has not been already created.");

        return (proposals[0].name, proposals[0].voteCount);
    }

}
