# vim74-32bit-with-ycm-for-windows

vim74 32bit with youcompleteme for windows 是专门为希望在 windowss 下使用 gvim 编程并启用 YouCompleteMe
进行补全的朋友们准备。

该项目的目的是：省去自己编译 gvim 和 youcompleteme 的麻烦，同时可以轻松移植到其他的 windows 电脑
中，甚至你可以放在 U 盘中。更值得的庆幸的是，你不要为了在 windows 中使用 C++ 编程而下载安装 20 G
左右的 visual studio 了（也不需要像其他伙伴一样为了使用 vim 的自动补全不得不安装 vs，尽管不使用
vs（但 youcompleme 需要，只是为了这个而下载 vs，好像不划算吧），甚至有个小伙伴为了使用 youcompleteme
还不得不下载 vs、cmake 等进行编译，而且运行的时候，还需要 vs 运行库支持，而且对版本还有要求，明显
移植性不行吧）、也不需要为了使用 vim 的 perl、lua 等接口特性而安装 perl、lua 等不需要的软件了。

本项目还配置了编译（F8 或 F9，其中 F8 针对 vs2008，要使用本功能，需要下载本人 vs2008 项目，并做相应
的设置）运行（F10 或 F11）、代码美化（F3）等快捷键。而且在 quichfix 中集成了编译错误信息展示，以及
集成了 ctag、cscope 等功能（对于其他功能，你可以打开 _vimrc 文件查看其中的文字说明）。

为了适应 window 下操作，还定制了 windoss 的快捷键 ctrl-c、ctrl-v、ctrl-s、ctrl-z、alt-h、alt-l 等。

# 该项目提供的功能

+ 带有 ```python、python3、lua、ruby、perl``` 等接口的gvim和vim；
+ 配置有符合 windows 操作习惯的 _vimrc 文件；
+ 配有插件管理器 pathogen.vim ，从而所有插件放在 vimfiles 文件夹中；
+ vimfiles 文件夹中有 ```gvim 编程帮助```，记录了常见的问题和脚本；
+ 该 gvim 默认配置的是 ```solarized``` 主题；
+ 含有 ```youcompleteme 、vim-javacomplete2``` 等插件

# 本项目特色

克隆之后，将 vimfile/bundle 目录下的 YouCompleteMe.rar 解压到当前文件夹（由于 github 支持的目录文件名有限制，
所以压缩之后才上传的）中s 安装 32 位的 ```python 2.7.x```（其中 ```x >= 10```，建议 x 最新为好），
添加 python 路径到 path 中，同时添加 gvim/vim74/bin 到 path 中，最后把 vimfiles 目录
下的 ```gvim 编程帮助``` 中的字体文件放到系统的字体文件夹（为了配合插件 powerline 的
显示要求）中即可使用其中的所有功能，不需要编译 youcompleteme ，
也不需要安装 lua、perl 等环境（因为所需要的运行库已经存放在 vim74 目录下）。

如果需要添加自己的插件，只要把插件的文件夹放入 vimfiles 目录下即可（当然，还
需要根据插件的要求在 _vimrc 文件中添加相应内容）。如果不需要其中的某个插件
，则只要删除相应文件夹即可。如果您有兴趣的话，可以用 vundle 管理器对插件进行
自动管理。

不过在使用 vundle 管理时，最好不要替换本项目中 ```echofun 、autotag``` 插件，
因为这两个插件是为了配合本项目而特别定制过的。

# 特别注意

要想使用 youcompleteme 自动补全 c/c++ 需要修改 ycm 中的配置文件和 _vimrc 中
有关 ycm 的路径（在 gvim 中通过 ycm 定位到对应路径，根据 gvim 存放的位置修改
相应的路径，同时也可以看到 ycm 配置文件所在的位置，等下修改配置文件时需要
通过该路径找到这两个文件）。

修改好 _vimrc 中关于 youcompleteme 路径信息之后，找到它的配置文件（比如，
E:/gvim/vimfiles/bundle/YouCompleteMe/python中的 .ycm_extra_conf.py 和 .ycm_extra_conf_c.py）
进行修改。修改流程如下：

通过以下命令找到 gcc/g++ 的搜索路径信息：

+ cmd 中使用命令 ```g++ -E -x c++ - -v < nul```（查看 gcc 则将 g++ 替换成
gcc 即可，查看 c 则将 c++ 替换成 c 即可）；
+ 显示出的内容中 search starts here --- End of search list 之间的内容就是编译器默认的头文件搜索路径；
然后将其中的路径信息替换掉 .ycm_extra_conf.py（对于 C++）和 .ycm_extra_conf_c.py（对于 c）中有关
路径的信息（注意路径分隔符使用```/```，而不是```\```，所以需要改正，不能直接复制粘贴）；
+ 然后编辑一个 cpp 文件进行测试（当然编译之前要添加 gcc 或 g++ 的路径到 path 中，也就是说要保证
在 cmd 中输入 gcc -v 或 g++ -v 有版本信息输出）

*如果你没有 gcc 或 g++ ，则你需要安装 MinGW 或 cygwin（可以参考使用这些类linux环境是如何搭建 C/C++ 开发环境的） 
等下的 gcc 或 g++ 编译器。*（当然，如果你是 java 爱好者也可以使用本项目进行 java 开发，只要你配置好 java SDk 开发环境，
调试环境和构建环境，比如 jdb、ant等。）

当然不想使用 gcc 或 g++ 等，而想使用 VC 或 VC++，但又不想安装 VS 的小伙伴可以克隆本人的另一个
项目 ```vc2008-for-gvim-or-other-editor``` 并且将其中的 ```.ycm_extra_conf.py``` 文件替换前面提到
的 ```.ycm_extra_conf.py``` 文件。也可以根据```vc2008-for-gvim-or-other-editor```中的指南操作。

有什么问题请联系 socojo@qq.com ，说明问题的时候请写好主题和项目名称，以便更好的定位和为您解决问题。
