// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 2: ���ΰ� �ּ�

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;
    // ���⼭ ���� ����
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) private {
        // ���Ӱ� Zombie ����ü�� �߰��� �� ������ �ε����� id�� ����Ѵ�.
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

// �ּ�

// �̴����� ���ü���� ���� ���¿� ���� ������� �̷���� ����. ������ �̴����� ���ü�λ��� ��ȭ�� _�̴�_�� �ܾ��� ������. 
// �ڳ��� ���� ���¿��� �ٸ� ���·� ���� �۱��� �� �ֵ���, ������ ���� �ٸ� ������ �̴��� �ְ� ���� �� ����.
// �� ������ ���� ���� ��ȣ�� ���� �ּҸ� ������ �ֳ�. �ּҴ� Ư�� ������ ����Ű�� ���� �ĺ��ڷ�, ������ ���� ǥ������:

// 0x0cE446255506E92DF41614C46F1d6df9Cc969183

// (�� �ּҴ� ũ�������� ���� �ּ���. �ڳװ� ũ�������� ���� �ִٸ� �츮���� �̴� �� ���� ������ �� �ְ���! ?)
// ���� �������� �ּҿ� ���� �ٽ� ������ �˾� �� ���ϼ�. ������ �ڳװ� "�ּҴ� Ư�� ����(Ȥ�� ����Ʈ ��Ʈ��Ʈ)�� �����Ѵ�"��� ���� �����ϸ� �ǳ�.
// �׷��ϱ� �ּҸ� �츮 ����鿡 ���� �������� ��Ÿ���� ���� ID�� Ȱ���� �� �ֳ�. 
// ������ �츮 ���� ���� ���ο� ���� �����ϸ� ���� �����ϴ� �Լ��� ȣ���� �̴����� �ּҿ� �� ���� ���� �������� �ο�����.