// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
// 오류 발생 : Contract "ERC721" should be marked as abstract. 
// 오류해결에 참고 : https://ethereum.stackexchange.com/questions/83267/contract-should-be-marked-as-abstract/83270

contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _owner) public view returns (uint256 _balance);
  function ownerOf(uint256 _tokenId) public view returns (address _owner);
  function transfer(address _to, uint256 _tokenId) public;
  function approve(address _to, uint256 _tokenId) public;
  function takeOwnership(uint256 _tokenId) public;
}