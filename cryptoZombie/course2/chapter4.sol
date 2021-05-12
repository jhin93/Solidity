// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 4: Require

// 레슨 1에서 유저가 createRandomZombie를 호출하여 좀비 이름을 입력하면 새로운 좀비를 생성할 수 있도록 했네. 
// 하지만, 만일 유저가 이 함수를 계속 호출해서 무제한으로 좀비를 생성한다면 게임이 매우 재미있지는 않을 걸세.
// 각 플레이어가 이 함수를 한 번만 호출할 수 있도록 만들어 보세. 이로써 새로운 플레이어들이 게임을 처음 시작할 때 좀비 군대를 구성할 첫 좀비를 생성하기 위해 createRandomZombie함수를 호출하게 될 것이네.
// 어떻게 하면 이 함수가 각 플레이어마다 한 번씩만 호출되도록 할 수 있을까?
// 이를 위해 require를 활용할 것이네. require를 활용하면 특정 조건이 참이 아닐 때 함수가 에러 메시지를 발생하고 실행을 멈추게 되지.

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;
    // 여기서 매핑 선언
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) private {
        // 새롭게 Zombie 구조체에 추가를 한 좀비의 인덱스를 id로 사용한다.
        // 해결. https://ethereum.stackexchange.com/questions/89792/typeerror-different-number-of-components-either-side-of-equation
        // 버전 0.6부터 push가 length를 반환하지 않고 더하기 기능만 수행함. 
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        // msg.sender 대입
        zombieToOwner[id] = msg.sender;
        // 자바스크립트와 마찬가지로 솔리디티에서도 uint를 ++로 증가시킬 수 있다.
        ownerZombieCount[msg.sender] ++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

// ※ msg.sender
// 솔리디티에는 모든 함수에서 이용 가능한 특정 전역 변수들이 있지.
// 그 중의 하나가 현재 함수를 호출한 사람 (혹은 스마트 컨트랙트)의 주소를 가리키는 msg.sender이지.

// 참고: 솔리디티에서 함수 실행은 항상 외부 호출자가 시작하네. 
// 컨트랙트는 누군가가 컨트랙트의 함수를 호출할 때까지 블록체인 상에서 아무 것도 안 하고 있을 것이네. 
// 그러니 항상 msg.sender가 있어야 하네.



// ※ msg.sender를 이용하고 mapping을 업데이트하는 예시.

// mapping (address => uint) favoriteNumber;

// function setMyNumber(uint _myNumber) public {
  // `msg.sender`에 대해 `_myNumber`가 저장되도록 `favoriteNumber` 매핑을 업데이트한다 `
  // favoriteNumber[msg.sender] = _myNumber;
  // ^ 데이터를 저장하는 구문은 배열로 데이터를 저장할 떄와 동일하다 
// }

// function whatIsMyNumber() public view returns (uint) {
  // sender의 주소에 저장된 값을 불러온다 
  // sender가 `setMyNumber`을 아직 호출하지 않았다면 반환값은 `0`이 될 것이다
  // return favoriteNumber[msg.sender];
// }
// 이 간단한 예시에서 누구나 setMyNumber을 호출하여 본인의 주소와 연결된 우리 컨트랙트 내에 uint를 저장할 수 있지.




// 자바스크립트와 마찬가지로 솔리디티에서도 uint를 ++로 증가시킬 수 있다.

// uint number = 0;
// number++;
// `number`는 이제 `1`이다