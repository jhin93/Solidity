// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombiehelper.sol";

/* é�� 12: SafeMath ��Ʈ 4
����, ���� �츮�� DApp���� ����� ��� uint Ÿ�Կ� ���� SafeMath�� ������ �� �ֳ�!
ZombieAttack���� �� ��� ������ �����Ÿ����� ���ĺ����� ����
(ZombieHelper������ �������� �� zombies[_zombieId].level++; �̷� �κ��� �־�����, �츮�� �̰� �ϱ� ���� �߰������� é�͸� ���� �ʵ��� ���� �ڳ׸� ���� ó���� ���ҳ� ?).

_���� �غ���
� ZombieAttack���� ++ ���� �κ��� SafeMath �޼ҵ�� �����ϰ�. ã�� ������ �ּ����� �޾Ƴ��ҳ�.
 */

contract ZombieAttack is ZombieHelper {

  using SafeMath for uint256;
  using SafeMath16 for uint16;
  using SafeMath32 for uint32;

  uint randNonce = 0;
  uint attackVictoryProbability = 70;
  function randMod(uint _modulus) internal returns(uint) {
    // ���� �ϳ� �ֳ�!
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

  function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability) {
        // ���� �� �� �� �ֱ�!
        myZombie.winCount = myZombie.winCount.add(1);
        myZombie.level = myZombie.level.add(1);
        enemyZombie.lossCount = enemyZombie.lossCount.add(1);
        feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    } else {
      // ...�׸��� 2�� ��!
      myZombie.lossCount++;
      enemyZombie.winCount++;
    }
    _triggerCooldown(myZombie);
  }
}