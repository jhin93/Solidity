pragma solidity ^0.4.24;

contract Variables {
    // ���� �ٲٰ� [����]�� ���� ����� Ȯ���غ�����!
    string public name = "Jhin";
    uint128 public birthday = 20180328;
    address public addr = 0x72ba7d8e73fe8eb666ea66babc8116a41bfb10e2;
    uint[] setOfYear = [2018, 2019, 2020];

    // [����]�� ���� ���� ���� ���� �Դϴ�.
    uint year = setOfYear[0];
    bool isHappy = true;

    // �� ���� �ּ��� ����� getYear() �Լ��� �ϼ��غ�����.
    function getYear() public view returns (uint) {
        return year;
    }

    // �� ���� getHappy() �Լ��� �ۼ��غ�����.
    function getHappy() public view returns (bool) {
        return isHappy;
    }
}

// pragma. 
// �����Ϸ����� ���� ����� ������ ������.
// ��� Solidity ��� ������ �ֻ�ܿ� [pragma ^����] �� �����ؾ� �Ѵ�.
// pragma once() : compile�� �ѹ��� ����
// https://m.blog.naver.com/PostView.nhn?blogId=wnsdnjsjay&logNo=150178059882&proxyReferer=https:%2F%2Fwww.google.com%2F

