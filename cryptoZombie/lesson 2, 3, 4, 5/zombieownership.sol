// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* 챕터 6: ERC721: 전송 (이어서)
훌륭하군! 어려운 부분을 잘 해내었네 - 이제 퍼블릭 transfer 함수를 구현하는 것은 쉬울 것이네. 우리의 _transfer 함수가 어려운 부분들은 대부분 처리하고 있으니 말이야.

_직접 해보기

1. 우리는 토큰/좀비의 소유자만 해당 토큰/좀비를 전송할 수 있도록 하고 싶네. 자네, 어떻게 그 소유자만 이 함수에 접근할 수 있도록 제한하는지 기억하고 있나?
   그래, 바로 그거지. 우리는 이미 이렇게 만들어주는 제어자를 가지고 있네. 그러니 이 함수에 onlyOwnerOf 제어자를 추가하게.
2. 이제 함수의 내용은 진짜로 딱 한 줄이면 되네... 그저 _transfer를 호출하기만 하면 되지. address _from 인수에 msg.sender를 전달하는 것을 잊지 말게.

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

  // 1. 여기에 제어자를 추가하게.
  function transfer(address _to, uint256 _tokenId) public override onlyOwnerOf(_tokenId){
    // 2. 여기서 함수를 정의하게.
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public override {

  }

  function takeOwnership(uint256 _tokenId) public override {

  }

}

