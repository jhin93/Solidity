// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "./ownable.sol";
import "./safemath.sol";

// 함수 제어자 종류.
// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 사용자 정의 제어자 : 'modifier' - lesson3 챕터 3 참고.
// payable 제어자 : 이더를 받을 수 있는 특별한 함수 유형.

/* 챕터 11: SafeMath 파트 3
훌륭하군, 이제 우리의 ERC721 구현은 오버플로우 & 언더플로우에서 안전하네! 
이전 레슨에서 우리가 작성한 코드로 돌아가 보면, 우리 코드에 오버플로우나 언더플로우가 발생할 수 있는 지점이 몇 개 더 있네.
예를 들어, ZombieAttack에서:
```
myZombie.winCount++;
myZombie.level++;
enemyZombie.lossCount++;
```
여기서도 안전을 위해 오버플로우를 막아야 할 것이네(일반적으로 기본 수학 연산보다 SafeMath를 쓰는 것이 좋네. 
향후의 솔리디티 버전에서는 이게 기본으로 포함될 수도 있겠지만, 지금은 우리 코드에 추가적인 보안 조치를 해야 하네).

하지만 여기에 작은 문제가 있네 - winCount와 lossCount는 uint16이고, level은 uint32인 것이지.
즉 우리가 이런 인수들을 써서 SafeMath의 add 메소드를 사용하면, 이 타입들을 uint256으로 바꿀 것이기 때문에 실제로 오버플로우를 막아주지 못하네.
```
function add(uint256 a, uint256 b) internal pure returns (uint256) {
  uint256 c = a + b;
  assert(c >= a);
  return c;
}
// 만약 `uint8`에 `.add`를 호출한다면, 타입이 `uint256`로 변환되네.
// 그러니 2^8에서 오버플로우가 발생하지 않을 것이네. 256은 `uint256`에서 유효한 숫자이기 때문이지.
```
의문점 : uint8(2^8)이 uint256에서 유효하다면, uint16, uint32도 마찬가지여야 하는 것 아닌가? uint8만 특별히 가능한건가?
이는 즉 uint16과 uint32에서 오버플로우/언더플로우를 막기 위해 2개의 라이브러리를 더 만들어야 한다는 것을 의미하네. 우리는 이들을 SafeMath16과 SafeMath32라고 부를 것이네.

코드는 모든 uint256들이 uint32 또는 uint16으로 바뀐다는 것 말고는 SafeMath와 정확히 같을 것이네.
내가 자네를 위해 먼저 그 코드를 구현해 놓았네 - safemath.sol로 가서 구현한 코드를 확인해보게.
이제 우리는 ZombieFactory에 이를 사용하여 구현해야 할 것이네.
 */

contract ZombieFactory is Ownable{

    using SafeMath for uint256;
    // 1. using SafeMath32 for uint32를 선언하게.
    using SafeMath32 for uint32;
    // 2. using SafeMath16 for uint16를 선언하게.
    using SafeMath16 for uint16;

    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        // 참고: 우리는 Year 2038 문제를 막지 않기로 하겠네... 그러니 readyTime에서 오버플로우를 걱정할 필요는 없네.
        // 우리 앱은 2038년에는 좀 꼬이겠지 ;)
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0));
        uint id = zombies.length - 1;
        zombieToOwner[id] = msg.sender;
        // 3. 여기에 SafeMath의 `add`를 사용하게:
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
