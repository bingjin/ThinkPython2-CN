第十九章：进阶小技巧
========================

我在写这本书时的一个目标，就是尽量少教些Python。如果有两种实现方法，我会挑其中之一讲解，避免再提另一种方法。有时候可能会将第二种方法放在练习题里。

现在我想回过头来讲一些之前没有涉及的内容。Python提供的特性中，有一些其实并不是必须的——没有它们你也能写出好的代码——但是有了它们之后，有时候你能写出更简洁、可读性更高或者效率更高的代码，有时候甚至三个好处都有。

条件表达式
-----------------------

在\ :ref:`conditional.execution`\ 一节中，我们学习了条件语句。条件语句通常用于在两个值之间进行二选一；例如：

::

    if x > 0:
        y = math.log(x)
    else:
        y = float('nan')

这个语句检测 ``x`` 是否是正值。如果是，它将计算它的 ``math.log`` 。如果不是，``math.log`` 会抛出 ``ValueError`` 。为了避免程序出错，我们生成一个 “NaN”，这是一个代表“非数字”的特殊浮点值。

我们可以使用 **条件表达式** 简化这个语句：

::

    y = math.log(x) if x > 0 else float('nan')

这条语句读起来很像英语：“y gets log-x if x is
greater than 0; otherwise it gets NaN”（如果 x 大于 0，y 的值则是 x 的 log；否则 y 的值为 NaN ）。

有时候也可以使用条件表达式改写递归函数。例如，下面是阶乘函数的递归版本：

::

    def factorial(n):
        if n == 0:
            return 1
        else:
            return n * factorial(n-1)

我们可以像这样重写：

::

    def factorial(n):
        return 1 if n == 0 else n * factorial(n-1)

条件表达式的另一个用处是处理可选参数。例如，下面是\ :ref:`kangaroo`\ 中 ``GoodKangaroo`` 类的 init 方法：

::

        def __init__(self, name, contents=None):
            self.name = name
            if contents == None:
                contents = []
            self.pouch_contents = contents

我们可以像这样重写：

::

        def __init__(self, name, contents=None):
            self.name = name
            self.pouch_contents = [] if contents == None else contents

一般来说，如果条件语句的两个分支中均为简单的表达式，不是被返回就是被赋值给相同的变量，那么你可以用条件表达式替换调该条件语句。

列表推导式
-------------------

在\ :ref:`filter`\ 一节中，我们学习了映射和筛选模式。例如，下面这个函数接受一个字符串列表，将字符串方法 ``capitalize`` 映射至元素，并返回一个新的字符串列表：

::

    def capitalize_all(t):
        res = []
        for s in t:
            res.append(s.capitalize())
        return res

我们可以使用 **列表推导式** 简化该函数：

::

    def capitalize_all(t):
        return [s.capitalize() for s in t]

方括号操作符表示，我们正在构造一个新列表。方括号中的表达式指定列表中的元素，``for`` 子句表示我们要遍历的序列。

列表推导式的语法有点奇怪，因为此例中的循环变量 ``s`` 在定义之前就出现了。

列表推导式也可以用于筛选。例如，这个函数只选择 ``t`` 中为大写的元素，并返回一个新列表：

::

    def only_upper(t):
        res = []
        for s in t:
            if s.isupper():
                res.append(s)
        return res

我们可以使用列表推导式重写这个函数：

::

    def only_upper(t):
        return [s for s in t if s.isupper()]

列表推导式非常简洁、易读，至少对简单的表达式是这样的。而且通常比对应的 for 循环要更快，有时要快很多。所以，如果你恨我之前没介绍，我可以理解。

但是，我这么做也是有原因的，列表推导式的调试难度更大，因为你不能在循环中添加打印语句。我建议你只在计算足够简单、第一次就能写出正确代码的前提下使用。不过对初学来说，第一次就写对几乎不可能。

生成器表达式
---------------------

\ **生成器表达式**\ 与列表推导式类似，但是使用的是圆括号，而不是方括号：

::

    >>> g = (x**2 for x in range(5))
    >>> g
    <generator object <genexpr> at 0x7f4c45a786c0>

结果是一个表达式对象，该对象知道如何遍历一个值序列。但与列举推导式不同的是，它不会一次性计算出所有的值；而是等待求值请求。内建函数 ``next`` 从生成器获取下一个值：

::

    >>> next(g)
    0
    >>> next(g)
    1

抵达序列的末尾时，``next`` 会抛出 ``StopIteration`` 异常。你还可以使用 for 循环遍历这些值：

::

    >>> for val in g:
    ...     print(val)
    4
    9
    16

生成器对象会记录其在序列中的位置，因此 for 循环是从 next 结束的地方开始的。一旦生成器被消耗完，它会抛出 ``StopException`` 。

::

    >>> next(g)
    StopIteration

生成器表达式常与 ``sum`` 、``max`` 和 ``min`` 等函数一起使用：

::

    >>> sum(x**2 for x in range(5))
    30

any 和 all
-----------

Python提供了一个内建函数 ``any``，它接受一个布尔值序列，如果其中有任意一个值为 ``True`` 则返回 ``True`` 。它也适用于列表：

::

    >>> any([False, False, True])
    True

但是它通常用于生成器表达式：

::

    >>> any(letter == 't' for letter in 'monty')
    True

上面这个例子不是很有用，因为它的功能和 in 操作符一样。但是我们可以使用 ``any`` 重写\ :ref:`search2`\ 一节中的部分搜索函数。例如，我们可以像这样编写 ``avoids`` 函数：

::

    def avoids(word, forbidden):
        return not any(letter in forbidden for letter in word)

上面的函数读取来和英语没什么区别：“word avoids forbidden if there
are not any forbidden letters in word.”（如果某个词中没有任何禁用字母，那么该词就算避免了使用禁用词。）

将 ``any`` 与生成器表达式结合使用的效率较高，因为它只要一遇到真值就会终止，所以不会对整个序列进行计算。

Python还提供了另一个内建函数 ``all``，如果序列中的每个元素均为 ``True`` 才会返回 ``True`` 。我们做个练习，使用 ``all`` 重写\ :ref:`search2`\ 一节中 ``uses_all`` 函数。


集合
--------

在\ :ref:`dictsub`\ 一节中，我使用字典对那些在文档中但不在单词列表里的单词进行了查找。我写的那个函数接受参数 ``d1`` 和 ``d2`` ，分别包含文档中的单词（作为键使用）和单词列表。它返回不在 ``d2`` 中但在 ``d1`` 里的键组成的字典。

::

    def subtract(d1, d2):
        res = dict()
        for key in d1:
            if key not in d2:
                res[key] = None
        return res

在上面的字典中，所有键的值均为 ``None`` ，因为我们不会使用这些值。后果就是会浪费一些存储空间。

Python提供了另一个叫做集合的内建类型，它的行为类似没有值的字典键集合。往集合中添加元素是非常快的；成员关系检测也很快。另外，集合还提供了计算常见集合操作的方法和操作符。

例如，集合差集就有一个对应的 ``difference`` 方法，或者操作符 ``-``。因此，我们可以这样重写 ``subtract`` 函数：

::

    def subtract(d1, d2):
        return set(d1) - set(d2)

结果是一个集合，而不是字典，但对于像迭代这样的操作而言，二者是没有区别的。

如果使用集合来完成本书中的部分练习题，代码会比较简洁、高效。例如，下面是\ :ref:`exercise10-7`\ 中 ``has_duplicates`` 函数的一种使用字典的实现：

::

    def has_duplicates(t):
        d = {}
        for x in t:
            if x in d:
                return True
            d[x] = True
        return False

当某个元素首次出现时，它被添加至字典中。如果同样的元素再次出现，函数则返回 ``True`` 。

如果使用集合，我们可以像这样重写该函数：

::

    def has_duplicates(t):
        return len(set(t)) < len(t)

一个元素在集合中只能出现一次，因此如果 ``t`` 中的某个元素出现次数超过一次，那么集合的大小就会小于 ``t`` 。如果没有重复的元素，集合和 ``t`` 的大小则相同。

我们还可以使用集合完成\ :ref:`wordplay`\ 中的部分练习题。例如，下面是使用循环实现的 ``uses_only`` 函数：

::

    def uses_only(word, available):
        for letter in word:
            if letter not in available:
                return False
        return True

``uses_only`` 检查 ``word`` 中的所有字符也在 ``available`` 中。我们可以像这样重写该函数：

::

    def uses_only(word, available):
        return set(word) <= set(available)

操作符  ``<=``  检查某个集合是否是另一个集合的子集或本身，包括了二者相等的可能性。如果 ``word`` 中所有的字符都出现在 ``available`` 中，则返回 ``True`` 。

接下来做个练习，使用集合重写 ``avoids`` 函数。


计数器
-----------

计数器（Counter）类似集合，区别在于如果某个元素出现次数超过一次，计数器就会记录其出现次数。如果你熟悉数学中的 **多重集** 概念，计数器就是用来表示一个多重集的自然选择。

计数器定义在叫做 ``collections`` 的标准模块中，因此你必须首先导入该模块。你可以通过字符串、列表或任何支持迭代的数据结构来初始化计数器：

::

    >>> from collections import Counter
    >>> count = Counter('parrot')
    >>> count
    Counter({'r': 2, 't': 1, 'o': 1, 'p': 1, 'a': 1})

计数器的行为与字典有很多相似的地方：它们将每个键映射至其出现的次数。与字典一样，键必须是可哈希的。

与字典不同的是，如果你访问一个没有出现过的元素，计数器不会抛出异常，而只是返回 0 ：

::

    >>> count['d']
    0

我们可以使用计数器重写\ :ref:`anagram` \ 中的 ``is_anagram`` 函数：

::

    def is_anagram(word1, word2):
        return Counter(word1) == Counter(word2)

如果两个单词是变位词，那么它们会包含相同的字符，而且字符的计数也相同，因此它们的计数器也是等价的。

计数器提供了执行类似集合操作的方法和操作符，包括集合添加、差集、并集和交集。另外，还提供了一个通常非常有用的方法 ``most_common`` ，返回一个由值-频率对组成的列表，按照频率高低排序：

::

    >>> count = Counter('parrot')
    >>> for val, freq in count.most_common(3):
    ...     print(val, freq)
    r 2
    p 1
    a 1

defaultdict
--------------

``collections`` 模块中还提供了一个 ``defaultdict`` ，它类似字典，但是如果你访问一个不存在的键，它会临时生成一个新值。

在创建 ``defaultdict`` 时，你提供一个用于创建新值的函数。这个用于创建对象的函数有时也被称为 **工厂** 。用于创建列表、集合和其他类型的内建函数也可以用作工厂：

::

    >>> from collections import defaultdict
    >>> d = defaultdict(list)

请注意，这里的实参是 ``list`` ，它是一个类对象，而不是 ``list()`` ，后者是一个新列表。你提供的函数只有在访问不存在的键时，才会被调用。

::

    >>> t = d['new key']
    >>> t
    []

新列表 ``t`` 也被添加至字典中。因此如果我们修改 ``t`` ，改动也会出现在 ``d`` 中。

::

    >>> t.append('new value')
    >>> d
    defaultdict(<class 'list'>, {'new key': ['new value']})

如果你要创建一个列表组成的字典，通常你可以使用 ``defaultdict`` 来简化代码。在\ :ref:`anagrams`\ 的答案（可从 http://thinkpython2.com/code/anagram_sets.py 处获取）中，我创建的字典将排好序的字符串映射至一个可以由这些字符串构成的单词列表。例如，``'opst'`` 映射至列表 ``['opts', 'post', 'pots', 'spot', 'stop', 'tops']`` 。

下面是代码：

::

    def all_anagrams(filename):
        d = {}
        for line in open(filename):
            word = line.strip().lower()
            t = signature(word)
            if t not in d:
                d[t] = [word]
            else:
                d[t].append(word)
        return d

这个函数可以使用 ``setdefault`` 进行简化，你可能在\ :ref:`setdefault`\ 中也用到了：

::

    def all_anagrams(filename):
        d = {}
        for line in open(filename):
            word = line.strip().lower()
            t = signature(word)
            d.setdefault(t, []).append(word)
        return d

这种方案有一个缺点，即不管是否需要，每次都会创建一个新列表。如果只是创建列表，这问题你不大，但是如果工厂函数非常复杂，就可能会成为一个大问题。

我们可以使用 ``defaultdict`` 来避免这个问题，同时简化代码：

::

    def all_anagrams(filename):
        d = defaultdict(list)
        for line in open(filename):
            word = line.strip().lower()
            t = signature(word)
            d[t].append(word)
        return d

\ :ref:`poker`\ 的答案（可从 http://thinkpython2.com/code/PokerHandSoln.py 下载）中，``has_straightflush`` 函数使用了 ``setdefault`` 。这个答案的缺点就是每次循环时都会创建一个 ``Hand`` 对象，不管是否需要。我们做个练习，使用 ``defaultdict`` 改写这个函数。

命名元组
------------

许多简单对象基本上就是相关值的集合。例如，\ :ref:`clobjects`\ 中定义的 ``Point`` 对象包含两个数字 ``x`` 和 ``y`` 。当你像下面这样定义类时，你通常先开始定义 init 和 str 方法：

::

    class Point:

        def __init__(self, x=0, y=0):
            self.x = x
            self.y = y

        def __str__(self):
            return '(%g, %g)' % (self.x, self.y)

但是编写了这么多代码，却只传递了很少的信息。Python提供了一个更简洁的实现方式：

::

    from collections import namedtuple
    Point = namedtuple('Point', ['x', 'y'])

第一个实参是你希望创建的类的名称。第二个实参是 ``Point`` 对象应该具备的属性列表，以字符串的形式指定。 ``namedtuple`` 的返回值是一个类对象：

::

    >>> Point
    <class '__main__.Point'>

这里的 ``Point`` 自动提供了像 ``__init__`` 和 ``__str__`` 这样的方法，你没有必须再自己编写。

如果想创建一个 ``Point`` 对象，你可以将 ``Point`` 类当作函数使用：

::

    >>> p = Point(1, 2)
    >>> p
    Point(x=1, y=2)

init 方法将实参赋值给你提供的属性。str 方法打印 ``Point`` 对象的字符串呈现及其属性。

你可以通过名称访问命令元组的元素：

::

    >>> p.x, p.y
    (1, 2)

但是你也可以把命名元组当作元组使用：

::

    >>> p[0], p[1]
    (1, 2)

    >>> x, y = p
    >>> x, y
    (1, 2)

命名元组是定义简单类的一种便捷方式。缺点是这些简单类不会一成不变。之后你可能会发现想要给命名元组添加更多的方法。在这种情况下，你可以定义一个继承自命名元组的新类：

::

    class Pointier(Point):
        # add more methods here

或者使用传统的类定义方式。

汇集关键字实参
----------------------

在\ :ref:`gather`\ 一节中，我们学习了如何编写一个将实参汇集到元组的函数：

::

    def printall(*args):
        print(args)

你可以使用任意数量的位置实参（即不带关键字的参数）调用该函数：

::

    >>> printall(1, 2.0, '3')
    (1, 2.0, '3')

不过 ``*`` 星号操作符无法汇集关键字参数：

::

    >>> printall(1, 2.0, third='3')
    TypeError: printall() got an unexpected keyword argument 'third'

如果要汇集关键字参数，你可以使用 ``**`` 双星号操作符：

::

    def printall(*args, **kwargs):
        print(args, kwargs)

你可以给关键字汇集形参取任意的名称，但是 ``kwargs`` 是常用名。上面函数的结果是一个将关键字映射至值的字典：

::

    >>> printall(1, 2.0, third='3')
    (1, 2.0) {'third': '3'}

如果你有一个有关键字和值组成的字典，可以使用分散操作符（scatter operator） ``**`` 调用函数：

::

    >>> d = dict(x=1, y=2)
    >>> Point(**d)
    Point(x=1, y=2)

如果没有分散操作符，函数会将 ``d`` 视为一个位置实参，因此会将 ``d`` 赋值给 ``x`` 并报错，因为没有给 ``y`` 赋值：

::

    >>> d = dict(x=1, y=2)
    >>> Point(d)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: __new__() missing 1 required positional argument: 'y'

在处理有大量形参的函数时，通常可以创建指定了常用选项的字典，并将其传入函数。

术语表
--------

条件表达式（conditional expression）：

    根据条件在两个值中二选一的表达式。

列表推导式（list comprehension）：

    位于方括号中带 for 循环的表达式，最终生成一个新列表。

生成器表达式（generator expression）：

    位于圆括号中带 for 循环的表达式，最终生成一个生成器对象。

多重集（multiset）：

    一个数学概念，表示一个集合的元素与各元素出现次数之间的映射。

工厂（factory）：

    用于创建对象的函数，通常作为形参传入。


练习题
---------

习题19-1
^^^^^^^^^^^

下面是一个递归计算二项式系数（binomial coefficient）的函数。

::

    def binomial_coeff(n, k):
        """Compute the binomial coefficient "n choose k".

        n: number of trials
        k: number of successes

        returns: int
        """
        if k == 0:
            return 1
        if n == 0:
            return 0

        res = binomial_coeff(n-1, k) + binomial_coeff(n-1, k-1)
        return res

使用嵌套条件表达式重写函数体。

注意：这个函数不是特别高效，因为它最后在不断地重复计算相同的值。你可以通过备忘录模式（memoizing，也可理解为缓存）来提高效率（参见\ :ref:`memoize`\ 一节）。不过你会发现，如果使用条件表达式，进行缓存的难度会更大。

**贡献者**
^^^^^^^^^^^

#. 翻译：`@bingjin`_
#. 校对：`@bingjin`_
#. 参考：`@carfly`_

.. _@bingjin: https://github.com/bingjin
.. _@bingjin: https://github.com/bingjin
.. _@carfly: https://github.com/carfly
