// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* é�� 12: For �ݺ���
���� é�Ϳ���, ������ �ڳװ� �Լ� ������ �迭�� �ٷ� ��, �׳� storage�� �ش� �迭�� �����ϴ� ���� �ƴ϶� for �ݺ����� ����ؼ� �����ؾ� �� ���� ���� ���̶� �߾���. �� �׷��� ���캸��.
getZombiesByOwner�� ������ ��, �������� ���� ����� ZombieFactory ��Ʈ��Ʈ���� �������� ���� ���뿡 ���� mapping�� ����� �����ϴ� ���� �ɼ�.
mapping (address => uint[]) public ownerToZombies
�׸����� ���ο� ���� ���� ������, �ش� �������� ���� �迭�� ownerToZombies[owner].push(zombieId)�� ����ؼ� �� ���� �߰��ϰ���. getZombiesByOwner �Լ��� ������ �����ϱ� ���� �Լ��� �� �Ծ�:

function getZombiesByOwner(address _owner) external view returns (uint[]) {
  return ownerToZombies[_owner];
} 
*/

/* �� ����� ����.
�̷��� ���� ����� ������ ������ ������ �ŷ������� ������. ������ ���� ���߿� �� ���� ���� �����ڿ��� �ٸ� ������� �����ϴ� �Լ��� �����ϰ� �ȴٸ� � ���� �Ͼ�� �����غ���(������ �������� �츰 �и� �� ����� ���ϰ� �� ���ϼ�).
���� ���� �Լ��� �̷� ������ �ʿ��� ���̳�:
1. ������ ���� ���ο� �������� ownerToZombies �迭�� �ִ´�.
2. ���� �������� ownerToZombies �迭���� �ش� ���� �����.
3. ���� ������ ������ �޿�� ���� ���� �������� �迭���� ��� ���� �� ĭ�� �����δ�.
4. �迭�� ���̸� 1 ���δ�.

3��° �ܰ�� �ش������� ���� �Ҹ� ���� ���̳�. �ֳ��ϸ� ��ġ�� �ٲ� ��� ���� ���� ���� ������ �ؾ� �ϱ� ��������. �����ڰ� 20������ ���� ������ �ְ� ù ��° ���� �ŷ��Ѵٸ�, �迭�� ������ �����ϱ� ���� �츰 19���� ���⸦ �ؾ� �� ���̳�.
�ָ���Ƽ���� storage�� ���� ���� ���� ����� ���� ���� �� �ϳ��̱� ������, �� ���� �Լ��� ���� ��� ȣ���� ���� ���鿡�� ������ ��ΰ� �� ���̳�. �� �� ���� ����, �� �Լ��� ����� ������ �ٸ� ���� ������ �Ҹ��� ���̶�� ���̳�. 
����ڰ� �ڽ��� ���뿡 �󸶳� ���� ���� ������ �ִ���, �� �ŷ��Ǵ� ������ �ε����� ���� �޶�������. �� ����ڵ��� �ŷ��� ������ �󸶳� ���� ���� �� �� ���� �ǳ�.

����: ����, �� �ڸ��� ä��� ���� ������ ���� ������ ����, �迭�� ���̸� �ϳ� �ٿ��� �ǰ���. ������ �׷��� �ϸ� ��ȯ�� �Ͼ ������ ���� ������ ������ �ٲ�� �� ���̳�.

view �Լ��� �ܺο��� ȣ��� �� ������ ������� �ʱ� ������, �츰 getZombiesByOwner �Լ����� for �ݺ����� ����ؼ� ���� �迭�� ��� ��ҿ� ������ �� Ư�� ������� ������ ������ �迭�� ���� �� ���� ���̳�. 
�׷��� ���� transfer �Լ��� �ξ� ����� ���� ���� �ǰ���. �ֳ��ϸ� storage���� � �迭�� �������� �ʿ䰡 �����ϱ� ���̾�. �Ϲ����� �������� �ݴ�� �̷� ���ٹ��� ��ü������ ��� �Ҹ� �� ����.
*/

/* for �ݺ��� ����ϱ�
�ָ���Ƽ���� for �ݺ����� ������ �ڹٽ�ũ��Ʈ�� ������ ����ϳ�.
¦���� ������ �迭�� ����� ���ø� �ѹ� ����:
function getEvens() pure external returns(uint[]) {
  uint[] memory evens = new uint[](5);
  // ���ο� �迭�� �ε����� �����ϴ� ����
  uint counter = 0;
  // for �ݺ������� 1���� 10���� �ݺ���
  for (uint i = 1; i <= 10; i++) {
    // `i`�� ¦�����...
    if (i % 2 == 0) {
      // �迭�� i�� �߰���
      evens[counter] = i;
      // `evens`�� ���� �� �ε��� ������ counter�� ������Ŵ
      counter++;
    }
  }
  return evens;
}
�� �Լ��� [2, 4, 6, 8, 10]�� ������ �迭�� ��ȯ�� ���̳�.
 */

 /* ���� �غ���
 for �ݺ����� �Ἥ getZombiesByOwner �Լ��� ���������� ����. 
 �ݺ��� �ȿ����� �츮 DApp �ȿ� �ִ� ��� ����鿡 �����ϰ�, �׵��� �����ڰ� �츮�� ã�� ������ ���Ͽ� Ȯ���� ��, ���ǿ� �´� ������� result �迭�� �߰��� �� ��ȯ�� ���̳�.
 1. counter��� �̸��� uint�� �ϳ� �����ϰ� 0�� �����ϰ�. �츰 result �迭���� �ε����� �����ϱ� ���� �� ������ ����� ���̳�.
 2. uint i = 0���� �����ؼ� i < zombies.length���� �����ϴ� for �ݺ����� �����ϰ�. �� �ݺ������� �츮 �迭�� ��� ���� ������ ���̳�.
 3. for �ݺ��� �ȿ���, zombieToOwner[i]�� _owner�� ������ Ȯ���ϴ� if ������ �����. �� ������ �� ���� �ּҰ��� ������ ���ϴ� ���̳�.
 4. if ���� �ȿ���:
  4-1. result[counter]�� i�� �����ؼ� result �迭�� ������ ID�� �߰��ϰ�.
  4-2. counter�� 1 ������Ű��(���� for �ݺ��� ���ø� �����ϰ�).
�̰� ���̶�� - �� �Լ��� ���� _owner�� ������ ��� ���� ������ �Ҹ����� �ʰ� ��ȯ�ϰ� �� ���̳�.
  */

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
