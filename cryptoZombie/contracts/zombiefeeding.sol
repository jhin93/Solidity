// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
// 함수 제어자 종류.
// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 사용자 정의 제어자 : 'modifier' - lesson3 챕터 3 참고.
// payable 제어자 : 이더를 받을 수 있는 특별한 함수 유형.

import "./zombiefactory.sol";

/* 챕터 4: 리팩토링
오 이런! 우린 방금 우리의 코드에 컴파일이 안 되도록 하는 에러를 만들었네. 자네 눈치 챘었나?
이전 챕터에서 우리는 ownerOf라는 함수를 정의했네. 하지만 레슨 4에서, 우리는 zombiefeeding.sol에서 ownerOf와 똑같은 이름의 modifier를 만들었네.
자네가 이 코드를 컴파일하려 한다면, 컴파일러가 똑같은 이름의 제어자와 함수를 가질 수 없다며 에러를 만들어낼 것이네.

그렇다면 우리가 ZombieOwnership의 함수 이름을 다른 걸로 바꿔야 할까?

아니, 그렇게 할 수는 없네!!! 우리는 ERC721 토큰 표준을 사용하고 있음을 기억하게. 이 말인즉 다른 컨트랙트들이 우리의 컨트랙트가 정확한 이름으로 정의된 함수들을 가지고 있을 것이라 예상한다는 것이네. 
그게 바로 이런 표준이 유용하게끔 하는 것이니 말이야 - 만약 우리 컨트랙트는 ERC721을 따른다는 것을 다른 컨트랙트가 안다면, 이 다른 컨트랙트는 우리의 내부 구현 로직을 모르더라도 우리와 통신할 수 있네.
그러니 우리는 레슨 4에서 만든 우리의 코드에서 modifier의 이름을 다른 것으로 바꾸도록 리팩토링을 해야 하네.

_직접 해보기
zombiefeeding.sol로 돌아와서, 우리의 modifier의 이름을 ownerOf에서 onlyOwnerOf로 바꿀 것이네.

1. 제어자를 정의하는 이름을 onlyOwnerOf로 바꾸게.
2. 이 제어자를 사용하는 feedAndMultiply 함수로 스크롤을 내리게. 여기서도 그 이름을 바꿔야 할 것이네.

| 참고: 우리는 이 제어자를 zombiehelper.sol과 zombieattack.sol에서도 사용하네. 
하지만 우리는 이 레슨에서 리팩토링에 시간을 너무 많이 쓰지는 않도록 할 것이야. 그래서 내가 자네를 위해 이 파일들에서 제어자의 이름을 먼저 변경해 놓았네.
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

  // 1. 제어자의 이름을 `onlyOwnerOf`로 바꾸게.
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

  // string에 memory를 사용해야 하는 이유. 
  // solidity 0.5.0 버전부터는 구조체, 배열 또는 매핑 등의 모든 변수를 위해 데이터 위치를 명시하는 것이 필수. bytes 와 string 타입의 변수는 특별한 형태의 배열입니다(https://solidity-kr.readthedocs.io/ko/latest/types.html#arrays).
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


