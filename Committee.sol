// SPDX-License-Identifier: unlicenced

pragma solidity >=0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MoneySavingSystem is ERC20{
    
    address owner = msg.sender;
    uint256 interval;
    uint256 totalTokens;
    
    struct Member {
        address person;
    }
    
    mapping(address => mapping(uint256 => bool)) paymentRecord;
    mapping(address => uint256) memberCount;
    Member[] public members;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function addMembers(address _member) public onlyOwner {
        require(memberCount[_member] == 0); 
        members.push(Member(_member));
        memberCount[_member]++;
    }
    
    function depositCommittee(address payable _member,address payable _owner, uint256 _tokenAmount) external payable {
        require(_tokenAmount == 500);
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