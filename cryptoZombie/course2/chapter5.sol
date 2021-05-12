// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 5: ���

// �츮�� ���� �ڵ尡 �� ������� �ֱ�. 
// ��û���� �� ��Ʈ��Ʈ �ϳ��� ����� ���ٴ� �ڵ带 �� �����ؼ� ���� ��Ʈ��Ʈ�� �ڵ� ������ ������ ���� �ո����� ���� ����.
// �̸� ���� �����ϱ� ������ �ϴ� �ָ���Ƽ ����� �ٷ� ��Ʈ��Ʈ _���_����.

// ����.
// contract Doge {
//   function catchphrase() public returns (string) {
//     return "So Wow CryptoDoge";
//   }
// }

// contract BabyDoge is Doge {
//   function anotherCatchphrase() public returns (string) {
//     return "Such Moon BabyDoge";
//   }
// }

// BabyDoge ��Ʈ��Ʈ�� Doge ��Ʈ��Ʈ�� ����ϳ�. 
// ��, �ڳװ� BabyDoge ��Ʈ��Ʈ�� �������ؼ� ������ ��, BabyDoge ��Ʈ��Ʈ�� catchphrase() �Լ��� anotherCatchphrase() �Լ��� ��� ������ �� �ִٴ� ������. (Doge ��Ʈ��Ʈ�� ���ǵǴ� �ٸ� � public �Լ��� ���ǵǾ ������ �����ϳ�)
// ��� ������ "����̴� �����̴�"�� ���ó�� �κ����� Ŭ������ ���� �� ���� ����� ���� Ȱ���� �� ����. 
// ������ ������ ������ �ټ��� Ŭ������ �����ؼ� �ܼ��� �ڵ带 ������ ���� Ȱ���� �� ����.

// ���� �غ���

// ���� é�Ϳ��� �츮 ������� ���̸� �԰� �����ϵ��� �ϴ� ����� ������ ���ϼ�. 
// �� ����� ������ ZombieFactory�� ��� �޼ҵ带 ����ϴ� Ŭ������ �־� ������ �ϼ�.

// ZombieFactory �Ʒ��� ZombieFeeding ��Ʈ��Ʈ�� �����Ѵ�. �� ��Ʈ��Ʈ�� ZombieFactory�� ����ؾ� �Ѵ�.

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
        // ���⼭ ����
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}