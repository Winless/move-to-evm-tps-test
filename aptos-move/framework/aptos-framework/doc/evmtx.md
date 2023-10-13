
<a name="0x1_evmx_tx"></a>

# Module `0x1::evmx_tx`



-  [Constants](#@Constants_0)
-  [Function `sendTx`](#0x1_evmx_tx_sendTx)
-  [Function `query`](#0x1_evmx_tx_query)
-  [Function `deposit`](#0x1_evmx_tx_deposit)


<pre><code><b>use</b> <a href="aptos_coin.md#0x1_aptos_coin">0x1::aptos_coin</a>;
<b>use</b> <a href="coin.md#0x1_coin">0x1::coin</a>;
<b>use</b> <a href="evmcontract.md#0x1_evmx">0x1::evmx</a>;
<b>use</b> <a href="evmstorage.md#0x1_evmx_storage">0x1::evmx_storage</a>;
<b>use</b> <a href="util.md#0x1_evmx_util">0x1::evmx_util</a>;
</code></pre>



<a name="@Constants_0"></a>

## Constants


<a name="0x1_evmx_tx_INVALID_SIGNER"></a>



<pre><code><b>const</b> <a href="evmtx.md#0x1_evmx_tx_INVALID_SIGNER">INVALID_SIGNER</a>: u64 = 2;
</code></pre>



<a name="0x1_evmx_tx_INSUFFICIENT_BALANCE"></a>



<pre><code><b>const</b> <a href="evmtx.md#0x1_evmx_tx_INSUFFICIENT_BALANCE">INSUFFICIENT_BALANCE</a>: u64 = 1;
</code></pre>



<a name="0x1_evmx_tx_INVALID_NONCE"></a>



<pre><code><b>const</b> <a href="evmtx.md#0x1_evmx_tx_INVALID_NONCE">INVALID_NONCE</a>: u64 = 3;
</code></pre>



<a name="0x1_evmx_tx_CONVERT_BASE"></a>



<pre><code><b>const</b> <a href="evmtx.md#0x1_evmx_tx_CONVERT_BASE">CONVERT_BASE</a>: u256 = 10000000000;
</code></pre>



<a name="0x1_evmx_tx_ZERO_ADDR"></a>



<pre><code><b>const</b> <a href="evmtx.md#0x1_evmx_tx_ZERO_ADDR">ZERO_ADDR</a>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
</code></pre>



<a name="0x1_evmx_tx_sendTx"></a>

## Function `sendTx`



<pre><code><b>public</b> entry <b>fun</b> <a href="evmtx.md#0x1_evmx_tx_sendTx">sendTx</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, value_bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, from: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, nonce_bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, gas_fee_bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="evmtx.md#0x1_evmx_tx_sendTx">sendTx</a>(
    <a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>,
    value_bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;,
    from: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;,
    <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;,
    nonce_bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;,
    data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;,
    gas_fee_bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
) {
    <b>let</b> value = data_to_u256(value_bytes, 0, (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&value_bytes) <b>as</b> u256));
    <b>let</b> nonce = data_to_u256(nonce_bytes, 0, (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&nonce_bytes) <b>as</b> u256));
    <b>let</b> gas_fee = data_to_u256(gas_fee_bytes, 0, (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&nonce_bytes) <b>as</b> u256));
    checkCaller(<a href="account.md#0x1_account">account</a>);
    <a href="coin.md#0x1_coin_transfer">coin::transfer</a>&lt;AptosCoin&gt;(<a href="account.md#0x1_account">account</a>, @aptos_framework, (gas_fee <b>as</b> u64));

    <b>let</b> deploy_contract = <b>if</b> (<b>to</b> == <a href="evmtx.md#0x1_evmx_tx_ZERO_ADDR">ZERO_ADDR</a>) <b>true</b> <b>else</b> <b>false</b>;
    createAccount(from, <b>false</b>);

    <b>if</b> (deploy_contract) {
        <b>let</b> contract_addr = <a href="evmcontract.md#0x1_evmx_deploy">evmx::deploy</a>(<a href="account.md#0x1_account">account</a>, from, nonce, data, value);
        createAccount(contract_addr, <b>true</b>);
        <b>to</b> = contract_addr;
    } <b>else</b> {
        createAccount(<b>to</b>, <b>false</b>);
        call(<a href="account.md#0x1_account">account</a>, from, <b>to</b>, data, value);
    };

    <b>update</b>(<a href="account.md#0x1_account">account</a>, from, <b>to</b>, nonce, value, gas_fee * <a href="evmtx.md#0x1_evmx_tx_CONVERT_BASE">CONVERT_BASE</a>);
}
</code></pre>



</details>

<a name="0x1_evmx_tx_query"></a>

## Function `query`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="evmtx.md#0x1_evmx_tx_query">query</a>(from: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="evmtx.md#0x1_evmx_tx_query">query</a>(from: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; {
    <a href="evmcontract.md#0x1_evmx_view">evmx::view</a>(from, <b>to</b>, data)
}
</code></pre>



</details>

<a name="0x1_evmx_tx_deposit"></a>

## Function `deposit`



<pre><code><b>public</b> entry <b>fun</b> <a href="evmtx.md#0x1_evmx_tx_deposit">deposit</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, amount_bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="evmtx.md#0x1_evmx_tx_deposit">deposit</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, amount_bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;) {
    <b>let</b> amount = data_to_u256(amount_bytes, 0, (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&amount_bytes) <b>as</b> u256));
    <a href="coin.md#0x1_coin_transfer">coin::transfer</a>&lt;AptosCoin&gt;(<a href="account.md#0x1_account">account</a>, @aptos_framework, ((amount / <a href="evmtx.md#0x1_evmx_tx_CONVERT_BASE">CONVERT_BASE</a>) <b>as</b> u64));
    addBalance(<a href="account.md#0x1_account">account</a>, <b>to</b>, amount);
}
</code></pre>



</details>


[move-book]: https://aptos.dev/move/book/SUMMARY
