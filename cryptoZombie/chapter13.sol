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
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        // uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // ��ó�� ����� �� ������ ���� ���� �߻�. Different number of components on the left hand side (1) than on the right hand side
        // ũ�������񿡼� ������ ������ �� ���� �������̷� ����. 
        // �ذ�. https://ethereum.stackexchange.com/questions/89792/typeerror-different-number-of-components-either-side-of-equation
        // ���� 0.6���� push�� length�� ��ȯ���� �ʰ� ���ϱ� ��ɸ� ������. 

        // ���⼭ �̺�Ʈ ����
        emit NewZombie(id, _name, _dna);
        // �����߻�. Event invocations have to be prefixed by "emit".
        // �ذ�. https://ethereum.stackexchange.com/questions/45482/invoking-events-without-emit-prefix-is-deprecated-in-transfermsg-sender-to/45485
        // Ʈ����� �α׿� �̺�Ʈ �����͸� ����ֱ� ���ؼ� emitŰ���带 ����Ѵ�. https://has3ong.tistory.com/393
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

