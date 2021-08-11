const Oracle = artifacts.require("Oracle.sol");
const Consumer = artifacts.require("Consumer.sol");

module.exports = async function (deployer, _network, addresses) {
    const [admin, reporter, _] = addresses;
    await deployer.deploy(Oracle, admin);
    //get a pointer to the deploy oracle
    const oracle = await Oracle.deployed();
    //update add a reporter, transaction send from the admin
    //transaction send from the first element of the array
    await oracle.updateReporter(reporter, true);
    //deploy the consumer smart contract, passe address of the oracle for the constructor
    await deployer.deploy(Consumer, oracle.address);
};
