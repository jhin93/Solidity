// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* é�� 2: ERC721 ǥ��, ���� ���
ERC721 ǥ���� �ѹ� ���� ���캸���� ����: 
(ERC-721�� �̴����� ���ü�ο��� ��ü �� �� ���ų� ������ ��ū�� �ۼ��ϴ� ����� �����ϴ� ���� ���� ǥ���̴�. http://wiki.hash.kr/index.php/ERC-721#.ED.81.AC.EB.A6.BD.ED.86.A0.EB.8F.84.EC.A0.80)

contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _owner) public view returns (uint256 _balance);
  function ownerOf(uint256 _tokenId) public view returns (address _owner);
  function transfer(address _to, uint256 _tokenId) public;
  function approve(address _to, uint256 _tokenId) public;
  function takeOwnership(uint256 _tokenId) public;
}

�̰� �ٷ� �츮�� �����ؾ� �� �޼ҵ���� ����̳�. ������ ���� é�͵鿡�� �������� ����� ���� �͵�����.
�ʹ� ���� ������, �������� ����! ���� ���⿡ ������ ���̾�.

|����: ERC721 ǥ���� ���� �ʾ��� �����̰�, ���� �������� ä�õ� ���� ������ ����. 
|�� Ʃ�丮�󿡼� �츮�� OpenZeppelin ���̺귯������ ���̴� ���� ������ ����� ��������, ���� ������ ������ ������ �ٲ� ���ɼ��� �ֳ�. 
|�׷��� �ϳ��� ���� ������ ���� �����θ� �����ϰ�, ERC721 ��ū�� ���� ǥ������ ���������� ����. 

���� ERC 721 ǥ�� : https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md

_��ū ��Ʈ��Ʈ ����
��ū ��Ʈ��Ʈ�� ������ ��, ó�� �ؾ� �� ���� �ٷ� �������̽��� �ָ���Ƽ ���Ϸ� ���� �����Ͽ� �����ϰ� import "./erc721.sol";�� �Ἥ ����Ʈ�� �ϴ� ���̳�. 
�׸��� �ش� ��Ʈ��Ʈ�� ����ϴ� �츮�� ��Ʈ��Ʈ�� �����, ������ �Լ��� �������̵��Ͽ� �����Ͽ��� ����.
�׷��� ���⼭ ��� - ZombieOwnership�� �̹� ZombieAttack�� ����ϰ� �ֳ� - �׷��ٸ� ��� ERC721�� ����ϰ� �� �� ������?
�� ���Ե� �ָ���Ƽ������, �ڳ��� ��Ʈ��Ʈ�� ������ ���� �ټ��� ��Ʈ��Ʈ�� ����� �� �ֳ�:

contract SatoshiNakamoto is NickSzabo, HalFinney {
  // �� �̷�, �� ������ ����� ��������!
}

�ڳ׵� �� �� �ֵ���, ���� ����� �� ���� ����ϰ��� �ϴ� �ټ��� ��Ʈ��Ʈ�� ��ǥ(,)�� �����ϸ� �ǳ�. ���� ��쿡, ��Ʈ��Ʈ�� NickSzabo�� HalFinney�� ����ϰ� ����. �� �� ���� �غ����� ����.

_���� �غ���
�ڳ׸� ���� erc721.sol ������ �������̽��� �Բ� ����� ���ҳ�.
1. erc721.sol ������ zombieownership.sol ���Ͽ��� ����Ʈ�ϰ�.
2. ZombieOwnership�� ZombieAttack�� ERC721�� ����Ѵٰ� �����ϰ�.
*/

import "./zombieattack.sol";
// ���⼭ import �ϰ�.
import "./erc721.sol";

// ���⼭ ERC721 ����� �����ϰ�.
contract ZombieOwnership is ZombieAttack, ERC721 {

}

