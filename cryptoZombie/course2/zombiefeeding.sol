// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 6: Import

// 우리 코드가 꽤 길어지고 있으니, 여러 파일로 나누어 정리하면 관리하기 더 편하겠지. 
// 보통 이런 방식으로 솔리디티 프로젝트의 긴 코드를 처리할 것이네.
// 다수의 파일이 있고 어떤 파일을 다른 파일로 불러오고 싶을 때, 솔리디티는 import라는 키워드를 이용하지.

// 예시
// import "./someothercontract.sol";
// contract newContract is SomeOtherContract {
// }

// 이 컨트랙트와 동일한 폴더에 (이게 ./가 의미하는 바임) someothercontract.sol이라는 파일이 있을 때, 이 파일을 컴파일러가 불러오게 되지.

// 여기에 import 구문을 넣기
import "./zombiefactory.sol";
contract ZombieFeeding is ZombieFactory {

}