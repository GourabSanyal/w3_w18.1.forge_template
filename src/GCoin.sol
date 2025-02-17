// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GCoin is ERC20 {

    constructor() ERC20("G", "GC") {

    }

    function mint(address to, uint256 amount) public{
        _mint(to, amount);
    }
    
    function transfer(address _to, uint256 _value) public virtual override returns (bool success) {
        address owner = _msgSender();
        _transfer(owner, _to, _value);
        return true;
    }
}