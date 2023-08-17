\begin{algorithm}
\caption{Demo mode: Beacons settings for indoor localization}
\begin{algorithmic}
\Require{ 
    \\1. epochs: number of training epochs
    \\2. lr: learning rate
    \\3. B1: status on/off of Beacon 1
    \\4. B2: status on/off of Beacon 2
    \\5. B3: status on/off of Beacon 3
    \\6. B4: status on/off of Beacon 4
    \\7. B5: status on/off of Beacon 5
    \\8. B6: status on/off of Beacon 6
    \\9. B7: status on/off of Beacon 7
    \\10. B8: status on/off of Beacon 8
}
\Ensure{
    \\1. Err: BCRB
}
\\ \\
\State Load ray-tracing simulation data from `.mat' file: 
$$
\bm{\theta}, \mathbf{X} \leftarrow \mathrm{Load\_data(B1, B2,\cdots,B8})
$$
\State Using Inf\_FINE to estimate the CRB: 
$$
\mathbf{BCRB} \leftarrow \mathrm{Inf\_FINE}(\bm{\theta}, \mathbf{X}, epochs, lr)
$$
\State Compute CRB on x and y axes: 
$$
\mathrm{BCRB_x}, \mathrm{BCRB_y} \leftarrow \mathrm{diag}(\mathbf{BCRB})
$$
\\
\State \Return Err $\leftarrow \mathrm{BCRB_x}, \mathrm{BCRB_y}$
\end{algorithmic}
\end{algorithm}