// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SimpleStorage {
    struct People {
        uint favouriteNumber;
        string name;
    }
    uint FavoriteNumber;
    People[] public people;
    mapping(string => uint) public nameToFavoriteNumber;

    function addPeople(string memory _name, uint _favouriteNumber) public {
        people.push(People(_favouriteNumber, _name));
        nameToFavoriteNumber[_name] = _favouriteNumber;
    }

    function store(uint _favouriteNumber) public {
        FavoriteNumber = _favouriteNumber;
    }

    function retrieve() public view returns (uint) {
        return FavoriteNumber;
    }
}
