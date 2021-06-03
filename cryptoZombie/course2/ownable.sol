// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.0;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */

  // �����߻� -> �ذ�. 7.5�������� �����ڿ� public, external���� ���ü� ������ ������� �ʴ´ٰ� ��.
  // https://docs.soliditylang.org/en/v0.7.5/070-breaking-changes.html#functions-and-events
  constructor () {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    // �����߻�. Event invocations have to be prefixed by "emit".
    // �ذ�. https://ethereum.stackexchange.com/questions/45482/invoking-events-without-emit-prefix-is-deprecated-in-transfermsg-sender-to/45485
    // Ʈ����� �α׿� �̺�Ʈ �����͸� ����ֱ� ���ؼ� emitŰ���带 ����Ѵ�. https://has3ong.tistory.com/393
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}
