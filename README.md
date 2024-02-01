# szuthesis 深圳大学学位论文 LaTeX 模板
## 新添修改：
1. 实现黑体加粗，但需自己下载字体
2. 修改了页边距（上—2.54cm， 下—2.54cm， 左—3.17cm， 右—3.17cm）
3. 修改了页眉下划线为双线且上粗下细
4. 封面：
* “深圳大学硕士学位论文”删去“深圳大学”，并将大小调整为小初
* 封面上方分类号等四项的内容调整为黑体小四
* 新增“学号”、“学科”、日期的填写
5. 原创性声明页：
+ 修改了标题内容
6. 章节内容：
+ 修改了章标题大小为黑体三号加粗、一级标题为黑体小三加粗、二级标题和为宋体四号加粗
+ 将第1章改为第一章
7. 摘要：
+ 修改了摘要二字的大小为：黑体加粗三号
+ 将Abstract改为全大写，且改为三号加粗
8. 目录：
+ 修改了“目录”为黑体三号加粗
+ 章节标题加粗
9. 页眉现在显示为每章标题
10. 增加了专硕封面、修改了附录、致谢和研究成果的字体大小

## 注意事项：
1. 每一章（也就是每一个`\Chapter{章标题}\label{chap:label}`）后，添加`\markboth{第几章\quad 章标题}{}`，例如：
```latex
\chapter{相关技术与理论}\label{chap:preliminary}
\markboth{第二章\quad 相关技术与理论}{}
```
特殊的是中文摘要，在Abstract.tex中修改如下
```latex
\begin{abstract}
    \markboth{摘\quad 要}{}
    %你的文本
```
2. 项目中包含FZHTJW.TTF即为项目中使用的黑体，点击安装即可，但要注意选择<span style="color: red;">**为所有用户安装**</span>选项，否则可能出现项目认不出来字体的情况。安装后可以通过在cmd中运行`fc-list -f "%{family}\n" :lang=zh-cn >d:\list.txt`生成一个可访问到的字体库的列表，其中`d:\list.txt`是文件生成路径，通过查看该路径确认字体安装，在生成的list.txt文件中查看<span style="color: yellow;">**方正黑体简体**</span>的英文编号，如果英文名称是"FZHei-B01S"则不需要修改，如果英文名称改变则需要在szuthesis.cls文件中第178行`\newCJKfontfamily\heitib{FZHei-B01S}[AutoFakeBold=2]`中的"FZHei-B01S"字段修改成list.txt文件中的字段。
3. 有关专硕和学硕封面问题：使用时须在config.tex文件中的22、23行选择学硕专硕类别
```latex
\DEGREE{MasterXS}% 学术硕士
% \DEGREE{MasterZY}% 专业硕士
```
4. 有一些自用宏包可能会与现在使用的其他包有冲突，例如已知的longtable包与使用tikz库自定义图形中使用的\fill命令会产生冲突，建议使用前检查config.tex文件中第118-129行。