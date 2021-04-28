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

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

}

// �ǹ��� �ذ�.
// https://ethereum.stackexchange.com/questions/63294/typeerror-data-location-must-be-storage-or-memory-for-parameter-in-function
// solidity 0.5.0 �������ʹ� ����ü, �迭 �Ǵ� ���� ���� ��� ������ ���� ������ ��ġ�� ����ϴ� ���� �ʼ�.

// private�� ��Ʈ��Ʈ ���� �ٸ� �Լ��鸸�� �� �Լ��� ȣ���Ͽ� numbers �迭�� ���𰡸� �߰��� �� �ִٴ� ���� �ǹ�����.
// ���� ���ÿ��� �� �� �ֵ��� private Ű����� �Լ��� ������ ����. 
// �Լ� ���ڸ�� ���������� private�� �Լ��� �����(_)�� �����ϴ� ���� ���ʶ��.