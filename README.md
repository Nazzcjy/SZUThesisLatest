# 深圳大学研究生学位论文 LaTeX 模板（2024年要求）
## 模板简介
* 本项目基于 [深圳大学学位论文 LaTeX 模板](https://github.com/yichengsu/szuthesis) 针对深大2024年论文格式进行修改(Windows系统为主，mac和linux可能会有未知问题)。
* 最近更新了cls文件修复了一些格式问题，请注意替换和更改。
* 更多关于 szuthesis 编译和设计的问题，请先阅读 模板使用说明.pdf，如有问题可提出issue。

## 编译
推荐使用 Tex Live 2020 + VS Code(LaTeX Workshop插件)，本项目已经提供了`.vscode/settings.json`进行相关设置。

## 新添修改：
**##** **新添修改：**

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

+ 目录内容字号改为小四

9. 页眉现在显示为每章标题

10. 增加了专硕封面、修改了附录、致谢和研究成果的字体大小

11. 图表标题加粗

12. 设置表格字体默认为5号字
* 如果需要将小表调大，建议调整表格列间距，在\begin{tabular}之前添加\setlength{\tabcolsep}{10pt}进行修改（根据表格情况修改10为其它大小）
* 如果需要将大表调小（暂时没有解决，\resizebox或\adjustbox都会该表字体大小）

13. 调整图、表、公式和算法标题为   {章节编号}-{图、表、公式和算法编号}   的形式，如果编号和标题直接间隔过小请在每个图表标题前手动添加空格，格式如下：

```latex
\begin{figure}
\centering
\includegraphics[width=0.5\textwidth]{example-image-a} % 引入一个示例图片
\caption{\ \ 示例图片} % 在标题文本前手动增加两个空格
\end{figure}
```

## 注意事项：
1. 每一章（也就是每一个`\Chapter{章标题}\label{chap:label}`）后，添加`\markboth{第几章\quad 章标题}{}`，例如：
```latex
\chapter{相关技术与理论}\label{chap:preliminary}
\markboth{第二章\ \ 相关技术与理论}{}
...
```
特殊的是中文摘要，在Abstract.tex中修改如下
```latex
\begin{abstract}
\markboth{摘\ \ 要}{}
...
```
2. 项目中包含FZHTJW.TTF即为项目使用的黑体。
由于系统中的黑体字体无法加粗，需额外下载黑体字体。
Windows系统：点击安装即可，但要注意选择<span style="color: red;">**为所有用户安装**</span>选项，否则可能出现项目认不出来字体的情况。安装后可以通过在cmd中运行`fc-list -f "%{family}\n" :lang=zh-cn >d:\list.txt`生成一个可访问到的字体库的列表，其中`d:\list.txt`是文件生成路径，通过查看该路径确认字体安装，在生成的list.txt文件中查看<span style="color: yellow;">**方正黑体简体**</span>的英文编号，如果英文名称是"FZHei-B01S"则不需要修改，如果英文名称改变则需要在szuthesis.cls文件中第178行`\newCJKfontfamily\heitib{FZHei-B01S}[AutoFakeBold=2]`中的"FZHei-B01S"字段修改成list.txt文件中的字段。

3. 有关专硕和学硕封面问题：使用时须在config.tex文件中的22、23行选择学硕专硕类别
```latex
\DEGREE{MasterXS}% 学术硕士
% \DEGREE{MasterZY}% 专业硕士
```
4. 有一些自用宏包可能会与现在使用的其他包有冲突，例如已知的longtable包与使用tikz库自定义图形中使用的\fill命令会产生冲突，建议使用前检查config.tex文件中第118-129行。

5. suzthesis.cls文件中定义的封面部分修改如下：
* 重定义了新的表格环境，消除表格字体全局设置的影响；
* 注意更改封面定义部分中表格语句。（正文中还是使用tabular，建议直接替换整个cls文件）
![image](https://github.com/cflee123/SZUThesisLatest/assets/131333379/7695d954-f17e-4ad8-9999-ca3106fc5bbf)





![image](https://github.com/cflee123/SZUThesisLatest/assets/131333379/c4251886-02b5-41fa-8a9e-45748dba8d91)

![1](https://github.com/cflee123/SZUThesisLatest/assets/131333379/d6cc89d4-476b-4df7-b025-be876a68df11)

![2](https://github.com/cflee123/SZUThesisLatest/assets/131333379/d22bed1e-490e-4934-b00d-fbdf23d942d6)

![3](https://github.com/cflee123/SZUThesisLatest/assets/131333379/926c92fd-5c45-4139-a72e-ecd2e6564d83)

![4](https://github.com/cflee123/SZUThesisLatest/assets/131333379/5bc9853a-9e77-4bab-a0d2-6bd580c8a187)

![5](https://github.com/cflee123/SZUThesisLatest/assets/131333379/c1847ff6-775e-4f16-98bb-acbe3862ca50)

![6](https://github.com/cflee123/SZUThesisLatest/assets/131333379/fe84f32c-5f3a-4aef-bac1-9ed6073ee3a7)

![7](https://github.com/cflee123/SZUThesisLatest/assets/131333379/63208cf8-7996-4deb-a191-247c0a076afa)



# szuthesis 深圳大学学位论文 LaTeX 模板 （参考项目中的ReadMe文件）

## 模板简介
* 本项目基于 [中国科学院大学学位论文模板 ucasthesis](https://github.com/mohuangrui/ucasthesis) 二次开发。相对于 ucasthesis ，本项目进行了许多改动，关键的变化如下：
  * 修改相关配置，使其符合深圳大学学位论文印刷格式样式；
  * 封装了更多的命令，极大化简了 Thesis.tex 中的内容；
  * 化简了许多操作，例如化简了字体相关补丁，遵循ctex字体关于粗体和斜体的相关设定，化简了参考文献格式等；
  * 参考了 [上海交通大学论文模板 SJTUThesis](https://github.com/sjtug/SJTUThesis) 的设计思路。

* szuthesis 提供了简单明了的 **模板使用说明.pdf**。无论你是否具有 LaTeX 使用经验，都可较为轻松地使用以完成学位论文的撰写和排版。感谢大家的测试、反馈和支持。

* 兼顾操作系统：Windows、Linux、MacOS；LaTeX 编译引擎：仅支持xelatex；文献编译引擎：biber (biblatex)。支持中文书签、中文渲染、拷贝 PDF 中的文本到其他文本编辑器等特性。

* 相对于 word 模板，LaTeX 模板拥有着诸多优势。例如，可以使用 git 进行版本控制，专注写作且无需关注格式，更便利的公式书写环境，支持注释等。

* 更多关于 szuthesis 编译和设计的问题，请先阅读 **模板使用说明.pdf**，如有问题可提出issue。

## 编译
推荐使用 Tex Live 2020 + VS Code(LaTeX Workshop插件)，本项目已经提供了`.vscode/settings.json`进行相关设置。

LaTeX Workshop 插件提供了诸如 Linting，Formatting，Intellisense，PDF 文件预览，公式预览，全文大纲，chktex 语法检查等诸多功能，更多功能请见 [LaTeX-Workshop](https://github.com/James-Yu/LaTeX-Workshop)。

推荐使用 **latexmk** 命令编译文档，latexmk 命令可以自动适应不同的编译顺序，因本项目使用 biber 作为参考文献引擎，所以编译顺序可以与通常的顺序不同。如使用 VS Code，只需安装插件后重启项目，点击 `TEX -> Build LaTeX project -> Recipe: latexmk` 即可，或在命令行使用命令：

``` sh
latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdfxe -outdir=./Temp -e ensure_path('TEXINPUTS','./texmf//') Thesis.tex
```

如初次接触 LaTeX 推荐使用上述方法进行编译，使用其他编辑软件请注意编译顺序。若使用 MiKTeX，在安装 latexmk 后可能会缺少 perl.exe，可安装 [Strawberry Perl](https://www.perl.org/get.html)。

Ubuntu 用户推荐安装完整 [adobe字体](https://github.com/mohuangrui/ucasthesis/wiki/%E5%AD%97%E4%BD%93%E9%85%8D%E7%BD%AE#adobe-%E5%AD%97%E4%BD%93%E4%B8%8B%E8%BD%BD%E5%9C%B0%E5%9D%80)。

## TODO
- [ ] 兼容本科毕业论文模板

## 软件许可证
深圳大校徽校名图片 `Image/logo.png` 的版权归属深圳大学所有。

项目其他内容遵循 GPLv3 授权。
