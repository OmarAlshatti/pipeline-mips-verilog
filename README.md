# pipeline-mips-verilog
This project uses Verilog code to implement and simulate a pipeline processor in MIPS ISA. 
Below is the diagram of said processor
![pipeline](https://user-images.githubusercontent.com/91927297/190830622-c2f0e1ce-11f3-403a-9458-91cbb23a7422.png)
# Pipeline Stages
A pipeline processor has five stages:
1.Instruction Fetch
2.Instruction Decode
3.Execute
4.Memory
5.Write Back
# How to use
1.Download all files then import to a Vivado project
2. Add two .MEM files named Dmem which hold the initizialed memory in binary eg.(00000000000000000000000000010001)
3. Add the other .MEM named Imem which has the instructions coded in MIPS where each part is seperated by an underscore eg.(001000_00000_10000_0000000000000000)
An example .MEM is given in this repo.
4. Use the table below to generate all instructions.
![MIPS_ISA](https://user-images.githubusercontent.com/91927297/190831329-a0fc9448-108b-43d2-a403-94d61adc8056.png)
