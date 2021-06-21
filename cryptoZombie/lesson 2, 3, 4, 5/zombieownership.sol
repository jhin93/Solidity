// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* 챕터 8: ERC721: takeOwnership
좋아, 이제 마지막 함수와 함께 우리의 ERC721 구현을 끝내보세!(걱정하지 말게, 이것 다음에도 레슨 5에서 다뤄야 할 것들이 더 남아 있네 ?)
마지막 함수인 takeOwnership에서는 msg.sender가 이 토큰/좀비를 가질 수 있도록 승인되었는지 확인하고, 승인이 되었다면 _transfer를 호출해야 하네.

_직접 해보기

1. 먼저, require 문장을 써서 zombieApprovals의 _tokenId 요소가 msg.sender와 같은지 확인해야 하네.
   이런 방식으로 만약 msg.sender가 이 토큰을 받도록 승인되지 않았다면, 에러를 만들어낼 것이네.
2. _transfer를 호출하기 위해, 우리는 그 토큰을 소유한 사람의 주소를 알 필요가 있네(함수에서 _from을 인수로 요구하기 떄문이지). 다행히 우리의 ownerOf 함수를 써서 이를 찾아낼 수 있네.
   그러니 address 변수를 owner라는 이름으로 선언하고, 여기에 ownerOf(_tokenId)를 대입하게.
3. 마지막으로, _transfer를 필요한 모든 정보와 함께 호출하게(여기서는 msg.sender를 _to에 사용하면 되네. 이 함수를 호출하는 사람이 토큰을 받을 사람이기 떄문이지).
| 참고: 2번째와 3번째 단계를 한 줄의 코드로 만들 수 있지만, 나누는 것이 조금 더 읽기 좋게 만드네. 개인적인 선호인 것이지.
*/

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

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

  function approve(address _to, uint256 _tokenId) public override onlyOwnerOf(_tokenId){
    zombieApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public override{
    // 여기서 시작하게.
    require(zombieApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }

}

