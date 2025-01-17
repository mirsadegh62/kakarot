// SPDX-License-Identifier: MIT

%lang starknet

// Starkware dependencies
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.cairo.common.uint256 import Uint256

// Local dependencies
from utils.utils import Helpers
from kakarot.model import model
from kakarot.stack import Stack
from kakarot.execution_context import ExecutionContext
from kakarot.instructions.duplication_operations import DuplicationOperations
from tests.utils.helpers import TestHelpers

@external
func test__exec_dup1_should_duplicate_1st_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 1, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup1(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 2;
    return ();
}

@external
func test__exec_dup2_should_duplicate_2nd_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 2, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup2(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 3;
    return ();
}

@external
func test__exec_dup3_should_duplicate_3rd_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 3, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup3(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 4;
    return ();
}

@external
func test__exec_dup4_should_duplicate_4th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 4, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup4(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 5;
    return ();
}

@external
func test__exec_dup5_should_duplicate_5th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 5, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup5(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 6;
    return ();
}

@external
func test__exec_dup6_should_duplicate_6th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 6, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup6(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 7;
    return ();
}

@external
func test__exec_dup7_should_duplicate_7th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 7, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup7(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 8;
    return ();
}

@external
func test__exec_dup8_should_duplicate_8th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 8, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup8(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 9;
    return ();
}

@external
func test__exec_dup9_should_duplicate_9th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 9, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup9(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 10;
    return ();
}

@external
func test__exec_dup10_should_duplicate_10th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 10, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup10(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 11;
    return ();
}

@external
func test__exec_dup11_should_duplicate_11th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 11, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup11(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 12;
    return ();
}

@external
func test__exec_dup12_should_duplicate_12th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 12, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup12(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 13;
    return ();
}

@external
func test__exec_dup13_should_duplicate_13th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 13, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup13(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 14;
    return ();
}

@external
func test__exec_dup14_should_duplicate_14th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 14, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup14(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 15;
    return ();
}

@external
func test__exec_dup15_should_duplicate_15th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 15, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup15(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 16;
    return ();
}

@external
func test__exec_dup16_should_duplicate_16th_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, 16, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup16(ctx);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = 17;
    return ();
}

@external
func test__exec_dup_i_should_duplicate_ith_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}() {
    alloc_locals;
    // Test DUP1 -> DUP16
    _test__exec_dup_i_should_duplicate_ith_item_to_top_of_stack(16);
    return ();
}

@external
func _test__exec_dup_i_should_duplicate_ith_item_to_top_of_stack{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}(i: felt) {
    alloc_locals;
    if (i == 0) {
        return ();
    }

    // Given
    let (bytecode) = alloc();
    let stack = Stack.init();
    let start = 1;
    let stack = TestHelpers.push_elements_in_range_to_stack(1, i, stack);

    let ctx = TestHelpers.init_context_with_stack(0, bytecode, stack);

    // When
    let result = DuplicationOperations.exec_dup_i(ctx, i);

    // Then
    assert result.gas_used = DuplicationOperations.GAS_COST_DUP;
    let (stack, top) = Stack.peek(result.stack, 0);
    assert top.low = start;
    assert top.high = 0;
    assert result.stack.size = i + 1;
    return ();
}
