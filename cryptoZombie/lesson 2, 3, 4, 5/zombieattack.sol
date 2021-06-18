// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombiehelper.sol";

/* é�� 11: ���� �й� ?
���� �츮�� ���� �̰��� �� � ���� �߻������� ���� �ۼ�������, ���� ���� � ���� �߻����� �����غ���.
�츮 ���ӿ���, ���� ���ٰ� ������ ������ ���������� �ʳ� - �ܼ��� ������ lossCount�� �׵��� �й踦 ����ϰ�, 
�ٽ� �����ϱ� ���� �Ϸ縦 ��ٷ��߸� �ϵ��� �׵��� ���� ���ð��� Ȱ��ȭ�� ���̳�.

�̷��� ������ �����ϱ� ���ؼ�, �츮�� else ������ �ʿ��� ���̳�. else ������ �ڹٽ�ũ��Ʈ�� �ٸ� ���� ���鿡�� ����ϵ��� �� �� �ֳ�:

if (zombieCoins[msg.sender] > 100000000) {
  // ��û�� ���ڴ�!!!
} else {
  // �� ���� ���� ������ �ʿ���...
}

_���� �غ���
1. else ������ �߰��ϰ�. ���� �츮�� ���� ���ٸ�:
  a. myZombie�� lossCount�� ������Ű��.
  b. enemyZombie�� winCount�� ������Ű��.
2. else ������ �ۿ���, myZombie�� ���� _triggerCooldown �Լ��� �����ϰ�. �̷��� ������� �ش� ����� �Ϸ翡 �� ���� ������ �� �ֳ�.
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