// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "contracts/SimpleStorage.sol";

contract ExtraStorage is SimpleStorage{
    //
    //virtual override
    function store(uint256 _favoriteNumber) public  override {
        favoriteNumber=_favoriteNumber+5;
    }
}