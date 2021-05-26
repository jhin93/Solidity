// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure

// é�� 12: �ټ��� ��ȯ�� ó���ϱ�
// getKitty �Լ��� �츮�� ���� �� ���� �� �����ϰ� �ټ��� ��ȯ���� ���� �Լ�����. 
// �� é�Ϳ����� ��� �ټ��� ��ȯ���� ó���ϴ��� ���� ����.

// ���� ũ����ŰƼ ��Ʈ��Ʈ�� ��ȣ�ۿ��� �ð��̳�!
// ũ����ŰƼ ��Ʈ��Ʈ���� ����� �����ڸ� ���� �Լ��� ������ ����.

// 1. feedOnKitty��� �Լ��� �����Ѵ�. �� �Լ��� _zombieId�� _kittyId��� uint ���� �� 2���� ���޹ް�, public �Լ��� ����Ǿ�� �Ѵ�.
// 2. �� �Լ��� kittyDna��� uint�� ���� �����ؾ� �Ѵ�. ����: KittyInterface �������̽����� genes�� uint256��������, ���� 1���� ����� ������ �ǻ��� ���� uint�� uint256�� �ٸ� ǥ������, ���� ��������.
// 3. �� ����, �� �Լ��� _kittyID�� �����Ͽ� kittyContract.getKitty �Լ��� ȣ���ϰ� genes�� kittyDna�� �����ؾ� �Ѵ�.getKitty�� �ټ��� ������ ��ȯ�Ѵٴ� ����� ����� ��. (��Ȯ�� �����ڸ� 10���� ������ ��ȯ�Ѵ�)
//    ������ �츮�� ���� �ִ� ������ ������ ������ genes�̴�. ��ǥ ���� ������ ���� ���� �ٶ���!
// 4. ���������� �� �Լ��� feedAndMultiply�� ȣ���ϰ� �� �� _zombieId�� kittyDna�� �����ؾ� �Ѵ�.

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

// �ټ��� ��ȯ�� ó�� ����.

// function multipleReturns() internal returns(uint a, uint b, uint c) {
//   return (1, 2, 3);
// }

// function processMultipleReturns() external {
//   uint a;
//   uint b;
//   uint c;
//   // ������ ���� �ټ� ���� �Ҵ��Ѵ�:
//   (a, b, c) = multipleReturns();
// }

// // Ȥ�� �� �ϳ��� ������ ������ ���� ���: 
// function getLastReturnValue() external {
//   uint c;
//   // �ٸ� �ʵ�� ��ĭ���� ���⸸ �ϸ� �ȴ�: 
//   (,,c) = multipleReturns();
// }