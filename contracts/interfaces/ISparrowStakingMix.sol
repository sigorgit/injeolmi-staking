pragma solidity ^0.5.6;

import "../klaytn-contracts/token/KIP7/IKIP7.sol";
import "../klaytn-contracts/token/KIP17/IKIP17.sol";

interface ISparrowStakingMix {
    event WithdrawReward(address indexed owner, uint256 indexed id, uint256 withdrawedMix);

    function mix() external view returns(IKIP7);
    function nft() external view returns(IKIP17);
    
    function totalNFTs() external view returns(uint256);
    function PRECISION() external view returns(uint256);
    function accRewardEach() external view returns(uint256);
    function nftRewardDebt(uint256 id) external view returns(uint256);

    function withdrawReward(uint256[] calldata ids) external;
    function withdrawableReward(uint256[] calldata ids) external view returns (uint256);
}