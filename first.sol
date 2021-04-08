// SPDX-License-Identifier: UNLICENSED
// ��Ʈ��Ʈ�� ���¼ҽ��� �⺻���� �ϱ� ������ ���̼����� ����� �ִ� ���� �����ϴ�. �ָ���Ƽ�� �ּ����� SPDX ����� ���� ���̼����� �ۼ��մϴ�. 
// ���¼ҽ��� �ƴϰų� ���̼����� ������� �ʰ� ���� ���� UNLICENSED�� �ۼ��մϴ�. 
// http://www.umlcert.com/ethereum-dapps-11/

// SPDX��? 
// https://en.wikipedia.org/wiki/Software_Package_Data_Exchange
// https://www.olis.or.kr/license/licenseSPDX.do?mapcode=010107&page=1

// ����Ʈ ��Ʈ��Ʈ �Ұ�.
// ������ ����Ʈ ��Ʈ��Ʈ
// https://solidity-kr.readthedocs.io/ko/latest/introduction-to-smart-contracts.html

pragma solidity ^0.7.0;

contract SimpleStorage {
    uint storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}

// #pragma once��, ���־�Ʃ������� �����ϴ� ������ ��ó����ν�, ��� �ڵ峪 ��������� �ٸ� �ڵ峪 ������� include �ɶ�, �ߺ��Ǿ� ����Ǵ� ���� �����ϴ� ����� �Ѵ�.
// �߰����� - https://wiserloner.tistory.com/264