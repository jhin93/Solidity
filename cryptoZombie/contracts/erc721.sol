// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
// ���� �߻� : 
// 1. Contract "ERC721" should be marked as abstract 
// 2. Functions in interfaces must be declared external.

// 1�� �����ذ� : lesson 2 chapter 11 Ŀ�� ��ÿ��� ���� ���� �߻��߾���. contract�� interface�� �ٲ㼭 �ذ�.
// https://github.com/jhin93/Solidity/commit/da7407e7d2bc192f3ac6522345c9a6f6b1fe46f0

// 2�� �����ذ� : public�� external�� �ٲ㼭 �ذ�.

interface ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _owner) external view returns (uint256 _balance);
  function ownerOf(uint256 _tokenId) external view returns (address _owner);
  function transfer(address _to, uint256 _tokenId) external;
  function approve(address _to, uint256 _tokenId) external;
  function takeOwnership(uint256 _tokenId) external;
}