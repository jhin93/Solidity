// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombieattack.sol";
import "./erc721.sol";

/* é�� 10: SafeMath ��Ʈ 2
SafeMath ������ �ڵ带 �ѹ� ���캸���� ����: 
(safemath.sol���� Ȯ��)
���� �츮�� library Ű���带 �� ���̳� - ���̺귯���� contract�� ��������� ���� �ٸ� ���� ����. 
���̺귯���� �츮�� using Ű���带 ����� �� �ְ� ���ֳ�. �̸� ���� ���̺귯���� �޼ҵ���� �ٸ� ������ Ÿ�Կ� ������ �� ����.
```
using SafeMath for uint;
// �츮�� ���� �� �޼ҵ���� �ƹ� uint������ �� �� �ֳ�.
uint test = 2;
test = test.mul(3); // test�� ���� 6�� �ǳ�
test = test.add(5); // test�� ���� 11�� �ǳ�
```
mul�� add �Լ��� ���� 2���� �μ��� �ʿ�� �Ѵٴ� �Ϳ� �ָ��ϰ�. 
������ �츮�� using SafeMath for uint�� ������ ��, �츮�� �Լ��� �����ϴ� uint(test)�� ù ��° �μ��� �ڵ����� ���޵ǳ�.

SafeMath�� � ���� �ϴ��� ���� ���� add �Լ��� ������ �ѹ� ���캸���� ����:
```
function add(uint256 a, uint256 b) internal pure returns (uint256) {
  uint256 c = a + b;
  assert(c >= a);
  return c;
}
```
�⺻������ add�� ���� 2���� uint�� +ó�� ���ϳ�. ������ �� �ȿ� assert ������ �Ἥ �� ���� a���� ũ���� ��������. �̰��� �����÷ο츦 �����ֳ�.
assert�� ������ �������� ������ ������ �߻���Ų�ٴ� ������ require�� �������. 
assert�� require�� ��������, require�� �Լ� ������ �����ϸ� ���� ������ ����ڿ��� �ǵ��� ������, assert�� �׷��� �ʴٴ� ���̳�. 
�� ��κ� �ڳ״� �ڳ��� �ڵ忡 require�� ���� ���� ���̳�; assert�� �Ϲ������� �ڵ尡 �ɰ��ϰ� �߸� ����� �� ����ϳ�(uint �����÷ο�ó�� ���̾�).

������ ����, SafeMath�� add, sub, mul, �׸��� div�� 4���� �⺻ ���� ������ �ϴ� �Լ�������, �����÷ο쳪 ����÷ο찡 �߻��ϸ� ������ �߻���Ű�� ���̳�.

_�츮�� �ڵ忡 SafeMath ����ϱ�
�����÷ο쳪 ����÷ο츦 ���� ����, �츮�� �ڵ忡�� +, -, * �Ǵ� /�� ���� ���� ã�� add, sub, mul, div�� ��ü�� ���̳�.
���� ���, �Ʒ�ó�� �ϴ� ���:
myUint++;
�̷��� �� ���̳�:
myUint = myUint.add(1);

_���� �غ���.
�츮�� ZombieOwnership���� ���� ������ ����� ���� 2���� �ֳ�. �̵��� SafeMath �޼ҵ��� �ٲ㺸���� ����.
    1. ++�� SafeMath �޼ҵ�� ��ü�ϰ�.
    2. --�� SafeMath �޼ҵ�� ��ü�ϰ�.
*/

contract ZombieOwnership is ZombieAttack, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) zombieApprovals;

  function balanceOf(address _owner) public override view returns (uint256 _balance) {
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public override view returns (address _owner) {
    return zombieToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    // 1. SafeMath�� `add`�� ��ü�ϰ�.
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
    // 2. SafeMath�� `sub`�� ��ü�ϰ�.
    ownerZombieCount[_from] = ownerZombieCount[_from].sub(1);
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
    require(zombieApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }

}

