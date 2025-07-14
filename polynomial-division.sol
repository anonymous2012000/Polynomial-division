// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 
contract PolynomialVerifier {
    uint256 public constant p = 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed; // Example 255-bit prime
    bool public lastCheckPassed;
 
    function modInverse(uint256 a) internal pure returns (uint256) {
        return modExp(a, p - 2);
    }
 
    function modExp(uint256 base, uint256 exp) internal pure returns (uint256 result) {
        result = 1;
        base = base % p;
        while (exp > 0) {
            if (exp % 2 == 1) {
                result = (result * base) % p;
            }
            base = (base * base) % p;
            exp = exp / 2;
        }
    }
 
    function isDivisibleByZeta(uint256[] memory phi, uint256 a, uint256 b) public returns (bool isDivisible) {
        require(a != 0, "Zeta must be degree 1");
        uint256 n = phi.length;
        if (n == 0) {
            lastCheckPassed = false;
            return false;
        }
 
        uint256[] memory dividend = new uint256[](n);
        for (uint256 i = 0; i < n; i++) {
            dividend[i] = phi[i] % p;
        }
 
        for (uint256 i = 0; i < n - 1; i++) {
            uint256 coeff = dividend[i];
            if (coeff == 0) continue;
            uint256 scale = (coeff * modInverse(a)) % p;
            uint256 sub = (b * scale) % p;
            dividend[i + 1] = (p + dividend[i + 1] - sub) % p;
        }
 
        isDivisible = (dividend[n - 1] == 0);
        lastCheckPassed = isDivisible;
    }
}
