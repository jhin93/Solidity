// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure

// é�� 13: ���ʽ�: ŰƼ ������

// �츮�� �Լ� ������ ���� �Ϸ�Ǿ���... ������ �� ������ ���ʽ��� �߰��� ������ �ϼ�.
// ����� �����ڿ� ���յǾ� ������ ���� �� ���� ��Ư�� Ư���� ������ ����� ����� ���̵��� �� ����. �̸� ���� ���� DNA�� �� ���� Ư���� ŰƼ �ڵ带 �߰��� �� �ֳ�.
// ���� 1���� ��� ������ ���÷� ����, ������ �ܸ� �����ϴ� �� �־ 16�ڸ� DNA �߿��� ó�� 12�ڸ��� �̿����. �׷��� ���������� 2�ڸ� ���ڸ� Ȱ���Ͽ� "Ư����" Ư���� ����� ����.
// ����� ����� DNA ������ 2�ڸ��� 99�� ���´ٰ� �� ����. �׷��� �츮 �ڵ忡���� ����(if) ���� ����̿��� �����Ǹ� ���� DNA�� ������ 2�ڸ��� 99�� �����Ѵ�.

// �츮�� ���� �ڵ忡 ����� �����ڿ� ���� ������ ������ ����.

// 1. ����, feedAndMultiply �Լ� ���Ǹ� �����Ͽ� _species��� string�� ����° ���� ������ ���޹޵��� �Ѵ�.
// 2. �� ����, ���ο� ���� DNA�� ����� �Ŀ� if ���� �߰��Ͽ� _species�� "kitty" ��Ʈ�� ������ keccak256 �ؽð��� ���ϵ��� �Ѵ�.
// 3. if �� ������ DNA ������ 2�ڸ��� 99�� ��ü�ϰ��� �Ѵ�. �Ѱ��� ����� newDna = newDna - newDna % 100 + 99; ������ �̿��ϴ� ���̴�.
// ����: newDna�� 334455��� �ϸ� newDna % 100�� 55�̰�, ���� newDna - newDna % 100�� 334400�̴�. ���������� ���⿡ 99�� ���ϸ� 334499�� ��� �ȴ�.
// 4. ����������, feedOnKitty �Լ� ������ �̷����� �Լ� ȣ���� �����ؾ� �Ѵ�. feedAndMultiply�� ȣ��� ��, "kitty"�� ������ ���ڰ����� �����Ѵ�.

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
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }

    // ���⿡ �Լ��� ���� 
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
      uint kittyDna;
      (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
      feedAndMultiply(_zombieId, kittyDna);
    }
}

// if��.
// �ָ���Ƽ���� if ���� �ڹٽ�ũ��Ʈ�� if ���� �����ϴ�.

// function eatBLT(string sandwich) public {
//   // ��Ʈ�� ���� ���� ���θ� �Ǵ��ϱ� ���� keccak256 �ؽ� �Լ��� �̿��ؾ� �Ѵٴ� ���� ������� 
//   if (keccak256(sandwich) == keccak256("BLT")) {
//     eat();
//   }
// }