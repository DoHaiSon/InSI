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
\State \% Random source: 
\State $0 \le $ data($N$) $ \le 3$  
\State \% Generate symbols: 
\State $s \leftarrow $ Mod\_type(data) 
\State \% Generate input signal: 
\State $X \leftarrow h^T * s + n$  
\State \% init CMA estimator 
\State $W \leftarrow [0, 0, \ldots, 1, \ldots, 0]$
\State CM $\leftarrow$ abs($X$(1))
\For{$k = L:N$}
    \State $X_k \leftarrow [X(k), X(k-1), \cdots, X(k-L+1)]^{T}$ 
    \State $Y_k \leftarrow X_k^T W$  
    \State $\epsilon \leftarrow [|Y_k|^2 - \text{CM}] \cdot Y_k$  
    \State $W \leftarrow W-\mu \epsilon X^{*}_k$  
    \State $Y \leftarrow [Y; Y_k]$
\EndFor
\State Y\_demod $\leftarrow$ Demod($Y$)    
\State padding\_data $\leftarrow$ data($L$:end)  
\State Err $\leftarrow$ SER / BER / MSE Sig
\State \Return Err
\end{algorithmic}
\end{algorithm}