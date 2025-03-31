# 打开源文件并读取内容
def convert_to_utf8(input_file, output_file):
    # 打开源文件并读取
    with open(input_file, 'r', encoding='ISO-8859-1') as f:
        content = f.read()

    # 将内容写入到目标文件并转换编码为 UTF-8
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"文件已成功转换为 UTF-8 并保存为 {output_file}")

# 指定源文件和目标文件路径
input_file = r'C:\Users\shijinzhou\mt-exercise-02\data\yellow_wallpaper\train.txt'  # 输入文件路径，使用原始字符串
output_file = r'C:\Users\shijinzhou\mt-exercise-02\data\yellow_wallpaper\train_utf8.txt'  # 输出文件路径，使用原始字符串

# 调用函数进行转换
convert_to_utf8(input_file, output_file)
