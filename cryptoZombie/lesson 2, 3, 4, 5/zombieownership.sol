// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* ERC721: Approve
이제 approve를 구현하도록 하지.
approve / takeOwnership을 사용하는 전송은 2단계로 나뉜다는 것을 기억하게:
1. 소유자인 자네가 새로운 소유자의 address와 그에게 보내고 싶은 _tokenId를 사용하여 approve를 호출하네.
2. 새로운 소유자가 _tokenId를 사용하여 takeOwnership 함수를 호출하면, 컨트랙트는 그가 승인된 자인지 확인하고 그에게 토큰을 전송하네.
이처럼 2번의 함수 호출이 발생하기 때문에, 우리는 함수 호출 사이에 누가 무엇에 대해 승인이 되었는지 저장할 데이터 구조가 필요할 것이네.

_직접 해보기

1. 먼저, zombieApprovals 매핑을 정의해보도록 하지. 이것은 uint를 address로 연결하여야 하네.
   이런 방식으로, 누군가 _tokenId로 takeOwnership을 호출하면, 이 매핑을 써서 누가 그 토큰을 가지도록 승인받았는지 확인할 수 있네.
2. approve 함수에서, 우리는 오직 그 토큰의 소유자만 다른 사람에게 토큰을 줄 수 있는 승인을 할 수 있도록 하고 싶네. 그러니 approve에 onlyOwnerOf 제어자를 추가해야 할 것이네.
3. 함수의 내용에서는 zombieApprovals의 _tokenId 요소를 _to 주소와 같도록 만들게.
4. 마지막으로, ERC721 스펙에 Approval 이벤트가 있네. 그러니 우리는 이 함수의 마지막에서 이 이벤트를 호출해야 하네. erc721.sol에서 인수를 확인하고, msg.sender를 _owner에 쓰도록 하게.
*/

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

  // 1. 여기에 mapping을 정의하게.
  mapping (uint => address) zombieApprovals;

  function balanceOf(address _owner) public override view returns (uint256 _balance) {
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public override view returns (address _owner) {
    return zombieToOwner[_tokenId];
  }
  
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to]++;
    ownerZombieCount[_from]--;
    zombieToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public override onlyOwnerOf(_tokenId){
    _transfer(msg.sender, _to, _tokenId);
  }

  // 2. 여기에 함수 제어자를 추가하게.
  function approve(address _to, uint256 _tokenId) public override onlyOwnerOf(_tokenId){
    // 3. 여기서 함수를 정의하게.
    zombieApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public override {

  }

}

