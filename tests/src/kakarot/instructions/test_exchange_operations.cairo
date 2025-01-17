// SPDX-License-Identifier: MIT

%lang starknet

// Starkware dependencies
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.cairo.common.bool import TRUE, FALSE
from starkware.cairo.common.uint256 import Uint256, assert_uint256_eq
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.registers import get_fp_and_pc

// Local dependencies
from kakarot.instructions.exchange_operations import ExchangeOperations
from kakarot.model import model
from kakarot.stack import Stack
from tests.utils.helpers import TestHelpers

// @notice Prepare a stack with `stack_len` elements to test swap logic.
func init_stack{range_check_ptr}(
    stack_len: felt,
    swap_idx: felt,
    swap_idx_element: Uint256,
    top_stack_element: Uint256,
    stack: model.Stack*,
) -> (stack: model.Stack*) {
    alloc_locals;
    let fp_and_pc = get_fp_and_pc();
    local __fp__: felt* = fp_and_pc.fp_val;

    if (stack_len == 0) {
        let stack = Stack.push(stack, &top_stack_element);
        return (stack,);
    }

    if (stack_len == swap_idx) {
        tempvar item = &swap_idx_element;
    } else {
        tempvar item = new Uint256(0, 0);
    }

    let stack = Stack.push(stack, &swap_idx_element);
    return init_stack(
        stack_len=stack_len - 1,
        swap_idx=swap_idx,
        swap_idx_element=swap_idx_element,
        top_stack_element=top_stack_element,
        stack=stack,
    );
}

// @notice Checks if previously prepared stack has its values properly swapped.
func assert_stack_is_swapped{range_check_ptr}(
    preswap_top_stack_element: Uint256,
    preswap_element_at_swap_idx: Uint256,
    swap_idx: felt,
    stack: model.Stack*,
) {
    alloc_locals;
    let (stack, swapped_element) = Stack.peek(stack, 0);
    let (stack, swapped_element_at_swap_idx) = Stack.peek(stack, swap_idx);

    assert_uint256_eq(preswap_top_stack_element, [swapped_element_at_swap_idx]);
    assert_uint256_eq(preswap_element_at_swap_idx, [swapped_element]);
    return ();
}

@external
func test__util_init_stack__should_create_stack_with_top_and_preswapped_elements{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_idx: Uint256 = Uint256(1, 0);
    let length_of_stack_indexed_from_zero = 15;

    // When
    let stack: model.Stack* = init_stack(
        stack_len=length_of_stack_indexed_from_zero,
        swap_idx=15,
        swap_idx_element=preswap_element_at_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    // Then
    let (stack, top_element) = Stack.peek(stack, 0);
    let (stack, element_at_swap_idx) = Stack.peek(stack, 15);

    assert stack.size = length_of_stack_indexed_from_zero + 1;
    assert_uint256_eq([top_element], top_stack_element);
    assert_uint256_eq([element_at_swap_idx], preswap_element_at_idx);

    return ();
}

@external
func test__exec_swap1__should_swap_1st_and_2nd{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepped_stack: model.Stack* = init_stack(
        stack_len=1,
        swap_idx=1,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepped_stack
    );

    // When
    let result = ExchangeOperations.exec_swap1(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=1,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap2__should_swap_1st_and_3rd{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=2,
        swap_idx=2,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap2(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=2,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap8__should_swap_1st_and_9th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=8,
        swap_idx=8,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap8(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=8,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap9__should_swap_1st_and_10th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=9,
        swap_idx=9,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap9(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=9,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap10__should_swap_1st_and_11th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=10,
        swap_idx=10,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap10(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=10,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap11__should_swap_1st_and_12th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=11,
        swap_idx=11,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap11(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=11,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap12__should_swap_1st_and_13th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=12,
        swap_idx=12,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap12(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=12,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap13__should_swap_1st_and_14th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=13,
        swap_idx=13,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap13(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=13,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap14__should_swap_1st_and_15th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=14,
        swap_idx=14,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap14(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=14,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap15__should_swap_1st_and_16th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=15,
        swap_idx=15,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap15(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=15,
        stack=result.stack,
    );
    return ();
}

@external
func test__exec_swap16__should_swap_1st_and_17th{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Given
    let (bytecode) = alloc();
    let stack: model.Stack* = Stack.init();
    let top_stack_element: Uint256 = Uint256(2, 0);
    let preswap_element_at_swap_idx: Uint256 = Uint256(1, 0);
    let prepared_stack: model.Stack* = init_stack(
        stack_len=16,
        swap_idx=16,
        swap_idx_element=preswap_element_at_swap_idx,
        top_stack_element=top_stack_element,
        stack=stack,
    );

    let ctx: model.ExecutionContext* = TestHelpers.init_context_with_stack(
        0, bytecode, prepared_stack
    );

    // When
    let result = ExchangeOperations.exec_swap16(ctx);

    // Then
    assert_stack_is_swapped(
        preswap_top_stack_element=top_stack_element,
        preswap_element_at_swap_idx=preswap_element_at_swap_idx,
        swap_idx=16,
        stack=result.stack,
    );
    return ();
}
