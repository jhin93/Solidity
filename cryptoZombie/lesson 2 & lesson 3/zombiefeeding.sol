// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 함수 제어자 : 'modifier' - lesson3 챕터 3 참고.

import "./zombiefactory.sol";

// 챕터 7: Public 함수 & 보안

// 이제 feedAndMultiply를 우리의 재사용 대기 시간 타이머를 고려하도록 수정해보게.

// 이 함수를 다시 살펴보면, 우리가 이전 레슨에서 이 함수를 public으로 만들었던 것을 볼 수 있을 것이네. 
// 보안을 점검하는 좋은 방법은 자네의 모든 public과 external 함수를 검사하고, 사용자들이 그 함수들을 남용할 수 있는 방법을 생각해보는 것이네. 
// 이걸 기억하시게 - 이 함수들이 onlyOwner 같은 제어자를 갖지 않는 이상, 어떤 사용자든 이 함수들을 호출하고 자신들이 원하는 모든 데이터를 함수에 전달할 수 있네.

// 위의 함수를 다시 살펴보면, 사용자들은 이 함수를 직접적으로 호출할 수 있고 그들이 원하는 아무 _targetDna나 _species를 전달할 수 있네. 이건 정말 게임 같지는 않군 - 우리는 그들이 우리의 규칙을 따르길 바라네!
// 좀 더 자세히 들여보면, 이 함수는 오직 feedOnKitty()에 의해서만 호출이 될 필요가 있네. 그러니 이런 남용을 막을 가장 쉬운 방법은 이 함수를 internal로 만드는 것이지.

// 직접 해보기
// 1. 현재 feedAndMultiply는 public 함수이네. 이걸 internal로 만들어서 컨트랙트가 더 안전해지도록 하세. 우리는 사용자들이 그들이 원하는 아무 DNA나 넣어서 이 함수를 실행하는 것을 원하지 않네.
// 2. feedAndMultiply 함수가 cooldownTime을 고려하도록 만들어보세. 먼저, myZombie를 찾은 후에, _isReady()를 확인하는 require 문장을 추가하고 거기에 myZombie를 전달하게. 이렇게 하면 사용자들은 좀비의 재사용 대기 시간이 끝난 다음에만 이 함수를 실행할 수 있네.
// 3. 함수의 끝에서 _triggerCooldown(myZombie) 함수를 호출하여 먹이를 먹는 것이 좀비의 재사용 대기 시간을 만들도록 하게.

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

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(block.timestamp + cooldownTime);
  }
  function _isReady(Zombie storage _zombie) internal view returns (bool) {
    return (_zombie.readyTime <= block.timestamp);
  }

  // 1. 이 함수를 internal로 만들게
  // string에 memory를 사용해야 하는 이유. 
  // solidity 0.5.0 버전부터는 구조체, 배열 또는 매핑 등의 모든 변수를 위해 데이터 위치를 명시하는 것이 필수. bytes 와 string 타입의 변수는 특별한 형태의 배열입니다(https://solidity-kr.readthedocs.io/ko/latest/types.html#arrays).
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    // 2. 여기에 `_isReady`를 확인하는 부분을 추가하게
    require(_isReady(myZombie)); 
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // keccak256 내부에 함수 인자를 받을 경우에 abi.encodePacked(arg) 를 같이 사용할 것. 
    if (keccak256(abi.encodePacked(_species)) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    // 3. `_triggerCooldown`을 호출하게
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // lesson 2 챕터 12: 다수의 반환값 처리하기. 단 하나의 값에만 관심이 있을 경우, 다른 필드는 빈칸으로 놓기만 하면 된다.
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


