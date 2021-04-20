// 프로그래머스 1 솔리디티 둘러보기

pragma solidity ^0.4.24;

contract Greeting {
    string name = "jhin";
    // 이곳에 string 타입의 상태 변수, name을 선언해 보세요.

    function getName() public view returns (string) {
        return name;
    }

    // 위에 함수를 참고하여 이곳에 name를 반환하는 getName 함수를 작성해보세요.
}

// public view 가 뭔지를 모르겠다.

// public
// 가시성이라는 속성 중 하나이다. 가시성은 함수로의 접근 권한에 대해 명시한다. 가시성에는 external, internal, public, private 등이 있다.
// function 은 기본적으로 public 으로 선언됩니다. 하지만 명시하지 않으면 warning message 를 전달하므로 명시해주는 것이 좋습니다.
// 1) public은 내부 컨트랙트에서 호출 가능합니다.
// 2) 상속받은 컨트랙트에서도 호출 가능하죠
// 3) 물론 외부 컨트랙트에서도 호출 가능합니다.

// 호출 가능하다는게 무슨 말인지 모르겠으면 https://potensj.tistory.com/18 이 링크에서 visible의 여러 예시함수를 참고할 것.
 

// view
// 1) 오직 데이터를 읽을 수만 있다.
// 2) 가스가 소모되지 않는다.
// view로 선언된 함수는 오직 데이터를 읽고 반환만 할 수 있다. view 로 선언된 함수 내에서 상태변수 값을 변경시면 에러가 발생한다. 
// 아래 링크에서 예시함수 확인해볼 것.
// view는 함수 접근 제어자이다. 함수를 선언할 때 같이 선언되어 함수에 대한 접근 권한에 대해 명시한다. 함수 접근 제어자에는 pure, payble 등이 있다.
// 출처: https://potensj.tistory.com/18 [개발이야기]
