// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure

// é�� 1: ��Ʈ��Ʈ�� �Һ���

// ���ݱ��� �� �͸����δ�, �ָ���Ƽ�� �ڹٽ�ũ��Ʈ ���� �ٸ� ���� �� ����غ����� ���̳�. ������ �̴����� DApp���� �Ϲ����� ���ø����̼ǰ��� �ٸ� �������� Ư¡�� ����.

// ù°��, �ڳװ� �̴����� ��Ʈ��Ʈ�� �����ϰ� ����, ��Ʈ��Ʈ�� ������ �ʴ´ٳ�(Immutable). �ٽ� �����ڸ� ��Ʈ��Ʈ�� �����ϰų� ������Ʈ�� �� ���ٴ� ������.
// �ڳװ� ��Ʈ��Ʈ�� ������ ������ �ڵ�� �׻�, ���ü�ο� ���������� �����Ѵٳ�. 
// �̰��� �ٷ� �ָ���Ƽ�� �־ ������ ������ ū �̽��� �������. ���� �ڳ��� ��Ʈ��Ʈ �ڵ忡 ������ �ִٸ�, �װ��� ���Ŀ� ��ĥ �� �ִ� ����� ���� ���ٳ�. 
// �ڳ״� ����ڵ鿡�� ������ ������ �ٸ� ����Ʈ ��Ʈ��Ʈ �ּҸ� ����� ���ϰ� �ٳ�� �� ���̳�.

// �׷��� �̰� ���� ����Ʈ ��Ʈ��Ʈ�� �� Ư¡�̳�. �ڵ�� �� ���� ������. 
// �ڳװ� � ����Ʈ ��Ʈ��Ʈ�� �ڵ带 �а� ������ �ߴٸ�, �ڳ״� �ڳװ� �Լ��� ȣ���� ������, �ڵ忡 ������ �״�� �Լ��� ����� ���̶�� Ȯ���� �� �ֳ�. 
// �� ������ ���� ���Ŀ� �Լ��� �����ϰų� ����ġ ���� ����� �߻���Ű�� ���Ѵٳ�.

// �ܺ� ������.

// ���� 2����, �츮�� ũ����ŰƼ ��Ʈ��Ʈ�� �ּҸ� �츮 DApp�� ���� ��־���. �׷��� ���� ũ����ŰƼ ��Ʈ��Ʈ�� ���װ� �־���, ������ ��� ����̵��� �ı��ع��ȴٸ� ��� �� �� ������?
// �׷� ���� �� ��������, ���� �׷� ���� �߻��Ѵٸ� �츮�� DApp�� ������ ���� ������ ���̳�. �츮 DApp�� �ּҸ� �ڵ忡 ���� ��ֱ� ������ � ����̵鵵 �޾ƿ� �� ������. 
// �츮 ������� ����̸� ���� �� ���� ���̰�, �츮�� �װ� ��ġ�� ���� �츮�� ��Ʈ��Ʈ�� ������ ���� ���� ���̳�.
// �̷� ������, �밳�� ��� �ڳװ� �ڳ� DApp�� �߿��� �Ϻθ� ������ �� �ֵ��� �ϴ� �Լ��� �������� ���� �ո����̰���.
// ���� ���ڸ� �츮 DApp�� ũ����ŰƼ ��Ʈ��Ʈ �ּҸ� ���� ��ִ� �� ���, ������ ũ����ŰƼ ��Ʈ��Ʈ�� ������ ����� �ش� �ּҸ� �ٲ� �� �ֵ��� ���ִ� setKittyContractAddress �Լ��� ���� �� ���� ���̳�.

// ���� �غ���.
// ���� 2���� �츮�� ���� �ڵ带 ũ����ŰƼ ��Ʈ��Ʈ �ּ��� ������Ʈ�� �����ϵ��� �ٲ㺸��.
// 1. �츮�� ���� �ּҸ� ��־��� ckAddress�� �ִ� ���� �����.
// 2. �츮�� kittyContract�� �����ߴ� ���� ���� ���� �ϵ��� �����ϰ� - � �͵� ������ ���� �ʵ��� �ϰ�.
// 3. setKittyContractAddress��� �̸��� �Լ��� �����ϰ�. �� �Լ��� address Ÿ���� ���� _address�� �ϳ��� ���ڷ� �ް�, external �Լ����� �ϳ�.
// 4. �Լ� ������, kittyContract�� KittyInterface(_address)�� �����ϴ� �� ���� �ڵ带 �ۼ��ϰ�.

import "./zombiefactory.sol";

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

  // 1. �� ���� �����:
  // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  // 2. ���⼭ ������ ���� �׳� �������� �ٲٰ�:
  KittyInterface kittyContract;

  // 3. ���� setKittyContractAddress �޼ҵ带 �߰��ϰ�
  function setKittyContractAddress(address _address) external {
    kittyContract = KittyInterface(_address);
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
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}