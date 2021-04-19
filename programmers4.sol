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

// Ű����Ʈ : payable�̶�� �Լ� �����ڰ� �־�� �̴��� �ְ� ���� �� �ִ�.

//  �Լ� ������
//  https://cryptozombies.io/ko/lesson/4/chapter/1

//  ���� ������ (visibility modifier)

//   - private : ��Ʈ��Ʈ ������ �ٸ� �Լ��鿡���� ȣ��
//   - internal : �ش� ��Ʈ��Ʈ�� ����ϴ� ��Ʈ��Ʈ������ ȣ�� ����
//   - external : ��Ʈ��Ʈ �ܺο����� ȣ��
//   - public : ���ܺ� ��ο��� ȣ��


//  ���� ������ (state modifier) 

//   - view : � �����͵� ���� / ������� ����
//   - pure : ���ü���� � �����͵� ���� ����
//   -> ��Ʈ��Ʈ �ܺο��� �ҷ��� �� ������ �Ҹ����� �ʴ´�.



//  ������ (modifier)

//   - payable.
//    - �̴��� ���� �� �ִ� �Լ� ����
//    - payable�� ǥ�õ��� ���� �Լ��� �̴��� ������ �Ѵٸ� �ź�
//    - (0.001 ether)
