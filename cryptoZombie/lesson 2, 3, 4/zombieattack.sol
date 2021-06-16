// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* é�� 5: ���� �ο�
���� �츮�� ��Ʈ��Ʈ�� ��� ���� ������ �Ұ����ϵ��� �ϴ� ������ ��������, ���� �������� ����� ����� �� �̸� ����� �� �ֳ�.
���� ������ ������ ���� ����� ���̳�:
? �ڳװ� �ڳ� ���� �� �ϳ��� ����, ������ ���� ���� ������� �����ϳ�.
? �ڳװ� �����ϴ� ���� ������, �ڳ״� 70%�� �¸� Ȯ���� ������. ����ϴ� ���� ����� 30%�� �¸� Ȯ���� ���� ���̳�.
? ��� �����(����, ��� ���)�� ���� ����� ���� �����ϴ� winCount�� lossCount�� ���� ���̳�.
? �����ϴ� ���� ���� �̱��, ������ ������ ������ ���ο� ���� �����.
? ���� ����, �ƹ��͵� �Ͼ�� �ʳ�(������ lossCount�� �����ϴ� �� ���� ���̾�).
? ���� �̱�� ����, �����ϴ� �� ������ ���� ���ð��� Ȱ��ȭ�� ���̳�.
������ ������ ������, ���� é�ͷ� �����ϸ鼭 ������ ������ ���̳�.

_���� �غ���

1. ��Ʈ��Ʈ�� attackVictoryProbability��� �̸��� uint ������ �߰��ϰ�, ���⿡ 70�� �����ϰ�.
2. attack�̶�� �̸��� �Լ��� �����ϰ�. �� �Լ��� �� ���� �Ű������� ���� ���̳�: _zombieId(uint)�� _targetId(uint)�̳�. �� �Լ��� external�̾�� �ϳ�.
������ �Լ��� ������ ����ε��� �ϰ�.
 */

import "./zombiehelper.sol";

contract ZombieBattle is ZombieHelper {
  uint randNonce = 0;
  // ���⿡ attackVictoryProbability�� �����
  uint attackVictoryProbability = 70;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

  // ���⿡ ���ο� �Լ��� �����
  function attack(uint _zombieId, uint _targetId) external {

  }
}