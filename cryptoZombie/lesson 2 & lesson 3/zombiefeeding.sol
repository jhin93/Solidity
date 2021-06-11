// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// �Լ� ������ : 'modifier' - lesson3 é�� 3 ����.

import "./zombiefactory.sol";

// é�� 6: ���� ���� ��� �ð�

// ���� Zombie ����ü�� readyTime �Ӽ��� ������ ������, zombiefeeding.sol�� ���� ���� ��� �ð� Ÿ�̸Ӹ� �����غ����� ����.
// �츰 feedAndMultiply�� ������ ���� ������ ���̳�: 1. ���̸� ������ ���� ���� ��⿡ ����, 2. ����� ���� ��� �ð��� ���� ������ ����̵��� ���� �� ����.
// �̷��� �ϸ� ������� ���Ӿ��� ����̵��� �԰� ������ �����ϴ� ���� ���� �� ����. ���߿� �츮�� ���� ����� �߰��ϸ�, �ٸ� ������� �����ϴ� �͵� ���� ��� �ð��� �ɸ����� �� ���̳�.
// ����, �츮�� ������ readyTime�� �����ϰ� Ȯ���� �� �ֵ��� ���ִ� ���� �Լ��� ������ ���̳�.

// ����ü�� �μ��� �����ϱ�.

// �ڳ״� private �Ǵ� internal �Լ��� �μ��μ� ����ü�� storage �����͸� ������ �� �ֳ�. �̰� ���� ��� �Լ��� ���� �츮�� Zombie ����ü�� �ְ���� �� �����ϳ�.
// ������ �̿� ���� �����:

// function _doStuff(Zombie storage _zombie) internal {
//   // _zombie�� �� �� �ִ� �͵��� ó��
// }
// �̷� ������� �츮�� �Լ��� ���� ID�� �����ϰ� ���� ã�� ���, �츮�� ���� ���� ������ ������ �� �ֳ�.

// ���� �غ���
// 1. _triggerCooldown�� �����ϸ鼭 ��������. �� �Լ��� 1���� �μ��� Zombie storage ������ Ÿ���� _zombie�� �޳�. �� �Լ��� internal�̾�� �ϳ�.
// 2. �Լ��� ���뿡���� _zombie.readyTime�� uint32(now + cooldownTime)���� �����ؾ� �ϳ�.
// 3. ��������, _isReady��� �Ҹ��� �Լ��� �����. �� �Լ� ���� _zombie��� �̸��� Zombie storage Ÿ�� �μ��� �޳�. internal view���� �ϰ�, bool�� �����ؾ� �ϳ�.
// 4. �Լ��� ���뿡���� (_zombie.readyTime <= now)�� �����ؾ� �ϰ�, �̴� true �ƴϸ� false�� ���� ���̳�. �� �Լ��� �츮���� ���� ���̸� ���� �� ����� �ð��� �������� �˷��� ���̳�.

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

  // 1. `_triggerCooldown` �Լ��� ���⿡ �����ϰ�
  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(block.timestamp + cooldownTime);
  }
  // 2. `_isReady` �Լ��� ���⿡ �����ϰ�
  function _isReady(Zombie storage _zombie) internal view returns (bool) {
    return (_zombie.readyTime <= block.timestamp);
  }

  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if(keccak256(abi.encodePacked(_species)) == keccak256("kitty")){
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // lesson 2 é�� 12: �ټ��� ��ȯ�� ó���ϱ�. �� �ϳ��� ������ ������ ���� ���, �ٸ� �ʵ�� ��ĭ���� ���⸸ �ϸ� �ȴ�.
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


