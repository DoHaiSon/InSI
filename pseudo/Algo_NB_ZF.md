\begin{algorithm}
\caption{Zero Forcing}
\begin{algorithmic}
\State Initialize variables
\State Generate input signal: Y <= $h^T$ * x + n           
\State Estimate channel: $H_{est}$ <= $Y_{pilot}$ ./ $X_{pilot}$
\State Equalization: X <= Y ./ $H_{est}$
\State Compute Error rate
\end{algorithmic}

\end{algorithm}