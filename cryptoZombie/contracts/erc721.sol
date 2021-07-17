// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
// 오류 발생 : 
// 1. Contract "ERC721" should be marked as abstract 
// 2. Functions in interfaces must be declared external.

// 1번 오류해결 : lesson 2 chapter 11 커밋 당시에도 같은 오류 발생했었음. contract를 interface로 바꿔서 해결.
// https://github.com/jhin93/Solidity/commit/da7407e7d2bc192f3ac6522345c9a6f6b1fe46f0

// 2번 오류해결 : public을 external로 바꿔서 해결.

interface ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _owner) external view returns (uint256 _balance);
  function ownerOf(uint256 _tokenId) external view returns (address _owner);
  function transfer(address _to, uint256 _tokenId) external;
  function approve(address _to, uint256 _tokenId) external;
  function takeOwnership(uint256 _tokenId) external;
}