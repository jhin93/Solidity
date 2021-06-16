// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* é�� 2: ���
���� é�Ϳ���, �츰 ��Ʈ��Ʈ�� �̴��� ������ ����� �����. �׷� �̴��� ���� �������� � ���� �Ͼ��?
�ڳװ� ��Ʈ��Ʈ�� �̴��� ������, �ش� ��Ʈ��Ʈ�� �̴����� ���¿� �̴��� ����ǰ� �ű⿡ ������ ���� - �ڳװ� ��Ʈ��Ʈ�κ��� �̴��� �����ϴ� �Լ��� ������ �ʴ´ٸ� ���̾�.
�ڳ״� ������ ���� ��Ʈ��Ʈ���� �̴��� �����ϴ� �Լ��� �ۼ��� �� �ֳ�:

contract GetPaid is Ownable {
  function withdraw() external onlyOwner {
    owner.transfer(this.balance);
  }
}
�츮�� Ownable ��Ʈ��Ʈ�� import �ߴٰ� �����ϰ� owner�� onlyOwner�� ����ϰ� �ִٴ� ���� �����ϰ�.
�ڳ״� transfer �Լ��� ����ؼ� �̴��� Ư�� �ּҷ� ������ �� �ֳ�. �׸��� this.balance�� ��Ʈ��Ʈ�� ������ִ� ��ü �ܾ��� ��ȯ����. 
�׷��� 100���� ����ڰ� �츮�� ��Ʈ��Ʈ�� 1�̴��� �����ߴٸ�, this.balance�� 100�̴��� �� ���̳�.

�ڳ״� transfer �Լ��� �Ἥ Ư���� �̴����� �ּҿ� ���� ���� �� �ֳ�. 
���� ���, ���� ������ �� �����ۿ� ���� �ʰ� ������ �ߴٸ�, �̴��� msg.sender�� �ǵ����ִ� �Լ��� ���� ���� �ֳ�:

uint itemFee = 0.001 ether;
msg.sender.transfer(msg.value - itemFee);

Ȥ�� �����ڿ� �Ǹ��ڰ� �����ϴ� ��Ʈ��Ʈ����, �Ǹ����� �ּҸ� storage�� �����ϰ�, ������ �Ǹ����� �������� �����ϸ� �����ڷκ��� ���� ����� �׿��� ������ ���� �ְ���:
seller.transfer(msg.value).

�̷� �͵��� �̴����� ���α׷����� ���� ������ ������ִ� ���õ��̳� - �ڳ״� �̰�ó�� �������Ե� ������� �ʴ� �л� ���͵��� ���� ���� �ֳ�.

���� �غ���
1. �츮 ��Ʈ��Ʈ�� withdraw �Լ��� �����ϰ�. �� �Լ��� ������ �� GetPaid ������ �����ؾ� �ϳ�.
2. �̴��� ������ ���ſ� ���� 10�� �̻� �پ���. �׷��� ���� �� ���� ���� ���������� 0.001�̴��� 1�޷� ���� ������, ���� �̰� �ٽ� 10�谡 �Ǹ� 0.001 ETH�� 10�޷��� �� ���̰� �츮�� ������ �� ����� ���̳�.
    �׷��� ��Ʈ��Ʈ�� �����ڷμ� �츮�� levelUpFee�� ������ �� �ֵ��� �ϴ� �Լ��� ����� ���� ������.
    2-a. setLevelUpFee��� �̸���, uint _fee�� �ϳ��� ���ڷ� �ް� external�̸� onlyOwner �����ڸ� ����ϴ� �Լ��� �����ϰ�.
    2-b. �� �Լ��� levelUpFee�� _fee�� �����ؾ� �ϳ�.
 */

import "./zombiefeeding.sol";
import "./ownable.sol";
contract ZombieHelper is ZombieFeeding {

  uint levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }

  // 1. ���⿡ withdraw �Լ��� �����ϰ�
  function withdraw() external onlyOwner {
    address(uint160(owner)).transfer(address(this).balance);
    // ���� 2 : "send" and "transfer" are only available for objects of type "address payable", not "address".
    // https://www.inflearn.com/questions/8249 - 2��° ���
    // https://www.programmersought.com/article/67734436660/ - address�� payable �ϰ� ��ȯ�Ͽ� �ۼ��Ѵ�.
  }

  // 2. ���⿡ setLevelUpFee�� �����ϰ�
  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

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
