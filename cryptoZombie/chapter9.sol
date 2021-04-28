// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

}

// 의문점 해결.

// https://ethereum.stackexchange.com/questions/63294/typeerror-data-location-must-be-storage-or-memory-for-parameter-in-function
// solidity 0.5.0 버전부터는 구조체, 배열 또는 매핑 등의 모든 변수를 위해 데이터 위치를 명시하는 것이 필수.

// https://solidity-kr.readthedocs.io/ko/latest/types.html  ->  '데이터 위치' 검색
// solidity 0.4 버전까지는 데이터 위치가 자동적으로 지정되어 굳이 명시하지 않아도 됐었음.

// 모든 복합 타입은 자신이 메모리 나 스토리지 중 어디에 저장되었는지를 나타내는 "데이터 위치"가 추가적으로 존재합니다. 
// 컨텍스트에 따라 항상 기본값이 존재하지만, 타입에 스토리지 나 메모리 를 추가하여 재정의 할 수 있습니다. 
// 함수 매개 변수(인자)와 반환 변수(리턴값)의 기본값은 메모리 이고, 지역변수의 기본값은 스토리지 이며 상태변수의 위치는 스토리지로 강제되어 있습니다.

// * 상태변수 = 컨트랙트 저장소에 영구적으로 저장이 되는 변수
// * 지역변수 = 1회성으로 해당 구역에서만 쓰는 값

// private는 컨트랙트 내의 다른 함수들만이 이 함수를 호출하여 numbers 배열로 무언가를 추가할 수 있다는 것을 의미하지.
// 위의 예시에서 볼 수 있듯이 private 키워드는 함수명 다음에 적네. 
// 함수 인자명과 마찬가지로 private한 함수명도 언더바(_)로 시작하는 것이 관례라네.