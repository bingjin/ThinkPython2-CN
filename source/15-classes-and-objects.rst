.. _clobjects:

第十五章：类和对象
============================

目前你已经知道如何使用函数来组织你的代码，同时用内置的类型来管理数据。
下一步我们将学习“面向对象编程”，即使用
程序员定义的类来组织代码和数据。
面向对象编程是一个很大的话题，讲完需要一些章节。

本章的示例代码可以在\ http://thinkpython2.com/code/Point1.py \ 获取；
练习题的答案可以在\ http://thinkpython2.com/code/Point1_soln.py \ 获取。

程序员自定义类型
------------------------------------------------

我们已经使用过了许多 Python 的内置类型；
现在我们要定义一个新类型。举个例子，我们来创建一个叫做 ``Point`` 的类型，代表二维空间中的一个点。

在数学记法中，点通常被写成在两个小括号中用一个逗号分隔坐标的形式。
例如\ :math:`(0,0)`\ 代表原点，\ :math:`(x,y)`\ 代表原点向右 x 个单位，向上 y 个单位的点。

在 Python 中，有几种表示点的方法：

-  我们可以将坐标存储在两个独立的变量，x和y中。

-  我们可以将坐标作为一个列表或者元组的元素存储。

-  我们可以创建一个新类型将点表示为对象。

创建一个新类型比其他方法更复杂，但是它的优势一会儿会显现出来。

程序员自定义类型( A programmer-defined type )也被称作\ **类（class）**\ 。 像这样定义一个对象：

::

    class Point:
        """Represents a point in 2-D space."""

头部语句表明新类的名称是 ``Point`` 。
主体部分是文档字符串，用来解释这个类的用途。
你可以在一个类的定义中定义变量和函数，稍后会讨论这个。

定义一个叫做 ``Point`` 的类将创建了一个\ **类对象（class object）**\ 。

::

    >>> Point
    <class '__main__.Point'>

由于 ``Point`` 是定义在顶层的，所以它的“全名”是\ ``__main__.Point``\ 。

类对象就像是一个用来创建对象的工厂。
要创建一个点，你可以像调用函数那样调用 ``Point`` 。

::

    >>> blank = Point()
    >>> blank
    <__main__.Point object at 0xb7e9d3ac>


返回值是一个 ``Point`` 对象的引用，我们将它赋值给 ``blank`` 。

创建一个新对象的过程叫做\ **实例化（instantiation）**\ ，这个新对象叫做这个类的一个\ **实例（instance）**\ 。

当你试图打印一个实例，Python 会告诉你它属于哪个类，
以及它在内存中的存储地址（前缀0x代表紧跟后面的数是以十六进制表示的）。

每一个对象都是某种类的实例，所以对象和实例可以互换。但是在这章我用“实例”来表示我在讨论程序员自定义类型。

属性
---------------

你可以使用点标记法向一个实例进行赋值操作：

::

    >>> blank.x = 3.0
    >>> blank.y = 4.0

这个语法类似于从一个模块中使用变量的语法，比如 ``math.pi`` 和 ``string.whitespace`` 。
不过在这个例子中，我们是给一个类中已命名的元素赋值。
这类元素叫做\ **属性（attributes）**\ 。

作为名词的时候，“属性”的英文“AT-trib-ute”的重音在第一个音节上，
作为动词的时候，“a-TRIB-ute”重音在第二个音节上。

下面这张图展示了这些赋值操作的结果。说明一个对象及其属性的状态图叫做\ **对象图（object diagram）**\ ；见图\ :ref:`fig.point`\ 。

.. _fig.point:

.. figure:: figs/point.png
   :alt: 图15-1：对象图

   图15-1：对象图

变量 ``blank`` 引用了一个 ``Point`` 类，这个类拥有了两个属性。
每个属性都引用了一个浮点数。

你可以使用相同的语法读取一个属性的值：

::

    >>> blank.y
    4.0
    >>> x = blank.x
    >>> x
    3.0

表达式 ``blank.x`` 的意思是，“前往 ``blank`` 所引用的对象并且获取 ``x`` 的值”。
在这个例子中，我们将获取到的值赋值给了一个叫做 ``x`` 的变量。
变量 ``x`` 和属性 ``x`` 并不会冲突。

你可以在任何表达式中使用点标记法。例如：

::

    >>> '(%g, %g)' % (blank.x, blank.y)
    '(3.0, 4.0)'
    >>> distance = math.sqrt(blank.x**2 + blank.y**2)
    >>> distance
    5.0

你可以将一个实例作为参数传递。 例如：

::

    def print_point(p):
        print('(%g, %g)' % (p.x, p.y))

\ ``print_point``\ 接受一个点作为参数，打印出其在数学中的表示方法。
调用它的时候，你可以将 ``blank`` 作为参数传递：

::

    >>> print_point(blank)
    (3.0, 4.0)

在这个函数内部，``p`` 是 ``blank`` 的别名，
所以，如果函数修改了 ``p`` ，``blank`` 也会随之改变。

我们做个联系，编写一个叫做\ ``distance_between_points``\ 的函数，它接受两个 ``Point`` 作为参数，然后返回这两个点之间的距离。

矩形
---------------

有时候，一个对象该拥有哪些属性是显而易见的，但有时候你需要好好考虑一番。
比如，你需要设计一个代表矩形的类。
为了描述一个矩形的位置和大小，你需要设计哪些属性呢？
角度是可以忽略的；为了使事情更简单，我们假设矩形是水平或者竖直的。

至少有两种可能的设计：

-  你可以指定矩形的一个角（或是中心）、宽度以及长度。

-  你可以指定对角线上的两个角。


这个时候还不能够说明哪个方法优于哪个方法。我们先来实现前者。

下面是类的定义：

::

    class Rectangle:
        """Represents a rectangle.

        attributes: width, height, corner.
        """

文档字符串中列出了属性：``width`` 和 ``height`` 是数字；
\ ``corner``\ 是一个 ``Point`` 对象，代表左下角的那个点。


为了描述一个矩形，你需要实例化一个 ``Rectangle`` 对象，并且为它的属性赋值：

::

    box = Rectangle()
    box.width = 100.0
    box.height = 200.0
    box.corner = Point()
    box.corner.x = 0.0
    box.corner.y = 0.0

表达式 ``box.corner.x`` 的意思是，
“前往 ``box`` 所引用的对象，找到叫做 ``corner`` 的属性；
然后前往 ``corner`` 所引用的对象，找到叫做 ``x`` 的属性。”

.. _fig.rectangle:

.. figure:: figs/rectangle.png
   :alt: 图15-2：对象图

   图15-2：对象图

\ :ref:`fig.rectangle`\ 展示了这个对象的状态。
一个对象作为另一个对象的属性叫做\ **嵌套（embedded）**\ 。

实例作为返回值
-----------------------------------------

函数可以返回实例。例如，\ ``find_center``\ 接受一个 ``Rectangle`` 作为参数，
返回一个 ``Point`` ，代表了这个 ``Rectangle`` 的中心坐标：

::

    def find_center(rect):
        p = Point()
        p.x = rect.corner.x + rect.width/2
        p.y = rect.corner.y + rect.height/2
        return p

下面这个例子将 ``box`` 作为参数传递，然后将返回的 ``Point`` 赋值给 ``center``：

::

    >>> center = find_center(box)
    >>> print_point(center)
    (50, 100)


对象是可变的
--------------------------------

你可以通过给一个对象的属性赋值来改变这个对象的状态。
例如，要改变一个矩形的大小而不改变它的位置，你可以修改 ``width`` 和 ``height`` 的值：

::

    box.width = box.width + 50
    box.height = box.height + 100

你也可以编写函数来修改对象。
例如，\ ``grow_rectangle``\ 接受一个 ``Rectangle`` 对象和两个数字，
\ ``dwidth``\ 和 ``dheight`` ，并将其加到矩形的宽度和高度上：

::

    def grow_rectangle(rect, dwidth, dheight):
        rect.width += dwidth
        rect.height += dheight

下面的例子展示了具体效果：

::

    >>> box.width, box.height
    (150.0, 300.0)
    >>> grow_rectangle(box, 50, 100)
    >>> box.width, box.height
    (200.0, 400.0)


在函数内部，``rect`` 是 ``box`` 的一个别名，
所以如果函数修改了 ``rect`` ，则 ``box`` 也随之改变。

我们做个练习，编写一个叫做\ ``move_rectangle``\ 的函数，接受一个 ``Rectangle`` 以及两个数字\ ``dx``\ 和\ ``dy``\ 。
它把 ``corner`` 的 ``x`` 坐标加上 ``dx``，把 ``corner`` 的 ``y`` 坐标加上 ``dy`` ，
从而改变矩形的位置。

复制
------------

别名会降低程序的可读性，因为一个地方的变动可能对另一个地方造成预料之外的影响。
跟踪所有引用同一个对象的变量是非常困难的。

通常用复制对象的方法取代为对象起别名。
\ ``copy``\ 模块拥有一个叫做 ``copy`` 的函数，可以复制任何对象：

::

    >>> p1 = Point()
    >>> p1.x = 3.0
    >>> p1.y = 4.0

    >>> import copy
    >>> p2 = copy.copy(p1)

\ ``p1``\ 和 ``p2`` 拥有相同的数据，但是它们并不是同一个 ``Point`` 对象。

::

    >>> print_point(p1)
    (3, 4)
    >>> print_point(p2)
    (3, 4)
    >>> p1 is p2
    False
    >>> p1 == p2
    False

正如我们预期的，``is`` 运算符显示了 ``p1`` 和 ``p2`` 并非同一个对象。
不过你可能会认为 ``==`` 运算的结果应该是 ``True`` ，因为这两个点的数据是相同的。
然而结果并不如你想象的那样，``==`` 运算符的默认行为和 ``is`` 运算符相同；
它检查对象的标识（identity）是否相同，而非对象的值是否相同。
因为 Python 并不知道什么样可以被认为相同。至少目前不知道。

如果你使用 ``copy.copy`` 来复制一个 ``Rectangle`` ，
你会发现它仅仅复制了 ``Rectangle`` 对象，但没有复制嵌套的 ``Point`` 对象。

::

    >>> box2 = copy.copy(box)
    >>> box2 is box
    False
    >>> box2.corner is box.corner
    True

.. _fig.rectangle2:

.. figure:: figs/rectangle2.png
   :alt: 图15-3：对象图

   图15-3：对象图

\ :ref:`fig.rectangle2`\ 展示了相应的对象图。 这个操作叫做\ **浅复制（shallow
copy）**\ ，因为它仅复制了对象以及其包含的引用， 但未复制嵌套的对象。

对大多数应用来说，这并非是你想要的结果。
在这个例子中，对其中一个 ``Rectangle`` 对象调用\ ``grow_rectangle``\ 并不会影响到另外一个，
然而当对任何一个 ``Rectangle`` 对象调用\ ``move_rectangle``\ 的时候，两者都会被影响！这个行为很容易带来疑惑和错误。


幸运的是，``copy`` 模块拥有一个叫做 ``deepcopy`` 的方法，
它不仅可以复制一个对象，还可以复制这个对象所引用的对象，
甚至可以复制\ *这个对象所引用的对象*\ 所引用的对象，等等。
没错！这个操作叫做\ **深复制（deep copy）**\ 。

::

    >>> box3 = copy.deepcopy(box)
    >>> box3 is box
    False
    >>> box3.corner is box.corner
    False

\ ``box3``\ 和 ``box`` 是完全互不相干的对象。


我们做个练习，编写另一个版本的\ ``move_rectangle``\ ，
函数创建并返回一个新的 ``Rectangle`` 对象而非修改原先的那个。

.. _hasattr:

调试
--------------

当你开始学习对象的时候，你可能会遇到一些新的异常。
如果你访问一个不存在的属性，你会得到 ``Attributeerror`` 的错误提示：

::

    >>> p = Point()
    >>> p.x = 3
    >>> p.y = 4
    >>> p.z
    AttributeError: Point instance has no attribute 'z'


如果你不确定一个对象的类型，你可以询问：

::

    >>> type(p)
    <class '__main__.Point'>


你也可以用 ``isinstance`` 来检查某个对象是不是某个类的实例。

::

    >>> isinstance(p, Point)
    True


如果你不确定一个对象是否拥有某个属性， 你可以使用内置函数 ``hasattr`` 检查：

::

    >>> hasattr(p, 'x')
    True
    >>> hasattr(p, 'z')
    False


第一个参数可以是任何对象；
第二个参数是一个\ *字符串*\ ，代表了某个属性的名字。


你也可以使用 ``try``　语句来检查某个对象是不是有你需要的属性:

::

    try:
        x = p.x
    except AttributeError:
        x = 0

这个方法可以让你更容易编写出可以适应多种数据结构的函数。你可以在[polymorphism]节查看更多内容。

术语表
---------------

类（class）:

    一种程序员自定义的类型。类定义创建了一个新的类对象。

类对象（class object）:

    包含程序员自定义类型的细节信息的对象。类对象可以被用于创建该类型的实例。

实例（instance）:

    属于某个类的对象。


实例化（instantiate）:

    创建新的对象。

属性（attribute）:

    和某个对象相关联的有命名的值。


嵌套对象（embedded object）:

    作为另一个对象的属性存储的对象。

浅复制（shallow copy）:

    在复制对象内容的时候，只包含嵌套对象的引用，通过 ``copy`` 模块的 ``copy`` 函数实现。

深复制（deep copy）:

    在复制对象内容的时候，既复制对象属性，也复制所有嵌套对象及其中的所有嵌套对象，由 ``copy`` 模块的 ``deepcopy`` 函数实现。

对象图（object diagram）:

    展示对象及其属性和属性值的图。

练习题
--------------

习题 15-1
^^^^^^^^^^^^^


定义一个叫做 ``Circle``　的类，类的属性是圆心(``center``) 和半径(``radius``),其中，圆心(``center``) 是一个　``Point`` 类，而半径(``radius``)是一个数字。

实例化一个圆心(center)为\ :math:`(150, 100)`\ ，半径(radius)为 75 的 ``Circle`` 对象。

习题 15-2
^^^^^^^^^^^^^^^^

编写一个名称为 ``point_in_circle`` 的函数，该函数可以接受一个圆类(``Circle``)对象和点类 (``Point``)对象，然后判断该点是否在圆内。在圆内则返回 ``True`` 。


习题 15-3
^^^^^^^^^^^^^^^^

编写一个名称为 ``rect_in_circle`` 的函数，该函数接受一个圆类(``Circle``)对象和矩形(``Rectangle``)对象，如果该矩形是否完全在圆内或者在圆上则返回 ``True`` 。

习题 15-4
^^^^^^^^^^^^^^^^

编写一个名为 ``rect_circle_overlap`` 函数，该函数接受一个圆类对象和一个矩形类对象，如果矩形有任意一个角落在圆内则返回 ``True`` 。或者写一个更具有挑战性的版本，如果该矩形有任何部分落在圆内返回 ``True`` 。

答案:http://thinkpython2.com/code/Circle.py.


习题 15-5
^^^^^^^^^^^^^^^^

编写一个名为 ``draw_rect`` 的函数，该函数接受一个 ``Turtle`` 对象和一个 ``Rectangle`` 对象，使用 ``Turtle`` 画出该矩形。参考[turtlechap]章中使用 ``Turtle`` 的示例。

习题 15-6
^^^^^^^^^^^^^^^^

编写一个名为　``draw_circle`` 的函数，该函数接受一个　``Turtle`` 对象和 ``Circle`` 对象，并画出该圆。

答案:http://thinkpython2.com/code/draw.py.

**贡献者**
^^^^^^^^^^^

#. 翻译：`@iphyer`_
#. 校对：`@bingjin`_
#. 参考：`@carfly`_

.. _@iphyer: https://github.com/iphyer
.. _@bingjin: https://github.com/bingjin
.. _@carfly: https://github.com/carfly