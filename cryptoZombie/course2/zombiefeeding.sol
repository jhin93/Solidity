// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure

// 챕터 10: 좀비가 무엇을 먹나요?

// 이제 좀비들에게 먹이를 줄 시간이군! 좀비가 가장 좋아하는 먹이가 뭘까?
// 크립토좀비가 가장 좋아하는 먹이는... 크립토키티! ???(그래, 정말이라네 ? )
// 좀비에게 크립토키티를 먹이로 주려면 크립토키티 스마트 컨트랙트에서 키티 DNA를 읽어와야 할 것이네. 
// 이게 가능한 이유는 크립토키티 데이터가 블록체인 상에 공개적으로 저장되어 있기 때문이지. 블록체인이 환상적이지 않나?!
// 걱정 말게 - 우리 게임이 어느 누구의 크립토키티에게도 실제 해를 끼치지 않을 것이니 말일세. 
// 우린 단지 크립토키티 데이터를 읽어 올 뿐이지. 실제로 이 데이터를 지울 수는 없다네. ?

// [다른 컨트랙트와 상호작용하기]

// 블록체인 상에 있으면서 우리가 소유하지 않은 컨트랙트와 우리 컨트랙트가 상호작용을 하려면 우선 인터페이스를 정의해야 하네.
// 간단한 예시를 살펴 보도록 하지. 다음과 같은 블록체인 컨트랙트가 있다고 해 보세:

contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}


import "./zombiefactory.sol";

// 여기에 KittyInterface를 생성한다

contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}
