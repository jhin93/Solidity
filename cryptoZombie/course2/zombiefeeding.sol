// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure

// 챕터 10: 좀비가 무엇을 먹나요?

// getKitty 함수가 어떤 함수인지 알아 보았으니, 이를 이용하여 인터페이스를 만들어 볼 수 있을 걸세.
// KittyInterface라는 인터페이스를 정의한다. 인터페이스 정의가 contract 키워드를 이용하여 새로운 컨트랙트를 생성하는 것과 같다는 점을 기억할 것.
// 인터페이스 내에 getKitty 함수를 선언한다 (위의 함수에서 중괄호 안의 모든 내용은 제외하고 return 키워드 및 반환 값 종류까지만 복사/붙여넣기 하고 그 다음에 세미콜론을 넣어야 한다).

import "./zombiefactory.sol";

// 에러 발생
// 1. Contract "KittyInterface" should be marked as abstract. - contract KittyInterface에서 발생.
// 2. Functions without implementation must be marked virtual. - function getKitty(uint256 _id) external view returns 에서 발생.
contract KittyInterface {
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
    // 코드를 보면 ckAddress라는 변수에 크립토키티 컨트랙트 주소가 입력되어 있다. 
    // 다음 줄에 kittyContract라는 KittyInterface를 생성하고, 위의 numberContract 선언 시와 동일하게 ckAddress를 이용하여 초기화한다.
    
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // `ckAddress`를 이용하여 여기에 kittyContract를 초기화한다
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}
