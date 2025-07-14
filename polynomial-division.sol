{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 TimesNewRomanPSMT;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs32 \cf2 \expnd0\expndtw0\kerning0
// SPDX-License-Identifier: MIT\
pragma solidity ^0.8.0;\
\'a0\
contract PolynomialVerifier \{\
\'a0\'a0\'a0 uint256 public constant p = 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed; // Example 255-bit prime\
\'a0\'a0\'a0 bool public lastCheckPassed;\
\'a0\
\'a0\'a0\'a0 function modInverse(uint256 a) internal pure returns (uint256) \{\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 return modExp(a, p - 2);\
\'a0\'a0\'a0 \}\
\'a0\
\'a0\'a0\'a0 function modExp(uint256 base, uint256 exp) internal pure returns (uint256 result) \{\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 result = 1;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 base = base % p;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 while (exp > 0) \{\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 if (exp % 2 == 1) \{\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 result = (result * base) % p;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 \}\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 base = (base * base) % p;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 exp = exp / 2;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 \}\
\'a0\'a0\'a0 \}\
\'a0\
\'a0\'a0\'a0 function isDivisibleByZeta(uint256[] memory phi, uint256 a, uint256 b) public returns (bool isDivisible) \{\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 require(a != 0, "Zeta must be degree 1");\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 uint256 n = phi.length;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 if (n == 0) \{\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 lastCheckPassed = false;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 return false;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 \}\
\'a0\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 uint256[] memory dividend = new uint256[](n);\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 for (uint256 i = 0; i < n; i++) \{\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 dividend[i] = phi[i] % p;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 \}\
\'a0\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 for (uint256 i = 0; i < n - 1; i++) \{\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 uint256 coeff = dividend[i];\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 if (coeff == 0) continue;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 uint256 scale = (coeff * modInverse(a)) % p;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 uint256 sub = (b * scale) % p;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 dividend[i + 1] = (p + dividend[i + 1] - sub) % p;\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 \}\
\'a0\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 isDivisible = (dividend[n - 1] == 0);\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 lastCheckPassed = isDivisible;\
\'a0\'a0\'a0 \}\
\}\
}