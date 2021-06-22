// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "./ownable.sol";
// 1. ���⼭ import �ϰ�.
import "./safemath.sol";

// �Լ� ������ ����.
// ���� ������(visibility modifier) : public, private, internal, external
// ���� ������(state modifier) : view, pure
// ����� ���� ������ : 'modifier' - lesson3 é�� 3 ����.
// payable ������ : �̴��� ���� �� �ִ� Ư���� �Լ� ����.

/* é�� 9: �����÷ο� ����.
�����ϳ�, ERC721 ������ �Ϸ��߳�!
�ʹ� �������� �ʾ��� ���̳�. �׷���? �̷� �̴����� ���� ���� �͵鿡 ���� ������� ���ϴ� �� ��� ���� ������ �����ϰ� ��������. 
�׷��� �̸� �����ϴ� ���� ���� ����� ������ ���� �����غ��� ���̳�. �̰� ���� ���� ������ ���� �����̶�� ���� ����ϰ�. ������ �� �߰��� �� �ִ� �߰����� ��ɵ��� ���� �ֳ�. 
���� ��� ����ڵ��� �ǵ�ġ �ʰ� �׵��� ���� 0�� �ּҷ� ������ ��(��ū�� "�¿��(burning)"�� �ϴ� ������ - �⺻������ ������ ����Ű�� ������ ���� ���� �ּҷ� ������ ������ �� ���� �ϴ� ���̳�)�� ���� ���� �߰����� Ȯ���� �� �� �ְ���.
Ȥ�� DApp ��ü�� �⺻���� ��� ������ �ִ� �͵� ������ ���̳�(�̸� �����ϴ� ����� �����س� �� �ְڳ�?).

������ �츮�� �� ������ �ٷ�� ���� �����ϰ� �ͱ� ������, ���� �⺻���� ������ �����Ͽ���. �� ���� �ִ� ������ ���ø� ���� �ʹٸ�, �� Ʃ�丮���� ���� �� OpenZeppelin ERC721 ��Ʈ��Ʈ�� �����غ����� �ϰ�.

_��Ʈ��Ʈ ���� ��ȭ: �����÷ο�� ����÷ο�
���� ����Ʈ ��Ʈ��Ʈ�� �ۼ��� �� �ڳװ� �����ϰ� �־�� �� �ϳ��� �ֿ��� ���� ����� ���캼 ���̳�: �����÷ο�� ����÷ο츦 ���� ������.

[�����÷ο찡 �����ΰ�?]
�츮�� 8��Ʈ �����͸� ������ �� �ִ� uint8 �ϳ��� ������ �ִٰ� �غ���. 
�� ������ �츮�� ������ �� �ִ� ���� ū ���� �������� 11111111(�Ǵ� �������� 2^8 - 1 = 255)�� �ǰ���. ���� �ڵ带 ����. �������� number�� ���� ������ �ǰڳ�?
```
uint8 number = 255;
number++;
```
�� ���ÿ���, �츮�� �� ������ �����÷ο츦 ������� - �� number�� �������� �ٸ��� 0�� �ǳ�. �츮�� ������ ���������� ���̾�. 
�ڳװ� ������ 11111111�� 1�� ���ϸ�, �� ���� 00000000���� ���ư���. �ð谡 23:59���� 00:00���� ������ ���̾�.
[����÷ο�]�� �̿� �����ϰ� �ڳװ� 0 ���� ���� uint8���� 1�� ����, 255�� �������� ���� ���ϳ�(uint�� ��ȣ�� ����, ������ �� �� ���� ��������.uint�� ����� ����. �������� ��������� int ���).
�츮�� ���⼭ uint8�� ������ �ʰ�, 1�� ������Ų�ٰ� uint256�� �����÷ο찡 �߻������� ���� �� ������(2^256�� ���� ū �����̳�), �̷��� �츮�� DApp�� ����ġ ���� ������ �߻����� �ʵ��� ������ �츮�� ��Ʈ��Ʈ�� ��ȣ ��ġ�� �δ� ���� ���� ���̳�.

_SafeMath ����ϱ�

�̸� ���� ����, OpenZeppelin���� �⺻������ �̷� ������ �����ִ� SafeMath��� �ϴ� ���̺귯���� �������.
�̰��� ���캸�� ���� ����... ���̺귯���� �����ΰ�?

[���̺귯��(Library)]�� �ָ���Ƽ���� Ư���� ������ ��Ʈ��Ʈ�̳�. �̰� �����ϰ� ���Ǵ� ��� �� �ϳ��� �⺻(native) ������ Ÿ�Կ� �Լ��� ���� ���̳�.
���� ���, SafeMath ���̺귯���� �� ���� using SafeMath for uint256�̶�� ������ ����� ���̳�. SafeMath ���̺귯���� 4���� �Լ��� ������ �ֳ� - add, sub, mul, �׸��� div�� �ֳ�. �׸��� ���� �츮�� uint256���� ������ ���� �� �Լ��鿡 ������ �� �ֳ�.
```
using SafeMath for uint256;

uint256 a = 5;
uint256 b = a.add(3); // 5 + 3 = 8
uint256 c = a.mul(2); // 5 * 2 = 10
```
�� �Լ����� � �͵������� ���� é�Ϳ��� �˾ƺ� ���̳�. ������ �츮 ��Ʈ��Ʈ�� SafeMath ���̺귯���� �߰��ϵ��� ����.

_���� �غ���.
�ڳ׸� ���� safemath.sol�� OpenZeppelin�� SafeMath ���̺귯���� ���� ������ ���ҳ�. �ڳװ� ���Ѵٸ� �� �ڵ带 ��½ ���� ���� ������, �츮�� ���� é�Ϳ��� �� �κ��� �� ���� �ְ� �� ���̳�.
���� �츮 ��Ʈ��Ʈ�� SafeMath ���̺귯���� ������ ������. �츮�� �̸� ���� ���ʰ� �Ǵ� ��Ʈ��Ʈ�� ZombieFactory�� ������ ���̳� - �̷��� �ϸ� �̸� ����ϴ� ���� ��Ʈ��Ʈ���� ��� �� �� ����.
    1. safemath.sol�� zombiefactory.sol�� ����Ʈ�ϰ�.
    2. using SafeMath for uint256; ������ �߰��ϰ�.
*/

contract ZombieFactory is Ownable{

    // 2. ���⿡ using safemath�� �����ϰ�.
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
