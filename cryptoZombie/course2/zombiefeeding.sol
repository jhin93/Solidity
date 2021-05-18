// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 7: Storage vs Memory
// 솔리디티에는 변수를 저장할 수 있는 공간으로 storage와 memory 두 가지가 있지.

// Storage는 블록체인 상에 영구적으로 저장되는 변수를 의미하지. 
// Memory는 임시적으로 저장되는 변수로, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워지지. 
// 두 변수는 각각 컴퓨터 하드 디스크와 RAM과 같지.

// 대부분의 경우에 자네는 이런 키워드들을 이용할 필요가 없네. 
// 왜냐면 솔리디티가 알아서 처리해 주기 때문이지. 
// 상태 변수(함수 외부에 선언된 변수)는 초기 설정상 storage로 선언되어 블록체인에 영구적으로 저장되는 반면, 
// 함수 내에 선언된 변수는 memory로 자동 선언되어서 함수 호출이 종료되면 사라지지.

// 하지만 이 키워드들을 사용해야 하는 때가 있지. 바로 함수 내의 구조체와 _배열_을 처리할 때지

// contract SandwichFactory {
//   struct Sandwich {
//     string name;
//     string status;
//   }

//   Sandwich[] sandwiches;

//   function eatSandwich(uint _index) public {
//     // Sandwich mySandwich = sandwiches[_index];

//     // ^ 꽤 간단해 보이나, 솔리디티는 여기서 
//     // `storage`나 `memory`를 명시적으로 선언해야 한다는 경고 메시지를 발생한다. 
//     // 그러므로 `storage` 키워드를 활용하여 다음과 같이 선언해야 한다:
//     Sandwich storage mySandwich = sandwiches[_index];
//     // ...이 경우, `mySandwich`는 저장된 `sandwiches[_index]`를 가리키는 포인터이다.
//     // 그리고 
//     mySandwich.status = "Eaten!";
//     // ...이 코드는 블록체인 상에서 `sandwiches[_index]`을 영구적으로 변경한다. 

//     // 단순히 복사를 하고자 한다면 `memory`를 이용하면 된다: 
//     Sandwich memory anotherSandwich = sandwiches[_index + 1];
//     // ...이 경우, `anotherSandwich`는 단순히 메모리에 데이터를 복사하는 것이 된다. 
//     // 그리고 
//     anotherSandwich.status = "Eaten!";
//     // ...이 코드는 임시 변수인 `anotherSandwich`를 변경하는 것으로 
//     // `sandwiches[_index + 1]`에는 아무런 영향을 끼치지 않는다. 그러나 다음과 같이 코드를 작성할 수 있다: 
//     sandwiches[_index + 1] = anotherSandwich;
//     // ...이는 임시 변경한 내용을 블록체인 저장소에 저장하고자 하는 경우이다.
//   }
// }

// 어떤 키워드를 이용해야 하는지 정확하게 이해하지 못한다고 해도 걱정 말게. 
// 이 튜토리얼을 진행하는 동안 언제 storage 혹은 memory를 사용해야 하는지 알려 주겠네. 
// 솔리디티 컴파일러도 경고 메시지를 통해 어떤 키워드를 사용해야 하는지 알려 줄 것이네.
// 지금으로선 명시적으로 storage나 memory를 선언할 필요가 있는 경우가 있다는 걸 이해하는 것만으로 충분하네!

// storage, memory 예제
// https://www.geeksforgeeks.org/storage-vs-memory-in-solidity/

// 여기에 import 구문을 넣기
import "./zombiefactory.sol";
contract ZombieFeeding is ZombieFactory {
    // 여기서 시작
    // 이 함수는 인자를 전달받아 쓰는 pure가 아닌 데이터(msg.sender나 zombieToOwner 등)를 읽고 써야 하기에 'view'를 사용해야 한다.
    // 근데 왜 Zombie storage myZombie = zombies[_zombieId]; -> 이 행은 에러가 안나지? storage를 써서 변화시켰는데?
    // 나름의 답 도출 - 상태변수를 변화시킨게 아니라 Zombie라는 지역변수를 선언하는 것이라 가능한 듯.
    function feedAndMultiply(uint _zombieId, uint _targetDna) view public {
        // 매핑 zombieToOwner에 uint _zombieId를 넣은 값은 타입이 address여야 하고 그게 msg.sender와 동일하면 주인으로 인정된다.
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
    }
}