// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure

// é�� 2: ���� ������ ��Ʈ��Ʈ

// �ڳ�, ���� é�Ϳ��� ���� ������� �߰��ߴ°�?

// setKittyContractAddress �Լ��� external�̶�, ������ �� �Լ��� ȣ���� �� �ֳ�! 
// �̴� �ƹ��� �� �Լ��� ȣ���ؼ� ũ��ƮŰƼ ��Ʈ��Ʈ�� �ּҸ� �ٲ� �� �ְ�, ��� ����ڸ� ������� �츮 ���� ���������� ���� �� �ִٴ� ������.
// �츮�� �츮 ��Ʈ��Ʈ���� �� �ּҸ� �ٲ� �� �ְԲ� �ϰ� ������, �׷��ٰ� ��� ����� �ּҸ� ������Ʈ�� �� �ֱ⸦ �������� �ʳ�.
// �̷� ��쿡 ��ó�ϱ� ���ؼ�, �ֱٿ� �ַ� ���� �ϳ��� ����� ��Ʈ��Ʈ�� ���� �����ϰ� ����� ���̳�. ��Ʈ��Ʈ�� ������� Ư���� �Ǹ��� ������ �����ڰ� ������ �ǹ��ϴ� ������.

// ���� �غ���
// �츮�� ���� Ownable ��Ʈ��Ʈ�� �ڵ带 ownable.sol�̶�� ���ο� ���Ϸ� �����س��ٳ�. � ZombieFactory�� �̰� ��ӹ޵��� ������.
// 1. �츮 �ڵ尡 ownable.sol�� ������ import�ϵ��� �����ϰ�. ��� �ϴ��� ����� ���� �ʴ´ٸ� zombiefeeding.sol�� ���캸��.
// 2. ZombieFactory ��Ʈ��Ʈ�� Ownable�� ����ϵ��� �����ϰ�. �ٽ� ��������, �̰� ��� �ϴ��� �� ��ﳪ�� �ʴ´ٸ� zombiefeeding.sol�� ���캸��.

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

  KittyInterface kittyContract;

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