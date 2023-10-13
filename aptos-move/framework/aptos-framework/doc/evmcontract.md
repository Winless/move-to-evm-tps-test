
<a name="0x1_evmx"></a>

# Module `0x1::evmx`



-  [Struct `Log3Event`](#0x1_evmx_Log3Event)
-  [Struct `Log1Event`](#0x1_evmx_Log1Event)
-  [Struct `Log2Event`](#0x1_evmx_Log2Event)
-  [Struct `RevertEvent`](#0x1_evmx_RevertEvent)
-  [Resource `T`](#0x1_evmx_T)
-  [Resource `S`](#0x1_evmx_S)
-  [Constants](#@Constants_0)
-  [Function `init_module`](#0x1_evmx_init_module)
-  [Function `deploy`](#0x1_evmx_deploy)
-  [Function `create`](#0x1_evmx_create)
-  [Function `call`](#0x1_evmx_call)
-  [Function `view`](#0x1_evmx_view)
-  [Function `run`](#0x1_evmx_run)
-  [Function `mstore`](#0x1_evmx_mstore)
-  [Function `power`](#0x1_evmx_power)
-  [Function `slice`](#0x1_evmx_slice)
-  [Function `read_value`](#0x1_evmx_read_value)
-  [Function `read_bytes`](#0x1_evmx_read_bytes)
-  [Function `to_int256`](#0x1_evmx_to_int256)
-  [Function `to_32bit`](#0x1_evmx_to_32bit)


<pre><code><b>use</b> <a href="account.md#0x1_account">0x1::account</a>;
<b>use</b> <a href="../../aptos-stdlib/../move-stdlib/doc/hash.md#0x1_aptos_hash">0x1::aptos_hash</a>;
<b>use</b> <a href="block.md#0x1_block">0x1::block</a>;
<b>use</b> <a href="../../aptos-stdlib/doc/debug.md#0x1_debug">0x1::debug</a>;
<b>use</b> <a href="event.md#0x1_event">0x1::event</a>;
<b>use</b> <a href="util.md#0x1_evmx_util">0x1::evmx_util</a>;
<b>use</b> <a href="../../aptos-stdlib/../move-stdlib/doc/option.md#0x1_option">0x1::option</a>;
<b>use</b> <a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">0x1::signer</a>;
<b>use</b> <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map">0x1::simple_map</a>;
<b>use</b> <a href="timestamp.md#0x1_timestamp">0x1::timestamp</a>;
<b>use</b> <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">0x1::vector</a>;
</code></pre>



<a name="0x1_evmx_Log3Event"></a>

## Struct `Log3Event`



<pre><code><b>struct</b> <a href="evmcontract.md#0x1_evmx_Log3Event">Log3Event</a> <b>has</b> drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>contract: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>topic0: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>topic1: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>topic2: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x1_evmx_Log1Event"></a>

## Struct `Log1Event`



<pre><code><b>struct</b> <a href="evmcontract.md#0x1_evmx_Log1Event">Log1Event</a> <b>has</b> drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>contract: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>topic0: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x1_evmx_Log2Event"></a>

## Struct `Log2Event`



<pre><code><b>struct</b> <a href="evmcontract.md#0x1_evmx_Log2Event">Log2Event</a> <b>has</b> drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>contract: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>topic0: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>topic1: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x1_evmx_RevertEvent"></a>

## Struct `RevertEvent`



<pre><code><b>struct</b> <a href="evmcontract.md#0x1_evmx_RevertEvent">RevertEvent</a> <b>has</b> drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>contract: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x1_evmx_T"></a>

## Resource `T`



<pre><code><b>struct</b> <a href="evmcontract.md#0x1_evmx_T">T</a> <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>storage: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_SimpleMap">simple_map::SimpleMap</a>&lt;u256, <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>runtime: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x1_evmx_S"></a>

## Resource `S`



<pre><code><b>struct</b> <a href="evmcontract.md#0x1_evmx_S">S</a> <b>has</b> key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>contracts: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_SimpleMap">simple_map::SimpleMap</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">evmx::T</a>&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>log1Event: <a href="event.md#0x1_event_EventHandle">event::EventHandle</a>&lt;<a href="evmcontract.md#0x1_evmx_Log1Event">evmx::Log1Event</a>&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>log2Event: <a href="event.md#0x1_event_EventHandle">event::EventHandle</a>&lt;<a href="evmcontract.md#0x1_evmx_Log2Event">evmx::Log2Event</a>&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>log3Event: <a href="event.md#0x1_event_EventHandle">event::EventHandle</a>&lt;<a href="evmcontract.md#0x1_evmx_Log3Event">evmx::Log3Event</a>&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>revertEvent: <a href="event.md#0x1_event_EventHandle">event::EventHandle</a>&lt;<a href="evmcontract.md#0x1_evmx_RevertEvent">evmx::RevertEvent</a>&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="0x1_evmx_CALL_CONTRACT_NOT_EXIST"></a>



<pre><code><b>const</b> <a href="evmcontract.md#0x1_evmx_CALL_CONTRACT_NOT_EXIST">CALL_CONTRACT_NOT_EXIST</a>: u64 = 102;
</code></pre>



<a name="0x1_evmx_CONTRACT_DEPLOYED"></a>



<pre><code><b>const</b> <a href="evmcontract.md#0x1_evmx_CONTRACT_DEPLOYED">CONTRACT_DEPLOYED</a>: u64 = 100;
</code></pre>



<a name="0x1_evmx_CONTRACT_READ_ONLY"></a>



<pre><code><b>const</b> <a href="evmcontract.md#0x1_evmx_CONTRACT_READ_ONLY">CONTRACT_READ_ONLY</a>: u64 = 101;
</code></pre>



<a name="0x1_evmx_INVALID_SENDER"></a>



<pre><code><b>const</b> <a href="evmcontract.md#0x1_evmx_INVALID_SENDER">INVALID_SENDER</a>: u64 = 1;
</code></pre>



<a name="0x1_evmx_INVALID_SIGNER"></a>



<pre><code><b>const</b> <a href="evmcontract.md#0x1_evmx_INVALID_SIGNER">INVALID_SIGNER</a>: u64 = 2;
</code></pre>



<a name="0x1_evmx_U255_MAX"></a>



<pre><code><b>const</b> <a href="evmcontract.md#0x1_evmx_U255_MAX">U255_MAX</a>: u256 = 57896044618658097711785492504343953926634992332820282019728792003956564819967;
</code></pre>



<a name="0x1_evmx_U256_MAX"></a>



<pre><code><b>const</b> <a href="evmcontract.md#0x1_evmx_U256_MAX">U256_MAX</a>: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
</code></pre>



<a name="0x1_evmx_ZERO_BYTES"></a>



<pre><code><b>const</b> <a href="evmcontract.md#0x1_evmx_ZERO_BYTES">ZERO_BYTES</a>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
</code></pre>



<a name="0x1_evmx_init_module"></a>

## Function `init_module`



<pre><code>entry <b>fun</b> <a href="evmcontract.md#0x1_evmx_init_module">init_module</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code>entry <b>fun</b> <a href="evmcontract.md#0x1_evmx_init_module">init_module</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>) {
    <b>move_to</b>(<a href="account.md#0x1_account">account</a>, <a href="evmcontract.md#0x1_evmx_S">S</a> {
        contracts: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_create">simple_map::create</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(),
        log1Event: new_event_handle&lt;<a href="evmcontract.md#0x1_evmx_Log1Event">Log1Event</a>&gt;(<a href="account.md#0x1_account">account</a>),
        log2Event: new_event_handle&lt;<a href="evmcontract.md#0x1_evmx_Log2Event">Log2Event</a>&gt;(<a href="account.md#0x1_account">account</a>),
        log3Event: new_event_handle&lt;<a href="evmcontract.md#0x1_evmx_Log3Event">Log3Event</a>&gt;(<a href="account.md#0x1_account">account</a>),
        revertEvent: new_event_handle&lt;<a href="evmcontract.md#0x1_evmx_RevertEvent">RevertEvent</a>&gt;(<a href="account.md#0x1_account">account</a>)
    });
}
</code></pre>



</details>

<a name="0x1_evmx_deploy"></a>

## Function `deploy`



<pre><code><b>public</b> <b>fun</b> <a href="evmcontract.md#0x1_evmx_deploy">deploy</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, nonce: u256, construct: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, value: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmcontract.md#0x1_evmx_deploy">deploy</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, nonce: u256, construct: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, value: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; <b>acquires</b> <a href="evmcontract.md#0x1_evmx_S">S</a> {
    checkCaller(<a href="account.md#0x1_account">account</a>);
    <b>assert</b>!(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&sender) == 32, <a href="evmcontract.md#0x1_evmx_INVALID_SENDER">INVALID_SENDER</a>);
    // todo verify caller
    <b>let</b> _account_addr = <a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer_address_of">signer::address_of</a>(<a href="account.md#0x1_account">account</a>);
    <a href="evmcontract.md#0x1_evmx_create">create</a>(sender, nonce, construct, value)
}
</code></pre>



</details>

<a name="0x1_evmx_create"></a>

## Function `create`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_create">create</a>(sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, nonce: u256, construct: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, value: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_create">create</a>(sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, nonce: u256, construct: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, value: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; <b>acquires</b> <a href="evmcontract.md#0x1_evmx_S">S</a> {
    <b>let</b> <b>global</b> = <b>borrow_global_mut</b>&lt;<a href="evmcontract.md#0x1_evmx_S">S</a>&gt;(@aptos_framework);

    <b>let</b> bytes = <b>copy</b> sender;
    <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> bytes, u256_to_data(nonce));
    <b>let</b> contract_addr = <a href="evmcontract.md#0x1_evmx_to_32bit">to_32bit</a>(<a href="evmcontract.md#0x1_evmx_slice">slice</a>(keccak256(bytes), 12, 20));
    <b>assert</b>!(!<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&<b>global</b>.contracts, &contract_addr), <a href="evmcontract.md#0x1_evmx_CONTRACT_DEPLOYED">CONTRACT_DEPLOYED</a>);
    <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_add">simple_map::add</a>(&<b>mut</b> <b>global</b>.contracts, contract_addr, <a href="evmcontract.md#0x1_evmx_T">T</a> {
        storage: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_create">simple_map::create</a>&lt;u256, <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;&gt;(),
        runtime: x""
    });

    <b>let</b> runtime = <a href="evmcontract.md#0x1_evmx_run">run</a>(<b>global</b>, sender, contract_addr, construct, x"", <b>false</b>, value);
    <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(&<b>mut</b> <b>global</b>.contracts, &contract_addr).runtime = runtime;
    contract_addr
}
</code></pre>



</details>

<a name="0x1_evmx_call"></a>

## Function `call`



<pre><code><b>public</b> <b>fun</b> <a href="evmcontract.md#0x1_evmx_call">call</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, contract_addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, value: u256)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmcontract.md#0x1_evmx_call">call</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, contract_addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, value: u256) <b>acquires</b> <a href="evmcontract.md#0x1_evmx_S">S</a> {
    checkCaller(<a href="account.md#0x1_account">account</a>);
    <b>let</b> <b>global</b> = <b>borrow_global_mut</b>&lt;<a href="evmcontract.md#0x1_evmx_S">S</a>&gt;(@aptos_framework);
    <b>assert</b>!(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&sender) == 32, <a href="evmcontract.md#0x1_evmx_INVALID_SENDER">INVALID_SENDER</a>);
    <b>if</b>(<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&<b>global</b>.contracts, &contract_addr)) {
        <b>let</b> contract = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(&<b>global</b>.contracts, &contract_addr);
        <a href="evmcontract.md#0x1_evmx_run">run</a>(<b>global</b>, sender, <b>copy</b> contract_addr, contract.runtime, data, <b>false</b>, value);
    };
}
</code></pre>



</details>

<a name="0x1_evmx_view"></a>

## Function `view`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="evmcontract.md#0x1_evmx_view">view</a>(sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, contract_addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmcontract.md#0x1_evmx_view">view</a>(sender:<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, contract_addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; <b>acquires</b> <a href="evmcontract.md#0x1_evmx_S">S</a> {
    <b>let</b> <b>global</b> = <b>borrow_global_mut</b>&lt;<a href="evmcontract.md#0x1_evmx_S">S</a>&gt;(@aptos_framework);
    <b>let</b> contract = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(&<b>global</b>.contracts, &contract_addr);
    <a href="evmcontract.md#0x1_evmx_run">run</a>(<b>global</b>, sender, <b>copy</b> contract_addr, contract.runtime, data, <b>true</b>, 0)
}
</code></pre>



</details>

<a name="0x1_evmx_run"></a>

## Function `run`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_run">run</a>(<b>global</b>: &<b>mut</b> <a href="evmcontract.md#0x1_evmx_S">evmx::S</a>, sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, contract_addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="code.md#0x1_code">code</a>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, readOnly: bool, value: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_run">run</a>(<b>global</b>: &<b>mut</b> <a href="evmcontract.md#0x1_evmx_S">S</a>, sender: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, contract_addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="code.md#0x1_code">code</a>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, readOnly: bool, value: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; {
    <b>let</b> stack = &<b>mut</b> <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u256&gt;();
    <b>let</b> memory = &<b>mut</b> <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u8&gt;();
    <b>let</b> storage = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(&<b>mut</b> <b>global</b>.contracts, &contract_addr).storage;
    <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&<a href="code.md#0x1_code">code</a>);
    <b>let</b> runtime_code = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u8&gt;();
    <b>let</b> i = 0;
    <b>let</b> ret_size = 0;
    <b>let</b> ret_bytes = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u8&gt;();
    // <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_upsert">simple_map::upsert</a>(&<b>mut</b> storage, 13579, x"3334432345");
    // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(<b>global</b>);
    // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(&<b>mut</b> <b>global</b>.contracts, &contract_addr).storage);
    // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&storage);

    // <b>if</b>(contract_addr == )
    // <b>assert</b>!(!<a href="../../aptos-stdlib/doc/table.md#0x1_table_contains">table::contains</a>(&<b>borrow_global</b>&lt;<a href="evmcontract.md#0x1_evmx_S">S</a>&gt;(@aptos_framework).contracts, x"9af22717a50e9a1650a2af5bee362cc197f340b1"), <a href="evmcontract.md#0x1_evmx_CONTRACT_DEPLOYED">CONTRACT_DEPLOYED</a>);
    // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(<a href="../../aptos-stdlib/doc/table.md#0x1_table_borrow">table::borrow</a>(&<b>borrow_global</b>&lt;<a href="evmcontract.md#0x1_evmx_S">S</a>&gt;(@aptos_framework).contracts, x"9af22717a50e9a1650a2af5bee362cc197f340b1"));

    <b>while</b> (i &lt; len) {
        <b>let</b> opcode = *<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_borrow">vector::borrow</a>(&<a href="code.md#0x1_code">code</a>, i);
        // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&i);
        // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&opcode);
        // stop
        <b>if</b>(opcode == 0x00) {
            ret_bytes = runtime_code;
            <b>break</b>
        }
        <b>else</b> <b>if</b>(opcode == 0xf3) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            // move_ret = <a href="evmcontract.md#0x1_evmx_read_bytes">read_bytes</a>(*memory, pos, end);
            ret_bytes = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, pos, len);
            <b>break</b>
        }
        //add
        <b>else</b> <b>if</b>(opcode == 0x01) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>if</b>(a &gt; 0 && b &gt; (<a href="evmcontract.md#0x1_evmx_U256_MAX">U256_MAX</a> - a + 1)) {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, b - (<a href="evmcontract.md#0x1_evmx_U256_MAX">U256_MAX</a> - a + 1));
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a + b);
            };
            i = i + 1;
        }
        //mul
        <b>else</b> <b>if</b>(opcode == 0x02) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a * b);
            i = i + 1;
        }
        //sub
        <b>else</b> <b>if</b>(opcode == 0x03) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>if</b>(a &gt;= b) {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a - b);
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, <a href="evmcontract.md#0x1_evmx_U256_MAX">U256_MAX</a> - b + a + 1);
            };
            i = i + 1;
        }
        //div && sdiv
        <b>else</b> <b>if</b>(opcode == 0x04 || opcode == 0x05) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a / b);
            i = i + 1;
        }
        //mod && smod
        <b>else</b> <b>if</b>(opcode == 0x06 || opcode == 0x07) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a % b);
            i = i + 1;
        }
        //exp
        <b>else</b> <b>if</b>(opcode == 0x0a) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, <a href="evmcontract.md#0x1_evmx_power">power</a>(a, b));
            i = i + 1;
        }
        //lt
        <b>else</b> <b>if</b>(opcode == 0x10) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>if</b>(a &lt; b) {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 1)
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0)
            };
            i = i + 1;
        }
        //gt
        <b>else</b> <b>if</b>(opcode == 0x11) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>if</b>(a &gt; b) {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 1)
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0)
            };
            i = i + 1;
        }
        //slt
        <b>else</b> <b>if</b>(opcode == 0x12) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b>(sg_a, num_a) = <a href="evmcontract.md#0x1_evmx_to_int256">to_int256</a>(a);
            <b>let</b>(sg_b, num_b) = <a href="evmcontract.md#0x1_evmx_to_int256">to_int256</a>(b);
            <b>let</b> value = 0;
            <b>if</b>((sg_a && !sg_b) || (sg_a && sg_b && num_a &gt; num_b) || (!sg_a && !sg_b && num_a &lt; num_b)) {
                value = 1
            };
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, value);
            i = i + 1;
        }
        //sgt
        <b>else</b> <b>if</b>(opcode == 0x13) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b>(sg_a, num_a) = <a href="evmcontract.md#0x1_evmx_to_int256">to_int256</a>(a);
            <b>let</b>(sg_b, num_b) = <a href="evmcontract.md#0x1_evmx_to_int256">to_int256</a>(b);
            <b>let</b> value = 1;
            <b>if</b>((sg_a && !sg_b) || (sg_a && sg_b && num_a &gt; num_b) || (!sg_a && !sg_b && num_a &lt; num_b)) {
                value = 0
            };
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, value);
            i = i + 1;
        }
        //eq
        <b>else</b> <b>if</b>(opcode == 0x14) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>if</b>(a == b) {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 1);
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
            };
            i = i + 1;
        }
        //and
        <b>else</b> <b>if</b>(opcode == 0x16) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a & b);
            i = i + 1;
        }
        //or
        <b>else</b> <b>if</b>(opcode == 0x17) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a | b);
            i = i + 1;
        }
        //xor
        <b>else</b> <b>if</b>(opcode == 0x18) {
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a ^ b);
            i = i + 1;
        }
        //not
        <b>else</b> <b>if</b>(opcode == 0x19) {
            // 10 1010
            // 6 0101
            <b>let</b> n = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, <a href="evmcontract.md#0x1_evmx_U256_MAX">U256_MAX</a> - n);
            i = i + 1;
        }
        //shl
        <b>else</b> <b>if</b>(opcode == 0x1b) {
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a &lt;&lt; (b <b>as</b> u8));
            i = i + 1;
        }
        //shr
        <b>else</b> <b>if</b>(opcode == 0x1c) {
            <b>let</b> b = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> a = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, a &gt;&gt; (b <b>as</b> u8));
            i = i + 1;
        }
        //push0
        <b>else</b> <b>if</b>(opcode == 0x5f) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
            i = i + 1;
        }
        // push1 -&gt; push32
        <b>else</b> <b>if</b>(opcode &gt;= 0x60 && opcode &lt;= 0x7f)  {
            <b>let</b> n = ((opcode - 0x60) <b>as</b> u64);
            <b>let</b> number = data_to_u256(<a href="code.md#0x1_code">code</a>, ((i + 1) <b>as</b> u256), ((n + 1) <b>as</b> u256));
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, (number <b>as</b> u256));
            i = i + n + 2;
        }
        // pop
        <b>else</b> <b>if</b>(opcode == 0x50) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            i = i + 1
        }
        //<b>address</b>
        <b>else</b> <b>if</b>(opcode == 0x30) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, data_to_u256(contract_addr, 0, 32));
            i = i + 1;
        }
        //balance
        <b>else</b> <b>if</b>(opcode == 0x31) {
            // <b>let</b> addr = u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack));
            // <b>let</b> bal = <a href="evmstorage.md#0x1_evmx_storage_getBal">evmx_storage::getBal</a>(addr);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack,0 );
            i = i + 1;
        }
        //caller
        <b>else</b> <b>if</b>(opcode == 0x33) {
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&utf8(b"caller"));
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&sender);
            <b>let</b> value = data_to_u256(sender, 0, 32);

            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&value);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, value);
            i = i + 1;
        }
        // callvalue
        <b>else</b> <b>if</b>(opcode == 0x34) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, value);
            i = i + 1;
        }
        //calldataload
        <b>else</b> <b>if</b>(opcode == 0x35) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, data_to_u256(data, pos, 32));
            i = i + 1;
            // <a href="block.md#0x1_block">block</a>.
        }
        //calldatasize
        <b>else</b> <b>if</b>(opcode == 0x36) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&data) <b>as</b> u256));
            i = i + 1;
        }
        //calldatacopy
        <b>else</b> <b>if</b>(opcode == 0x37) {
            <b>let</b> m_pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> d_pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> end = d_pos + len;
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&utf8(b"calldatacopy"));
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&data);
            <b>while</b> (d_pos &lt; end) {
                // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&d_pos);
                // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&end);
                <b>let</b> bytes = <b>if</b>(end - d_pos &gt;= 32) {
                    <a href="evmcontract.md#0x1_evmx_slice">slice</a>(data, d_pos, 32)
                } <b>else</b> {
                    <a href="evmcontract.md#0x1_evmx_slice">slice</a>(data, d_pos, end - d_pos)
                };
                // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&bytes);
                <a href="evmcontract.md#0x1_evmx_mstore">mstore</a>(memory, m_pos, bytes);
                d_pos = d_pos + 32;
                m_pos = m_pos + 32;
            };
            i = i + 1
        }
        //codesize
        <b>else</b> <b>if</b>(opcode == 0x38) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&<a href="code.md#0x1_code">code</a>) <b>as</b> u256));
            i = i + 1
        }
        //codecopy
        <b>else</b> <b>if</b>(opcode == 0x39) {
            <b>let</b> m_pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> d_pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> end = d_pos + len;
            runtime_code = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(<a href="code.md#0x1_code">code</a>, d_pos, len);
            <b>while</b> (d_pos &lt; end) {
                <b>let</b> bytes = <b>if</b>(end - d_pos &gt;= 32) {
                    <a href="evmcontract.md#0x1_evmx_slice">slice</a>(<a href="code.md#0x1_code">code</a>, d_pos, 32)
                } <b>else</b> {
                    <a href="evmcontract.md#0x1_evmx_slice">slice</a>(<a href="code.md#0x1_code">code</a>, d_pos, end - d_pos)
                };
                <a href="evmcontract.md#0x1_evmx_mstore">mstore</a>(memory, m_pos, bytes);
                d_pos = d_pos + 32;
                m_pos = m_pos + 32;
            };
            i = i + 1
        }
        //extcodesize
        <b>else</b> <b>if</b>(opcode == 0x3b) {
            <b>let</b> addr = <a href="evmcontract.md#0x1_evmx_to_32bit">to_32bit</a>(u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack)));
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&addr);
            <b>if</b>(<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&<b>mut</b> <b>global</b>.contracts, &addr)) {
                <b>let</b> <a href="code.md#0x1_code">code</a> = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(&<b>mut</b> <b>global</b>.contracts, &addr).runtime;
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&<a href="code.md#0x1_code">code</a>) <b>as</b> u256));
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
            };

            i = i + 1;
        }
        //returndatacopy
        <b>else</b> <b>if</b>(opcode == 0x3e) {
            // <a href="evmcontract.md#0x1_evmx_mstore">mstore</a>()
            <b>let</b> m_pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> d_pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> bytes = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(ret_bytes, d_pos, len);
            <a href="evmcontract.md#0x1_evmx_mstore">mstore</a>(memory, m_pos, bytes);
            i = i + 1;
        }
        //returndatasize
        <b>else</b> <b>if</b>(opcode == 0x3d) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, ret_size);
            i = i + 1;
        }
        //blockhash
        <b>else</b> <b>if</b>(opcode == 0x40) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
            i = i + 1;
        }
        //coinbase
        <b>else</b> <b>if</b>(opcode == 0x41) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
            i = i + 1;
        }
        //<a href="timestamp.md#0x1_timestamp">timestamp</a>
        <b>else</b> <b>if</b>(opcode == 0x42) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, (now_microseconds() <b>as</b> u256) / 1000000);
            i = i + 1;
        }
        //number
        <b>else</b> <b>if</b>(opcode == 0x43) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, (<a href="block.md#0x1_block_get_current_block_height">block::get_current_block_height</a>() <b>as</b> u256));
            i = i + 1;
        }
        //difficulty
        <b>else</b> <b>if</b>(opcode == 0x44) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
            i = i + 1;
        }
        //gaslimit
        <b>else</b> <b>if</b>(opcode == 0x44) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 30000000);
            i = i + 1;
        }
        //chainid
        <b>else</b> <b>if</b>(opcode == 0x46) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 1);
            i = i + 1
        }
        // mload
        <b>else</b> <b>if</b>(opcode == 0x51) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, data_to_u256(<a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, pos, 32), 0, 32));
            i = i + 1;
        }
        // mstore
        <b>else</b> <b>if</b>(opcode == 0x52) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> value = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="evmcontract.md#0x1_evmx_mstore">mstore</a>(memory, pos, u256_to_data(value));
            i = i + 1;

        }
        // sload
        <b>else</b> <b>if</b>(opcode == 0x54) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>if</b>(<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&<b>mut</b> storage, &pos)) {
                <b>let</b> value = *<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>(&<b>mut</b> storage, &pos);
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, data_to_u256(value, 0, 32));
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
            };
            i = i + 1;
        }
        // sstore
        <b>else</b> <b>if</b>(opcode == 0x55) {
            <b>if</b>(readOnly) {
                <b>assert</b>!(<b>false</b>, <a href="evmcontract.md#0x1_evmx_CONTRACT_READ_ONLY">CONTRACT_READ_ONLY</a>);
            };
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> value = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_upsert">simple_map::upsert</a>(&<b>mut</b> storage, pos, u256_to_data(value));
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&utf8(b"sstore"));
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&pos);
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&value);
            i = i + 1;
        }
        //dup1 -&gt; dup16
        <b>else</b> <b>if</b>(opcode &gt;= 0x80 && opcode &lt;= 0x8f) {
            <b>let</b> size = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(stack);
            <b>let</b> value = *<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_borrow">vector::borrow</a>(stack, size - ((opcode - 0x80 + 1) <b>as</b> u64));
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, value);
            i = i + 1;
        }
        //swap1 -&gt; swap16
        <b>else</b> <b>if</b>(opcode &gt;= 0x90 && opcode &lt;= 0x9f) {
            <b>let</b> size = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(stack);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_swap">vector::swap</a>(stack, size - 1, size - ((opcode - 0x90 + 2) <b>as</b> u64));
            i = i + 1;
        }
        //iszero
        <b>else</b> <b>if</b>(opcode == 0x15) {
            <b>let</b> value = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>if</b>(value == 0) {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 1)
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0)
            };
            i = i + 1;
        }
        //jump
        <b>else</b> <b>if</b>(opcode == 0x56) {
            <b>let</b> dest = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            i = (dest <b>as</b> u64) + 1
        }
        //jumpi
        <b>else</b> <b>if</b>(opcode == 0x57) {
            <b>let</b> dest = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> condition = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>if</b>(condition &gt; 0) {
                i = (dest <b>as</b> u64) + 1
            } <b>else</b> {
                i = i + 1
            }
        }
        //gas
        <b>else</b> <b>if</b>(opcode == 0x5a) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
            i = i + 1
        }
        //jump dest (no action, <b>continue</b> execution)
        <b>else</b> <b>if</b>(opcode == 0x5b) {
            i = i + 1
        }
        //sha3
        <b>else</b> <b>if</b>(opcode == 0x20) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> bytes = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, pos, len);
            <b>let</b> value = data_to_u256(keccak256(bytes), 0, 32);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, value);
            i = i + 1
        }
        //call 0xf1 static call 0xfa
        <b>else</b> <b>if</b>(opcode == 0xf1 || opcode == 0xfa) {
            <b>let</b> readOnly = <b>if</b>(opcode == 0xf1) <b>false</b> <b>else</b> <b>true</b>;
            <b>let</b> _gas = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> dest_addr = <a href="evmcontract.md#0x1_evmx_to_32bit">to_32bit</a>(u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack)));
            <b>let</b> msg_value = <b>if</b>(opcode == 0xf1) <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack) <b>else</b> 0;
            <b>let</b> m_pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> m_len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> ret_pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> ret_len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);

            <b>if</b>(<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&<b>global</b>.contracts, &dest_addr)) {

                <b>let</b> ret_end = ret_len + ret_pos;
                <b>let</b> params = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, m_pos, m_len);
                <b>let</b> runtime = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>(&<b>mut</b> <b>global</b>.contracts, &dest_addr).runtime;

                ret_bytes = <a href="evmcontract.md#0x1_evmx_run">run</a>(<b>global</b>, <b>copy</b> contract_addr, dest_addr, runtime, params, readOnly, msg_value);
                ret_size = (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&ret_bytes) <b>as</b> u256);
                <b>let</b> index = 0;
                <b>while</b> (ret_pos &lt; ret_end) {
                    <b>let</b> bytes = <b>if</b>(ret_end - ret_pos &gt;= 32) {
                        <a href="evmcontract.md#0x1_evmx_slice">slice</a>(ret_bytes, index, 32)
                    } <b>else</b> {
                        <a href="evmcontract.md#0x1_evmx_slice">slice</a>(ret_bytes, index, ret_end - ret_pos)
                    };
                    <a href="evmcontract.md#0x1_evmx_mstore">mstore</a>(memory, ret_pos, bytes);
                    ret_pos = ret_pos + 32;
                    index = index + 32;
                };
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 1);
            } <b>else</b> {
                <b>if</b>(opcode == 0xfa) {
                    <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, 0);
                } <b>else</b> {
                    <b>assert</b>!(<b>false</b>, <a href="evmcontract.md#0x1_evmx_CALL_CONTRACT_NOT_EXIST">CALL_CONTRACT_NOT_EXIST</a>);
                }

            };
            i = i + 1
        }
        //create2
        <b>else</b> <b>if</b>(opcode == 0xf5) {
            <b>if</b>(readOnly) {
                <b>assert</b>!(<b>false</b>, <a href="evmcontract.md#0x1_evmx_CONTRACT_READ_ONLY">CONTRACT_READ_ONLY</a>);
            };
            <b>let</b> msg_value = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> salt = u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack));
            <b>let</b> new_codes = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, pos, len);
            <b>let</b> p = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u8&gt;();
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> p, x"ff");
            // must be 20 bytes
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> p, <a href="evmcontract.md#0x1_evmx_slice">slice</a>(contract_addr, 12, 20));
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> p, salt);
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> p, keccak256(new_codes));
            <b>let</b> new_contract_addr = <a href="evmcontract.md#0x1_evmx_to_32bit">to_32bit</a>(<a href="evmcontract.md#0x1_evmx_slice">slice</a>(keccak256(p), 12, 20));
            // <b>let</b> contracts = &<b>mut</b> <b>borrow_global_mut</b>&lt;<a href="evmcontract.md#0x1_evmx_S">S</a>&gt;(@aptos_framework).contracts;
            <b>assert</b>!(!<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&<b>mut</b> <b>global</b>.contracts, &new_contract_addr), <a href="evmcontract.md#0x1_evmx_CONTRACT_DEPLOYED">CONTRACT_DEPLOYED</a>);
            <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_add">simple_map::add</a>(&<b>mut</b> <b>global</b>.contracts, new_contract_addr,  <a href="evmcontract.md#0x1_evmx_T">T</a> {
                storage: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_create">simple_map::create</a>&lt;u256, <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;&gt;(),
                runtime: x""
            });
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&utf8(b"create2 start"));
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&p);
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&new_codes);
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&new_contract_addr);
            <b>let</b> runtime = <a href="evmcontract.md#0x1_evmx_run">run</a>(<b>global</b>, <b>copy</b> contract_addr, new_contract_addr, new_codes, x"", <b>false</b>, msg_value);
            // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&utf8(b"create2 end"));
            ret_size = 32;
            ret_bytes = contract_addr;
            <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(&<b>mut</b> <b>global</b>.contracts, &new_contract_addr).runtime = runtime;
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(stack, data_to_u256(new_contract_addr,0, 32));
            i = i + 1
        }
        //revert
        <b>else</b> <b>if</b>(opcode == 0xfd) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> bytes = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, pos, len);
            <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&bytes);
            <a href="event.md#0x1_event_emit_event">event::emit_event</a>&lt;<a href="evmcontract.md#0x1_evmx_RevertEvent">RevertEvent</a>&gt;(
                &<b>mut</b> <b>global</b>.revertEvent,
                <a href="evmcontract.md#0x1_evmx_RevertEvent">RevertEvent</a>{
                    contract: contract_addr,
                    data: bytes
                },
            );
            i = i + 1;
            <b>assert</b>!(<b>false</b>, (opcode <b>as</b> u64));
        }
        //log1
        <b>else</b> <b>if</b>(opcode == 0xa1) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> data = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, pos, len);
            <b>let</b> topic0 = u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack));
            <a href="event.md#0x1_event_emit_event">event::emit_event</a>&lt;<a href="evmcontract.md#0x1_evmx_Log1Event">Log1Event</a>&gt;(
                &<b>mut</b> <b>global</b>.log1Event,
                <a href="evmcontract.md#0x1_evmx_Log1Event">Log1Event</a>{
                    contract: contract_addr,
                    data,
                    topic0,
                },
            );
            i = i + 1
        }
        //log2
        <b>else</b> <b>if</b>(opcode == 0xa2) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> data = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, pos, len);
            <b>let</b> topic0 = u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack));
            <b>let</b> topic1 = u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack));
            <a href="event.md#0x1_event_emit_event">event::emit_event</a>&lt;<a href="evmcontract.md#0x1_evmx_Log2Event">Log2Event</a>&gt;(
                &<b>mut</b> <b>global</b>.log2Event,
                <a href="evmcontract.md#0x1_evmx_Log2Event">Log2Event</a>{
                    contract: contract_addr,
                    data,
                    topic0,
                    topic1
                },
            );
            i = i + 1
        }
        //log3
        <b>else</b> <b>if</b>(opcode == 0xa3) {
            <b>let</b> pos = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack);
            <b>let</b> data = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*memory, pos, len);
            <b>let</b> topic0 = u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack));
            <b>let</b> topic1 = u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack));
            <b>let</b> topic2 = u256_to_data(<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_pop_back">vector::pop_back</a>(stack));
            <a href="event.md#0x1_event_emit_event">event::emit_event</a>&lt;<a href="evmcontract.md#0x1_evmx_Log3Event">Log3Event</a>&gt;(
                &<b>mut</b> <b>global</b>.log3Event,
                <a href="evmcontract.md#0x1_evmx_Log3Event">Log3Event</a>{
                    contract: contract_addr,
                    data,
                    topic0,
                    topic1,
                    topic2
                },
            );
            i = i + 1
        }
        <b>else</b> {
            <b>assert</b>!(<b>false</b>, (opcode <b>as</b> u64));
        };
        // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(stack);
        // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(stack));
    };
    <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmcontract.md#0x1_evmx_T">T</a>&gt;(&<b>mut</b> <b>global</b>.contracts, &contract_addr).storage = storage;
    ret_bytes
}
</code></pre>



</details>

<a name="0x1_evmx_mstore"></a>

## Function `mstore`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_mstore">mstore</a>(memory: &<b>mut</b> <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, pos: u256, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_mstore">mstore</a>(memory: &<b>mut</b> <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, pos: u256, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;) {
    <b>let</b> len_m = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(memory);
    <b>let</b> len_d = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&data);
    <b>let</b> p = (pos <b>as</b> u64);
    <b>while</b>(len_m &lt; p) {
        <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(memory, 0);
        len_m = len_m + 1
    };

    <b>let</b> i = 0;
    <b>while</b> (i &lt; len_d) {
        <b>if</b>(len_m &lt;= p + i) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(memory, *<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_borrow">vector::borrow</a>(&data, i));
            len_m = len_m + 1;
        } <b>else</b> {
            *<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_borrow_mut">vector::borrow_mut</a>(memory, p + i) = *<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_borrow">vector::borrow</a>(&data, i);
        };

        i = i + 1
    }
}
</code></pre>



</details>

<a name="0x1_evmx_power"></a>

## Function `power`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_power">power</a>(base: u256, exponent: u256): u256
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_power">power</a>(base: u256, exponent: u256): u256 {
    <b>let</b> result = 1;

    <b>let</b> i = 0;
    <b>while</b> (i &lt; exponent) {
        result = result * base;
        i = i + 1;
    };

    result
}
</code></pre>



</details>

<a name="0x1_evmx_slice"></a>

## Function `slice`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_slice">slice</a>(data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, pos: u256, size: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_slice">slice</a>(data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, pos: u256, size: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; {
    <b>let</b> s = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u8&gt;();
    <b>let</b> i = 0;
    <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&data);
    <b>while</b> (i &lt; size) {
        <b>let</b> p = ((pos + i) <b>as</b> u64);
        <b>if</b>(p &gt;= len) {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(&<b>mut</b> s, 0);
        } <b>else</b> {
            <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(&<b>mut</b> s, *<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_borrow">vector::borrow</a>(&data, (pos + i <b>as</b> u64)));
        };

        i = i + 1;
    };
    s
}
</code></pre>



</details>

<a name="0x1_evmx_read_value"></a>

## Function `read_value`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_read_value">read_value</a>(map: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_SimpleMap">simple_map::SimpleMap</a>&lt;u256, <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;&gt;, pos: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_read_value">read_value</a>(map: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_SimpleMap">simple_map::SimpleMap</a>&lt;u256, <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;&gt;, pos: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; {
    <b>if</b>(<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&map, &pos)) {
        *<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>(&map, &pos)
    } <b>else</b> {
        <a href="evmcontract.md#0x1_evmx_ZERO_BYTES">ZERO_BYTES</a>
    }
}
</code></pre>



</details>

<a name="0x1_evmx_read_bytes"></a>

## Function `read_bytes`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_read_bytes">read_bytes</a>(map: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_SimpleMap">simple_map::SimpleMap</a>&lt;u256, <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;&gt;, pos: u256, end: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_read_bytes">read_bytes</a>(map: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_SimpleMap">simple_map::SimpleMap</a>&lt;u256, <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;&gt;, pos: u256, end: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; {
    <b>let</b> bytes = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u8&gt;();
    <b>let</b> mod = pos % 32;
    // last bit mod...32, next bit 0 ... mod
    <b>if</b>(mod &gt; 0) {
        <b>let</b> last_bit = <a href="evmcontract.md#0x1_evmx_slice">slice</a>(<a href="evmcontract.md#0x1_evmx_read_value">read_value</a>(map, pos - mod), mod, 32 - mod);
        <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> bytes, last_bit);
        pos = pos + 32 - mod
    };
    <b>while</b>(pos &lt; end) {
        <b>if</b>(<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&map, &pos)) {
            <b>let</b> value = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>(&map, &pos);
            <b>if</b>(end - pos &lt; 32) {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> bytes, <a href="evmcontract.md#0x1_evmx_slice">slice</a>(*value, 0, end - pos));
            } <b>else</b> {
                <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> bytes, *value);
            }

        };
        pos = pos + 32;
    };

    bytes
}
</code></pre>



</details>

<a name="0x1_evmx_to_int256"></a>

## Function `to_int256`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_to_int256">to_int256</a>(num: u256): (bool, u256)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_to_int256">to_int256</a>(num: u256): (bool, u256) {
    <b>let</b> neg = <b>false</b>;
    <b>if</b>(num &gt; <a href="evmcontract.md#0x1_evmx_U255_MAX">U255_MAX</a>) {
        neg = <b>true</b>;
        num = <a href="evmcontract.md#0x1_evmx_U256_MAX">U256_MAX</a> - num + 1;
    };
    (neg, num)
}
</code></pre>



</details>

<a name="0x1_evmx_to_32bit"></a>

## Function `to_32bit`



<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_to_32bit">to_32bit</a>(data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>fun</b> <a href="evmcontract.md#0x1_evmx_to_32bit">to_32bit</a>(data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; {
    <b>let</b> bytes = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u8&gt;();
    <b>let</b> len = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&data);
    // <a href="../../aptos-stdlib/doc/debug.md#0x1_debug_print">debug::print</a>(&len);
    <b>while</b>(len &lt; 32) {
        <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(&<b>mut</b> bytes, 0);
        len = len + 1
    };
    <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_append">vector::append</a>(&<b>mut</b> bytes, data);
    bytes
}
</code></pre>



</details>


[move-book]: https://aptos.dev/move/book/SUMMARY
