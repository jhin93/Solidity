// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;


contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie{
        string name;
        uint dna;
    }
    // Zombie 구조체의 public 배열. 이름은 zombies
    Zombie[] public zombies;

}

// 배열. 정적배열과 동적배열.

// 2개의 원소를 담을 수 있는 고정 길이의 배열:
// uint[2] fixedArray;

// 또다른 고정 배열으로 5개의 스트링을 담을 수 있다:
// string[5] stringArray;

// 동적 배열은 고정된 크기가 없으며 계속 크기가 커질 수 있다:
// uint[] dynamicArray;


// 상태 변수

// 상태 변수는 컨트랙트 저장소에 영구적으로 저장되네. 즉, 이더리움 블록체인에 기록된다는 거지. 데이터베이스에 데이터를 쓰는 것과 동일하네.

// contract Example {
//   이 변수는 블록체인에 영구적으로 저장된다.
//   uint myUnsignedInteger = 100;
// }

// 이 예시 컨트랙트에서는 myUnsignedInteger라는 uint를 생성하여 100이라는 값을 배정했네.

// 상태 변수가 블록체인에 영구적으로 저장될 수 있다는 걸 기억하나? 그러니 이처럼 구조체의 동적 배열을 생성하면 마치 데이터베이스처럼 컨트랙트에 구조화된 데이터를 저장하는 데 유용하네.




// 의문점.
// public으로 배열을 선언할 수 있지. 솔리디티는 이런 배열을 위해 getter 메소드를 자동적으로 생성하지.
// 그러면 다른 컨트랙트들이 이 배열을 읽을 수 있게 되지 (쓸 수는 없네). 이는 컨트랙트에 공개 데이터를 저장할 때 유용한 패턴이지.



// 의문점 해결. public function은 다른 컨트랙트에서 쓸 수도 있지만, public 배열은 그렇지 않다.
// https://needjarvis.tistory.com/320

// 이렇게 배열로 만들어진 변수를 다른 컨트랙트들이 읽을 수 있게 하려면 public으로 지정을 하면 된다. 
// 참고로 다른 컨트랙트가 읽을 수 있게 getter 메소드를 자동적으로 생성하지만 setter 메소드를 생성하는 것은 아니다. 그렇기 때문에 읽을 수만 있고 쓸 수는 없다.

// getter, setter 메소드
// https://velog.io/@mollog/getter-setter%EB%9E%80