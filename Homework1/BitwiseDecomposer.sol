
// Part B - Masking and Bitwise Operations

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

// Personal work just to understand better.
// // Other functions that could be included in the contract :

//     // 1. This unction aims to demonstrate left bit shifting
//     function leftShift(uint8 x, uint8 positions) public pure returns (uint8) {
//         return x << positions; 
//     }

//     // 2. This function aims to demonstrate right bit shifting
//     function rightShift(uint8 x, uint8 positions) public pure returns (uint8) {
//         return x >> positions; 
//     }

//     // 3. This function aims to demonstrate masking with AND operation
//     function applyMask(uint8 x, uint8 mask) public pure returns (uint8) {
//         return x & mask;
//         }