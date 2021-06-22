// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombieattack.sol";
import "./erc721.sol";
import "./safemath.sol";

/* 챕터 13: 주석(Comment)
드디어 우리의 좀비 게임을 위한 솔리디티 코드를 완성했군!
다음 레슨들에서는, 이더리움에 코드를 배포하는 방법과 Web3.js로 통신하는 방법을 살펴볼 것이네.
하지만 자네가 레슨 5에서 할 것이 마지막으로 하나 남았네: 자네의 코드에 주석을 다는 것에 대해 얘기해보도록 하지.

_주석을 위한 문법
솔리디티에서 주석을 다는 것은 자바스크립트와 비슷하네. 자네는 크립토좀비 레슨에서 이미 한 줄 주석을 다는 예시들을 봐왔네:
// 이게 한 줄 주석이네. 자신 또는 다른 사람에 대한 메모와도 같은 것이지. 그저 자네가 주석을 달 부분에 //를 추가하기만 하면 되네. 언제든 쉽게 달 수 있는 것이지.
그런데 자네의 소리가 들리는군 - 가끔 한 줄은 충분하지 않을 수 있지. 자네는 작가로구만! 여기 여러 줄 주석을 쓰는 방법이 있네: (이미 이 설명을 감싸고 있음)

특히, 자네 컨트랙트의 모든 함수에서 예상되는 행동값을 자네의 코드에 주석으로 설명하는 것이 좋네. 
그렇게 하면 다른 개발자들(또는 6개월 동안 프로젝트를 멈춘 후 자네 자신!)이 코드 자체를 다 읽어보지 않고 훑어보더라도 큰 맥락에서 그 코드를 이해할 수 있을 것이네.
 
솔리디티 커뮤니티에서 표준으로 쓰이는 형식은 natspec이라 불리네. 아래와 같이 생겼지:
```
/// @title 기본적인 산수를 위한 컨트랙트
/// @author H4XF13LD MORRIS ?????
/// @notice 지금은 곱하기 함수만 추가한다.
contract Math {
  /// @notice 2개의 숫자를 곱한다.
  /// @param x 첫 번쨰 uint.
  /// @param y 두 번째 uint.
  /// @return z (x * y) 곱의 값
  /// @dev 이 함수는 현재 오버플로우를 확인하지 않는다.
  function multiply(uint x, uint y) returns (uint z) {
    // 이것은 일반적인 주석으로, natspec에 포함되지 않는다.
    z = x * y;
  }
}
```
@title과 @author는 따로 설명이 필요 없을 것 같군.
@notice는 사용자에게 컨트랙트/함수가 무엇을 하는지 설명하네. @dev는 개발자에게 추가적인 상세 정보를 설명하기 위해 사용하지.
@param과 @return은 함수에서 어떤 매개 변수와 반환값을 가지는지 설명하네.
자네가 모든 함수에 대해 꼭 이 모든 태그들을 항상 써야만 하는 것은 아니라는 점을 명심하게 - 모든 태그는 필수가 아니네. 하지만 적어도, 각각의 함수가 어떤 것을 하는지 설명하도록 @dev는 남기도록 하게.

_직접 해보기
아직 깨닫지 못했을 수 있지만, 크립토좀비의 정답 확인 시스템은 자네의 답을 확인할 때 주석을 무시하네. 
그러니 이 챕터에서 자네의 natspec 코드를 우리가 실제로 확인할 수는 없네 ;) 하지만, 이제 자네는 솔리디티 전문가네 - 자네가 이것을 이해했을 것이라고 생각하지!
어쨌든 한번 해보도록 하지. ZombieOwnership에 natspec 태그를 추가해보도록 하게:

1. @title - 예를 들어, 좀비 소유권 전송을 관리하는 컨트랙트라고 쓰게.
2. @author - 자네의 이름!
3. @dev - 예를 들어, OpenZeppelin의 ERC721 표준 초안 구현을 따른다고 하게.
 */


/// TODO: natspec에 맞도록 이 부분을 바꾸게.
///@title 좀비 소유권 전송을 관리하는 컨트랙트.
///@author jhin.
///@dev OpenZeppelin의 ERC721 표준 초안 구현을 따른다.

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

