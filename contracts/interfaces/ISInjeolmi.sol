pragma solidity ^0.5.6;

interface ISInjeolmi {
    event Stake(address indexed owner, uint256 amount);
    event Unstake(address indexed owner, uint256 amountOfIJM);

    function stake(uint256 amount) external;

    function unstake(uint256 share) external;

    function ratio() external view returns (uint256);

    function withdrawableIJM(address user) external view returns (uint256);

    function amountToWithdrawIJM(uint256 desiredAmountOfIJM) external view returns (uint256);
}
