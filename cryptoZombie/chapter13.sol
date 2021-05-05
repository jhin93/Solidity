// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);
    // 여기에 이벤트 선언
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        // 새롭게 Zombie 구조체에 추가를 한 좀비의 인덱스를 id로 사용한다.
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // 위처럼 사용할 시 다음과 같은 오류 발생. Different number of components on the left hand side (1) than on the right hand side
        // 크립토좀비에선 문제가 없었던 걸 보니 버전차이로 추정. 
        
        // 여기서 이벤트 실행
        NewZombie(id, _name, _dna);

    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

