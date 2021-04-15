pragma solidity ^0.4.24;

contract Solution {
    uint t1 = 0;
    bool t2 = false;

    function playground() public returns (uint, bool) {

        // 여기에 연산자와 제어문을 테스트 해보세요.

        // 이런식으로 테스트를 해보세요!
        /*
        for (uint i = 0; i < 10; i++) {
            t1++;
        }

        t2 = 2 ** 3 == 8 && t1 == 10;
        */

        getLog(t1, t2); // 삭제하지 마세요. 이벤트 호출 입니다.
        return (t1, t2);
    }

    // 삭제하지 마세요. 로깅을 위한 이벤트입니다. 이벤트는 이후 강의에서 다루겠습니다.
    event getLog(uint _t1, bool _t2);
}