// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "./ownable.sol";

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// �Լ� ������ : 'modifier' - lesson3 é�� 3 ����.

// é�� 5: �ð� ����

// level �Ӽ��� ���� �� �� �ص� �˰���? 
// ���߿� �츮�� ���� �ý����� ����� �Ǹ�, �������� �� ���� �̱� ����� �ð��� ������ �������� �ϰ� �� ���̰� �� ���� ����� ���� ���̳�.
// readyTime �Ӽ��� ���� ������ �ʿ��� ���ϱ�. �̰��� ��ǥ�� ���� ���̸� �԰ų� ������ �ϰ� ���� �ٽ� �԰ų� ������ �� ���� ������ ��ٷ��� �ϴ� "���� ��� �ð�"�� �߰��ϴ� ���̳�. 
// �� �Ӽ� ���̴�, ����� �Ϸ翡 õ �� �̻� �����ϰų� ������ �� ����. �̷��� ������ �ʹ� ������ ���� ���̳�.
// ���� �ٽ� ������ ������ ��ٷ��� �ϴ� �ð��� �����ϱ� ����, �츮�� �ָ���Ƽ�� �ð� ����(Time units)�� ����� ���̳�.

contract ZombieFactory is Ownable{
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
        // ���� �� �����͸� �Է��ϰ�
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        // �Ʒ��� �����߻�. Wrong argument count for struct constructor: 2 arguments given but expected 4.
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
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}