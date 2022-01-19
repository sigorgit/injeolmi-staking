pragma solidity ^0.5.6;

import "./interfaces/IInjeolmi.sol";
import "./interfaces/ISInjeolmi.sol";
import "./klaytn-contracts/math/SafeMath.sol";
import "./klaytn-contracts/token/KIP7/KIP7.sol";
import "./klaytn-contracts/token/KIP7/KIP7Metadata.sol";

contract SInjeolmi is ISInjeolmi, KIP7, KIP7Metadata("sInjeolmi", "sIJM", 18) {
    using SafeMath for uint256;
    IInjeolmi public ijm;

    constructor(IInjeolmi _ijm) public {
        ijm = _ijm;
    }

    function stake(uint256 amount) external returns (uint256 amountOfSIJM) {
        uint256 totalIJM = ijm.balanceOf(address(this));
        uint256 totalShares = totalSupply();
        if (totalShares == 0 || totalIJM == 0) {
            amountOfSIJM = amount;
        } else {
            amountOfSIJM = amount.mul(totalShares).div(totalIJM);
        }
        _mint(msg.sender, amountOfSIJM);
        ijm.transferFrom(msg.sender, address(this), amount);
        emit Stake(msg.sender, amount);
    }

    function unstake(uint256 share) external returns (uint256 amountOfIJM) {
        amountOfIJM = share.mul(ijm.balanceOf(address(this))).div(totalSupply());
        _burn(msg.sender, share);
        ijm.transfer(msg.sender, amountOfIJM);
        emit Unstake(msg.sender, amountOfIJM);
    }

    //multiplied by 1e18
    function ratio() external view returns (uint256) {
        return ijm.balanceOf(address(this)).mul(1e18).div(totalSupply());
    }

    function withdrawableIJM(address user) external view returns (uint256) {
        return balanceOf(user).mul(ijm.balanceOf(address(this))).div(totalSupply());
    }

    function amountToWithdrawIJM(uint256 desiredAmountOfIJM) external view returns (uint256) {
        return desiredAmountOfIJM.mul(totalSupply()).div(ijm.balanceOf(address(this)));
    }
}
