// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;
    
    function _createZombie(string _name, uint _dna) private {
        // �� storage�� �����ߴµ� ������ �ȵƴٰ� �ߴ� �ɱ�.
        Zombie storage dataSave = zombies[_name];
        dataSave.name = "it's name";
        // �� �� ������ �۵��� ���ϴ� ������ ����.
        zombies.push(Zombie(_name, _dna));
    }

}

// ���� ���ÿ��� �� �� �ֵ��� private Ű����� �Լ��� ������ ����. 
// �Լ� ���ڸ�� ���������� private�� �Լ��� �����(_)�� �����ϴ� ���� ���ʶ��.