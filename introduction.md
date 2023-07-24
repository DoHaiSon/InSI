#
# InSI specifications

Supporting both professional and particular users, this toolbox, thus, is designed for research and development as well as teaching. We target at its easy use and extensive capabilities as follows:

- **Interface**:
    - Interaction: algorithms in telecommunications are often in abstract form and not intuitive for beginners (e.g., students) to understand their input parameters. Therefore, we emphasize visualization in our toolbox. For example, when the user selects a parameter, a corresponding animation will be shown up on the system model so that the user can observe the effect of this parameter. Therefore, for each algorithm, a system model along with its parameter sets and the interactions must be included.
            
    - Independence: 
        - Algorithms: each study often has different assumptions and experiment conditions. Thus, in this toolbox, we divide the chosen algorithms into independent modules, with their proportionate parameter sets, system models, default values, and so forth to bring the results closest to the original study. Furthermore, the separation of algorithms from each other helps to add or remove algorithms without affecting the other algorithms. This module feature is useful for further extensions of  toolbox.
                    
        - Mode: this toolbox has three modes (i.e., performance analysis, algorithms and demo). Since these modes have different operations, interfaces, and running-times,  we separate their source codes independently.
- **Algorithms**:
    - Description: for reproducible research, we add notes about the input/output, and pseudo code of the algorithm (in a separate document) at the top of the functions as per the standard MatLab recommendations [help].
            
    - Example: parameter sets in the experiments of the original paper are added as "default values" and a hands-on example is also provided.
            
    - Reference: the original paper and related works are cited in each  function description.
        
- **InSI_modtool**: The InSI toolbox comes packaged with InSI_modtool, a small GUI utility used to create user-defined algorithms.

- **MatLab support**: we try to use common built-in functions to support older versions of MatLab as much as possible. Most functions are selected to work with MatLab from the R2006 version. However, we recommend using MatLab versions higher than 2014.

# InSI Graphical User Interface (GUI)

## Application architecture

<p style="text-align-last: center">
<img src="./assets/img/InSI_architecture.svg">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI architecture.
</b>
</p>

Based on the above specifications, we separated the toolbox architecture into four layers as shown in figure 1.

- **GUI**: when the toolbox is initialized, the user can choose the Mode, i.e., Algorithms, CRB, or Demo. Each Mode corresponds to the dashboard, input parameters, and output interface.
    
- **Data**: this layer is a bridge between GUI (user) and Algorithms (back-end). The GUI collects input parameters from UI, then combines them into a pre-defined data structure and sends them to the back-end algorithm. After execution, the output of algorithm functions are values of "x" and "y" axes and they are stored in the data layer. Next, the GUI process "Figure options" from the user. It then gets data from the data layer, and finally displays the result figures.
    
- **Algorithms**: Figure 2 presents a dictionary tree of the toolbox. Every algorithm of three Modes is stored in the "Algorithms" folder. They are divided by Mode, model, and each of them is attached with a parameters file. For example, in Figure 2, the function of the CMA algorithm is named "B\_CMA\_adap" stored in the folder Blind Model and Algo Mode. This means this function is a blind channel estimation method, and its version is "adap" which stands for adaptive.

<p style="text-align-last: center">
<img src="./assets/img/InSI_dict.png" width=35%>
</p>
<p style="text-align-last: center">
<b>
Figure 2. Dictionary tree of InSI.
</b>
</p>

## Dashboard interface

<p style="text-align-last: center">
<img src="./assets/img/InSI_dashboard_interface.svg" width=70%>
</p>
<p style="text-align-last: center">
<b>
Figure 3. InSI dashboard.
</b>
</p>

Corresponding to the Modes, the toolbox will show the user a dashboard as shown in Figure 3. This dashboard is divided into five areas as follows:

1. **Menu bar**: this function bar provides small functions such as figure options, select fonts, font size, or help of toolbox. For example, figure options: the user can switch between holding on all results inside a figure or plotting each result inside an individual figure. If non of hold on or subplot option is selected, the results are replaced by the newer result in a single figure.
    
2. **Algorithm's model**: this panel is a dynamic update system model based on the algorithm  in use. Moreover, the system model can also interact with the selecting input parameters.
    
3. **InSI workspace**: the results are not only displayed on the figure but also saved in a separate workspace. In addition, the user can also hide/show the lines on the figure from this workspace.
    
4. **Select model**: the available algorithms/functions is divided into 3 main groups, i.e., Blind/Semi-blind/Non-blind. 
        
5. **Switch Mode button**: the users can switch between Performance/Algorithm/Demo MODE by this button if they miss in the first step.


## Input parameters interface

<p style="text-align-last: center">
<img src="./assets/img/InSI_input_interface.svg" width=70%>
</p>
<p style="text-align-last: center">
<b>
Figure 4. InSI input parameters menu.
</b>
</p>

After selecting the Blind/Semi-blind/Non-blind model in the dashboard interface, the corresponding input parameters GUI will appear as illustrated in Figure 4. This GUI is divided into five areas as follows:

1. **Methods**:  the box on top is the name of the algorithm and the box below is the versions corresponding to the selected algorithm.
    
2. **Parameters**: based on the algorithm and version, pre-defined parameters are displayed in the "Params area". These parameters can appear as a drop-list for the user to select or a box for the user to enter from the keyboard. When the user selects/modifies the value boxes, the dashboard GUI interacts to illustrate that parameter on the algorithm's model. The maximum number of the input parameters is 10.
    
3. **Output types**: the user can choose the type of output (i.e., Symbol error rate (SER), Bit error rate (BER), Mean Square Error Signal (MSE Sig), and Mean Square Error Channel (MSE H)).
    
4. **Execute button**: this button collects all parameters in the Input parameters interface and sends them to the back-end algorithm for processing.

5. **Help button**: this button opens the help document of the selected algorithm.

## Output interface

<p style="text-align-last: center">
<img src="./assets/img/InSI_output.png" width=40%>
</p>
<p style="text-align-last: center">
<b>
Figure 5. InSI output interface.
</b>
</p>

After receiving the results from the back-end algorithms, the toolbox plots/subplots them into a standard MatLab figure as shown in Figure 5. Similar to the standard plot in MatLab, this output is easy to modify. In Figure 5, all results are holding on in a figure that permits to compare the performance between the algorithms. On the other hand, separated figure mode divides the results into different figures.

## InSI_modtool interface

<p style="text-align-last: center">
<img src="./assets/img/InSI_modtool_interface.svg" width=70%>
</p>
<p style="text-align-last: center">
<b>
Figure 6. InSI modtool.
</b>
</p>

InSI\_modtool is our small utility to create user-defined algorithms. This utility is divided into two steps as shown in Figure 6. At the first step as shown in the left hand side figure, user selects the mode, model, and defines algorithm name. After that, the user defines one by one of parameters in the second step as shown in the right hand side figure. The output of this utility is a folder containing the template of algorithm code, system model, and parameters file.

[help]: https://www.mathworks.com/help/matlab/matlab_prog/add-help-for-your-program.html