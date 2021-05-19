// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure

// 챕터 9: 함수 접근 제어자 더 알아보기.

// 지난 레슨의 코드에 실수가 있네!
// 자네가 코드를 컴파일하려고 하면 컴파일러가 에러 메시지를 출력할 거네.
// 문제는 ZombieFeeding 컨트랙트 내에서 _createZombie 함수를 호출하려고 했다는 거지. 
// 그런데 _createZombie 함수는 ZombieFactory 컨트랙트 내의 private 함수이지. 
// 즉, ZombieFactory 컨트랙트를 상속하는 어떤 컨트랙트도 이 함수에 접근할 수 없다는 뜻이지.

// Internal과 External.
// public과 private 이외에도 솔리디티에는 internal과 external이라는 함수 접근 제어자가 있지.

// internal은 함수가 정의된 컨트랙트를 상속하는 컨트랙트에서도 접근이 가능하다 점을 제외하면 private과 동일하지. **(우리한테 필요한 게 바로 internal인 것 같군!

// external은 함수가 컨트랙트 바깥에서만 호출될 수 있고 컨트랙트 내의 다른 함수에 의해 호출될 수 없다는 점을 제외하면 public과 동일하지. 나중에 external과 public이 각각 왜 필요한지 살펴 볼 것이네.

// interal이나 external 함수를 선언하는 건 private과 public 함수를 선언하는 구문과 동일하네.

// 예시.
// contract Sandwich {
//   uint private sandwichesEaten = 0;

//   function eat() internal {
//     sandwichesEaten++;
//   }
// }

// contract BLT is Sandwich {
//   uint private baconSandwichesEaten = 0;

//   function eatWithBacon() public returns (string) {
//     baconSandwichesEaten++;
//     // eat 함수가 internal로 선언되었기 때문에 여기서 호출이 가능하다 
//     eat();
//   }
// }

import "./zombiefactory.sol";
contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        // 아래 _createZombie 함수 실행에서 오류발생. Function declared as view, but this expression (potentially) modifies the state and thus requires non-payable (the default) or payable.
        // 부모 함수(feedAndMultiply)의 'view'를 삭제해서 해결. 함수는 데이터를 보기만하고 변경하지 않는다.
        _createZombie("NoName", newDna);
    }
}