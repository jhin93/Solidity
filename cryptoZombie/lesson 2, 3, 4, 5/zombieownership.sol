// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* 챕터 5: ERC721: 전송 로직
좋아, 충돌을 해결했군! 이제 우리의 ERC721에서 한 사람이 다른 사람에게 소유권을 넘기는 것을 구현해 나갈 것이네.
ERC721 스펙에서는 토큰을 전송할 때 2개의 다른 방식이 있음을 기억하게:

function transfer(address _to, uint256 _tokenId) public;
function approve(address _to, uint256 _tokenId) public;
function takeOwnership(uint256 _tokenId) public;

1. 첫 번째 방법은 토큰의 소유자가 전송 상대의 address, 전송하고자 하는 _tokenId와 함께 transfer 함수를 호출하는 것이네.
2. 두 번째 방법은 토큰의 소유자가 먼저 위에서 본 정보들을 가지고 approve를 호출하는 것이네. 그리고서 컨트랙트에 누가 해당 토큰을 가질 수 있도록 허가를 받았는지 저장하지. 
   보통 mapping (uint256 => address)를 써서 말이지. 이후 누군가 takeOwnership을 호출하면, 해당 컨트랙트는 이 msg.sender가 소유자로부터 토큰을 받을 수 있게 허가를 받았는지 확인하네. 
   그리고 허가를 받았다면 해당 토큰을 그에게 전송하지.
자네가 눈치를 챘을지 모르겠지만, transfer와 takeOwnership 모두 동일한 전송 로직을 가지고 있네. 순서만 반대인 것이지(전자는 토큰을 보내는 사람이 함수를 호출하네; 후자는 토큰을 받는 사람이 호출하는 것이지).
그러니 이 로직만의 프라이빗 함수, _transfer를 만들어 추상화하는 것이 좋을 것이네. 두 함수에서 모두 쓸 수 있도록 말이야. 이렇게 하면 똑같은 코드를 두 번씩 쓰지 않아도 되지.

_직접 해보기
_transfer에 대한 로직을 정의해보도록 하지.

1. _transfer라는 이름으로 함수를 정의하게. address _from, address _to, 그리고 uint256 _tokenId 세 개의 인수를 받고, private 함수이어야 하네.
2. 소유자가 바뀌면 함께 바뀔 2개의 매핑을 쓸 것이네: ownerZombieCount(한 소유자가 얼마나 많은 좀비를 가지고 있는지 기록)와 zombieToOwner(어떤 좀비를 누가 가지고 있는지 기록)이네.
   이 함수에서 처음 해야 할 일은 바로 좀비를 받는 사람(address _to)의 ownerZombieCount를 증가시키는 것이네. 증가시킬 때 ++를 사용하도록 하게.
3. 다음으로, 좀비를 보내는 사람(address _from)의 ownerZombieCount를 감소시켜야 하네. 감소시킬 때 --를 쓰도록 하게.
4. 마지막으로, 이 _tokenId에 해당하는 zombieToOwner 매핑 값이 _to를 가리키도록 변경하게.
5. 아 이런, 내가 거짓말을 했군. 마지막이 아니었네. 하나 더 해야 할 것이 있네. ERC721 스펙에는 Transfer 이벤트가 포함되어 있네. 
   이 함수의 마지막 줄에서 적절한 정보와 함께 Transfer를 실행해야 하네 - erc721.sol을 보고 어떤 인수들이 필요한지 확인한 후 여기에 그걸 구현하게.

*/

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {
  function balanceOf(address _owner) public override view returns (uint256 _balance) {
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public override view returns (address _owner) {
    return zombieToOwner[_tokenId];
  }
  // 여기에 _transfer()를 정의하게.
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to]++;
    ownerZombieCount[_from]--;
    zombieToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public override {

  }

  function approve(address _to, uint256 _tokenId) public override {

  }

  function takeOwnership(uint256 _tokenId) public override {

  }

}

