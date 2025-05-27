// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";

contract BabylonXToken is ERC20, ERC20Burnable, Ownable { 
    uint256 public constant MAX_SUPPLY = 500000 * 1e18; 
    uint256 public constant INITIAL_DISTRIBUTION = 10000 * 1e18; 
    uint256 public constant PUBLIC_SALE_ALLOCATION = 200000 * 10 ** 18; 
    uint256 public constant STAKING_REWARDS_ALLOCATION = MAX_SUPPLY - INITIAL_DISTRIBUTION - PUBLIC_SALE_ALLOCATION;

    address public stakingContract;
    uint256 public annualRewardRate = 10; // 10% annual reward

    constructor(address initialWallet) ERC20("BabylonX", "BBX") Ownable(msg.sender) {
        _mint(initialWallet, INITIAL_DISTRIBUTION);
        _mint(address(this), PUBLIC_SALE_ALLOCATION + STAKING_REWARDS_ALLOCATION);
}

    function setStakingContract(address _stakingContract) external onlyOwner {
        stakingContract = _stakingContract;
}

    function distributeStakingRewards(address to, uint256 amount) external {
        require(msg.sender == stakingContract, "Only staking contract can distribute rewards");
         _transfer(address(this), to, amount);
}

    function buyTokens() external payable {
       // Example token sale logic (to be customized):
      // uint256 rate = 1000; // 1 ETH = 1000 BBX
       // uint256 tokens = msg.value * rate;
       // require(balanceOf(address(this)) >= tokens, "Not enough tokens");
       // _transfer(address(this), msg.sender, tokens);
}

}