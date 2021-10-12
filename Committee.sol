// SPDX-License-Identifier: unlicenced

pragma solidity >=0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MoneySavingSystem is ERC20{
    
    address owner;
    uint256 interval;
    uint tokenAmount = 100;
    uint256 totalTokens;
    
    struct Member {
        address person;
        uint256 id;
    }
    
    struct ReserveFee {
        address newMember;
        uint256 fee;
    }
    
    mapping(address => ReserveFee) securityPolicy;
    mapping(address => mapping(uint256 => bool)) paymentRecord;
    mapping(address => Member) memberCount;
    Member[] public members;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function reserveFee(address _newMember, uint256 _fee) internal {
        require(_fee == tokenAmount*5);
        _transfer(_newMember, owner, _fee);
        securityPolicy[] = ReserveFee(_newMember, _fee);
    }
    
    function addMembers(address _member, uint256 _reservefee) public onlyOwner {
        require(memberCount.Member(_member) == false);
        require(Member[5] == false);
        reserveFee(_member, _reservefee);
        members.push(Member(_member));
        memberCount[_member]++;
    }
    
    function depositCommittee(address payable _member,address payable _owner, uint256 _tokenAmount) external payable {
        require(_tokenAmount == tokenAmount);
        require(Member.person(_member) == true);
        require(paymentRecord[_member][_tokenAmount] == false);
        _transfer(_member,_owner,_tokenAmount);
        paymentRecord[_member][_tokenAmount] = true;
    }
    
    function paymentToMember(address payable _member, uint256 _tokenAmount) public payable onlyOwner {
        require(interval == 20 days);
        require(totalTokens == 2500);
        _transfer(owner,_member,totalTokens);
        for(int i=0;i<10;i++) {
            paymentRecord[_member][_tokenAmount] = false;
            memberCount(i) = _member;
        }
    }
}