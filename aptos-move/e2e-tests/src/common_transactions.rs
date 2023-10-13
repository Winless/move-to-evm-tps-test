// Copyright © Aptos Foundation
// Parts of the project are originally copyright © Meta Platforms, Inc.
// SPDX-License-Identifier: Apache-2.0

//! Support for encoding transactions for common situations.

use crate::account::Account;
use aptos_cached_packages::aptos_stdlib;
use aptos_types::transaction::{EntryFunction, Script, SignedTransaction, TransactionPayload};
use move_ir_compiler::Compiler;
use once_cell::sync::Lazy;
use rand::Rng;
use move_core_types::account_address::AccountAddress;
use move_core_types::ident_str;
use move_core_types::language_storage::ModuleId;

pub static EMPTY_SCRIPT: Lazy<Vec<u8>> = Lazy::new(|| {
    let code = "
    main(account: signer) {
    label b0:
      return;
    }
";
    let modules = aptos_cached_packages::head_release_bundle().compiled_modules();
    let compiler = Compiler {
        deps: modules.iter().collect(),
    };
    compiler.into_script_blob(code).expect("Failed to compile")
});

pub fn empty_txn(
    sender: &Account,
    seq_num: u64,
    max_gas_amount: u64,
    gas_unit_price: u64,
) -> SignedTransaction {
    sender
        .transaction()
        .script(Script::new(EMPTY_SCRIPT.to_vec(), vec![], vec![]))
        .sequence_number(seq_num)
        .max_gas_amount(max_gas_amount)
        .gas_unit_price(gas_unit_price)
        .sign()
}

/// Returns a transaction to create a new account with the given arguments.
pub fn create_account_txn(
    sender: &Account,
    new_account: &Account,
    seq_num: u64,
) -> SignedTransaction {
    sender
        .transaction()
        .payload(aptos_stdlib::aptos_account_create_account(
            *new_account.address(),
        ))
        .sequence_number(seq_num)
        .sign()
}

/// Returns a transaction to transfer coin from one account to another (possibly new) one,
/// with the given arguments. Providing 0 as gas_unit_price generates transactions that
/// don't use an aggregator for total supply tracking (due to logic in coin.move that
/// doesn't generate a delta for total supply when gas is 0).
pub fn peer_to_peer_txn(
    sender: &Account,
    receiver: &Account,
    seq_num: u64,
    transfer_amount: u64,
    gas_unit_price: u64,
) -> SignedTransaction {
    // get a SignedTransaction
    // sender
    //     .transaction()
    //     .payload(aptos_stdlib::aptos_coin_transfer(
    //         *receiver.address(),
    //         transfer_amount,
    //     ))
    //     .sequence_number(seq_num)
    //     .gas_unit_price(gas_unit_price)
    //     .sign()
    // let amount: u256 = transfer_amount as u256;
    // let random_address = generate_random_vector(32);
    sender
        .transaction()
        .payload(TransactionPayload::EntryFunction(EntryFunction::new(
            ModuleId::new(
                AccountAddress::new([
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 1,
                ]),
                ident_str!("evmx_tx").to_owned(),
            ),
            ident_str!("deposit").to_owned(),
            vec![],
            vec![
                 bcs::to_bytes(&transfer_amount).unwrap(),
                 bcs::to_bytes(&generate_random_vector(10)).unwrap()],
        )))
        .sequence_number(seq_num)
        .gas_unit_price(gas_unit_price).max_gas_amount(1_000_000)
        .sign()
}

fn generate_random_vector(size: usize) -> Vec<u8> {
    let mut rng = rand::thread_rng();
    let mut vec = Vec::with_capacity(size);

    for _ in 0..size {
        vec.push(rng.gen::<u8>());
    }

    vec
}

pub fn peer_to_peer_txn_evm(
    sender: &Account,
    receiver: &Account,
    seq_num: u64,
    transfer_amount: u64,
    gas_unit_price: u64,
) -> SignedTransaction {
    // get a SignedTransaction
    let to: Vec<u8> = vec![0x0000000000000000000000000000000000000000000000000000000000000001];
    // let amount: u256 = transfer_amount as u256;
    sender
        .transaction()
        .payload(TransactionPayload::EntryFunction(EntryFunction::new(
            ModuleId::new(
                AccountAddress::new([
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 1,
                ]),
                ident_str!("evmx_tx").to_owned(),
            ),
            ident_str!("deposit").to_owned(),
            vec![],
            vec![bcs::to_bytes(&transfer_amount).unwrap(),
                 // bcs::to_bytes(&receiver.address().to_vec()).unwrap()
                 bcs::to_bytes(&to).unwrap()
            ],
        )))
        .sequence_number(seq_num)
        .gas_unit_price(gas_unit_price)
        .sign()
}