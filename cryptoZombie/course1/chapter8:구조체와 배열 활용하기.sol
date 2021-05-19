// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;


// 지난 예시의 Person 구조체를 기억하나?

// struct Person {
//   uint age;
//   string name;
// }
// Person[] public people;

// 이제 새로운 Person를 생성하고 people 배열에 추가하는 방법을 살펴보도록 하지.

// 새로운 사람을 생성한다:
// Person satoshi = Person(172, "Satoshi");
// 이 사람을 배열에 추가한다:
// people.push(satoshi);

// 이 두 코드를 조합하여 깔끔하게 한 줄로 표현할 수 있네:
// people.push(Person(16, "Vitalik"));

// uint[] numbers;
// numbers.push(5);
// numbers.push(10);
// numbers.push(15);
// numbers 배열은 [5, 10, 15]과 같다.

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function createZombie(string _name, uint _dna) public {
        // 여기서 시작
        zombies.push(_name, _dna);
    }

}


// Storage 와 Memory.
// https://steemit.com/hive-101145/@happyberrysboy/happyberrysboy-posting-2020-08-14-00-24

// 솔리디티에는 변수를 저장할 수 있는 공간으로 storage와 memory, 두 가지가 있습니다.
// Storage는 블록체인 상에 영구적으로 저장되는 변수를 의미합니다.
// Memory는 임시적으로 저장되는 변수로, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워집니다.

// 솔리디티가 알아서 처리해 주기 때문이지 대부분의 경우에 이 키워드들을 이용할 필요가 없습니다.
// 상태 변수(함수 외부에 선언된 변수)는 초기 설정상 storage로 선언되어 블록체인에 영구적으로 저장되는 반면, 함수 내에 선언된 변수는 memory로 자동 선언되어서 함수 호출이 종료되면 사라지게 됩니다.
// 하지만 이 키워드들을 사용해야 하는 경우가 있습니다. 바로 함수 내의 구조체와 배열을 처리할 때!!


// storage와 memory에 대한 예시.

contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // 윗 문장처럼 작성하면 `storage`나 `memory`를 명시적으로 선언해야 한다는 경고 메시지를 발생한다. 
    // 그러므로 `storage` 키워드를 활용하여 다음과 같이 선언해야 한다:
    Sandwich storage mySandwich = sandwiches[_index];
    // 이 경우, `mySandwich`는 저장된 `sandwiches[_index]`를 가리키는 포인터이다.
    // 그리고 
    mySandwich.status = "Eaten!";
    // 이 코드는 블록체인 상에서 `sandwiches[_index]`을 영구적으로 변경한다. 

    // 단순히 복사를 하고자 한다면 `memory`를 이용하면 된다: 
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // 이 경우, `anotherSandwich`는 단순히 메모리에 데이터를 복사하는 것이 된다. 
    // 그리고 
    anotherSandwich.status = "Eaten!";
    // 이 코드는 임시 변수인 `anotherSandwich`를 변경하는 것으로 `sandwiches[_index + 1]`에는 아무런 영향을 끼치지 않는다. 
    // 그러나 다음과 같이 코드를 작성할 수 있다: 
    sandwiches[_index + 1] = anotherSandwich;
    // 이는 임시 변경한 내용을 블록체인 저장소에 저장하고자 하는 경우이다.
  }
}


// calldata.

// calldata는 storage, memory와 같이 데이터를 저장하는 장소 중 하나.
// solidity 버전 4와 5의 차이가 큰 듯 하다.
// 5를 기준으로 calldata는 external 함수의 인자를 위한 저장소이다. external 함수에 이용하기 위해 좀 더 긴 lifetime 을 가지고 있다.
// https://medium.com/day34/solidity-0-5-0-%EC%97%90%EC%84%9C%EC%9D%98-%EB%B3%80%EA%B2%BD%EC%82%AC%ED%95%AD%EC%9D%84-%EC%86%8C%EA%B0%9C%ED%95%A9%EB%8B%88%EB%8B%A4-ab6104296164
// memory처럼 사라지고, 수정할 수 없다.
// https://docs.soliditylang.org/en/v0.5.3/types.html

// 가시성 중 external은 계약서의 해당 내용을 공개한다는 의미이며, 계약서의 외부에서 사용하는 인터페이스라는 것을 명시하는 것.
// 그렇기 때문에 이런 external 함수에 사용되는 calldata는 수정도 안되고, 함수 내에서만 사용되고 지워지는 듯 하다.



