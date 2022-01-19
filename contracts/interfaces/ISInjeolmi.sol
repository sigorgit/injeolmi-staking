pragma solidity ^0.5.6;

import "../klaytn-contracts/token/KIP7/IKIP7.sol";

contract ISInjeolmi is IKIP7 {
    event Stake(address indexed owner, uint256 amount);
    event Unstake(address indexed owner, uint256 amountOfIJM);

    function stake(uint256 amount) external returns (uint256);

    function unstake(uint256 share) external returns (uint256);

    function ratio() external view returns (uint256);

    function withdrawableIJM(address user) external view returns (uint256);

    function amountToWithdrawIJM(uint256 desiredAmountOfIJM) external view returns (uint256);
}
