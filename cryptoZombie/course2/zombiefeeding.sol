// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure

// 챕터 1: 컨트랙트의 불변성

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

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

  // 여기에 있는 함수 정의를 변경
  //  _species에만 memory가 들어가는 이유. _species는 문자열 즉, 복합 데이터 타입이다. 그리고 함수의 매개변수는 기본적으로 memory에 저장되어야 하는데, 복합 데이터(매핑, 구조체, 배열 등)는 이를 따로 명시해줘야 한다.
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // 여기에 if 문 추가
// keccak256 안에 abi.encodePacked를 사용하여야 한다. (https://frontalnh.github.io/categories/ethereum/blockchain/) -> 2년전 글이라 abi.encodePacked(arg); 사용이 선택이라 명시했지만 지금은 필수인듯 하다.
    if(keccak256(abi.encodePacked(_species)) == keccak256("kitty")){
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // 여기에 있는 함수 호출을 변경: 
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}