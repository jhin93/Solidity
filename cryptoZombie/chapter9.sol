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

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

}

// 의문점 해결.
// https://ethereum.stackexchange.com/questions/63294/typeerror-data-location-must-be-storage-or-memory-for-parameter-in-function
// solidity 0.5.0 버전부터는 구조체, 배열 또는 매핑 등의 모든 변수를 위해 데이터 위치를 명시하는 것이 필수.

// private는 컨트랙트 내의 다른 함수들만이 이 함수를 호출하여 numbers 배열로 무언가를 추가할 수 있다는 것을 의미하지.
// 위의 예시에서 볼 수 있듯이 private 키워드는 함수명 다음에 적네. 
// 함수 인자명과 마찬가지로 private한 함수명도 언더바(_)로 시작하는 것이 관례라네.