Exercice 2

Part A - String Conversion

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// The Contract is done to convert a binary number (string) into its decimal equivalent
contract BinaryToDecimalConverter {

// TheFunction "binaryToDecimal" converts a binary string to a decimal integer
    function binaryToDecimal(string memory binaryStr) public pure returns (uint) {
        // We convert the input string to a byte array for character-by-character access
        bytes memory bStr = bytes(binaryStr);

        // We initialize two variables to store the decimal result and the lenght of this one
        uint decimal = 0;
        uint length = bStr.length;

        // We loop through each character in the binary string
        for (uint i = 0; i < length; i++) {

            // We first ensure that the character is either '0' or '1'
            require(bStr[i] == bytes1('0') || bStr[i] == bytes1('1'), "Invalid binary character");

            // If the character is '1', calculate its corresponding decimal value
            if (bStr[i] == bytes1('1')) {
                // The power of 2 is determined by the position of the bit from right to left
                // (length - i - 1) calculates the bit's position
                decimal += 2 ** (length - i - 1);
            }
        }

        return decimal;
    }
}


Part B - Masking and Bitwise Operations

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BitwiseDecomposer {
// This function receives a "uint8 type parameter x" 
// and returns a "uint[] memory type" array "bitsDecomposed",
// this array is used to store the decimal value of each active bit (e.g., [1, 0, 4, 8]).
    function decompose(uint8 x) public pure returns (uint[] memory) {
        uint[] memory bitsDecomposed = new uint[](8); 
        uint mask = 1; 

        for (uint i = 0; i < 8; ++i) {
// Apply the AND operation with the shifted mask to isolate the i-th bit
            if ((x & (mask << i)) != 0) {
                bitsDecomposed[i] = 2 ** i; 
            } else {
                bitsDecomposed[i] = 0; 
            }
        }

        return bitsDecomposed; 
// which contains the decimal values corresponding to the active bits of x.
    }
}

Personal work just to understand better.
// Other functions that could be included in the contract :

    // 1. This unction aims to demonstrate left bit shifting
    function leftShift(uint8 x, uint8 positions) public pure returns (uint8) {
        return x << positions; 
    }

    // 2. This function aims to demonstrate right bit shifting
    function rightShift(uint8 x, uint8 positions) public pure returns (uint8) {
        return x >> positions; 
    }

    // 3. This function aims to demonstrate masking with AND operation
    function applyMask(uint8 x, uint8 mask) public pure returns (uint8) {
        return x & mask;
        }