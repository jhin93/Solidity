// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;


contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie{
        string name;
        uint dna;
    }
    // Zombie ����ü�� public �迭. �̸��� zombies
    Zombie[] public zombies;

}

// �ָ���Ƽ���� 2���� �迭�� ����. �����迭�� �����迭.

// 2���� ���Ҹ� ���� �� �ִ� ���� ������ �迭:
// uint[2] fixedArray;

// �Ǵٸ� ���� �迭���� 5���� ��Ʈ���� ���� �� �ִ�:
// string[5] stringArray;

// ���� �迭�� ������ ũ�Ⱑ ������ ��� ũ�Ⱑ Ŀ�� �� �ִ�:
// uint[] dynamicArray;