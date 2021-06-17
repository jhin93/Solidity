// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombiehelper.sol";

/* é�� 10: ���� �¸� ?
���� �츮�� winCount�� lossCount�� ������ ������, � ���� �ο򿡼� �̱�Ŀ� ���� �̵��� ������Ʈ�� �� �ֳ�.
é�� 6���� �츰 0���� 100������ ������ ����߳�. ���� �� ���ڸ� ���� �ο򿡼� �̱��� �����ϴ� ���� ����ϰ�, �׿� ���� ���¸� ������Ʈ�ϼ�.

_���� �غ���
1. rand�� attackVictoryProbability�� ���ų� �� ������ Ȯ���ϴ� if ������ �����.
2. ���� �� ������ ���̶��, �츮 ���� �̱�� �ǳ�! �׷��ٸ�:
  a. myZombie�� winCount�� ������Ű��.
  b. myZombie�� level�� ������Ű��. (�������̴�!!!!!!!)
  c. enemyZombie�� lossCount�� ������Ű��. (�� �й���!!!!!!! ? ? ?)
  d. feedAndMultiply �Լ��� �����ϰ�. ������ ���� ������ ������ zombiefeeding.sol�� Ȯ���ϰ�. 3��° �μ�(_species)�δ� "zombie"��� ���ڿ��� �����ϰ�
  (�̰� ���� �� �������� ������ �ƹ� �͵� ���� ������, ���Ŀ� �츮�� ���Ѵٸ� ���� ����� ���� ������ �ΰ����� ����� �߰��� ���� ���� ���̳�).

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
    // ���⼭ �����ϰ�
    if (rand <= attackVictoryProbability) {
        myZombie.winCount++;
        myZombie.level++;
        enemyZombie.lossCount++;
        feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    }
  }
}