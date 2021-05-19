// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;


// ���� ������ Person ����ü�� ����ϳ�?

// struct Person {
//   uint age;
//   string name;
// }
// Person[] public people;

// ���� ���ο� Person�� �����ϰ� people �迭�� �߰��ϴ� ����� ���캸���� ����.

// ���ο� ����� �����Ѵ�:
// Person satoshi = Person(172, "Satoshi");
// �� ����� �迭�� �߰��Ѵ�:
// people.push(satoshi);

// �� �� �ڵ带 �����Ͽ� ����ϰ� �� �ٷ� ǥ���� �� �ֳ�:
// people.push(Person(16, "Vitalik"));

// uint[] numbers;
// numbers.push(5);
// numbers.push(10);
// numbers.push(15);
// numbers �迭�� [5, 10, 15]�� ����.

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


// Storage �� Memory.
// https://steemit.com/hive-101145/@happyberrysboy/happyberrysboy-posting-2020-08-14-00-24

// �ָ���Ƽ���� ������ ������ �� �ִ� �������� storage�� memory, �� ������ �ֽ��ϴ�.
// Storage�� ���ü�� �� ���������� ����Ǵ� ������ �ǹ��մϴ�.
// Memory�� �ӽ������� ����Ǵ� ������, ��Ʈ��Ʈ �Լ��� ���� �ܺ� ȣ����� �Ͼ�� ���̿� �������ϴ�.

// �ָ���Ƽ�� �˾Ƽ� ó���� �ֱ� �������� ��κ��� ��쿡 �� Ű������� �̿��� �ʿ䰡 �����ϴ�.
// ���� ����(�Լ� �ܺο� ����� ����)�� �ʱ� ������ storage�� ����Ǿ� ���ü�ο� ���������� ����Ǵ� �ݸ�, �Լ� ���� ����� ������ memory�� �ڵ� ����Ǿ �Լ� ȣ���� ����Ǹ� ������� �˴ϴ�.
// ������ �� Ű������� ����ؾ� �ϴ� ��찡 �ֽ��ϴ�. �ٷ� �Լ� ���� ����ü�� �迭�� ó���� ��!!


// storage�� memory�� ���� ����.

contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // �� ����ó�� �ۼ��ϸ� `storage`�� `memory`�� ��������� �����ؾ� �Ѵٴ� ��� �޽����� �߻��Ѵ�. 
    // �׷��Ƿ� `storage` Ű���带 Ȱ���Ͽ� ������ ���� �����ؾ� �Ѵ�:
    Sandwich storage mySandwich = sandwiches[_index];
    // �� ���, `mySandwich`�� ����� `sandwiches[_index]`�� ����Ű�� �������̴�.
    // �׸��� 
    mySandwich.status = "Eaten!";
    // �� �ڵ�� ���ü�� �󿡼� `sandwiches[_index]`�� ���������� �����Ѵ�. 

    // �ܼ��� ���縦 �ϰ��� �Ѵٸ� `memory`�� �̿��ϸ� �ȴ�: 
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // �� ���, `anotherSandwich`�� �ܼ��� �޸𸮿� �����͸� �����ϴ� ���� �ȴ�. 
    // �׸��� 
    anotherSandwich.status = "Eaten!";
    // �� �ڵ�� �ӽ� ������ `anotherSandwich`�� �����ϴ� ������ `sandwiches[_index + 1]`���� �ƹ��� ������ ��ġ�� �ʴ´�. 
    // �׷��� ������ ���� �ڵ带 �ۼ��� �� �ִ�: 
    sandwiches[_index + 1] = anotherSandwich;
    // �̴� �ӽ� ������ ������ ���ü�� ����ҿ� �����ϰ��� �ϴ� ����̴�.
  }
}


// calldata.

// calldata�� storage, memory�� ���� �����͸� �����ϴ� ��� �� �ϳ�.
// solidity ���� 4�� 5�� ���̰� ū �� �ϴ�.
// 5�� �������� calldata�� external �Լ��� ���ڸ� ���� ������̴�. external �Լ��� �̿��ϱ� ���� �� �� �� lifetime �� ������ �ִ�.
// https://medium.com/day34/solidity-0-5-0-%EC%97%90%EC%84%9C%EC%9D%98-%EB%B3%80%EA%B2%BD%EC%82%AC%ED%95%AD%EC%9D%84-%EC%86%8C%EA%B0%9C%ED%95%A9%EB%8B%88%EB%8B%A4-ab6104296164
// memoryó�� �������, ������ �� ����.
// https://docs.soliditylang.org/en/v0.5.3/types.html

// ���ü� �� external�� ��༭�� �ش� ������ �����Ѵٴ� �ǹ��̸�, ��༭�� �ܺο��� ����ϴ� �������̽���� ���� ����ϴ� ��.
// �׷��� ������ �̷� external �Լ��� ���Ǵ� calldata�� ������ �ȵǰ�, �Լ� �������� ���ǰ� �������� �� �ϴ�.



