// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
// 함수 제어자 종류.
// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 사용자 정의 제어자 : 'modifier' - lesson3 챕터 3 참고.
// payable 제어자 : 이더를 받을 수 있는 특별한 함수 유형.

import "./zombiefactory.sol";

/* 챕터 6: 공통 로직 구조 개선하기(Refactoring)
누가 우리의 attack 함수를 실행하든지 - 우리는 사용자가 공격에 사용하는 좀비를 실제로 소유하고 있다는 것을 확실히 하고 싶네. 
만약 자네가 다른 사람의 좀비를 사용해서 공격할 수 있다면 보안에 문제가 되는 부분일 것이야!
함수를 호출하는 사람이 그가 사용한 _zombieId의 소유자인지 확인할 방법을 생각해낼 수 있겠는가? 좀 더 생각해보면서, 자네 스스로 답을 생각해낼 수 있는지 확인해보게.

시간을 가지고... 아이디어를 위해 지난 레슨들을 참고해보게. 해결책은 아래에 있지만, 생각이 나기 전에는 보지 말도록 하게. 

_해결책
우린 이전 레슨들에서 이런 종류의 확인을 여러 번 해왔었네. changeName(), changeDna(), feedMultiply()에서, 우리는 다음과 같은 방식을 썼네:
require(msg.sender == zombieToOwner[_zombieId]);
우리의 attack 함수에도 똑같은 내용을 적용할 필요가 있네. 동일한 내용을 여러 번 사용하고 있으니, 코드를 정리하고 반복을 피할 수 있도록 이 내용을 이것만의 modifier로 옮기도록 하세.

_직접 해보기
zombiefeeding.sol을 다시 보도록 하겠네. 저 내용을 처음으로 썼던 곳이니 말이야. 확인 부분을 그 부분만의 modifier로 만들어 구조를 개선하겠네.
1. modifier를 ownerOf라는 이름으로 만들게. 이 제어자는 _zombieId(uint)를 1개의 인수로 받을 것이네. 제어자 내용에서는 msg.sender와 zombieToOwner[_zombieId]가 같은지 require로 확인하고, 함수를 실행해야 하네. 
   제어자의 문법이 기억이 나지 않는다면 zombiehelper.sol을 참고하면 되네.
2. feedAndMultiply의 함수 정의 부분을 ownerOf 제어자를 사용하도록 바꾸게.
3. 이제 modifier를 사용하게 됐으니, require(msg.sender == zombieToOwner[_zombieId]); 줄을 지워도 되네.
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

  // 1. 여기에 제어자를 생성하게
  modifier ownerOf(uint _zombieId) {
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
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal ownerOf(_zombieId){
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


