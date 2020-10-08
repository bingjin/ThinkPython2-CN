第十八章：继承
===================

最常与面向对象编程联系在一起的语言特性就是 **继承** 。继承指的是在现有类的基础下进行修改，从而定义新类的能力。在本章中，我会用表示卡牌（playing cards）、一副牌（deck of hands）和牌型（poker hands）的类，来展示继承这一特性。

如果你不玩扑克牌，你可以阅读 http://en.wikipedia.org/wiki/Poker 了解一下，但这不是必须的；我会告诉你完成练习所需要了解的知识点。

本章的代码示例可以从 http://thinkpython2.com/code/Card.py 下载。

卡牌对象
------------

一副牌有52张牌，每一张属于4种花色的一个和13个等级的一个。
4种花色是黑桃（Spades），红心（Hearts），方块（Diamonds），梅花（Clubs），
以桥牌中的逆序排列。13个等级是A、2、3、4、5、6、7、8、9、10、J、Q、K。
根据你玩的游戏的不同，A 可能比 K 大或者比 2 小。

如果我们定义一个新的对象来表示卡牌，明显它应该有\ ``rank``\ （等级） 和\ ``suit``\ （花色）
两个属性。但两个属性的类型不太明显。一个可能是使用字符串类型，
如\ ``'Spade'``\ 表示花色，\ ``'Queen'``\ 表示等级。这种实现的一个问题是，不是那么容易比较牌的大小，看哪张牌的等级或花色更高。

另外一种方法，是使用一个整型来 **编码** 等级和花色。
在这里，“编码”表示我们要定义一个数字到花色或数字到等级的映射。
但是这里的编码并不是为了保密（那就成了“加密”）。

例如，下面的表格列出了花色和对应的整数码：

+------------+-------------------+-----+
| Spades     | :math:`\mapsto`   | 3   |
+------------+-------------------+-----+
| Hearts     | :math:`\mapsto`   | 2   |
+------------+-------------------+-----+
| Diamonds   | :math:`\mapsto`   | 1   |
+------------+-------------------+-----+
| Clubs      | :math:`\mapsto`   | 0   |
+------------+-------------------+-----+

整数码使得很容易比较牌的大小；因为更高的花色对应更高的数字，我们可以通过比较数字，来判断花色的的大小。

等级的映射类型选择就显而易见；每个数字等级对应相应的整数，然后对于J，K，Q：

+---------+-------------------+------+
| Jack    | :math:`\mapsto`   | 11   |
+---------+-------------------+------+
| Queen   | :math:`\mapsto`   | 12   |
+---------+-------------------+------+
| King    | :math:`\mapsto`   | 13   |
+---------+-------------------+------+

这里，我使用\ :math:`\mapsto`\ 符号来清楚的表示，这些不是 Python 程序的一部分。它们属于程序设计的一部分，但是不会出现在代码中。

\ ``Card``\ 的类定义如下：

::

    class Card:
        """代表一张标准的卡牌"""

        def __init__(self, suit=0, rank=2):
            self.suit = suit
            self.rank = rank

通常，init 方法接受针对每个属性的可选形参。默认的卡牌是梅花 2。

可以使用你需要的花色和等级调用 ``Card`` ，创建一个 ``Card`` 对象。

::

    queen_of_diamonds = Card(1, 12)

类属性
----------------

为了以大家能够轻松看懂的方式来打印卡牌对象，我们需要一个从整数码到对应的等级和花色的映射。
一种直接的方法是使用字符串列表。我们把这些列表赋值到\ **类属性**\ ：

::

    # 在Card类内部:

        suit_names = ['Clubs', 'Diamonds', 'Hearts', 'Spades']
        rank_names = [None, 'Ace', '2', '3', '4', '5', '6', '7', 
                  '8', '9', '10', 'Jack', 'Queen', 'King']

        def __str__(self):
            return '%s of %s' % (Card.rank_names[self.rank],
                                 Card.suit_names[self.suit])

像 ``suit_names`` 和 ``rank_names`` 这样的变量，是定义在类内部但在方法之外，
被称为类属性。因为他们是被关联到 ``Card`` 类对象上的。

这个术语将它们同 ``suit`` 和 ``rank`` 这样的变量区分开来，后者被称为\ **实例属性**\ ，
因为他们被关联到了特定的实例。

这两种属性都使用点标记法来访问。例如，在\ ``__str__``\ 中，``self`` 是一个卡牌对
象，``self.rank`` 是它的等级。
同样的，``Card`` 是一个类对象，``Card.rank_names``\ 是一个和类关联的字符串列表。

每一张卡牌都有自己的花色和等级，
但是这里只有一份\ ``suit_names``\ 和\ ``rank_names``\ 拷贝。

综合来说，表达式\ ``Card.rank_names[self.rank]``\ 表示“使用 ``self`` 对象
中的 ``rank`` 属性作为 ``Card`` 类的\ ``rank_names``\ 列表的索引下标，然后获取相应的字符串。”

\ ``rank_names``\ 的第一个元素是 ``None`` ，因为没有卡牌的等级是 0 。
通过使用 ``None`` 作为占位符，我们可以很好地将索引 2 映射到字符串\ ``'2'``\ ，等等。
为了避免使用这种小技巧，我们也可以使用一个字典来代替列表。

利用现有的方法，我们可以创建和打印卡牌：

::

    >>> card1 = Card(2, 11)
    >>> print(card1)
    Jack of Hearts

.. _fig.card1:

.. figure:: figs/card1.png
   :alt: 图18-1：对象图

   图18-1：对象图

\ :ref:`fig.card1`\ 是 ``Card`` 类对象和一个 ``Card`` 实例的图示。``Card`` 是一个类对象；它的类型是 ``type`` 。``card1`` 是 ``Card`` 的一个实例，因此它的类型是 ``Card`` 。为了节省空间，我没有画出\ ``suit_names`` 和 ``rank_names``\ 的内容。


比较卡牌
---------------

对于内建类型，有关系运算符(<, >, ==, 等等)可以比较值，判断哪一个是大于、小于或等于另外一个。
对于程序员自定义的类型，我们可以通过提供一个叫 \ ``__lt__``\ （代表“小于”）的方法，来覆盖内建运算符的行为。

\ ``__lt__``\ 接受 2 个参数, ``self`` 和 ``other``，如果 ``self`` 比 ``other`` 的值要小则返回 ``True`` 。

卡牌的正确顺序并不明显。例如，梅花 3 和方块 2 哪个更高？
一个等级更高，另一个花色更高。为了比较卡牌，你必须决定等级还是花色更重要。

答案可能根据你玩的是什么游戏而不同，但是简洁起见，我们将规定花色更重要，所以所有的黑桃大于任何方块卡牌，以此类推。

定好了这个规则后，我们可以编写\ ``__lt__``\ 了：

::

    # 在Card类内部:

        def __lt__(self, other):
            # 判断花色
            if self.suit < other.suit: return True
            if self.suit > other.suit: return False

            # 花色相同...判断等级
            return self.rank < other.rank

你可以使用元组比较来使得代码更加简洁：

::

    # 在Card类内部:

        def __lt__(self, other):
            t1 = self.suit, self.rank
            t2 = other.suit, other.rank
            return t1 < t2

我们做个练习，编写一个 ``Time`` 对象的 ``__lt__`` 方法。你可以使用元组比较，也可以考虑比较整数。

一副牌
---------

现在我们有 ``Card`` 类了，下一步是定义完整的一副牌（Deck）了。因为一副牌由许多牌组成，自然地
每一个 ``Deck`` 都有一个卡牌列表作为属性。

下面是一个 ``Deck`` 的类定义。初始化方法创建了 ``cards`` 属性，然后生成了由52张牌组成一副标准卡牌。

::

    class Deck:

        def __init__(self):
            self.cards = []
            for suit in range(4):
                for rank in range(1, 14):
                    card = Card(suit, rank)
                    self.cards.append(card)

生成一副牌的最简单方法是使用嵌套循环。外层循环枚举 0 到 3 的花色。内层循环枚举 1 到 13 
的等级。每一个迭代都用当前的花色和等级创建一张新的牌。然后放入 ``self.cards`` 中。

打印一副牌
-----------------

下面是为 ``Deck`` 定义的 ``__str__`` 方法：

::

    # Deck类的内部

        def __str__(self):
            res = []
            for card in self.cards:
                res.append(str(card))
            return '\n'.join(res)

这个方法展示了累积大字符串的高效方法：建立一个字符串列表然后使用字符串方法 ``join`` 。
内建函数 ``str`` 会调用每个卡牌上的\ ``__str__``\ 方法，并返回它们的字符串表示。

由于我们是在一个换行符上调用的 ``join`` ，卡牌之间被换行符分隔。下面是结果示例：

::

    >>> deck = Deck()
    >>> print(deck)
    Ace of Clubs
    2 of Clubs
    3 of Clubs
    ...
    10 of Spades
    Jack of Spades
    Queen of Spades
    King of Spades

虽然这个结果有52行，但他实际上是包含换行符的一个长字符串。

添加，移除，洗牌和排序
-----------------------------

为了发牌，我们需要一个可以把卡牌从一副牌中移除并返回的方法。
列表的 ``pop`` 方法提供了一个便捷的实现：

::

    # Deck类的内部

        def pop_card(self):
            return self.cards.pop()

Since pop removes the *last* card in the list, we are dealing from the
bottom of the deck.

由于 ``pop`` 移除列表的 **最后一张** 卡牌，所以我们从牌底开始发牌。

我们可以使用列表的 ``append`` 方法，添加一张卡牌：

::

    # Deck类的内部

        def add_card(self, card):
            self.cards.append(card)

像上面这样利用别的方法（method），自己却没有做太多处理的方法，有时候被称为 **伪装方法（veneer）** 。
这个隐喻来源于木工行业，他们通常用一片高质量的木质薄层粘贴在一块便宜木材的表面，改善外观形象。

在这里，``add_card`` 是一个“瘦”方法，以卡牌的术语来表述一个列表操作。它改善了实现的外观，或者说接口。

再举一个例子，我们可以用 ``random`` 模块中的 
``shuffle`` 函数，给 ``Deck`` 写一个叫 ``shuffle`` 的方法。

::

    # Deck类的内部
                
        def shuffle(self):
            random.shuffle(self.cards)

不要忘记了导入 ``random`` 。

我们做个练习，用列表的 ``sort`` 方法来写一个 ``Deck`` 的 ``sort`` 方法，给卡牌排序。
\ ``sort``\ 使用我们定义的\ ``__cmp__``\ 来决定排序顺序。


继承
-----------

继承指的是在现有类的基础下进行修改，从而定义新类的能力。例如，假设我们想定义一个类来代表手牌（hand），即玩家目前手里有的牌。手牌与一副牌（deck）类似：二者都由卡牌组成，都要求支持添加和移除卡牌的操作。

但二者也有区别；有些我们希望手牌具备的操作，对于 deck 来说并不合理。例如，在扑克牌中，我们可能需要比较两个手牌，比较哪方赢了。在桥牌中，我们可能需要计算手牌的得分，才好下注。

类之间有相似之处，但也存在不同，这时就可以用上继承了。你只需要在定义新类时，将现有类的名称放在括号里，即可继承现有类：

::

    class Hand(Deck):
        """Represents a hand of playing cards."""

这个定义表明，``Hand`` 继承自 ``Deck`` ；这意味着我们也可以对 ``Hands`` 使用 ``Deck`` 的\ ``pop_card``\ 和\ ``add_card``\ 方法。

当一个新类继承自一个现有类时，现有类被称为 **父类** ，新类被称为 **子类** 。

在此例中，``Hand`` 继承了 ``Deck`` 的\ ``__init__``\ 方法，但是它并没有满足我们的要求：init 方法应该为 ``Hand`` 初始化一个空的 ``cards`` 列表，而不是往手牌里添加 52 张新牌。

如果我们提供一个 ``Hand`` 的 init 方法，它会覆盖从 ``Deck`` 类继承来的同名方法。

::

    # Hand 类的内部

        def __init__(self, label=''):
            self.cards = []
            self.label = label

当你创建一个 ``Hand`` 时，Python 会调用这个 init 方法，而不是 ``Deck`` 中的同名方法。

::

    >>> hand = Hand('new hand')
    >>> hand.cards
    []
    >>> hand.label
    'new hand'

其它方法是从 ``Deck`` 继承来的，所以我们可以使用\ ``pop_card`` 和
``add_card``\ 来发牌：

::

    >>> deck = Deck()
    >>> card = deck.pop_card()
    >>> hand.add_card(card)
    >>> print(hand)
    King of Spades

很自然地，下一步就是把这些代码封装进一个叫\ ``move_cards``\ 的方法：

::

    # Deck类的内部

        def move_cards(self, hand, num):
            for i in range(num):
                hand.add_card(self.pop_card())

\ ``move_cards``\ 接受两个参数，一个是 ``Hand`` 对象，另一个是发牌的数量。
它会同时修改 ``self`` 和 ``hand`` ，然后返回 ``None`` 。

在有些游戏里面，卡牌从一个手牌移动到另外一个手牌，或者从手牌退还到牌堆里面。
任何这些操作都可以使用 \ ``move_cards``\ ：``self`` 可以是一个 ``Deck`` 或者一个 ``Hand`` ，而且尽管名字叫 ``hand`` ，它也可以是一个 ``Deck`` 。

继承是一个非常有用的特性。有了继承，一些重复性的代码可以写得非常的优雅。
继承有助于代码重用，因为你可以在不修改父类定义的前提下，就改变父类的行为。
在有些情况下，继承的结构反映了真实问题的结构，使得程序更易于理解。

另一方面，继承又有可能会使得程序更加难读。
当调用一个方法时，有时候搞不清楚去哪找它的定义。
相关的代码可能被分散在几个模块之中。
而且，许多用继承能完成的事情，不用继承也可以完成，有可能还完成得更好。


类图
--------------

到目前为止我们已经了解过栈图，它显示的是一个程序的状态；以及对象图，它显示的是一个对象的属性及其值。这些图代表了程序执行中的一个快照，所以它们随着程序的运行而变化。

它们也十分的详细；但有些时候显得过于详细了。类图是程序结构的一种更加抽象的表达。
它显示的是类和类之间的关系，而不是每个独立的对象。

类之间有如下几种关系：

-  一个类中的对象可以包含对另外一个类的对象的引用。例如，每一个矩形包含对点的引用，每一个 ``Deck`` 包含对许多 ``Card`` 的引用。这种关系被称为组合( **HAS-A** )，可以类似这样描述：“一个矩形有一个（has a）点”。

-  一个类可能继承自另外一个类。这种关系被称为继承(\ **IS-A**)，可以类似这样描述：“Hand is a kind of Deck”。

-  一个类可能强赖另一个类，因为前者中的对象接受后者中的对象作为参数，或者使用后者中的对象作为计算的一部分。这种关系被称为 **依赖** 。

类图是这些关系的图形化表示。例如，\ :ref:`fig.class1`\ 标明了 ``Card`` ， ``Deck`` 和
``Hand`` 之间的关系。

.. _fig.class1:

.. figure:: figs/class1.png
   :alt: 图18-2：类图

   图18-2：类图

带空心三角的箭头表示 IS-A 的关系；这里它表示 ``Hand`` 继承自 ``Deck`` 。

标准箭头表示 HAS-A 的关系；这里表示 ``Deck`` 包含对 ``Card`` 对象的引用。

箭头旁边的星号是一个复数（ **multiplicity** ）表达；它表示 ``Deck`` 包含多少个 ``Card`` 。一个复数表达可以是一个简单的数字(如 52 )，一个范围（如5..7）或者是\*，表示有任意数量的 ``Card`` 。

上图中没有标出依赖关系。这种关系通常使用虚线箭头表示。或者，如果有很多依赖关系的话，有时候会省略。

一个更详细的类图可能会显示 ``Deck`` 实际包含了一个由 ``Cards`` 组成的列表，但是通常类图中不会包含 ``list`` 和 ``dict`` 等内建类型。

数据封装
------------------

前面几章中描述了一种可以称为”面向对象设计“的开发计划。我们确定所需要的对象 —— 如``Point`` 、 ``Rectangle`` 和  ``Time`` —— 然后定义代表它们的类。
对于每个类来说，这个类对象和真实世界（或至少是数学世界）中的某种实体具有明显的对应关系。

但是有时有很难界定你需要的对象以及它们如何交互。在这个时候，你需要一个不同的开发计划。之前我们通过封装和泛化来编写函数接口，我们同样可以通过 **数据封装** 来编写类接口。

\ :ref:`markov`\ 一节中介绍的马尔科夫分析就是一个很好的例子。如果你从\ http://thinkpython2.com/code/markov.py \ 下载我的代码，你会发现它使用了两个全局变量 —— \ ``suffix_map``\ 和\ ``prefix``\ ，它们被多个函数进行读写。

::

    suffix_map = {}        
    prefix = ()            

因为这些变量是全局的，我们一次只能运行一个分析。如果我们读取了两个文本，
它们的前缀和后缀会被加入相同的数据结构（会使得输出文本混乱）。

如果想同时运行多个分析，并且保持它们的相互独立，我们可以把每个分析的状态封装到一个对象中。
下面是一个示例：

::

    class Markov:

        def __init__(self):
            self.suffix_map = {}
            self.prefix = ()    

下一步，我们把这些函数转换为方法。例如：下面是\ ``process_word``\ ：

::

        def process_word(self, word, order=2):
            if len(self.prefix) < order:
                self.prefix += (word,)
                return

            try:
                self.suffix_map[self.prefix].append(word)
            except KeyError:
                # if there is no entry for this prefix, make one
                self.suffix_map[self.prefix] = [word]

            self.prefix = shift(self.prefix, word)        

像这样改变一个程序 —— 改变设计而保持功能不变 —— 是代码重构的另一个例子（参见\ :ref:`refactoring`\ 一节）。

下面的例子给出了一种设计对象和方法的开发计划：


#. 首先编写读取全局变量的函数（如有必要）。

#. 一旦你让程序跑起来了，开始查找全局变量和使用它们的函数的联系。

#. 封装相关的变量作为一个对象的属性。

#. 转换相关函数为新类的方法。

我们做个练习，从 http://thinkpython2.com/code/markov.py 下载我的马尔科夫分析代码，然后按照上面所述的步骤，将全局变量封装为新类 ``Markov`` （注意M为大写）的属性。


调试
---------

继承会使得调试变得更加复杂，因为你可能不知道实际调用的是哪个类的方法。

假设你在写一个处理 ``Hand`` 对象的函数。你可能会想让它可以处理所有种类的 ``Hand`` ，如 ``PockerHands`` ，``BridgeHands`` ，等等。如果你调用类似 ``shuffle`` 这样的方法，你可能会得到 ``Deck`` 中定义的那个，
但是如果有任何一个子类覆盖了这个方法。你实际上得到的是子类的那个方法。这个行为通常是一件好事，但是容易让人混淆。

只要你不确定程序的执行流程，最简单的方法是在相关方法的开始处添加 ``print`` 语
句。如果 ``Deck.shuffle`` 打印一条如像 ``Running Deck.shuffle`` 的消息，那么随着程序的运行，它会追踪执行的流程。

另外一种方法是使用下面的函数，它接受一个对象和一个方法的名字（字符串格式）作
为参数，然后返回提供这个方法定义的类：

::

    def find_defining_class(obj, meth_name):
        for ty in type(obj).mro():
            if meth_name in ty.__dict__:
                return ty

例如：

::

    >>> hand = Hand()
    >>> find_defining_class(hand, 'shuffle')
    <class 'Card.Deck'>

所以 ``Hand`` 的 ``shuffle`` 方法是来自于 ``Deck`` 的。

\ ``find_defining_class``\ 使用 ``mro`` 方法获得将类对象（类型）的列表，
解释器将会从这里依次搜索哪个类提供了这个方法。“MOR”是“method resolution order”的简称，指的是Python “解析” 方法名时将搜索的一个类序列。

我提一个对程序设计的建议：当你覆盖一个方法时，新方法的接口应该与旧方法保持一致。
它们应该接受相同的参数，返回相同的类型，遵守相同的先决条件和后置条件。
如果你遵循这个原则，你会发现：任何你设计的函数，只要能用于一个父类的对象（
如 ``Deck`` ），就能够用于任何子类的实例（如 ``Hand`` 和 ``PockerHand`` ）。

如果你违背这条规则（该原则被称为“里氏代换原理”，英文为：Liskov substitution
principle），你的代码逻辑就会变得乱七八糟。

术语表
--------

编码（encode）：

    利用另一组值代表一组值，方法时构建二者之间的映射。

类属性（class attribute）：

    与类对象相关联的属性。类属性定义在类定义的内部，但在方法的外部。

实例属性（instance attribute）：

    与类的实例相关联的属性。

伪装方法（veneer）：
    
    提供另一个函数的不同接口，但不做太多计算的函数或方法。

继承（inheritance）：

    在此前定义的类的基础下进行修改，从而定义一个新类的能力。

父类（parent class）：

    子类所继承自的类。

子类（child class）：

    通过继承一个现有类创建的新类。

IS-A 关系：

    子类和父类之间的关系。

HAS-A 关系：

    两个类之中，有一个类包含对另一个类的实例的引用的关系。

依赖（dependency）：

    两个类之中，一个类的实例使用了另一个类的实例，但没有将其保存为属性的关系。

类图（class diagram）：

    表明程序中包含的类及其之间的关系的图示。

复数（multiplicity）：

    类图中的一种标记，表明在 HAS-A 关系中，某个对包含了多少个对另一个类实例的引用。

数据封装（data encapsulation）：

    一种程序开发计划，包括首先编写一个使用全局变量的原型，然后再讲全局变量变成实例属性的最终版代码。


练习题
---------

习题18-1
^^^^^^^^^^^^

针对以下程序，画一个 UML 类图，说明其中包含的类及其之间的关系。

::

    class PingPongParent:
        pass

    class Ping(PingPongParent):
        def __init__(self, pong):
            self.pong = pong


    class Pong(PingPongParent):
        def __init__(self, pings=None):
            if pings is None:
                self.pings = []
            else:
                self.pings = pings

        def add_ping(self, ping):
            self.pings.append(ping)

    pong = Pong()
    ping = Ping(pong)
    pong.add_ping(ping)


习题18-2
^^^^^^^^^^^^

为 ``Deck`` 编写一个叫 ``deal_hands`` 的方法，接受两个参数：手牌的数量以及每个手牌的卡牌数。它应该创建相应数量的 ``Hand`` 对象，给每个手牌发放相应数量的卡牌，然后返回一个 ``Hands`` 列表。

下面是扑克牌中可能的手牌（牌型），越往下值越大，几率越低：

对牌：
    
    两张相同牌面的牌

两对牌：

    两对相同牌面的牌

三条：

    三张等级相同的牌

顺子：

    五张连续的牌（A可高可低。如A-2-3-4-5是一个顺子,10-J-Q-K-A也
    是。但是Q-K-A-2-3就不是）

同花：

    五张花色一样的牌

三代二：

    三张等级一样的牌，另外两张等级一样的牌

四条：

    四张牌面一样的牌

同花顺：
    
    五张花色相同的等级连续的牌

.. _poker:

习题18-3
^^^^^^^^^^^^

下面这些习题的目的，是估算抽到不同手牌的几率。


#. 从\ http://thinkpython2.com/code \ 页面下载以下文件：

   Card.py
       : 本章中完整版本的Card , Deck和Hand类。

   PokerHand.py
       : 代表 poker hand 的不完整的实现，和一些测试代码。

#. 如果你运行 ``PokerHand.py`` ,它会发放 7 张牌的 poker hand，检查是否含有顺子。仔细阅读代码，再继续下面的内容。

#. 往 ``PokerHand.py`` 文件中添加叫做 ``has_pair`` 、 ``has_twopair`` 等方法，这些方法根据手牌是否满足相应的标准来返回 ``True`` 或 ``False`` 。你的代码应该可以正确地处理包含任意卡牌数量（虽然 5 和 7 是最常见的数量）的手牌。

#. 写一个叫 ``classify`` 的方法，计算出一个手牌的最高值分类，然后设置对应的 ``label`` 属性。例如，一个 7 张牌的手牌可能包含一个顺子和一个对子；那么它应该标注为“顺子”。

#. 确信你的分类方法是正确的之后，下一步是估算这些不同手牌出现的几率。在 ``PokerHand.py`` 中编写一个函数，完成洗牌，分牌，对牌分类，然后记录每种分类出现的次数。

#. 打印每种分类和对应频率的表格。运行你的程序，不断增加手牌的卡牌数量，直到输出的值保持在足够准确的范围。将你的结果和\ http://en.wikipedia.org/wiki/Hand_rankings \ 页面中的的值进行比较。

答案： http://thinkpython2.com/code/PokerHandSoln.py 。

**贡献者**
^^^^^^^^^^^

#. 翻译：`@bingjin`_
#. 校对：`@bingjin`_
#. 参考：`@carfly`_

.. _@bingjin: https://github.com/bingjin
.. _@bingjin: https://github.com/bingjin
.. _@carfly: https://github.com/carfly
