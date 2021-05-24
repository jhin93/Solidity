// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure

// é�� 10: ���� ������ �Գ���?

// getKitty �Լ��� � �Լ����� �˾� ��������, �̸� �̿��Ͽ� �������̽��� ����� �� �� ���� �ɼ�.
// KittyInterface��� �������̽��� �����Ѵ�. �������̽� ���ǰ� contract Ű���带 �̿��Ͽ� ���ο� ��Ʈ��Ʈ�� �����ϴ� �Ͱ� ���ٴ� ���� ����� ��.
// �������̽� ���� getKitty �Լ��� �����Ѵ� (���� �Լ����� �߰�ȣ ���� ��� ������ �����ϰ� return Ű���� �� ��ȯ �� ���������� ����/�ٿ��ֱ� �ϰ� �� ������ �����ݷ��� �־�� �Ѵ�).

import "./zombiefactory.sol";

// ���⿡ KittyInterface�� �����Ѵ�
contract KittyInterface {
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
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}
