// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// é�� 7: Storage vs Memory
// �ָ���Ƽ���� ������ ������ �� �ִ� �������� storage�� memory �� ������ ����.

// Storage�� ���ü�� �� ���������� ����Ǵ� ������ �ǹ�����. 
// Memory�� �ӽ������� ����Ǵ� ������, ��Ʈ��Ʈ �Լ��� ���� �ܺ� ȣ����� �Ͼ�� ���̿� ��������. 
// �� ������ ���� ��ǻ�� �ϵ� ��ũ�� RAM�� ����.

// ��κ��� ��쿡 �ڳ״� �̷� Ű������� �̿��� �ʿ䰡 ����. 
// �ֳĸ� �ָ���Ƽ�� �˾Ƽ� ó���� �ֱ� ��������. 
// ���� ����(�Լ� �ܺο� ����� ����)�� �ʱ� ������ storage�� ����Ǿ� ���ü�ο� ���������� ����Ǵ� �ݸ�, 
// �Լ� ���� ����� ������ memory�� �ڵ� ����Ǿ �Լ� ȣ���� ����Ǹ� �������.

// ������ �� Ű������� ����ؾ� �ϴ� ���� ����. �ٷ� �Լ� ���� ����ü�� _�迭_�� ó���� ����

// contract SandwichFactory {
//   struct Sandwich {
//     string name;
//     string status;
//   }

//   Sandwich[] sandwiches;

//   function eatSandwich(uint _index) public {
//     // Sandwich mySandwich = sandwiches[_index];

//     // ^ �� ������ ���̳�, �ָ���Ƽ�� ���⼭ 
//     // `storage`�� `memory`�� ��������� �����ؾ� �Ѵٴ� ��� �޽����� �߻��Ѵ�. 
//     // �׷��Ƿ� `storage` Ű���带 Ȱ���Ͽ� ������ ���� �����ؾ� �Ѵ�:
//     Sandwich storage mySandwich = sandwiches[_index];
//     // ...�� ���, `mySandwich`�� ����� `sandwiches[_index]`�� ����Ű�� �������̴�.
//     // �׸��� 
//     mySandwich.status = "Eaten!";
//     // ...�� �ڵ�� ���ü�� �󿡼� `sandwiches[_index]`�� ���������� �����Ѵ�. 

//     // �ܼ��� ���縦 �ϰ��� �Ѵٸ� `memory`�� �̿��ϸ� �ȴ�: 
//     Sandwich memory anotherSandwich = sandwiches[_index + 1];
//     // ...�� ���, `anotherSandwich`�� �ܼ��� �޸𸮿� �����͸� �����ϴ� ���� �ȴ�. 
//     // �׸��� 
//     anotherSandwich.status = "Eaten!";
//     // ...�� �ڵ�� �ӽ� ������ `anotherSandwich`�� �����ϴ� ������ 
//     // `sandwiches[_index + 1]`���� �ƹ��� ������ ��ġ�� �ʴ´�. �׷��� ������ ���� �ڵ带 �ۼ��� �� �ִ�: 
//     sandwiches[_index + 1] = anotherSandwich;
//     // ...�̴� �ӽ� ������ ������ ���ü�� ����ҿ� �����ϰ��� �ϴ� ����̴�.
//   }
// }

// � Ű���带 �̿��ؾ� �ϴ��� ��Ȯ�ϰ� �������� ���Ѵٰ� �ص� ���� ����. 
// �� Ʃ�丮���� �����ϴ� ���� ���� storage Ȥ�� memory�� ����ؾ� �ϴ��� �˷� �ְڳ�. 
// �ָ���Ƽ �����Ϸ��� ��� �޽����� ���� � Ű���带 ����ؾ� �ϴ��� �˷� �� ���̳�.
// �������μ� ��������� storage�� memory�� ������ �ʿ䰡 �ִ� ��찡 �ִٴ� �� �����ϴ� �͸����� ����ϳ�!

// ���⿡ import ������ �ֱ�
import "./zombiefactory.sol";
contract ZombieFeeding is ZombieFactory {

}