// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure

// é�� 3: onlyOwner �Լ� ������

// ��, ���� �츮�� �⺻ ��Ʈ��Ʈ�� ZombieFactory�� Ownable�� ����ϰ� ������, �츮�� onlyOwner �Լ� �����ڸ� ZombieFeeding������ ����� �� �ֳ�.
// �̰� ��Ʈ��Ʈ�� ��ӵǴ� ���� ��������. �Ʒ� ������ ����ϰ�:
// ZombieFeeding is ZombieFactory
// ZombieFactory is Ownable

// �׷��� ������ ZombieFeeding ���� Ownable�̰�, Ownable ��Ʈ��Ʈ�� �Լ�/�̺�Ʈ/�����ڿ� ������ �� �ִٳ�. 
// �̰� ���Ŀ� ZombieFeeding�� ����ϴ� �ٸ� ��Ʈ��Ʈ�鿡�� ���������� ����ǳ�.

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

  // �� �Լ��� �����ϰ�:
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
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}

// �Լ� ������

// �Լ� �����ڴ� �Լ�ó�� ��������, function Ű���� ��� modifier Ű���带 ����Ѵٳ�. 
// �׸��� �ڳװ� �Լ��� ȣ���ϵ��� ���� ȣ���� ���� ����. ��ſ� �Լ� ���Ǻ� ���� �ش� �Լ��� �۵� ����� �ٲٵ��� �������� �̸��� ���� �� �ֳ�.

// onlyOwner�� ���캸�鼭 �� �ڼ��� �˾ƺ����� ����.

// /**
//  * @dev Throws if called by any account other than the owner.
//  */
// modifier onlyOwner() {
//   require(msg.sender == owner);
//   _;
// }

// �츮�� �� �����ڸ� ������ ���� ����� ���̳�:

// contract MyContract is Ownable {
//   event LaughManiacally(string laughter);

//   // �Ʒ� `onlyOwner`�� ��� ����� �� ����:
//   function likeABoss() external onlyOwner {
//     LaughManiacally("Muahahahaha");
//   }
// }

// ���� -------- �߿� ----------
// likeABoss �Լ��� onlyOwner ������ �κ��� �� ����. 
// �ڳװ� likeABoss �Լ��� ȣ���ϸ�, onlyOwner�� �ڵ尡 ���� ����ǳ�. 
// �׸��� onlyOwner�� _; �κ��� likeABoss �Լ��� �ǵ��ư� �ش� �ڵ带 �����ϰ� ����.

// �ڳװ� �����ڸ� ����� �� �ִ� �پ��� ����� ������, ���� �Ϲ������� ���� ���� �� �ϳ��� �Լ� ���� ���� require üũ�� �ִ� ���̳�.
// onlyOwner�� ��쿡��, �Լ��� �� �����ڸ� �߰��ϸ� ���� ��Ʈ��Ʈ�� ������(�ڳװ� �����ߴٸ� �ڳװ���)���� �ش� �Լ��� ȣ���� �� �ֳ�.

// ����: �̷��� �����ڰ� ��Ʈ��Ʈ�� Ư���� ������ ������ �ϴ� ���� ���� �ʿ�������, �̰� �ǿ�� ���� �ִٳ�. 
// ���� ���, �����ڰ� �ٸ� ����� ���� ����� �� �ֵ��� �ϴ� �鵵�� �Լ��� �߰��� ���� ����!

// �׷��� �� ����ϰ�. �̴����򿡼� ���ư��� DApp�̶�� �ؼ� �װ͸����� �л�ȭ�Ǿ� �ִٰ� �� ���� ����. 
// �ݵ�� ��ü �ҽ� �ڵ带 �о��, �ڳװ� ���������� ������ ����, �����ڿ� ���� Ư���� ��� �Ұ����� �������� Ȯ���ϰ�. 
// �����ڷμ��� �ڳװ� �������� ���׸� �����ϰ� DApp�� ���������� �����ϵ��� �ϴ� �Ͱ�, ����ڵ��� �׵��� �����͸� �ϰ� ������ �� �ִ� �����ڰ� ���� �÷����� ����� �� ���̿��� ������ �� ��� ���� �߿��ϳ�.