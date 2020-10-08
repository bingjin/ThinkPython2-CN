第十六章：类和函数
========================

现在我们已经知道如何去定义一个新的类型，下一步就是编写以自定义对象为参数的函数，并返回自定义对象作为结果。在本章中，我还将介绍“函数式编程风格”和两种新的编程开发方案。

本章的代码示例可以从 http://thinkpython2.com/code/Time1.py 下载。练习的答案可以从 http://thinkpython2.com/code/Time1_soln.py 下载。

.. _isafter:

时间
--------

再举一个程序员自定义类型的例子，我们定义一个叫 ``Time`` 的类，用于记录时间。
这个类的定义如下：

::

    class Time:
        """Represents the time of day.

        attributes: hour, minute, second
        """

我们可以创建一个新的 ``Time`` 类对象，并且给它的属性 ``hour`` , ``minutes`` 和 ``seconds`` 赋值：

::

    time = Time()
    time.hour = 11
    time.minute = 59
    time.second = 30

\ ``Time``\ 对象的状态图类似于\ :ref:`fig.time`\ 。

我们做个练习，编写一个叫做 ``print_time`` 的函数，接收一个 ``Time`` 对象并用“时:分:秒”的格式打印它。
提示：格式化序列 ``'%.2d'`` 可以至少两位数的形式打印一个整数，如果不足则在前面补0。

编写一个叫做 ``is_after`` 的布尔函数，接收两个 ``Time`` 对象，``t1`` 和 ``t2`` ，若 ``t1`` 的时间在 ``t2`` 之后，
则返回 ``True`` ，否则返回 ``False`` 。挑战：不要使用 ``if`` 语句。

.. _fig.time:

.. figure:: figs/time.png
   :alt: 图16-1：对象图

   图16-1：对象图


纯函数
-----------

在下面几节中，我们将编写两个用来增加时间值的函数。
它们展示了两种不同的函数：纯函数（pure functions）和修改器（modifiers）。
它们也展示了我所称的 **原型和补丁（prototype and patch）** 的开发方案。
这是一种处理复杂问题的方法，从简单的原型开始，逐步解决复杂情况。

下面是一个简单的 ``add_time`` 原型：

::

    def add_time(t1, t2):
        sum = Time()
        sum.hour = t1.hour + t2.hour
        sum.minute = t1.minute + t2.minute
        sum.second = t1.second + t2.second
        return sum

这个函数创建了一个新的 ``Time`` 对象，初始化了对象的属性，并返回了这个对象的引用。
我们把这个函数称为 **纯函数（pure function）**，因为它除了返回一个值以外，并不修改作为参数传入的任何对象，
也没有产生如显示一个值或者获取用户输入的影响。

为了测试这个函数，我将创建两个 ``Time`` 对象：``start`` 用于存放一个电影
（如 Monty Python and the Holy Grail）的开始时间，``duration`` 用于存放电影的放映时长，这里时长定为1小时35分钟。

\ ``add_time``\ 将计算电影何时结束。

::

    >>> start = Time()
    >>> start.hour = 9
    >>> start.minute = 45
    >>> start.second =  0

    >>> duration = Time()
    >>> duration.hour = 1
    >>> duration.minute = 35
    >>> duration.second = 0

    >>> done = add_time(start, duration)
    >>> print_time(done)
    10:80:00


这个结果 10:80:00 可能不是你所希望得到的。问题在于这个函数并没有处理好秒数和分钟数相加超过60的情况。
当发生这种情况时，我们要把多余的秒数放进分钟栏，或者把多余的分钟加进小时栏。

下面是一个改进的版本：

::

    def add_time(t1, t2):
        sum = Time()
        sum.hour = t1.hour + t2.hour
        sum.minute = t1.minute + t2.minute
        sum.second = t1.second + t2.second

        if sum.second >= 60:
            sum.second -= 60
            sum.minute += 1

        if sum.minute >= 60:
            sum.minute -= 60
            sum.hour += 1

        return sum


这个函数虽然正确，但是它开始变得臃肿。我们会在后面看到一个较短的版本。

.. _increment:

修改器
-------------

有时候用函数修改作为参数传入的对象是很有用的。在这种情况下，这种改变对
调用者来说是可见的。这种方式工作的函数称为 **修改器（modifiers）**。

函数 ``increment`` 给一个 ``Time`` 对象增加指定的秒数，可以很自然地用修改器来编写。
下面是一个初稿：

::

    def increment(time, seconds):
        time.second += seconds

        if time.second >= 60:
            time.second -= 60
            time.minute += 1

        if time.minute >= 60:
            time.minute -= 60
            time.hour += 1


第一行进行基础操作；其余部分的处理则是我们之前看到的特殊情况。

这个函数正确吗？如果 ``seconds`` 比 60 大很多会发生什么？

在那种情况下，只进位一次是不够的；我们要重复执行直到 ``seconds`` 小于 60。一种
方法是用 ``while`` 语句代替 ``if`` 语句。这样能够让函数正确，但是并不是很高效。

我们做个练习：编写正确的 ``increment`` 函数，不能包含任何循环。

任何能够用修改器实现的函数同样能够用纯函数实现。事实上，一些编程语言只允许用纯函数。
一些证据表明用纯函数实现的程序比用修改器实现的函数开发更快、更不易出错。
但是有时候修改器是很方便的，而函数式程序效率反而不高。

通常来说，我推荐只要是合理的情况下，都使用纯函数方式编写，只在有完全令人信服的原因下采用修改器。
这种方法可以称为 **函数式编程风格（functional programming style）**。

我们做个练习，编写一个纯函数版本的 ``increment`` ，创建并返回一个 ``Time`` 对象，而不是修改参数。

.. _prototype:

原型 vs. 方案
----------------

我刚才展示的开发方案叫做 **原型和补丁（protptype and patch）**。
针对每个函数，我编写了一个可以进行基本运算的原型并对其测试，逐步修正错误。

这种方法在你对问题没有深入理解时特别有效。但增量修正可能导致代码过度复杂，
因为需要处理许多特殊情况。也并不可靠，因为很难知道你是否已经找到了所有的错误。

另一种方法叫做 **设计开发(designed development)** 。
对问题有高层次的理解能够使开发变得更容易。
这给我们的启示是，``Time`` 对象本质上是一个基于六十进制的三位数（详见 http://en.wikipedia.org/wiki/Sexagesimal 。）！
属性\ ``second``\ 是“个位”，属性 ``minute`` 是“六十位”，属性 ``hour`` 是“360位数”。

当我们编写 ``add_time`` 和 ``increment`` 时，其实是在基于六十进制累加，
所以我们需要把一位进位到下一位。

这个观察意味着我们可以用另一种方法去解决整个问题——我们可以把 ``Time`` 对象转换为整数，
并利用计算机知道如何进行整数运算的这个事实。

下面是一个把 ``Time`` 对象转成整数的函数：
::

    def time_to_int(time):
        minutes = time.hour * 60 + time.minute
        seconds = minutes * 60 + time.second
        return seconds

下面则是一个把整数转换为 ``Time`` 对象（记得 ``divmod`` 是用第一个参数除以第二个参数并以
元组的形式返回商和余数）。

::

    def int_to_time(seconds):
        time = Time()
        minutes, time.second = divmod(seconds, 60)
        time.hour, time.minute = divmod(minutes, 60)
        return time

你可能需要思考一下，并运行一些测试，以此来说服自己这些函数是正确的。
一种测试方法是对很多的 ``x`` 检查 ``time_to_int(int_to_time(x)) == x`` 是否正确。
这是一致性检查的例子。


一旦你确信它们是正确的，你就能使用它们重写 ``add_time`` ：

::

    def add_time(t1, t2):
        seconds = time_to_int(t1) + time_to_int(t2)
        return int_to_time(seconds)


这个版本比先前的要更短，更容易校验。我们再做个练习，使用 ``time_to_int`` 和 ``int_to_time`` 重写 ``increment`` 函数。

从某个方面来说，六十进制和十进制相互转换比处理时间更难些。进制转换更加抽象；
我们解决时间值的想法是更好的。

但如果我们意识到把时间当作六十进制，并预先做好编写转换函数（ ``time_to_int``
和 ``int_to_time`` ）的准备，我们就能获得一个更短、更易读、更可靠的程序。

这让我们日后更加容易添加其它功能。例如，试想将两个 ``Time`` 对象相减来获得它们之间的时间间隔。
最简单的方法是使用借位来实现减法。使用转换函数则更容易，也更容易正确。

讽刺的是，有时候把一个问题变得更难（或更加普遍）反而能让它更加简单
（因为会有更少的特殊情况和更少出错的机会）。


调试
-------

如果 ``minute`` 和 ``second`` 的值介于 0 和 60 之间（包括 0 但不包括 60 ），并且 ``hour`` 是正值，那么这个 ``Time`` 对象就是合法的。``hour`` 和 ``minute`` 应该是整数值，
但我们可能也允许 
\ ``second``\ 有小数部分。

这样的要求称为 **不变式（invariants）**。因为它们应当总是为真。
换句话说，如果它们不为真，肯定是某些地方出错了。

编写代码来检查不变式能够帮助检测错误并找到出错的原因。
例如，你可能会写一个 ``valid_time`` 这样的函数，
接受一个 ``Time`` 对象，并在违反不变式的条件下返回 ``False`` ：

::

    def valid_time(time):
        if time.hour < 0 or time.minute < 0 or time.second < 0:
            return False
        if time.minute >= 60 or time.second >= 60:
            return False
        return True

在每个函数的开头，你可以检查参数，确认它们是否合法：

::

    def add_time(t1, t2):
        if not valid_time(t1) or not valid_time(t2):
            raise ValueError('invalid Time object in add_time')
        seconds = time_to_int(t1) + time_to_int(t2)
        return int_to_time(seconds)

或者你可以使用 **assert语句**，检查一个给定的不变式并在失败的情况下抛出异常：

::

    def add_time(t1, t2):
        assert valid_time(t1) and valid_time(t2)
        seconds = time_to_int(t1) + time_to_int(t2)
        return int_to_time(seconds)

\ ``assert``\ 语句非常有用，因为它们区分了处理普通条件的代码和检查错误的代码。


术语表
-------

原型和补丁（prototype and patch）：

    一种开发方案，编写一个程序的初稿，测试，发现错误时修正它们。

设计开发（designed development）：


    一种开发方案，需要对问题有更高层次的理解，比增量开发或原型开发更有计划性。

纯函数（pure function）：

    一种不修改任何作为参数传入的对象的函数。大部分纯函数是有返回值的（fruitful）。

修改器（modifier）：

    一种修改一个或多个作为参数传入的对象的函数。大部分修改器没有返回值；即返回 ``None`` 。

函数式编程风格（functional programming style）：

    一种程序设计风格，大部分函数为纯函数。


不变式（invariant）：

    在程序执行过程中总是为真的条件。

断言语句（assert statement）：

    一种检查条件是否满足并在失败的情况下抛出异常的语句。


练习题
---------

本章的代码示例可以从 http://thinkpython2.com/code/Time1.py 下载；
练习的答案可以从 http://thinkpython2.com/code/Time1_soln.py 下载。

习题16-1
^^^^^^^^^^^^^

编写一个叫做 ``mul_time`` 的函数，接收一个 ``Time`` 对象和一个数，并返回一个新的 ``Time`` 对象，包含原始时间和数的乘积。


然后使用 ``mul_time`` 编写一个函数，接受一个表示比赛完赛时间的 ``Time`` 对象以及一个表示距离的数字，并返回一个用于表示平均配速（每英里所需时间）的 ``Time`` 对象。

习题16-2
^^^^^^^^^^^^^

\ ``datetime``\ 模块提供的 ``time`` 对象，和本章的 ``Time`` 对象类似，但前者提供了更丰富的方法和操作符。可以在 http://docs.python.org/3/library/datetime.html 阅读相关文档。

#. 使用 ``datetime`` 模块来编写一个程序，获取当前日期并打印当天是周几。

#. 编写一个程序，接受一个生日作为输入，并打印用户的年龄以及距离下个生日所需要的天数、小时数、分钟数和秒数。

#. 对于两个不在同一天出生的人来说，总有一天，一个人的出生天数是另一个人的两倍。
   我们把这一天称为“双倍日”。编写一个程序，接受两个不同的出生日期，并计算他们的“双倍日”。

#. 再增加点挑战，编写一个更通用的版本，用于计算一个人出生天数是另一个人 :math:`n` 倍的日子。

答案：\ http://thinkpython2.com/code/double.py \ 。


**贡献者**
^^^^^^^^^^^

#. 翻译：`@cxyfreedom`_
#. 校对：`@bingjin`_
#. 参考：`@carfly`_

.. _@cxyfreedom: https://github.com/cxyfreedom
.. _@bingjin: https://github.com/bingjin
.. _@carfly: https://github.com/carfly
