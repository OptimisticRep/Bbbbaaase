// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract ArraysExercise {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    function resetNumbers() public {
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }

    // More efficient
    function appendToNumbers(uint[] calldata _toAppend) public {
        uint[] memory concated = new uint[](numbers.length + _toAppend.length);

        for (uint i = 0; i < concated.length; i++) {
            if (i < numbers.length) {
                concated[i] = numbers[i];
            } else {
                concated[i] = _toAppend[i - numbers.length];
            }
        }

        numbers = concated;
    }

    // Valid, but less efficient
    // function appendToNumbers(uint[] calldata _toAppend) public {
    //     for(uint i = 0; i < _toAppend.length; i++) {
    //         numbers.push(_toAppend[i]);
    //     }
    // }

    uint constant Y2K = 946702800;
    address[] public senders;
    uint[] public timestamps;

    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        delete timestamps;
    }

    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint count = _countAfterY2K();
        uint[] memory timestampsAfter = new uint[](count);
        address[] memory addressesAfter = new address[](count);
        uint cursor = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > Y2K) {
                timestampsAfter[cursor] = timestamps[i];
                addressesAfter[cursor] = senders[i];
                cursor++;
            }
        }

        return (timestampsAfter, addressesAfter);
    }

    function _countAfterY2K() private view returns (uint) {
        uint count = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > Y2K) {
                count++;
            }
        }

        return count;
    }
}