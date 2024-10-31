// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
/*
使用EIP712离线签名出租NFT： 
1. 准备阶段： NFT所有者需要确定租赁条款，包括租赁时间、价格等关键信息，并将这些信息结构化。 
2. struct RentoutOrder {
    address maker; // 出租方地址
    address nft_ca; // NFT合约地址
    uint256 token_id; // NFT tokenId
    uint256 daily_rent; // 每日租金
    uint256 max_rental_duration; // 最大租赁时长
    uint256 min_collateral; // 最小抵押
    uint256 list_endtime; // 挂单结束时间
  }
3. 生成签名： 使用EIP712标准将租赁条款进行编码和签名。这一步骤不需要进行任何链上交互，因此大大降低了交易费用和时间。 
4. 发布租赁信息： 将签名后的租赁条款发布到市场或直接发送给租赁方，租赁方可以验证签名的有效性和条款的一致性。 
5. 执行租赁合同： 一旦租赁方接受条款并签名，合同即被激活。链上智能合约会验证双方的签名和条款，确保交易的执行严格按照协议进行。 使用EIP712离线签名出租NFT： 
6. 准备阶段： NFT所有者需要确定租赁条款，包括租赁时间、价格等关键信息，并将这些信息结构化。 
7. 生成签名： 使用EIP712标准将租赁条款进行编码和签名。这一步骤不需要进行任何链上交互，因此大大降低了交易费用和时间。 
8. 发布租赁信息： 将签名后的租赁条款发布到市场或直接发送给租赁方，租赁方可以验证签名的有效性和条款的一致性。 
9. 执行租赁合同： 一旦租赁方接受条款并签名，合同即被激活。链上智能合约会验证双方的签名和条款，确保交易的执行严格按照协议进行。 

挑战要求： 
1. 完善已有项目： https://github.com/0xqige/openspace-nftrent-study/tree/0508A 实现 NFT 的出租和借入功能。 
2. 完整运行在 https://vercel.com/ 中 
3. 提交内容的：vercel.com上的可访问公共链接 和对应的仓库 github 链接。
*/
/**
 * @title RenftMarket
 * @dev NFT租赁市场合约
 *   TODO:
 *      1. 退还NFT：租户在租赁期内，可以随时退还NFT，根据租赁时长计算租金，剩余租金将会退还给出租人
 *      2. 过期订单处理：
 *      3. 领取租金：出租人可以随时领取租金
 */
contract RenftMarket is EIP712 {
    // 出租订单事件
    event BorrowNFT(
        address indexed taker,
        address indexed maker,
        bytes32 orderHash,
        uint256 collateral
    );
    // 取消订单事件
    event OrderCanceled(address indexed maker, bytes32 orderHash);

    mapping(bytes32 => BorrowOrder) public orders; // 已租赁订单
    mapping(bytes32 => bool) public canceledOrders; // 已取消的挂单

    constructor() EIP712("RenftMarket", "1") {}

    /**
     * @notice 租赁NFT
     * @dev 验证签名后，将NFT从出租人转移到租户，并存储订单信息
     */
    function borrow(
        RentoutOrder calldata order,
        bytes calldata makerSignature
    ) external payable {
        revert("TODO");
    }

    /**
     * 1. 取消时一定要将取消的信息在链上标记，防止订单被使用！
     * 2. 防DOS： 取消订单有成本，这样防止随意的挂单，
     */
    function cancelOrder(
        RentoutOrder calldata order,
        bytes calldata makerSignatre
    ) external {
        revert("TODO");
    }

    // 计算订单哈希
    function orderHash(
        RentoutOrder calldata order
    ) public view returns (bytes32) {
        revert("TODO");
    }

    struct RentoutOrder {
        address maker; // 出租方地址
        address nft_ca; // NFT合约地址
        uint256 token_id; // NFT tokenId
        uint256 daily_rent; // 每日租金
        uint256 max_rental_duration; // 最大租赁时长
        uint256 min_collateral; // 最小抵押
        uint256 list_endtime; // 挂单结束时间
    }

    // 租赁信息
    struct BorrowOrder {
        address taker; // 租方人地址
        uint256 collateral; // 抵押
        uint256 start_time; // 租赁开始时间，方便计算利息
        RentoutOrder rentinfo; // 租赁订单
    }
}
