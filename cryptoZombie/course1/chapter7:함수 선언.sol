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

    // 여기서 시작
    function createZombie(string _name, uint _dna) {
        
    }
}

// 참고: 함수 인자명을 언더스코어(_)로 시작해서 전역 변수와 구별하는 것이 관례이네 (의무는 아님). 본 튜토리얼 전체에서 이 관례를 따를 것이네.