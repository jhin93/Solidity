// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 함수 제어자 : 'modifier' - lesson3 챕터 3 참고.

import "./zombiefactory.sol";

// 챕터 6: 좀비 재사용 대기 시간

// 이제 Zombie 구조체에 readyTime 속성을 가지고 있으니, zombiefeeding.sol로 들어가서 재사용 대기 시간 타이머를 구현해보도록 하지.
// 우린 feedAndMultiply를 다음과 같이 수정할 것이네: 1. 먹이를 먹으면 좀비가 재사용 대기에 들어가고, 2. 좀비는 재사용 대기 시간이 지날 때까지 고양이들을 먹을 수 없네.
// 이렇게 하면 좀비들이 끊임없이 고양이들을 먹고 온종일 증식하는 것을 막을 수 있지. 나중에 우리가 전투 기능을 추가하면, 다른 좀비들을 공격하는 것도 재사용 대기 시간에 걸리도록 할 것이네.
// 먼저, 우리가 좀비의 readyTime을 설정하고 확인할 수 있도록 해주는 헬퍼 함수를 정의할 것이네.

// 구조체를 인수로 전달하기.

// 자네는 private 또는 internal 함수에 인수로서 구조체의 storage 포인터를 전달할 수 있네. 이건 예를 들어 함수들 간에 우리의 Zombie 구조체를 주고받을 때 유용하네.
// 문법은 이와 같이 생겼네:

// function _doStuff(Zombie storage _zombie) internal {
//   // _zombie로 할 수 있는 것들을 처리
// }
// 이런 방식으로 우리는 함수에 좀비 ID를 전달하고 좀비를 찾는 대신, 우리의 좀비에 대한 참조를 전달할 수 있네.

// 직접 해보기
// 1. _triggerCooldown을 정의하면서 시작하지. 이 함수는 1개의 인수로 Zombie storage 포인터 타입인 _zombie를 받네. 이 함수는 internal이어야 하네.
// 2. 함수의 내용에서는 _zombie.readyTime을 uint32(now + cooldownTime)으로 설정해야 하네.
// 3. 다음으로, _isReady라고 불리는 함수를 만들게. 이 함수 역시 _zombie라는 이름의 Zombie storage 타입 인수를 받네. internal view여야 하고, bool을 리턴해야 하네.
// 4. 함수의 내용에서는 (_zombie.readyTime <= now)를 리턴해야 하고, 이는 true 아니면 false로 계산될 것이네. 이 함수는 우리에게 좀비가 먹이를 먹은 후 충분한 시간이 지났는지 알려줄 것이네.

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

  // 1. `_triggerCooldown` 함수를 여기에 정의하게
  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(block.timestamp + cooldownTime);
  }
  // 2. `_isReady` 함수를 여기에 정의하게
  function _isReady(Zombie storage _zombie) internal view returns (bool) {
    return (_zombie.readyTime <= block.timestamp);
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
    // lesson 2 챕터 12: 다수의 반환값 처리하기. 단 하나의 값에만 관심이 있을 경우, 다른 필드는 빈칸으로 놓기만 하면 된다.
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


