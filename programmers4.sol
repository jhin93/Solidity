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

