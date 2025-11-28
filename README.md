<div align="center">
    <h1>🗳️ Simple Poll Contract (Decentralized Voting System)</h1>
    <p>The most secure, transparent, and immutable way to make decisions on-chain.</p>
</div>

---

## 🚀 Project Description: Building Digital Trust

Tired of opaque, centralized voting systems? **Simple Poll Contract** is your robust solution. This Smart Contract has been engineered to serve as the foundational governance module for any project that requires fair and cryptographically verifiable decision-making.

**We Guarantee Trust:** By hardcoding the voting rules directly into the blockchain, we eliminate the need for intermediaries. We ensure that every vote cast is **unique**, the vote count (using the **`int256`** data type) is **immutable**, and only **authorized** parties can participate. This is the perfect starting point for building your first Decentralized Autonomous Organization (DAO) or integrating verifiable transparency into corporate governance.

---

## 🎯 Use Cases (Execution Flow Example)

This contract is ideal for scenarios demanding strict control over participant access and certainty in the outcome, such as corporate surveys, investor votes, or basic DAO proposals.

### Example Scenario: Budget Approval

1.  **Alice (Owner/Admin)** deploys the contract. Alice's address is set as the `owner` and is **automatically authorized** to vote in the constructor.
2.  Alice calls **`authorizeVoter(Bob's_Address)`**. The **`AuthorizeVoter` event is emitted**, creating a transparent, public record of Bob's authorization.
3.  Alice calls **`createProposal("Approve Marketing Budget")`**.
4.  **Bob (Authorized Voter)** calls the **`vote()`** function. The **modifier** `onlyVoter` verifies his permission, and a `require` checks that he hasn't voted before. The vote is successfully recorded. The **`Vote` event is emitted**.
5.  If Bob attempts to vote again, the transaction is **reverted** because the `hasVoted` mapping prevents double-voting.
6.  Any user can call the `getResults()` function (a `view` function) to instantly verify the current voting status in real-time without incurring gas costs.

---

## ⚙️ How it Works: Block-by-Block Functionality

The system relies on the strategic combination of Solidity elements—modifiers, mappings, and events—to guarantee security and auditability.

### Conceptual Diagram (Simplified UML)

This diagram illustrates the core process flow on the blockchain: 
```
+---------------------------------------------------+
|                  << Contract >>                   |
|                    SimplePoll                     |
+---------------------------------------------------+
| - proposals : mapping(int256 => Proposal)         |
| - hasVoted : mapping(address => bool)             |
| - hasPermissionToVote : mapping(address => bool)  |
| # owner : address                                 |
+---------------------------------------------------+
| << struct >> Proposal                             |
| + name : string                                   |
| + voteCount : int256                              |
| + exist : bool                                    |
+---------------------------------------------------+
| << modifier >> onlyOwner()                        |
| << modifier >> onlyVoter()                        |
| << event >> CreateProposal(string)                |
| << event >> Vote(address, string)                 |
| << event >> AuthorizeVoter(address)               |
| << event >> LogMessage(string)                    |
+---------------------------------------------------+
| + constructor()                                   |
| + createProposal(string memory _name) : public onlyOwner |
| + authorizeVoter(address _voter) : public onlyOwner|
| + vote() : public onlyVoter                       |
| + getResults() : public view (string, int256)     |
+---------------------------------------------------+
```

### Access and Logic Flow

1.  **Deployment:** The **`constructor`** initializes the **`owner`** variable and grants the owner vote permission (`hasPermissionToVote[owner] = true`).
2.  **Authorization:** The `owner` uses the **`onlyOwner` modifier** to securely manage the **`hasPermissionToVote`** mapping via the `authorizeVoter()` function.
3.  **Voting:** The **`vote()`** function is protected by the **`onlyVoter` modifier**. It then checks the **`hasVoted`** mapping to enforce the single-vote rule before incrementing `proposals[0].voteCount`.
4.  **Debugging:** The contract includes **`import "hardhat/console.sol"`** and `console.log()` calls for efficient debugging when running tests in a Hardhat environment.
5.  **Logging:** Every critical state change (proposal creation, authorization, voting) activates an **`event`** to notify external applications and ensure public auditability.

---

## 📚 Technical Documentation (Tech Docs)

| Component | Data Type / Function | Description |
| :--- | :--- | :--- |
| **`Proposal`** | `struct` | Stores the proposal name, the vote count (`voteCount`, using `int256`), and the `exist` indicator. |
| **`proposals`** | `mapping(int256 => Proposal)` | Stores the details of the single proposal (accessed via index `0`). |
| **`hasPermissionToVote`**| `mapping(address => bool)` | Boolean mapping used by `onlyVoter` to track addresses authorized to vote. |
| **`hasVoted`** | `mapping(address => bool)` | Boolean mapping to ensure single-vote execution per address. |
| **`owner`** | `address public` | The address that deployed the contract. |
| **`onlyOwner`** | `modifier` | Restricts access to sensitive functions (`createProposal`, `authorizeVoter`). |
| **`onlyVoter`** | `modifier` | Restricts access to the primary voting function (`vote`). |
| **`getResults`** | `function view` | Returns the current proposal name and the vote count without changing state. |
| **`import "hardhat/console.sol"`**| `import` | Enables the use of `console.log()` for outputting debug information during testing/local execution. |

### SPDX License

The contract uses the widely accepted **MIT** license for maximum reusability and transparency.

```solidity
// SPDX-License-Identifier: MIT
