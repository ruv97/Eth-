pragma solidity 0.6.12;

contract farm2fork{
    
    struct user{
        role userRole;
        string name;
        string BID;
        uint8 vegName;
        uint8 quantity;
    }
    
    mapping(address=>user) userMapping;
    
    struct Tomato{
        address producerID;
        uint256 plantedDate;
        bool carbonicFertilizer;
        string lotNo;
    }
    
    mapping(address=>Tomato) ProducerDataMapping;
   
    struct tomatoPackage{
        address packerId;
        uint256 packedDate;
        uint256 printedExpiryDate;
    }
    
    mapping(address=>tomatoPackage) PackerDataMapping;
    
    struct shipping{
        address distributerID;
        string accpetedLocation;
        string deliveredLocation;
    }
    
    mapping(address=>shipping) shippingDataMapping; 
    
    struct retail{
        address retailerID;
        uint256 receivedDate;
        uint256 SoldDate;
    }
    
    mapping(address=>retail) retailDataMapping;
    
    struct customer{
        address customer;
        uint256 purchasedDate;
    }
    
    mapping(address=>customer) customerDataMapping;
    
    //***********************Updated details about products at each stage*************************************
    
    event updatedProducerData(address producerID, uint256 plantedDate, bool carbonicFertilizer, string lotNo);
    event updatedPackingData(address packerID, uint256 packedDate, uint256 printedExpiryDate);
    event updatedShippingData(address distributerID, string accpetedLocation, string deliveredLocation);
    event updatedRetailData(address retailerID, uint256 receivedDate, uint256 SoldDate);
    event updatedCustomerData(address customerID, uint256 purchasedDate);
    
    //************************Updated details about resource people********************************************
    
    event producerRegistered(address producerID, string name, string BID);
    event packerRegistered(address pakerID, string name, string BID);
    event distributerRegistered(address distributerID, string name, string BID);
    event customerRegistered(address customerID, string name, string BID);
    event retailerRegistered(address retailerID, string name, string BID);
    
    //**********************Update details about the stage of Tomatoes*****************************************
    
    event tomatoHarvested(address producerID);
    
    
    enum role{producer, packer, distributer, retailer,customer}
    
    //address owner;
    
    //constructor() public {
    //    owner = msg.sender;
    //}
    
    //modifier onlyOwner() {
    //    require(msg.sender == owner,"Only owner can call this task");
    //    _;
    //}
    
    
    address producerID;
    
    modifier onlyProducer() {
        require(userMapping[msg.sender].userRole == role.producer,"only producer can update");
        _;
    }
    
    address packerID;
    
    modifier onlyPacker() {
        require(userMapping[msg.sender].userRole == role.packer);
        _;
    }
    
    address distributerID;
    
    modifier onlyDistributer(){
        require(userMapping[msg.sender].userRole == role.distributer,"only distributer can update");
        _;
    }
    
    address retailerID;
    
    modifier onlyRetailer(){
        require(userMapping[msg.sender].userRole == role.retailer,"only retailer can update");
        _;
    }
    
    address customerID;
    
    modifier onlyCustomer(){
        require(userMapping[msg.sender].userRole == role.customer,"only customer can update");
        _;
    }
    //*********************Register required users**************************************************************
    
    function registerProducer(string memory name, string memory BID)public{
        user memory p = user(role.producer, name, BID, 0, 0);
        userMapping[msg.sender] = p;
        emit producerRegistered(msg.sender, name, BID);
    }
    
    
    function registerPacker(string memory name, string memory BID)public{
        user memory pa = user(role.producer, name, BID, 0, 0);
        userMapping[msg.sender] = pa;
        emit packerRegistered(msg.sender, name, BID);
    }
    
    function registerDistributer(string memory name, string memory BID)public{
        user memory d = user(role.producer, name, BID, 0, 0);
        userMapping[msg.sender] = d;
        emit distributerRegistered(msg.sender, name, BID);
    }
    
    function registerRetailer(string memory name, string memory BID)public{
        user memory r = user(role.producer, name, BID, 0, 0);
        userMapping[msg.sender] = r;
        emit retailerRegistered(msg.sender, name, BID);
    }
    
    function registerCustomer(string memory name, string memory BID)public{
        user memory c = user(role.producer, name, BID, 0, 0);
        userMapping[msg.sender] = c;
        emit customerRegistered(msg.sender, name, BID);
    }
    
    //update
        
      // planted date,quantity,lotno
      // packed date,quantity,expiry date given
      // ditributed from -> to,quantity,shipping mode
      // retailed date
      // received date,place        
      //*************************** 5 functions *****************************************************************
   
    
    function updateProducerData(uint256 plantedDate, bool carbonicFertilizer, string memory lotNo)public onlyProducer(){
        Tomato memory pD = Tomato(msg.sender, plantedDate, carbonicFertilizer, lotNo);
        ProducerDataMapping[msg.sender] = pD;
        emit updatedProducerData(msg.sender, plantedDate, carbonicFertilizer, lotNo);
    }
        
    function updatePackingData(uint256 packedDate, uint256 printedExpiryDate)public onlyPacker(){
        tomatoPackage memory tP = tomatoPackage(msg.sender, packedDate, printedExpiryDate);
        PackerDataMapping[msg.sender] = tP;
        emit updatedPackingData(msg.sender, packedDate, printedExpiryDate);
    }
    
    function updateDistributerData(string memory accpetedLocation, string memory deliveredLocation)public onlyDistributer(){
        shipping memory s = shipping(msg.sender, accpetedLocation, deliveredLocation);
        shippingDataMapping[msg.sender] = s;
        emit updatedShippingData(msg.sender, accpetedLocation, deliveredLocation);
    }
    
    function updateRetailData(uint256 receivedDate, uint256 SoldDate)public onlyRetailer(){
        retail memory rE = retail(msg.sender, receivedDate, SoldDate);
        retailDataMapping[msg.sender] = rE;
        emit updatedRetailData(msg.sender, receivedDate, SoldDate);
    }
    
    function updateCustomerData(uint8 purchasedDate)public onlyCustomer(){
        customer memory cU = customer(msg.sender, purchasedDate);
        customerDataMapping[msg.sender] = cU;
        emit updatedCustomerData(msg.sender, purchasedDate);
    }
    
    //************************Display Details about Tomato at various stage***************************************
    
    function showProductionDetails()public view returns(uint256 plantedDate, bool carbonicFertilizer, string memory lotNo){
        return (ProducerDataMapping[msg.sender].plantedDate, ProducerDataMapping[msg.sender].carbonicFertilizer, ProducerDataMapping[msg.sender].lotNo);
    }
    
    function showPackingData()public view returns(uint256 packedDate, uint256 printedExpiryDate){
        return (PackerDataMapping[msg.sender].packedDate,PackerDataMapping[msg.sender].printedExpiryDate);
    }
    
    function showShippingData()public view returns(string memory accpetedLocation, string memory deliveredLocation){
        return (shippingDataMapping[msg.sender].accpetedLocation, shippingDataMapping[msg.sender].deliveredLocation);
    }
    
    function showRetailData()public view returns(uint256 receivedDate, uint256 SoldDate){
        return (retailDataMapping[msg.sender].receivedDate, retailDataMapping[msg.sender].SoldDate);
    }
    
    function showCustomerData()public view returns(uint256 purchasedDate){
        return customerDataMapping[msg.sender].purchasedDate;
    }
}



pragma solidity 0.6.12;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
   
    address public owner;
   
    constructor(string memory name, string memory symbol, uint256 count) ERC20(name, symbol) public {
       
        owner = msg.sender;
        // _setupDecimals(1);
        _mint(msg.sender, count * 10 ** 18);
        
    
       
    }
}



pragma solidity 0.6.12;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract farm2forkICO {
    
    IERC20 token;
    
    address customer;
    
    constructor() public {
        customer = msg.sender;
    }
    
    function setToken(address _token) public {
        token = IERC20(_token);
    }
    
    function buyTokens(uint256 count) public payable {
        require(msg.value >= 1 ether,"not enough ether sent");
        
        token.transferFrom(customer,msg.sender,count); 
    }
}


