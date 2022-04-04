// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

// 우리가 _generateRandomDna 함수의 반환값이 (반) 랜덤인 uint가 되기를 원하면, 어떻게 하면 되겠는가?

// 이더리움은 SHA3의 한 버전인 keccak256를 내장 해시 함수로 가지고 있지. 
//해시 함수는 기본적으로 입력 스트링을 랜덤 256비트 16진수로 매핑하네. 스트링에 약간의 변화라도 있으면 해시 값은 크게 달라지네.
//해시 함수는 이더리움에서 여러 용도로 활용되지만, 여기서는 의사 난수 발생기(pseudo-random number generator)로 이용하도록 하지.

// keccak256("aaaab");
// 결과 : 6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
// keccak256("aaaac");
// 결과 : b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9

// 이 예시를 보면 입력값의 한 글자가 달라졌음에도 불구하고 반환값은 완전히 달라짐을 알 수 있지.

// 형 변환
// 가끔씩 자네가 자료형 간에 변환을 할 필요가 있지. 다음 예시를 살펴보세:

// uint8 a = 5;
// uint b = 6;
// uint8 c = a * b; 
// a * b가 uint8이 아닌 uint를 반환하기 때문에 에러 메시지가 난다:
// uint8 c = a * uint8(b); 
// b를 uint8으로 형 변환해서 코드가 제대로 작동하도록 해야 한다:

// 위의 예시에서 a * b는 uint를 반환하지. 
// 하지만 우리는 이 반환값을 uint8에 저장하려고 하니 잠재적으로 문제를 야기할 수 있네. 
// 반환값을 uint8으로 형 변환하면 코드가 제대로 작동하고 컴파일러도 에러 메시지를 주지 않을 걸세.

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

    function _generateRandomDna(string memory _str) private view returns (uint) {
        // 여기서 시작
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        // uint(keccak256(_str)); -> 이렇게만 입력했을 때, 오류 발생. 오류 : string memory -> byte memory로 변환할 때 문제가 생김. 문제 : This function requires a single bytes argument.
        // abi-encodepacked가 필요하다고 함. 아래 링크로 해결.
        // https://ethereum.stackexchange.com/questions/68360/invalid-implicit-conversion-from-uint256-to-bytes-memory-requested
        return rand % dnaModulus;
        // %는 나머지를 구하는 것.
    }

}

// public과 private 다시.
// 솔리디티에서 함수는 기본적으로 public으로 선언됨. 누구나(혹은 다른 어느 컨트랙트가) 내 컨트랙트의 함수를 호출하고 코드를 실행할 수 있다.
// 이와 달리 private는 컨트랙트 내의 다른 함수들만이 호출할 수 있다는 뜻.

// abi-encodepacked란?
// https://frontalnh.github.io/categories/ethereum/blockchain/