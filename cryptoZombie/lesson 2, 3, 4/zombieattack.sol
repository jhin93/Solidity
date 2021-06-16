// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

/* 챕터 5: 좀비 싸움
이제 우리의 컨트랙트에 어느 정도 예측이 불가능하도록 하는 성질이 생겼으니, 좀비 전투에서 결과를 계산할 때 이를 사용할 수 있네.
좀비 전투는 다음과 같이 진행될 것이네:
? 자네가 자네 좀비 중 하나를 고르고, 상대방의 좀비를 공격 대상으로 선택하네.
? 자네가 공격하는 쪽의 좀비라면, 자네는 70%의 승리 확률을 가지네. 방어하는 쪽의 좀비는 30%의 승리 확률을 가질 것이네.
? 모든 좀비들(공격, 방어 모두)은 전투 결과에 따라 증가하는 winCount와 lossCount를 가질 것이네.
? 공격하는 쪽의 좀비가 이기면, 좀비의 레벨이 오르고 새로운 좀비가 생기네.
? 좀비가 지면, 아무것도 일어나지 않네(좀비의 lossCount가 증가하는 것 빼고 말이야).
? 좀비가 이기든 지든, 공격하는 쪽 좀비의 재사용 대기시간이 활성화될 것이네.
구현할 내용이 많으니, 다음 챕터로 진행하면서 나눠서 구현할 것이네.

_직접 해보기

1. 컨트랙트에 attackVictoryProbability라는 이름의 uint 변수를 추가하고, 여기에 70을 대입하게.
2. attack이라는 이름의 함수를 생성하게. 이 함수는 두 개의 매개변수를 받을 것이네: _zombieId(uint)와 _targetId(uint)이네. 이 함수는 external이어야 하네.
지금은 함수의 내용을 비워두도록 하게.
 */

import "./zombiehelper.sol";

contract ZombieBattle is ZombieHelper {
  uint randNonce = 0;
  // 여기에 attackVictoryProbability를 만들게
  uint attackVictoryProbability = 70;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

  // 여기에 새로운 함수를 만들게
  function attack(uint _zombieId, uint _targetId) external {

  }
}