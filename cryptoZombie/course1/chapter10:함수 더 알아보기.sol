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

    // ���⼭ ����

    function _generateRandomDna(string _str) private view returns (uint) {

    }

}

// ��ȯ��
// �Լ����� � ���� ��ȯ �������� ������ ���� �����ؾ� �ϳ�:

string greeting = "What's up dog";

function sayHello() public returns (string) {
  return greeting;
}
// �ָ���Ƽ���� �Լ� ������ ��ȯ�� ������ �������� (�� ��쿡�� string�̳�).

// �Լ� ������
// ������ ���� �� �Լ� sayHello()�� �ָ���Ƽ���� ���¸� ��ȭ��Ű�� �ʴ´ٳ�. ��, � ���� �����ϰų� ���𰡸� ���� ����.

// �� ��쿡�� �Լ��� view �Լ��� �����Ѵٳ�. �̴� �Լ��� �����͸� ���⸸ �ϰ� �������� �ʴ´ٴ� ������:

function sayHello() public view returns (string) {
// �ָ���Ƽ�� pure �Լ��� ������ �ִµ�, �̴� �Լ��� �ۿ��� � �����͵� �������� �ʴ� ���� �ǹ�����. ������ ���캸��

function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}

// �� �Լ��� �ۿ��� �д� �͵� ���� �ʰ�, �ٸ� ��ȯ���� �Լ��� ���޵� ���ڰ��� ���� �޶�����. �׷��� �� ��쿡 �Լ��� pure�� ��������.
// ����: �Լ��� pure�� view�� ���� ǥ������ ����ϱ� ����� �� ����. �� ���Ե� �ָ���Ƽ �����Ϸ��� � �����ڸ� ��� �ϴ��� ��� �޽����� ���� �� �˷��ֳ�.
