// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 3: Msg.sender

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;
    // 여기서 매핑 선언
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) private {
        // 새롭게 Zombie 구조체에 추가를 한 좀비의 인덱스를 id로 사용한다.
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] ++;
        emit NewZombie(id, _name, _dna);
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

// 레슨 1에서 다뤘던 _createZombie 메소드를 업데이트하여 이 함수를 호출하는 누구나 좀비 소유권을 부여하도록 해 보세.

// 먼저, 새로운 좀비의 id가 반환된 후에 zombieToOwner 매핑을 업데이트하여 id에 대하여 msg.sender가 저장되도록 해보자.
// 그 다음, 저장된 msg.sender을 고려하여 ownerZombieCount를 증가시키자.

// 자바스크립트와 마찬가지로 솔리디티에서도 uint를 ++로 증가시킬 수 있다.

// uint number = 0;
// number++;
// `number`는 이제 `1`이다