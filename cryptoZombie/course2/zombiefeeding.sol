// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure

// 챕터 3: onlyOwner 함수 제어자

// 자, 이제 우리의 기본 컨트랙트인 ZombieFactory가 Ownable을 상속하고 있으니, 우리는 onlyOwner 함수 제어자를 ZombieFeeding에서도 사용할 수 있네.
// 이건 컨트랙트가 상속되는 구조 때문이지. 아래 내용을 기억하게:
// ZombieFeeding is ZombieFactory
// ZombieFactory is Ownable

// 그렇기 때문에 ZombieFeeding 또한 Ownable이고, Ownable 컨트랙트의 함수/이벤트/제어자에 접근할 수 있다네. 
// 이건 향후에 ZombieFeeding을 상속하는 다른 컨트랙트들에도 마찬가지로 적용되네.

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

  // 이 함수를 수정하게:
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

// 함수 제어자

// 함수 제어자는 함수처럼 보이지만, function 키워드 대신 modifier 키워드를 사용한다네. 
// 그리고 자네가 함수를 호출하듯이 직접 호출할 수는 없지. 대신에 함수 정의부 끝에 해당 함수의 작동 방식을 바꾸도록 제어자의 이름을 붙일 수 있네.

// onlyOwner를 살펴보면서 더 자세히 알아보도록 하지.

// /**
//  * @dev Throws if called by any account other than the owner.
//  */
// modifier onlyOwner() {
//   require(msg.sender == owner);
//   _;
// }

// 우리는 이 제어자를 다음과 같이 사용할 것이네:

// contract MyContract is Ownable {
//   event LaughManiacally(string laughter);

//   // 아래 `onlyOwner`의 사용 방법을 잘 보게:
//   function likeABoss() external onlyOwner {
//     LaughManiacally("Muahahahaha");
//   }
// }

// 사용법 -------- 중요 ----------
// likeABoss 함수의 onlyOwner 제어자 부분을 잘 보게. 
// 자네가 likeABoss 함수를 호출하면, onlyOwner의 코드가 먼저 실행되네. 
// 그리고 onlyOwner의 _; 부분을 likeABoss 함수로 되돌아가 해당 코드를 실행하게 되지.

// 자네가 제어자를 사용할 수 있는 다양한 방법이 있지만, 가장 일반적으로 쓰는 예시 중 하나는 함수 실행 전에 require 체크를 넣는 것이네.
// onlyOwner의 경우에는, 함수에 이 제어자를 추가하면 오직 컨트랙트의 소유자(자네가 배포했다면 자네겠지)만이 해당 함수를 호출할 수 있네.

// 참고: 이렇게 소유자가 컨트랙트에 특별한 권한을 갖도록 하는 것은 자주 필요하지만, 이게 악용될 수도 있다네. 
// 예를 들어, 소유자가 다른 사람의 좀비를 뺏어올 수 있도록 하는 백도어 함수를 추가할 수도 있지!

// 그러니 잘 기억하게. 이더리움에서 돌아가는 DApp이라고 해서 그것만으로 분산화되어 있다고 할 수는 없네. 
// 반드시 전체 소스 코드를 읽어보고, 자네가 잠재적으로 걱정할 만한, 소유자에 의한 특별한 제어가 불가능한 상태인지 확인하게. 
// 개발자로서는 자네가 잠재적인 버그를 수정하고 DApp을 안정적으로 유지하도록 하는 것과, 사용자들이 그들의 데이터를 믿고 저장할 수 있는 소유자가 없는 플랫폼을 만드는 것 사이에서 균형을 잘 잡는 것이 중요하네.