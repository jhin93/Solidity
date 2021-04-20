// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;


contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie{
        string name;
        uint dna;
    }
    // Zombie 구조체의 public 배열. 이름은 zombies
    Zombie[] public zombies;

}

// 솔리디티에는 2가지 배열이 존재. 정적배열과 동적배열.

// 2개의 원소를 담을 수 있는 고정 길이의 배열:
// uint[2] fixedArray;

// 또다른 고정 배열으로 5개의 스트링을 담을 수 있다:
// string[5] stringArray;

// 동적 배열은 고정된 크기가 없으며 계속 크기가 커질 수 있다:
// uint[] dynamicArray;