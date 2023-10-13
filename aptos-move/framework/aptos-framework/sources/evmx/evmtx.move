module aptos_framework::evmx_tx {
    use aptos_framework::evmx;
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::coin;
    use aptos_framework::evmx::call;
    use aptos_framework::evmx_storage::{createAccount, update, addBalance};
    use aptos_framework::evmx_util::checkCaller;

    const INSUFFICIENT_BALANCE: u64 = 1;
    const INVALID_SIGNER: u64 = 2;
    const INVALID_NONCE: u64 = 3;
    const CONVERT_BASE: u256 = 10000000000;

    const ZERO_ADDR: vector<u8> = x"0000000000000000000000000000000000000000000000000000000000000000";

    // public entry fun sendTx(
    //     account: &signer,
    //     value: u256,
    //     from: vector<u8>,
    //     to: vector<u8>,
    //     nonce: u256,
    //     data: vector<u8>,
    //     gas_fee: u256
    // ) {
    //     checkCaller(account);
    //     coin::transfer<AptosCoin>(account, @aptos_framework, (gas_fee as u64));
    //
    //     let deploy_contract = if (to == ZERO_ADDR) true else false;
    //     createAccount(from, false);
    //
    //     if (deploy_contract) {
    //         let contract_addr = evmx::deploy(account, from, nonce, data, value);
    //         createAccount(contract_addr, true);
    //         to = contract_addr;
    //     } else {
    //         createAccount(to, false);
    //         call(account, from, to, data, value);
    //     };
    //
    //     update(account, from, to, nonce, value, gas_fee * CONVERT_BASE);
    // }
    //
    #[view]
    public fun query(from: vector<u8>, to: vector<u8>, data: vector<u8>): vector<u8> {
        evmx::view(from, to, data)
    }

    public entry fun deposit(account: &signer, amount: u64, to: vector<u8>) {
        // coin::transfer<AptosCoin>(account, to2, amount);
        addBalance(account, to, (amount as u256));
    }

}