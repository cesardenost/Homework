## Exercice 1

What would the output be for the function selector of HelloWorld(uint[], bool) and how would the encodePacked function behave?

//Function Selector calculation:

The function selector is generated from the function signature by applying the Keccak256 hash and taking the first 4 bytes: bytes4 selector = bytes4(keccak256("HelloWorld(uint[],bool)"))

Where the result will be a 4-byte identifier for the function.

//Encoding the Parameters with abi.encode

The ABI encoding process is used so we first encode the memory location where the array is stored, next, we encode the length of the array, which is 2 in this case (since the array contains two elements: 1993 and 1994). This will be encoded as a 32-byte value, then, we encode each element of the array. In this case, we have the values 1993 and 1994. Each uint is encoded on 32 bytes.
Also, the bool value true is encoded on 1 byte as: 0x01.

Then the full encoding of the function's abi.encode parameters would be :

0x1234567890abcdef1234567890abcdef12345678  Memory location for uint[] (32 bytes)
0x0000000000000000000000000000000000000000000000000000000000000002  Length of uint[] (32 bytes)
0x00000000000000000000000000000000000000000000000000000000000007C9  First element of uint[] (1993, 32 bytes)
0x00000000000000000000000000000000000000000000000000000000000007CA  Second element of uint[] (1994, 32 bytes)
0x0000000000000000000000000000000000000000000000000000000000000001  Bool (true), padded to 32 bytes


// Encoding with abi.encodePacked

The key difference with abi.encodePacked is that it does not add padding between the data types. It simply concatenates the values together, producing a more compact encoding.

For HelloWorld(uint[], bool), the encodePacked function call would result the memory location and array length will still be encoded, but without the padding, the elements of the array are encoded directly in a packed form, still with no padding and the bool value true is encoded on 1 byte as: 0x01.

Thus, the abi.encodePacked output would look like this :

0x1234567890abcdef1234567890abcdef12345678  Memory location for uint[] (32 bytes)
0x0000000000000000000000000000000000000000000000000000000000000002  Length of uint[] (32 bytes)
0x00000000000000000000000000000000000000000000000000000000000007C9  First element of uint[] (1993, 32 bytes)
0x00000000000000000000000000000000000000000000000000000000000007CA  Second element of uint[] (1994, 32 bytes)
0x01  Bool (true), no padding, just 1 byte


The key point is that encodePacked produces a more compact and concatenated encoding without any padding, unlike abi.encode, which adds padding between the parameters to align them to 32-byte boundaries.


## Exercice 2
PART C

This would be the Beacon Proxy model, a contract upgrade mechanism that is designed in such a way UX-wise also separates the methods of contract upgrade in contrast to other base implementations such as Transparent and UUPS Proxy by introducing a Beacon contract as a control point. This model is especially convenient when you have a number of different proxies you want to point at the same implementation contract. Instead of each proxy maintaining an address to the implementation themselves, they query the Beacon contract for the current implementation address. This centralization of the logic makes Beacon Proxy is more scalable and efficient method of managing contract upgrades.

In the Beacon Proxy model, an upgrade procedure consists of the following steps: First, the Beacon contract gets deployed and caches the address of the first implementation contract. Each of the proxy contracts queries the beacon contract for the implementation address and delegates its function calls to it. When the contract needs to be upgraded, a new implementation is deployed and the Beacon contract is updated to point to the new implementation address. Then all proxies querying Beacon contract will automatically use the updated logic. Opening all implementation contracts with just one contract addresses the problem of needing to update every single proxy contract whenever an upgrade is needed.

The Beacon Proxy model allows for greater centralization compared to the more decentralized approach taken in the Transparent Proxy and UUPS Proxy models. You have to upgrade it (implementation address) individually in each proxy in Transparent Proxy model as each proxy contract has its own implementation address. In contrast, the Beacon Proxy delegates the upgrade process to the Beacon contract, allowing multiple proxies to be upgraded at once.

By the same token, though the UUPS Proxy model delegates the responsibility for its own upgrades to each individual implementation contract, the Beacon Proxy model assigns the responsibility to the Beacon contract, which means centralized control. The Beacon Proxy model is especially useful in large systems where many proxy contracts are using the same implementation. One single update of the Beacon contract can upgrade all of the proxies at the same time, saving upgrading time and decreasing risk of human error at the same time.

But the Beacon Proxy model also comes with its drawbacks. Central control of block execution in the Beacon contract can be considered a drawback depending on how prioritization systems view decentralization. Furthermore, the Beacon contract introduces additional complexity to the system, which may not be required for smaller or simpler applications.

In conclusion, the Beacon Proxy model offers a centralized, efficient, and scalable solution for managing contract upgrades, especially when multiple proxies share the same implementation. While it provides several advantages in terms of simplicity and efficiency, it also introduces a level of centralization that might not suit every use case. Compared to the Transparent and UUPS models, the Beacon Proxy offers a more streamlined upgrade process but at the cost of increased complexity and reduced decentralization.