# CrowdFunding Smart Contract

## Overview

The **CrowdFunding** smart contract enables multiple contributors to pool funds for a campaign with a defined funding goal and duration. Depending on the success of the campaign, funds can either be withdrawn by the owner or refunded to contributors.

## Features

- **Contributions**: Contributors can send funds to the campaign before the deadline.
- **Funding Goal**: A funding goal is set at contract deployment, and contributors are notified when it is met.
- **Withdrawals**: The owner can withdraw funds after the campaign ends if the funding goal is met.
- **Refunds**: Contributors can claim refunds if the funding goal is not met by the deadline.

---

## Contract Functions

### 1. **Constructor**
Initializes the contract with:
- `goal`: The funding target for the campaign.
- `duration`: The campaign's duration in seconds.

### 2. **Contribute**
Allows contributors to send funds to the campaign:
- Contributions must be greater than zero.
- Campaign must not have ended.
- Emits a `FundReceived` event upon successful contribution.
- Emits a `GoalReached` event if the funding goal is met.

### 3. **Withdraw Funds**
Allows the owner to withdraw funds after the campaign ends if:
- The funding goal is met.
- Emits a `FundsWithdrawn` event upon successful withdrawal.

### 4. **Refund**
Allows contributors to claim refunds after the campaign ends if:
- The funding goal is not met.
- Refunds are issued based on the contributor's contributions.
- Emits a `RefundIssued` event upon successful refund.

---

## Deployment

1. Deploy the contract by specifying:
   - `goal`: Target amount in wei.
   - `duration`: Duration in seconds.

2. The contract deployer will automatically be assigned as the owner.

---

## Events

- **`FundReceived`**: Emitted when a contribution is made.
- **`GoalReached`**: Emitted when the total funds meet or exceed the goal.
- **`FundsWithdrawn`**: Emitted when the owner withdraws funds after a successful campaign.
- **`RefundIssued`**: Emitted when a contributor claims a refund.

---

## Security Considerations

- Only the owner can withdraw funds using the `withdrawFunds` function.
- Refunds are only available after the campaign ends and if the funding goal is not reached.
- Contributions are tracked per address to ensure accurate refunds.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
