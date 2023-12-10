// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";


/**
* @title SimpleSlotGame Contract
* @notice A contract that gets random values from Chainlink VRF V2 and uses it to play a slot game
*/
contract SimpleSlotGame is VRFConsumerBaseV2, ConfirmedOwner {
    VRFCoordinatorV2Interface immutable COORDINATOR;

    uint64 immutable s_subscriptionId; 
    bytes32 immutable s_keyHash;
    uint32 public callbackGasLimit = 40000;
    uint16 public requestConfirmations = 3;
    uint32 public numWords = 1;

    uint256 private s_jackpotNumber = 777;
    uint256 private s_multiplier = 10;

    mapping(uint256 => address) private s_spinners;
    mapping(address => uint256) public winnings;

    event SpinStarted(uint256 indexed requestId, address indexed spinner);
    event RandomNumberFulfilled(uint256 indexed requestId, uint256 randomNumber);
    event WinningsWithdrawn(address indexed player, uint256 amount);

    constructor(
        uint64 subscriptionId,
        address vrfCoordinator,
        bytes32 keyHash
    )
        VRFConsumerBaseV2(vrfCoordinator)
        ConfirmedOwner(msg.sender)
    {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_keyHash = keyHash;
        s_subscriptionId = subscriptionId;
    }
    
    function spin() public payable whenNotPaused {
        require(msg.value > 0, "Must bet more than 0");
        
        uint256 requestId = COORDINATOR.requestRandomWords(
            s_keyHash, 
            s_subscriptionId,  
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        
        s_spinners[requestId] = msg.sender;

        emit SpinStarted(requestId, msg.sender);
    }

    function fulfillRandomWords(        
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override { 
        uint256 randomResult = (randomWords[0] % 1000) + 1; 
        address spinner = s_spinners[requestId]; 
        if (randomResult == s_jackpotNumber) {
            winnings[spinner] += msg.value * s_multiplier;
        }

        emit RandomNumberFulfilled(requestId, randomResult);
    }

    function withdrawWinnings() public whenNotPaused {
        uint256 amount = winnings[msg.sender];
        require(amount > 0, "No winnings to withdraw");
        winnings[msg.sender] = 0;
        payable(msg.sender).transfer(amount);

        emit WinningsWithdrawn(msg.sender, amount);
    }

    // The below functions are created for security and contract maintenance

    function updateKeyHash(bytes32 newKeyHash) public onlyOwner {
        s_keyHash = newKeyHash;
    }

    function updateSubscriptionId(uint64 newSubscriptionId) public onlyOwner {
        s_subscriptionId = newSubscriptionId;
    }

    function updateJackpotNumber(uint256 newJackpotNumber) public onlyOwner {
        s_jackpotNumber = newJackpotNumber;
    }

    function updateMultiplier(uint256 newMultiplier) public onlyOwner {
        s_multiplier = newMultiplier;
    }

    bool public paused = false;

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    function pauseContract() public onlyOwner {
        paused = true;
    }

    function resumeContract() public onlyOwner {
        paused = false;
    }
}