
<a name="0x1_evmx_storage"></a>

# Module `0x1::evmx_storage`



-  [Resource `R`](#0x1_evmx_storage_R)
-  [Resource `Account`](#0x1_evmx_storage_Account)
-  [Constants](#@Constants_0)
-  [Function `init_module`](#0x1_evmx_storage_init_module)
-  [Function `create`](#0x1_evmx_storage_create)
-  [Function `createAccount`](#0x1_evmx_storage_createAccount)
-  [Function `update`](#0x1_evmx_storage_update)
-  [Function `addBalance`](#0x1_evmx_storage_addBalance)
-  [Function `getAccount`](#0x1_evmx_storage_getAccount)
-  [Function `getBal`](#0x1_evmx_storage_getBal)
-  [Function `getNonce`](#0x1_evmx_storage_getNonce)


<pre><code><b>use</b> <a href="util.md#0x1_evmx_util">0x1::evmx_util</a>;
<b>use</b> <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map">0x1::simple_map</a>;
</code></pre>



<a name="0x1_evmx_storage_R"></a>

## Resource `R`



<pre><code><b>struct</b> <a href="evmstorage.md#0x1_evmx_storage_R">R</a> <b>has</b> key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>accounts: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_SimpleMap">simple_map::SimpleMap</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmstorage.md#0x1_evmx_storage_Account">evmx_storage::Account</a>&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>total_fee: u256</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x1_evmx_storage_Account"></a>

## Resource `Account`



<pre><code><b>struct</b> <a href="evmstorage.md#0x1_evmx_storage_Account">Account</a> <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>nonce: u256</code>
</dt>
<dd>

</dd>
<dt>
<code>addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>balance: u256</code>
</dt>
<dd>

</dd>
<dt>
<code>is_contract: bool</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="0x1_evmx_storage_INSUFFICIENT_BALANCE"></a>



<pre><code><b>const</b> <a href="evmstorage.md#0x1_evmx_storage_INSUFFICIENT_BALANCE">INSUFFICIENT_BALANCE</a>: u64 = 101;
</code></pre>



<a name="0x1_evmx_storage_INVALID_NONCE"></a>



<pre><code><b>const</b> <a href="evmstorage.md#0x1_evmx_storage_INVALID_NONCE">INVALID_NONCE</a>: u64 = 102;
</code></pre>



<a name="0x1_evmx_storage_init_module"></a>

## Function `init_module`



<pre><code>entry <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_init_module">init_module</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code>entry <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_init_module">init_module</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>) {
    <b>move_to</b>(<a href="account.md#0x1_account">account</a>, <a href="evmstorage.md#0x1_evmx_storage_R">R</a> {
        accounts: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_create">simple_map::create</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmstorage.md#0x1_evmx_storage_Account">Account</a>&gt;(),
        total_fee: 0
    });
}
</code></pre>



</details>

<a name="0x1_evmx_storage_create"></a>

## Function `create`



<pre><code><b>public</b> entry <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_create">create</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_create">create</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>) {
    <b>move_to</b>(<a href="account.md#0x1_account">account</a>, <a href="evmstorage.md#0x1_evmx_storage_R">R</a> {
        accounts: <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_create">simple_map::create</a>&lt;<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <a href="evmstorage.md#0x1_evmx_storage_Account">Account</a>&gt;(),
        total_fee: 0
    });
}
</code></pre>



</details>

<a name="0x1_evmx_storage_createAccount"></a>

## Function `createAccount`



<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_createAccount">createAccount</a>(addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, is_contract: bool)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_createAccount">createAccount</a>(addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, is_contract: bool) <b>acquires</b> <a href="evmstorage.md#0x1_evmx_storage_R">R</a> {
    <b>let</b> <b>global</b> = <b>borrow_global_mut</b>&lt;<a href="evmstorage.md#0x1_evmx_storage_R">R</a>&gt;(@aptos_framework);
    <b>if</b> (!<a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_contains_key">simple_map::contains_key</a>(&<b>global</b>.accounts, &addr)) {
        <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_add">simple_map::add</a>(&<b>mut</b> <b>global</b>.accounts, addr, <a href="evmstorage.md#0x1_evmx_storage_Account">Account</a> {
            nonce: 0,
            addr,
            balance: 0,
            is_contract
        })
    };
}
</code></pre>



</details>

<a name="0x1_evmx_storage_update"></a>

## Function `update`



<pre><code><b>public</b> <b>fun</b> <b>update</b>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, from: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, nonce: u256, value: u256, gas_fee: u256)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <b>update</b>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, from: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, nonce:u256, value: u256, gas_fee: u256) <b>acquires</b> <a href="evmstorage.md#0x1_evmx_storage_R">R</a> {
    checkCaller(<a href="account.md#0x1_account">account</a>);
    <b>let</b> <b>global</b> = <b>borrow_global_mut</b>&lt;<a href="evmstorage.md#0x1_evmx_storage_R">R</a>&gt;(@aptos_framework);
    <b>global</b>.total_fee = <b>global</b>.total_fee + gas_fee;
    <b>let</b> to_account = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>(&<b>mut</b> <b>global</b>.accounts, &<b>to</b>);
    to_account.balance = to_account.balance + value;

    <b>let</b> from_account = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>(&<b>mut</b> <b>global</b>.accounts, &from);
    <b>assert</b>!(from_account.balance &gt;= value + gas_fee, <a href="evmstorage.md#0x1_evmx_storage_INSUFFICIENT_BALANCE">INSUFFICIENT_BALANCE</a>);
    <b>assert</b>!(from_account.nonce == nonce, <a href="evmstorage.md#0x1_evmx_storage_INVALID_NONCE">INVALID_NONCE</a>);

    from_account.balance = from_account.balance - value - gas_fee;
    from_account.nonce = from_account.nonce + 1;
}
</code></pre>



</details>

<a name="0x1_evmx_storage_addBalance"></a>

## Function `addBalance`



<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_addBalance">addBalance</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, amount: u256)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_addBalance">addBalance</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, amount: u256) <b>acquires</b> <a href="evmstorage.md#0x1_evmx_storage_R">R</a> {
    checkCaller(<a href="account.md#0x1_account">account</a>);
    <a href="evmstorage.md#0x1_evmx_storage_createAccount">createAccount</a>(<b>to</b>, <b>false</b>);
    // <b>let</b> <a href="account.md#0x1_account">account</a> = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow_mut">simple_map::borrow_mut</a>(&<b>mut</b> <b>borrow_global_mut</b>&lt;<a href="evmstorage.md#0x1_evmx_storage_R">R</a>&gt;(@aptos_framework).accounts, &<b>to</b>);
    // <a href="account.md#0x1_account">account</a>.balance = <a href="account.md#0x1_account">account</a>.balance + amount;
}
</code></pre>



</details>

<a name="0x1_evmx_storage_getAccount"></a>

## Function `getAccount`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_getAccount">getAccount</a>(addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): (u256, u256)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_getAccount">getAccount</a>(addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): (u256, u256) <b>acquires</b> <a href="evmstorage.md#0x1_evmx_storage_R">R</a> {
    <b>let</b> <a href="account.md#0x1_account">account</a> = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>(&<b>borrow_global</b>&lt;<a href="evmstorage.md#0x1_evmx_storage_R">R</a>&gt;(@aptos_framework).accounts, &addr);
    (<a href="account.md#0x1_account">account</a>.balance, <a href="account.md#0x1_account">account</a>.nonce)
}
</code></pre>



</details>

<a name="0x1_evmx_storage_getBal"></a>

## Function `getBal`



<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_getBal">getBal</a>(addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): u256
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_getBal">getBal</a>(addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;):u256 <b>acquires</b> <a href="evmstorage.md#0x1_evmx_storage_R">R</a> {
    <b>let</b> <a href="account.md#0x1_account">account</a> = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>(&<b>borrow_global</b>&lt;<a href="evmstorage.md#0x1_evmx_storage_R">R</a>&gt;(@aptos_framework).accounts, &addr);
    <a href="account.md#0x1_account">account</a>.balance
}
</code></pre>



</details>

<a name="0x1_evmx_storage_getNonce"></a>

## Function `getNonce`



<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_getNonce">getNonce</a>(addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): u256
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmstorage.md#0x1_evmx_storage_getNonce">getNonce</a>(addr: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;):u256 <b>acquires</b> <a href="evmstorage.md#0x1_evmx_storage_R">R</a> {
    <b>let</b> <a href="account.md#0x1_account">account</a> = <a href="../../aptos-stdlib/doc/simple_map.md#0x1_simple_map_borrow">simple_map::borrow</a>(&<b>borrow_global</b>&lt;<a href="evmstorage.md#0x1_evmx_storage_R">R</a>&gt;(@aptos_framework).accounts, &addr);
    <a href="account.md#0x1_account">account</a>.nonce
}
</code></pre>



</details>


[move-book]: https://aptos.dev/move/book/SUMMARY
