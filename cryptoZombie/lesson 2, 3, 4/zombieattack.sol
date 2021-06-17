// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombiehelper.sol";

/* 챕터 11: 좀비 패배 ?
이제 우리는 좀비가 이겼을 때 어떤 일이 발생할지에 대해 작성했으니, 좀비가 지면 어떤 일이 발생할지 생각해보세.
우리 게임에서, 좀비가 진다고 좀비의 레벨이 떨어지지는 않네 - 단순히 좀비의 lossCount에 그들의 패배를 기록하고, 
다시 공격하기 전에 하루를 기다려야만 하도록 그들의 재사용 대기시간이 활성화될 것이네.

이러한 구조를 구현하기 위해서, 우리는 else 문장이 필요할 것이네. else 문장은 자바스크립트나 다른 많은 언어들에서 사용하듯이 쓸 수 있네:

if (zombieCoins[msg.sender] > 100000000) {
  // 엄청난 부자다!!!
} else {
  // 더 많은 좀비 코인이 필요해...
}

_직접 해보기
1. else 문장을 추가하게. 만약 우리의 좀비가 진다면:
  a. myZombie의 lossCount를 증가시키게.
  b. enemyZombie의 winCount를 증가시키게.
2. else 문장의 밖에서, myZombie에 대해 _triggerCooldown 함수를 실행하게. 이러한 방법으로 해당 좀비는 하루에 한 번만 공격할 수 있네.
 */

contract ZombieBattle is ZombieHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability) {
        myZombie.winCount++;
        myZombie.level++;
        enemyZombie.lossCount++;
        feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    } else {
      myZombie.lossCount++;
      enemyZombie.winCount++;
    }
    _triggerCooldown(myZombie);
  }
}