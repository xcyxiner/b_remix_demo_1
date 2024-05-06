// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;//hello all ! i'm patrick!

contract SimpleStorage{
    //boolean,unit,int,address,bytes
    // bool hasFavoriteNumber=false;
    uint256 favoriteNumber;
    // string favoriteNumberInText="Five";
    // int256 favoriteInt=-5;
    // address myAddRess=0x63E0fDA295DcB367dD88F1558F433c8F5566277f;
    // bytes32 favoriteBytes="cat";

    // People public  person=People({favoriteNumber:2,name:"xcyxiner"});

   mapping(string => uint256) public nameToFavoriteNumber;

    struct People{
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber=_favoriteNumber;
    } 

   //view 不消耗gas,除非在gas中调用，不能改变状态,pure 不消耗gas，不改变状态,也不能读取变量 
    function retrieve() public view  returns (uint256){
        return favoriteNumber;
    }

    //calldata 不氪改变  memory 内存 storage 全局作用域
    function addPerson(string memory _name,uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber,_name));
        nameToFavoriteNumber[_name]=_favoriteNumber;
    }
}
//0xd9145CCE52D386f254917e481eB44e9943F39138