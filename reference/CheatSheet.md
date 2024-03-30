### Solidity Cheat Sheet
---

**1. Comments**
```solidity
// This is a single-line comment
/* This is a multi-line comment that spans several lines */
```
---
**2. Pragma Directive**

Locks the Solidity compiler version for smart contract ensuring that the contract will only compile with a compatible compiler.

```solidity
pragma solidity ^0.8.0;
```
---

**3. Import**

Import code from other Solidity files.

```solidity
import "./SomeContract.sol";
```
---

**4. Data Types**

`uint`: Unsigned integers, cannot be negative.

`int`: Singed integers, can be negative.

`bool`: Boolean, true or false.

`address`: Ethereum address.

`bytes`: Fixed-size byte arrays.

`string`: Dynamic-size string.

```solidity
uint256 x = 42;
bool isTrue = true;
address user = msg.sender;
```
---

**5. Enums**

Create custom types with a range of predefined constants, making code more readable and less error-prone.

```solidity
enum State { Created, Locked, Inactive }
```

---
**6. Structs**

Create complex data types that group variables unde a single name.

```solidity
struct Person {
    string name;
    uint age;
}
Person public person = Person("Alice", 30);
```

---

**7. Arrays**

```solidity
uint[] public numbers = [1, 2, 3];
```

**8. Mappings**

```solidity
mapping(address => uint) public balances;
```

---

**9. Functions**

**Note**: Functions are the building blocks of a Solidity contract. Functions read and modify contract states.

```solidity
function add(uint x, uint y) public pure returns (uint) {
    return x + y;
}
```

---

**10. Function Modifiers**

Modifiers can change the behavior of functions and are often used for access control.

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Not the owner");
    _;
}
```

---

**11. Events**

Logging mechanism for the blockchain. Events are for tracking the changes in the smart contracts.

```solidity
event LogData(uint indexed data);

emit LogData(42);
```

---

**12. Error Handling**

`require`: Input and condition validations. Consume less gass.

`assert`: Internal errors

`revert`: Similar to **require** but also used to revert complex operations.

```solidity
require(x > 0, "x must be greater than 0");
```

---

**13. Inheritance**

Inherit properties and behavior (i.e., state variables and functions) of a parent contract.

```solidity
contract Child is Parent {
    // code
}
```

----

**14. Interfaces**

For defiining a contract's external functions and enable the interaction between different contracts.

```solidity
interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
}
```

---

**15. Libraries**

```solidity
using SafeMath for uint;

uint x = y.add(z);
```

---

**16. Storage and Memory**

`Storage`: Persistent data storage that forms the contract state. CHanges are very costly in terms of gas.
`Memory`: Temporary data storage. It's erased between external function calls and is cheaper to use than storage.

```solidity
uint[] storage myArray;
uint[] storage tempArray;
```

---

**17. Payable**

The payable keyword allows a function to receiver Ether.

```solidity
function deposit() public payable {
    // code
}
```

---

**18. Fallback and Receive Functions**

Functions are executed when a contract receives Ether without a function being called.

`Fallback`: A default function marked with fallback.

`Receive`: Explicit function to receive Ether, must be marked external payable.

```solidity
fallback() external payable {
    // code
}

receive() external payable {
    // code
}
```
---

**19. Constructor**

A constructor is a special function that gets executed only once when the contract is deployed.

```solidity
constructor() {
    owner = msg.sender;
}
```

---

**20. Visibility**

`public`: Accessible from this and other contracts.

`private`: Accessilbe only from this contract.

`internal`: Like private but also accessible in derived contracts.

`external`: Only accessible from other contracts

```solidity
uint public x;
uint private y;
```

---

**21. View and Pure Functions**

`view`: Functions that read the state but don't modify it.

`pure`: Functions that neither read nor modify the state.

```solidity
function getView() public view returns (uint) {
    return x;
}

function getPure() public pure returns (uint) {
    return 42;
}
```

---

### Acknowledgements

This cheat sheet was created with the assistance of [Risein Platform](https://www.risein.com/courses/solidity-fundamentals/solidity-cheat-sheet).