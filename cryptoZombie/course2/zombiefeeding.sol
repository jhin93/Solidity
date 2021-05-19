// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure

// é�� 9: �Լ� ���� ������ �� �˾ƺ���.

// ���� ������ �ڵ忡 �Ǽ��� �ֳ�!
// �ڳװ� �ڵ带 �������Ϸ��� �ϸ� �����Ϸ��� ���� �޽����� ����� �ų�.
// ������ ZombieFeeding ��Ʈ��Ʈ ������ _createZombie �Լ��� ȣ���Ϸ��� �ߴٴ� ����. 
// �׷��� _createZombie �Լ��� ZombieFactory ��Ʈ��Ʈ ���� private �Լ�����. 
// ��, ZombieFactory ��Ʈ��Ʈ�� ����ϴ� � ��Ʈ��Ʈ�� �� �Լ��� ������ �� ���ٴ� ������.

// Internal�� External.
// public�� private �̿ܿ��� �ָ���Ƽ���� internal�� external�̶�� �Լ� ���� �����ڰ� ����.

// internal�� �Լ��� ���ǵ� ��Ʈ��Ʈ�� ����ϴ� ��Ʈ��Ʈ������ ������ �����ϴ� ���� �����ϸ� private�� ��������. **(�츮���� �ʿ��� �� �ٷ� internal�� �� ����!

// external�� �Լ��� ��Ʈ��Ʈ �ٱ������� ȣ��� �� �ְ� ��Ʈ��Ʈ ���� �ٸ� �Լ��� ���� ȣ��� �� ���ٴ� ���� �����ϸ� public�� ��������. ���߿� external�� public�� ���� �� �ʿ����� ���� �� ���̳�.

// interal�̳� external �Լ��� �����ϴ� �� private�� public �Լ��� �����ϴ� ������ �����ϳ�.

// ����.
// contract Sandwich {
//   uint private sandwichesEaten = 0;

//   function eat() internal {
//     sandwichesEaten++;
//   }
// }

// contract BLT is Sandwich {
//   uint private baconSandwichesEaten = 0;

//   function eatWithBacon() public returns (string) {
//     baconSandwichesEaten++;
//     // eat �Լ��� internal�� ����Ǿ��� ������ ���⼭ ȣ���� �����ϴ� 
//     eat();
//   }
// }

import "./zombiefactory.sol";
contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        // �Ʒ� _createZombie �Լ� ���࿡�� �����߻�. Function declared as view, but this expression (potentially) modifies the state and thus requires non-payable (the default) or payable.
        // �θ� �Լ�(feedAndMultiply)�� 'view'�� �����ؼ� �ذ�. �Լ��� �����͸� ���⸸�ϰ� �������� �ʴ´�.
        _createZombie("NoName", newDna);
    }
}