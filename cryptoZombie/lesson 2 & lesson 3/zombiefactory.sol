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

// ���� �غ���

// �츮 DApp�� ���� ��� �ð��� �߰��ϰ�, ������� �����ϰų� ���̸� ���� �� 1���� �����߸� �ٽ� ������ �� �ֵ��� �� ���̳�.

// 1. cooldownTime�̶�� uint ������ �����ϰ�, ���⿡ 1 days�� �����ϰ�.(���������� �̻��ϰ� ������ �Ѿ��. �ڳװ� "1 day"�� �����Ѵٸ�, �������� ���� ���� ���ϼ�!)
// 2. �츮�� ���� é�Ϳ��� �츮�� Zombie ����ü�� level�� readyTime�� �߰�������, �츰 Zombie ����ü�� ������ �� �Լ��� �μ� ������ ��Ȯ�� �µ��� _createZombie() �Լ��� ������Ʈ�ؾ� �ϳ�. 
//    �ڵ��� zombies.push �ٿ� 2���� �μ��� �� ����ϵ��� ������Ʈ�ϰ�: 1(level�� ���), uint32(now + cooldownTime)(readyTime�� ���). 0.7�������� now ��� block.timestamp�� ���. 


contract ZombieFactory is Ownable{
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    // 1. `cooldownTime`�� ���⿡ �����ϰ�
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        // 2. �Ʒ� ���� ������Ʈ�ϰ�:
        // ���� ���� now�� �� �̻� ������ ������ block.timestamp��� ����ؾ��մϴ�. ���� �ĺ��� now�� ���� ������ ���� �ʹ� �Ϲ����̸� Ʈ����� ó�� �߿� ����Ǵ� �λ��� �� �� ������ block.timestamp����� �Ӽ� �� ���̶�� ����� �ùٸ��� �ݿ��մϴ�.
        // https://docs.soliditylang.org/en/v0.7.3/070-breaking-changes.html
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime)));
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

// �ð� ����(Time units)

// now ������ ���� ������ ���н� Ÿ�ӽ�����(1970�� 1�� 1�Ϻ��� ���ݱ����� �� ���� ��) ���� ���� �� �ֳ�. ���� �� ���� �� �� ���н� Ÿ���� ���� 1515527488�̱�.
// ���� : ���н� Ÿ���� ���������� 32��Ʈ ���ڷ� ����ǳ�. �̴� ���н� Ÿ�ӽ����� ���� 32��Ʈ�� ǥ�ð� ���� ���� ��ŭ Ŀ���� �� ���� ���� �ý��ۿ� ������ �߻��� "Year 2038" ������ ����ų ���̳�. 
// �׷��� ���� �츮 DApp�� ���ݺ��� 20�� �̻� ��Ǳ� ���Ѵٸ�, �츮�� 64��Ʈ ���ڸ� ��� �� ���̳�. ������ �츮 �������� �׵��� �� ���� ������ �Ҹ��ؾ� �ϰ���. ���踦 ���� ������ �ؾ� �ϳ�!

// �ָ���Ƽ�� ���� seconds, minutes, hours, days, weeks, years ���� �ð� ���� ���� �����ϰ� �ִٳ�. 
// �̵��� �׿� �ش��ϴ� ���� ��ŭ�� �� ���� uint ���ڷ� ��ȯ�ǳ�. 
// �� 1 minutes�� 60, 1 hours�� 3600(60�� x 60 ��), 1 days�� 86400(24�ð� x 60�� x 60��) ���� ��ȯ�ǳ�.
// �� �ð� �������� �����ϰ� ���� �� �ִ� ���ô� ������ ����:

// uint lastUpdated;

// // `lastUpdated`�� `now`�� ����
// function updateTimestamp() public {
//   lastUpdated = now;
// }

// // ���������� `updateTimestamp`�� ȣ��� �� 5���� �������� `true`��, 5���� ���� ������ �ʾ����� `false`�� ��ȯ
// function fiveMinutesHavePassed() public view returns (bool) {
//   return (now >= (lastUpdated + 5 minutes));
// }

// �츮�� �̷� �ð� �������� ������ cooldown ����� �߰��� �� ����� ���̳�.