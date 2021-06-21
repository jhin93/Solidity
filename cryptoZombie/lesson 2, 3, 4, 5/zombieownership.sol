// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* é�� 6: ERC721: ���� (�̾)
�Ǹ��ϱ�! ����� �κ��� �� �س����� - ���� �ۺ� transfer �Լ��� �����ϴ� ���� ���� ���̳�. �츮�� _transfer �Լ��� ����� �κе��� ��κ� ó���ϰ� ������ ���̾�.

_���� �غ���

1. �츮�� ��ū/������ �����ڸ� �ش� ��ū/���� ������ �� �ֵ��� �ϰ� �ͳ�. �ڳ�, ��� �� �����ڸ� �� �Լ��� ������ �� �ֵ��� �����ϴ��� ����ϰ� �ֳ�?
   �׷�, �ٷ� �װ���. �츮�� �̹� �̷��� ������ִ� �����ڸ� ������ �ֳ�. �׷��� �� �Լ��� onlyOwnerOf �����ڸ� �߰��ϰ�.
2. ���� �Լ��� ������ ��¥�� �� �� ���̸� �ǳ�... ���� _transfer�� ȣ���ϱ⸸ �ϸ� ����. address _from �μ��� msg.sender�� �����ϴ� ���� ���� ����.

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
  // ���⿡ _transfer()�� �����ϰ�.
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to]++;
    ownerZombieCount[_from]--;
    zombieToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  // 1. ���⿡ �����ڸ� �߰��ϰ�.
  function transfer(address _to, uint256 _tokenId) public override onlyOwnerOf(_tokenId){
    // 2. ���⼭ �Լ��� �����ϰ�.
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public override {

  }

  function takeOwnership(uint256 _tokenId) public override {

  }

}

