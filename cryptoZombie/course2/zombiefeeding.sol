// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// �Լ� ������ : 'modifier' - lesson3 é�� 3 ����.

// é�� 4: ����(Gas)

// �Ǹ���! ���� �츮�� ����ڵ��� �츮 ��Ʈ��Ʈ�� ���� ������ ���ϰ� �ϸ鼭�� DApp�� �ٽ����� �κ��� ������Ʈ�� �� �ִ� ����� �͵��߳�.
// ���ݺ��ʹ� �� �ٸ� �ָ���Ƽ�� �ٸ� ���α׷��� ������ �������� ���캼 ���̳�.

import "./zombiefactory.sol";

interface KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  KittyInterface kittyContract;

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if(keccak256(abi.encodePacked(_species)) == keccak256("kitty")){
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // lesson 2 é�� 12: �ټ��� ��ȯ�� ó���ϱ�. �� �ϳ��� ������ ������ ���� ���, �ٸ� �ʵ�� ��ĭ���� ���⸸ �ϸ� �ȴ�.
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


// ���� - �̴����� DApp�� ����ϴ� ����

// �ָ���Ƽ������ ����ڵ��� �ڳװ� ���� DApp�� �Լ��� ������ ������ _����_��� �Ҹ��� ȭ�� �����ؾ� �ϳ�. 
// ����ڴ� �̴�(ETH, �̴������� ȭ��)�� �̿��ؼ� ������ ��� ������, �ڳ��� DApp �Լ��� �����Ϸ��� ����ڵ��� ETH�� �Ҹ��ؾ߸� �ϳ�.

// �Լ��� �����ϴ� ���� �󸶳� ���� ������ �ʿ������� �� �Լ��� ����(�� ����)�� �󸶳� ���������� ���� �޶�����. 
// ������ ������ �Ҹ�Ǵ� ���� ���(gas cost)�� �ְ�, �� ������ �����ϴ� ���� �Ҹ�Ǵ� ��ǻ�� �ڿ��� ���� �� ����� �����ϳ�. 
// ���� ���, storage�� ���� ���� ���� �� ���� ������ ���ϴ� �ͺ��� �ξ� ����� ����. 
// �ڳ� �Լ��� ��ü ���� ����� �� �Լ��� �����ϴ� ���� ������� ���� ����� ��� ��ģ �Ͱ� ����.

// �Լ��� �����ϴ� ���� �ڳ��� ����ڵ鿡�� ���� ���� ���� �ϱ� ������, �̴����򿡼� �ڵ� ����ȭ�� �ٸ� ���α׷��� ���鿡 ���� �ξ� �� �߿��ϳ�. 
// ���� �ڳ��� �ڵ尡 �����̶��, ����ڵ��� �ڳ��� �Լ��� �����ϱ� ���� ������ �����Ḧ �� ���� �� �ɼ�. 
// �׸��� ��õ ���� ����ڰ� �̷� ���ʿ��� ����� ���ٸ� �����ᰡ ���� �� ������ ���� �� ����.

// ������ �� �ʿ��Ѱ�?

// �̴������� ũ�� ����, ������ ������ ������ ��ǻ�Ϳ� ���ٰ� �� �� �ֳ�. 
// �ڳװ� � �Լ��� ������ ��, ��Ʈ��ũ���� ��� ���� ��尡 �Լ��� ��°��� �����ϱ� ���� �� �Լ��� �����ؾ� ����. 
// ��� �Լ��� ������ �����ϴ� ��õ ���� ��尡 �ٷ� �̴������� �л�ȭ�ϰ�, �����͸� �����ϸ� ������ �˿��� �� ������ �ϴ� �������.

// �̴������� ���� ������� �������� ���� �ݺ����� �Ἥ ��Ʈ��ũ�� �����ϰų�, �ڿ� �Ҹ� ū ������ �Ἥ ��Ʈ��ũ �ڿ��� ��� ������� ���ϵ��� ����� ���ߴٳ�. 
// �׷��� �׵��� ���� ó���� ����� �鵵�� �������, ����ڵ��� ���� ���� �Ӹ� �ƴ϶� ���� ��� �ð��� ���󼭵� ����� �����ؾ� �Ѵٳ�.

// ����: ���̵�ü�ο����� �ݵ�� �̷����� �ʴٳ�. ũ�������� ���� ������� Loom Network���� ����� �ִ� �͵��� ���� ���ð� �ǰڱ�. 
// �̴����� ���γݿ��� ���� ���� ��ũ����Ʈ ���� ������ ���������� ������ ���� ���� ���� ���� ���� �ɼ�. 
// ���� ����� ��û���� ���� ���̱� ��������. ������ �ٸ� ���� �˰����� ���� ���̵�ü�ο����� ������ �� ����. 
// �츰 ������ ���� �������� DApp�� ���̵�ü�ο� �ø���, �̴����� ���γݿ� �ø��� �Ǵ��ϴ� ����鿡 ���� �� ����� �ɼ�.