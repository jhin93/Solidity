// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* é�� 8: ERC721: takeOwnership
����, ���� ������ �Լ��� �Բ� �츮�� ERC721 ������ ��������!(�������� ����, �̰� �������� ���� 5���� �ٷ�� �� �͵��� �� ���� �ֳ� ?)
������ �Լ��� takeOwnership������ msg.sender�� �� ��ū/���� ���� �� �ֵ��� ���εǾ����� Ȯ���ϰ�, ������ �Ǿ��ٸ� _transfer�� ȣ���ؾ� �ϳ�.

_���� �غ���

1. ����, require ������ �Ἥ zombieApprovals�� _tokenId ��Ұ� msg.sender�� ������ Ȯ���ؾ� �ϳ�.
   �̷� ������� ���� msg.sender�� �� ��ū�� �޵��� ���ε��� �ʾҴٸ�, ������ ���� ���̳�.
2. _transfer�� ȣ���ϱ� ����, �츮�� �� ��ū�� ������ ����� �ּҸ� �� �ʿ䰡 �ֳ�(�Լ����� _from�� �μ��� �䱸�ϱ� ��������). ������ �츮�� ownerOf �Լ��� �Ἥ �̸� ã�Ƴ� �� �ֳ�.
   �׷��� address ������ owner��� �̸����� �����ϰ�, ���⿡ ownerOf(_tokenId)�� �����ϰ�.
3. ����������, _transfer�� �ʿ��� ��� ������ �Բ� ȣ���ϰ�(���⼭�� msg.sender�� _to�� ����ϸ� �ǳ�. �� �Լ��� ȣ���ϴ� ����� ��ū�� ���� ����̱� ��������).
| ����: 2��°�� 3��° �ܰ踦 �� ���� �ڵ�� ���� �� ������, ������ ���� ���� �� �б� ���� �����. �������� ��ȣ�� ������.
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
    // ���⼭ �����ϰ�.
    require(zombieApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }

}

