// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* ERC721: Approve
���� approve�� �����ϵ��� ����.
approve / takeOwnership�� ����ϴ� ������ 2�ܰ�� �����ٴ� ���� ����ϰ�:
1. �������� �ڳװ� ���ο� �������� address�� �׿��� ������ ���� _tokenId�� ����Ͽ� approve�� ȣ���ϳ�.
2. ���ο� �����ڰ� _tokenId�� ����Ͽ� takeOwnership �Լ��� ȣ���ϸ�, ��Ʈ��Ʈ�� �װ� ���ε� ������ Ȯ���ϰ� �׿��� ��ū�� �����ϳ�.
��ó�� 2���� �Լ� ȣ���� �߻��ϱ� ������, �츮�� �Լ� ȣ�� ���̿� ���� ������ ���� ������ �Ǿ����� ������ ������ ������ �ʿ��� ���̳�.

_���� �غ���

1. ����, zombieApprovals ������ �����غ����� ����. �̰��� uint�� address�� �����Ͽ��� �ϳ�.
   �̷� �������, ������ _tokenId�� takeOwnership�� ȣ���ϸ�, �� ������ �Ἥ ���� �� ��ū�� �������� ���ι޾Ҵ��� Ȯ���� �� �ֳ�.
2. approve �Լ�����, �츮�� ���� �� ��ū�� �����ڸ� �ٸ� ������� ��ū�� �� �� �ִ� ������ �� �� �ֵ��� �ϰ� �ͳ�. �׷��� approve�� onlyOwnerOf �����ڸ� �߰��ؾ� �� ���̳�.
3. �Լ��� ���뿡���� zombieApprovals�� _tokenId ��Ҹ� _to �ּҿ� ������ �����.
4. ����������, ERC721 ���忡 Approval �̺�Ʈ�� �ֳ�. �׷��� �츮�� �� �Լ��� ���������� �� �̺�Ʈ�� ȣ���ؾ� �ϳ�. erc721.sol���� �μ��� Ȯ���ϰ�, msg.sender�� _owner�� ������ �ϰ�.
*/

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

  // 1. ���⿡ mapping�� �����ϰ�.
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

  // 2. ���⿡ �Լ� �����ڸ� �߰��ϰ�.
  function approve(address _to, uint256 _tokenId) public override onlyOwnerOf(_tokenId){
    // 3. ���⼭ �Լ��� �����ϰ�.
    zombieApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public override {

  }

}

