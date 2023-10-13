
<a name="0x1_util"></a>

# Module `0x1::util`

Utility functions used by the framework modules.


-  [Function `from_bytes`](#0x1_util_from_bytes)
-  [Function `address_from_bytes`](#0x1_util_address_from_bytes)
-  [Specification](#@Specification_0)
    -  [Function `from_bytes`](#@Specification_0_from_bytes)


<pre><code></code></pre>



<a name="0x1_util_from_bytes"></a>

## Function `from_bytes`

Native function to deserialize a type T.

Note that this function does not put any constraint on <code>T</code>. If code uses this function to
deserialized a linear value, its their responsibility that the data they deserialize is
owned.


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="util.md#0x1_util_from_bytes">from_bytes</a>&lt;T&gt;(bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): T
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(<b>friend</b>) <b>native</b> <b>fun</b> <a href="util.md#0x1_util_from_bytes">from_bytes</a>&lt;T&gt;(bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): T;
</code></pre>



</details>

<a name="0x1_util_address_from_bytes"></a>

## Function `address_from_bytes`



<pre><code><b>public</b> <b>fun</b> <a href="util.md#0x1_util_address_from_bytes">address_from_bytes</a>(bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): <b>address</b>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="util.md#0x1_util_address_from_bytes">address_from_bytes</a>(bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): <b>address</b> {
    <a href="util.md#0x1_util_from_bytes">from_bytes</a>(bytes)
}
</code></pre>



</details>

<a name="@Specification_0"></a>

## Specification


<a name="@Specification_0_from_bytes"></a>

### Function `from_bytes`


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="util.md#0x1_util_from_bytes">from_bytes</a>&lt;T&gt;(bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): T
</code></pre>




<pre><code><b>pragma</b> opaque;
<b>aborts_if</b> [abstract] <b>false</b>;
<b>ensures</b> [abstract] result == <a href="util.md#0x1_util_spec_from_bytes">spec_from_bytes</a>&lt;T&gt;(bytes);
</code></pre>




<a name="0x1_util_spec_from_bytes"></a>


<pre><code><b>fun</b> <a href="util.md#0x1_util_spec_from_bytes">spec_from_bytes</a>&lt;T&gt;(bytes: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;): T;
</code></pre>



<a name="0x1_evmx_util"></a>

# Module `0x1::evmx_util`



-  [Constants](#@Constants_0)
-  [Function `checkCaller`](#0x1_evmx_util_checkCaller)
-  [Function `u256_to_data`](#0x1_evmx_util_u256_to_data)
-  [Function `data_to_u256`](#0x1_evmx_util_data_to_u256)


<pre><code></code></pre>



<a name="@Constants_0"></a>

## Constants


<a name="0x1_evmx_util_INVALID_CALLER"></a>



<pre><code><b>const</b> <a href="util.md#0x1_evmx_util_INVALID_CALLER">INVALID_CALLER</a>: u64 = 103;
</code></pre>



<a name="0x1_evmx_util_checkCaller"></a>

## Function `checkCaller`



<pre><code><b>public</b> <b>fun</b> <a href="util.md#0x1_evmx_util_checkCaller">checkCaller</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="util.md#0x1_evmx_util_checkCaller">checkCaller</a>(<a href="account.md#0x1_account">account</a>: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>) {
    // <b>assert</b>!(<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer_address_of">signer::address_of</a>(<a href="account.md#0x1_account">account</a>) == @<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>, <a href="util.md#0x1_evmx_util_INVALID_CALLER">INVALID_CALLER</a>);
}
</code></pre>



</details>

<a name="0x1_evmx_util_u256_to_data"></a>

## Function `u256_to_data`



<pre><code><b>public</b> <b>fun</b> <a href="util.md#0x1_evmx_util_u256_to_data">u256_to_data</a>(num256: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="util.md#0x1_evmx_util_u256_to_data">u256_to_data</a>(num256: u256): <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt; {
    <b>let</b> res = <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_empty">vector::empty</a>&lt;u8&gt;();
    <b>let</b> i = 32;
    <b>while</b>(i &gt; 0) {
        i = i - 1;
        <b>let</b> shifted_value = num256 &gt;&gt; (i * 8);
        <b>let</b> byte = ((shifted_value & 0xff) <b>as</b> u8);
        <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_push_back">vector::push_back</a>(&<b>mut</b> res, byte);
    };
    res
}
</code></pre>



</details>

<a name="0x1_evmx_util_data_to_u256"></a>

## Function `data_to_u256`



<pre><code><b>public</b> <b>fun</b> <a href="util.md#0x1_evmx_util_data_to_u256">data_to_u256</a>(data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, p: u256, size: u256): u256
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="util.md#0x1_evmx_util_data_to_u256">data_to_u256</a>(data: <a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector">vector</a>&lt;u8&gt;, p: u256, size: u256): u256 {
    <b>let</b> res = 0;
    <b>let</b> i = 0;
    <b>let</b> len = (<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_length">vector::length</a>(&data) <b>as</b> u256);
    <b>assert</b>!(size &lt;= 32, 1);
    <b>while</b> (i &lt; size) {
        <b>if</b>(p + i &lt; len) {
            <b>let</b> value = *<a href="../../aptos-stdlib/../move-stdlib/doc/vector.md#0x1_vector_borrow">vector::borrow</a>(&data, ((p + i) <b>as</b> u64));
            res = (res &lt;&lt; 8) + (value <b>as</b> u256);
        } <b>else</b> {
            res = res &lt;&lt; 8
        };

        i = i + 1;
    };

    res
}
</code></pre>



</details>


[move-book]: https://aptos.dev/move/book/SUMMARY
