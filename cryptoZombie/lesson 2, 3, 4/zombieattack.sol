// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombiehelper.sol";

/* 챕터 10: 좀비 승리 ?
이제 우리는 winCount와 lossCount를 가지고 있으니, 어떤 좀비가 싸움에서 이기냐에 따라 이들을 업데이트할 수 있네.
챕터 6에서 우린 0부터 100까지의 난수를 계산했네. 이제 그 숫자를 누가 싸움에서 이길지 결정하는 데에 사용하고, 그에 따라 상태를 업데이트하세.

_직접 해보기
1. rand가 attackVictoryProbability와 같거나 더 작은지 확인하는 if 문장을 만들게.
2. 만약 이 조건이 참이라면, 우리 좀비가 이기게 되네! 그렇다면:
  a. myZombie의 winCount를 증가시키게.
  b. myZombie의 level을 증가시키게. (레벨업이다!!!!!!!)
  c. enemyZombie의 lossCount를 증가시키게. (이 패배자!!!!!!! ? ? ?)
  d. feedAndMultiply 함수를 실행하게. 실행을 위한 문법을 보려면 zombiefeeding.sol을 확인하게. 3번째 인수(_species)로는 "zombie"라는 문자열을 전달하게
  (이건 지금 이 순간에는 실제로 아무 것도 하지 않지만, 이후에 우리가 원한다면 좀비 기반의 좀비를 만들어내는 부가적인 기능을 추가할 수도 있을 것이네).

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
    // 여기서 시작하게
    if (rand <= attackVictoryProbability) {
        myZombie.winCount++;
        myZombie.level++;
        enemyZombie.lossCount++;
        feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    }
  }
}