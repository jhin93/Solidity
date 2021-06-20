// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
// �Լ� ������ ����.
// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// ����� ���� ������ : 'modifier' - lesson3 é�� 3 ����.
// payable ������ : �̴��� ���� �� �ִ� Ư���� �Լ� ����.

import "./zombiefactory.sol";

/* é�� 4: �����丵
�� �̷�! �츰 ��� �츮�� �ڵ忡 �������� �� �ǵ��� �ϴ� ������ �������. �ڳ� ��ġ ë����?
���� é�Ϳ��� �츮�� ownerOf��� �Լ��� �����߳�. ������ ���� 4����, �츮�� zombiefeeding.sol���� ownerOf�� �Ȱ��� �̸��� modifier�� �������.
�ڳװ� �� �ڵ带 �������Ϸ� �Ѵٸ�, �����Ϸ��� �Ȱ��� �̸��� �����ڿ� �Լ��� ���� �� ���ٸ� ������ ���� ���̳�.

�׷��ٸ� �츮�� ZombieOwnership�� �Լ� �̸��� �ٸ� �ɷ� �ٲ�� �ұ�?

�ƴ�, �׷��� �� ���� ����!!! �츮�� ERC721 ��ū ǥ���� ����ϰ� ������ ����ϰ�. �� ������ �ٸ� ��Ʈ��Ʈ���� �츮�� ��Ʈ��Ʈ�� ��Ȯ�� �̸����� ���ǵ� �Լ����� ������ ���� ���̶� �����Ѵٴ� ���̳�. 
�װ� �ٷ� �̷� ǥ���� �����ϰԲ� �ϴ� ���̴� ���̾� - ���� �츮 ��Ʈ��Ʈ�� ERC721�� �����ٴ� ���� �ٸ� ��Ʈ��Ʈ�� �ȴٸ�, �� �ٸ� ��Ʈ��Ʈ�� �츮�� ���� ���� ������ �𸣴��� �츮�� ����� �� �ֳ�.
�׷��� �츮�� ���� 4���� ���� �츮�� �ڵ忡�� modifier�� �̸��� �ٸ� ������ �ٲٵ��� �����丵�� �ؾ� �ϳ�.

_���� �غ���
zombiefeeding.sol�� ���ƿͼ�, �츮�� modifier�� �̸��� ownerOf���� onlyOwnerOf�� �ٲ� ���̳�.

1. �����ڸ� �����ϴ� �̸��� onlyOwnerOf�� �ٲٰ�.
2. �� �����ڸ� ����ϴ� feedAndMultiply �Լ��� ��ũ���� ������. ���⼭�� �� �̸��� �ٲ�� �� ���̳�.

| ����: �츮�� �� �����ڸ� zombiehelper.sol�� zombieattack.sol������ ����ϳ�. 
������ �츮�� �� �������� �����丵�� �ð��� �ʹ� ���� ������ �ʵ��� �� ���̾�. �׷��� ���� �ڳ׸� ���� �� ���ϵ鿡�� �������� �̸��� ���� ������ ���ҳ�.
*/

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

  // 1. �������� �̸��� `onlyOwnerOf`�� �ٲٰ�.
  modifier onlyOwnerOf(uint _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    _;
  }

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(block.timestamp + cooldownTime);
  }
  function _isReady(Zombie storage _zombie) internal view returns (bool) {
    return (_zombie.readyTime <= block.timestamp);
  }

  // string�� memory�� ����ؾ� �ϴ� ����. 
  // solidity 0.5.0 �������ʹ� ����ü, �迭 �Ǵ� ���� ���� ��� ������ ���� ������ ��ġ�� ����ϴ� ���� �ʼ�. bytes �� string Ÿ���� ������ Ư���� ������ �迭�Դϴ�(https://solidity-kr.readthedocs.io/ko/latest/types.html#arrays).
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal onlyOwnerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie)); 
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


