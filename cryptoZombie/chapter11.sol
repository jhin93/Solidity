// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// �츮�� _generateRandomDna �Լ��� ��ȯ���� (��) ������ uint�� �Ǳ⸦ ���ϸ�, ��� �ϸ� �ǰڴ°�?

// �̴������� SHA3�� �� ������ keccak256�� ���� �ؽ� �Լ��� ������ ����. 
//�ؽ� �Լ��� �⺻������ �Է� ��Ʈ���� ���� 256��Ʈ 16������ �����ϳ�. ��Ʈ���� �ణ�� ��ȭ�� ������ �ؽ� ���� ũ�� �޶�����.
//�ؽ� �Լ��� �̴����򿡼� ���� �뵵�� Ȱ�������, ���⼭�� �ǻ� ���� �߻���(pseudo-random number generator)�� �̿��ϵ��� ����.

// keccak256("aaaab");
// ��� : 6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
// keccak256("aaaac");
// ��� : b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9

// �� ���ø� ���� �Է°��� �� ���ڰ� �޶��������� �ұ��ϰ� ��ȯ���� ������ �޶����� �� �� ����.

// �� ��ȯ
// ������ �ڳװ� �ڷ��� ���� ��ȯ�� �� �ʿ䰡 ����. ���� ���ø� ���캸��:

// uint8 a = 5;
// uint b = 6;
// uint8 c = a * b; 
// a * b�� uint8�� �ƴ� uint�� ��ȯ�ϱ� ������ ���� �޽����� ����:
// uint8 c = a * uint8(b); 
// b�� uint8���� �� ��ȯ�ؼ� �ڵ尡 ����� �۵��ϵ��� �ؾ� �Ѵ�:

// ���� ���ÿ��� a * b�� uint�� ��ȯ����. 
// ������ �츮�� �� ��ȯ���� uint8�� �����Ϸ��� �ϴ� ���������� ������ �߱��� �� �ֳ�. 
// ��ȯ���� uint8���� �� ��ȯ�ϸ� �ڵ尡 ����� �۵��ϰ� �����Ϸ��� ���� �޽����� ���� ���� �ɼ�.

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    } 

    function _generateRandomDna(string memory _str) private view returns (uint) {
        // ���⼭ ����
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        // uint(keccak256(_str)); -> �̷��Ը� �Է����� ��, ���� �߻�. ���� : string memory -> byte memory�� ��ȯ�� �� ������ ����. ���� : This function requires a single bytes argument.
        // abi-encodepacked�� �ʿ��ϴٰ� ��. �Ʒ� ��ũ�� �ذ�.
        // https://ethereum.stackexchange.com/questions/68360/invalid-implicit-conversion-from-uint256-to-bytes-memory-requested
        return rand % dnaModulus;
        // %�� �������� ���ϴ� ��.
    }

}

// public�� private �ٽ�.
// �ָ���Ƽ���� �Լ��� �⺻������ public���� �����. ������(Ȥ�� �ٸ� ��� ��Ʈ��Ʈ��) �� ��Ʈ��Ʈ�� �Լ��� ȣ���ϰ� �ڵ带 ������ �� �ִ�.
// �̿� �޸� private�� ��Ʈ��Ʈ ���� �ٸ� �Լ��鸸�� ȣ���� �� �ִٴ� ��.

// abi-encodepacked��?
// https://frontalnh.github.io/categories/ethereum/blockchain/