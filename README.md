# pipeline-mips-verilog
This project uses Verilog code to implement and simulate a pipeline processor in MIPS ISA. <br/>
Below is the diagram of said processor<br/>
![pipeline](https://user-images.githubusercontent.com/91927297/190830622-c2f0e1ce-11f3-403a-9458-91cbb23a7422.png)
# Pipeline Stages
A pipeline processor has five stages:<br/>
1.Instruction Fetch<br/>
2.Instruction Decode<br/>
3.Execute<br/>
4.Memory<br/>
5.Write Back<br/>
# How to use
1.Download all files then import to a Vivado project<br/>
2. Add two .MEM files named Dmem which hold the initizialed memory in binary eg.(00000000000000000000000000010001)<br/>
3. Add the other .MEM named Imem which has the instructions coded in MIPS where each part is seperated by an underscore eg.(001000_00000_10000_0000000000000000)<br/>
An example .MEM is given in this repo.<br/>
4. Use the table below to generate all instructions.<br/>
![MIPS_ISA](https://user-images.githubusercontent.com/91927297/190831329-a0fc9448-108b-43d2-a403-94d61adc8056.png)
