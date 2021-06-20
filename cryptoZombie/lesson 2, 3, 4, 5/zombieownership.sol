// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {
  function balanceOf(address _owner) public view returns (uint256 _balance) {
    // 1. 여기서 `_owner`가 가진 좀비의 수를 반환하게.
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    // 2. 여기서 `_tokenId`의 소유자를 반환하게.
    return zombieToOwner[_tokenId];
  }

  function transfer(address _to, uint256 _tokenId) public {

  }

  function approve(address _to, uint256 _tokenId) public {

  }

  function takeOwnership(uint256 _tokenId) public {

  }

}

