
// Solidity 1����
// ����Ʈ ��Ʈ��Ʈ �Ұ�.
// ������ ����Ʈ ��Ʈ��Ʈ
// https://solidity-kr.readthedocs.io/ko/latest/introduction-to-smart-contracts.html

pragma solidity >=0.4.0 < 0.6.0;

contract SimpleStorage {
    uint storedDta;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}

// #pragma once��, ���־�Ʃ������� �����ϴ� ������ ��ó����ν�, ��� �ڵ峪 ��������� �ٸ� �ڵ峪 ������� include �ɶ�, �ߺ��Ǿ� ����Ǵ� ���� �����ϴ� ����� �Ѵ�.
// �߰����� - https://wiserloner.tistory.com/264