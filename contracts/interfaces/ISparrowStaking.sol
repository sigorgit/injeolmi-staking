pragma solidity ^0.5.6;

import "./IInjeolmi.sol";
import "./ISInjeolmi.sol";
import "../klaytn-contracts/token/KIP17/IKIP17.sol";

interface ISparrowStaking {
    event Initialize(address indexed initializer, uint256 initialSIjmAmountPerId);
    event WithdrawReward(address indexed owner, uint256 indexed id, uint256 withdrawedIjm);

    function ijm() external view returns (IInjeolmi);
    function sIjm() external view returns (ISInjeolmi);
    function nft() external view returns (IKIP17);

    function totalNFTs() external view returns (uint256);
    function baseDepositedIjm() external view returns (uint256);

    function initialized() external view returns (bool);
    function initialIjmAmount() external view returns (uint256);
    function initialSIjmAmountPerId() external view returns (uint256);

    function nftSIjmInitialized(uint256 id) external view returns (bool);

    function initialize() external;
    function withdrawReward(uint256[] calldata ids) external;
    function withdrawableReward(uint256[] calldata ids) external view returns (uint256);
    function nftSIjmAmount(uint256 id) external view returns (uint256);
}