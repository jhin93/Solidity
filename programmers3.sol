pragma solidity ^0.4.24;

contract Solution {
    uint t1 = 0;
    bool t2 = false;

    function playground() public returns (uint, bool) {

        // ���⿡ �����ڿ� ����� �׽�Ʈ �غ�����.

        // �̷������� �׽�Ʈ�� �غ�����!
        /*
        for (uint i = 0; i < 10; i++) {
            t1++;
        }

        t2 = 2 ** 3 == 8 && t1 == 10;
        */

        getLog(t1, t2); // �������� ������. �̺�Ʈ ȣ�� �Դϴ�.
        return (t1, t2);
    }

    // �������� ������. �α��� ���� �̺�Ʈ�Դϴ�. �̺�Ʈ�� ���� ���ǿ��� �ٷ�ڽ��ϴ�.
    event getLog(uint _t1, bool _t2);
}