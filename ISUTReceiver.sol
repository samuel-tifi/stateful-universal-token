// SPDX-License-Identifier: UNKNOWN
pragma solidity ^0.8.0;

interface ISUTReceiver {
    /**
     * @dev Handles the receipt of a single SUT token type. This function is called at the end of
     * a {ISUT-safeTransferFrom} after the balance has been updated.
     *
     * NOTE: To accept the transfer, the implementation must return
     * `bytes4(keccak256("onSUTReceived(address,address,uint256,uint256,uint256,bytes)"))`
     * (i.e. 0x6480c8a4, or its own function selector).
     *
     * @param operator The address which initiated the transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param id The ID of the token being transferred
     * @param state The state of the token being transfered
     * @param value The amount of tokens being transferred
     * @param data Additional data with no specified format
     *
     * @return `bytes4(keccak256("onSUTReceived(address,address,uint256,uint256,uint256,bytes)"))`
     * if transfer is allowed
     */
    function onSUTReceived(
        address operator,
        address from,
        uint256 id,
        uint256 state,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

    /**
     * @dev Handles the receipt of a multiple SUT token types and states. This function is called
     * at then end of a {ISUT-safeBatchTransferFrom} after the balances have been updated.
     *
     * NOTE: To accept the transfer(s), the implementation must return
     * `bytes4(keccak256("onSUTBatchReceived(address,address,uint256[],uint256[],uint256[],bytes)"))`
     * (i.e. 0xf14f45c5, or its own function selector).
     *
     * @param operator The address which initiated the batch transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param ids An array containing ids of each token being transferred (The length of the 3
     * arrays ids, states and values must be the same)
     * @param states An array containing states of each token being transferred
     * @param values An array containing amounts of each token being transferred
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onSUTBatchReceived(address,address,uint256[],uint256[],uint256[],bytes)"))`
     * if transfer is allowed
     */
    function onSUTBatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata states,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}
