
//instance
const CCIPLocalSimulator = await ethers.getContractFactory("CCIPLocalSimulator");
const simulator = await CCIPLocalSimulator.deploy();
await simulator.deployed();

// Configuration for obtaining the contract 'ROuter'
const routerAddress = await simulator.configuration();
console.log("Router Address:", routerAddress);

// Instances : 'CrossChainNameServiceRegister', 'CrossChainNameServiceLookup', 'CrossChainNameServiceReceiver

const CrossChainNameServiceRegister = await ethers.getContractFactory("CrossChainNameServiceRegister");
const register = await CrossChainNameServiceRegister.deploy(routerAddress);
await register.deployed();

const CrossChainNameServiceReceiver = await ethers.getContractFactory("CrossChainNameServiceReceiver");
const receiver = await CrossChainNameServiceReceiver.deploy(routerAddress);
await receiver.deployed();

const CrossChainNameServiceLookup = await ethers.getContractFactory("CrossChainNameServiceLookup");
const lookup = await CrossChainNameServiceLookup.deploy(routerAddress);
await lookup.deployed();

// Enabling chains with 'enableChain'

await register.enableChain(chainId);
await receiver.enableChain(chainId);


// Config : 'CrossChainNameServiceLookup.sol'

await lookup.setCrossChainNameServiceAddress(register.address);
await lookupReceiver.setCrossChainNameServiceAddress(receiver.address);

// Register name

await register.register("alice.ccns", aliceAddress);

// registered name search

const result = await lookup.lookup("alice.ccns");
console.log("Lookup Result:", result);
