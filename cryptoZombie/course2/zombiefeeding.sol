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

// contract LuckyNumber {
//   mapping(address => uint) numbers;

//   function setNum(uint _num) public {
//     numbers[msg.sender] = _num;
//   }

//   function getNum(address _myAddress) public view returns (uint) {
//     return numbers[_myAddress];
//   }
// }

// �� ��Ʈ��Ʈ�� �ƹ��� �ڽ��� ����� ���� ������ �� �ִ� ������ ��Ʈ��Ʈ�̰�, ������ �̴����� �ּҿ� ������ ���� ���̳�. 
// �� �ּҸ� �̿��ؼ� ������ �� ����� ����� ���� ã�� �� �� ����.
// ���� getNum �Լ��� �̿��Ͽ� �� ��Ʈ��Ʈ�� �ִ� �����͸� �а��� �ϴ� external �Լ��� �ִٰ� �� ����.
// ����, LuckyNumber ��Ʈ��Ʈ�� �������̽��� ������ �ʿ䰡 �ֳ�.

// contract NumberInterface {
//   function getNum(address _myAddress) public view returns (uint);
// }

// �ణ �ٸ�����, �������̽��� �����ϴ� ���� ��Ʈ��Ʈ�� �����ϴ� �Ͱ� �����ϴٴ� �� �����ϰ�. 
// ����, �ٸ� ��Ʈ��Ʈ�� ��ȣ�ۿ��ϰ��� �ϴ� �Լ����� ������ ��(�� ���, getNum�� �ٷ� �׷��� �Լ�����) �ٸ� �Լ��� ���� ������ ������� �ʳ�.
// ��������, �Լ� ��ü�� �������� ����. �߰�ȣ {, }�� ���� �ʰ� �Լ� ������ �����ݷ�(;)���� �����ϰ� ������.
// �׷��� �������̽��� ��Ʈ��Ʈ ����ó�� ���δٰ� �� �� ����. �����Ϸ��� �׷��� �������̽��� �ν�����.
// �츮�� dapp �ڵ忡 �̷� �������̽��� �����ϸ� ��Ʈ��Ʈ�� �ٸ� ��Ʈ��Ʈ�� ���ǵ� �Լ��� Ư��, ȣ�� ���, ����Ǵ� ���� ���뿡 ���� �� �� �ְ� ����.
// ���� �������� �ٸ� ��Ʈ��Ʈ�� �Լ��� ������ ȣ���� ���ϼ�. ������ ũ����ŰƼ ��Ʈ��Ʈ�� ���� �������̽��� ������ ����.


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
