// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;


contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // ���⼭ ����
    function createZombie(string _name, uint _dna) {
        
    }
}