// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure

// é�� 10: ���� ������ �Գ���?

// ���� ����鿡�� ���̸� �� �ð��̱�! ���� ���� �����ϴ� ���̰� ����?
// ũ�������� ���� �����ϴ� ���̴�... ũ����ŰƼ! ???(�׷�, �����̶�� ? )
// ���񿡰� ũ����ŰƼ�� ���̷� �ַ��� ũ����ŰƼ ����Ʈ ��Ʈ��Ʈ���� ŰƼ DNA�� �о�;� �� ���̳�. 
// �̰� ������ ������ ũ����ŰƼ �����Ͱ� ���ü�� �� ���������� ����Ǿ� �ֱ� ��������. ���ü���� ȯ�������� �ʳ�?!
// ���� ���� - �츮 ������ ��� ������ ũ����ŰƼ���Ե� ���� �ظ� ��ġ�� ���� ���̴� ���ϼ�. 
// �츰 ���� ũ����ŰƼ �����͸� �о� �� ������. ������ �� �����͸� ���� ���� ���ٳ�. ?

// [�ٸ� ��Ʈ��Ʈ�� ��ȣ�ۿ��ϱ�]

// ���ü�� �� �����鼭 �츮�� �������� ���� ��Ʈ��Ʈ�� �츮 ��Ʈ��Ʈ�� ��ȣ�ۿ��� �Ϸ��� �켱 �������̽��� �����ؾ� �ϳ�.
// ������ ���ø� ���� ������ ����. ������ ���� ���ü�� ��Ʈ��Ʈ�� �ִٰ� �� ����:

contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}


import "./zombiefactory.sol";

// ���⿡ KittyInterface�� �����Ѵ�

contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}
