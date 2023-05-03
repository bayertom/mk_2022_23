clc
clear

%Set Python environment
pyenv(Version="C:\Program Files\Python310\python.exe");

L = [5, 6]
L = py.mk.test(L)
print(L)