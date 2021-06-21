// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* é�� 5: ERC721: ���� ����
����, �浹�� �ذ��߱�! ���� �츮�� ERC721���� �� ����� �ٸ� ������� �������� �ѱ�� ���� ������ ���� ���̳�.
ERC721 ���忡���� ��ū�� ������ �� 2���� �ٸ� ����� ������ ����ϰ�:

function transfer(address _to, uint256 _tokenId) public;
function approve(address _to, uint256 _tokenId) public;
function takeOwnership(uint256 _tokenId) public;

1. ù ��° ����� ��ū�� �����ڰ� ���� ����� address, �����ϰ��� �ϴ� _tokenId�� �Բ� transfer �Լ��� ȣ���ϴ� ���̳�.
2. �� ��° ����� ��ū�� �����ڰ� ���� ������ �� �������� ������ approve�� ȣ���ϴ� ���̳�. �׸��� ��Ʈ��Ʈ�� ���� �ش� ��ū�� ���� �� �ֵ��� �㰡�� �޾Ҵ��� ��������. 
   ���� mapping (uint256 => address)�� �Ἥ ������. ���� ������ takeOwnership�� ȣ���ϸ�, �ش� ��Ʈ��Ʈ�� �� msg.sender�� �����ڷκ��� ��ū�� ���� �� �ְ� �㰡�� �޾Ҵ��� Ȯ���ϳ�. 
   �׸��� �㰡�� �޾Ҵٸ� �ش� ��ū�� �׿��� ��������.
�ڳװ� ��ġ�� ë���� �𸣰�����, transfer�� takeOwnership ��� ������ ���� ������ ������ �ֳ�. ������ �ݴ��� ������(���ڴ� ��ū�� ������ ����� �Լ��� ȣ���ϳ�; ���ڴ� ��ū�� �޴� ����� ȣ���ϴ� ������).
�׷��� �� �������� �����̺� �Լ�, _transfer�� ����� �߻�ȭ�ϴ� ���� ���� ���̳�. �� �Լ����� ��� �� �� �ֵ��� ���̾�. �̷��� �ϸ� �Ȱ��� �ڵ带 �� ���� ���� �ʾƵ� ����.

_���� �غ���
_transfer�� ���� ������ �����غ����� ����.

1. _transfer��� �̸����� �Լ��� �����ϰ�. address _from, address _to, �׸��� uint256 _tokenId �� ���� �μ��� �ް�, private �Լ��̾�� �ϳ�.
2. �����ڰ� �ٲ�� �Բ� �ٲ� 2���� ������ �� ���̳�: ownerZombieCount(�� �����ڰ� �󸶳� ���� ���� ������ �ִ��� ���)�� zombieToOwner(� ���� ���� ������ �ִ��� ���)�̳�.
   �� �Լ����� ó�� �ؾ� �� ���� �ٷ� ���� �޴� ���(address _to)�� ownerZombieCount�� ������Ű�� ���̳�. ������ų �� ++�� ����ϵ��� �ϰ�.
3. ��������, ���� ������ ���(address _from)�� ownerZombieCount�� ���ҽ��Ѿ� �ϳ�. ���ҽ�ų �� --�� ������ �ϰ�.
4. ����������, �� _tokenId�� �ش��ϴ� zombieToOwner ���� ���� _to�� ����Ű���� �����ϰ�.
5. �� �̷�, ���� �������� �߱�. �������� �ƴϾ���. �ϳ� �� �ؾ� �� ���� �ֳ�. ERC721 ���忡�� Transfer �̺�Ʈ�� ���ԵǾ� �ֳ�. 
   �� �Լ��� ������ �ٿ��� ������ ������ �Բ� Transfer�� �����ؾ� �ϳ� - erc721.sol�� ���� � �μ����� �ʿ����� Ȯ���� �� ���⿡ �װ� �����ϰ�.

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

  function transfer(address _to, uint256 _tokenId) public override {

  }

  function approve(address _to, uint256 _tokenId) public override {

  }

  function takeOwnership(uint256 _tokenId) public override {

  }

}

