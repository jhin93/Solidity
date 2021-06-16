// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
// �Լ� ������ ����.
// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// ����� ���� ������ : 'modifier' - lesson3 é�� 3 ����.
// payable ������ : �̴��� ���� �� �ִ� Ư���� �Լ� ����.

import "./zombiefactory.sol";

/* é�� 6: ���� ���� ���� �����ϱ�(Refactoring)
���� �츮�� attack �Լ��� �����ϵ��� - �츮�� ����ڰ� ���ݿ� ����ϴ� ���� ������ �����ϰ� �ִٴ� ���� Ȯ���� �ϰ� �ͳ�. 
���� �ڳװ� �ٸ� ����� ���� ����ؼ� ������ �� �ִٸ� ���ȿ� ������ �Ǵ� �κ��� ���̾�!
�Լ��� ȣ���ϴ� ����� �װ� ����� _zombieId�� ���������� Ȯ���� ����� �����س� �� �ְڴ°�? �� �� �����غ��鼭, �ڳ� ������ ���� �����س� �� �ִ��� Ȯ���غ���.

�ð��� ������... ���̵� ���� ���� �������� �����غ���. �ذ�å�� �Ʒ��� ������, ������ ���� ������ ���� ������ �ϰ�. 

_�ذ�å
�츰 ���� �����鿡�� �̷� ������ Ȯ���� ���� �� �ؿԾ���. changeName(), changeDna(), feedMultiply()����, �츮�� ������ ���� ����� ���:
require(msg.sender == zombieToOwner[_zombieId]);
�츮�� attack �Լ����� �Ȱ��� ������ ������ �ʿ䰡 �ֳ�. ������ ������ ���� �� ����ϰ� ������, �ڵ带 �����ϰ� �ݺ��� ���� �� �ֵ��� �� ������ �̰͸��� modifier�� �ű⵵�� �ϼ�.

_���� �غ���
zombiefeeding.sol�� �ٽ� ������ �ϰڳ�. �� ������ ó������ ��� ���̴� ���̾�. Ȯ�� �κ��� �� �κи��� modifier�� ����� ������ �����ϰڳ�.
1. modifier�� ownerOf��� �̸����� �����. �� �����ڴ� _zombieId(uint)�� 1���� �μ��� ���� ���̳�. ������ ���뿡���� msg.sender�� zombieToOwner[_zombieId]�� ������ require�� Ȯ���ϰ�, �Լ��� �����ؾ� �ϳ�. 
   �������� ������ ����� ���� �ʴ´ٸ� zombiehelper.sol�� �����ϸ� �ǳ�.
2. feedAndMultiply�� �Լ� ���� �κ��� ownerOf �����ڸ� ����ϵ��� �ٲٰ�.
3. ���� modifier�� ����ϰ� ������, require(msg.sender == zombieToOwner[_zombieId]); ���� ������ �ǳ�.
*/

interface KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  KittyInterface kittyContract;

  // 1. ���⿡ �����ڸ� �����ϰ�
  modifier ownerOf(uint _zombieId) {
      require(msg.sender == zombieToOwner[_zombieId]);
      _;
  }

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(block.timestamp + cooldownTime);
  }
  function _isReady(Zombie storage _zombie) internal view returns (bool) {
    return (_zombie.readyTime <= block.timestamp);
  }

  // string�� memory�� ����ؾ� �ϴ� ����. 
  // solidity 0.5.0 �������ʹ� ����ü, �迭 �Ǵ� ���� ���� ��� ������ ���� ������ ��ġ�� ����ϴ� ���� �ʼ�. bytes �� string Ÿ���� ������ Ư���� ������ �迭�Դϴ�(https://solidity-kr.readthedocs.io/ko/latest/types.html#arrays).
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal ownerOf(_zombieId){
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie)); 
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


