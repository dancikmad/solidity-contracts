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

   // -------------- DATA --------------

   // this is the owner of the contract
   address owner;

   uint256 private counter;

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

   // Track the addresses that has voted for this contract
   address[] private voted_addresses;

   constructor () {
      owner = msg.sender;
      voted_addresses.push(msg.sender);
   }


   // -------------- Function Modifiers --------------

   modifier onlyOwner() {
      require(msg.sender == owner);
      _;
   }

   modifier active() {
      require(proposal_history[counter].is_active == true, "The proposal is not active");
      _;
   }

   modifier newVoter(address _address) {
      require(!isVoted(_address), "Address has not voted yet");
      _;
   }

   // -------------- Execute Functions --------------


   function setOwner(address new_owner) external onlyOwner {
      owner = new_owner;
   }


   function create(string calldata _description, uint256 _total_vote_to_end, string memory _title) external onlyOwner {
      counter += 1;
      proposal_history[counter] = Proposal(_description, 0, 0, 0, _total_vote_to_end, false, true, _title);
   }


   function vote(uint8 choice) external active newVoter(msg.sender) {
      // Function to vote on a proposal
      Proposal storage proposal = proposal_history[counter];
      uint256 total_vote = proposal.approve + proposal.reject + proposal.pass;

      voted_addresses.push(msg.sender);

      if (choice == 1) {
         proposal.approve += 1;
         proposal.current_state = calculateCurrentState();
      } else if (choice == 2) {
         proposal.reject += 1;
         proposal.current_state = calculateCurrentState();
      } else if (choice == 0) {
         proposal.pass += 1;
         proposal.current_state = calculateCurrentState();
      }

      if ((proposal.total_vote_to_end - total_vote == 1) && (choice == 1 || choice == 2 || choice == 0)) {
         proposal.is_active = false;
         voted_addresses = [owner];
      }
   }


   function terminateProposal() external onlyOwner() active {
      proposal_history[counter].is_active = false;
   }


   function calculateCurrentState() private view returns(bool) {
      Proposal storage proposal = proposal_history[counter];

      uint256 approve = proposal.approve;
      uint256 reject = proposal.reject;
      uint256 pass = proposal.pass;

      if (proposal.pass %2 == 1) {
         pass += 1;
      }

      pass = pass / 2;

      if (approve > reject + pass) {
         return true;
      } else {
         return false;
      }

   }



   // -------------- Query Functions --------------

   function isVoted(address _address) public view returns (bool) {
      for (uint i = 0; i < voted_addresses.length; i++) {
         if (voted_addresses[i] == _address) {
            return true;
         }
      }
      return false;
   }



   // Getter function to retrieve the current proposal
   function getCurrentProposal() external view returns(Proposal memory) {
      return proposal_history[counter];
   }



   // Getter function to retrieve a specific proposal
   function getProposal(uint256 number) external view returns(Proposal memory) {
      return proposal_history[number];
   }

}
