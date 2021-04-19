pragma solidity ^0.4.24;

contract Solution {
    uint256 balance = 0;

    // payable 키워드를 넣어 함수를 완성하세요
    function sending() payable public {
        balance = msg.value;
        Sended(msg.value, balance);
    }

    //로깅을 위한 이벤트입니다. 삭제하지 마세요,
    event Sended(
        uint256 _value,
        uint256 _balance
    );
}

// 키포인트 : payable이라는 함수 제어자가 있어야 이더를 주고 받을 수 있다.

//  함수 제어자
//  https://cryptozombies.io/ko/lesson/4/chapter/1

//  접근 제어자 (visibility modifier)

//   - private : 컨트랙트 내부의 다른 함수들에서만 호출
//   - internal : 해당 컨트랙트를 상속하는 컨트랙트에서도 호출 가능
//   - external : 컨트랙트 외부에서만 호출
//   - public : 내외부 모두에서 호출


//  상태 제어자 (state modifier) 

//   - view : 어떤 데이터도 저장 / 변경되지 않음
//   - pure : 블록체인의 어떤 데이터도 읽지 않음
//   -> 컨트랙트 외부에서 불렸을 때 가스를 소모하지 않는다.



//  제어자 (modifier)

//   - payable.
//    - 이더를 받을 수 있는 함수 유형
//    - payable로 표시되지 않은 함수에 이더를 보내려 한다면 거부
//    - (0.001 ether)
