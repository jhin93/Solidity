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
        zombies.push(Zombie(_name, _dna));
    }

}

// private�� ��Ʈ��Ʈ ���� �ٸ� �Լ��鸸�� �� �Լ��� ȣ���Ͽ� numbers �迭�� ���𰡸� �߰��� �� �ִٴ� ���� �ǹ�����.

// ���� ���ÿ��� �� �� �ֵ��� private Ű����� �Լ��� ������ ����. 

// �Լ� ���ڸ�� ���������� private�� �Լ��� �����(_)�� �����ϴ� ���� ���ʶ��.