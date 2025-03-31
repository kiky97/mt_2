import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

def read_data(file):
    """ 读取 perplexity 日志文件 """
    data = pd.read_csv(file, sep='\t')
    return data["Valid PPL"].tolist()

def generate_plots():
    # 读取5个 dropout 设定的文件
    epochs = list(range(1, 41))
    files = [
        "perplexity_log_dropout_0.0.txt", "perplexity_log_dropout_0.3.txt", 
        "perplexity_log_dropout_0.5.txt", "perplexity_log_dropout_0.8.txt", 
        "perplexity_log_dropout_1.0.txt"
    ]
    labels = ["Dropout 0.0", "Dropout 0.3", "Dropout 0.5", "Dropout 0.8", "Dropout 1.0"]
    
    perplexity_data = {label: read_data(file) for label, file in zip(labels, files)}
    
    # 创建 DataFrame 以便于表格显示
    df = pd.DataFrame({"Epoch": epochs, **perplexity_data})
    
    # 生成表格图片
    fig, ax = plt.subplots(figsize=(12, 8))
    ax.axis('tight')
    ax.axis('off')
    table = ax.table(cellText=df.values, colLabels=df.columns, cellLoc='center', loc='center')
    plt.savefig("perplexity_table.png", bbox_inches='tight', dpi=300)
    plt.close()
    
    # 生成折线图
    plt.figure(figsize=(10, 5))
    for label in labels:
        plt.plot(epochs, perplexity_data[label], label=label, marker='o')
    plt.xlabel("Epoch")
    plt.ylabel("Validation Perplexity")
    plt.yscale("log")  # 使用对数坐标轴
    plt.legend()
    plt.title("Validation Perplexity vs. Epochs")
    plt.grid()
    plt.savefig("perplexity_plot.png", bbox_inches='tight', dpi=300)
    plt.close()
    
    print("Plots saved: perplexity_table.png, perplexity_plot.png")

if __name__ == "__main__":
    generate_plots()