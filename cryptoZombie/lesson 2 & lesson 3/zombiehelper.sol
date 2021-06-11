// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 9: ���� ������

// ���� ��� �Լ��� ���� �� �츮�� aboveLevel �����ڸ� ����غ���.
// �츮 ���ӿ����� ����ڵ��� �׵��� ���� �������� �� �μ�Ƽ�긦 �� ���̳�.
// - ���� 2 �̻��� ������ ���, ����ڵ��� �� ������ �̸��� �ٲ� �� �ֳ�.
// - ���� 20 �̻��� ������ ���, ����ڵ��� �� ���񿡰� ������ DNA�� �� �� �ֳ�.

// �� �Լ����� �Ʒ��� ������ ���̳�. ����� �ϱ� ���� ���� �������� �� ���� �ڵ带 �ְڳ�.

// // ������� ���̸� �����ϱ� ���� ����
// mapping (uint => uint) public age;

// // ����ڰ� Ư�� ���� �̻����� Ȯ���ϴ� ������
// modifier olderThan(uint _age, uint _userId) {
//   require (age[_userId] >= _age);
//   _;
// }

// // ���� �����ϱ� ���Ἥ�� 16�� �̻��̾�� �ϳ�(��� �̱�������).
// function driveCar(uint _userId) public olderThan(16, _userId) {
//   // �ʿ��� �Լ� �����
// }

// ���� �غ���

// 1. changeName�̶�� �Լ��� �����. �� �Լ��� 2���� �μ��� ���� ���̳�: _zombieId(uint), _newName(string). �׸��� �Լ��� external�� �����. �� �Լ��� aboveLevel �����ڸ� ������ �ϰ�, _level�� 2��� ���� �����ؾ� �ϳ�. _zombieId ���� �����ϴ� ���� ���� ���Գ�.
// 2. �Լ��� ���뿡����, ���� �츮�� msg.sender�� zombieToOwner[_zombieId]�� ������ �����ؾ� �ϳ�. require ������ ����ϰ�.
// 3. �׸��� ���� �� �Լ������� zombies[_zombieId].name�� _newName�� �����ؾ� �ϳ�.
// 4. changeName �Ʒ��� changeDna��� �Ǵٸ� �Լ��� �����. �׸��� �Լ��� external�� �����. �� �Լ��� ���ǿ� ������ changeName�� ���� �Ȱ�����, �� ��° �μ��� _newDna(uint)�̰�, aboveLevel�� _level �Ű� ������ 20�� �����ؾ� �� ���̳�. ����, �� �Լ��� ������ �̸��� �����ϴ� �� ��ſ� ������ dna�� _newDna�� �����ؾ� �ϰ���.

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }

  // ���⼭ �����ϰ�
  function changeName(uint _zombieId, string memory _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

}
