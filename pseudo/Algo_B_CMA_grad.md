\begin{algorithm}
\caption{Constant modulus algorithm}
\begin{algorithmic}
\Require{ \\
    1. $N$: number of samples \\
    2. Num\_Ch: number of channels\\
    3. ChL: Channel order\\
    4. Ch\_type: Type of the channel (real, complex, user's input)\\
    5. Mod\_type: Type of modulation (Bin, QPSK, QAM-4)\\
    6. $\mu$: Step size\\
    7. $L$: Length of the CMA filter\\
    8. SNR\_i: signal noise ratio\\
    9. Output\_type: SER / BER / MSE Signal \\
}
\Ensure{\\
    1. Err: SER / BER / MSE Signal 
}
\\ \\
\State Random source: $0 \le $~data($N$)~$ \le $ Mod\_type   
\State Generate symbols:  $\mathbf{s} \leftarrow $ Mod\_type(data) 
\State Generate channel: $\mathbf{h} \leftarrow \text{Generate\_channel(Num\_Ch, ChL, Ch\_type)}$
\State Generate input signal: $\mathbf{x} \leftarrow \mathbf{h}^T * \mathbf{s} + \mathbf{n}$  
\State Initialize CMA equalizer: $\mathbf{w} \leftarrow [0, 0, \ldots, 1, \ldots, 0]$
\State Compute modulus: CM $\leftarrow$ abs($\mathbf{x}$(1))
\For{$k = L:N$}
    \State $\mathbf{x}_k \leftarrow [\mathbf{x}(k), \mathbf{x}(k-1), \cdots, \mathbf{x}(k-L+1)]^{T}$  
    \State $\mathbf{y}_k \leftarrow \mathbf{x}_k^T \mathbf{w}$  
    \State $\epsilon \leftarrow [|\mathbf{y}_k|^2 - \text{CM}] \cdot \mathbf{y}_k$  
    \State $\mathbf{w} \leftarrow \mathbf{w}-\mu \epsilon \mathbf{x}^{*}_k$  
    \State $\mathbf{y} \leftarrow [\mathbf{y}; \mathbf{y}_k]$
\EndFor
\State Y\_demod $\leftarrow$ Demod($Y$)    
\State padding\_data $\leftarrow$ data($L$:end)  
\State Err $\leftarrow$ SER / BER / MSE Sig
\State \Return Err
\end{algorithmic}
\end{algorithm}