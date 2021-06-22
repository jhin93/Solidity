// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "./ownable.sol";
// 1. 여기서 import 하게.
import "./safemath.sol";

// 함수 제어자 종류.
// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 사용자 정의 제어자 : 'modifier' - lesson3 챕터 3 참고.
// payable 제어자 : 이더를 받을 수 있는 특별한 함수 유형.

/* 챕터 9: 오버플로우 막기.
축하하네, ERC721 구현을 완료했네!
너무 빡빡하진 않았을 것이네. 그렇지? 이런 이더리움에 관한 많은 것들에 대해 사람들이 말하는 걸 듣다 보면 굉장히 복잡하게 느껴지네. 
그러니 이를 이해하는 가장 좋은 방법은 실제로 직접 구현해보는 것이네. 이건 그저 가장 간단한 구현 버전이라는 것을 명심하게. 구현에 더 추가할 수 있는 추가적인 기능들이 많이 있네. 
예를 들면 사용자들이 의도치 않게 그들의 좀비를 0번 주소로 보내는 것(토큰을 "태운다(burning)"고 하는 것이지 - 기본적으로 누구도 개인키를 가지고 있지 않은 주소로 보내서 복구할 수 없게 하는 것이네)을 막기 위해 추가적인 확인을 할 수 있겠지.
혹은 DApp 자체에 기본적은 경매 로직을 넣는 것도 가능할 것이네(이를 구현하는 방법을 생각해낼 수 있겠나?).

하지만 우리는 이 레슨이 다루기 쉽게 유지하고 싶기 때문에, 가장 기본적인 구현만 진행하였네. 더 깊이 있는 구현의 예시를 보고 싶다면, 이 튜토리얼이 끝난 후 OpenZeppelin ERC721 컨트랙트를 참고해보도록 하게.

_컨트랙트 보안 강화: 오버플로우와 언더플로우
이제 스마트 컨트랙트를 작성할 때 자네가 인지하고 있어야 할 하나의 주요한 보안 기능을 살펴볼 것이네: 오버플로우와 언더플로우를 막는 것이지.

[오버플로우가 무엇인가?]
우리가 8비트 데이터를 저장할 수 있는 uint8 하나를 가지고 있다고 해보지. 
이 말인즉 우리가 저장할 수 있는 가장 큰 수는 이진수로 11111111(또는 십진수로 2^8 - 1 = 255)가 되겠지. 다음 코드를 보게. 마지막에 number의 값은 무엇이 되겠나?
```
uint8 number = 255;
number++;
```
이 예시에서, 우리는 이 변수에 오버플로우를 만들었네 - 즉 number가 직관과는 다르게 0이 되네. 우리가 증가를 시켰음에도 말이야. 
자네가 이진수 11111111에 1을 더하면, 이 수는 00000000으로 돌아가네. 시계가 23:59에서 00:00으로 가듯이 말이야.
[언더플로우]는 이와 유사하게 자네가 0 값을 가진 uint8에서 1을 빼면, 255와 같아지는 것을 말하네(uint에 부호가 없어, 음수가 될 수 없기 때문이지.uint는 양수만 지원. 음수까지 쓰고싶으면 int 사용).
우리가 여기서 uint8을 쓰지는 않고, 1씩 증가시킨다고 uint256에 오버플로우가 발생하지는 않을 것 같지만(2^256은 정말 큰 숫자이네), 미래에 우리의 DApp에 예상치 못한 문제가 발생하지 않도록 여전히 우리의 컨트랙트에 보호 장치를 두는 것이 좋을 것이네.

_SafeMath 사용하기

이를 막기 위해, OpenZeppelin에서 기본적으로 이런 문제를 막아주는 SafeMath라고 하는 라이브러리를 만들었네.
이것을 살펴보기 전에 먼저... 라이브러리가 무엇인가?

[라이브러리(Library)]는 솔리디티에서 특별한 종류의 컨트랙트이네. 이게 유용하게 사용되는 경우 중 하나는 기본(native) 데이터 타입에 함수를 붙일 때이네.
예를 들어, SafeMath 라이브러리를 쓸 때는 using SafeMath for uint256이라는 구문을 사용할 것이네. SafeMath 라이브러리는 4개의 함수를 가지고 있네 - add, sub, mul, 그리고 div가 있네. 그리고 이제 우리는 uint256에서 다음과 같이 이 함수들에 접근할 수 있네.
```
using SafeMath for uint256;

uint256 a = 5;
uint256 b = a.add(3); // 5 + 3 = 8
uint256 c = a.mul(2); // 5 * 2 = 10
```
이 함수들이 어떤 것들인지는 다음 챕터에서 알아볼 것이네. 지금은 우리 컨트랙트에 SafeMath 라이브러리를 추가하도록 하지.

_직접 해보기.
자네를 위해 safemath.sol에 OpenZeppelin의 SafeMath 라이브러리를 먼저 포함해 놓았네. 자네가 원한다면 그 코드를 슬쩍 먼저 봐도 좋지만, 우리는 다음 챕터에서 이 부분을 더 깊이 있게 볼 것이네.
먼저 우리 컨트랙트가 SafeMath 라이브러리를 쓰도록 만들어보세. 우리는 이를 가장 기초가 되는 컨트랙트인 ZombieFactory에 적용할 것이네 - 이렇게 하면 이를 상속하는 하위 컨트랙트에서 모두 쓸 수 있지.
    1. safemath.sol을 zombiefactory.sol에 임포트하게.
    2. using SafeMath for uint256; 선언을 추가하게.
*/

contract ZombieFactory is Ownable{

    // 2. 여기에 using safemath를 선언하게.
    using SafeMath for uint256;

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
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0));
        uint id = zombies.length - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] ++;
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
