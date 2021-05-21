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

// contract LuckyNumber {
//   mapping(address => uint) numbers;

//   function setNum(uint _num) public {
//     numbers[msg.sender] = _num;
//   }

//   function getNum(address _myAddress) public view returns (uint) {
//     return numbers[_myAddress];
//   }
// }

// 이 컨트랙트는 아무나 자신의 행운의 수를 저장할 수 있는 간단한 컨트랙트이고, 각자의 이더리움 주소와 연관이 있을 것이네. 
// 이 주소를 이용해서 누구나 그 사람의 행운의 수를 찾아 볼 수 있지.
// 이제 getNum 함수를 이용하여 이 컨트랙트에 있는 데이터를 읽고자 하는 external 함수가 있다고 해 보세.
// 먼저, LuckyNumber 컨트랙트의 인터페이스를 정의할 필요가 있네.

// contract NumberInterface {
//   function getNum(address _myAddress) public view returns (uint);
// }

// 약간 다르지만, 인터페이스를 정의하는 것이 컨트랙트를 정의하는 것과 유사하다는 걸 참고하게. 
// 먼저, 다른 컨트랙트와 상호작용하고자 하는 함수만을 선언할 뿐(이 경우, getNum이 바로 그러한 함수이지) 다른 함수나 상태 변수를 언급하지 않네.
// 다음으로, 함수 몸체를 정의하지 않지. 중괄호 {, }를 쓰지 않고 함수 선언을 세미콜론(;)으로 간단하게 끝내지.
// 그러니 인터페이스는 컨트랙트 뼈대처럼 보인다고 할 수 있지. 컴파일러도 그렇게 인터페이스를 인식하지.
// 우리의 dapp 코드에 이런 인터페이스를 포함하면 컨트랙트는 다른 컨트랙트에 정의된 함수의 특성, 호출 방법, 예상되는 응답 내용에 대해 알 수 있게 되지.
// 다음 레슨에서 다른 컨트랙트의 함수를 실제로 호출할 것일세. 지금은 크립토키티 컨트랙트를 위한 인터페이스를 선언해 보세.


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
