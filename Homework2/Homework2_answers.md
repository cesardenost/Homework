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


