\begin{algorithm}
\caption{Naive maximum likelihood estimator}
\begin{algorithmic}
\Require{ 
    \\1. K: block length
    \\2. data\_size: number of sample data
    \\3. Mod\_type: type of modulation (Binary)
    \\4. $\sigma_w$: noise variance
    \\7. SNR\_i: signal noise ratio
}
\Ensure{
    \\1. Err: MSE
}
\\ \\
\State Generate channel parameters: $\bm{\theta}$
\State Compute the received signals: $\mathbf{Y}$
\State Generate the alphabet: $\mathcal{\alpha} \leftarrow \mathrm{Gen\_alphabet}(Mode\_type)$
\State Total square error: $SE \leftarrow 0$
\For{$y$ in $\mathbf{Y}$}
    \State Maximum likelihood estimation from the phase distortion: $\hat{\theta} \leftarrow \mathrm{MLE}(|\angle y - \angle \mathcal{\alpha}|)$
    
    \State Accumulate the square error: $SE \leftarrow SE + \lVert \hat{\theta} - \theta \rVert^2_2 \quad / \quad K$
\EndFor
\State \Return Err $\leftarrow SE / data\_size$
\end{algorithmic}
\end{algorithm}