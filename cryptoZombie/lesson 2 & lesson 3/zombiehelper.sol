// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 8: �Լ� �������� �� �ٸ� Ư¡

// �Ǹ��ϳ�! �츮 ���� ���� ���� ��� �ð� Ÿ�̸Ӹ� ������ �Ǿ���.
// ��������, �츮�� �߰����� ���� �޼ҵ带 �� �� �߰��� ���̳�. 
// �ڳ׸� ���� zombiehelper.sol�̶��, zombiefeeding.sol�� import�ϴ� ���ο� ������ �߰��ص׳�. �̷��� �ϸ� �츮�� �ڵ尡 �� ������ ���¸� ������ �� ���� ���̳�.
// ���� ������� Ư�� ������ �����ϸ� Ư���� �ɷµ��� ���� �� �ֵ��� ���� ���̳�. ������ �׷��� �ϱ� ���ؼ�, ���� �Լ� �����ڿ� ���� ���� �� ��� �ʿ䰡 �ֳ�.

// �μ��� ������ �Լ� ������

// �������� onlyOwner��� ������ ���ø� ���캸�ҳ�. ������ �Լ� �����ڴ� ��� �μ� ���� ���� �� �ֳ�. ���� ���:

// // ������� ���̸� �����ϱ� ���� ����
// mapping (uint => uint) public age;

// // ����ڰ� Ư�� ���� �̻����� Ȯ���ϴ� ������
// modifier olderThan(uint _age, uint _userId) {
//   require (age[_userId] >= _age);
//   _;
// }

// // ���� �����ϱ� ���Ἥ�� 16�� �̻��̾�� �ϳ�(��� �̱�������).
// // `olderThan` �����ڸ� �μ��� �Բ� ȣ���Ϸ��� �̷��� �ϸ� �ǳ�:
// function driveCar(uint _userId) public olderThan(16, _userId) {
//   // �ʿ��� �Լ� �����
// }

// ���⼭ �ڳ״� olderthan �����ڰ� �Լ��� ����ϰ� �μ��� �޴� ���� �� �� ���� ���̳�. �׸��� driveCar �Լ��� ���� �μ��� �����ڷ� �����ϰ� ����.
// ���� Ư���� �ɷ¿� ������ �� �� �ֵ��� ������ level �Ӽ��� ����ϴ� �츮���� modifier�� ������.

// ���� �غ���
// 1. ZombieHelper����, aboveLevel�̶�� �̸��� modifier�� �����. �� �����ڴ� _level(uint), _zombieId(uint) �� ���� �μ��� ���� ���̳�.
// 2. �Լ� ���뿡���� zombies[_zombieId].level�� _level �̻����� Ȯ���ϰ� Ȯ���ؾ� �ϳ�.
// 3. �Լ��� ������ ������ ������ �� �ֵ��� �������� ������ �ٿ� _;�� �ִ� ���� ���� ����.

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  // ���⼭ �����ϰ�
  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }
}
