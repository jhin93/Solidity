// SPDX-License-Identifier: UNLICENSED
// 컨트랙트는 오픈소스를 기본으로 하기 때문에 라이센스를 명시해 주는 것이 좋습니다. 솔리디티는 주석으로 SPDX 방법에 따라 라이센스를 작성합니다. 
// 오픈소스가 아니거나 라이센스를 명시하지 않고 싶을 때는 UNLICENSED로 작성합니다. 
// http://www.umlcert.com/ethereum-dapps-11/

// SPDX란? 
// 소프트웨어 패키지 데이터 교환(SPDX)은 주어진 컴퓨터 소프트웨어 가 배포 되는 소프트웨어 라이센스 에 대한 정보를 문서화하는 데 사용되는 파일 형식 입니다. 
// SPDX는 Linux Foundation 의 후원하에 20 개 이상의 서로 다른 조직을 대표하는 SPDX 워킹 그룹에 의해 작성되었습니다 
// https://en.wikipedia.org/wiki/Software_Package_Data_Exchange
// https://www.olis.or.kr/license/licenseSPDX.do?mapcode=010107&page=1

// 스마트 컨트랙트 소개.
// 간단한 스마트 컨트랙트
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

// #pragma once는, 비주얼스튜디오에서 제공하는 간편한 전처리기로써, 어떠한 코드나 헤더파일이 다른 코드나 헤더에서 include 될때, 중복되어 복사되는 것을 방지하는 기능을 한다.
// 추가설명 - https://wiserloner.tistory.com/264