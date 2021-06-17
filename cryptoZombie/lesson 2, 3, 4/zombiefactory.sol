// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "./ownable.sol";

// 함수 제어자 종류.
// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 사용자 정의 제어자 : 'modifier' - lesson3 챕터 3 참고.
// payable 제어자 : 이더를 받을 수 있는 특별한 함수 유형.

/* 챕터 9: 좀비 승리와 패배
우리의 좀비 게임에서, 우린 좀비들이 얼마나 많이 이기고 졌는지를 추적하고 싶게 될 것이네. 이렇게 하면 우리는 게임 상에서 "좀비 순위표"를 유지할 수 있게 되지.
우린 DApp에서 다양한 방식으로 이 데이터를 저장할 수 있네 - 개별적인 매핑으로, 순위표 구조체로, 혹은 Zombie 구조체 자체에 넣을 수도 있네.
우리가 이 데이터로 어떻게 상호작용 할 것인지에 따라 각각의 방식 모두 장단점이 있네. 이 튜토리얼에서는, 간결함을 유지할 수 있도록 Zombie 구조체에 상태를 저장하도록 하고, 이들을 winCount와 lossCount로 이름짓도록 하겠네.

이제 zombiefactory.sol로 돌아가서 우리 Zombie 구조체에 이 속성들을 추가하게.

_직접 해보기
1. Zombie 구조체가 2개의 속성을 더 가지도록 수정하게:
  a. winCount, uint16 타입
  b. lossCount, 역시 uint16 타입
참고: 기억하게, 구조체 안에서 uint들을 압축(pack)할 수 있으니, 우리가 다룰 수 있는 가장 작은 uint 타입을 사용하는 것이 좋을 것이네. uint8은 너무 작을 것이네. 2^8 = 256이기 때문이지 
- 만약 우리 좀비가 하루에 한 번씩 공격한다면, 일 년 안에 데이터 크기가 넘쳐버릴 수 있을 것이네. 하지만 2^16은 65536이네 - 그러니 한 사용자가 매일 179년 동안 이기거나 지지 않는다면, 이걸로 안전할 것이네.

2. 이제 우리는 Zombie 구조체에 새로운 속성들을 가지게 되었으니, _createZombie()의 함수 정의 부분을 수정해야 할 필요가 있네. 각각의 새로운 좀비가 0승 0패를 가지고 생성될 수 있도록 좀비 생성의 정의 부분을 변경하게.
*/

contract ZombieFactory is Ownable{
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        // 1. 여기에 새로운 속성을 추가하게
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0));
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
