import matplotlib.pyplot as plt
import pandas as pd

# 读取实验结果
data = pd.read_csv("buffer_size_results.txt")
buffer_sizes = data["Buffer Size (bytes)"]
speeds = data["Speed (MB/s)"]

# 绘制折线图
plt.figure(figsize=(10, 6))
plt.plot(buffer_sizes, speeds, marker='o', color='#2ca02c', linewidth=2, markersize=8)
plt.xscale('log')  # 对数刻度以清晰显示缓冲区大小变化
plt.xlabel('缓冲区大小 (字节)')
plt.ylabel('读写速度 (MB/s)')
plt.title('不同缓冲区大小的读写速度')
plt.grid(True, which="both", ls="--")
plt.savefig('buffer_size_plot.png')
plt.show()