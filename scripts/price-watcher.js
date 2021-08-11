const CoinGecko = require('coingecko-api');
const Oracle = artifacts.require('Oracle.sol');

//refresh price any 5 sec
const POLL_INTERVAL = 5000;
const CoinGeckoClient = new CoinGecko();

module.exports = async done => {
    const [_, reporter] = await web3.eth.getAccounts();
    //pointer to the default oracle
    const oracle = await Oracle.deployed();

    while(true) {
        const response = await CoinGeckoClient.coins.fetch('bitcoin', {});
        //extract the specific info we want
        let currentPrice = parseFloat(response.data.market_data.current_price.usd);
        //convert to an integer
        currentPrice = parseInt(currentPrice * 100);
        //call the oracle smart contract, update data
        await oracle.updateData(
            web3.utils.soliditySha3('BTC/USD'),
            currentPrice,
            {from: reporter}
        );
        console.log(`new price for BTC/USD ${currentPrice} updated on-chain`);
        //wait poll interval before to go to the next iteration
        //promise resolved after the timeout
        await new Promise(resolve => setTimeout(resolve, POLL_INTERVAL));
    }

    done()
}