#!/bin/bash

# 假设初始 buf_size 为 4KB (4096 bytes)
buf_size=4096
# 测试的倍数
multipliers=(1 2 4 8 16 32 64 128 256 512)
# 每次实验传输 1GB 数据
data_size=$((1024*1024)) # 1M blocks of 1KB
# 重复次数
runs=5

echo "Testing buffer sizes for dd with /dev/zero to /dev/null"
echo "Data size: 1GB, buf_size: $buf_size bytes"

for m in "${multipliers[@]}"; do
    block_size=$((buf_size * m))
    echo -n "Testing multiplier $m (buffer size $block_size bytes): "
    
    total_rate=0
    for ((i=1; i<=runs; i++)); do
        # 运行 dd，设置 bs=block_size，oflag=direct 绕过缓存
        rate=$(dd if=/dev/zero of=/dev/null bs=$block_size count=$data_size iflag=count_bytes oflag=direct 2>&1 | grep -oP '\d+\.\d+ [MG]?B/s' | awk '{print $1}')
        total_rate=$(echo "$total_rate + $rate" | bc)
    done
    
    # 计算平均速率
    avg_rate=$(echo "scale=2; $total_rate / $runs" | bc)
    echo "$avg_rate MB/s"
    # 保存结果到文件
    echo "$m $avg_rate" >> results.txt
done

echo "Experiment complete. Results saved to results.txt"