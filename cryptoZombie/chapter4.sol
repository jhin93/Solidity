// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    //10�� 16��.

}

// ��Ģ����

// ����: x + y
// ����: x - y,
// ����: x * y
// ������: x / y
// ���� / ������: x % y (�̸��׸�, 13 % 5�� 3�̴�. �ֳĸ� 13�� 5�� ������ �������� 3�̱� �����̴�)
// �ָ���Ƽ�� ���� ���굵 �������� (��, "x�� y��", x^y����):

// uint x = 5 ** 2; // ��, 5^2 = 25