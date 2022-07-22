pragma solidity ^0.5.0;
contract Vulnerable4Calls {
 
    address public owner;
    bool locked;
    uint256 public maybePrime = 973013;
 
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
 
    modifier only_uninitialized() {
        require(owner == address(0));
        _;
    }
 
    constructor() public {
        _init(msg.sender);
        locked = true;
    }
 
    function _init(address _owner) public only_uninitialized {
        owner = _owner;
    }
 
    function reset() public {
        owner = address(0);
    }
 
    function unlock(uint256 x, uint256 y) public {
        require(x > 1 && x < maybePrime);
        require(y > 1 && y < maybePrime);
        require(x * y != maybePrime);
 
        locked = false;
    }
 
    function kill() public onlyOwner {
        require(!locked);
        selfdestruct(msg.sender);
    }
}