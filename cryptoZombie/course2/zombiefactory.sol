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

// 직접 해보기

// 우리 DApp에 재사용 대기 시간을 추가하고, 좀비들이 공격하거나 먹이를 먹은 후 1일이 지나야만 다시 공격할 수 있도록 할 것이네.

// 1. cooldownTime이라는 uint 변수를 선언하고, 여기에 1 days를 대입하게.(문법적으로 이상하게 보여도 넘어가게. 자네가 "1 day"를 대입한다면, 컴파일이 되지 않을 것일세!)
// 2. 우리가 이전 챕터에서 우리의 Zombie 구조체에 level과 readyTime을 추가했으니, 우린 Zombie 구조체를 생성할 때 함수의 인수 개수가 정확히 맞도록 _createZombie() 함수를 업데이트해야 하네. 
//    코드의 zombies.push 줄에 2개의 인수를 더 사용하도록 업데이트하게: 1(level에 사용), uint32(now + cooldownTime)(readyTime에 사용). 0.7버전에선 now 대신 block.timestamp를 사용. 


contract ZombieFactory is Ownable{
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    // 1. `cooldownTime`을 여기에 정의하게
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        // 2. 아래 줄을 업데이트하게:
        // 전역 변수 now는 더 이상 사용되지 않으며 block.timestamp대신 사용해야합니다. 단일 식별자 now는 전역 변수에 대해 너무 일반적이며 트랜잭션 처리 중에 변경되는 인상을 줄 수 있지만 block.timestamp블록의 속성 일 뿐이라는 사실을 올바르게 반영합니다.
        // https://docs.soliditylang.org/en/v0.7.3/070-breaking-changes.html
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime)));
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

// 시간 단위(Time units)

// now 변수를 쓰면 현재의 유닉스 타임스탬프(1970년 1월 1일부터 지금까지의 초 단위 합) 값을 얻을 수 있네. 내가 이 글을 쓸 때 유닉스 타임의 값은 1515527488이군.
// 참고 : 유닉스 타임은 전통적으로 32비트 숫자로 저장되네. 이는 유닉스 타임스탬프 값이 32비트로 표시가 되지 않을 만큼 커졌을 때 많은 구형 시스템에 문제가 발생할 "Year 2038" 문제를 일으킬 것이네. 
// 그러니 만약 우리 DApp이 지금부터 20년 이상 운영되길 원한다면, 우리는 64비트 숫자를 써야 할 것이네. 하지만 우리 유저들은 그동안 더 많은 가스를 소모해야 하겠지. 설계를 보고 결정을 해야 하네!

// 솔리디티는 또한 seconds, minutes, hours, days, weeks, years 같은 시간 단위 또한 포함하고 있다네. 
// 이들은 그에 해당하는 길이 만큼의 초 단위 uint 숫자로 변환되네. 
// 즉 1 minutes는 60, 1 hours는 3600(60초 x 60 분), 1 days는 86400(24시간 x 60분 x 60초) 같이 변환되네.
// 이 시간 단위들이 유용하게 사용될 수 있는 예시는 다음과 같네:

// uint lastUpdated;

// // `lastUpdated`를 `now`로 설정
// function updateTimestamp() public {
//   lastUpdated = now;
// }

// // 마지막으로 `updateTimestamp`가 호출된 뒤 5분이 지났으면 `true`를, 5분이 아직 지나지 않았으면 `false`를 반환
// function fiveMinutesHavePassed() public view returns (bool) {
//   return (now >= (lastUpdated + 5 minutes));
// }

// 우리는 이런 시간 단위들은 좀비의 cooldown 기능을 추가할 때 사용할 것이네.