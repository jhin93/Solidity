// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 8: ���� DNA.

// feedAndMultiply �Լ� �ۼ��� �������� ����!
// ���ο� ������ DNA�� ����ϴ� ������ �����ϳ�: ���̸� �Դ� ������ DNA�� ������ DNA�� ����� ���� ����.

// ����:

// function testDnaSplicing() public {
//   uint zombieDna = 2222222222222222;
//   uint targetDna = 4444444444444444;
//   uint newZombieDna = (zombieDna + targetDna) / 2;
//   // ^ 3333333333333333�� �� ���̴�
// }

// �ڳװ� ���Ѵٸ� ���߿� ������ ���� �����ϰ� �� ���� ���� �ų�. ������ �������μ� ������ �����ϰ� �ϵ��� ����. 
// ���߿� �������� ������ �� �����ϱ�.

// 1. ����, _targetDna�� 16�ڸ����� ũ�� �ʵ��� �ؾ� �Ѵ�. �̸� ����, _targetDna�� _targetDna % dnaModulus�� ������ �ؼ� ������ 16�ڸ� ���� ���ϵ��� �Ѵ�.
// 2. �� ����, �Լ��� newDna��� uint�� �����ϰ� myZombie�� DNA�� _targetDna�� ��� ���� �ο��ؾ� �Ѵ�. (���� ���� ����)
// ����: myZombie.name�� myZombie.dna�� �̿��Ͽ� myZombie ����ü�� ������ ������ �� ����.
// 3. ���ο� DNA ���� ��� �Ǹ� _createZombie �Լ��� ȣ���Ѵ�. �� �Լ��� ȣ���ϴ� �� �ʿ��� ���� ���� zombiefactory.sol �ǿ��� Ȯ���� �� �ִ�. 
// �����, �� �Լ��� ������ �̸��� ���� ������ �ʿ�� �Ѵ�. �׷��� ���ο� ������ �̸��� ����μ��� "NoName"���� �ϵ��� ����. ���߿� ���� �̸��� �����ϴ� �Լ��� �ۼ��� �� ���� ���̴�.

// ����: �ָ���Ƽ�� �ڳ׸� ���� ������ ���ؼ� �ڳװ� �ڵ��� �������� �˾� ������ ���� �ְڱ�. ���� ����. ���� é�Ϳ��� ������ �ذ��� �ɼ� ;)

// ����ü �迭 ��뿹��
// https://hatpub.tistory.com/56

import "./zombiefactory.sol";
contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) view public {
        require(msg.sender == zombieToOwner[_zombieId]);
        // ������ �ؼ��� �Ʒ������� ����.
        // 1. myZombie��� Zombie���� ����ü�� �������� ���� �����ͷ� �����Ѵ�(storage�� ����)
        // 2. �׸��� ���⿡ zombies�� _zombieId��° �ε����� �ش��ϴ� ���� ����ִ´�.
        Zombie storage myZombie = zombies[_zombieId];
        // ���⼭ ����
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}