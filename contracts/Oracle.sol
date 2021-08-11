pragma solidity ^0.8.6;
//SPDX-License-Identifier:UNLICENSED

contract Oracle {
    struct Data {
        uint date;
        uint payload;
    }
    address public admin;
    //several reporters (addresses allowed to report the data)
    mapping(address => bool) public reporters;
    //store reported data
    mapping(bytes32 => Data) public data;

    constructor(address _admin) {
        admin = _admin;
    }

    function updateReporter(address reporter, bool isReporter) external {
        //the sender of the trasaction is an admin
        require(msg.sender == admin, 'only admin');
        //update a reporter admin
        reporters[reporter] = isReporter;
    }

    //updta data for the smart contract
    function updateData(bytes32 key, uint payload) external {
        //make sure the reporter is inside reporters array
        require(reporters[msg.sender] == true, 'only reporters');
        //update the data indexed by the key variable
        data[key] = Data(block.timestamp,payload);
    }

    function getData(bytes32 key)
        external 
        view 
        returns(bool result, uint date, uint payload){
            //test we do have the data
            //if 0 acess to default values
            if(data[key].date == 0){
                return(false, 0, 0);
            }
            //if true, return a tuple
            return (true, data[key].date, data[key].payload);
        }

}