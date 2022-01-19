pragma solidity ^0.5.6;

import "./interfaces/ISparrowStaking.sol";
import "./klaytn-contracts/math/SafeMath.sol";

contract SparrowStaking is ISparrowStaking {
    using SafeMath for uint256;

    IInjeolmi public ijm;
    ISInjeolmi public sIjm;

    IKIP17 public constant nft = IKIP17(0x29d05593116C443da54DaBFB4e5322DEA2fff8Cd);
    uint256 public constant totalNFTs = 8001;
    uint256 public constant baseDepositedIjm = 1000 * 1e18;

    bool public initialized;
    uint256 public initialIjmAmount = totalNFTs * baseDepositedIjm;
    uint256 public initialSIjmAmountPerId;

    mapping(uint256 => bool) public nftSIjmInitialized;
    mapping(uint256 => uint256) internal _nftSIjmAmount;

    constructor(IInjeolmi _ijm, ISInjeolmi _sIjm) public {
        ijm = _ijm;
        sIjm = _sIjm;
    }

    function initialize() external {
        require(!initialized);
        initialized = true;

        ijm.transferFrom(msg.sender, address(this), initialIjmAmount);
        ijm.approve(address(sIjm), initialIjmAmount);

        initialSIjmAmountPerId = (sIjm.stake(initialIjmAmount)).div(totalNFTs);

        emit Initialize(msg.sender, initialSIjmAmountPerId);
    }

    function withdrawReward(uint256 id) external {
        require(id < totalNFTs);
        require(nft.ownerOf(id) == msg.sender);
        if (!nftSIjmInitialized[id]) {
            _nftSIjmAmount[id] = initialSIjmAmountPerId;
            nftSIjmInitialized[id] = true;
        }

        uint256 baseSIjm = sIjm.amountToWithdrawIJM(baseDepositedIjm);
        uint256 withdrawableSIjm = _nftSIjmAmount[id].sub(baseSIjm);
        require(withdrawableSIjm > 0);

        _nftSIjmAmount[id] = baseSIjm;

        uint256 withdrawedIjm = sIjm.unstake(withdrawableSIjm);
        ijm.transfer(msg.sender, withdrawedIjm);

        emit WithdrawReward(msg.sender, id, withdrawedIjm);
    }

    function withdrawableReward(uint256 id) external view returns (uint256) {
        return nftSIjmAmount(id).mul(sIjm.ratio()).div(1e18).sub(baseDepositedIjm);
    }

    function nftSIjmAmount(uint256 id) public view returns (uint256) {
        require(id < totalNFTs);
        return nftSIjmInitialized[id] ? _nftSIjmAmount[id] : initialSIjmAmountPerId;
    }
}
