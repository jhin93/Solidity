pragma solidity ^0.4.24;

contract Variables {
    // 값을 바꾸고 [실행]을 눌러 출력을 확인해보세요!
    string public name = "Jhin";
    uint128 public birthday = 20180328;
    address public addr = 0x72ba7d8e73fe8eb666ea66babc8116a41bfb10e2;
    uint[] setOfYear = [2018, 2019, 2020];

    // [제출]을 위한 상태 변수 선언 입니다.
    uint year = setOfYear[0];
    bool isHappy = true;

    // 이 곳에 주석을 지우고 getYear() 함수를 완성해보세요.
    function getYear() public view returns (uint) {
        return year;
    }

    // 이 곳에 getHappy() 함수를 작성해보세요.
    function getHappy() public view returns (bool) {
        return isHappy;
    }
}

// pragma. 
// 컴파일러에게 직접 명령을 내리는 지시자.
// 모든 Solidity 계약 파일은 최상단에 [pragma ^버전] 을 삽입해야 한다.
// pragma once() : compile을 한번만 실행
// https://m.blog.naver.com/PostView.nhn?blogId=wnsdnjsjay&logNo=150178059882&proxyReferer=https:%2F%2Fwww.google.com%2F

// 자료형
// https://needjarvis.tistory.com/255

// address
// address는 balance, transfer, send, call, callcode, delegatecall 등을 member로 가진다.
// address는 golang의 &와 비슷한 역할을 한다.

// 사용예시 
// address x = 0x123;
// address myAddress = this;
// if (x.balance < 10 && myAddress.balance >= 10) x.transfer(10);


// https://solidity-kr.readthedocs.io/ko/latest/types.html#address