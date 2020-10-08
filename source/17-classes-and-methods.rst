第十七章：类和方法
===================

虽然我们已经在使用部分 Python 面向对象的特性，前两个章节中的程序并不是真正面向对象的，
因为它们没有呈现出程序员自定义类型与对其进行操作的函数（functions）之间的关系。
下一步，我们将会把这些函数转换成明显突出这一关系的方法（methods）。

本章代码可以从\ http://thinkpython2.com/code/Time2.py \ 获取，
练习题的答案位于\ http://thinkpython2.com/code/Point2_soln.py \ 。

面向对象的特性
------------------------

Python 是一门**面向对象的编程语言**，这意味它提供了能够支持面向对象编程的特性。
面向对象编程具有以下特征：

- 程序包含类和方法定义。

- 大部分计算以对象上的操作表示。

- 对象通常代表现实世界的物体，方法对应现实世界中物体交互的方式。

例如，第16章中定义的 ``Time`` 类对应人们用来记录一天中的时间，其中定义的各种函数对应人们使用时间的方式。类似的，第15章中的 ``Point`` 类和 ``Rectangle`` 类对应数学中点和矩形的概念。

到目前为止，我们还没有利用Python提供的支持面向对象编程的特性。这些特性严格来说并不是必须的；大部分提供的是我们已经实现的功能的替代语法。但在很多情况下，这些替代语法更加简洁，更准确地表达了程序的结构。

例如，在 ``Time1.py`` 中，类定义与之后的函数定义之间没有明显的联系。仔细检查之后，才会发现每个函数都至少接受一个 ``Time`` 对象作为参数。

从这个观察中我们发现了\ **方法**\ ；方法是一个与特定的类相关联的函数。我们已经接触了字符串、列表、字典和元组的方法。在这章中，我们将会定义程序员自定义类型的方法。

方法和函数的语义相同，但是有两处句法的不同：

-  方法在一个类定义内部声明，为的是显示地与类进行关联。

-  调用方法的语法和调用函数的语法不同。

在接下来的几节中，我们会把前面两章中的函数转化为方法。这个转化是纯机械式的；你可以通
过一系列步骤完成。如果你能够轻松地将一种形式转换成另一种形式，就可以选择最适合目前需求的形式。

打印对象
----------------

在第16章中，我们定义了一个名叫 ``Time`` 的类，在\ :ref:`isafter`\ 一节中，你编写了一个叫做 ``print_time`` 的函数：

::

    class Time:
        """Represents the time of day."""

    def print_time(time):
        print('%.2d:%.2d:%.2d' % (time.hour, time.minute, time.second))

想要调用这个函数，你必须把一个 ``Time`` 对象作为一个参数传递给函数。

::

    >>> start = Time()
    >>> start.hour = 9
    >>> start.minute = 45
    >>> start.second = 00
    >>> print_time(start)
    09:45:00

将 ``print_time`` 变成一个方法，我们只需要将函数定义移到类定义里面即可。注意缩进
的变化。

::

    class Time:
        def print_time(time):
            print('%.2d:%.2d:%.2d' % (time.hour, time.minute, time.second))

现在有两种方法可以调用\ ``print_time``\ 。第一种（也是不常用的）是使用函数的语法：

::

    >>> Time.print_time(start)
    09:45:00

在这个点标记法的用法中，``Time`` 是类的名字，\ ``print_time``\ 是方法的名字。``start`` 是传递的参数。

第二种语法（也更简洁）是使用方法语法：

::

    >>> start.print_time()
    09:45:00

在这个点标记法的用法中，\ ``print_time``\ 是方法的名称，然后 ``start`` 是调用方法的对象
，被称为主语（\ **subject**\ ）。就像一个句子的主语是句子的核心，方法的主语也是方
法作用的主要对象。

在方法中，主语被赋值为第一个参数，所以在这里 ``start`` 被赋值给 ``time`` 上了。

根据约定，方法的第一个参数写作 ``self`` ，所以\ ``print_time``\ 写成这样更常见：

::

    class Time:
        def print_time(self):
            print('%.2d:%.2d:%.2d' % (self.hour, self.minute, self.second))

使用该约定原因在于一种暗喻：

-  在函数调用的语法中，\ ``print_time(start)``\ 表示函数是一个活跃的代理。就像是在
   说“Hi, print_time! 这有一个对象需要你打印”。

-  在面向对象编程中，对象是活跃的代理。一个类似\ ``start.print_time()``\ 的方法
   调用，就像是在说“Hi start! 请打印你自己”。

视角的转换似乎让语气变得更文雅些了，但很难看出其好处。在前面的例子中，的确如此。
但是将职责从函数上面转移到对象上，可以更加容易地写出多样化的函数（或方法），并且代码将更加容易维护和复用。

我们做个练习，将 ``time_to_int`` （见 \ :ref:`prototype`\ ）重写为方法。你或许也想将 ``int_to_time`` 改写为方法，但是那样做并没有什么意义，因为没有调用它的对象。

再举一例
---------------

下面是 ``increment`` （见 \ :ref:`increment`\ ）改写为方法后的代码版本：

::

    # inside class Time:

        def increment(self, seconds):
            seconds += self.time_to_int()
            return int_to_time(seconds)

这个版本假设\ ``time_to_int``\ 已经改成了方法。另外，注意这是一个纯函数，不是修改器。

下面是调用 ``increment`` 的方法：

::

    >>> start.print_time()
    09:45:00
    >>> end = start.increment(1337)
    >>> end.print_time()
    10:07:17

主语 ``start`` 被赋值给第一个形参 ``self`` 。实参 1337 被赋值给第二个形参 ``seconds`` 。

这个机制有时会把人弄晕，尤其是你犯错的时候。例如，如果你使用两个实参调用 ``increment`` ， 你会得到：

::

    >>> end = start.increment(1337, 460)
    TypeError: increment() takes 2 positional arguments but 3 were given

错误信息一开始让人很难理解，因为在括号内只有两个实参。但是主语也被认为是一个实参，所以加在一起共有三个实参。

另外，**位置参数** 是没有形参名的参数；也就是说，它不是一个关键字参数。在下面这个函数调用中：

::

    sketch(parrot, cage, dead=True)

\ ``parrot``\ 和 \ ``cage``\ 是位置参数，而 ``dead`` 是一个关键字参数。

一个更复杂的例子
--------------------------

重写 ``is_after`` （见 \ :ref:`isafter`\ 一节）要更加复杂一些，因为它接受两个 ``Time`` 对象作为参数。在这个例子中，惯用的做法是将第一个形参命名为 ``self`` ，第二个形参命名为 ``other`` ：

::

    # inside class Time:

        def is_after(self, other):
            return self.time_to_int() > other.time_to_int()

要使用该方法的话，你必须在某个对象上调用它，并传入 ``other`` 的实参：

::

    >>> end.is_after(start)
    True

这个语法有一个好处，就是它读起来很像英语：“end是出现在start之后吗？”

init 方法
---------------

init 方法（“initialization”的简称）是一个特殊的方法，当一个对象初始化的时候调
用。它的全名是\ ``__init__``\ （两个下划线后加init再加两个下划线）。
一个 ``Time`` 类的 init 方法看起来像是这样的：

::

    # inside class Time:

        def __init__(self, hour=0, minute=0, second=0):
            self.hour = hour
            self.minute = minute
            self.second = second

通常\ ``__init__``\ 方法的参数和属性的名称一样。

::

            self.hour = hour

上面的语句把 ``hour`` 参数的值储存为 ``self`` 的一个属性。

参数是可选的，所以如果你不带参数的调用 ``Time`` ，你会得到默认值。

::

    >>> time = Time()
    >>> time.print_time()
    00:00:00

如果你提供一个参数，它会覆盖 ``hour`` ：

::

    >>> time = Time (9)
    >>> time.print_time()
    09:00:00

如果你提供两个参数，他们会覆盖 ``hour`` 和 ``minute`` 。
::

    >>> time = Time(9, 45)
    >>> time.print_time()
    09:45:00

如果你提供三个参数，它们会覆盖三个默认值。

我们做个练习，为 ``Point`` 类写一个 init 方法，使用 ``x`` 和 ``y`` 作为可选参数，然后赋值给对应的属性。

\_\_str\_\_ 方法
----------------------

``__str__``\ 是一个和\ ``__init__``\ 方法类似的特殊方法，返回一个对象的字符串表现形式。

例如，下面是一个 ``Time`` 对象的 ``str`` 方法：

::

    # inside class Time:

        def __str__(self):
            return '%.2d:%.2d:%.2d' % (self.hour, self.minute, self.second)

当你打印一个对象，Python 调用 str 方法：

::

    >>> time = Time(9, 45)
    >>> print(time)
    09:45:00

写一个新类时，我总是从\ ``__init__``\ 开始，使得更容易实例化对象，接着就是写\ ``__str__``\ 方法，方便调试。

我们做个练习，为 ``Point`` 类写一个 str 方法。然后创建一个 ``Point`` 对象并打印。

运算符重载
--------------------

通过定义其它的一些特殊方法，你可以在程序员自定义类型上指定运算符的行为。
例如，如果你为 ``Time`` 类定义了一个叫\ ``__add__``\ 的方法，你就可以在 ``Time`` 对象上使用 + 运算符。

可以大致像这样定义：

::

    # inside class Time:

        def __add__(self, other):
            seconds = self.time_to_int() + other.time_to_int()
            return int_to_time(seconds)

下面是使用方式：

::

    >>> start = Time(9, 45)
    >>> duration = Time(1, 35)
    >>> print(start + duration)
    11:20:00

当你在 ``Time`` 对象上应用 + 运算符，Python 会调用\ ``__add__``\ 。
当你打印结果时，Python 会调用\ ``__str__``\ 。
所以实际上后台发生了很多有趣的事情！

改变一个运算符的行为，使其兼容程序员自定义类型，这被称为\ **运算符重载（operator overloading）**\ 。
对于每一个运算符，Python 有一个类似\ ``__add__``\ 的对应的特殊方法。
更多的详情，请参考 http://docs.python.org/3/reference/datamodel.html#specialnames 。

我们做个练习，为 ``Point`` 类编写一个 add 方法。

类型分发（type-based dispatch）
----------------------------------

在上一节中，我们将两个 ``Time`` 对象相加，但是你还会想要将一个整数与 ``Time`` 对象相加。下面这个版本的 ``__add__`` 会检查 ``other`` 的类型，并相应地调用 ``add_time`` 或者 ``increment`` ：

::

    # inside class Time:

        def __add__(self, other):
            if isinstance(other, Time):
                return self.add_time(other)
            else:
                return self.increment(other)

        def add_time(self, other):
            seconds = self.time_to_int() + other.time_to_int()
            return int_to_time(seconds)

        def increment(self, seconds):
            seconds += self.time_to_int()
            return int_to_time(seconds)

内建函数 ``isinstance`` 接受一个值和一个类对象，如果值是这个类的实例则返回 ``True`` 。

如果 ``other`` 是一个 ``Time`` 对象，\ ``__add__``\ 调用\ ``add_time``\ 。
否则它假设参数是一个数字然后调用 ``increment`` 。
这个操作被称为\ **类型分发（type-based dispatch）**\ ，因为它根据参数的
类型将计算任务分发给不同的方法。

下面是一些在不同类型上使用 + 运算符的例子：

::

    >>> start = Time(9, 45)
    >>> duration = Time(1, 35)
    >>> print(start + duration)
    11:20:00
    >>> print(start + 1337)
    10:07:17

不幸的是，这个加法的实现没有交换性（commutative）。如果第一个运算数是一个整数，你会得到：

::

    >>> print(1337 + start)
    TypeError: unsupported operand type(s) for +: 'int' and 'instance'

问题在于，我们不是让一个 ``Time`` 对象去加一个整数，而是让一个整数去加一个 ``Time`` 对
象，但是Python不知道怎样去做。不过这个问题有一个优雅的解决方案：特殊方法 ``__radd__`` ，表示“右手加法”。当一个 ``Time`` 对象在 + 运算符的右手边出现时，调用这个方法。下面是定义：

::

    # inside class Time:

        def __radd__(self, other):
            return self.__add__(other)

接着是使用方法：

::

    >>> print(1337 + start)
    10:07:17

我们做个练习，为 ``Points`` 编写一个 add 方法，使其既适用 ``Point`` 对象，也适用元组：

-  如果第二个运算数是一个 ``Point`` ，该方法将返回一个新的 ``Point`` ，
   其\ :math:`x`\ 坐标是两个运算数的\ :math:`x`\ 的和，\ :math:`y` 以此类推。

-  如果第二个运算数是一个元组，该方法将把元组的第一个元素与\ :math:`x`\ 相加，
   第二个元素与\ :math:`y`\ 相加，然后返回以相关结果为参数的新的 ``Point`` 。

多态性
------------

类型分发在必要的时候非常有用，但是（幸运的是）它不是绝对必须的。
通常，你可以通过编写对不同参数类型都适用的函数，来避免这种情况。

许多我们为字符串写的函数，实际上也适用于其他序列类型。
例如，在\ :ref:`histogram`\ 一节中，我们使用 ``histogram`` 计算了单词中每个字母出现的次数。

::

    def histogram(s):
        d = dict()
        for c in s:
            if c not in d:
                d[c] = 1
            else:
                d[c] = d[c]+1
        return d

这个函数也适用于列表、元组甚至是字典，只要 ``s`` 的元素是可哈希的，你就可以把
它用作 ``d`` 的键。

::

    >>> t = ['spam', 'egg', 'spam', 'spam', 'bacon', 'spam']
    >>> histogram(t)
    {'bacon': 1, 'egg': 1, 'spam': 4}

适用于多种类型的函数，被称为\ **多态**\ 函数。
多态性有助于代码复用。例如，内建函数 ``sum`` 对一个序列的元素求和，只要序列中的元素支持加法即可。

因为 ``Time`` 对象提供了一个 add 方法，``sum`` 也可以应用于该对象：

::

    >>> t1 = Time(7, 43)
    >>> t2 = Time(7, 41)
    >>> t3 = Time(7, 37)
    >>> total = sum([t1, t2, t3])
    >>> print(total)
    23:01:00

通常，如果一个函数内所有的操作都适用于一个类型，那这个函数就能适用该类型。

最好的多态性是无心成柳柳成荫的，就是你发现你已经写的一个函数，在你没有预计的类型上也能使用。

接口和实现
----------------------------

面向对象设计的一个目标是使得软件更容易维护，这意味着当系统的其它部分改变时程序还能正常运行，你可以修改程序满足新的需求。

有助于实现该目标的一个设计原则是，接口和实现分离。
对于对象，就意味着一个类提供的方法不应该依赖属性的形式。

例如，在本章中，我们设计了一个表示一天中时间的类。这个类提供的方法包括\ ``time_to_int``\ ，\ ``is_after``\ 和\ ``add_time``\ 。

我们有多种方式可以实现这些方法。实现的细节取决于我们如何表示时间。
在本章中，``Time`` 对象的属性是 ``hour`` ，``minute`` 和 ``second`` 。

另一种方式是，我们用一个整数表示从零点开始的秒数，来替代这些属性。
这个实现会使得一些方法（如\ ``is_after``\ ） 更容易编写，但也让编写其他方法变得更难。

在你完成一个新类后，你可能会发现有一个更好的实现。如果程序其他部分使用了你的类，
再来改变接口需要很多时间，而且容易出错。

但是如果你细心设计好接口，你可以改变实现而保持接口不变，这样程序的其它部分都不用改变。

调试
---------

在程序执行的任何时间，为一个对象添加属性都是合法的，
但是如果相同类型的对象拥有不同的属性，就会很容易出现错误。
通常一个好的做法是在 init 方法中初始化一个对象的所有属性。

如果你不确定一个对象是否应该有某个属性，你可以使用内建函数 ``hasattr`` (参见\ :ref:`hasattr`\ 一节)。

另一种访问对象属性的方法是使用内建函数 ``vars`` ，它接受一个对象，并返回一个将属性名称（字符串形式）到对应值的字典：

::

    >>> p = Point(3, 4)
    >>> vars(p)
    {'y': 4, 'x': 3}

定义下面这段代码，可能对调试非常有用：

::

    def print_attributes(obj):
        for attr in vars(obj):
            print(attr, getattr(obj, attr))

\ ``print_attributes``\ 遍历一个对象的字典，然后打印每个属性的名称和对应的值。

内建函数 ``getattr`` 接受一个对象和一个属性名称（字符串）作为参数，然后返回该属性的值。

术语表
--------

面向对象的语言（object-oriented language）：

    提供有助于面向对象编程特性的语言，如程序员自定义类型和方法。

面向对象编程（object-oriented programming）：

    一种编程风格，数据和处理数据的操作被组织成类和方法。

方法（method）：

    在类定义内部定义的一个函数，必须在该类的实例上调用。

主语（subject）：

    方法在该对象上调用。

位置参数（positional argument）：

    不包括形参名的实参，所以不是关键字实参。

运算符重载（operator overloading）：

    改变类似 + 的运算符，使其可以应用于程序员自定义类型。

类型分发（type-based dispatch）：

    一种检查运算符的类型，并根据类型不同调用不同函数的编程模式。

多态的（polymorphic）：

    描述一个可应用于多种类型的函数。

信息隐藏（information hiding）：

    对象提供的接口不应依赖于其实现的原则，尤其是其属性的表示形式。

练习题
---------

习题17-1
^^^^^^^^^^^

可以从 http://thinkpython2.com/code/Time2.py 下载本章的代码。修改 ``Time`` 类的属性，使用一个整数代表自午夜零点开始的秒数。然后修改类的方法（和 ``int_to_time`` 函数 ），使其适用于新的实现。你不用修改 ``main`` 函数中的测试代码。

完成之后，程序的输出应该和之前保持一致。答案： http://thinkpython2.com/code/Time2_soln.py 。

.. _kangaroo:

习题17-2
^^^^^^^^^^^^

这道习题中包含了 Python 中最常见、最难找出来的错误。
编写一个叫 ``Kangaroo`` 的类，包含以下方法：

#. 一个\ ``__init__``\ 方法，初始化一个叫\ ``pounch_contents``\ 的属性为空列表。

#. 一个叫\ ``put_in_pounch``\ 的方法，将一个任意类型的对象加入\ ``pounch_contents``
   。

#. 一个\ ``__str__``\ 方法，返回 ``Kangaroo`` 对象的字符串表示和 ``pounch`` 中的内容。


创建两个 ``Kangaroo`` 对象，将它们命名为 ``kanga`` 和 ``roo`` ，然后将 ``roo`` 加入 ``kanga`` 的 ``pounch`` 列表，以此测试你写的代码。

下载\ http://thinkpython2.com/code/BadKangaroo.py \ 。其中有一个上述习题的答案，但是有一个又大又棘手的 bug 。找出并修正这个 bug 。

如果你找不到 bug ，可以下载 http://thinkpython2.com/code/GoodKangaroo.py ，里面解释了问题所在并提供了一个解决方案。

**贡献者**
^^^^^^^^^^^

#. 翻译：`@bingjin`_
#. 校对：`@bingjin`_
#. 参考：`@carfly`_

.. _@bingjin: https://github.com/bingjin
.. _@bingjin: https://github.com/bingjin
.. _@carfly: https://github.com/carfly