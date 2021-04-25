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

    function createZombie(string _name, uint _dna) public {
        // ���⼭ ����
        zombies.push(_name, _dna);
    }

}


// storage�� memory�� ���� ����.

contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ �� ������ ���̳�, �ָ���Ƽ�� ���⼭ 
    // `storage`�� `memory`�� ��������� �����ؾ� �Ѵٴ� ��� �޽����� �߻��Ѵ�. 
    // �׷��Ƿ� `storage` Ű���带 Ȱ���Ͽ� ������ ���� �����ؾ� �Ѵ�:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...�� ���, `mySandwich`�� ����� `sandwiches[_index]`�� ����Ű�� �������̴�.
    // �׸��� 
    mySandwich.status = "Eaten!";
    // ...�� �ڵ�� ���ü�� �󿡼� `sandwiches[_index]`�� ���������� �����Ѵ�. 

    // �ܼ��� ���縦 �ϰ��� �Ѵٸ� `memory`�� �̿��ϸ� �ȴ�: 
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...�� ���, `anotherSandwich`�� �ܼ��� �޸𸮿� �����͸� �����ϴ� ���� �ȴ�. 
    // �׸��� 
    anotherSandwich.status = "Eaten!";
    // ...�� �ڵ�� �ӽ� ������ `anotherSandwich`�� �����ϴ� ������ `sandwiches[_index + 1]`���� �ƹ��� ������ ��ġ�� �ʴ´�. 
    // �׷��� ������ ���� �ڵ带 �ۼ��� �� �ִ�: 
    sandwiches[_index + 1] = anotherSandwich;
    // ...�̴� �ӽ� ������ ������ ���ü�� ����ҿ� �����ϰ��� �ϴ� ����̴�.
  }
}