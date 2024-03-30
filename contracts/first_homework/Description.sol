// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract HomeWorkOne {

    // this is the owner of the contract
    address owner;

    // this is the counter struct.
    // holds necessary information about the counter -> number & description
    struct Counter {
        uint number;
        string description;
    }

    // create an instance of Counter;
    // it is empty for now
    // initialize it in the constructor
    Counter counter;

    // modifier in use with execute functions
    // this modifier make sure that the caller of the function is the owner of the contract.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can increment or decrement the counter");
        _;
    }

    constructor(uint initial_value, string memory description) {
        owner = msg.sender;
        counter = Counter(initial_value, description);
    }

    function increment_counter() external onlyOwner {
        counter.number += 1;
    }

    function decrement_counter() external onlyOwner {
        counter.number -= 1;
    }

    function get_counter_value() external view returns(uint) {
        return counter.number;
    }

    function get_description() external view returns(string memory) {
        return counter.description;
    }
}