// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 챕터 11: Storage는 비싸다.

// 솔리디티에서 더 비싼 연산 중 하나는 바로 storage를 쓰는 것이네 - 그중에서도 쓰기 연산이지. 이건 자네가 데이터의 일부를 쓰거나 바꿀 때마다, 블록체인에 영구적으로 기록되기 때문이네. 영원히! 
// 지구상의 수천 개의 노드들이 그들의 하드 드라이브에 그 데이터를 저장해야 하고, 블록체인이 커져가면서 이 데이터의 양 또한 같이 커져가네. 그러니 이 연산에는 비용이 들지.

// 비용을 최소화하기 위해서, 진짜 필요한 경우가 아니면 storage에 데이터를 쓰지 않는 것이 좋네. 
// 이를 위해 때때로는 겉보기에 비효율적으로 보이는 프로그래밍 구성을 할 필요가 있네 - 어떤 배열에서 내용을 빠르게 찾기 위해, 단순히 변수에 저장하는 것 대신 함수가 호출될 때마다 배열을 memory에 다시 만드는 것처럼 말이지.

// 대부분의 프로그래밍 언어에서는, 큰 데이터 집합의 개별 데이터에 모두 접근하는 것은 비용이 비싸네. 하지만 솔리디티에서는 그 접근이 external view 함수라면 storage를 사용하는 것보다 더 저렴한 방법이네. 
// view 함수는 사용자들의 가스를 소모하지 않기 때문이지(가스는 사용자들이 진짜 돈을 쓰는 것이네!).
// 우리는 다음 챕터에서 for 반복문을 알아볼 것이지만, 먼저 메모리에 배열을 선언하는 방법을 알아보도록 하지.


// 메모리에 배열 선언하기.

// Storage에 아무것도 쓰지 않고도 함수 안에 새로운 배열을 만들려면 배열에 memory 키워드를 쓰면 되네. 이 배열은 함수가 끝날 때까지만 존재할 것이고, 이는 storage의 배열을 직접 업데이트하는 것보다 가스 소모 측면에서 훨씬 저렴하네 - 외부에서 호출되는 view 함수라면 무료이지.
// 메모리에 배열을 선언하는 방법은 다음과 같네:

// function getArray() external pure returns(uint[]) {
//   // 메모리에 길이 3의 새로운 배열을 생성한다.
//   uint[] memory values = new uint[](3);
//   // 여기에 특정한 값들을 넣는다.
//   values.push(1);
//   values.push(2);
//   values.push(3);
//   // 해당 배열을 반환한다.
//   return values;
// }

// 이건 자네에게 문법을 보여주기 위한 그저 간단한 예시에 불과하네만, 다음 챕터에서는 실제 사용에 쓸 수 있도록 for 반복문과 이것을 결합하는 방법을 알아볼 것이네.
// 참고: 메모리 배열은 반드시 길이 인수와 함께 생성되어야 하네(이 예시에서는, 3). 메모리 배열은 현재로서는 storage 배열처럼 array.push()로 크기가 조절되지는 않네. 이후 버전의 솔리디티에서는 변경될 수도 있겠지만 말이야.

// 직접 해보기
// getZombiesByOwner 함수에서, 우리는 특정한 사용자가 소유한 모든 좀비를 uint[] 배열로 반환하기를 원하네.
// 1. result라는 이름의 uint[] memory 변수를 선언하게.
// 2. 해당 변수에 uint 배열을 대입하게. 배열의 길이는 이 _owner가 소유한 좀비의 개수여야 하고, 이는 우리의 mapping인 ownerZombieCount[_owner]를 통해서 찾을 수 있네.
// 3. 함수의 끝에서 result를 반환하게. 지금 당장은 빈 배열이지만, 다음 챕터에서 이를 채울 것이네.

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
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
    // 여기서 시작하게
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    return result;
  }

}
