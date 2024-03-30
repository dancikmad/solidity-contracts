// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Example {

    // This is the owner of the contract
    address owner;

    /* This is the counter struct.
    It will hold necessary information about the counter which are
    number and description */
    struct Counter {
        uint number;
        string description;
    }

    /* Create an instance of Counter;
    It is empty for now, but it will be initialized in the constructor. */
    Counter counter;

    /* Use this modifier with execute functions.
    This modifiers make sure that the caller of the function is the owner of the contract. */
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
}