// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* 챕터 2: ERC721 표준, 다중 상속
ERC721 표준을 한번 같이 살펴보도록 하지: 
(ERC-721은 이더리움 블록체인에서 대체 할 수 없거나 고유한 토큰을 작성하는 방법을 설명하는 무료 공개 표준이다. http://wiki.hash.kr/index.php/ERC-721#.ED.81.AC.EB.A6.BD.ED.86.A0.EB.8F.84.EC.A0.80)

contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _owner) public view returns (uint256 _balance);
  function ownerOf(uint256 _tokenId) public view returns (address _owner);
  function transfer(address _to, uint256 _tokenId) public;
  function approve(address _to, uint256 _tokenId) public;
  function takeOwnership(uint256 _tokenId) public;
}

이게 바로 우리가 구현해야 할 메소드들의 목록이네. 앞으로 남은 챕터들에서 차근차근 만들어 나갈 것들이지.
너무 많아 보여도, 걱정하지 말게! 내가 여기에 있으니 말이야.

|참고: ERC721 표준은 현재 초안인 상태이고, 아직 공식으로 채택된 구현 버전은 없네. 
|이 튜토리얼에서 우리는 OpenZeppelin 라이브러리에서 쓰이는 현재 버전을 사용할 것이지만, 공식 릴리즈 이전에 언젠가 바뀔 가능성도 있네. 
|그러니 하나의 구현 가능한 버전 정도로만 생각하고, ERC721 토큰의 정식 표준으로 생각하지는 말게. 

현재 ERC 721 표준 : https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md

_토큰 컨트랙트 구현
토큰 컨트랙트를 구현할 때, 처음 해야 할 일은 바로 인터페이스를 솔리디티 파일로 따로 복사하여 저장하고 import "./erc721.sol";을 써서 임포트를 하는 것이네. 
그리고 해당 컨트랙트를 상속하는 우리의 컨트랙트를 만들고, 각각의 함수를 오버라이딩하여 정의하여야 하지.
그런데 여기서 잠깐 - ZombieOwnership은 이미 ZombieAttack을 상속하고 있네 - 그렇다면 어떻게 ERC721도 상속하게 할 수 있을까?
운 좋게도 솔리디티에서는, 자네의 컨트랙트는 다음과 같이 다수의 컨트랙트를 상속할 수 있네:

contract SatoshiNakamoto is NickSzabo, HalFinney {
  // 오 이런, 이 세계의 비밀이 밝혀졌군!
}

자네도 볼 수 있듯이, 다중 상속을 쓸 때는 상속하고자 하는 다수의 컨트랙트를 쉼표(,)로 구분하면 되네. 위의 경우에, 컨트랙트는 NickSzabo와 HalFinney를 상속하고 있지. 한 번 직접 해보도록 하지.

_직접 해보기
자네를 위해 erc721.sol 파일을 인터페이스와 함께 만들어 놓았네.
1. erc721.sol 파일을 zombieownership.sol 파일에서 임포트하게.
2. ZombieOwnership이 ZombieAttack과 ERC721을 상속한다고 선언하게.
*/

import "./zombieattack.sol";
// 여기서 import 하게.
import "./erc721.sol";

// 여기서 ERC721 상속을 선언하게.
contract ZombieOwnership is ZombieAttack, ERC721 {

}

