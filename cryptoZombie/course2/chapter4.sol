// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 4: require

// 레슨 1에서 유저가 createRandomZombie를 호출하여 좀비 이름을 입력하면 새로운 좀비를 생성할 수 있도록 했네. 
// 하지만, 만일 유저가 이 함수를 계속 호출해서 무제한으로 좀비를 생성한다면 게임이 매우 재미있지는 않을 걸세.
// 각 플레이어가 이 함수를 한 번만 호출할 수 있도록 만들어 보세. 이로써 새로운 플레이어들이 게임을 처음 시작할 때 좀비 군대를 구성할 첫 좀비를 생성하기 위해 createRandomZombie함수를 호출하게 될 것이네.
// 어떻게 하면 이 함수가 각 플레이어마다 한 번씩만 호출되도록 할 수 있을까?
// 이를 위해 require를 활용할 것이네. require를 활용하면 특정 조건이 참이 아닐 때 함수가 에러 메시지를 발생하고 실행을 멈추게 되지

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
        // 해결. https://ethereum.stackexchange.com/questions/89792/typeerror-different-number-of-components-either-side-of-equation
        // 버전 0.6부터 push가 length를 반환하지 않고 더하기 기능만 수행함. 
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        // msg.sender 대입
        zombieToOwner[id] = msg.sender;
        // 자바스크립트와 마찬가지로 솔리디티에서도 uint를 ++로 증가시킬 수 있다.
        ownerZombieCount[msg.sender] ++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        // 여기서 시작
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}


// require 예시

// function sayHiToVitalik(string _name) public returns (string) {
//   // _name이 "Vitalik"인지 비교한다. 참이 아닐 경우 에러 메시지를 발생하고 함수를 벗어난다
//   // (참고: 솔리디티는 고유의 스트링 비교 기능을 가지고 있지 않기 때문에 
//   // 스트링의 keccak256 해시값을 비교하여 스트링 값이 같은지 판단한다)
//   require(keccak256(_name) == keccak256("Vitalik"));
//   // 참이면 함수 실행을 진행한다:
//   return "Hi!";
// }