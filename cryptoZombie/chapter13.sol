// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);
    // ���⿡ �̺�Ʈ ����
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        // ���Ӱ� Zombie ����ü�� �߰��� �� ������ �ε����� id�� ����Ѵ�.
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // ��ó�� ����� �� ������ ���� ���� �߻�. Different number of components on the left hand side (1) than on the right hand side
        // ũ�������񿡼� ������ ������ �� ���� �������̷� ����. 
        
        // ���⼭ �̺�Ʈ ����
        NewZombie(id, _name, _dna);

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

