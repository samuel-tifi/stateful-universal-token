// SPDX-License-Identifier: MIT
// SUT (Stateful Universal Token) Interface
pragma solidity ^0.8.0;

/**
 * @dev Required interface of a SUT compliant contract.
 */
interface ISUT {
    /**
     * @dev Emitted when `value` tokens of token type `id` in the specific `state` are transferred from `from` to
     * `to` by `operator`.
     */
    event TransferSingle(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 id,
        uint256 state,
        uint256 value
    );

    /**
     * @dev Equivalent to multiple {TransferSingle} events, where `operator`, `from` and `to` are the same for all
     * transfers.
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] states,
        uint256[] values
    );

    /**
     * @dev Emitted when `account` grants or revokes permission to `operator` to transfer their tokens, according to
     * `approved`.
     */
    event ApprovalForAll(
        address indexed account,
        address indexed operator,
        bool approved
    );

    /**
     * @dev Emitted when state is changed for single type of token
     */
    event ChangeStateSingle(
        address indexed account,
        uint256 id,
        uint256 value,
        uint256 oldState,
        uint256 newState
    );

    /**
     * @dev Emitted when states are changed for muliple types of tokens
     */
    event ChangeStateBatch(
        address indexed account,
        uint256[] ids,
        uint256[] values,
        uint256 oldStates,
        uint256 newStates
    );

    /**
     * @dev Emitted when the URI for token type `id` changes to `value`, if it is a non-programmatic URI.
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev Returns the amount of tokens of token type `id` owned by `account`.
     *
     * Requirements:
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id)
        external
        view
        returns (uint256);

    /**
     * @dev batched version of {balanceOf}.
     *
     * Requirements:
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);

    /**
     * @dev Grants or revokes permission to `operator` to transfer the caller's tokens, according to `approved`,
     *
     * Emits an {ApprovalForAll} event.
     *
     * Requirements:
     * - `operator` cannot be the caller.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns true if `operator` is approved to transfer `account`'s tokens.
     * See {setApprovalForAll}.
     */
    function isApprovedForAll(address account, address operator)
        external
        view
        returns (bool);

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to` for a specific `state`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If the caller is not `from`, it must have been approved to spend ``from``'s tokens via {setApprovalForAll}.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {ISUTReceiver-onSUTReceived} and return the
     * acceptance magic value.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 state,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev Batched version of {safeTransferFrom}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     * - `ids`, `amounts` and `states` must have the same length.
     * - If `to` refers to a smart contract, it must implement {ISUTReceiver-onSUTReceived} and return the
     * acceptance magic value.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata states,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;

    /**
     * @dev Change a single type `id` of token to the specific `state` owned by `msg.sender`.
     *
     * Emits a {ChangeStateSingle} event.
     *
     * Requirements:
     * - `id` and `state` must exist.
     * - `msg.sender` must have at least `amount` of tokens of the type `id` in `state`.
     */
    function changeState(
        uint256 id,
        uint256 state,
        uint256 amount
    ) external;

    /**
     * @dev Batched version of {changeState}
     *
     * Emits a {batchChangeStates} event.
     *
     * Requirements:
     * - `ids`, `states` and `amounts` must have the same length.
     */
    function batchChangeStates(
        uint256[] calldata ids,
        uint256[] calldata states,
        uint256[] calldata amounts
    ) external;

    /**
     * @dev Get balance of SUT for an `account`, `id` and `state`.
     */
    function balanceOfState(
        address account,
        uint256 id,
        uint256 state
    ) external view returns (uint256);

    /**
     * @dev Batched version of {balanceOfState}
     *
     * Requiremets:
     * - `ids`, `states` and `accounts` must have the same length.
     */
    function balanceOfStateBatch(
        address[] calldata accounts,
        uint256[] calldata ids,
        uint256[] calldata states
    ) external view returns (uint256[] memory);
}
