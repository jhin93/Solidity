// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);
    // 여기에 이벤트 선언
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        // 새롭게 Zombie 구조체에 추가를 한 좀비의 인덱스를 id로 사용한다.
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        // uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // 위처럼 사용할 시 다음과 같은 오류 발생. Different number of components on the left hand side (1) than on the right hand side
        // 크립토좀비에선 문제가 없었던 걸 보니 버전차이로 추정. 
        // 해결. https://ethereum.stackexchange.com/questions/89792/typeerror-different-number-of-components-either-side-of-equation
        // 버전 0.6부터 push가 length를 반환하지 않고 더하기 기능만 수행함. 

        // 여기서 이벤트 실행
        emit NewZombie(id, _name, _dna);
        // 오류발생. Event invocations have to be prefixed by "emit".
        // 해결. https://ethereum.stackexchange.com/questions/45482/invoking-events-without-emit-prefix-is-deprecated-in-transfermsg-sender-to/45485
        // 트랜잭션 로그에 이벤트 데이터를 집어넣기 위해선 emit키워드를 사용한다. https://has3ong.tistory.com/393
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

