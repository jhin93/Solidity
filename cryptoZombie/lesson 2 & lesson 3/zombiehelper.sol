// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 8: 함수 제어자의 또 다른 특징

// 훌륭하네! 우리 좀비가 이제 재사용 대기 시간 타이머를 가지게 되었군.
// 다음으로, 우리는 추가적인 헬퍼 메소드를 좀 더 추가할 것이네. 
// 자네를 위해 zombiehelper.sol이라는, zombiefeeding.sol을 import하는 새로운 파일을 추가해뒀네. 이렇게 하면 우리의 코드가 잘 정리된 상태를 유지할 수 있을 것이네.
// 이제 좀비들이 특정 레벨에 도달하면 특별한 능력들을 얻을 수 있도록 만들 것이네. 하지만 그렇게 하기 위해선, 먼저 함수 제어자에 대해 조금 더 배울 필요가 있네.

// 인수를 가지는 함수 제어자

// 이전에는 onlyOwner라는 간단한 예시를 살펴보았네. 하지만 함수 제어자는 사실 인수 또한 받을 수 있네. 예를 들면:

// // 사용자의 나이를 저장하기 위한 매핑
// mapping (uint => uint) public age;

// // 사용자가 특정 나이 이상인지 확인하는 제어자
// modifier olderThan(uint _age, uint _userId) {
//   require (age[_userId] >= _age);
//   _;
// }

// // 차를 운전하기 위햐서는 16살 이상이어야 하네(적어도 미국에서는).
// // `olderThan` 제어자를 인수와 함께 호출하려면 이렇게 하면 되네:
// function driveCar(uint _userId) public olderThan(16, _userId) {
//   // 필요한 함수 내용들
// }

// 여기서 자네는 olderthan 제어자가 함수와 비슷하게 인수를 받는 것을 볼 수 있을 것이네. 그리고 driveCar 함수는 받은 인수를 제어자로 전달하고 있지.
// 이제 특별한 능력에 제한을 걸 수 있도록 좀비의 level 속성을 사용하는 우리만의 modifier를 만들어보세.

// 직접 해보기
// 1. ZombieHelper에서, aboveLevel이라는 이름의 modifier를 만들게. 이 제어자는 _level(uint), _zombieId(uint) 두 개의 인수를 받을 것이네.
// 2. 함수 내용에서는 zombies[_zombieId].level이 _level 이상인지 확실하게 확인해야 하네.
// 3. 함수의 나머지 내용을 실행할 수 있도록 제어자의 마지막 줄에 _;를 넣는 것을 잊지 말게.

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  // 여기서 시작하게
  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }
}
