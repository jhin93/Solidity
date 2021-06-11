// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// �Լ� ������ : 'modifier' - lesson3 é�� 3 ����.

import "./zombiefactory.sol";

// é�� 7: Public �Լ� & ����

// ���� feedAndMultiply�� �츮�� ���� ��� �ð� Ÿ�̸Ӹ� ����ϵ��� �����غ���.

// �� �Լ��� �ٽ� ���캸��, �츮�� ���� �������� �� �Լ��� public���� ������� ���� �� �� ���� ���̳�. 
// ������ �����ϴ� ���� ����� �ڳ��� ��� public�� external �Լ��� �˻��ϰ�, ����ڵ��� �� �Լ����� ������ �� �ִ� ����� �����غ��� ���̳�. 
// �̰� ����Ͻð� - �� �Լ����� onlyOwner ���� �����ڸ� ���� �ʴ� �̻�, � ����ڵ� �� �Լ����� ȣ���ϰ� �ڽŵ��� ���ϴ� ��� �����͸� �Լ��� ������ �� �ֳ�.

// ���� �Լ��� �ٽ� ���캸��, ����ڵ��� �� �Լ��� ���������� ȣ���� �� �ְ� �׵��� ���ϴ� �ƹ� _targetDna�� _species�� ������ �� �ֳ�. �̰� ���� ���� ������ �ʱ� - �츮�� �׵��� �츮�� ��Ģ�� ������ �ٶ��!
// �� �� �ڼ��� �鿩����, �� �Լ��� ���� feedOnKitty()�� ���ؼ��� ȣ���� �� �ʿ䰡 �ֳ�. �׷��� �̷� ������ ���� ���� ���� ����� �� �Լ��� internal�� ����� ������.

// ���� �غ���
// 1. ���� feedAndMultiply�� public �Լ��̳�. �̰� internal�� ���� ��Ʈ��Ʈ�� �� ������������ �ϼ�. �츮�� ����ڵ��� �׵��� ���ϴ� �ƹ� DNA�� �־ �� �Լ��� �����ϴ� ���� ������ �ʳ�.
// 2. feedAndMultiply �Լ��� cooldownTime�� ����ϵ��� ������. ����, myZombie�� ã�� �Ŀ�, _isReady()�� Ȯ���ϴ� require ������ �߰��ϰ� �ű⿡ myZombie�� �����ϰ�. �̷��� �ϸ� ����ڵ��� ������ ���� ��� �ð��� ���� �������� �� �Լ��� ������ �� �ֳ�.
// 3. �Լ��� ������ _triggerCooldown(myZombie) �Լ��� ȣ���Ͽ� ���̸� �Դ� ���� ������ ���� ��� �ð��� ���鵵�� �ϰ�.

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

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(block.timestamp + cooldownTime);
  }
  function _isReady(Zombie storage _zombie) internal view returns (bool) {
    return (_zombie.readyTime <= block.timestamp);
  }

  // 1. �� �Լ��� internal�� �����
  // string�� memory�� ����ؾ� �ϴ� ����. 
  // solidity 0.5.0 �������ʹ� ����ü, �迭 �Ǵ� ���� ���� ��� ������ ���� ������ ��ġ�� ����ϴ� ���� �ʼ�. bytes �� string Ÿ���� ������ Ư���� ������ �迭�Դϴ�(https://solidity-kr.readthedocs.io/ko/latest/types.html#arrays).
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    // 2. ���⿡ `_isReady`�� Ȯ���ϴ� �κ��� �߰��ϰ�
    require(_isReady(myZombie)); 
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // keccak256 ���ο� �Լ� ���ڸ� ���� ��쿡 abi.encodePacked(arg) �� ���� ����� ��. 
    if (keccak256(abi.encodePacked(_species)) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    // 3. `_triggerCooldown`�� ȣ���ϰ�
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // lesson 2 é�� 12: �ټ��� ��ȯ�� ó���ϱ�. �� �ϳ��� ������ ������ ���� ���, �ٸ� �ʵ�� ��ĭ���� ���⸸ �ϸ� �ȴ�.
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


