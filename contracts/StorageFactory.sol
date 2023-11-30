// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "contracts/SimpleStorage.sol";
contract StorageFactory is SimpleStorage{
    SimpleStorage[] simpleStorageArray;
    function createSimpleStorageContract() public {
    SimpleStorage simpleStorage = new SimpleStorage();
     simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint simpleStorageIndex,uint simpleStorageNumber) public {
        SimpleStorage(address(simpleStorageArray[simpleStorageIndex])).store(simpleStorageNumber);
    }

    function sfRetrieve(uint simpleStorageIndex) public view returns (uint){
        return SimpleStorage(address(simpleStorageArray[simpleStorageIndex])).retrieve();
    }

}