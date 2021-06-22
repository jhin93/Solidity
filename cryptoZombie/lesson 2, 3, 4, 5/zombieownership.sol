// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombieattack.sol";
import "./erc721.sol";
import "./safemath.sol";

/* é�� 13: �ּ�(Comment)
���� �츮�� ���� ������ ���� �ָ���Ƽ �ڵ带 �ϼ��߱�!
���� �����鿡����, �̴����� �ڵ带 �����ϴ� ����� Web3.js�� ����ϴ� ����� ���캼 ���̳�.
������ �ڳװ� ���� 5���� �� ���� ���������� �ϳ� ���ҳ�: �ڳ��� �ڵ忡 �ּ��� �ٴ� �Ϳ� ���� ����غ����� ����.

_�ּ��� ���� ����
�ָ���Ƽ���� �ּ��� �ٴ� ���� �ڹٽ�ũ��Ʈ�� ����ϳ�. �ڳ״� ũ�������� �������� �̹� �� �� �ּ��� �ٴ� ���õ��� ���Գ�:
// �̰� �� �� �ּ��̳�. �ڽ� �Ǵ� �ٸ� ����� ���� �޸�͵� ���� ������. ���� �ڳװ� �ּ��� �� �κп� //�� �߰��ϱ⸸ �ϸ� �ǳ�. ������ ���� �� �� �ִ� ������.
�׷��� �ڳ��� �Ҹ��� �鸮�±� - ���� �� ���� ������� ���� �� ����. �ڳ״� �۰��α���! ���� ���� �� �ּ��� ���� ����� �ֳ�: (�̹� �� ������ ���ΰ� ����)

Ư��, �ڳ� ��Ʈ��Ʈ�� ��� �Լ����� ����Ǵ� �ൿ���� �ڳ��� �ڵ忡 �ּ����� �����ϴ� ���� ����. 
�׷��� �ϸ� �ٸ� �����ڵ�(�Ǵ� 6���� ���� ������Ʈ�� ���� �� �ڳ� �ڽ�!)�� �ڵ� ��ü�� �� �о�� �ʰ� �Ⱦ���� ū �ƶ����� �� �ڵ带 ������ �� ���� ���̳�.
 
�ָ���Ƽ Ŀ�´�Ƽ���� ǥ������ ���̴� ������ natspec�̶� �Ҹ���. �Ʒ��� ���� ������:
```
/// @title �⺻���� ����� ���� ��Ʈ��Ʈ
/// @author H4XF13LD MORRIS ?????
/// @notice ������ ���ϱ� �Լ��� �߰��Ѵ�.
contract Math {
  /// @notice 2���� ���ڸ� ���Ѵ�.
  /// @param x ù ���� uint.
  /// @param y �� ��° uint.
  /// @return z (x * y) ���� ��
  /// @dev �� �Լ��� ���� �����÷ο츦 Ȯ������ �ʴ´�.
  function multiply(uint x, uint y) returns (uint z) {
    // �̰��� �Ϲ����� �ּ�����, natspec�� ���Ե��� �ʴ´�.
    z = x * y;
  }
}
```
@title�� @author�� ���� ������ �ʿ� ���� �� ����.
@notice�� ����ڿ��� ��Ʈ��Ʈ/�Լ��� ������ �ϴ��� �����ϳ�. @dev�� �����ڿ��� �߰����� �� ������ �����ϱ� ���� �������.
@param�� @return�� �Լ����� � �Ű� ������ ��ȯ���� �������� �����ϳ�.
�ڳװ� ��� �Լ��� ���� �� �� ��� �±׵��� �׻� ��߸� �ϴ� ���� �ƴ϶�� ���� ����ϰ� - ��� �±״� �ʼ��� �ƴϳ�. ������ ���, ������ �Լ��� � ���� �ϴ��� �����ϵ��� @dev�� ���⵵�� �ϰ�.

_���� �غ���
���� ������ ������ �� ������, ũ���������� ���� Ȯ�� �ý����� �ڳ��� ���� Ȯ���� �� �ּ��� �����ϳ�. 
�׷��� �� é�Ϳ��� �ڳ��� natspec �ڵ带 �츮�� ������ Ȯ���� ���� ���� ;) ������, ���� �ڳ״� �ָ���Ƽ �������� - �ڳװ� �̰��� �������� ���̶�� ��������!
��·�� �ѹ� �غ����� ����. ZombieOwnership�� natspec �±׸� �߰��غ����� �ϰ�:

1. @title - ���� ���, ���� ������ ������ �����ϴ� ��Ʈ��Ʈ��� ����.
2. @author - �ڳ��� �̸�!
3. @dev - ���� ���, OpenZeppelin�� ERC721 ǥ�� �ʾ� ������ �����ٰ� �ϰ�.
 */


/// TODO: natspec�� �µ��� �� �κ��� �ٲٰ�.
///@title ���� ������ ������ �����ϴ� ��Ʈ��Ʈ.
///@author jhin.
///@dev OpenZeppelin�� ERC721 ǥ�� �ʾ� ������ ������.

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
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
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

