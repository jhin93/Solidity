// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "./zombieattack.sol";
import "./erc721.sol";

/* 챕터 10: SafeMath 파트 2
SafeMath 내부의 코드를 한번 살펴보도록 하지: 
(safemath.sol에서 확인)
먼저 우리는 library 키워드를 볼 것이네 - 라이브러리는 contract와 비슷하지만 조금 다른 점이 있지. 
라이브러리는 우리가 using 키워드를 사용할 수 있게 해주네. 이를 통해 라이브러리의 메소드들을 다른 데이터 타입에 적용할 수 있지.
```
using SafeMath for uint;
// 우리는 이제 이 메소드들을 아무 uint에서나 쓸 수 있네.
uint test = 2;
test = test.mul(3); // test는 이제 6이 되네
test = test.add(5); // test는 이제 11이 되네
```
mul과 add 함수는 각각 2개의 인수를 필요로 한다는 것에 주목하게. 
하지만 우리가 using SafeMath for uint를 선언할 때, 우리가 함수를 적용하는 uint(test)는 첫 번째 인수로 자동으로 전달되네.

SafeMath가 어떤 것을 하는지 보기 위해 add 함수의 내용을 한번 살펴보도록 하지:
```
function add(uint256 a, uint256 b) internal pure returns (uint256) {
  uint256 c = a + b;
  assert(c >= a);
  return c;
}
```
기본적으로 add는 그저 2개의 uint를 +처럼 더하네. 하지만 그 안에 assert 구문을 써서 그 합이 a보다 크도록 보장하지. 이것이 오버플로우를 막아주네.
assert는 조건을 만족하지 않으면 에러를 발생시킨다는 점에서 require와 비슷하지. 
assert와 require의 차이점은, require는 함수 실행이 실패하면 남은 가스를 사용자에게 되돌려 주지만, assert는 그렇지 않다는 것이네. 
즉 대부분 자네는 자네의 코드에 require를 쓰고 싶을 것이네; assert는 일반적으로 코드가 심각하게 잘못 실행될 때 사용하네(uint 오버플로우처럼 말이야).

간단히 말해, SafeMath의 add, sub, mul, 그리고 div는 4개의 기본 수학 연산을 하는 함수이지만, 오버플로우나 언더플로우가 발생하면 에러를 발생시키는 것이네.

_우리의 코드에 SafeMath 사용하기
오버플로우나 언더플로우를 막기 위해, 우리의 코드에서 +, -, * 또는 /을 쓰는 곳을 찾아 add, sub, mul, div로 교체할 것이네.
예를 들어, 아래처럼 하는 대신:
myUint++;
이렇게 할 것이네:
myUint = myUint.add(1);

_직접 해보기.
우리는 ZombieOwnership에서 수학 연산을 사용한 곳이 2군데 있네. 이들을 SafeMath 메소드들로 바꿔보도록 하지.
    1. ++를 SafeMath 메소드로 교체하게.
    2. --를 SafeMath 메소드로 교체하게.
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
    // 1. SafeMath의 `add`로 교체하게.
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
    // 2. SafeMath의 `sub`로 교체하게.
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

