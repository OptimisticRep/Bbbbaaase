// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.17;

contract GarageManager {
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    mapping(address => Car[]) public garage;

    error BadCarIndex(uint);

    function addCar(
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        garage[msg.sender].push(Car(_make, _model, _color, _numberOfDoors));
    }

    function updateCar(
        uint _index,
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        if (_index >= garage[msg.sender].length) {
            revert BadCarIndex(_index);
        }

        garage[msg.sender][_index] = Car(_make, _model, _color, _numberOfDoors);
    }

    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    function getMyCars() external view returns (Car[] memory) {
        return getUserCars(msg.sender);
    }

    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}