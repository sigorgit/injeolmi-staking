// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.6;

import "./interfaces/IInjeolmi.sol";
import "./interfaces/ISInjeolmi.sol";
import "./klaytn-contracts/math/SafeMath.sol";

contract TotalBalanceOf {
    using SafeMath for uint256;

    IInjeolmi public ijm;
    ISInjeolmi public sijm;

    constructor(IInjeolmi _ijm, ISInjeolmi _sijm) public {
        ijm = _ijm;
        sijm = _sijm;
    }

    function decimals() public view returns (uint8) {
        return 18;
    }

    function balanceOf(address account) public view returns (uint256) {
        return ijm.balanceOf(account).add(sijm.withdrawableIJM(account));
    }
}
