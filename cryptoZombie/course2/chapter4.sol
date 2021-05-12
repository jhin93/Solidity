// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 4: require

// ���� 1���� ������ createRandomZombie�� ȣ���Ͽ� ���� �̸��� �Է��ϸ� ���ο� ���� ������ �� �ֵ��� �߳�. 
// ������, ���� ������ �� �Լ��� ��� ȣ���ؼ� ���������� ���� �����Ѵٸ� ������ �ſ� ��������� ���� �ɼ�.
// �� �÷��̾ �� �Լ��� �� ���� ȣ���� �� �ֵ��� ����� ����. �̷ν� ���ο� �÷��̾���� ������ ó�� ������ �� ���� ���븦 ������ ù ���� �����ϱ� ���� createRandomZombie�Լ��� ȣ���ϰ� �� ���̳�.
// ��� �ϸ� �� �Լ��� �� �÷��̾�� �� ������ ȣ��ǵ��� �� �� ������?
// �̸� ���� require�� Ȱ���� ���̳�. require�� Ȱ���ϸ� Ư�� ������ ���� �ƴ� �� �Լ��� ���� �޽����� �߻��ϰ� ������ ���߰� ����

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
        // �ذ�. https://ethereum.stackexchange.com/questions/89792/typeerror-different-number-of-components-either-side-of-equation
        // ���� 0.6���� push�� length�� ��ȯ���� �ʰ� ���ϱ� ��ɸ� ������. 
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        // msg.sender ����
        zombieToOwner[id] = msg.sender;
        // �ڹٽ�ũ��Ʈ�� ���������� �ָ���Ƽ������ uint�� ++�� ������ų �� �ִ�.
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


// require ����

// function sayHiToVitalik(string _name) public returns (string) {
//   // _name�� "Vitalik"���� ���Ѵ�. ���� �ƴ� ��� ���� �޽����� �߻��ϰ� �Լ��� �����
//   // (����: �ָ���Ƽ�� ������ ��Ʈ�� �� ����� ������ ���� �ʱ� ������ 
//   // ��Ʈ���� keccak256 �ؽð��� ���Ͽ� ��Ʈ�� ���� ������ �Ǵ��Ѵ�)
//   require(keccak256(_name) == keccak256("Vitalik"));
//   // ���̸� �Լ� ������ �����Ѵ�:
//   return "Hi!";
// }