
<a name="0x1_evmx_tx"></a>

# Module `0x1::evmx_tx`



-  [Constants](#@Constants_0)
-  [Function `query`](#0x1_evmx_tx_query)
-  [Function `deposit`](#0x1_evmx_tx_deposit)


<pre><code><b>use</b> <a href="evmcontract.md#0x1_evmx">0x1::evmx</a>;
<b>use</b> <a href="evmstorage.md#0x1_evmx_storage">0x1::evmx_storage</a>;
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



<pre><code><b>public</b> entry <b>fun</b> <a href="evmtx.md#0x1_evmx_tx_deposit">deposit</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, amount: u256, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="evmtx.md#0x1_evmx_tx_deposit">deposit</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, amount: u256, <b>to</b>: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;) {
    // <a href="coin.md#0x1_coin_transfer">coin::transfer</a>&lt;AptosCoin&gt;(<a href="account.md#0x1_account">account</a>, to2, amount);
    addBalance(<a href="account.md#0x1_account">account</a>, <b>to</b>, amount);
}
</code></pre>



</details>


[move-book]: https://aptos.dev/move/book/SUMMARY
