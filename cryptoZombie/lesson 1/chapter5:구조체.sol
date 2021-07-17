// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;


contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // 여기서 시작
    struct Zombie{
        string name;
        uint dna;
    }
}

// struct라는 자료형은 Go에서 배운 것과 동일한 것 같다.
