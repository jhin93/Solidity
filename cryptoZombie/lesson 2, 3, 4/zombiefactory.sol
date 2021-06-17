// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "./ownable.sol";

// �Լ� ������ ����.
// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// ����� ���� ������ : 'modifier' - lesson3 é�� 3 ����.
// payable ������ : �̴��� ���� �� �ִ� Ư���� �Լ� ����.

/* é�� 9: ���� �¸��� �й�
�츮�� ���� ���ӿ���, �츰 ������� �󸶳� ���� �̱�� �������� �����ϰ� �Ͱ� �� ���̳�. �̷��� �ϸ� �츮�� ���� �󿡼� "���� ����ǥ"�� ������ �� �ְ� ����.
�츰 DApp���� �پ��� ������� �� �����͸� ������ �� �ֳ� - �������� ��������, ����ǥ ����ü��, Ȥ�� Zombie ����ü ��ü�� ���� ���� �ֳ�.
�츮�� �� �����ͷ� ��� ��ȣ�ۿ� �� �������� ���� ������ ��� ��� ������� �ֳ�. �� Ʃ�丮�󿡼���, �������� ������ �� �ֵ��� Zombie ����ü�� ���¸� �����ϵ��� �ϰ�, �̵��� winCount�� lossCount�� �̸������� �ϰڳ�.

���� zombiefactory.sol�� ���ư��� �츮 Zombie ����ü�� �� �Ӽ����� �߰��ϰ�.

_���� �غ���
1. Zombie ����ü�� 2���� �Ӽ��� �� �������� �����ϰ�:
  a. winCount, uint16 Ÿ��
  b. lossCount, ���� uint16 Ÿ��
����: ����ϰ�, ����ü �ȿ��� uint���� ����(pack)�� �� ������, �츮�� �ٷ� �� �ִ� ���� ���� uint Ÿ���� ����ϴ� ���� ���� ���̳�. uint8�� �ʹ� ���� ���̳�. 2^8 = 256�̱� �������� 
- ���� �츮 ���� �Ϸ翡 �� ���� �����Ѵٸ�, �� �� �ȿ� ������ ũ�Ⱑ ���Ĺ��� �� ���� ���̳�. ������ 2^16�� 65536�̳� - �׷��� �� ����ڰ� ���� 179�� ���� �̱�ų� ���� �ʴ´ٸ�, �̰ɷ� ������ ���̳�.

2. ���� �츮�� Zombie ����ü�� ���ο� �Ӽ����� ������ �Ǿ�����, _createZombie()�� �Լ� ���� �κ��� �����ؾ� �� �ʿ䰡 �ֳ�. ������ ���ο� ���� 0�� 0�и� ������ ������ �� �ֵ��� ���� ������ ���� �κ��� �����ϰ�.
*/

contract ZombieFactory is Ownable{
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        // 1. ���⿡ ���ο� �Ӽ��� �߰��ϰ�
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0));
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
