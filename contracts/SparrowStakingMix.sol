pragma solidity ^0.5.6;

import "./klaytn-contracts/math/SafeMath.sol";
import "./interfaces/ISparrowStakingMix.sol";

contract SparrowStakingMix is ISparrowStakingMix {
    using SafeMath for uint256;

    IKIP7 public mix;
    IKIP17 public constant nft = IKIP17(0x29d05593116C443da54DaBFB4e5322DEA2fff8Cd);
    uint256 public constant totalNFTs = 8001;
    uint256 internal _lastMixBalance;

    uint256 public constant PRECISION = 1e20;

    mapping(uint256 => uint256) public nftRewardDebt;
    uint256 public accRewardEach;

    constructor(IKIP7 _mix) public {
        mix = _mix;
    }

    function _updateReward() internal {
        uint256 currentMixBalance = mix.balanceOf(address(this));
        uint256 reward = currentMixBalance.sub(_lastMixBalance);
        if (reward > 0) {
            accRewardEach = accRewardEach.add(reward.mul(PRECISION).div(totalNFTs));
            _lastMixBalance = mix.balanceOf(address(this));
        }
    }

    function withdrawReward(uint256[] calldata ids) external {
        _updateReward();

        uint256 totalWithdrawableReward;
        uint256 _accRewardEach = accRewardEach.div(PRECISION);

        for (uint256 i = 0; i < ids.length; i++) {
            require(ids[i] < totalNFTs);
            require(nft.ownerOf(ids[i]) == msg.sender);

            uint256 _withdrawableReward = _accRewardEach.sub(nftRewardDebt[ids[i]]);
            totalWithdrawableReward = totalWithdrawableReward.add(_withdrawableReward);
            nftRewardDebt[ids[i]] = _accRewardEach;
            emit WithdrawReward(msg.sender, ids[i], _withdrawableReward);
        }
        require(totalWithdrawableReward > 0);
        _safeMixTransfer(msg.sender, totalWithdrawableReward);

        _lastMixBalance = mix.balanceOf(address(this));
    }

    function withdrawableReward(uint256[] calldata ids) external view returns (uint256) {
        uint256 currentMixBalance = mix.balanceOf(address(this));
        uint256 reward = currentMixBalance.sub(_lastMixBalance);

        uint256 _accRewardEach = (accRewardEach.add(reward.mul(PRECISION).div(totalNFTs))).div(PRECISION);

        uint256 totalWithdrawableReward;
        for (uint256 i = 0; i < ids.length; i++) {
            require(ids[i] < totalNFTs);
            totalWithdrawableReward = totalWithdrawableReward.add(_accRewardEach.sub(nftRewardDebt[ids[i]]));
        }
        return totalWithdrawableReward;
    }

    function _safeMixTransfer(address to, uint256 amount) internal {
        uint256 mixBal = mix.balanceOf(address(this));
        if (amount > mixBal) {
            mix.transfer(to, mixBal);
        } else {
            mix.transfer(to, amount);
        }
    }
}
