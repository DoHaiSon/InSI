\begin{algorithm}
\caption{Performance analysis: Fast GCRB SIMO}
\begin{algorithmic}
\Require{ 
    \\1. Nr: number of receive antennas
    \\2. L: channel order
    \\3. N: number of samples
    \\4. SNR\_i: signal noise ratio 
}
\Ensure{
    \\1. Err: CRB
}
\\
\State Generate the system for each output $i = 1,\cdots, Nr$: $x_i[n]=\sum_{l=0}^L h_i[l] s[n-l]+w_i[n], \quad n=0, \ldots, N-1$
\State Generate channel in the form of Sylvester matrix: \\  \\
$\mathbf{H}_i \leftarrow \left[\begin{array}{ccccc}
h_i[0] & & & & 0 \\
\vdots & \ddots & & & \\
h_i[L] & & h_i(0) & & \\
& \ddots & & \ddots & \\
0 & & h_i[L] & \cdots & h_i[0]
\end{array}\right]_{N \times N}$ \\ \\
\State Variance of $\mathbf{s}$: sigma2\_s $\leftarrow 1$
\State Variance of $\mathbf{w}$: sigma2\_noise $\leftarrow \text{sigma2\_s}/10^{(\text{SNR\_i}/10)}$
\State Compute approximate FIM: h\_i $\leftarrow$ H\_columns(:, i)$^T$
\State \% Compute $\mathbf{A, C, D}$:
\State sigma2\_noise\_zL $\leftarrow$ [zeros(1, L), sigma2\_noise, zeros(1, L)]
\State $\mathbf{C} \leftarrow$ conv(fliplr(conj(h1)), h1) + conv(fliplr(conj(h2)), h2)
\State $\mathbf{D} \leftarrow$ sigma2\_noise\_zL + sigma2\_s * $\mathbf{C}$
\State $\mathbf{A} \leftarrow$ [conv($\mathbf{D}, \mathbf{D}$), zeros(1, L+1)]
\For{jj = $1,\cdots, 2$}
    \For{ii = $1,\cdots, 2$}
        \For{mm = $0,\cdots, L$}
            \For{ll = $0,\cdots, L$}
                \If{ ii $\neq$ jj}
                    \State tmp $\leftarrow$ [zeros(1, 2*L), b\_nonzero]
                    \State $\mathbf{B} \leftarrow$ -sigma2\_s$^3$/sigma2\_noise * circshift(tmp, -(L+ll-mm))
                \Else 
                    \State tmp $\leftarrow$ [zeros(1, 2*L), b\_nonzero]
                    \State $\mathbf{B} \leftarrow$ -sigma2\_s$^2$/sigma2\_noise * circshift(tmp, -(L+ll-mm))
                \EndIf

                \State Compute residues: [r, p] $\leftarrow$ residue($\mathbf{B}, \mathbf{A}$)
                \State [p\_unique, idx\_unique] $\leftarrow$ unique(p)
                \State r\_unique $\leftarrow$ r(idx\_unique)

                \State Compute FIM: 
                        $\text{approx\_FIM\_hh}((L+1)*(ii-1)+ll+1,  (L+1)*(jj-1)+mm+1)  \leftarrow N*sum(\text{r\_unique}(\operatorname{abs}(\text{p\_unique})<1))$
            \EndFor
        \EndFor
    \EndFor
\EndFor
\State Compute CRB: Err $\leftarrow \operatorname{abs}(\operatorname{trace} (\text{approx\_FIM\_hh}^{-1}))$
\\
\State \Return Err
\end{algorithmic}
\end{algorithm}