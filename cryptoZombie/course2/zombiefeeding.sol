// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 7: Storage vs Memory
// 솔리디티에는 변수를 저장할 수 있는 공간으로 storage와 memory 두 가지가 있지.

// Storage는 블록체인 상에 영구적으로 저장되는 변수를 의미하지. 
// Memory는 임시적으로 저장되는 변수로, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워지지. 
// 두 변수는 각각 컴퓨터 하드 디스크와 RAM과 같지.

// 대부분의 경우에 자네는 이런 키워드들을 이용할 필요가 없네. 
// 왜냐면 솔리디티가 알아서 처리해 주기 때문이지. 
// 상태 변수(함수 외부에 선언된 변수)는 초기 설정상 storage로 선언되어 블록체인에 영구적으로 저장되는 반면, 
// 함수 내에 선언된 변수는 memory로 자동 선언되어서 함수 호출이 종료되면 사라지지.

// 여기에 import 구문을 넣기
import "./zombiefactory.sol";
contract ZombieFeeding is ZombieFactory {

}