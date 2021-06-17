// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombiehelper.sol";

/* é�� 8: �������� ���ư���!
������ ����� ������ �� ���� - zombieattack.sol�� ���ư���. ���� ownerOf �����ڵ� ����� �� ������, �츰 attack �Լ��� ��� �����س��� ���̳�.

_���� �غ���
1. �Լ��� ȣ���ϴ� ����� _zombieId�� �����ϰ� �ִ��� Ȯ���ϱ� ���� attack �Լ��� ownerOf �����ڸ� �߰��ϰ�.
2. �츮 �Լ����� ó������ �ؾ� �� ���� �� ������ storage �����͸� �� �׵�� ��ȣ�ۿ� �ϱ� ������ �ϴ� ���̳�.
    a. Zombie storage�� myZombie��� �̸����� �����ϰ�, ���⿡ zombies[_zombieId]�� �����ϰ�.
    b. Zombie storage�� enemyZombie��� �̸����� �����ϰ�, ���⿡ zombies[_targetId]�� �����ϰ�.
3. �츰 ������ ����� �����ϱ� ���� 0�� 99 ������ ������ ����� ���̳�. �׷��� uint�� rand��� �̸����� �����ϰ�, ���⿡ randMod �Լ��� 100�� �μ��� ����� ���� �����ϰ�.
 */

contract ZombieBattle is ZombieHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

  // 1. ���⿡ �����ڸ� �߰��ϰ�
  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
    // 2. ���⼭ �Լ� ���Ǹ� �����ϰ�
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100);
  }
}