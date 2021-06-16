// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* 챕터 2: 출금
이전 챕터에서, 우린 컨트랙트에 이더를 보내는 방법을 배웠네. 그럼 이더를 보낸 다음에는 어떤 일이 일어날까?
자네가 컨트랙트로 이더를 보내면, 해당 컨트랙트의 이더리움 계좌에 이더가 저장되고 거기에 갇히게 되지 - 자네가 컨트랙트로부터 이더를 인출하는 함수를 만들지 않는다면 말이야.
자네는 다음과 같이 컨트랙트에서 이더를 인출하는 함수를 작성할 수 있네:

contract GetPaid is Ownable {
  function withdraw() external onlyOwner {
    owner.transfer(this.balance);
  }
}
우리가 Ownable 컨트랙트를 import 했다고 가정하고 owner와 onlyOwner를 사용하고 있다는 것을 참고하게.
자네는 transfer 함수를 사용해서 이더를 특정 주소로 전달할 수 있네. 그리고 this.balance는 컨트랙트에 저장돼있는 전체 잔액을 반환하지. 
그러니 100명의 사용자가 우리의 컨트랙트에 1이더를 지불했다면, this.balance는 100이더가 될 것이네.

자네는 transfer 함수를 써서 특정한 이더리움 주소에 돈을 보낼 수 있네. 
예를 들어, 만약 누군가 한 아이템에 대해 초과 지불을 했다면, 이더를 msg.sender로 되돌려주는 함수를 만들 수도 있네:

uint itemFee = 0.001 ether;
msg.sender.transfer(msg.value - itemFee);

혹은 구매자와 판매자가 존재하는 컨트랙트에서, 판매자의 주소를 storage에 저장하고, 누군가 판매자의 아이템을 구매하면 구매자로부터 받은 요금을 그에게 전달할 수도 있겠지:
seller.transfer(msg.value).

이런 것들이 이더리움 프로그래밍을 아주 멋지게 만들어주는 예시들이네 - 자네는 이것처럼 누구에게도 제어되지 않는 분산 장터들을 만들 수도 있네.

직접 해보기
1. 우리 컨트랙트에 withdraw 함수를 생성하게. 이 함수는 위에서 본 GetPaid 예제와 동일해야 하네.
2. 이더의 가격은 과거에 비해 10배 이상 뛰었네. 그러니 지금 이 글을 쓰는 시점에서는 0.001이더가 1달러 정도 되지만, 만약 이게 다시 10배가 되면 0.001 ETH는 10달러가 될 것이고 우리의 게임은 더 비싸질 것이네.
    그러니 컨트랙트의 소유자로서 우리가 levelUpFee를 설정할 수 있도록 하는 함수를 만드는 것이 좋겠지.
    2-a. setLevelUpFee라는 이름의, uint _fee를 하나의 인자로 받고 external이며 onlyOwner 제어자를 사용하는 함수를 생성하게.
    2-b. 이 함수는 levelUpFee를 _fee로 설정해야 하네.
 */

import "./zombiefeeding.sol";
import "./ownable.sol";
contract ZombieHelper is ZombieFeeding {

  uint levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }

  // 1. 여기에 withdraw 함수를 생성하게
  function withdraw() external onlyOwner {
    address(uint160(owner)).transfer(address(this).balance);
    // 오류 2 : "send" and "transfer" are only available for objects of type "address payable", not "address".
    // https://www.inflearn.com/questions/8249 - 2번째 대답
    // https://www.programmersought.com/article/67734436660/ - address가 payable 하게 변환하여 작성한다.
  }

  // 2. 여기에 setLevelUpFee를 생성하게
  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp (uint _zombieId) external payable {
    require(msg.value == levelUpFee);
    zombies[_zombieId].level++;
  }

  function changeName(uint _zombieId, string memory _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    // 여기서 시작하게
    uint counter = 0;
    for(uint i = 0; i < zombies.length; i++){
      if(zombieToOwner[i] == _owner){
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
