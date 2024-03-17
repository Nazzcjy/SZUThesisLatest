%!TEX TS-program = xelatex
% %---------------------------------------------------------------------------%
% %-                                                                         -%
% %-                           Document Class                                -%
% %-                                                                         -%
% %---------------------------------------------------------------------------%
% %- Copyright (C) 2014-2020 Huangrui Mo <huangrui.mo@gmail.com>
% %-               2021-     Yicheng Su <suyicheng1995@gmail.com>
% %-               2024-     Jiayao Chen <cjyedu@163.com>
% %- This is free software: you can redistribute it and/or modify it
% %- under the terms of the GNU General Public License as published by
% %- the Free Software Foundation, either version 3 of the License, or
% %- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\newcommand\szu@error[1]{\ClassError{szuthesis}{#1}{}}
\newcommand\szu@warning[1]{\ClassWarning{szuthesis}{#1}}
\newcommand*\@iflatexlater{\@ifl@t@r\fmtversion}%
\@iflatexlater{2018/01/01}{}{%
    \szu@error{TeXLive/MikTex >= 2018 is required}%
}
\ProvidesClass{szuthesis}[2021/01/01 v0.1 LaTeX for Shenzhen University thesis]%
%---------------------------------------------------------------------------%
%->> Load ctex
%---------------------------------------------------------------------------%
%-> 排版
%-> 提供print参数可用于打印时自动双页对齐
\def\szu@openoption{openany}
\DeclareOption{print}{%
    \def\szu@openoption{openright}%
    \szu@warning{Just a hint! You are using the printed version, The blank page will be automatically generated}%
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax%
\LoadClass[UTF8,a4paper,zihao=-4,\szu@openoption]{ctexbook}[2018/01/01]%
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
\RequireXeTeX%
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\szu@ifstreq}{\expandafter\ifstrequal\expandafter}% expansion control
\newcommand{\szu@ifstrbk}{\expandafter\ifblank\expandafter}% expansion control
\RequirePackage{geometry}% for layout
\RequirePackage{expl3}% LaTeX3 programming environment
\RequirePackage{array}% for cover layout
\RequirePackage{ulem}% underline
\RequirePackage{xeCJKfntef}% underline for CJK
\RequirePackage{fancyhdr}% header and footer
\RequirePackage[backend=biber,style=gb7714-2015,gbpub=false]{biblatex}

% 设置fancyhdr
\pagestyle{fancy} % 使用fancy页面样式
\fancyhf{} % 清除所有页眉和页脚的默认设置
\fancyhead[LE,RO]{\leftmark} % 在偶数页的左侧和奇数页的右侧显示当前章节的名称和编号
\fancyfoot[C]{\thepage} % 在页脚中间设置页码

% 章节起始页的风格
\fancypagestyle{plain}{ 
  \fancyhf{} % 清除页眉和页脚
  \renewcommand{\headrulewidth}{0pt} % 去掉页眉下方的横线
  \fancyfoot[C]{\thepage} % 仅在页脚中间显示页码
}

% 确保章节名称被正确捕获
\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter.\ #1}{}}
%---------------------------------------------------------------------------%
%->> Latex3
%---------------------------------------------------------------------------%
\ExplSyntaxOn
\newcommand{\szulntotab}[2][0.5pt]{% convert lines into table lines
    \seq_set_split:NnV \l_tmpa_seq {\\} {#2}
    \clist_set_from_seq:NN \l_tmpa_clist \l_tmpa_seq
    \clist_clear:N \l_tmpb_clist
    \clist_map_inline:Nn \l_tmpa_clist
      {%
        \clist_put_right:Nn \l_tmpb_clist 
          { \ulenhance[#1]{\ulextend{##1}} }
      }
    %\clist_show:N\l_tmpb_clist% show the content of comma list
    \clist_use:Nn \l_tmpb_clist { \\ & }
}
\providecommand{\g__ctex_fontset_tl}{}% platform fontset state variable
\edef\szu@fontset{\g__ctex_fontset_tl}% expanded platform fontset state variable
\ExplSyntaxOff
%---------------------------------------------------------------------------%
%->> Cover information
%---------------------------------------------------------------------------%
\AtEndOfPackage{%
    %->> Basic
    \def\szu@label@ch@classid{分类号}
    \def\szu@label@ch@schoolid{学校代码}
    \def\szu@value@ch@schoolid{\ \ \ 10590}
    \def\szu@label@ch@udc{U\hfill{}D\hfill{}C}
    \def\szu@label@ch@confidential{密\qquad{}级}
    \def\szu@label@ch@thesis{}
    \def\szu@label@ch@thesis@mas{\textbf{硕士学位论文}}
    \def\szu@label@ch@author{}
    \def\szu@label@ch@author@mas{学位申请人姓名}
    \def\szu@label@ch@idnumber{}
    \def\szu@label@ch@idnumber@mas{学位申请人学号}
    \def\szu@label@ch@major{}
    \def\szu@label@ch@major@mas@xs{专\quad{}业\quad{}名\quad{}称}
    \def\szu@label@ch@major@mas@zy{专业(领域)名称}
    \def\szu@label@ch@dtype{}
    \def\szu@label@ch@dtype@mas@xs{学\quad{}科\quad{}门\quad{}类}
    \def\szu@label@ch@dtype@mas@zy{学\quad{}位\quad{}类\quad{}别}
    \def\szu@label@ch@institute{}
    \def\szu@label@ch@institute@mas{学院(部,研究院)}
    \def\szu@label@ch@advisor@mas{导\quad{}师\quad{}姓\quad{}名}
    \def\szu@label@ch@school{深圳大学}
    %-----------------------------------------------------------------------%
    %->> Structure elements
    \def\szu@label@ch@tocname{目\ \ 录}
    \def\szu@label@ch@keywords{关键词：}
    \def\szu@label@en@keywords{Key\ word:}
    %-----------------------------------------------------------------------%
    %->> Author's declaration
    \def\szu@label@ch@declare@title{深圳大学}
    \def\szu@label@ch@declare@creativity{学位论文原创性声明}
    \def\szu@value@ch@declare@creativity@prefix{%
        本人郑重声明：所呈交的学位论文%
    }
    \def\szu@value@ch@declare@creativity@suffix{%
        是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，%
        本论文不含任何其他个人或集体已经发表或撰写的作品或成果。%
        对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本声明的法律后果由本人承担。%
    }
    \def\szu@label@ch@declare@rights{学位论文使用授权说明}
    \def\szu@value@ch@declare@rights{%
        本学位论文作者完全了解深圳大学关于收集、保存、使用学位论文的规定，%
        即：研究生在校攻读学位期间论文工作的知识产权单位属深圳大学。%
        学校有权保留学位论文并向国家主管部门或其他机构送交论文的电子版和纸质版，允许论文被查阅和借阅。%
        本人授权深圳大学可以将学位论文的全部或部分内容编入有关数据库进行检索，%
        可以采用影印、缩印或扫描等复制手段保存、汇编学位论文。%
    }
    \def\szu@value@ch@declare@rule{（涉密学位论文在解密后适用本授权书）}
    \def\szu@label@ch@declare@author{论文作者签名：}
    \def\szu@label@ch@declare@advisor{导师签名：}
    \def\szu@label@ch@declare@date{日期：\hspace*{2.5em}年\hspace*{1.5em}月\hspace*{1.5em}日}
}
%---------------------------------------------------------------------------%
%->> font set
%---------------------------------------------------------------------------%
\IfFontExistsTF{XITS-Regular.otf}{%
    \def\XITSFontOptions{%
        Extension  = .otf,     UprightFont    = *-Regular,    BoldFont  = *-Bold,%
        ItalicFont = *-Italic, BoldItalicFont = *-BoldItalic,% Ligatures = TeX,
    }
    \setmainfont[NFSSFamily=entextrm]{XITS}[\XITSFontOptions]
    \setsansfont[NFSSFamily=entextsf]{XITS}[\XITSFontOptions]
    \setmonofont[NFSSFamily=entexttt]{XITS}[\XITSFontOptions]
}{%
    \szu@error{XITS font is required! Please install `xits' in Tex Live Shell}
}
\IfFontExistsTF{Arial}{% for abstract titile
    \newfontfamily\szu@lucon{Arial}[AutoFakeBold=2]
}{
    \szu@error{`Arial' font is required! Please install `Arial'}
}
% bold songti patch

\IfFontExistsTF{SimSun}{
\newCJKfontfamily\szu@song{SimSun}[AutoFakeBold=2]
}{
\szu@error{`SimSun' font is required! Please install `SimSun'}
}

\IfFontExistsTF{FangSong}{
\newCJKfontfamily\szu@fangsong{FangSong}[AutoFakeBold=2]
}{
\szu@error{`FangSong' font is required! Please install `FangSong'}
}

\newCJKfontfamily\heitib{FZHei-B01S}[AutoFakeBold=2]

% \def\BoldSongOptions{AutoFakeBold=2}
% \IfFontExistsTF{Noto~Serif~CJK~SC}{
%     \newfontfamily\szu@song{Noto~Serif~CJK~SC}[\BoldSongOptions]
%     \IfFontExistsTF{FangSong}{
%     \newCJKfontfamily\szu@fangsong{FangSong}[\BoldSongOptions]
%     }{
%     \def\szu@fangsong\szu@song
%     \szu@warning{No FangSong font was found, SongTi is used default. Please install FangSong or adobe series fonts.}
% }{\szu@error{Please use adobe|mac|ubuntu|windows fontset.}}}
% \def\BoldSongOptions{AutoFakeBold=2}
% \szu@ifstreq{\szu@fontset}{windows}{
%     \newCJKfontfamily\szu@song{SimSun}[\BoldSongOptions]
%     \newCJKfontfamily\szu@fangsong{FangSong}[\BoldSongOptions]
% }{\szu@ifstreq{\szu@fontset}{adobe}{
%     \newCJKfontfamily\szu@song{AdobeSongStd-Light}[\BoldSongOptions]
%     \newCJKfontfamily\szu@fangsong{AdobeFangsongStd-Regular}[\BoldSongOptions]
% }{\szu@ifstreq{\szu@fontset}{mac}{
%     \def\szu@song\szu@song
%     \newCJKfontfamily\szu@fangsong{STFangsong}[\BoldSongOptions]
% }{\szu@ifstreq{\szu@fontset}{luubuntu}{
%     \newCJKfontfamily\szu@song{Noto~Serif~CJK~SC}[\BoldSongOptions]
%     \IfFontExistsTF{FangSong}{
%         \newCJKfontfamily\szu@fangsong{FangSong}[\BoldSongOptions]
%     }{
%         \def\szu@fangsong\szu@song
%         \szu@warning{No FangSong font was found, SongTi is used default. Please install FangSong or adobe series fonts.}
%     }
% }{\szu@error{Please use adobe|mac|ubuntu|windows fontset.}}}}}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- assuming A4 paper (210mm x 297mm)
%- 深大论文要求：四周留25mm空白。行距一般为23磅。
% \geometry{margin=25mm,headsep=5mm,headheight=9mm}
%- 深大论文最新要求：上下留2.54cmm空白，左右留3.17cm空白。行距一般为23磅。
\geometry{top=2.54cm,bottom=2.54cm,left=3.17cm,right=3.17cm,headsep=3mm,headheight=9mm}
%- specifies the amount of space between paragraphs. 段落间距
% \setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.6}% line space setting，效果等于行距23磅
\raggedbottom% prevent adding vertical white space in strange places
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
\newcommand{\szu@clearpage}{\if@openright\cleardoublepage\else\clearpage\fi}
\newcommand{\ulunify}[1]{\uline{#1}}% unified name
\newcommand{\ulenhance}[2][0.5pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness of line
    \setlength{\ULdepth}{0.5em}% distance between line and word
    \expandafter\ulunify\expandafter{#2}% linebreak fix
}
\newcommand{\ulextend}[2][2.8in]{\hbox to #1{\hspace*{5pt}#2\hfill}}% extend underline length for cover
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> Chinese item commands
%-
\def\szu@value@ch@classid{}
\newcommand{\classid}[1]{\def\szu@value@ch@classid{#1}}
\def\szu@value@ch@udc{}
\newcommand{\udc}[1]{\def\szu@value@ch@udc{#1}}
\def\szu@value@ch@confidential{}
\newcommand{\confidential}[1]{\def\szu@value@ch@confidential{#1}}
\def\szu@value@ch@title@t{深圳大学\LaTeX{}模板}
\def\szu@value@ch@title@b{\;}
\def\szu@value@ch@title{}
\renewcommand{\title}[2]{%考虑为空的情况
    \szu@ifstrbk{#1}{}{\def\szu@value@ch@title@t{#1}%
    \szu@ifstrbk{#2}{\def\szu@value@ch@title{#1}}{\def\szu@value@ch@title@b{#2}\def\szu@value@ch@title{#1#2}}}}%
\def\szu@value@ch@author{}
\renewcommand{\author}[1]{\def\szu@value@ch@author{#1}}
\def\szu@value@ch@idnumber{}
\newcommand{\idnumber}[1]{\def\szu@value@ch@idnumber{#1}}
\def\szu@value@ch@major{}
\newcommand{\major}[1]{\def\szu@value@ch@major{#1}}
\def\szu@value@ch@dtype{}
\newcommand{\dtype}[1]{\def\szu@value@ch@dtype{#1}}
\def\szu@value@ch@institute{}
\newcommand{\institute}[1]{\long\def\szu@value@ch@institute{#1}}
\def\szu@value@ch@advisor{}
\newcommand{\advisor}[1]{\long\def\szu@value@ch@advisor{#1}}
%-
%-> english item commands
%-
\def\szu@value@en@title{}
\newcommand{\TITLE}[1]{\def\szu@value@en@title{#1}}
\def\szu@value@en@degree{}
\newcommand{\DEGREE}[1]{\edef\szu@value@en@degree{\zap@space#1 \@empty}}% expand and remove space
%-
%-> Detect and adjust items
%-
\AtEndPreamble{%
    \szu@ifstreq{\szu@value@en@degree}{MasterXS}{%
        \def\szu@label@ch@thesis{\szu@label@ch@thesis@mas}%
        \def\szu@label@ch@author{\szu@label@ch@author@mas}%
        \def\szu@label@ch@idnumber{\szu@label@ch@idnumber@mas}%
        \def\szu@label@ch@major{\szu@label@ch@major@mas@xs}%
        \def\szu@label@ch@dtype{\szu@label@ch@dtype@mas@xs}%
        \def\szu@label@ch@institute{\szu@label@ch@institute@mas}%
        \def\szu@label@ch@advisor{\szu@label@ch@advisor@mas}%
        \def\maketitle{\maketitle@mas}
    }{%
    \szu@ifstreq{\szu@value@en@degree}{MasterZY}{
        \def\szu@label@ch@thesis{\szu@label@ch@thesis@mas}%
        \def\szu@label@ch@author{\szu@label@ch@author@mas}%
        \def\szu@label@ch@idnumber{\szu@label@ch@idnumber@mas}%
        \def\szu@label@ch@major{\szu@label@ch@major@mas@zy}%
        \def\szu@label@ch@dtype{\szu@label@ch@dtype@mas@zy}%
        \def\szu@label@ch@institute{\szu@label@ch@institute@mas}%
        \def\szu@label@ch@advisor{\szu@label@ch@advisor@mas}%
        \def\maketitle{\maketitle@mas}
    }{
        \szu@error{DEGREE error}
    }}
}
%-
%-> Define Chinese style
%-
\AtBeginEnvironment{tabular}{\zihao{5}\selectfont}
\AtBeginEnvironment{tabularx}{\zihao{5}\selectfont}%设置表格字体为5号字

\newenvironment{mytabular}%重新定义表格格式
  {\tabular}
  {\endtabular}

\newcommand{\maketitle@mas}{%
    \szu@clearpage
    
    \begin{center}
        % \linespread{1.6}
        {\zihao{-4}\heiti
        \begin{mytabular}{w{c}{0.50in}>{\zihao{-4}}p{0.80in}p{2.40in}w{c}{0.80in}p{0.80in}}
            \szu@label@ch@classid                 & \szu@song{\szu@value@ch@classid} & & \szu@label@ch@schoolid     & \szu@value@ch@schoolid              \\ \cline{2-2} \cline{5-5}
            \makebox[0.4in][s]{\szu@label@ch@udc} & \szu@value@ch@udc                & & \szu@label@ch@confidential & \zihao{-4}\szu@value@ch@confidential \\ \cline{2-2} \cline{5-5} 
        \end{mytabular}}\\
        \vspace*{29mm}
        %
        {\zihao{-0}\heitib\textbf{\szu@label@ch@thesis}}\\
        \vspace*{15mm}
        %
        {\zihao{-2}\heitib\bfseries \szu@value@ch@title@t}\\
        \vspace*{3mm}
        {\zihao{-2}\heitib\bfseries \szu@value@ch@title@b}\\
        \vspace*{30mm}
        %
        \def\arraystretch{1.4}
        \def\tabcolsep{1pt}
        {\zihao{3}\szu@song
        \begin{mytabular}{w{c}{1.8in}w{c}{2.8in}}
            \szu@label@ch@author    & \ulenhance{\ulextend{\szu@value@ch@author}}  \\
            \szu@label@ch@idnumber    & \ulenhance{\ulextend{\szu@value@ch@idnumber}}  \\
            \szu@label@ch@major     & \ulenhance{\ulextend{\szu@value@ch@major}}   \\
            \szu@label@ch@dtype     & \ulenhance{\ulextend{\szu@value@ch@dtype}}   \\
            \szu@label@ch@institute & \szulntotab{\szu@value@ch@institute}           \\
            \szu@label@ch@advisor   & \szulntotab{\szu@value@ch@advisor}             \\
            \multicolumn{2}{c}{二〇二四年五月}
        \end{mytabular}}
    \end{center}
    \szu@clearpage
}

%---------------------------------------------------------------------------%
%->> Author's declaration
%---------------------------------------------------------------------------%
\newcommand{\makedeclaration}[1]{%
    \szu@clearpage
    {
        \szu@ifstrbk{#1}{
            \newgeometry{hmargin=1.23in,vmargin=1in}
            \linespread{1.6}
            \zihao{-4}
            %
            \vspace*{1mm}
            \begin{center}
                \heiti\bfseries
                {\zihao{3} \szu@label@ch@declare@title} \\
                \vspace*{3mm}
                {\zihao{3} \szu@label@ch@declare@creativity}
            \end{center}
            \vspace*{-4mm}
            {\par\szu@value@ch@declare@creativity@prefix%
            \CJKunderline{\ \szu@value@ch@title\ }%
            \szu@value@ch@declare@creativity@suffix}
            \vspace*{\baselineskip}
            {\par\szu@label@ch@declare@author\hspace*{12em}\szu@label@ch@declare@date} 
            %
            \vspace*{4\baselineskip}
            \begin{center}
                \heiti\bfseries
                {\zihao{3} \szu@label@ch@declare@title} \\
                \vspace*{3mm}
                {\zihao{3} \szu@label@ch@declare@rights}
            \end{center}
            \vspace*{1mm}
            {\par\szu@value@ch@declare@rights}
            {\par\szu@value@ch@declare@rule}
            \vspace*{\baselineskip}
            {\par\szu@label@ch@declare@author\hspace*{12em}\szu@label@ch@declare@advisor}
            \vspace*{1mm}
            {\par\szu@label@ch@declare@date\hspace*{7.5em}\szu@label@ch@declare@date}
            %
            \restoregeometry
        }{
            \newgeometry{margin=0mm}
            \begin{figure}
                \includegraphics[width=0.999\textwidth]{#1}
            \end{figure}
            \restoregeometry
        }
    }
    \szu@clearpage
}
%---------------------------------------------------------------------------%
%->> abstract environments
%---------------------------------------------------------------------------%
%- define chinese keywords
\newcommand{\keywords}[1]{%
    \vspace*{2\baselineskip}
    \noindent {\heitib\bfseries \szu@label@ch@keywords} #1}
%- define engish keywords
\newcommand{\KEYWORDS}[1]{%
    \vspace*{2\baselineskip}
    \noindent {\bfseries \szu@label@en@keywords} #1}
\newenvironment{abstract}{
    \ctexset{chapter = {
        format = \linespread{1.0}\zihao{3}\heiti\bfseries\centering,
        beforeskip = {5pt},
        afterskip = {18pt},
    }}%
    \chapter[摘要]{摘\ \ 要}%
    \pagestyle{mainmatterstyle}%
}{\szu@clearpage}
\newenvironment{ABSTRACT}{
    \ctexset{chapter = {
        format = \linespread{1.0}\zihao{3}\szu@lucon\bfseries\centering,
        beforeskip = {5pt},
        afterskip = {18pt},
    }}%
    \chapter{ABSTRACT}%
    \pagestyle{ABSTRACT}%
}{\szu@clearpage}
% %---------------------------------------------------------------------------%
% %->> Structure elements
% %---------------------------------------------------------------------------%
\def\contentsname{\szu@label@ch@tocname}
\def\szutitle{\szu@value@ch@title}
\def\szuauthor{\szu@value@ch@author}
%---------------------------------------------------------------------------%
%->> Structure layout
%---------------------------------------------------------------------------%
%- chapter
\ctexset {
    chapter = {
        format = \linespread{1.0}\zihao{3}\heiti\bfseries\centering,
        number = \chinese{chapter},
        aftername = \quad,
        beforeskip = {18pt},
        afterskip = {18pt},
        pagestyle = plain,
    },
    section = {
        format = \linespread{1.0}\zihao{-3}\heiti\bfseries\raggedright,
        aftername = \quad,
        beforeskip = {24pt},
        afterskip = {6pt},
    },
    subsection = {
        format = \linespread{1.0}\zihao{4}\szu@song\bfseries\raggedright,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    },
    subsubsection = {
        format = \linespread{1.0}\zihao{-4}\szu@song\bfseries\raggedright,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    },
    appendix = {
        %numbering = true|false,
        %number = \szu@song\Alph{chapter},
    }
}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- the table of contents is specified by defining \l@chapter, \l@section, ...
%- most commands are then defined with the \@dottedtocline:
%- \@dottedtocline{⟨level⟩}{⟨indent⟩}{⟨numwidth⟩}{⟨title⟩}{⟨page⟩}
%- ⟨level⟩    an entry is produced only if ⟨level⟩ <= value of the tocdepth counter
%-            note, \chapter is level 0, \section is level 1, etc
%- ⟨indent⟩   indentation from the outer left margin of the start of the contents line
%- ⟨numwidth⟩ width of a box in which the section number is to go
%- <title>    title
%- <page>     page number
%-
%- parameters for spacing and length in toc
\def\@dotsep{1.5mu}% separation between dots in mu units
\def\@pnumwidth{2em}% width of a box in which the page number is put
\def\@tocrmarg{2em}% right margin for multiple line entries, \@tocrmarg ≥ \@pnumwidth
% \def\@chaptervspace{1ex}% vertical space between chapter titles
%-
\usepackage{tikz}
\newcommand{\myboldcftdotfill}{%
  \leavevmode\leaders\hbox to 0.454em{%
  $\m@th\mkern \@dotsep
    \begin{tikzpicture}
      \filldraw (0,0) circle (0.03); % 调整圆点半径来改变加粗程度
    \end{tikzpicture}%
    \mkern \@dotsep$
  }\hfill\kern\z@
}

% \renewcommand{\cfttoctitlefont}{\zihao{3}\bfseries\heiti\centering}
% \renewcommand{\cftaftertoctitle}{\vspace{24pt}\vspace{-\baselineskip}}%设置目录标题为黑体加粗
%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        \parindent #2\relax\@afterindenttrue
        \interlinepenalty\@M
        \leavevmode \zihao{-4}\szu@song
        \@tempdima #3\relax
        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
        {#4}\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
        \nobreak
        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
        \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from book.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty{-\@highpenalty}%
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode
            \zihao{-4}\szu@song #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
            \nobreak
            \global\@nobreaktrue
            \everypar{\global\@nobreakfalse\everypar{}}%
        \endgroup
    \fi
}
%- redefine l@chapter from book.cls to add dotted toc line
\renewcommand*{\l@chapter}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip \z@ \@plus.2\p@ % \vskip \@chaptervspace \@plus\p@
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \zihao{-4}\bfseries\szu@song
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak
            % \hspace{0.1em}%向右移动起始位置
            % \leaders\hbox{$\m@th\mkern \@dotsep \pmb{\cdot} \mkern \@dotsep$}% add dotted toc line
            \myboldcftdotfill % 使用自定义的加粗点线
            % \hspace{-0.5em}%向右移动终点位置
            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi
}
%- redefine indentation for others
\renewcommand*\l@section{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{2em}{2.8em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{3em}{3.8em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{4em}{4.8em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{5em}{5.8em}}
\renewcommand*\l@figure{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@table{\@dottedtocline{1}{1em}{1.8em}}
%---------------------------------------------------------------------------%
%->> header and footer style
%---------------------------------------------------------------------------%
\pagestyle{fancy}
\fancypagestyle{mainmatterstyle}{% style for mainmatter
    \fancyhf{}% clear fields
    \fancyhead[C]{\small\rmfamily \leftmark}% structure elements
    \fancyfoot[C]{\small\rmfamily \thepage}% page number
    \renewcommand{\headrule}{
\makebox[0pt][l]{\rule[0.55\baselineskip]{\headwidth}{0.5pt}}%
\rule[0.7\baselineskip]{\headwidth}{1pt}}
    % \renewcommand{\headrulewidth}{2pt}% header rule
    \renewcommand{\footrulewidth}{0pt}% footer rule
}
\fancypagestyle{plain}{}
\fancypagestyle{empty}{%
    \fancyhf{}% clear fields
    \renewcommand{\headrulewidth}{0pt}% header rule
    \renewcommand{\footrulewidth}{0pt}% footer rule
}
\fancypagestyle{ABSTRACT}{% style for english abstract
    \fancyhf{}% clear fields
    \fancyhead[C]{\small\rmfamily \szu@value@en@title}% use english title
    \fancyfoot[C]{\small\rmfamily \thepage}% page number
    \renewcommand{\headrule}{
\makebox[0pt][l]{\rule[0.55\baselineskip]{\headwidth}{0.5pt}}%
\rule[0.7\baselineskip]{\headwidth}{1pt}}
    % \renewcommand{\headrulewidth}{2pt}% header rule
    \renewcommand{\footrulewidth}{0pt}% footer rule
}
\pagestyle{empty}
%---------------------------------------------------------------------------%
%->> Renew control command
%---------------------------------------------------------------------------%
%- Redefine \tableofcontents
\providecommand{\tableofcontents}{}
\let\tableofcontentsORIG\tableofcontents
\renewcommand{\tableofcontents}{
    \begingroup%
    \ctexset{chapter = {
        format = \linespread{1.0}\zihao{3}\bfseries\heiti\centering,
        beforeskip = {10pt},
        afterskip = {30pt},
    }}%
    \szu@clearpage\newgeometry{hmargin=1.23in,vmargin=1in}%
    \pagestyle{empty}\linespread{1.3}\tableofcontentsORIG%
    \szu@clearpage\restoregeometry%
    \endgroup%
}
%- \szubibliography
\renewcommand*{\bibfont}{\zihao{5}}
\newcommand*{\szubibliography}{%
    \szu@addtotoc{参考文献}%
    \printbibliography[title={参\ \ 考\ \ 文\ \ 献}]
}
%- Redefine \frontmatter to include the change
\providecommand{\frontmatter}{}% compatibility for non-book classes
\renewcommand{\frontmatter}{%
    \szu@clearpage%
    \@mainmatterfalse%
    \pagenumbering{Roman}%
}
%- Redefine \mainmatter
\providecommand{\mainmatter}{}% compatibility for non-book classes
\renewcommand{\mainmatter}{%
    \szu@clearpage%
    \@mainmattertrue%
    \pagenumbering{arabic}%
    \pagestyle{mainmatterstyle}%
}
%- Redefine \backmatter
\providecommand{\backmatter}{}% compatibility for non-book classes
\let\backmatterORIG\backmatter
\renewcommand{\backmatter}{%
    \backmatterORIG%
    \ctexset{chapter/format = \linespread{1.0}\zihao{3}\bfseries\heiti\centering}%
}
%---------------------------------------------------------------------------%
%->> new command
%---------------------------------------------------------------------------%
\newcommand*{\szu@addtotoc}[1]{
    \szu@clearpage%
    \ifdefined\phantomsection\phantomsection\fi% create bookmark link if hyperref
    \addcontentsline{toc}{chapter}{#1}% add to content
}
\newcommand*{\szuaddpdf}[2][]{
    \clearpage\newgeometry{hmargin=20mm,vmargin=25mm}\fancyhfoffset{-5mm}
    \szu@ifstrbk{#1}{}{\szu@addtotoc{#1}}%
    \begin{figure}[!h]
        \includegraphics[width=\textwidth]{#2}
    \end{figure}
    \clearpage\restoregeometry\fancyhfoffset{0mm}
}
%---------------------------------------------------------------------------%
\endinput

