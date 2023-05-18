// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract FavoriteRecords {
    mapping(string => bool) public approvedRecords;
    string[] listOfApproved;
    uint numApprovedRecords;

    mapping(address => string[]) public userFavorites;

    error NotApproved(string recordName);

    constructor() {
        _addApprovedRecord("Thriller");
        _addApprovedRecord("Back in Black");
        _addApprovedRecord("The Bodyguard");
        _addApprovedRecord("The Dark Side of the Moon");
        _addApprovedRecord("Their Greatest Hits (1971-1975)");
        _addApprovedRecord("Hotel California");
        _addApprovedRecord("Come On Over");
        _addApprovedRecord("Rumours");
        _addApprovedRecord("Saturday Night Fever");
    }

    function _addApprovedRecord(string memory _name) private {
        approvedRecords[_name] = true;
        listOfApproved.push(_name);
        numApprovedRecords++;
    }

    function getApprovedRecords() public view returns (string[] memory) {
        return listOfApproved;
    }

    function addRecord(string memory _albumName) public {
        if (!approvedRecords[_albumName]) {
            revert NotApproved(_albumName);
        }

        userFavorites[msg.sender].push(_albumName);
    }

    function getUserFavorites(
        address _address
    ) public view returns (string[] memory) {
        return userFavorites[_address];
    }

    function resetUserFavorites() public {
        delete userFavorites[msg.sender];
    }
}