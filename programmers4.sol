pragma solidity ^0.4.24;

contract Solution {
    uint256 balance = 0;

    // payable Ű���带 �־� �Լ��� �ϼ��ϼ���
    function sending() payable public {
        balance = msg.value;
        Sended(msg.value, balance);
    }

    //�α��� ���� �̺�Ʈ�Դϴ�. �������� ������,
    event Sended(
        uint256 _value,
        uint256 _balance
    );
}

