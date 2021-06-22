// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "./ownable.sol";
import "./safemath.sol";

// �Լ� ������ ����.
// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// ����� ���� ������ : 'modifier' - lesson3 é�� 3 ����.
// payable ������ : �̴��� ���� �� �ִ� Ư���� �Լ� ����.

/* é�� 11: SafeMath ��Ʈ 3
�Ǹ��ϱ�, ���� �츮�� ERC721 ������ �����÷ο� & ����÷ο쿡�� �����ϳ�! 
���� �������� �츮�� �ۼ��� �ڵ�� ���ư� ����, �츮 �ڵ忡 �����÷ο쳪 ����÷ο찡 �߻��� �� �ִ� ������ �� �� �� �ֳ�.
���� ���, ZombieAttack����:
```
myZombie.winCount++;
myZombie.level++;
enemyZombie.lossCount++;
```
���⼭�� ������ ���� �����÷ο츦 ���ƾ� �� ���̳�(�Ϲ������� �⺻ ���� ���꺸�� SafeMath�� ���� ���� ����. 
������ �ָ���Ƽ ���������� �̰� �⺻���� ���Ե� ���� �ְ�����, ������ �츮 �ڵ忡 �߰����� ���� ��ġ�� �ؾ� �ϳ�).

������ ���⿡ ���� ������ �ֳ� - winCount�� lossCount�� uint16�̰�, level�� uint32�� ������.
�� �츮�� �̷� �μ����� �Ἥ SafeMath�� add �޼ҵ带 ����ϸ�, �� Ÿ�Ե��� uint256���� �ٲ� ���̱� ������ ������ �����÷ο츦 �������� ���ϳ�.
```
function add(uint256 a, uint256 b) internal pure returns (uint256) {
  uint256 c = a + b;
  assert(c >= a);
  return c;
}
// ���� `uint8`�� `.add`�� ȣ���Ѵٸ�, Ÿ���� `uint256`�� ��ȯ�ǳ�.
// �׷��� 2^8���� �����÷ο찡 �߻����� ���� ���̳�. 256�� `uint256`���� ��ȿ�� �����̱� ��������.
```
�ǹ��� : uint8(2^8)�� uint256���� ��ȿ�ϴٸ�, uint16, uint32�� ������������ �ϴ� �� �ƴѰ�? uint8�� Ư���� �����Ѱǰ�?
�̴� �� uint16�� uint32���� �����÷ο�/����÷ο츦 ���� ���� 2���� ���̺귯���� �� ������ �Ѵٴ� ���� �ǹ��ϳ�. �츮�� �̵��� SafeMath16�� SafeMath32��� �θ� ���̳�.

�ڵ�� ��� uint256���� uint32 �Ǵ� uint16���� �ٲ�ٴ� �� ����� SafeMath�� ��Ȯ�� ���� ���̳�.
���� �ڳ׸� ���� ���� �� �ڵ带 ������ ���ҳ� - safemath.sol�� ���� ������ �ڵ带 Ȯ���غ���.
���� �츮�� ZombieFactory�� �̸� ����Ͽ� �����ؾ� �� ���̳�.
 */

contract ZombieFactory is Ownable{

    using SafeMath for uint256;
    // 1. using SafeMath32 for uint32�� �����ϰ�.
    using SafeMath32 for uint32;
    // 2. using SafeMath16 for uint16�� �����ϰ�.
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
        // ����: �츮�� Year 2038 ������ ���� �ʱ�� �ϰڳ�... �׷��� readyTime���� �����÷ο츦 ������ �ʿ�� ����.
        // �츮 ���� 2038�⿡�� �� ���̰��� ;)
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0));
        uint id = zombies.length - 1;
        zombieToOwner[id] = msg.sender;
        // 3. ���⿡ SafeMath�� `add`�� ����ϰ�:
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
