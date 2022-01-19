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

    function withdrawReward(uint256[] calldata ids, uint256[] calldata sIjmAmounts) external {
        require(ids.length == sIjmAmounts.length);
        uint256 totalWithdrawedIjm;
        for (uint256 i = 0; i < ids.length; i++) {
            uint256 id = ids[i];
            require(id < totalNFTs);
            require(nft.ownerOf(id) == msg.sender);
            if (!nftSIjmInitialized[id]) {
                _nftSIjmAmount[id] = initialSIjmAmountPerId;
                nftSIjmInitialized[id] = true;
            }

            uint256 withdrawedIjm = sIjm.unstake(sIjmAmounts[i]);

            uint256 nftSIjm_left = _nftSIjmAmount[id].sub(sIjmAmounts[i]);

            uint256 withdrawableIJM = nftSIjm_left.mul(ijm.balanceOf(address(sIjm))).div(sIjm.totalSupply());
            require(withdrawableIJM >= baseDepositedIjm);

            _nftSIjmAmount[id] = nftSIjm_left;

            totalWithdrawedIjm = totalWithdrawedIjm.add(withdrawedIjm);
            emit WithdrawReward(msg.sender, id, withdrawedIjm);
        }
        ijm.transfer(msg.sender, totalWithdrawedIjm);
    }

    function withdrawableReward(uint256[] calldata ids) external view returns (uint256) {
        uint256 totalWithdrawableReward;
        for (uint256 i = 0; i < ids.length; i++) {
            uint256 totalIjm = nftSIjmAmount(ids[i]).mul(sIjm.ratio()).div(1e18);
            if (totalIjm >= baseDepositedIjm) {
                totalWithdrawableReward = totalWithdrawableReward.add(totalIjm - baseDepositedIjm);
            } else {
                return 0;
            }
        }
        return totalWithdrawableReward;
    }

    function nftSIjmAmount(uint256 id) public view returns (uint256) {
        require(id < totalNFTs);
        return nftSIjmInitialized[id] ? _nftSIjmAmount[id] : initialSIjmAmountPerId;
    }
}
