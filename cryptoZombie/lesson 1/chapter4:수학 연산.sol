// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    //10의 16승.

}

// 사칙연산

// 덧셈: x + y
// 뺄셈: x - y,
// 곱셈: x * y
// 나눗셈: x / y
// 모듈로 / 나머지: x % y (이를테면, 13 % 5는 3이다. 왜냐면 13을 5로 나누면 나머지가 3이기 때문이다)
// 솔리디티는 지수 연산도 지원하지 (즉, "x의 y승", x^y이지):

// uint x = 5 ** 2; // 즉, 5^2 = 25