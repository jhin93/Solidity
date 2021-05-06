// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 3: Msg.sender

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
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] ++;
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

// ���� 1���� �ٷ�� _createZombie �޼ҵ带 ������Ʈ�Ͽ� �� �Լ��� ȣ���ϴ� ������ ���� �������� �ο��ϵ��� �� ����.

// ����, ���ο� ������ id�� ��ȯ�� �Ŀ� zombieToOwner ������ ������Ʈ�Ͽ� id�� ���Ͽ� msg.sender�� ����ǵ��� �غ���.
// �� ����, ����� msg.sender�� ����Ͽ� ownerZombieCount�� ������Ű��.

// �ڹٽ�ũ��Ʈ�� ���������� �ָ���Ƽ������ uint�� ++�� ������ų �� �ִ�.

// uint number = 0;
// number++;
// `number`�� ���� `1`�̴�