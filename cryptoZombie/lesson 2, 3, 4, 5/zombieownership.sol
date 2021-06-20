// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* 챕터 3: balanceOf & ownerOf
훌륭해, 이제 ERC721 구현을 시작해보세!
내가 먼저 이번 레슨에서 구현할 모든 함수의 기본 구조를 복사해 놓았네.
이 챕터에서는, 우리는 첫 두 메소드를 구현할 것이네: balanceOf와 ownerOf 말이지.

* balanceOf
function balanceOf(address _owner) public view returns (uint256 _balance);
이 함수는 단순히 address를 받아, 해당 address가 토큰을 얼마나 가지고 있는지 반환하네.
이 경우, 우리의 "토큰"은 좀비들이 되겠지. 우리의 DApp에서 어떤 소유자가 얼마나 많은 좀비를 가지는지 저장해놓은 곳을 기억하는가?

* ownerOf
function ownerOf(uint256 _tokenId) public view returns (address _owner);
이 함수에서는 토큰 ID(우리의 경우에는 좀비 ID)를 받아, 이를 소유하고 있는 사람의 address를 반환하네.
다시 말하지만, 이들은 구현하기가 매우 수월하네. 우리가 이 정보를 저장하는 mapping을 우리 DApp에 이미 가지고 있기 떄문이지. 
이 함수들은 단 한 줄로 구현할 수 있네. return 문장 하나만 가지고 말이야.

| 참고 : uint256은 uint와 동일하다는 것을 기억하게. 우리 코드에서 지금까지 uint를 사용해왔지만, 여기서는 우리가 스펙을 복사/붙여넣기 했으니 uint256을 쓸 것이네.

_직접 해보기
이 두 함수를 어떻게 구현할지 직접 생각하고 이해해 보게. 각각의 함수는 return을 쓰는 딱 1줄의 코드로만 구성되어야 하네. 
이전 레슨들에서 우리의 코드를 살펴보고 우리가 이 데이터들을 어디에 저장하는지 확인해보게. 찾기 너무 힘들다면, "정답 보기" 버튼을 눌러 도움을 받게.

1. _owner가 가진 좀비의 수를 반환하도록 balanceOf를 구현하게.
2. ID가 _tokenId인 좀비를 가진 주소를 반환하도록 ownerOf를 구현하게.

*/

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

}

