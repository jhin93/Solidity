// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombiehelper.sol";

/* 챕터 8: 공격으로 돌아가자!
구조는 충분히 개선한 것 같군 - zombieattack.sol로 돌아가세. 이제 ownerOf 제어자도 사용할 수 있으니, 우린 attack 함수를 계속 정의해나갈 것이네.

_직접 해보기
1. 함수를 호출하는 사람이 _zombieId를 소유하고 있는지 확인하기 위해 attack 함수에 ownerOf 제어자를 추가하게.
2. 우리 함수에서 처음으로 해야 할 것은 두 좀비의 storage 포인터를 얻어서 그들과 상호작용 하기 쉽도록 하는 것이네.
    a. Zombie storage를 myZombie라는 이름으로 선언하고, 여기에 zombies[_zombieId]를 대입하게.
    b. Zombie storage를 enemyZombie라는 이름으로 선언하고, 여기에 zombies[_targetId]를 대입하게.
3. 우린 전투의 결과를 결정하기 위해 0과 99 사이의 난수를 사용할 것이네. 그러니 uint를 rand라는 이름으로 선언하고, 여기에 randMod 함수에 100을 인수로 사용한 값을 대입하게.
 */

contract ZombieBattle is ZombieHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

  // 1. 여기에 제어자를 추가하게
  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
    // 2. 여기서 함수 정의를 시작하게
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100);
  }
}