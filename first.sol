
// Solidity 1일차
// 스마트 컨트랙트 소개.
// 간단한 스마트 컨트랙트
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

// #pragma once는, 비주얼스튜디오에서 제공하는 간편한 전처리기로써, 어떠한 코드나 헤더파일이 다른 코드나 헤더에서 include 될때, 중복되어 복사되는 것을 방지하는 기능을 한다.
// 추가설명 - https://wiserloner.tistory.com/264