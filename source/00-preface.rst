前言
====

本书与众不同的历史
------------------

1999年1月，我正准备使用Java教一门编程入门课程。我之前已经开了三次课，
但是却感到越来越沮丧。课程的不及格率太高，即使对于及格的学生，他们整体的收获也太低。

我看到的问题之一是教材。

它们都太厚重了，写了太多关于Java的不必要细节，却缺乏如何编程的上层指导
（high-level guidance）。这些教材都陷入了陷阱门效应（trap door
effect）：开始的时候简单，逐渐深入，然后大概到了第五章左右，基础差的学生就跟不上了。
学生们看的材料太多，进展太快，最后，我在接下来的学期里都是在收拾残局（pick
up the pieces）。

所以，在开始上课前两周，我决定自己写一本书。我的目标是：

-  尽量简短。让学生们读10页，胜过让他们读50页。

-  谨慎使用术语。我会尽量少用术语，而且第一次使用时，会给出定义。

-  循序渐进。为了避免陷阱门，我将最难的主题拆分成了很多个小节。

-  聚焦于编程，而不是编程语言。我只涵盖了Java最小可用子集，剔除了其余的部分。

我需要一个书名，所以一时兴起，我选择了\ *《如何像计算机科学家一样思考》*\ 。

这本书的第一版很粗糙，但是却起了作用。学生们读了它之后，对书中内容理解的很好，
因此我才可以在课堂上讲授那些困难、有趣的主题，并让学生们动手实践（这点最重要）。

我将此书以GNU自有文档许可的形式发布，允许用户拷贝、修改和传播此书。

有趣的是接下来发生的事。弗吉尼亚一所高中的教师Jeff Elkne采用了我的教材，
并改为使用Python语言。他将修改过的书发给了我一份，就这样，我读着自己的书学会了
Python。2001年，通过Green Tea Press，我出版了本书的第一个Python版本。

2003年，我开始在Olin College教书，并且第一次教授Python语言。
与Java教学的对比很明显。学生们遇到的困难更少，学到的更多，开发了更有趣的工程，
并且大部分人都学的更开心。

此后，我一直致力于改善本书，纠正错误，改进一些示例，新增教学材料，尤其是练习题。

最后的结果，就是此书。现在的书名没有之前那么浮夸，就叫《\ *Think
Python*\ 》 。下面是一些变化：

-  我在每章的最后新增了一个名叫调试的小节。我会在这些小节中，为大家介绍如何发现及避免bug的一般技巧，并提醒大家注意使用Python过程中可能的陷阱。

-  我增补了更多的练习题，从测试是否理解书中概念的小测试，到部分较大的项目。大部分的练习题后，我都会附上答案的链接。

-  我新增了一系列案例研究——更长的代码示例，既有练习题，也有答题解释和讨论。

-  我扩充了对程序开发计划及基本设计模式的内容介绍。

-  我增加了关于调试和算法分析的附录。

*《Think Python》* 第二版还有以下新特点：

-  本书及其中的代码都已更新至Python 3。

-  我增加了一些小节内容，还在本书网站上介绍如何在网络浏览器上运行Python。这样，如果你嫌麻烦的话，就可以先不用在本地安装Python。

-  在海龟绘图这章中，我没有继续使用自己编写的海龟绘图包``Swampy``，改用了一个更标准的Python包 ``turtle``。这个包更容易安装，也更强大。

-  我新增了一个叫作“The Goodies”的章节，给大家介绍一些严格来说并不是必须了解的Python特性，不过有时候这些特性还是很方便的。

我希望你能使用该书愉快的工作，也希望它能帮助你学习编程，学会像计算机科学家一样思考，至少有那么一点像。

| Allen B. Downey
| Olin College

----

Acknowledgments
---------------

Many thanks to Jeff Elkner, who translated my Java book into Python,
which got this project started and introduced me to what has turned out
to be my favorite language.

Thanks also to Chris Meyers, who contributed several sections to *How to
Think Like a Computer Scientist*.

Thanks to the Free Software Foundation for developing the GNU Free
Documentation License, which helped make my collaboration with Jeff and
Chris possible, and Creative Commons for the license I am using now.

Thanks to the editors at Lulu who worked on *How to Think Like a
Computer Scientist*.

Thanks to the editors at O’Reilly Media who worked on *Think Python*.

Thanks to all the students who worked with earlier versions of this book
and all the contributors (listed below) who sent in corrections and
suggestions.

Contributor List
----------------

More than 100 sharp-eyed and thoughtful readers have sent in suggestions
and corrections over the past few years. Their contributions, and
enthusiasm for this project, have been a huge help.

If you have a suggestion or correction, please send email to
feedback@thinkpython.com. If I make a change based on your feedback, I
will add you to the contributor list (unless you ask to be omitted).

If you include at least part of the sentence the error appears in, that
makes it easy for me to search. Page and section numbers are fine, too,
but not quite as easy to work with. Thanks!

-  Lloyd Hugh Allen sent in a correction to Section 8.4.

-  Yvon Boulianne sent in a correction of a semantic error in Chapter 5.

-  Fred Bremmer submitted a correction in Section 2.1.

-  Jonah Cohen wrote the Perl scripts to convert the LaTeX source for
   this book into beautiful HTML.

-  Michael Conlon sent in a grammar correction in Chapter 2 and an
   improvement in style in Chapter 1, and he initiated discussion on the
   technical aspects of interpreters.

-  Benoit Girard sent in a correction to a humorous mistake in Section
   5.6.

-  Courtney Gleason and Katherine Smith wrote horsebet.py, which was
   used as a case study in an earlier version of the book. Their program
   can now be found on the website.

-  Lee Harr submitted more corrections than we have room to list here,
   and indeed he should be listed as one of the principal editors of the
   text.

-  James Kaylin is a student using the text. He has submitted numerous
   corrections.

-  David Kershaw fixed the broken catTwice function in Section 3.10.

-  Eddie Lam has sent in numerous corrections to Chapters 1, 2, and 3.
   He also fixed the Makefile so that it creates an index the first time
   it is run and helped us set up a versioning scheme.

-  Man-Yong Lee sent in a correction to the example code in Section 2.4.

-  David Mayo pointed out that the word “unconsciously" in Chapter 1
   needed to be changed to “subconsciously".

-  Chris McAloon sent in several corrections to Sections 3.9 and 3.10.

-  Matthew J. Moelter has been a long-time contributor who sent in
   numerous corrections and suggestions to the book.

-  Simon Dicon Montford reported a missing function definition and
   several typos in Chapter 3. He also found errors in the increment
   function in Chapter 13.

-  John Ouzts corrected the definition of “return value" in Chapter 3.

-  Kevin Parks sent in valuable comments and suggestions as to how to
   improve the distribution of the book.

-  David Pool sent in a typo in the glossary of Chapter 1, as well as
   kind words of encouragement.

-  Michael Schmitt sent in a correction to the chapter on files and
   exceptions.

-  Robin Shaw pointed out an error in Section 13.1, where the printTime
   function was used in an example without being defined.

-  Paul Sleigh found an error in Chapter 7 and a bug in Jonah Cohen’s
   Perl script that generates HTML from LaTeX.

-  Craig T. Snydal is testing the text in a course at Drew University.
   He has contributed several valuable suggestions and corrections.

-  Ian Thomas and his students are using the text in a programming
   course. They are the first ones to test the chapters in the latter
   half of the book, and they have made numerous corrections and
   suggestions.

-  Keith Verheyden sent in a correction in Chapter 3.

-  Peter Winstanley let us know about a longstanding error in our Latin
   in Chapter 3.

-  Chris Wrobel made corrections to the code in the chapter on file I/O
   and exceptions.

-  Moshe Zadka has made invaluable contributions to this project. In
   addition to writing the first draft of the chapter on Dictionaries,
   he provided continual guidance in the early stages of the book.

-  Christoph Zwerschke sent several corrections and pedagogic
   suggestions, and explained the difference between *gleich* and
   *selbe*.

-  James Mayer sent us a whole slew of spelling and typographical
   errors, including two in the contributor list.

-  Hayden McAfee caught a potentially confusing inconsistency between
   two examples.

-  Angel Arnal is part of an international team of translators working
   on the Spanish version of the text. He has also found several errors
   in the English version.

-  Tauhidul Hoque and Lex Berezhny created the illustrations in Chapter
   1 and improved many of the other illustrations.

-  Dr. Michele Alzetta caught an error in Chapter 8 and sent some
   interesting pedagogic comments and suggestions about Fibonacci and
   Old Maid.

-  Andy Mitchell caught a typo in Chapter 1 and a broken example in
   Chapter 2.

-  Kalin Harvey suggested a clarification in Chapter 7 and caught some
   typos.

-  Christopher P. Smith caught several typos and helped us update the
   book for Python 2.2.

-  David Hutchins caught a typo in the Foreword.

-  Gregor Lingl is teaching Python at a high school in Vienna, Austria.
   He is working on a German translation of the book, and he caught a
   couple of bad errors in Chapter 5.

-  Julie Peters caught a typo in the Preface.

-  Florin Oprina sent in an improvement in makeTime, a correction in
   printTime, and a nice typo.

-  D. J. Webre suggested a clarification in Chapter 3.

-  Ken found a fistful of errors in Chapters 8, 9 and 11.

-  Ivo Wever caught a typo in Chapter 5 and suggested a clarification in
   Chapter 3.

-  Curtis Yanko suggested a clarification in Chapter 2.

-  Ben Logan sent in a number of typos and problems with translating the
   book into HTML.

-  Jason Armstrong saw the missing word in Chapter 2.

-  Louis Cordier noticed a spot in Chapter 16 where the code didn’t
   match the text.

-  Brian Cain suggested several clarifications in Chapters 2 and 3.

-  Rob Black sent in a passel of corrections, including some changes for
   Python 2.2.

-  Jean-Philippe Rey at Ecole Centrale Paris sent a number of patches,
   including some updates for Python 2.2 and other thoughtful
   improvements.

-  Jason Mader at George Washington University made a number of useful
   suggestions and corrections.

-  Jan Gundtofte-Bruun reminded us that “a error” is an error.

-  Abel David and Alexis Dinno reminded us that the plural of “matrix”
   is “matrices”, not “matrixes”. This error was in the book for years,
   but two readers with the same initials reported it on the same day.
   Weird.

-  Charles Thayer encouraged us to get rid of the semi-colons we had put
   at the ends of some statements and to clean up our use of “argument”
   and “parameter”.

-  Roger Sperberg pointed out a twisted piece of logic in Chapter 3.

-  Sam Bull pointed out a confusing paragraph in Chapter 2.

-  Andrew Cheung pointed out two instances of “use before def”.

-  C. Corey Capel spotted the missing word in the Third Theorem of
   Debugging and a typo in Chapter 4.

-  Alessandra helped clear up some Turtle confusion.

-  Wim Champagne found a brain-o in a dictionary example.

-  Douglas Wright pointed out a problem with floor division in arc.

-  Jared Spindor found some jetsam at the end of a sentence.

-  Lin Peiheng sent a number of very helpful suggestions.

-  Ray Hagtvedt sent in two errors and a not-quite-error.

-  Torsten Hübsch pointed out an inconsistency in Swampy.

-  Inga Petuhhov corrected an example in Chapter 14.

-  Arne Babenhauserheide sent several helpful corrections.

-  Mark E. Casida is is good at spotting repeated words.

-  Scott Tyler filled in a that was missing. And then sent in a heap of
   corrections.

-  Gordon Shephard sent in several corrections, all in separate emails.

-  Andrew Turner spotted an error in Chapter 8.

-  Adam Hobart fixed a problem with floor division in arc.

-  Daryl Hammond and Sarah Zimmerman pointed out that I served up
   math.pi too early. And Zim spotted a typo.

-  George Sass found a bug in a Debugging section.

-  Brian Bingham suggested Exercise [exrotatepairs].

-  Leah Engelbert-Fenton pointed out that I used tuple as a variable
   name, contrary to my own advice. And then found a bunch of typos and
   a “use before def”.

-  Joe Funke spotted a typo.

-  Chao-chao Chen found an inconsistency in the Fibonacci example.

-  Jeff Paine knows the difference between space and spam.

-  Lubos Pintes sent in a typo.

-  Gregg Lind and Abigail Heithoff suggested Exercise [checksum].

-  Max Hailperin has sent in a number of corrections and suggestions.
   Max is one of the authors of the extraordinary *Concrete
   Abstractions*, which you might want to read when you are done with
   this book.

-  Chotipat Pornavalai found an error in an error message.

-  Stanislaw Antol sent a list of very helpful suggestions.

-  Eric Pashman sent a number of corrections for Chapters 4–11.

-  Miguel Azevedo found some typos.

-  Jianhua Liu sent in a long list of corrections.

-  Nick King found a missing word.

-  Martin Zuther sent a long list of suggestions.

-  Adam Zimmerman found an inconsistency in my instance of an “instance”
   and several other errors.

-  Ratnakar Tiwari suggested a footnote explaining degenerate triangles.

-  Anurag Goel suggested another solution for ``is_abecedarian`` and
   sent some additional corrections. And he knows how to spell Jane
   Austen.

-  Kelli Kratzer spotted one of the typos.

-  Mark Griffiths pointed out a confusing example in Chapter 3.

-  Roydan Ongie found an error in my Newton’s method.

-  Patryk Wolowiec helped me with a problem in the HTML version.

-  Mark Chonofsky told me about a new keyword in Python 3.

-  Russell Coleman helped me with my geometry.

-  Wei Huang spotted several typographical errors.

-  Karen Barber spotted the the oldest typo in the book.

-  Nam Nguyen found a typo and pointed out that I used the Decorator
   pattern but didn’t mention it by name.

-  Stéphane Morin sent in several corrections and suggestions.

-  Paul Stoop corrected a typo in ``uses_only``.

-  Eric Bronner pointed out a confusion in the discussion of the order
   of operations.

-  Alexandros Gezerlis set a new standard for the number and quality of
   suggestions he submitted. We are deeply grateful!

-  Gray Thomas knows his right from his left.

-  Giovanni Escobar Sosa sent a long list of corrections and
   suggestions.

-  Alix Etienne fixed one of the URLs.

-  Kuang He found a typo.

-  Daniel Neilson corrected an error about the order of operations.

-  Will McGinnis pointed out that polyline was defined differently in
   two places.

-  Swarup Sahoo spotted a missing semi-colon.

-  Frank Hecker pointed out an exercise that was under-specified, and
   some broken links.

-  Animesh B helped me clean up a confusing example.

-  Martin Caspersen found two round-off errors.

-  Gregor Ulm sent several corrections and suggestions.

-  Dimitrios Tsirigkas suggested I clarify an exercise.

-  Carlos Tafur sent a page of corrections and suggestions.

-  Martin Nordsletten found a bug in an exercise solution.

-  Lars O.D. Christensen found a broken reference.

-  Victor Simeone found a typo.

-  Sven Hoexter pointed out that a variable named input shadows a
   build-in function.

-  Viet Le found a typo.

-  Stephen Gregory pointed out the problem with cmp in Python 3.

-  Matthew Shultz let me know about a broken link.

-  Lokesh Kumar Makani let me know about some broken links and some
   changes in error messages.

-  Ishwar Bhat corrected my statement of Fermat’s last theorem.

-  Brian McGhie suggested a clarification.

-  Andrea Zanella translated the book into Italian, and sent a number of
   corrections along the way.

-  Many, many thanks to Melissa Lewis and Luciano Ramalho for excellent
   comments and suggestions on the second edition.

-  Thanks to Harry Percival from PythonAnywhere for his help getting
   people started running Python in a browser.

-  Xavier Van Aubel made several useful corrections in the second
   edition.