// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 9: 좀비 제어자

// 이제 몇몇 함수를 만들 때 우리의 aboveLevel 제어자를 사용해보세.
// 우리 게임에서는 사용자들이 그들의 좀비를 레벨업할 때 인센티브를 줄 것이네.
// - 레벨 2 이상인 좀비인 경우, 사용자들은 그 좀비의 이름을 바꿀 수 있네.
// - 레벨 20 이상인 좀비인 경우, 사용자들은 그 좀비에게 임의의 DNA를 줄 수 있네.

// 이 함수들을 아래에 구현할 것이네. 참고로 하기 위해 이전 레슨에서 본 예제 코드를 주겠네.

// // 사용자의 나이를 저장하기 위한 매핑
// mapping (uint => uint) public age;

// // 사용자가 특정 나이 이상인지 확인하는 제어자
// modifier olderThan(uint _age, uint _userId) {
//   require (age[_userId] >= _age);
//   _;
// }

// // 차를 운전하기 위햐서는 16살 이상이어야 하네(적어도 미국에서는).
// function driveCar(uint _userId) public olderThan(16, _userId) {
//   // 필요한 함수 내용들
// }

// 직접 해보기

// 1. changeName이라는 함수를 만들게. 이 함수는 2개의 인수를 받을 것이네: _zombieId(uint), _newName(string). 그리고 함수를 external로 만들게. 이 함수는 aboveLevel 제어자를 가져야 하고, _level에 2라는 값을 전달해야 하네. _zombieId 또한 전달하는 것을 잊지 말게나.
// 2. 함수의 내용에서는, 먼저 우리는 msg.sender가 zombieToOwner[_zombieId]와 같은지 검증해야 하네. require 문장을 사용하게.
// 3. 그리고 나서 이 함수에서는 zombies[_zombieId].name에 _newName을 대입해야 하네.
// 4. changeName 아래에 changeDna라는 또다른 함수를 만들게. 그리고 함수를 external로 만들게. 이 함수의 정의와 내용은 changeName과 거의 똑같지만, 두 번째 인수가 _newDna(uint)이고, aboveLevel의 _level 매개 변수에 20을 전달해야 할 것이네. 물론, 이 함수는 좀비의 이름을 설정하는 것 대신에 좀비의 dna를 _newDna로 설정해야 하겠지.

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }

  // 여기서 시작하게
  function changeName(uint _zombieId, string memory _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

}
