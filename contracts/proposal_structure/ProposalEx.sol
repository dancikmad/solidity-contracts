/*
What does Proposal Contract do:

1. Simple voting system for proposals created by the owner.

2. In proposals, description is used for the explanation of the proposal.
   Variables: hold numbers of approve, reject and pass votes.
   Fields: Track more information about proposals.

3. The owner can create a new proposal with a description and a vote limit,
   The other users can vote to approve, reject or pass the proposal.

4. The contract calculates the current state of the proposal based on the number of votes,
   and ends the proposal when the vote limit is reached.

5. The contract keeps a history of all the proposals and their outcome, and prevents
   the users from voting more than once.

6. The contract uses some modifiers to restrict access and check conditions
   Helper functions to implement the logic.
 */


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract ProposalContract {

   struct Proposal {
      string description;         // Description of the proposal
      uint256 approve;            // Number of approve votes
      uint256 reject;             // Number of reject votes
      uint256 pass;               // Number of pass votes
      uint256 total_vote_to_end;  // When the total votes in the proposal reaches the limit
                                  // proposal ends
      bool current_state;         // The current state of the proposal. It either passes or fail
      bool is_active;             // This shows if others can vote to our contract
      string title;               // Having a title for proposals makes them easier to identify surronded by long descriptions
   }
   
   mapping(uint256 => Proposal) proposal_history;   // Recordings of previous proposals
}
