\begin{algorithm}
\caption{Performance analysis: Fisher information neural estimation}
\begin{algorithmic}
\Require{ 
    \\1. K: block length
    \\2. data\_size: number of sample data
    \\3. Mod\_type: type of modulation (Binary, QPSK, QAM-4, QAM-16)
    \\4. $\sigma_w$: noise variance
    \\5. Epochs: number of training epochs
    \\6. lr: learning rate
    \\7. SNR\_i: signal noise ratio
}
\Ensure{
    \\1. Err: BCRB
}
\\ \\
\State Generate channel parameters: $\bm{\theta}$
\State Compute the received signals: $\mathbf{Y}$
\State Divergence estimates: $\mathbf{Div}$
\For{i = 1, $\cdots$,d}
    \For{j = i, $\cdots$,d}
        \State $\delta_i, \delta_j \leftarrow 0.05$
        \State $\mathbf{Div}_{i,j} \leftarrow \mathrm{Divergence\_estimate}(\mathbf{Y}, \bm{\theta}, \bm{\delta})$ 
    \EndFor
\EndFor
\State Compute BFIM: $\mathbf{BFIM} \leftarrow \mathrm{Direct\_evalutation(\mathbf{Div})}$ 
\State Compute BCRB: $\mathbf{BCRB} \leftarrow \mathbf{BFIM}^{-1}$
\State Compute Trace(BCRB): Err $\leftarrow \operatorname{trace}({\mathbf{BCRB}}) / d$
\\
\State \Return Err 
\end{algorithmic}
\end{algorithm}