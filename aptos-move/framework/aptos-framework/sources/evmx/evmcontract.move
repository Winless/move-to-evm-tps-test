module aptos_framework::evmx {
    use std::vector;
    use std::signer;
    use aptos_std::simple_map;
    use aptos_std::simple_map::SimpleMap;
    use aptos_std::debug;
    use aptos_std::aptos_hash::keccak256;
    use aptos_framework::event::EventHandle;
    use aptos_framework::account::new_event_handle;
    use aptos_framework::event;
    use aptos_framework::timestamp::now_microseconds;
    use aptos_framework::evmx_storage;
    use aptos_framework::evmx_util::{checkCaller};
    use aptos_framework::block;
    use aptos_framework::transaction_fee;

    const INVALID_SENDER: u64 = 1;
    const INVALID_SIGNER: u64 = 2;

    const CONTRACT_DEPLOYED: u64 = 100;
    const CONTRACT_READ_ONLY: u64 = 101;
    const CALL_CONTRACT_NOT_EXIST: u64 = 102;
    const U256_MAX: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
    const U255_MAX: u256 = 57896044618658097711785492504343953926634992332820282019728792003956564819967;
    const ZERO_BYTES: vector<u8> = x"0000000000000000000000000000000000000000000000000000000000000000";
    struct Log3Event has drop, store {
        contract: vector<u8>,
        data: vector<u8>,
        topic0: vector<u8>,
        topic1: vector<u8>,
        topic2: vector<u8>
    }

    struct Log1Event has drop, store {
        contract: vector<u8>,
        data: vector<u8>,
        topic0: vector<u8>
    }

    struct Log2Event has drop, store {
        contract: vector<u8>,
        data: vector<u8>,
        topic0: vector<u8>,
        topic1: vector<u8>
    }

    struct RevertEvent has drop, store {
        contract: vector<u8>,
        data: vector<u8>
    }

    struct T has key, store {
        storage: SimpleMap<u256, vector<u8>>,
        runtime: vector<u8>
    }

    struct S has key {
        contracts: simple_map::SimpleMap<vector<u8>, T>,
        log1Event: EventHandle<Log1Event>,
        log2Event: EventHandle<Log2Event>,
        log3Event: EventHandle<Log3Event>,
        revertEvent: EventHandle<RevertEvent>
    }

    entry fun init_module(account: &signer) {
        move_to(account, S {
            contracts: simple_map::create<vector<u8>, T>(),
            log1Event: new_event_handle<Log1Event>(account),
            log2Event: new_event_handle<Log2Event>(account),
            log3Event: new_event_handle<Log3Event>(account),
            revertEvent: new_event_handle<RevertEvent>(account)
        });
    }

    public fun deploy(account: &signer, sender: vector<u8>, nonce: u256, construct: vector<u8>, value: u256): vector<u8> acquires S {
        checkCaller(account);
        assert!(vector::length(&sender) == 32, INVALID_SENDER);
        // todo verify caller
        let _account_addr = signer::address_of(account);
        create(sender, nonce, construct, value)
    }


    fun create(sender: vector<u8>, nonce: u256, construct: vector<u8>, value: u256): vector<u8> acquires S {
        let global = borrow_global_mut<S>(@aptos_framework);

        let bytes = copy sender;
        vector::append(&mut bytes, u256_to_data(nonce));
        let contract_addr = to_32bit(slice(keccak256(bytes), 12, 20));
        assert!(!simple_map::contains_key(&global.contracts, &contract_addr), CONTRACT_DEPLOYED);
        simple_map::add(&mut global.contracts, contract_addr, T {
            storage: simple_map::create<u256, vector<u8>>(),
            runtime: x""
        });

        let runtime = run(global, sender, contract_addr, construct, x"", false, value);
        simple_map::borrow_mut<vector<u8>, T>(&mut global.contracts, &contract_addr).runtime = runtime;
        contract_addr
    }

    public fun call(account: &signer, sender: vector<u8>, contract_addr: vector<u8>, data: vector<u8>, value: u256) acquires S {
        checkCaller(account);
        let global = borrow_global_mut<S>(@aptos_framework);
        assert!(vector::length(&sender) == 32, INVALID_SENDER);
        if(simple_map::contains_key(&global.contracts, &contract_addr)) {
            let contract = simple_map::borrow<vector<u8>, T>(&global.contracts, &contract_addr);
            run(global, sender, copy contract_addr, contract.runtime, data, false, value);
        };
    }

    #[view]
    public fun view(sender:vector<u8>, contract_addr: vector<u8>, data: vector<u8>): vector<u8> acquires S {
        let global = borrow_global_mut<S>(@aptos_framework);
        let contract = simple_map::borrow<vector<u8>, T>(&global.contracts, &contract_addr);
        run(global, sender, copy contract_addr, contract.runtime, data, true, 0)
    }

    fun run(global: &mut S, sender: vector<u8>, contract_addr: vector<u8>, code: vector<u8>, data: vector<u8>, readOnly: bool, value: u256): vector<u8> {
        let stack = &mut vector::empty<u256>();
        let memory = &mut vector::empty<u8>();
        let storage = simple_map::borrow_mut<vector<u8>, T>(&mut global.contracts, &contract_addr).storage;
        let len = vector::length(&code);
        let runtime_code = vector::empty<u8>();
        let i = 0;
        let ret_size = 0;
        let ret_bytes = vector::empty<u8>();
        // simple_map::upsert(&mut storage, 13579, x"3334432345");
        // debug::print(global);
        // debug::print(&simple_map::borrow_mut<vector<u8>, T>(&mut global.contracts, &contract_addr).storage);
        // debug::print(&storage);

        // if(contract_addr == )
        // assert!(!table::contains(&borrow_global<S>(@aptos_framework).contracts, x"9af22717a50e9a1650a2af5bee362cc197f340b1"), CONTRACT_DEPLOYED);
        // debug::print(table::borrow(&borrow_global<S>(@aptos_framework).contracts, x"9af22717a50e9a1650a2af5bee362cc197f340b1"));

        while (i < len) {
            let opcode = *vector::borrow(&code, i);
            // debug::print(&i);
            // debug::print(&opcode);
            // stop
            if(opcode == 0x00) {
                ret_bytes = runtime_code;
                break
            }
            else if(opcode == 0xf3) {
                let pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                // move_ret = read_bytes(*memory, pos, end);
                ret_bytes = slice(*memory, pos, len);
                break
            }
            //add
            else if(opcode == 0x01) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                if(a > 0 && b > (U256_MAX - a + 1)) {
                    vector::push_back(stack, b - (U256_MAX - a + 1));
                } else {
                    vector::push_back(stack, a + b);
                };
                i = i + 1;
            }
            //mul
            else if(opcode == 0x02) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                vector::push_back(stack, a * b);
                i = i + 1;
            }
            //sub
            else if(opcode == 0x03) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                if(a >= b) {
                    vector::push_back(stack, a - b);
                } else {
                    vector::push_back(stack, U256_MAX - b + a + 1);
                };
                i = i + 1;
            }
            //div && sdiv
            else if(opcode == 0x04 || opcode == 0x05) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                vector::push_back(stack, a / b);
                i = i + 1;
            }
            //mod && smod
            else if(opcode == 0x06 || opcode == 0x07) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                vector::push_back(stack, a % b);
                i = i + 1;
            }
            //exp
            else if(opcode == 0x0a) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                vector::push_back(stack, power(a, b));
                i = i + 1;
            }
            //lt
            else if(opcode == 0x10) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                if(a < b) {
                    vector::push_back(stack, 1)
                } else {
                    vector::push_back(stack, 0)
                };
                i = i + 1;
            }
            //gt
            else if(opcode == 0x11) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                if(a > b) {
                    vector::push_back(stack, 1)
                } else {
                    vector::push_back(stack, 0)
                };
                i = i + 1;
            }
            //slt
            else if(opcode == 0x12) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                let(sg_a, num_a) = to_int256(a);
                let(sg_b, num_b) = to_int256(b);
                let value = 0;
                if((sg_a && !sg_b) || (sg_a && sg_b && num_a > num_b) || (!sg_a && !sg_b && num_a < num_b)) {
                    value = 1
                };
                vector::push_back(stack, value);
                i = i + 1;
            }
            //sgt
            else if(opcode == 0x13) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                let(sg_a, num_a) = to_int256(a);
                let(sg_b, num_b) = to_int256(b);
                let value = 1;
                if((sg_a && !sg_b) || (sg_a && sg_b && num_a > num_b) || (!sg_a && !sg_b && num_a < num_b)) {
                    value = 0
                };
                vector::push_back(stack, value);
                i = i + 1;
            }
            //eq
            else if(opcode == 0x14) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                if(a == b) {
                    vector::push_back(stack, 1);
                } else {
                    vector::push_back(stack, 0);
                };
                i = i + 1;
            }
            //and
            else if(opcode == 0x16) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                vector::push_back(stack, a & b);
                i = i + 1;
            }
            //or
            else if(opcode == 0x17) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                vector::push_back(stack, a | b);
                i = i + 1;
            }
            //xor
            else if(opcode == 0x18) {
                let a = vector::pop_back(stack);
                let b = vector::pop_back(stack);
                vector::push_back(stack, a ^ b);
                i = i + 1;
            }
            //not
            else if(opcode == 0x19) {
                // 10 1010
                // 6 0101
                let n = vector::pop_back(stack);
                vector::push_back(stack, U256_MAX - n);
                i = i + 1;
            }
            //shl
            else if(opcode == 0x1b) {
                let b = vector::pop_back(stack);
                let a = vector::pop_back(stack);
                vector::push_back(stack, a << (b as u8));
                i = i + 1;
            }
            //shr
            else if(opcode == 0x1c) {
                let b = vector::pop_back(stack);
                let a = vector::pop_back(stack);
                vector::push_back(stack, a >> (b as u8));
                i = i + 1;
            }
            //push0
            else if(opcode == 0x5f) {
                vector::push_back(stack, 0);
                i = i + 1;
            }
            // push1 -> push32
            else if(opcode >= 0x60 && opcode <= 0x7f)  {
                let n = ((opcode - 0x60) as u64);
                let number = data_to_u256(code, ((i + 1) as u256), ((n + 1) as u256));
                vector::push_back(stack, (number as u256));
                i = i + n + 2;
            }
            // pop
            else if(opcode == 0x50) {
                vector::pop_back(stack);
                i = i + 1
            }
            //address
            else if(opcode == 0x30) {
                vector::push_back(stack, data_to_u256(contract_addr, 0, 32));
                i = i + 1;
            }
            //balance
            else if(opcode == 0x31) {
                // let addr = u256_to_data(vector::pop_back(stack));
                // let bal = evmx_storage::getBal(addr);
                vector::push_back(stack,0 );
                i = i + 1;
            }
            //caller
            else if(opcode == 0x33) {
                // debug::print(&utf8(b"caller"));
                // debug::print(&sender);
                let value = data_to_u256(sender, 0, 32);

                // debug::print(&value);
                vector::push_back(stack, value);
                i = i + 1;
            }
            // callvalue
            else if(opcode == 0x34) {
                vector::push_back(stack, value);
                i = i + 1;
            }
            //calldataload
            else if(opcode == 0x35) {
                let pos = vector::pop_back(stack);
                vector::push_back(stack, data_to_u256(data, pos, 32));
                i = i + 1;
                // block.
            }
            //calldatasize
            else if(opcode == 0x36) {
                vector::push_back(stack, (vector::length(&data) as u256));
                i = i + 1;
            }
            //calldatacopy
            else if(opcode == 0x37) {
                let m_pos = vector::pop_back(stack);
                let d_pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let end = d_pos + len;
                // debug::print(&utf8(b"calldatacopy"));
                // debug::print(&data);
                while (d_pos < end) {
                    // debug::print(&d_pos);
                    // debug::print(&end);
                    let bytes = if(end - d_pos >= 32) {
                        slice(data, d_pos, 32)
                    } else {
                        slice(data, d_pos, end - d_pos)
                    };
                    // debug::print(&bytes);
                    mstore(memory, m_pos, bytes);
                    d_pos = d_pos + 32;
                    m_pos = m_pos + 32;
                };
                i = i + 1
            }
            //codesize
            else if(opcode == 0x38) {
                vector::push_back(stack, (vector::length(&code) as u256));
                i = i + 1
            }
            //codecopy
            else if(opcode == 0x39) {
                let m_pos = vector::pop_back(stack);
                let d_pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let end = d_pos + len;
                runtime_code = slice(code, d_pos, len);
                while (d_pos < end) {
                    let bytes = if(end - d_pos >= 32) {
                        slice(code, d_pos, 32)
                    } else {
                        slice(code, d_pos, end - d_pos)
                    };
                    mstore(memory, m_pos, bytes);
                    d_pos = d_pos + 32;
                    m_pos = m_pos + 32;
                };
                i = i + 1
            }
            //extcodesize
            else if(opcode == 0x3b) {
                let addr = to_32bit(u256_to_data(vector::pop_back(stack)));
                // debug::print(&addr);
                if(simple_map::contains_key(&mut global.contracts, &addr)) {
                    let code = simple_map::borrow_mut<vector<u8>, T>(&mut global.contracts, &addr).runtime;
                    vector::push_back(stack, (vector::length(&code) as u256));
                } else {
                    vector::push_back(stack, 0);
                };

                i = i + 1;
            }
            //returndatacopy
            else if(opcode == 0x3e) {
                // mstore()
                let m_pos = vector::pop_back(stack);
                let d_pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let bytes = slice(ret_bytes, d_pos, len);
                mstore(memory, m_pos, bytes);
                i = i + 1;
            }
            //returndatasize
            else if(opcode == 0x3d) {
                vector::push_back(stack, ret_size);
                i = i + 1;
            }
            //blockhash
            else if(opcode == 0x40) {
                vector::push_back(stack, 0);
                i = i + 1;
            }
            //coinbase
            else if(opcode == 0x41) {
                vector::push_back(stack, 0);
                i = i + 1;
            }
            //timestamp
            else if(opcode == 0x42) {
                vector::push_back(stack, (now_microseconds() as u256) / 1000000);
                i = i + 1;
            }
            //number
            else if(opcode == 0x43) {
                vector::push_back(stack, (block::get_current_block_height() as u256));
                i = i + 1;
            }
            //difficulty
            else if(opcode == 0x44) {
                vector::push_back(stack, 0);
                i = i + 1;
            }
            //gaslimit
            else if(opcode == 0x44) {
                vector::push_back(stack, 30000000);
                i = i + 1;
            }
            //chainid
            else if(opcode == 0x46) {
                vector::push_back(stack, 1);
                i = i + 1
            }
            // mload
            else if(opcode == 0x51) {
                let pos = vector::pop_back(stack);
                vector::push_back(stack, data_to_u256(slice(*memory, pos, 32), 0, 32));
                i = i + 1;
            }
            // mstore
            else if(opcode == 0x52) {
                let pos = vector::pop_back(stack);
                let value = vector::pop_back(stack);
                mstore(memory, pos, u256_to_data(value));
                i = i + 1;

            }
            // sload
            else if(opcode == 0x54) {
                let pos = vector::pop_back(stack);
                if(simple_map::contains_key(&mut storage, &pos)) {
                    let value = *simple_map::borrow(&mut storage, &pos);
                    vector::push_back(stack, data_to_u256(value, 0, 32));
                } else {
                    vector::push_back(stack, 0);
                };
                i = i + 1;
            }
            // sstore
            else if(opcode == 0x55) {
                if(readOnly) {
                    assert!(false, CONTRACT_READ_ONLY);
                };
                let pos = vector::pop_back(stack);
                let value = vector::pop_back(stack);
                simple_map::upsert(&mut storage, pos, u256_to_data(value));
                // debug::print(&utf8(b"sstore"));
                // debug::print(&pos);
                // debug::print(&value);
                i = i + 1;
            }
            //dup1 -> dup16
            else if(opcode >= 0x80 && opcode <= 0x8f) {
                let size = vector::length(stack);
                let value = *vector::borrow(stack, size - ((opcode - 0x80 + 1) as u64));
                vector::push_back(stack, value);
                i = i + 1;
            }
            //swap1 -> swap16
            else if(opcode >= 0x90 && opcode <= 0x9f) {
                let size = vector::length(stack);
                vector::swap(stack, size - 1, size - ((opcode - 0x90 + 2) as u64));
                i = i + 1;
            }
            //iszero
            else if(opcode == 0x15) {
                let value = vector::pop_back(stack);
                if(value == 0) {
                    vector::push_back(stack, 1)
                } else {
                    vector::push_back(stack, 0)
                };
                i = i + 1;
            }
            //jump
            else if(opcode == 0x56) {
                let dest = vector::pop_back(stack);
                i = (dest as u64) + 1
            }
            //jumpi
            else if(opcode == 0x57) {
                let dest = vector::pop_back(stack);
                let condition = vector::pop_back(stack);
                if(condition > 0) {
                    i = (dest as u64) + 1
                } else {
                    i = i + 1
                }
            }
            //gas
            else if(opcode == 0x5a) {
                vector::push_back(stack, 0);
                i = i + 1
            }
            //jump dest (no action, continue execution)
            else if(opcode == 0x5b) {
                i = i + 1
            }
            //sha3
            else if(opcode == 0x20) {
                let pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let bytes = slice(*memory, pos, len);
                let value = data_to_u256(keccak256(bytes), 0, 32);
                vector::push_back(stack, value);
                i = i + 1
            }
            //call 0xf1 static call 0xfa
            else if(opcode == 0xf1 || opcode == 0xfa) {
                let readOnly = if(opcode == 0xf1) false else true;
                let _gas = vector::pop_back(stack);
                let dest_addr = to_32bit(u256_to_data(vector::pop_back(stack)));
                let msg_value = if(opcode == 0xf1) vector::pop_back(stack) else 0;
                let m_pos = vector::pop_back(stack);
                let m_len = vector::pop_back(stack);
                let ret_pos = vector::pop_back(stack);
                let ret_len = vector::pop_back(stack);

                if(simple_map::contains_key(&global.contracts, &dest_addr)) {

                    let ret_end = ret_len + ret_pos;
                    let params = slice(*memory, m_pos, m_len);
                    let runtime = simple_map::borrow(&mut global.contracts, &dest_addr).runtime;

                    ret_bytes = run(global, copy contract_addr, dest_addr, runtime, params, readOnly, msg_value);
                    ret_size = (vector::length(&ret_bytes) as u256);
                    let index = 0;
                    while (ret_pos < ret_end) {
                        let bytes = if(ret_end - ret_pos >= 32) {
                            slice(ret_bytes, index, 32)
                        } else {
                            slice(ret_bytes, index, ret_end - ret_pos)
                        };
                        mstore(memory, ret_pos, bytes);
                        ret_pos = ret_pos + 32;
                        index = index + 32;
                    };
                    vector::push_back(stack, 1);
                } else {
                    if(opcode == 0xfa) {
                        vector::push_back(stack, 0);
                    } else {
                        assert!(false, CALL_CONTRACT_NOT_EXIST);
                    }

                };
                i = i + 1
            }
            //create2
            else if(opcode == 0xf5) {
                if(readOnly) {
                    assert!(false, CONTRACT_READ_ONLY);
                };
                let msg_value = vector::pop_back(stack);
                let pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let salt = u256_to_data(vector::pop_back(stack));
                let new_codes = slice(*memory, pos, len);
                let p = vector::empty<u8>();
                vector::append(&mut p, x"ff");
                // must be 20 bytes
                vector::append(&mut p, slice(contract_addr, 12, 20));
                vector::append(&mut p, salt);
                vector::append(&mut p, keccak256(new_codes));
                let new_contract_addr = to_32bit(slice(keccak256(p), 12, 20));
                // let contracts = &mut borrow_global_mut<S>(@aptos_framework).contracts;
                assert!(!simple_map::contains_key(&mut global.contracts, &new_contract_addr), CONTRACT_DEPLOYED);
                simple_map::add(&mut global.contracts, new_contract_addr,  T {
                    storage: simple_map::create<u256, vector<u8>>(),
                    runtime: x""
                });
                // debug::print(&utf8(b"create2 start"));
                // debug::print(&p);
                // debug::print(&new_codes);
                // debug::print(&new_contract_addr);
                let runtime = run(global, copy contract_addr, new_contract_addr, new_codes, x"", false, msg_value);
                // debug::print(&utf8(b"create2 end"));
                ret_size = 32;
                ret_bytes = contract_addr;
                simple_map::borrow_mut<vector<u8>, T>(&mut global.contracts, &new_contract_addr).runtime = runtime;
                vector::push_back(stack, data_to_u256(new_contract_addr,0, 32));
                i = i + 1
            }
            //revert
            else if(opcode == 0xfd) {
                let pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let bytes = slice(*memory, pos, len);
                debug::print(&bytes);
                event::emit_event<RevertEvent>(
                    &mut global.revertEvent,
                    RevertEvent{
                        contract: contract_addr,
                        data: bytes
                    },
                );
                i = i + 1;
                assert!(false, (opcode as u64));
            }
            //log1
            else if(opcode == 0xa1) {
                let pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let data = slice(*memory, pos, len);
                let topic0 = u256_to_data(vector::pop_back(stack));
                event::emit_event<Log1Event>(
                    &mut global.log1Event,
                    Log1Event{
                        contract: contract_addr,
                        data,
                        topic0,
                    },
                );
                i = i + 1
            }
            //log2
            else if(opcode == 0xa2) {
                let pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let data = slice(*memory, pos, len);
                let topic0 = u256_to_data(vector::pop_back(stack));
                let topic1 = u256_to_data(vector::pop_back(stack));
                event::emit_event<Log2Event>(
                    &mut global.log2Event,
                    Log2Event{
                        contract: contract_addr,
                        data,
                        topic0,
                        topic1
                    },
                );
                i = i + 1
            }
            //log3
            else if(opcode == 0xa3) {
                let pos = vector::pop_back(stack);
                let len = vector::pop_back(stack);
                let data = slice(*memory, pos, len);
                let topic0 = u256_to_data(vector::pop_back(stack));
                let topic1 = u256_to_data(vector::pop_back(stack));
                let topic2 = u256_to_data(vector::pop_back(stack));
                event::emit_event<Log3Event>(
                    &mut global.log3Event,
                    Log3Event{
                        contract: contract_addr,
                        data,
                        topic0,
                        topic1,
                        topic2
                    },
                );
                i = i + 1
            }
            else {
                assert!(false, (opcode as u64));
            };
            // debug::print(stack);
            // debug::print(&vector::length(stack));
        };
        simple_map::borrow_mut<vector<u8>, T>(&mut global.contracts, &contract_addr).storage = storage;
        ret_bytes
    }

    fun mstore(memory: &mut vector<u8>, pos: u256, data: vector<u8>) {
        let len_m = vector::length(memory);
        let len_d = vector::length(&data);
        let p = (pos as u64);
        while(len_m < p) {
            vector::push_back(memory, 0);
            len_m = len_m + 1
        };

        let i = 0;
        while (i < len_d) {
            if(len_m <= p + i) {
                vector::push_back(memory, *vector::borrow(&data, i));
                len_m = len_m + 1;
            } else {
                *vector::borrow_mut(memory, p + i) = *vector::borrow(&data, i);
            };

            i = i + 1
        }
    }

    fun power(base: u256, exponent: u256): u256 {
        let result = 1;

        let i = 0;
        while (i < exponent) {
            result = result * base;
            i = i + 1;
        };

        result
    }

    fun slice(data: vector<u8>, pos: u256, size: u256): vector<u8> {
        let s = vector::empty<u8>();
        let i = 0;
        let len = vector::length(&data);
        while (i < size) {
            let p = ((pos + i) as u64);
            if(p >= len) {
                vector::push_back(&mut s, 0);
            } else {
                vector::push_back(&mut s, *vector::borrow(&data, (pos + i as u64)));
            };

            i = i + 1;
        };
        s
    }

    fun read_value(map: simple_map::SimpleMap<u256, vector<u8>>, pos: u256): vector<u8> {
        if(simple_map::contains_key(&map, &pos)) {
            *simple_map::borrow(&map, &pos)
        } else {
            ZERO_BYTES
        }
    }

    fun read_bytes(map: simple_map::SimpleMap<u256, vector<u8>>, pos: u256, end: u256): vector<u8> {
        let bytes = vector::empty<u8>();
        let mod = pos % 32;
        // last bit mod...32, next bit 0 ... mod
        if(mod > 0) {
            let last_bit = slice(read_value(map, pos - mod), mod, 32 - mod);
            vector::append(&mut bytes, last_bit);
            pos = pos + 32 - mod
        };
        while(pos < end) {
            if(simple_map::contains_key(&map, &pos)) {
                let value = simple_map::borrow(&map, &pos);
                if(end - pos < 32) {
                    vector::append(&mut bytes, slice(*value, 0, end - pos));
                } else {
                    vector::append(&mut bytes, *value);
                }

            };
            pos = pos + 32;
        };

        bytes
    }

    fun u256_to_data(num256: u256): vector<u8> {
        let res = vector::empty<u8>();
        let i = 32;
        while(i > 0) {
            i = i - 1;
            let shifted_value = num256 >> (i * 8);
            let byte = ((shifted_value & 0xff) as u8);
            vector::push_back(&mut res, byte);
        };
        res
    }

    fun data_to_u256(data: vector<u8>, p: u256, size: u256): u256 {
        let res = 0;
        let i = 0;
        let len = (vector::length(&data) as u256);
        assert!(size <= 32, 1);
        while (i < size) {
            if(p + i < len) {
                let value = *vector::borrow(&data, ((p + i) as u64));
                res = (res << 8) + (value as u256);
            } else {
                res = res << 8
            };

            i = i + 1;
        };

        res
    }

    fun to_int256(num: u256): (bool, u256) {
        let neg = false;
        if(num > U255_MAX) {
            neg = true;
            num = U256_MAX - num + 1;
        };
        (neg, num)
    }

    fun to_32bit(data: vector<u8>): vector<u8> {
        let bytes = vector::empty<u8>();
        let len = vector::length(&data);
        // debug::print(&len);
        while(len < 32) {
            vector::push_back(&mut bytes, 0);
            len = len + 1
        };
        vector::append(&mut bytes, data);
        bytes
    }

}