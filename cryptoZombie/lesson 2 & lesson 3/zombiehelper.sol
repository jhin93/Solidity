// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 11: Storage�� ��δ�.

// �ָ���Ƽ���� �� ��� ���� �� �ϳ��� �ٷ� storage�� ���� ���̳� - ���߿����� ���� ��������. �̰� �ڳװ� �������� �Ϻθ� ���ų� �ٲ� ������, ���ü�ο� ���������� ��ϵǱ� �����̳�. ������! 
// �������� ��õ ���� ������ �׵��� �ϵ� ����̺꿡 �� �����͸� �����ؾ� �ϰ�, ���ü���� Ŀ�����鼭 �� �������� �� ���� ���� Ŀ������. �׷��� �� ���꿡�� ����� ����.

// ����� �ּ�ȭ�ϱ� ���ؼ�, ��¥ �ʿ��� ��찡 �ƴϸ� storage�� �����͸� ���� �ʴ� ���� ����. 
// �̸� ���� �����δ� �Ѻ��⿡ ��ȿ�������� ���̴� ���α׷��� ������ �� �ʿ䰡 �ֳ� - � �迭���� ������ ������ ã�� ����, �ܼ��� ������ �����ϴ� �� ��� �Լ��� ȣ��� ������ �迭�� memory�� �ٽ� ����� ��ó�� ������.

// ��κ��� ���α׷��� ������, ū ������ ������ ���� �����Ϳ� ��� �����ϴ� ���� ����� ��γ�. ������ �ָ���Ƽ������ �� ������ external view �Լ���� storage�� ����ϴ� �ͺ��� �� ������ ����̳�. 
// view �Լ��� ����ڵ��� ������ �Ҹ����� �ʱ� ��������(������ ����ڵ��� ��¥ ���� ���� ���̳�!).
// �츮�� ���� é�Ϳ��� for �ݺ����� �˾ƺ� ��������, ���� �޸𸮿� �迭�� �����ϴ� ����� �˾ƺ����� ����.


// �޸𸮿� �迭 �����ϱ�.

// Storage�� �ƹ��͵� ���� �ʰ� �Լ� �ȿ� ���ο� �迭�� ������� �迭�� memory Ű���带 ���� �ǳ�. �� �迭�� �Լ��� ���� �������� ������ ���̰�, �̴� storage�� �迭�� ���� ������Ʈ�ϴ� �ͺ��� ���� �Ҹ� ���鿡�� �ξ� �����ϳ� - �ܺο��� ȣ��Ǵ� view �Լ���� ��������.
// �޸𸮿� �迭�� �����ϴ� ����� ������ ����:

// function getArray() external pure returns(uint[]) {
//   // �޸𸮿� ���� 3�� ���ο� �迭�� �����Ѵ�.
//   uint[] memory values = new uint[](3);
//   // ���⿡ Ư���� ������ �ִ´�.
//   values.push(1);
//   values.push(2);
//   values.push(3);
//   // �ش� �迭�� ��ȯ�Ѵ�.
//   return values;
// }

// �̰� �ڳ׿��� ������ �����ֱ� ���� ���� ������ ���ÿ� �Ұ��ϳ׸�, ���� é�Ϳ����� ���� ��뿡 �� �� �ֵ��� for �ݺ����� �̰��� �����ϴ� ����� �˾ƺ� ���̳�.
// ����: �޸� �迭�� �ݵ�� ���� �μ��� �Բ� �����Ǿ�� �ϳ�(�� ���ÿ�����, 3). �޸� �迭�� ����μ��� storage �迭ó�� array.push()�� ũ�Ⱑ ���������� �ʳ�. ���� ������ �ָ���Ƽ������ ����� ���� �ְ����� ���̾�.

// ���� �غ���
// getZombiesByOwner �Լ�����, �츮�� Ư���� ����ڰ� ������ ��� ���� uint[] �迭�� ��ȯ�ϱ⸦ ���ϳ�.
// 1. result��� �̸��� uint[] memory ������ �����ϰ�.
// 2. �ش� ������ uint �迭�� �����ϰ�. �迭�� ���̴� �� _owner�� ������ ������ �������� �ϰ�, �̴� �츮�� mapping�� ownerZombieCount[_owner]�� ���ؼ� ã�� �� �ֳ�.
// 3. �Լ��� ������ result�� ��ȯ�ϰ�. ���� ������ �� �迭������, ���� é�Ϳ��� �̸� ä�� ���̳�.

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }

  function changeName(uint _zombieId, string memory _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
    // ���⼭ �����ϰ�
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    return result;
  }

}
