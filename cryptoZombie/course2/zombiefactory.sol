// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "./ownable.sol";

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 함수 제어자 : 'modifier' - lesson3 챕터 3 참고.

// 챕터 5: 시간 단위

// level 속성은 뭔지 말 안 해도 알겠지? 
// 나중에 우리가 전투 시스템을 만들게 되면, 전투에서 더 많이 이긴 좀비는 시간이 지나며 레벨업을 하게 될 것이고 더 많은 기능이 생길 것이네.
// readyTime 속성은 조금 설명이 필요할 듯하군. 이것의 목표는 좀비가 먹이를 먹거나 공격을 하고 나서 다시 먹거나 공격할 수 있을 때까지 기다려야 하는 "재사용 대기 시간"을 추가하는 것이네. 
// 이 속성 없이는, 좀비는 하루에 천 번 이상 공격하거나 증식할 수 있지. 이러면 게임이 너무 쉬워져 버릴 것이네.
// 좀비가 다시 공격할 때까지 기다려야 하는 시간을 측정하기 위해, 우리는 솔리디티의 시간 단위(Time units)를 사용할 것이네.

contract ZombieFactory is Ownable{
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
        // 여기 새 데이터를 입력하게
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        // 아랫줄 오류발생. Wrong argument count for struct constructor: 2 arguments given but expected 4.
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
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}