pragma solidity ^0.4.24;

contract Variables {
    // 값을 바꾸고 [실행]을 눌러 출력을 확인해보세요!
    string public name = "James";
    uint128 public birthday = 20180328;
    address public addr = 0x72ba7d8e73fe8eb666ea66babc8116a41bfb10e2;
    uint[] setOfYear = [2018, 2019, 2020];

    // [제출]을 위한 상태 변수 선언 입니다.
    uint year = setOfYear[0];
    bool isHappy = true;

    // 이 곳에 주석을 지우고 getYear() 함수를 완성해보세요.
    // function getYear() public view returns (/* 자료형 */) {
    //     return /* 상태 변수명 */
    // }

    // 이 곳에 getHappy() 함수를 작성해보세요.
    // function getHappy() public ....
}