pragma solidity ^0.5.6;


interface IInjeolmi {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

/**
 * @dev Interface of the KIP-13 standard, as defined in the
 * [KIP-13](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard).
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others.
 *
 * For an implementation, see `KIP13`.
 */
interface IKIP13 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * [KIP-13 section](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard#how-interface-identifiers-are-defined)
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

/**
 * @dev Interface of the KIP7 standard as defined in the KIP. Does not include
 * the optional functions; to access them see `KIP7Metadata`.
 * See http://kips.klaytn.com/KIPs/kip-7-fungible_token
 */
contract IKIP7 is IKIP13 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through `transferFrom`. This is
     * zero by default.
     *
     * This value changes when `approve` or `transferFrom` are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * > Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an `Approval` event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     */
    function safeTransfer(
        address recipient,
        uint256 amount,
        bytes memory data
    ) public;

    /**
     * @dev  Moves `amount` tokens from the caller's account to `recipient`.
     */
    function safeTransfer(address recipient, uint256 amount) public;

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the allowance mechanism.
     * `amount` is then deducted from the caller's allowance.
     */
    function safeTransferFrom(
        address sender,
        address recipient,
        uint256 amount,
        bytes memory data
    ) public;

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the allowance mechanism.
     * `amount` is then deducted from the caller's allowance.
     */
    function safeTransferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public;

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to `approve`. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract ISInjeolmi is IKIP7 {
    event Stake(address indexed owner, uint256 amount);
    event Unstake(address indexed owner, uint256 amountOfIJM);

    function stake(uint256 amount) external returns (uint256);

    function unstake(uint256 share) external returns (uint256);

    function ratio() external view returns (uint256);

    function withdrawableIJM(address user) external view returns (uint256);

    function amountToWithdrawIJM(uint256 desiredAmountOfIJM) external view returns (uint256);
}

/**
 * @dev Required interface of an KIP17 compliant contract.
 */
contract IKIP17 is IKIP13 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either `approve` or `setApproveForAll`.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public;

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either `approve` or `setApproveForAll`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public;

    function approve(address to, uint256 tokenId) public;

    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;

    function isApprovedForAll(address owner, address operator) public view returns (bool);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public;
}

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
    function withdrawReward(uint256[] calldata ids, uint256[] calldata sIjmAmounts) external;
    function withdrawableReward(uint256[] calldata ids) external view returns (uint256);
    function nftSIjmAmount(uint256 id) external view returns (uint256);
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

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
            uint256 sIjmAmount = sIjmAmounts[i];
            require(id < totalNFTs);
            require(nft.ownerOf(id) == msg.sender);
            require(sIjmAmount > 0);

            if (!nftSIjmInitialized[id]) {
                _nftSIjmAmount[id] = initialSIjmAmountPerId;
                nftSIjmInitialized[id] = true;
            }

            uint256 withdrawedIjm;
            if(sIjmAmount == uint256(-1)) {
                uint256 baseSIjm = sIjm.amountToWithdrawIJM(baseDepositedIjm);
                uint256 withdrawableSIjm = _nftSIjmAmount[id].sub(baseSIjm);
                require(withdrawableSIjm > 0);

                _nftSIjmAmount[id] = baseSIjm;
                
                withdrawedIjm = sIjm.unstake(withdrawableSIjm);
            } else {
                withdrawedIjm = sIjm.unstake(sIjmAmount);
                uint256 nftSIjm_left = _nftSIjmAmount[id].sub(sIjmAmount);

                uint256 withdrawableIJM = nftSIjm_left.mul(ijm.balanceOf(address(sIjm))).div(sIjm.totalSupply());
                require(withdrawableIJM >= baseDepositedIjm);

                _nftSIjmAmount[id] = nftSIjm_left;
            }

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