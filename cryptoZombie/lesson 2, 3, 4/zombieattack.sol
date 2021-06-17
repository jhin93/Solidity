// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombiehelper.sol";

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