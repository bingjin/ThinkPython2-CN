第十四章：文件
==================

本章将介绍“持久（persistent）”程序的概念，即永久储存数据的程序，并说明如何使用不同种类的永久存储形式，例如文件和数据库。

持久化
-----------

目前我们所见到的大多数程序都是临时的（transient），
因为它们只运行一段时间并输出一些结果，但当它们结束时，数据也就消失了。
如果你再次运行程序，它将以全新的状态开始。

另一类程序是 **持久（persistent）** 的：它们长时间运行（或者一直在运行）；
它们至少将一部分数据记录在永久存储（如一个硬盘中）；
如果你关闭程序然后重新启动时，它们将从上次中断的地方开始继续。

持久程序的一个例子是操作系统，在一台电脑开机后的绝大多数时间系统都在运行。
另一个例子是网络服务器，不停地在运行，等待来自网络的请求。

程序保存其数据的一个最简单方法，就是读写文本文件。
我们已经接触过读取文本文件的程序；在本章，我们将接触写入文本的程序。

另一种方法是使用数据库保存程序的状态。本章我将介绍一个简单的数据库，
以及简化存储程序数据过程的 ``pickle`` 模块。

读取和写入
-------------------

文本文件是储存在类似硬盘、闪存、或者CD-ROM等永久介质上的字符序列。我们在\ :ref:`wordlist`\ 一节中接触了如何打开和读取文件。

要写入一个文件，你必须在打开文件时设置第二个参数来为 ``'w'`` 模式：

::

    >>> fout = open('output.txt', 'w')

如果该文件已经存在，那么用写入模式打开它将会清空原来的数据并从新开始，所以要小心！
如果文件不存在，那么将创建一个新的文件。

\ ``open``\ 会返回一个文件对象，该对象提供了操作文件的方法。``write`` 方法将数据写入文件。

::

    >>> line1 = "This here's the wattle,\n"
    >>> fout.write(line1)
    24

返回值是被写入字符的个数。文件对象将跟踪自身的位置，所以下次你调用 ``write`` 的时候，它会在文件末尾添加新的数据。

::

    >>> line2 = "the emblem of our land.\n"
    >>> fout.write(line2)
    24

完成文件写入后，你应该关闭文件。

::

    >>> fout.close()

如果你不关闭这个文件，程序结束时它才会关闭。

格式化运算符
---------------

\ ``write``\ 的参数必须是字符串，所以如果想要在文件中写入其它值，
我们需要先将它们转换为字符串。最简单的法是使用 ``str`` ：

::

    >>> x = 52
    >>> fout.write(str(x))

另一个方法是使用 **格式化运算符（format operator）** ，即 ``%``。
作用于整数时，``%`` 是取模运算符，而当第一个运算数是字符串时，``%`` 则是格式化运算符。

第一个运算数是 **格式化字符串（format string）** ，它包含一个或多个 **格式化序列（format sequence）** 。格式化序列指定了第二个运算数是如何格式化的。运算结果是一个字符串。

例如，格式化序列 ``'%d'`` 意味着第二个运算数应该被格式化为一个十进制整数：

::

    >>> camels = 42
    >>> '%d' % camels
    '42'

结果是字符串 ``'42'`` ，需要和整数值 42 区分开来。

一个格式化序列可以出现在字符串中的任何位置，所以可以将一个值嵌入到一个语句中：

::

    >>> 'I have spotted %d camels.' % camels
    'I have spotted 42 camels.'

如果字符串中有多个格式化序列，那么第二个参数必须是一个元组。
每个格式化序列按顺序和元组中的元素对应。

下面的例子中使用 ``'%d'`` 来格式化一个整数， ``'%g'`` 来格式化一个浮点数，以及 ``'%s'`` 来格式化一个字符串：

::

    >>> 'In %d years I have spotted %g %s.' % (3, 0.1, 'camels')
    'In 3 years I have spotted 0.1 camels.'

元组中元素的个数必须等于字符串中格式化序列的个数。
同时，元素的类型也必须符合对应的格式化序列：

::

    >>> '%d %d %d' % (1, 2)
    TypeError: not enough arguments for format string
    >>> '%d' % 'dollars'
    TypeError: %d format: a number is required, not str

在第一个例子中，元组中没有足够的元素；在第二个例子中，元素的类型错误。

可以在 https://docs.python.org/3/library/stdtypes.html#printf-style-string-formatting 中了解关于格式化运算符的更多信息。
一个更为强大的方法是使用字符串的 ``format`` 方法，可以前往 https://docs.python.org/3/library/stdtypes.html#str.format 中了解。

文件名和路径
-------------------

文件以 **目录（directory）** （也称为“文件夹（folder）”）的形式组织起来。
每个正在运行的程序都有一个“当前目录（current directory）”作为大多数操作的默认目录。
例如，当你打开一个文件来读取时，Python 会在当前目录下寻找这个文件。

\ ``os``\ 模块提供了操作文件和目录的函数（“os”代表“operating system”）。``os.getcwd`` 返回当前目录的名称：

::

    >>> import os
    >>> cwd = os.getcwd()
    >>> cwd
    '/home/dinsdale'

\ ``cwd``\ 代表“current working directory”，即“当前工作目录”。
在本例中，返回的结果是 ``/home/dinsdale`` ，即用户名为 ``dinsdale`` 的主目录。

类似 ``'/home/dinsdale'`` 这样的字符串指明一个文件或者目录，叫做 **路径（path）** 。

一个简单的文件名，如 ``memo.txt`` ，同样被看做是一个路径，只不过是 **相对路径（relative path）** ，因为它是相对于当前目录而言的。如果当前目录是 ``/home/dinsdale`` ，那么文件名 ``memo.txt`` 就代表 ``/home/dinsdale/memo.txt`` 。

一个以 ``/`` 开头的路径和当前目录无关，叫做 **绝对路径（absolute path）**。要获得一个文件的绝对路径，你可以使用 ``os.path.abspath`` ：

::

    >>> os.path.abspath('memo.txt')
    '/home/dinsdale/memo.txt'

\ ``os.path``\ 还提供了其它函数来对文件名和路径进行操作。例如，``os.path.exists`` 检查一个文件或者目录是否存在：

::

    >>> os.path.exists('memo.txt')
    True

如果存在，可以通过 ``os.path.isdir`` 检查它是否是一个目录：

::

    >>> os.path.isdir('memo.txt')
    False
    >>> os.path.isdir('/home/dinsdale')
    True

类似的，``os.path.isfile`` 检查它是否是一个文件。

\ ``os.listdir``\ 返回给定目录下的文件列表（以及其它目录）。

::

    >>> os.listdir(cwd)
    ['music', 'photos', 'memo.txt']

接下来演示下以上函数的使用。下面的例子“遍历”一个目录，打印所有文件的名字，并且针对其中所有的目录递归的调用自身。

::

    def walk(dirname):
        for name in os.listdir(dirname):
            path = os.path.join(dirname, name)

            if os.path.isfile(path):
                print(path)
            else:
                walk(path)

\ ``os.path.join``\ 接受一个目录和一个文件名，并把它们合并成一个完整的路径。

os模块提供了一个叫做 ``walk`` 的函数，和我们上面写的类似，但是功能更加更富。
作为练习，阅读文档并且使用 ``walk`` 打印出给定目录下的文件名和子目录。
你可以从 http://thinkpython2.com/code/walk.py 下载我的答案。

捕获异常
-------------------

试图读写文件时，很多地方可能会发生错误。如果你试图打开一个不存在的文件夹，
会得到一个输入输出错误（IOError）：

::

    >>> fin = open('bad_file')
    IOError: [Errno 2] No such file or directory: 'bad_file'

如果你没有权限访问一个文件：

::

    >>> fout = open('/etc/passwd', 'w')
    PermissionError: [Errno 13] Permission denied: '/etc/passwd'

如果你试图打开一个目录来读取，你会得到：

::

    >>> fin = open('/home')
    IsADirectoryError: [Errno 21] Is a directory: '/home'

为了避免这些错误，你可以使用类似 ``os.path.exists`` 和 ``os.path.isfile`` 的函数来检查，但这将会耗费大量的时间和代码去检查所有的可能性（从“Errno 21”这个错误信息来看，至少有21种可能出错的情况）。

更好的办法是在问题出现的时候才去处理，而这正是 ``try`` 语句做的事情。
它的语法类似 ``if...else`` 语句：

::

    try:
        fin = open('bad_file')
    except:
        print('Something went wrong.')

Python 从 ``try`` 子句（clause）开始执行。
如果一切正常，那么 ``except`` 子句将被跳过。
如果发生异常，则跳出 ``try`` 子句，执行 ``except`` 子句。

使用 ``try`` 语句处理异常被称为是 **捕获（catching）** 异常。
在本例中，``except`` 子句打印出一个并非很有帮助的错误信息。
一般来说，捕获异常后你可以选择是否解决这个问题，或者继续尝试运行，又或者至少优雅地结束程序。

数据库
---------

\ **数据库**\ 是一个用来存储数据的文件。
大多数的数据库采用类似字典的形式，即将键映射到值。
数据库和字典的最大区别是，数据库是存储在硬盘上（或者其他永久存储中），
所以即使程序结束，它们依然存在。

\ ``dbm``\ 模块提供了一个创建和更新数据库文件的接口。
举个例子，我接下来创建建一个包含图片文件标题的数据库。

打开数据库和打开其它文件的方法类似：

::

    >>> import dbm
    >>> db = dbm.open('captions', 'c')

模式 ``'c'`` 代表如果数据库不存在则创建该数据库。
这个操作返回的是一个数据库对象，可以像字典一样使用它（对于大多数操作）。

当你创建一个新项时，``dbm`` 将更新数据库文件。

::

    >>> db['cleese.png'] = 'Photo of John Cleese.'

当你访问某个项时，``dbm`` 将读取文件：

::

    >>> db['cleese.png']
    b'Photo of John Cleese.'

返回的结果是一个 **字节对象（bytes object）** ，这就是为什么结果以 ``b`` 开头。
一个字节对象在很多方面都和一个字符串很像。但是当你深入了解 Python 时，
它们之间的差别会变得很重要，但是目前我们可以忽略掉那些差别。

如果你对已有的键再次进行赋值，``dbm`` 将把旧的值替换掉：

::

    >>> db['cleese.png'] = 'Photo of John Cleese doing a silly walk.'
    >>> db['cleese.png']
    b'Photo of John Cleese doing a silly walk.'

一些字典方法，例如 ``keys`` 和 ``items`` ，不适用于数据库对象，但是 ``for`` 循环依然适用：

::

    for key in db:
        print(key, db[key])

与其它文件一样，当你完成操作后需要关闭文件：

::

    >>> db.close()

序列化
--------

\ ``dbm`` 的一个限制在于键和值必须是字符串或者字节。
如果你尝试去用其它数据类型，你会得到一个错误。

\ ``pickle``\ 模块可以解决这个问题。它能将几乎所有类型的对象转化为适合在数据库中存储的字符串，以及将那些字符串还原为原来的对象。

\ ``pickle.dumps``\ 读取一个对象作为参数，并返回一个字符串表示（``dumps`` 是“dump string”的缩写）：

::

    >>> import pickle
    >>> t = [1, 2, 3]
    >>> pickle.dumps(t)
    b'\x80\x03]q\x00(K\x01K\x02K\x03e.'

这个格式对人类来说不是很直观，但是对 ``pickle`` 来说很容易去解释。``pickle.loads`` （“load string”）可以重建对象：

::

    >>> t1 = [1, 2, 3]
    >>> s = pickle.dumps(t1)
    >>> t2 = pickle.loads(s)
    >>> t2
    [1, 2, 3]

尽管新对象和旧对象有相同的值，但它们（一般来说）不是同一个对象：

::

    >>> t1 == t2
    True
    >>> t1 is t2
    False

换言之，序列化然后反序列化等效于复制一个对象。

你可以使用 ``pickle`` 将非字符串对象存储在数据库中。
事实上，这个组合非常常用，已经被封装进了模块 ``shelve`` 中。

管道
--------

大多数的操作系统提供了一个命令行的接口，也被称为 **shell** 。
shell通常提供浏览文件系统和启动程序的命令。
例如，在Unix系统中你可以使用 ``cd`` 改变目录，使用 ``ls`` 显示一个目录的内容，
通过输入 ``firefox`` （举例来说）来启动一个网页浏览器。

任何可以在shell中启动的程序，也可以在 Python 中通过使用 **管道对象（pipe object）** 来启动。一个管道代表着一个正在运行的程序。

例如，Unix 命令 ``ls -l`` 将以详细格式显示当前目录下的内容。
你可以使用 ``os.popen`` 来启动 ``ls`` ：

::

    >>> cmd = 'ls -l'
    >>> fp = os.popen(cmd)

实参是一个包含shell命令的字符串。返回值是一个行为类似已打开文件的对象。
你可以使用 ``readline`` 来每次从 ``ls`` 进程的输出中读取一行，或者使用 ``read`` 来一次读取所有内容：

::

    >>> res = fp.read()

当你完成操作后，像关闭一个文件一样关闭管道：

::

    >>> stat = fp.close()
    >>> print(stat)
    None

返回值是 ``ls`` 进程的最终状态。``None`` 表示正常结束（没有出现错误）。

例如，大多数 Unix 系统提供了一个叫做 ``md5sum`` 的命令，来读取一个文件的内容并计算出一个“校验和（checksum）”。
你可以在 http://en.wikipedia.org/wiki/Md5 中了解更多MD5的信息。不同的内容产生相同校验和的概率非常小（也就是说，在宇宙坍塌之前是不可能的）。

你可以使用一个管道来从 Python 中运行 ``md5sum`` ，并得到计算结果：

::

    >>> filename = 'book.tex'
    >>> cmd = 'md5sum ' + filename
    >>> fp = os.popen(cmd)
    >>> res = fp.read()
    >>> stat = fp.close()
    >>> print(res)
    1e0033f0ed0656636de0d75144ba32e0  book.tex
    >>> print(stat)
    None

编写模块
---------------

任何包含 Python 代码的文件，都可以作为模块被导入。
例如，假设你有包含以下代码的文件 ``wc.py`` ：

::

    def linecount(filename):
        count = 0
        for line in open(filename):
            count += 1
        return count

    print(linecount('wc.py'))

如果你运行这个程序，它将读取自身并打印文件的行数，结果是 7 。
你也可以这样导入模块：

::

    >>> import wc
    7

现在你有了一个模块对象 ``wc`` ：

::

    >>> wc
    <module 'wc' from 'wc.py'>

这个模块对象提供了 ``linecount`` 函数：

::

    >>> wc.linecount('wc.py')
    7

以上就是如何编写 Python 模块的方法。

这个例子中唯一的问题在于，当你导入模块后，它将自动运行最后面的测试代码。
通常当导入一个模块时，它将定义一些新的函数，但是并不运行它们。

作为模块的程序通常写成以下结构：

::

    if __name__ == '__main__':
        print(linecount('wc.py'))

\ ``__name__``\ 是一个在程序开始时设置好的内建变量。
如果程序以脚本的形式运行，``__name__`` 的值为 ``__main__`` ，这时其中的代码将被执行。否则当被作为模块导入时，其中的代码将被跳过。

我们做个练习，将例子输入到文件 ``wc.py`` 中，然后以脚本形式运行它。
接着，打开 Python 解释器并导入 ``wc`` 。当模块被导入后， ``__name__`` 的值是什么？

警示：如果你导入一个已经被导入了的模块，Python 将不会做任何事情。它并不会重新读取文件，即使文件的内容已经发生了改变。

如果你要重载一个模块，可以使用内建函数 ``reload`` ，但它可能会出错。因此最安全的方法是重启解释器，然后重新导入模块。

调试
---------

当你读写文件时，可能会遇到空白带来的问题。这些问题会很难调试，因为空格、制表符和换行符通常是看不见的：

::

    >>> s = '1 2\t 3\n 4'
    >>> print(s)
    1 2  3
     4

内建函数 ``repr`` 可以用来解决这个问题。它接受任意一个对象作为参数，然后返回一个该对象的字符串表示。对于空白符号，它将用反斜杠序列表示：

::

    >>> print(repr(s))
    '1 2\t 3\n 4'

这个对于调试会很有用。

另一个你可能会遇到的问题是，不同的的系统使用不同的符号来表示一行的结束。
有些系统使用换行符 ``\n`` ，有的使用返回符号 ``\r`` ，有些两者都使用。
如果你在不同的系统中移动文件，这些差异会导致问题。

对大多数的系统，有一些转换不同格式文件的应用。
你可以在 http://en.wikipedia.org/wiki/Newline 中找到这些应用的信息（并阅读更多相关内容）。当然，你也可以自己编写一个转换程序。

术语表
--------

持久性（persistent）：

	用于描述长期运行并至少将一部分自身的数据保存在永久存储中的程序。

格式化运算符（format operator）：

	运算符 %。读取一个格式化字符串和一个元组，生成一个包含元组中元素的字符串，按照格式化字符串的要求格式化。

格式化字符串（format string）：

	一个包含格式化序列的字符串，和格式化运算符一起使用。

格式化序列（format sequence）：

	格式化字符串中的一个字符序列，例如 %d ，指定了一个值的格式。

文本文件（text file）：

	保存在类似硬盘的永久存储设备上的字符序列。

目录（directory）：

	一个有命名的文件集合，也叫做文件夹。

路径（path）：

	一个指定一个文件的字符串。

相对路径（relative path）：

	从当前目录开始的路径。

绝对路径（absolute path）：

	从文件系统顶部开始的路径。

捕获（catch）：

	为了防止程序因为异常而终止，使用 ``try`` 和 ``except`` 语句来捕捉异常。

数据库（database）：

	一个内容结构类似字典的文件，将键映射至对应的值。

字节对象（bytes object）：

	和字符串类的对象。

shell：

	一个允许用户输入命令，并通过启用其它程序执行命令的程序。

管道对象（pipe object）：

	一个代表某个正在运行的程序的对象，允许一个 Python 程序去运行命令并得到运行结果。

练习题
---------

习题14-1
^^^^^^^^^^^

编写一个叫做 ``sed`` 的函数，它的参数是一个模式字符串（pattern string），一个替换字符串和两个文件名。
它应该读取第一个文件，并将内容写入到第二个文件（需要时创建它）。
如果在文件的任何地方出现了模式字符串，就用替换字符串替换它。

如果在打开、读取、写入或者关闭文件时出现了错误，你的程序应该捕获这个异常，打印一个错误信息，并退出。

答案： http://thinkpython2.com/code/sed.py 。

习题14-2
^^^^^^^^^^^^

如果你从 http://thinkpython2.com/code/anagram_sets.py 下载了\ :ref:`anagrams`\ 的答案，你会看到答案中创建了一个字典，
将从一个由排序后的字母组成的字符串映射到一个可以由这些字母拼成的单词组成的列表。例如， ``'opst'`` 映射到列表 ``['opts', 'post', 'pots', 'spot', 'stop', 'tops']`` 。

编写一个模块，导入 ``anagram_sets`` 并提供两个新函数：函数 ``store_anagrams`` 在将 ``anagram`` 字典保存至 ``shelf``中； ``read_anagrams`` 查找一个单词，并返回它的 ``anagrams`` 列表。

答案： http://thinkpython2.com/code/anagram_db.py 。

习题14-3
^^^^^^^^^^^

在一个很大的MP3文件集合中，或许会有同一首歌的不同拷贝，
它们存放在不同的目录下或者有不同的名字。这个练习的目的是检索出这些拷贝。

#. 编写一个程序，搜索一个目录和它的所有子目录，并返回一个列表，列表中包含所有的有给定后缀（例如.mp3）的文件的完整路径。提示：``os.path`` 提供了一些可以操作文件和路径名的函数。

#. 为了识别出重复的文件，你可以使用 ``md5sum`` 来计算每个文件的“校验和”。如果两个文件的校验和相同，它们很可能有相同的内容。

#. 你可以使用Unix命令 ``diff`` 再确认一下。

答案: http://thinkpython2.com/code/find_duplicates.py 。

**贡献者**
^^^^^^^^^^^

#. 翻译：`@obserthinker`_
#. 校对：`@bingjin`_
#. 参考：`@carfly`_

.. _@obserthinker: https://github.com/obserthinker
.. _@bingjin: https://github.com/bingjin
.. _@carfly: https://github.com/carfly   
