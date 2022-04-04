// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

// 챕터 3: Msg.sender

// 레슨 1에서 다뤘던 _createZombie 메소드를 업데이트하여 이 함수를 호출하는 누구나 좀비 소유권을 부여하도록 해 보세.
// 먼저, 새로운 좀비의 id가 반환된 후에 zombieToOwner 매핑을 업데이트하여 id에 대하여 msg.sender가 저장되도록 해보자.
// 그 다음, 저장된 msg.sender을 고려하여 ownerZombieCount를 증가시키자.

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
// //   `msg.sender`에 대해 `_myNumber`가 저장되도록 `favoriteNumber` 매핑을 업데이트한다 `
//   favoriteNumber[msg.sender] = _myNumber;
// //   ^ 데이터를 저장하는 구문은 배열로 데이터를 저장할 때와 동일하다 
// }

// function whatIsMyNumber() public view returns (uint) {
// //   sender의 주소에 저장된 값을 불러온다 
// //   sender가 `setMyNumber`을 아직 호출하지 않았다면 반환값은 `0`이 될 것이다
//   return favoriteNumber[msg.sender];
// }
// 이 간단한 예시에서 누구나 setMyNumber을 호출하여 본인의 주소와 연결된 우리 컨트랙트 내에 uint를 저장할 수 있지.




// 자바스크립트와 마찬가지로 솔리디티에서도 uint를 ++로 증가시킬 수 있다.

// uint number = 0;
// number++;
// `number`는 이제 `1`이다