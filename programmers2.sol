pragma solidity ^0.4.24;

contract Variables {
    // ���� �ٲٰ� [����]�� ���� ����� Ȯ���غ�����!
    string public name = "James";
    uint128 public birthday = 20180328;
    address public addr = 0x72ba7d8e73fe8eb666ea66babc8116a41bfb10e2;
    uint[] setOfYear = [2018, 2019, 2020];

    // [����]�� ���� ���� ���� ���� �Դϴ�.
    uint year = setOfYear[0];
    bool isHappy = true;

    // �� ���� �ּ��� ����� getYear() �Լ��� �ϼ��غ�����.
    // function getYear() public view returns (/* �ڷ��� */) {
    //     return /* ���� ������ */
    // }

    // �� ���� getHappy() �Լ��� �ۼ��غ�����.
    // function getHappy() public ....
}