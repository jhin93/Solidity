// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* é�� 1: Payable
���ݱ��� �츰 �� ���� �Լ� ������(function modifier)�� �ٷ��. ��� ���� �� ����ϴ� ���� ���� ���̴�, �ѹ� ������ �����غ���.

1. �츰 �Լ��� ����, ��� ȣ��� �� �ִ��� �����ϴ� ���� ������(visibility modifier)�� �˰� �Ǿ���: 
private : private�� ��Ʈ��Ʈ ������ �ٸ� �Լ��鿡���� ȣ��� �� ������ �ǹ�����. 
internal : internal�� private�� ���������, �ش� ��Ʈ��Ʈ�� ����ϴ� ��Ʈ��Ʈ������ ȣ��� �� ����.
external : external�� ���� ��Ʈ��Ʈ �ܺο����� ȣ��� �� �ֳ�.
public : ���������� public�� ���ܺ� ��ο���, ��𼭵� ȣ��� �� �ֳ�.

2. ���� ���� ������(state modifier)�� ���ؼ��� �����. �� �����ڴ� ���ü�ΰ� ��ȣ�ۿ� �ϴ� ����� ���� �˷�����: 
view : view�� �ش� �Լ��� �����ص� � �����͵� ����/������� ������ �˷�����.
pure : pure�� �ش� �Լ��� � �����͵� ���ü�ο� �������� ���� �Ӹ� �ƴ϶�, ���ü�����κ��� � �����͵� ���� ������ �˷�����. 
�̵� ��δ� ��Ʈ��Ʈ �ܺο��� �ҷ��� �� ������ ���� �Ҹ����� �ʳ�(������ �ٸ� �Լ��� ���� ���������� ȣ����� ��쿡�� ������ �Ҹ�����).

3. �׸��� ����� ���� ������(modifier)�� ���ؼ��� �����. ���� 3���� ����� ������. ���� ���ڸ� onlyOwner�� aboveLevel ���� ������. 
�̷� �����ڸ� ����ؼ� �츰 �Լ��� �� �����ڵ��� ��� ������ ������ �����ϴ� �츮���� ���� ������ �� �ֳ�.

�̷� �����ڵ��� �Լ� �ϳ��� ����ó�� �Բ� ����� �� �ֳ�:
function test() external view onlyOwner anotherModifier { ... }
�̹� é�Ϳ���, �츰 �Լ� �����ڸ� �ϳ� �� �Ұ��� ���̳�: �ٷ� payable����.

 -- payable ������ --

payable �Լ��� �ָ���Ƽ�� �̴������� ���� ������ ����� �� �� �ϳ���� - �̴� �̴��� ���� �� �ִ� Ư���� �Լ� ��������.
����� ������ �� �ֵ��� ��� �ð��� ����. �ڳװ� �Ϲ����� �� �������� API �Լ��� ������ ������, �ڳ״� �Լ� ȣ���� ���ؼ� US �޷��� ���� �� ���� - ��Ʈ���ε� ���� �� ����.
������ �̴����򿡼���, ��(_�̴�_), ������(transaction payload), �׸��� ��Ʈ��Ʈ �ڵ� ��ü ��� �̴����� ���� �����ϱ� ������, �ڳװ� �Լ��� �����ϴ� ���ÿ� ��Ʈ��Ʈ�� ���� �����ϴ� ���� �����ϳ�.

�̸� ���� ������ ��̷ο� ������ ���� �� �ֳ�. �Լ��� �����ϱ� ���� ��Ʈ��Ʈ�� ���� �ݾ��� �����ϰ� �ϴ� �Ͱ� ���� ���̾�. ���ø� �ѹ� ����.

contract OnlineStore {
  function buySomething() external payable {
    // �Լ� ���࿡ 0.001�̴��� ���������� Ȯ���� �ϱ� ���� Ȯ��:
    require(msg.value == 0.001 ether);
    // �������ٸ�, �Լ��� ȣ���� �ڿ��� ������ �������� �����ϱ� ���� ���� ����:
    transferThing(msg.sender);
  }
}
���⼭, msg.value�� ��Ʈ��Ʈ�� �̴��� �󸶳� ���������� Ȯ���ϴ� ����̰�, ether�� �⺻������ ���Ե� �����̳�.
���⼭ �Ͼ�� ���� ������ web3.js(DApp�� �ڹٽ�ũ��Ʈ ����Ʈ����)���� ������ ���� �Լ��� ������ �� �߻��ϳ�:

// `OnlineStore`�� �ڳ��� �̴����� ���� ��Ʈ��Ʈ�� ����Ų�ٰ� �����ϳ�:
OnlineStore.buySomething({from: web3.eth.defaultAccount, value: web3.utils.toWei(0.001)})

value �ʵ带 �ָ��ϰ�. �ڹٽ�ũ��Ʈ �Լ� ȣ�⿡�� �� �ʵ带 ���� ether�� �󸶳� ������ �����ϳ�(���⼭�� 0.001����). 
Ʈ������� ������ �����ϰ�, �Լ� ȣ�⿡ �����ϴ� �Ű� ������ �ڳװ� ����� ������ �����̶� �����Ѵٸ�, value�� ���� �ȿ� ������ �ִ� �Ͱ� ���� - ������ ���� ��� �����ο��� ���޵���.
����: ���� �Լ��� payable�� ǥ�õ��� �ʾҴµ� �ڳװ� ������ �� ��ó�� �̴��� ������ �Ѵٸ�, �Լ����� �ڳ��� Ʈ������� �ź��� ���̳�.

���� �غ���.
���� payable �Լ��� �츮�� ���� ���ӿ� ������.
�츮 ���ӿ� ������ �������� ���� ����ڵ��� ETH�� ������ �� �ִ� ����� �ִٰ� �����غ���. 
ETH�� �ڳװ� ������ ��Ʈ��Ʈ�� ����� ���̳� - �̴� �ڳ��� ������ ���� �ڳװ� ���� �� �� �ִ� ������ �����̳�!

1. uint Ÿ���� levelUpFee ������ �����ϰ�, ���⿡ 0.001 ether�� �����ϰ�.
2. levelUp�̶�� �Լ��� �����ϰ�. �� �Լ��� _zombieId��� uint Ÿ���� �Ű����� �ϳ��� ���� ���̳�. �Լ��� external�̸鼭 payable�̾�� �ϳ�.
3. �� �Լ��� ���� msg.value�� levelUpFee�� ������ require�� Ȯ���ؾ� �ϳ�.
4. �׸��� ������ level�� �������Ѿ� �ϳ�: zombies[_zombieId].level++.
 */

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  // 1. ���⿡ levelUpFee�� �����ϰ�
  uint levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }

  // 2. ���⿡ levelUp �Լ��� �����ϰ�
  function levelUp (uint _zombieId) external payable {
    require(msg.value == levelUpFee);
    zombies[_zombieId].level++;
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
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    // ���⼭ �����ϰ�
    uint counter = 0;
    for(uint i = 0; i < zombies.length; i++){
      if(zombieToOwner[i] == _owner){
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
