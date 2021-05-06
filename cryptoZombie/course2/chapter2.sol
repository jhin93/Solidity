// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 2: 매핑과 주소

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
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
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

// 주소

// 이더리움 블록체인은 은행 계좌와 같은 계정들로 이루어져 있지. 계정은 이더리움 블록체인상의 통화인 _이더_의 잔액을 가지지. 
// 자네의 은행 계좌에서 다른 계좌로 돈을 송금할 수 있듯이, 계정을 통해 다른 계정과 이더를 주고 받을 수 있지.
// 각 계정은 은행 계좌 번호와 같은 주소를 가지고 있네. 주소는 특정 계정을 가리키는 고유 식별자로, 다음과 같이 표현되지:

// 0x0cE446255506E92DF41614C46F1d6df9Cc969183

// (이 주소는 크립토좀비 팀의 주소지. 자네가 크립토좀비를 즐기고 있다면 우리에게 이더 몇 개를 보내줄 수 있겠지! ?)
// 이후 레슨에서 주소에 관한 핵심 내용을 알아 볼 것일세. 지금은 자네가 "주소는 특정 유저(혹은 스마트 컨트랙트)가 소유한다"라는 점만 이해하면 되네.
// 그러니까 주소를 우리 좀비들에 대한 소유권을 나타내는 고유 ID로 활용할 수 있네. 
// 유저가 우리 앱을 통해 새로운 좀비를 생성하면 좀비를 생성하는 함수를 호출한 이더리움 주소에 그 좀비에 대한 소유권을 부여하지.