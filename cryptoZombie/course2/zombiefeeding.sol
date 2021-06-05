// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// 접근 제어자(visibility modifier) : public, private, internal, external
// 상태 제어자(state modifier) : view, pure
// 함수 제어자 : 'modifier' - lesson3 챕터 3 참고.

// 챕터 4: 가스(Gas)

// 훌륭해! 이제 우리는 사용자들이 우리 컨트랙트를 마구 휘젓지 못하게 하면서도 DApp의 핵심적인 부분을 업데이트할 수 있는 방법을 터득했네.
// 지금부터는 또 다른 솔리디티와 다른 프로그래밍 언어들의 차이점을 살펴볼 것이네.

import "./zombiefactory.sol";

interface KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  KittyInterface kittyContract;

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if(keccak256(abi.encodePacked(_species)) == keccak256("kitty")){
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // lesson 2 챕터 12: 다수의 반환값 처리하기. 단 하나의 값에만 관심이 있을 경우, 다른 필드는 빈칸으로 놓기만 하면 된다.
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


// 가스 - 이더리움 DApp이 사용하는 연료

// 솔리디티에서는 사용자들이 자네가 만든 DApp의 함수를 실행할 때마다 _가스_라고 불리는 화폐를 지불해야 하네. 
// 사용자는 이더(ETH, 이더리움의 화폐)를 이용해서 가스를 사기 때문에, 자네의 DApp 함수를 실행하려면 사용자들은 ETH를 소모해야만 하네.

// 함수를 실행하는 데에 얼마나 많은 가스가 필요한지는 그 함수의 로직(논리 구조)이 얼마나 복잡한지에 따라 달라지네. 
// 각각의 연산은 소모되는 가스 비용(gas cost)이 있고, 그 연산을 수행하는 데에 소모되는 컴퓨팅 자원의 양이 이 비용을 결정하네. 
// 예를 들어, storage에 값을 쓰는 것은 두 개의 정수를 더하는 것보다 훨씬 비용이 높네. 
// 자네 함수의 전체 가스 비용은 그 함수를 구성하는 개별 연산들의 가스 비용을 모두 합친 것과 같네.

// 함수를 실행하는 것은 자네의 사용자들에게 실제 돈을 쓰게 하기 때문에, 이더리움에서 코드 최적화는 다른 프로그래밍 언어들에 비해 훨씬 더 중요하네. 
// 만약 자네의 코드가 엉망이라면, 사용자들은 자네의 함수를 실행하기 위해 일종의 할증료를 더 내야 할 걸세. 
// 그리고 수천 명의 사용자가 이런 불필요한 비용을 낸다면 할증료가 수십 억 원까지 쌓일 수 있지.

// 가스는 왜 필요한가?

// 이더리움은 크고 느린, 하지만 굉장히 안전한 컴퓨터와 같다고 할 수 있네. 
// 자네가 어떤 함수를 실행할 때, 네트워크상의 모든 개별 노드가 함수의 출력값을 검증하기 위해 그 함수를 실행해야 하지. 
// 모든 함수의 실행을 검증하는 수천 개의 노드가 바로 이더리움을 분산화하고, 데이터를 보존하며 누군가 검열할 수 없도록 하는 요소이지.

// 이더리움을 만든 사람들은 누군가가 무한 반복문을 써서 네트워크를 방해하거나, 자원 소모가 큰 연산을 써서 네트워크 자원을 모두 사용하지 못하도록 만들길 원했다네. 
// 그래서 그들은 연산 처리에 비용이 들도록 만들었고, 사용자들은 저장 공간 뿐만 아니라 연산 사용 시간에 따라서도 비용을 지불해야 한다네.

// 참고: 사이드체인에서는 반드시 이렇지는 않다네. 크립토좀비를 만든 사람들이 Loom Network에서 만들고 있는 것들이 좋은 예시가 되겠군. 
// 이더리움 메인넷에서 월드 오브 워크래프트 같은 게임을 직접적으로 돌리는 것은 절대 말이 되지 않을 걸세. 
// 가스 비용이 엄청나게 높을 것이기 때문이지. 하지만 다른 합의 알고리즘을 가진 사이드체인에서는 가능할 수 있지. 
// 우린 다음에 나올 레슨에서 DApp을 사이드체인에 올릴지, 이더리움 메인넷에 올릴지 판단하는 방법들에 대해 더 얘기할 걸세.