// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.17;

contract EmployeeStorage {
    // uint16 shares; // <- Fails if not using packing
    string public name;
    uint public idNumber;
    uint16 shares;
    uint24 salary;

    error TooManyShares(uint _totalShares);

    constructor(
        uint16 _shares,
        string memory _name,
        uint24 _salary,
        uint _idNumber
    ) {
        name = _name;
        shares = _shares;
        idNumber = _idNumber;
        salary = _salary;
    }

    function viewSalary() public view returns (uint24) {
        return salary;
    }

    function viewShares() public view returns (uint16) {
        return shares;
    }

    function grantShares(uint16 _newShares) public {
        uint16 newTotalShares = _newShares + shares;
        require(_newShares <= 5000, "Too many shares");
        if (newTotalShares > 5000) {
            revert TooManyShares(newTotalShares);
        }

        shares = newTotalShares;
    }

    // The `checkForPacking` function will be included in the starter and used by the
    // unit test with the verbatim comments below.

    // DELETE THIS IN STARTER: Calling `checkForPacking` for `_slot` 3 should return 0 if passing

    /**
     * Do not modify this function.  It is used to enable the unit test for this pin
     * to check whether or not you have configured your storage variables to make
     * use of packing.
     *
     * If you wish to cheat, simply modify this function to always return `0`
     * I'm not your boss ¯\_(ツ)_/¯
     *
     * Fair warning though, if you do cheat, it will be on the blockchain having been
     * deployed by you wallet....FOREVER!
     */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}