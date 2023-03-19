--OK, so welcome back to 4.18. 00:00:00,000 --> 00:00:13,480
好的，欢迎回到 4.18。
--So today, we're going to start talking about parallel 00:00:13,480 --> 00:00:15,720
所以今天，我们要开始讨论并行
--software. 00:00:15,720 --> 00:00:16,880
软件。
--Last week, we talked about parallel hardware. 00:00:16,880 --> 00:00:19,920
上周，我们讨论了并行硬件。
--And the theme for all of this week and most of next week 00:00:19,920 --> 00:00:24,320
以及本周和下周大部分时间的主题
--will be how we actually write parallel code. 00:00:24,320 --> 00:00:27,760
将是我们实际编写并行代码的方式。
--And in fact, so today's theme is the difference 00:00:27,760 --> 00:00:31,040
事实上，所以今天的主题是不同的
--between abstraction and implementation. 00:00:31,040 --> 00:00:33,920
在抽象和实现之间。
--So abstractions are things that we 00:00:33,920 --> 00:00:35,960
所以抽象是我们
--create to make life better for programmers, 00:00:35,960 --> 00:00:39,560
创造让程序员的生活更美好，
--to make it easier to express your code 00:00:39,560 --> 00:00:42,840
更容易表达你的代码
--and debug it and so on. 00:00:42,840 --> 00:00:44,840
并调试它等等。
--But these abstractions need to be implemented. 00:00:44,840 --> 00:00:48,120
但是这些抽象需要被实现。
--And when we're talking about parallelism, 00:00:48,120 --> 00:00:50,960
当我们谈论并行性时，
--it's easy to make the mistake of confusing abstraction 00:00:50,960 --> 00:00:55,240
很容易犯混淆抽象的错误
--and implementation, because these abstractions are 00:00:55,240 --> 00:00:58,400
和实现，因为这些抽象是
--used to express concurrency and communication. 00:00:58,400 --> 00:01:02,480
用于表示并发和通信。
--And the system is also doing communication and managing 00:01:02,480 --> 00:01:06,160
而系统也在做沟通和管理
--concurrency. 00:01:06,160 --> 00:01:07,480
并发。
--And you don't want to get these things confused 00:01:07,480 --> 00:01:10,680
你不想让这些事情混淆
--with each other. 00:01:10,680 --> 00:01:11,400
彼此。
--So we're going to go through a specific example first, which 00:01:11,400 --> 00:01:16,200
所以我们要先看一个具体的例子，
--is a really interesting parallel language called 00:01:16,200 --> 00:01:18,400
是一种非常有趣的并行语言，叫做
--ISPC from Intel. 00:01:18,400 --> 00:01:21,120
英特尔的 ISPC。
--And after that, I'm going to talk 00:01:21,120 --> 00:01:22,480
在那之后，我要谈谈
--about several other very popular and common abstractions. 00:01:22,480 --> 00:01:27,960
关于其他几个非常流行和常见的抽象。
--OK, so ISPC, this is a language that you can download. 00:01:27,960 --> 00:01:33,480
好的，ISPC，这是一种您可以下载的语言。
--It's available on GitHub. 00:01:33,480 --> 00:01:35,240
它在 GitHub 上可用。
--It was developed at Intel. 00:01:35,240 --> 00:01:37,720
它是在英特尔开发的。
--And it has this abstraction called, 00:01:37,720 --> 00:01:40,600
它有这个抽象，叫做
--the acronym for it is SPMD, which 00:01:40,600 --> 00:01:43,920
它的首字母缩写词是 SPMD，它
--stands for Single Program Multiple Data, which 00:01:43,920 --> 00:01:47,960
代表单程序多数据，它
--is a fancy way of saying that you have concurrency where 00:01:47,960 --> 00:01:51,920
是说你有并发的奇特方式
--each of the concurrent controls. 00:01:51,920 --> 00:01:57,440
每个并发控件。
--I'm trying hard not to say thread. 00:01:57,440 --> 00:01:59,720
我努力不说线程。
--So you could say thread. 00:01:59,720 --> 00:02:00,920
所以你可以说线程。
--Each of the logical threads, at least, 00:02:00,920 --> 00:02:04,640
每个逻辑线程，至少，
--are executing the same code. 00:02:04,640 --> 00:02:07,400
正在执行相同的代码。
--Now, they may or may not be executing it 00:02:07,400 --> 00:02:09,320
现在，他们可能会或可能不会执行它
--at exactly the same time. 00:02:09,320 --> 00:02:10,480
在完全相同的时间。
--But you hand them all the same, say, 00:02:10,480 --> 00:02:12,640
但你还是把它们都交给了，比如说，
--procedure or chunk of code. 00:02:12,640 --> 00:02:15,120
过程或代码块。
--And they all go off and execute that on their own data, 00:02:15,120 --> 00:02:18,920
他们都开始对自己的数据执行，
--on separate pieces of data. 00:02:18,920 --> 00:02:20,680
在不同的数据上。
--And that's how you get parallelism. 00:02:20,680 --> 00:02:22,560
这就是您获得并行性的方式。
--So that's a very common way of writing parallel code. 00:02:22,560 --> 00:02:25,960
所以这是一种非常常见的编写并行代码的方式。
--If you think about it, what's the alternative to that? 00:02:25,960 --> 00:02:28,240
如果你考虑一下，还有什么替代方案呢？
--It would be to have completely different programs operating 00:02:28,240 --> 00:02:31,920
这将是让完全不同的程序运行
--on different pieces of data, for example. 00:02:31,920 --> 00:02:34,960
例如，在不同的数据上。
--Now, that is something that happens sometimes 00:02:34,960 --> 00:02:37,380
现在，这有时会发生
--if you write something like, say, a web browser 00:02:37,380 --> 00:02:40,800
如果你写一些东西，比如说，一个网络浏览器
--or some piece of software where you have completely 00:02:40,800 --> 00:02:44,400
或者你完全拥有的一些软件
--different tasks unrelated to each other that 00:02:44,400 --> 00:02:47,000
互不相关的不同任务
--are doing their own thing. 00:02:47,000 --> 00:02:48,320
正在做自己的事情。
--They have completely different procedures 00:02:48,320 --> 00:02:50,400
他们有完全不同的程序
--that they're executing. 00:02:50,400 --> 00:02:51,720
他们正在执行。
--But in our class, when we're trying 00:02:51,720 --> 00:02:53,360
但是在我们的课堂上，当我们尝试
--to make things run faster, usually we're 00:02:53,360 --> 00:02:55,320
为了让事情运行得更快，通常我们是
--giving them the same code. 00:02:55,320 --> 00:02:57,720
给他们相同的代码。
--And they're executing that way. 00:02:57,720 --> 00:03:00,240
他们就是这样执行的。
--All right, now, as you may recall from Friday, 00:03:00,240 --> 00:03:03,840
好吧，现在，你可能还记得星期五的事，
--this was an example from the lecture. 00:03:03,840 --> 00:03:06,560
这是讲座中的一个例子。
--This is not necessarily the most interesting procedure 00:03:06,560 --> 00:03:09,760
这不一定是最有趣的过程
--in the world. 00:03:09,760 --> 00:03:10,260
在世界上。
--But it fits on one slide. 00:03:10,260 --> 00:03:11,920
但它适合一张幻灯片。
--And we're going to use it as an example today 00:03:11,920 --> 00:03:14,700
我们今天将以它为例
--when we talk about ISPC, at least. 00:03:14,700 --> 00:03:17,240
至少，当我们谈论 ISPC 时。
--So this code is computing signs using Taylor expansion. 00:03:17,280 --> 00:03:22,360
所以这段代码使用泰勒展开来计算符号。
--So we have an outer loop where it's 00:03:22,360 --> 00:03:25,560
所以我们有一个外循环
--going to generate lots of different values of output. 00:03:25,560 --> 00:03:28,960
将生成许多不同的输出值。
--And then there's an inner loop where it's 00:03:28,960 --> 00:03:31,320
然后有一个内部循环
--computing each of these terms. 00:03:31,320 --> 00:03:34,000
计算每一项。
--So now we're going to look at doing this in parallel. 00:03:34,000 --> 00:03:38,840
所以现在我们要考虑并行执行此操作。
--OK, so in ISPC, the way that this works, 00:03:38,840 --> 00:03:44,480
好的，所以在 ISPC 中，它的工作方式，
--it's a restricted model where what you do 00:03:44,480 --> 00:03:48,240
这是一个受限模型，你可以做什么
--is you take the pieces of software 00:03:48,240 --> 00:03:50,720
你拿的是软件件吗
--that you want to run in parallel. 00:03:50,720 --> 00:03:52,800
你想并行运行。
--And you pull them out and put them 00:03:52,800 --> 00:03:54,160
然后你把它们拉出来放好
--into their own separate files. 00:03:54,160 --> 00:03:56,760
到他们自己的单独文件中。
--And the code looks a lot like C code. 00:03:56,760 --> 00:04:00,040
而且代码看起来很像 C 代码。
--But it has the file name, instead of it being .c, 00:04:00,040 --> 00:04:04,560
但它有文件名，而不是.c，
--it's .ispc. 00:04:04,560 --> 00:04:07,160
它是 .ispc。
--So those things will run in parallel. 00:04:07,160 --> 00:04:11,200
所以这些东西将并行运行。
--I'll talk about that more in a second. 00:04:11,200 --> 00:04:13,680
我稍后会详细讨论。
--But then you have the code around that 00:04:13,680 --> 00:04:16,880
但是你有围绕它的代码
--that calls that parallel code. 00:04:16,880 --> 00:04:19,360
调用那个并行代码。
--So there's, in this case, main.cpp, our main file. 00:04:19,360 --> 00:04:24,160
所以，在这种情况下，我们的主文件是 main.cpp。
--It's going to actually execute sequentially 00:04:24,160 --> 00:04:27,240
它实际上是顺序执行的
--until it gets to the point where it calls 00:04:27,240 --> 00:04:30,240
直到它到达它调用的地步
--a method that's in an ISPC file. 00:04:30,240 --> 00:04:35,280
ISPC 文件中的方法。
--OK, now in this abstraction, you'll 00:04:35,280 --> 00:04:38,160
好的，现在在这个抽象中，你会
--notice we're not going to use the word thread. 00:04:38,160 --> 00:04:40,240
请注意，我们不会使用线程这个词。
--Instead, we talk about something that sounds a little squishy 00:04:40,240 --> 00:04:43,160
相反，我们谈论的东西听起来有点软
--or a little bit vague. 00:04:43,160 --> 00:04:45,040
或者有点模糊。
--So the idea is what it's going to spawn 00:04:45,040 --> 00:04:48,120
所以这个想法就是它会产生什么
--is not actually threads, but it's 00:04:48,120 --> 00:04:51,440
实际上不是线程，但它是
--going to have this collection or gang of program instances, 00:04:51,440 --> 00:04:56,680
将有这个集合或程序实例团伙，
--so things that are operating concurrently. 00:04:56,680 --> 00:05:00,320
所以同时运行的东西。
--OK, and if we animate what this looks like, 00:05:00,320 --> 00:05:05,400
好的，如果我们为它制作动画，
--basically what happens is when you're over here 00:05:05,400 --> 00:05:08,040
基本上当你在这里时会发生什么
--in the main file here, until you call that method, 00:05:08,720 --> 00:05:13,400
在此处的主文件中，直到您调用该方法，
--you're executing sequentially. 00:05:13,400 --> 00:05:15,320
您正在按顺序执行。
--So there's no concurrency there. 00:05:15,320 --> 00:05:16,680
所以那里没有并发性。
--You're just operating sequentially. 00:05:16,680 --> 00:05:18,680
你只是按顺序操作。
--Then you hit this method that's in an ISPC file. 00:05:18,680 --> 00:05:23,320
然后你点击 ISPC 文件中的这个方法。
--At that point, you're running concurrently. 00:05:23,320 --> 00:05:25,800
那时，您正在同时运行。
--And then when you return from it, 00:05:25,800 --> 00:05:27,640
然后当你从那里回来时，
--then you go back to running sequentially again. 00:05:27,640 --> 00:05:29,800
然后你又回到顺序运行。
--So you express all of your parallelism 00:05:29,800 --> 00:05:32,560
所以你表达了你所有的并行性
--by way of creating these separate ISPC files. 00:05:32,560 --> 00:05:36,600
通过创建这些单独的 ISPC 文件。
--Now, there are other interesting things about this. 00:05:37,280 --> 00:05:41,320
现在，还有其他有趣的事情。
--So so far, I just was talking at a high level. 00:05:41,320 --> 00:05:43,880
到目前为止，我只是在高层次上谈论。
--Now let's look in a little more detail 00:05:43,880 --> 00:05:46,280
现在让我们更详细地看一下
--at some of the new keywords that we see in the ISPC file. 00:05:46,280 --> 00:05:52,080
我们在 ISPC 文件中看到的一些新关键词。
--So first of all, there are a couple of variables, 00:05:52,080 --> 00:05:59,240
所以首先，有几个变量，
--program count and program index. 00:05:59,240 --> 00:06:02,040
程序计数和程序索引。
--So program count is the number of concurrent instances 00:06:02,040 --> 00:06:07,560
所以程序计数是并发实例数
--in the gang. 00:06:07,560 --> 00:06:09,280
在帮派中。
--So how many things are we running in parallel? 00:06:09,280 --> 00:06:14,080
那么我们并行运行了多少东西？
--An interesting thing about ISPC is that you don't set that. 00:06:14,080 --> 00:06:17,600
关于 ISPC 的一个有趣的事情是你没有设置它。
--The system, the runtime system, decides 00:06:17,600 --> 00:06:20,640
系统，运行时系统，决定
--what that value should be. 00:06:20,640 --> 00:06:22,640
该值应该是多少。
--So you can read it in the software as a programmer, 00:06:22,640 --> 00:06:25,640
所以你可以以程序员的身份在软件中阅读它，
--but you don't set that. 00:06:25,640 --> 00:06:27,920
但你没有设置它。
--So you can see that we're looking at program count here. 00:06:27,920 --> 00:06:32,840
所以你可以看到我们在这里查看程序计数。
--So that's the total number of concurrent things, 00:06:32,840 --> 00:06:36,520
这就是并发事物的总数，
--program instances. 00:06:36,520 --> 00:06:38,000
程序实例。
--But sometimes you want to know, well, which instance am I 00:06:38,000 --> 00:06:40,840
但有时你想知道，嗯，我是哪个实例
--specifically? 00:06:40,840 --> 00:06:42,240
具体来说？
--And that's the point of program index. 00:06:42,240 --> 00:06:45,080
这就是程序索引的意义所在。
--So that program index variable tells you your instance number 00:06:45,080 --> 00:06:51,160
所以那个程序索引变量告诉你你的实例号
--from 0 to n minus 1. 00:06:51,160 --> 00:06:53,780
从 0 到 n 减 1。
--So if you look at the code here, you 00:06:53,780 --> 00:06:55,320
所以如果你看这里的代码，你
--can see what it's done is we've rewritten the outer loop 00:06:55,320 --> 00:07:00,520
可以看到它做了什么我们重写了外循环
--so that instead of incrementing it by 1, 00:07:00,520 --> 00:07:02,960
所以不是将它递增 1，
--we're hopping ahead by program count. 00:07:02,960 --> 00:07:06,280
我们在节目数量上领先。
--So if program count is, say, 4, then 00:07:06,280 --> 00:07:09,200
所以如果程序计数是，比方说，4，那么
--we'll be jumping ahead by 4. 00:07:09,200 --> 00:07:12,080
我们将提前 4 点。
--And there will be four concurrent instances 00:07:12,080 --> 00:07:14,680
并且会有四个并发实例
--running in parallel. 00:07:14,680 --> 00:07:16,480
并行运行。
--And they do separate work because this index 00:07:16,480 --> 00:07:20,520
他们分开工作，因为这个索引
--is calculated taking into account that offset, 00:07:20,520 --> 00:07:24,600
计算时考虑了该偏移量，
--their particular program index. 00:07:24,600 --> 00:07:26,840
他们特定的节目索引。
--So you can see that that's then used to access whatever data 00:07:26,840 --> 00:07:30,360
所以你可以看到它被用来访问任何数据
--they're working on. 00:07:30,360 --> 00:07:31,560
他们正在努力。
--So because of this, each instance 00:07:31,560 --> 00:07:33,360
因此，正因为如此，每个实例
--is actually working on separate work. 00:07:33,360 --> 00:07:37,040
实际上是在做单独的工作。
--So one thing that I forgot to say 00:07:37,040 --> 00:07:38,560
所以有一件事我忘了说
--is, what if we just took the original method, sine x, 00:07:38,560 --> 00:07:45,880
就是，如果我们只采用原来的方法，正弦 x，会怎样，
--and we simply took it as is and put it into an ISPC file 00:07:45,880 --> 00:07:51,120
我们只是照原样将其放入 ISPC 文件中
--and called it? 00:07:51,120 --> 00:07:52,640
并称之为？
--So what would happen then? 00:07:52,680 --> 00:07:54,960
那么会发生什么呢？
--Well, it would create program count 00:07:54,960 --> 00:07:57,480
好吧，它会创建程序计数
--number of concurrent instances of that code. 00:07:57,480 --> 00:08:01,120
该代码的并发实例数。
--But since each one of them would do exactly the same work, 00:08:01,120 --> 00:08:05,080
但由于他们每个人都会做完全相同的工作，
--they would actually be entirely redundant with each other. 00:08:05,080 --> 00:08:08,680
他们实际上彼此完全多余。
--So it would not actually make the program run any faster. 00:08:08,680 --> 00:08:12,640
所以它实际上不会使程序运行得更快。
--So what you want to do to make it run faster 00:08:12,640 --> 00:08:14,880
所以你想做什么让它运行得更快
--is you have to divide up the work. 00:08:14,880 --> 00:08:16,520
你必须分工吗？
--So that's the point of having this extra stuff in here 00:08:16,520 --> 00:08:20,680
所以这就是在这里添加这些额外内容的意义所在
--is that we don't want each of them to do all of the work 00:08:20,680 --> 00:08:24,520
是我们不希望他们每个人都做所有的工作
--because then we don't run any faster. 00:08:24,520 --> 00:08:26,320
因为那样我们就不会跑得更快了。
--We have to divide it up. 00:08:26,320 --> 00:08:27,320
我们必须把它分开。
--And that's how it's working in this example. 00:08:27,320 --> 00:08:31,040
这就是它在这个例子中的工作方式。
--Now, there's one other keyword in here, which is uniform. 00:08:31,040 --> 00:08:36,640
现在，这里还有另一个关键字，它是统一的。
--And this is actually just a hint for optimization purposes. 00:08:36,640 --> 00:08:40,880
而这实际上只是出于优化目的的提示。
--What uniform means is that each program instance, 00:08:40,880 --> 00:08:44,920
统一意味着每个程序实例，
--if you use that as a type modifier, 00:08:44,920 --> 00:08:47,640
如果您将其用作类型修饰符，
--it means that each copy of that variable 00:08:47,640 --> 00:08:51,120
这意味着该变量的每个副本
--will have exactly the same value across all 00:08:51,120 --> 00:08:53,640
将具有完全相同的价值
--of the concurrent instances. 00:08:53,640 --> 00:08:55,760
的并发实例。
--So there are things that do not have that. 00:08:55,760 --> 00:08:57,560
所以有些东西没有那个。
--So for example, index is not uniform 00:08:57,560 --> 00:09:01,160
例如，索引不统一
--because each concurrent instance is 00:09:01,160 --> 00:09:03,400
因为每个并发实例是
--going to have a different value of index 00:09:03,400 --> 00:09:05,260
将具有不同的索引值
--depending on what program index and i happen to be. 00:09:05,260 --> 00:09:11,400
取决于什么程序索引和我恰好是。
--OK, so any questions about that? 00:09:11,400 --> 00:09:15,120
好的，有什么问题吗？
--We'll be talking more about this. 00:09:15,120 --> 00:09:16,680
我们将更多地讨论这个。
--But, yep? 00:09:16,680 --> 00:09:20,120
但是，是吗？
--So how is the uniform thing implemented? 00:09:20,120 --> 00:09:22,840
那么统一的东西是如何实现的呢？
--Is it like one actual value that they can all read? 00:09:22,840 --> 00:09:26,640
它就像一个他们都可以读取的实际值吗？
--Or can they just make sure that they 00:09:26,640 --> 00:09:28,280
或者他们可以确保他们
--have separate values that update at the same time? 00:09:28,280 --> 00:09:33,000
有同时更新的单独值？
--Yep, that's a great question. 00:09:33,000 --> 00:09:34,320
是的，这是一个很好的问题。
--So in a minute, I'm going to pull back the covers 00:09:34,320 --> 00:09:36,720
所以一分钟后，我要掀开被子
--and show you this really surprising thing about how 00:09:36,720 --> 00:09:39,200
并向您展示这件非常令人惊讶的事情
--this is implemented. 00:09:39,200 --> 00:09:40,040
这是实施。
--And then hopefully, it'll make sense 00:09:40,040 --> 00:09:41,960
然后希望这会有意义
--why you need to bother to think about uniform 00:09:41,960 --> 00:09:44,240
为什么你需要费心去考虑制服
--because it is an unusual type of hint. 00:09:44,240 --> 00:09:47,560
因为这是一种不寻常的提示。
--Normally, when we're writing parallel code 00:09:47,560 --> 00:09:51,440
通常，当我们编写并行代码时
--and many other abstractions, you do not 00:09:51,440 --> 00:09:53,680
和许多其他抽象，你不
--have something like uniform. 00:09:53,680 --> 00:09:55,240
有类似制服的东西。
--But when I explain what it really does under the covers, 00:09:55,240 --> 00:09:58,980
但是当我解释它在幕后的真正作用时，
--hopefully, it'll make more sense. 00:09:58,980 --> 00:10:00,360
希望它会更有意义。
--And if not, we'll talk more about it 00:10:00,360 --> 00:10:01,900
如果没有，我们会更多地讨论它
--then, which will be in just a few minutes here. 00:10:01,900 --> 00:10:05,680
然后，这将在几分钟后在这里进行。
--OK, so as I was describing a minute ago, 00:10:05,680 --> 00:10:10,120
好的，就像我一分钟前描述的那样，
--we're using the combination of i and program index 00:10:10,120 --> 00:10:13,020
我们正在使用 i 和程序索引的组合
--to figure out this IDX variable. 00:10:13,020 --> 00:10:15,300
找出这个 IDX 变量。
--And that controls what data each concurrent instance is actually 00:10:15,300 --> 00:10:19,940
这控制了每个并发实例实际上是什么数据
--executing. 00:10:19,940 --> 00:10:20,580
执行。
--And just to look at that, that style of decomposition 00:10:20,580 --> 00:10:25,420
看看那个，那种分解风格
--is called interleaved. 00:10:25,420 --> 00:10:27,180
称为交错。
--So just to illustrate this graphically, 00:10:27,180 --> 00:10:30,740
因此，为了以图形方式说明这一点，
--let's imagine that we have four program instances. 00:10:30,740 --> 00:10:34,460
假设我们有四个程序实例。
--So program count would be four. 00:10:34,460 --> 00:10:36,900
所以程序数是四个。
--Now, as we're executing along, what this means 00:10:36,900 --> 00:10:40,340
现在，当我们执行时，这意味着什么
--is that instance 0, since its program index is 0, 00:10:40,340 --> 00:10:43,940
是那个实例 0，因为它的程序索引是 0，
--and since we'd be bumping up the outer loop by four at a time, 00:10:43,940 --> 00:10:48,020
因为我们一次要将外循环增加四个，
--it's going to be jumping ahead by four. 00:10:48,020 --> 00:10:50,020
它将领先四倍。
--So it would start off with 0, 4, 8, and so on. 00:10:50,020 --> 00:10:54,740
所以它将以 0、4、8 等开始。
--And then the next instances would 00:10:54,740 --> 00:10:56,180
然后下一个实例会
--have the values after that. 00:10:56,180 --> 00:10:58,060
之后有值。
--So that's what interleaved looks like. 00:10:58,060 --> 00:11:02,860
这就是交错的样子。
--Now, that's not the only way to do it. 00:11:02,860 --> 00:11:04,660
现在，这不是唯一的方法。
--There's another way we can implement this. 00:11:04,660 --> 00:11:09,780
我们还有另一种方法可以实现这一点。
--So actually, I'll hold that thought for a second. 00:11:10,420 --> 00:11:13,900
所以实际上，我会暂时保留这个想法。
--So now I'm going to actually explain what's 00:11:13,900 --> 00:11:15,860
所以现在我要真正解释什么是
--going on under the covers. 00:11:15,860 --> 00:11:17,820
在幕后进行。
--So ISPC was designed for a specific reason, 00:11:17,820 --> 00:11:23,220
所以 ISPC 是出于特定原因而设计的，
--which is actually to make it easier 00:11:23,220 --> 00:11:24,840
这实际上是为了让它更容易
--to write code that takes advantage of SIMD vector 00:11:24,840 --> 00:11:28,540
编写利用 SIMD 向量的代码
--instructions. 00:11:28,540 --> 00:11:30,340
指示。
--So you can write code with SIMD vector instructions 00:11:30,340 --> 00:11:34,260
因此您可以使用 SIMD 矢量指令编写代码
--by just sticking in these special macros or pragmas 00:11:34,260 --> 00:11:39,080
只需坚持使用这些特殊的宏或编译指示
--where you can say, OK, don't do an add, do a vector add, 00:11:39,080 --> 00:11:42,680
你可以说，好的，不要做加法，做向量加法，
--and now do a vector multiply. 00:11:42,680 --> 00:11:44,720
现在做一个向量乘法。
--It's a little painful to do that. 00:11:44,720 --> 00:11:46,720
这样做有点痛苦。
--So the idea is programmers have this abstraction, which is, 00:11:46,720 --> 00:11:51,600
所以这个想法是程序员有这个抽象，也就是，
--hey, we're not writing SIMD vector code. 00:11:51,600 --> 00:11:53,520
嘿，我们不是在编写 SIMD 矢量代码。
--We're just writing plain old, more or less generic-looking 00:11:53,520 --> 00:11:57,760
我们只是在写普通的、或多或少看起来很普通的东西
--concurrent code. 00:11:57,760 --> 00:11:58,840
并发代码。
--And now the compiler will play some tricks 00:11:58,840 --> 00:12:01,160
现在编译器会玩一些花样
--and generate some interesting code under the covers. 00:12:01,160 --> 00:12:05,000
并在幕后生成一些有趣的代码。
--So the abstraction is that we have these program instances, 00:12:05,000 --> 00:12:11,120
所以抽象是我们有这些程序实例，
--which are not separate threads, it turns out. 00:12:11,120 --> 00:12:14,000
事实证明，它们不是单独的线程。
--What it generates is just a single thread of execution. 00:12:14,000 --> 00:12:17,800
它生成的只是一个执行线程。
--But it uses the SIMD vector instructions 00:12:17,800 --> 00:12:21,000
但它使用 SIMD 矢量指令
--to take advantage of the parallelism. 00:12:21,000 --> 00:12:23,880
利用并行性。
--So we'll look at the code in a second here. 00:12:23,880 --> 00:12:28,200
因此，我们稍后将在此处查看代码。
--And so in fact, now that I've told you that, 00:12:28,200 --> 00:12:30,920
所以事实上，既然我已经告诉你了，
--you can probably guess what the value of program count is, 00:12:30,920 --> 00:12:35,200
你大概可以猜到程序计数的值是多少，
--which is it's the vector width of the machine, 00:12:35,200 --> 00:12:38,400
这是机器的矢量宽度，
--basically, taking into account the width of the data types 00:12:38,400 --> 00:12:42,000
基本上，考虑到数据类型的宽度
--you're operating on, basically. 00:12:42,000 --> 00:12:44,440
基本上，你在做手术。
--So that's the idea. 00:12:44,440 --> 00:12:48,440
这就是我们的想法。
--And OK, so that's what it's doing. 00:12:48,440 --> 00:12:52,920
好的，这就是它正在做的。
--And I think later, I believe I'll show you 00:12:52,920 --> 00:12:55,840
我想以后，我相信我会告诉你
--what the code looks like, maybe. 00:12:55,840 --> 00:12:57,880
代码看起来像什么，也许。
--Yes, we'll get to some examples where we actually 00:12:57,880 --> 00:13:00,000
是的，我们会得到一些例子，我们实际上
--see some of the code that's generated 00:13:00,080 --> 00:13:02,360
查看生成的一些代码
--in a couple of slides. 00:13:02,360 --> 00:13:03,680
在几张幻灯片中。
--But before I get to that, a minute ago, 00:13:03,680 --> 00:13:05,880
但在我开始之前，一分钟前，
--remember, I showed you the fact that this code that we've 00:13:05,880 --> 00:13:10,800
记住，我向你展示了我们的这段代码
--looked at so far is doing interleaved access of data. 00:13:10,800 --> 00:13:15,560
到目前为止，我们正在对数据进行交错访问。
--Now, there's another major common option 00:13:15,560 --> 00:13:18,280
现在，还有另一个主要的共同选择
--for accessing the data, which is called blocked assignment 00:13:18,280 --> 00:13:21,480
用于访问数据，这称为阻塞分配
--rather than interleaved assignment. 00:13:21,480 --> 00:13:23,520
而不是交错分配。
--So here, instead of going round robin across the data 00:13:23,520 --> 00:13:27,000
所以在这里，而不是循环遍历数据
--elements, you break up the data into contiguous chunks 00:13:27,000 --> 00:13:31,800
元素，你将数据分解成连续的块
--instead. 00:13:31,800 --> 00:13:32,480
反而。
--So you're not interleaving. 00:13:32,480 --> 00:13:34,080
所以你没有交错。
--You're getting these chunks. 00:13:34,080 --> 00:13:36,520
你得到这些块。
--So here's what the code looks like that will do that. 00:13:36,520 --> 00:13:40,640
因此，这就是执行此操作的代码。
--So notice that the logic here is a little bit different. 00:13:40,640 --> 00:13:45,360
所以请注意这里的逻辑有点不同。
--Now, what we do is we figure out how many contiguous elements 00:13:45,360 --> 00:13:49,640
现在，我们要做的是找出有多少个连续元素
--are we operating on, and for now, ignore the fact 00:13:49,640 --> 00:13:52,800
我们是否在继续运作，暂时忽略这个事实
--that that may not divide nicely. 00:13:52,800 --> 00:13:55,240
那可能不会很好地划分。
--And then we figure out which. 00:13:55,240 --> 00:13:58,320
然后我们找出哪个。
--So basically, we're going to take this array of data, 00:13:58,320 --> 00:14:01,600
所以基本上，我们要获取这组数据，
--so lots and lots of elements here. 00:14:01,600 --> 00:14:04,560
这里有很多元素。
--And then what we do is we divide this into chunks. 00:14:04,560 --> 00:14:09,000
然后我们所做的是将其分成块。
--Like, let's say there are four chunks, 00:14:09,000 --> 00:14:11,720
比如，假设有四个块，
--because there are four program instances. 00:14:11,720 --> 00:14:15,280
因为有四个程序实例。
--And now, they need to know, how wide is this, 00:14:15,280 --> 00:14:18,400
现在，他们需要知道，这有多宽，
--and where do I start? 00:14:18,400 --> 00:14:20,360
我从哪里开始？
--And that's what all of this code is doing down here. 00:14:20,360 --> 00:14:24,040
这就是所有这些代码在这里所做的。
--So you figure out where you start, 00:14:24,040 --> 00:14:26,160
所以你弄清楚你从哪里开始，
--and you know how many of them there are. 00:14:26,160 --> 00:14:28,640
你知道有多少人。
--And then you just go ahead and have 00:14:28,640 --> 00:14:31,680
然后你继续前进并拥有
--an inner loop that looks very much like the inner loop we saw 00:14:31,680 --> 00:14:34,160
一个内循环，看起来很像我们看到的内循环
--before, or code inside of that, that is. 00:14:34,160 --> 00:14:38,280
之前，或者里面的代码，就是这样。
--All right, so these are two options. 00:14:38,280 --> 00:14:41,640
好吧，所以这是两个选择。
--Oh, and then here's what this would look like. 00:14:41,640 --> 00:14:44,120
哦，这就是它的样子。
--You saw interleaved already. 00:14:44,120 --> 00:14:45,360
你已经看到交错了。
--So in the blocked case, you hand out contiguous elements 00:14:45,360 --> 00:14:49,480
所以在阻塞的情况下，你分发连续的元素
--instead of interleaved elements. 00:14:49,480 --> 00:14:52,920
而不是交错的元素。
--OK, so which of these things do you think is better, 00:14:52,920 --> 00:14:55,400
好的，那么你认为哪一个更好，
--blocked or interleaved? 00:14:55,400 --> 00:14:57,000
阻塞或交错？
--Let's see. 00:15:02,880 --> 00:15:03,880
让我们来看看。
--Yeah? 00:15:03,880 --> 00:15:04,400
是的？
--Depends on your data. 00:15:04,400 --> 00:15:06,160
取决于你的数据。
--OK. 00:15:06,160 --> 00:15:07,440
好的。
--OK. 00:15:07,440 --> 00:15:08,600
好的。
--So do you have an example of when one or the other 00:15:08,600 --> 00:15:12,160
那么你有没有一个例子说明什么时候
--might be better? 00:15:12,160 --> 00:15:13,680
可能会更好？
--Or? 00:15:13,680 --> 00:15:14,240
或者？
--Well, in the case of if the data set that you're working on 00:15:14,240 --> 00:15:18,440
好吧，如果你正在处理的数据集
--has different amounts of work across that array, 00:15:18,440 --> 00:15:23,000
在该数组中有不同的工作量，
--if the first one through seven take a lot more time 00:15:23,000 --> 00:15:27,840
如果第一个到七个需要更多时间
--to process the block method, it's 00:15:27,840 --> 00:15:29,640
处理块方法，它是
--not going to be sufficient for the interleaved method. 00:15:29,640 --> 00:15:32,680
对于交错方法来说是不够的。
--That's when you get, you spread out 00:15:32,680 --> 00:15:35,880
那是你得到的时候，你散开了
--the hard work between the computations that you get. 00:15:35,880 --> 00:15:40,920
您获得的计算之间的艰苦工作。
--Yeah, so speaking generically, not necessarily 00:15:40,920 --> 00:15:43,800
是的，所以笼统地说，不一定
--for this specific code that we're looking at, 00:15:43,800 --> 00:15:45,960
对于我们正在查看的这个特定代码，
--but a common disadvantage of blocked assignment 00:15:45,960 --> 00:15:49,640
但阻塞分配的一个常见缺点
--is if the computation time, say, scales 00:15:49,640 --> 00:15:53,480
是如果计算时间，比方说，缩放
--with the index into the data, let's 00:15:53,480 --> 00:15:56,240
有了数据的索引，让我们
--say it's like n squared time or something, 00:15:56,240 --> 00:15:58,920
说它就像 n 平方时间之类的，
--and it gets more and more expensive. 00:15:58,920 --> 00:16:00,440
而且它变得越来越贵。
--If I divide this into even chunks, 00:16:00,440 --> 00:16:02,640
如果我把它分成偶数块，
--it may be that the one way over on the left 00:16:02,640 --> 00:16:05,680
可能是左边的那条路
--has very little computation to do, 00:16:05,680 --> 00:16:07,320
需要做的计算很少，
--and the one way over on the right 00:16:07,320 --> 00:16:08,720
右边的那条路
--has a whole lot of computation to do. 00:16:08,720 --> 00:16:11,000
有很多计算要做。
--So for that reason, interleaving tends 00:16:11,000 --> 00:16:12,960
因此，出于这个原因，交错倾向于
--to be a little less risky if you have contiguous properties 00:16:12,960 --> 00:16:19,320
如果你有连续的财产，风险会小一些
--in terms of how long the computation takes. 00:16:19,320 --> 00:16:22,080
根据计算需要多长时间。
--So that's a potential advantage of blocked. 00:16:22,080 --> 00:16:24,360
所以这是阻塞的潜在优势。
--Any other thoughts? 00:16:24,360 --> 00:16:25,800
还有其他想法吗？
--The block will, each instance will 00:16:25,800 --> 00:16:28,760
块将，每个实例将
--access data that's near each other. 00:16:28,760 --> 00:16:30,240
访问彼此靠近的数据。
--You have better locality, then you 00:16:30,240 --> 00:16:31,920
你有更好的地方，然后你
--will have better cache performance. 00:16:31,920 --> 00:16:33,640
会有更好的缓存性能。
--If you know the computation for each array element, 00:16:33,640 --> 00:16:37,560
如果你知道每个数组元素的计算，
--it's going to be pretty even across the entire array. 00:16:37,560 --> 00:16:41,600
在整个阵列中它会非常均匀。
--Yeah, so another thing about, as you learned from 2.13, 00:16:41,640 --> 00:16:46,840
是的，还有一件事，正如你从 2.13 中学到的，
--spatial locality is good for caches. 00:16:46,840 --> 00:16:49,040
空间局部性有利于缓存。
--So one thing when we look at this picture 00:16:49,040 --> 00:16:51,480
所以当我们看这张照片时有一件事
--is accessing contiguous data, that sounds more cache friendly. 00:16:51,480 --> 00:16:56,080
正在访问连续数据，这听起来对缓存更友好。
--And in fact, for most, in many situations, 00:16:56,080 --> 00:17:00,960
事实上，对于大多数人来说，在许多情况下，
--that would be a valid argument. 00:17:00,960 --> 00:17:02,440
那将是一个有效的论点。
--It turns out in a case of ISPC, that's 00:17:02,440 --> 00:17:06,320
在 ISPC 的情况下，结果是
--not really very compelling because it's just one thread, 00:17:06,320 --> 00:17:09,960
不是很引人注目，因为它只是一个线程，
--and we're going to kind of look at some details about that. 00:17:09,960 --> 00:17:12,440
我们将看看有关的一些细节。
--But in general, if you had separate threads 00:17:12,440 --> 00:17:15,480
但一般来说，如果你有单独的线程
--and they were accessing data in separate caches, 00:17:15,480 --> 00:17:17,800
他们在不同的缓存中访问数据，
--then normally blocked would have a big advantage 00:17:17,800 --> 00:17:20,120
那么通常被阻止会有很大的优势
--from spatial locality. 00:17:20,120 --> 00:17:22,280
从空间局部性。
--Any other thoughts? 00:17:22,280 --> 00:17:23,920
还有其他想法吗？
--So it turns out that for ISPC, there actually 00:17:23,920 --> 00:17:26,480
所以事实证明，对于 ISPC，实际上有
--is a very clear winner between blocked and interleaved. 00:17:26,480 --> 00:17:29,240
是阻塞和交错之间非常明显的赢家。
--It's really not, it's not close. 00:17:29,240 --> 00:17:32,360
真的不是，不是很近。
--And it's not for any of the reasons I've heard so far. 00:17:32,360 --> 00:17:34,920
而且这不是出于我目前所听到的任何原因。
--Oh, yeah? 00:17:34,920 --> 00:17:35,420
哦耶？
--Interleaved, like typically what happens 00:17:36,020 --> 00:17:38,340
交错，就像通常发生的事情一样
--is that instance is 1, 2, 3 executed simultaneously. 00:17:38,340 --> 00:17:41,300
是实例是1、2、3同时执行。
--So if it's interleaved, then you're 00:17:41,300 --> 00:17:43,100
所以如果它是交错的，那么你就是
--actually taking away a bunch of words. 00:17:43,100 --> 00:17:45,980
居然带走了一堆话。
--Yes, that's right. 00:17:45,980 --> 00:17:47,060
恩，那就对了。
--So in fact, and that actually has a big, 00:17:47,060 --> 00:17:51,180
所以事实上，这实际上有很大的，
--that's the root cause of the big advantage for ISPC. 00:17:51,180 --> 00:17:54,780
这是 ISPC 巨大优势的根本原因。
--So if we look at this over time, what happens is, 00:17:54,780 --> 00:17:59,460
所以如果我们随着时间的推移看这个，会发生什么，
--so in the pictures I showed you before, 00:17:59,460 --> 00:18:01,340
所以在我之前给你们看的照片中，
--I was actually showing you what it 00:18:01,340 --> 00:18:03,540
我实际上是在向你展示它是什么
--looks like from the perspective of a particular program 00:18:03,540 --> 00:18:06,300
从特定程序的角度看
--instance. 00:18:06,300 --> 00:18:07,340
实例。
--But if we think about what's happening in time, 00:18:07,340 --> 00:18:09,620
但如果我们考虑及时发生的事情，
--in the interleaved case, the first four iterations, 0 00:18:09,620 --> 00:18:14,180
在交错情况下，前四次迭代，0
--through 3, they are being computed on by a vector, 00:18:14,180 --> 00:18:18,300
通过 3，它们由向量计算，
--by one vector instruction. 00:18:18,300 --> 00:18:20,580
通过一个向量指令。
--And so that's what's happening at any moment in time. 00:18:20,580 --> 00:18:25,580
这就是随时发生的事情。
--So we actually march along like this. 00:18:25,580 --> 00:18:29,060
所以我们实际上是这样前进的。
--OK, that's interleaved. 00:18:29,060 --> 00:18:31,100
好的，那是交错的。
--And if we look at now, what's nice about that 00:18:31,100 --> 00:18:35,140
如果我们现在看，那有什么好处
--is when I want to bring that data into the register, 00:18:35,140 --> 00:18:39,820
是当我想把这些数据带入寄存器时，
--the vector register to operate on it, 00:18:39,820 --> 00:18:42,220
对其进行操作的向量寄存器，
--the data that I want for the vector 00:18:42,220 --> 00:18:44,020
我想要的矢量数据
--happens to be contiguous in memory. 00:18:44,020 --> 00:18:46,940
碰巧在内存中是连续的。
--And there are vector load instructions 00:18:46,940 --> 00:18:49,740
并且有向量加载指令
--that will bring in big chunks of data. 00:18:49,740 --> 00:18:52,420
这将带来大量数据。
--And they work really well as long 00:18:52,420 --> 00:18:53,940
他们工作得很好只要
--as the data you're bringing in is contiguous already. 00:18:53,940 --> 00:18:57,060
因为您引入的数据已经是连续的。
--So with one vector load, essentially the cost 00:18:57,060 --> 00:19:00,260
所以对于一个矢量负载，本质上是成本
--of one load operation, we can bring in all of that data. 00:19:00,300 --> 00:19:03,380
在一次加载操作中，我们可以引入所有这些数据。
--In fact, if the vector is wider than this, 00:19:03,380 --> 00:19:05,180
事实上，如果矢量比这宽，
--if it has 8 or 16 elements, we could bring it all 00:19:05,180 --> 00:19:07,620
如果它有 8 或 16 个元素，我们可以把它全部带上
--in in basically one cycle, assuming it hits in the cache. 00:19:07,620 --> 00:19:12,380
基本上在一个周期内，假设它命中缓存。
--Now, if you compare that with blocked, 00:19:12,380 --> 00:19:14,940
现在，如果你将它与阻塞进行比较，
--this is what happens with blocked. 00:19:14,940 --> 00:19:17,700
这就是阻塞时发生的情况。
--Now, although from the perspective 00:19:17,700 --> 00:19:19,420
现在，虽然从角度
--of a particular instance, things look like they're contiguous, 00:19:19,420 --> 00:19:23,700
在特定情况下，事物看起来是连续的，
--that's not what's happening in time. 00:19:23,700 --> 00:19:25,460
那不是及时发生的事情。
--In time, now we're jumping across different elements. 00:19:25,460 --> 00:19:29,500
随着时间的推移，现在我们正在跨越不同的元素。
--We need to load 0, 4, 8, and 12 all at once. 00:19:29,500 --> 00:19:34,260
我们需要同时加载 0、4、8 和 12。
--Now, OK, what do you think happens 00:19:34,260 --> 00:19:36,620
现在，好吧，你认为会发生什么
--in the hardware for that? 00:19:36,620 --> 00:19:37,780
在硬件上呢？
--So it turns out there is an instruction that 00:19:41,300 --> 00:19:45,860
所以事实证明有一条指令
--will allow you to do this. 00:19:45,860 --> 00:19:47,140
将允许你这样做。
--There's a vector gather instruction 00:19:47,140 --> 00:19:49,420
有一个矢量收集指令
--that lets you load lots of non-contiguous data 00:19:49,420 --> 00:19:52,860
让你加载大量非连续数据
--into one vector with one instruction. 00:19:52,860 --> 00:19:56,780
用一条指令变成一个向量。
--But how long does that take, do you think? 00:19:56,780 --> 00:20:00,100
但你认为这需要多长时间？
--Does it take one cycle? 00:20:00,100 --> 00:20:01,420
需要一个周期吗？
--For those of you who are EEs, or if you've 00:20:04,420 --> 00:20:07,500
对于那些 EE 的人，或者如果你已经
--studied much about hardware, that's 00:20:07,500 --> 00:20:10,300
研究了很多关于硬件的知识，那就是
--not going to be anywhere near as fast as doing the vector load. 00:20:10,300 --> 00:20:13,420
不会像矢量加载那样快。
--Because what the hardware really has to do 00:20:13,420 --> 00:20:15,140
因为硬件真正要做的事情
--is effectively the moral equivalent of 4 or 8 00:20:15,140 --> 00:20:19,060
实际上在道德上等同于 4 或 8
--or however many separate loads. 00:20:19,060 --> 00:20:21,340
或许多单独的负载。
--So it appears to be one instruction 00:20:21,340 --> 00:20:23,420
所以这似乎是一条指令
--from the assembly language programmer's point of view, 00:20:23,420 --> 00:20:25,980
从汇编语言程序员的角度来看，
--but performance-wise, this is a costly thing to do. 00:20:25,980 --> 00:20:29,540
但就性能而言，这是一件代价高昂的事情。
--So for that reason, interleaved is actually 00:20:29,540 --> 00:20:32,420
所以出于这个原因，交错实际上是
--much faster in this case. 00:20:32,420 --> 00:20:34,460
在这种情况下要快得多。
--So that's surprising. 00:20:34,460 --> 00:20:35,500
所以这很令人惊讶。
--That's a case where, because of what we're doing, 00:20:35,500 --> 00:20:38,380
在这种情况下，由于我们正在做的事情，
--because it's targeting SIMD vector instructions, 00:20:38,380 --> 00:20:40,980
因为它针对的是 SIMD 矢量指令，
--that was the clear winner. 00:20:40,980 --> 00:20:43,540
那是明显的赢家。
--OK, now you might look at that and say, 00:20:43,540 --> 00:20:48,100
好的，现在你可能会看着它说，
--it's not fun to have to write all that low-level code 00:20:48,100 --> 00:20:50,700
必须编写所有低级代码并不有趣
--to specify blocked or interleaved. 00:20:50,700 --> 00:20:53,580
指定阻塞或交错。
--And what if I pick one and get it wrong? 00:20:53,580 --> 00:20:56,100
如果我选错了一个怎么办？
--That's a shame. 00:20:56,100 --> 00:20:57,140
太可惜了。
--Wouldn't it be nice if this clever compiler and language 00:20:57,140 --> 00:21:01,060
如果这个聪明的编译器和语言不是很好
--could just figure this out for me? 00:21:01,060 --> 00:21:03,580
能帮我解决这个问题吗？
--So that's the idea of another primitive, 00:21:03,580 --> 00:21:07,620
这就是另一个原始人的想法，
--which is called forEach. 00:21:07,620 --> 00:21:09,500
这叫做 forEach。
--So forEach is essentially, it's like a for loop, 00:21:09,500 --> 00:21:14,820
所以 forEach 本质上就像一个 for 循环，
--but you're handing over control of the assignment of the loop 00:21:14,820 --> 00:21:18,220
但你正在移交循环分配的控制权
--iterations to the system. 00:21:18,220 --> 00:21:20,220
对系统的迭代。
--So what you're telling the system is, 00:21:20,220 --> 00:21:22,340
所以你告诉系统的是，
--you can execute these iterations in parallel. 00:21:22,340 --> 00:21:25,460
您可以并行执行这些迭代。
--And you figure out the order in which you want to do that. 00:21:25,460 --> 00:21:29,620
然后你弄清楚你想要这样做的顺序。
--So since the computations are independent for each value 00:21:29,620 --> 00:21:34,460
因此，由于计算对于每个值都是独立的
--of i in the outer loop, we can do them in any order. 00:21:34,460 --> 00:21:37,980
i 在外循环中，我们可以按任何顺序执行它们。
--And so we'll let the system choose. 00:21:37,980 --> 00:21:40,340
所以我们会让系统选择。
--So from the programmer's point of view, 00:21:40,340 --> 00:21:42,020
所以从程序员的角度来看，
--they're just pointing out the source of parallelism, 00:21:42,020 --> 00:21:44,340
他们只是指出并行性的来源，
--and they're letting the language synthesize the code. 00:21:44,340 --> 00:21:48,460
他们让语言合成代码。
--And in the case of ISPC, what it'll do 00:21:48,460 --> 00:21:50,620
就 ISPC 而言，它会做什么
--is it'll synthesize the interleaved code 00:21:50,660 --> 00:21:53,020
它会合成交错代码吗
--that we saw earlier, the first code 00:21:53,020 --> 00:21:54,620
我们之前看到的，第一个代码
--that we saw in this case, because 00:21:54,620 --> 00:21:56,900
我们在这种情况下看到的，因为
--of the loading of vectors. 00:21:56,900 --> 00:21:58,340
向量的加载。
--So just to recap what we saw so far, 00:22:02,780 --> 00:22:06,020
回顾一下我们到目前为止所看到的，
--so there's an abstraction, which is 00:22:06,020 --> 00:22:08,300
所以有一个抽象，就是
--that it looks like we have almost conventional single 00:22:08,300 --> 00:22:12,100
看起来我们几乎有传统的单身
--program multiple data parallelism, where we say, 00:22:12,100 --> 00:22:15,780
对多数据并行性进行编程，我们说，
--OK, here's a procedure. 00:22:15,780 --> 00:22:18,300
好的，这是一个程序。
--And instances of that will be executed in parallel. 00:22:18,300 --> 00:22:22,300
并且该实例将并行执行。
--But in fact, the implementation of it 00:22:22,300 --> 00:22:24,300
但实际上执行起来
--was SIMD vector instructions, where there only 00:22:24,300 --> 00:22:27,620
是 SIMD 矢量指令，其中只有
--is one thread of control. 00:22:27,620 --> 00:22:29,500
是一个控制线程。
--And the concurrency is coming only 00:22:29,500 --> 00:22:31,340
并且并发性即将到来
--from these vector instructions. 00:22:31,340 --> 00:22:33,580
从这些矢量指令。
--And it's saving us the headache of having 00:22:33,580 --> 00:22:35,740
它让我们免于头痛
--to insert all those macros and think about all 00:22:35,740 --> 00:22:38,900
插入所有这些宏并考虑所有
--those low-level details. 00:22:38,900 --> 00:22:40,020
那些底层细节。
--So before we move on, though, just 00:22:43,660 --> 00:22:46,260
所以在我们继续之前，不过
--to maybe test your understanding of this a little bit, 00:22:46,300 --> 00:22:51,220
或许可以测试一下你对此的理解，
--what happens in the case where we 00:22:51,220 --> 00:22:52,700
在我们的情况下会发生什么
--want to do a reduction in ISPC? 00:22:52,700 --> 00:22:55,620
想减少 ISPC？
--So here, this is a different procedure, 00:22:55,620 --> 00:22:58,660
所以在这里，这是一个不同的过程，
--where what we want to do is just add up 00:22:58,660 --> 00:23:00,300
我们要做的只是加起来
--all the values in an array. 00:23:00,300 --> 00:23:01,980
数组中的所有值。
--So we want to calculate this sum and return that sum. 00:23:01,980 --> 00:23:07,460
所以我们要计算这个总和并返回那个总和。
--OK, now, interesting thing about this is so, well, 00:23:07,460 --> 00:23:15,580
好的，现在，有趣的是，好吧，
--in fact, the sum that we get back, 00:23:15,580 --> 00:23:19,620
事实上，我们得到的总和，
--everyone should agree on the sum, right? 00:23:19,620 --> 00:23:21,660
每个人都应该同意总数，对吧？
--The return value, which is the answer, should be one thing. 00:23:21,660 --> 00:23:25,780
返回值，也就是答案，应该是一回事。
--So maybe we want to stick the type modifier 00:23:25,780 --> 00:23:28,660
所以也许我们想坚持类型修饰符
--uniform in front of the declaration of sum. 00:23:28,660 --> 00:23:31,900
统一在申报金额前。
--It turns out that if you do that and try to compile it, 00:23:31,900 --> 00:23:34,180
事实证明，如果你这样做并尝试编译它，
--ISPC will say this is a compilation error. 00:23:34,180 --> 00:23:36,660
 ISPC 会说这是一个编译错误。
--You can't do that. 00:23:36,660 --> 00:23:38,340
你不能那样做。
--So why is that? 00:23:38,340 --> 00:23:40,020
那是为什么呢？
--Yeah? 00:23:40,020 --> 00:23:40,520
是的？
--So what the, yeah? 00:23:44,820 --> 00:23:46,540
那是什么，是吗？
--You're having multiple, this is just 00:23:46,540 --> 00:23:48,140
你有多个，这只是
--trying to access the same value at once. 00:23:48,140 --> 00:23:49,900
试图一次访问相同的值。
--So it's going to be modified. 00:23:49,900 --> 00:23:51,140
所以要修改。
--You can get a different value at different times. 00:23:51,140 --> 00:23:53,580
你可以在不同的时间获得不同的价值。
--Right. 00:23:53,580 --> 00:23:54,060
正确的。
--They're all adding different values into it. 00:23:54,060 --> 00:23:56,340
他们都在其中添加不同的价值。
--So this, yeah. 00:23:56,340 --> 00:23:58,420
所以这个，是的。
--So the problem is that x sub i, the thing 00:23:58,420 --> 00:24:03,100
所以问题是 x sub i，那个东西
--they're trying to add into it, this is definitely not 00:24:03,100 --> 00:24:05,380
他们试图添加进去，这绝对不是
--uniform for every instance. 00:24:05,380 --> 00:24:07,420
每个实例都是统一的。
--They're all reading different values. 00:24:07,420 --> 00:24:09,620
他们都在阅读不同的价值观。
--So if you're trying to concurrently add 00:24:09,620 --> 00:24:13,140
所以如果你想同时添加
--all these things into it, that would, 00:24:13,140 --> 00:24:15,500
所有这些东西都放进去，那会，
--if you just did something naive here, it would break. 00:24:15,500 --> 00:24:18,300
如果你只是在这里做了一些天真的事情，它就会崩溃。
--So here's code that would work in ISPC, 00:24:18,300 --> 00:24:22,380
所以这是在 ISPC 中工作的代码，
--where you're trying to do essentially the same thing, 00:24:22,380 --> 00:24:24,620
你试图做本质上相同的事情，
--where what you need to do instead 00:24:24,620 --> 00:24:26,540
你需要做什么
--is you're going to calculate partial sums. 00:24:26,540 --> 00:24:29,380
你要计算部分和吗？
--So each instance is going to first have 00:24:29,380 --> 00:24:32,100
所以每个实例都会首先有
--a loop where it calculates its portion of the total sum. 00:24:32,100 --> 00:24:36,780
一个循环，它计算它在总和中的部分。
--And those are not uniform. 00:24:36,780 --> 00:24:38,020
那些并不统一。
--Those are different for each instance. 00:24:38,020 --> 00:24:40,180
这些对于每个实例都是不同的。
--And after we do that, then we will put them together 00:24:40,180 --> 00:24:43,580
在我们这样做之后，我们会把它们放在一起
--into the final answer. 00:24:43,580 --> 00:24:44,620
进入最终答案。
--But we'll use a special ISPC primitive 00:24:44,620 --> 00:24:47,940
但我们将使用特殊的 ISPC 原语
--called reduce add, which allows us 00:24:47,940 --> 00:24:49,980
称为 reduce add，它允许我们
--to take a set of different values 00:24:49,980 --> 00:24:52,900
取一组不同的值
--and turn them into a value that ought 00:24:52,900 --> 00:24:54,820
并将它们转化为应有的价值
--to be uniform across all the threads ultimately. 00:24:54,820 --> 00:24:59,420
最终在所有线程中保持一致。
--OK. 00:24:59,420 --> 00:25:00,220
好的。
--So that would work. 00:25:00,220 --> 00:25:02,460
这样就可以了。
--And in fact, for fun, I'm not going 00:25:02,460 --> 00:25:04,100
事实上，为了好玩，我不会去
--to spend time going through all the details of this. 00:25:04,100 --> 00:25:06,260
花时间了解所有细节。
--But here's an example of what that actually compiles into. 00:25:06,260 --> 00:25:09,900
但这里有一个实际编译成的例子。
--So here, well, first of all, what you can see 00:25:09,900 --> 00:25:12,980
所以在这里，嗯，首先，你能看到什么
--is here are these vector instructions, 00:25:12,980 --> 00:25:15,660
这是这些矢量指令，
--like adds and loads and stores and things like that. 00:25:15,660 --> 00:25:21,460
比如添加、加载、存储等等。
--So up here, what we're seeing is the first part up here. 00:25:21,460 --> 00:25:27,220
所以在这里，我们看到的是这里的第一部分。
--So that's basically this loop. 00:25:27,220 --> 00:25:29,380
所以这基本上就是这个循环。
--And then down here in the bottom, this is the reduction. 00:25:29,380 --> 00:25:35,300
然后在底部，这是减少。
--And notice the reduction is actually not 00:25:35,300 --> 00:25:37,140
并注意减少实际上不是
--using vector instructions, because what it's doing 00:25:37,140 --> 00:25:39,420
使用矢量指令，因为它在做什么
--is it's just adding up all the elements of a vector 00:25:39,420 --> 00:25:42,700
它只是将向量的所有元素相加吗
--using conventional instructions. 00:25:42,700 --> 00:25:45,340
使用常规指令。
--But that gets the right value. 00:25:45,340 --> 00:25:47,540
但这得到了正确的价值。
--OK. 00:25:47,540 --> 00:25:48,020
好的。
--So that's ISPC. 00:25:48,020 --> 00:25:51,580
这就是 ISPC。
--So OK, last thing to say about ISPC 00:25:51,580 --> 00:25:56,500
好的，关于 ISPC 的最后一件事
--is that the size of a gang. 00:25:56,500 --> 00:26:04,580
是一个帮派的规模。
--So the program count variable is set by the system. 00:26:04,580 --> 00:26:08,940
所以程序计数变量是由系统设置的。
--And it's usually the vector width. 00:26:08,940 --> 00:26:11,820
它通常是矢量宽度。
--But many machines have more than one core on them. 00:26:11,820 --> 00:26:15,820
但是很多机器上面都有不止一个核心。
--So if I wanted to run parallel code using ISPC 00:26:15,820 --> 00:26:19,060
所以如果我想使用 ISPC 运行并行代码
--and I have multiple cores, the code I've shown you so far 00:26:19,060 --> 00:26:22,740
我有多个内核，到目前为止我向您展示的代码
--would actually only run on one core. 00:26:22,740 --> 00:26:24,460
实际上只会在一个核心上运行。
--And it wouldn't take advantage of any of those other cores. 00:26:24,460 --> 00:26:27,260
而且它不会利用任何其他核心。
--So ISPC has another piece of their mechanism, 00:26:27,260 --> 00:26:31,540
所以 ISPC 有另一个机制，
--which is you can create a task. 00:26:31,540 --> 00:26:34,340
这是你可以创建一个任务。
--And a task is a thread of control 00:26:34,340 --> 00:26:37,860
一个任务就是一个控制线程
--that can run on different cores. 00:26:37,860 --> 00:26:42,540
可以在不同的内核上运行。
--So it's basically a thread. 00:26:42,540 --> 00:26:43,980
所以它基本上是一个线程。
--It gets turned into a thread. 00:26:43,980 --> 00:26:46,660
它变成了一个线程。
--So that's ISPC. 00:26:46,660 --> 00:26:51,060
这就是 ISPC。
--OK. 00:26:51,060 --> 00:26:51,540
好的。
--So that was part one. 00:26:51,540 --> 00:26:53,020
所以这是第一部分。
--Next, we're going to move on and talk 00:26:53,020 --> 00:26:55,100
接下来我们继续往下说
--about several other important parallel programming 00:26:55,100 --> 00:26:58,420
关于其他几个重要的并行编程
--abstractions. 00:26:58,420 --> 00:26:59,860
抽象。
--So we're going to talk about the abstraction 00:26:59,860 --> 00:27:04,340
所以我们要讨论抽象
--from the programmer's point of view. 00:27:04,340 --> 00:27:05,820
从程序员的角度来看。
--And I'm also going to talk about some examples of machines 00:27:05,820 --> 00:27:09,340
我还将讨论一些机器示例
--that support these abstractions. 00:27:09,340 --> 00:27:12,940
支持这些抽象。
--And the things that are really different 00:27:12,940 --> 00:27:17,100
真正不同的东西
--in parallel processing are that we 00:27:17,100 --> 00:27:22,020
在并行处理中，我们
--have to have the concurrent instances of code communicate 00:27:22,020 --> 00:27:26,380
必须让代码的并发实例进行通信
--and cooperate with each other. 00:27:26,380 --> 00:27:27,780
并相互合作。
--So that's what we're going to focus on 00:27:27,780 --> 00:27:29,360
所以这就是我们要关注的
--when we talk about these abstractions. 00:27:29,360 --> 00:27:31,400
当我们谈论这些抽象时。
--What part of the abstraction do you 00:27:31,400 --> 00:27:33,360
你抽象的哪一部分
--use to talk about how you communicate and cooperate? 00:27:33,360 --> 00:27:37,040
谈谈你们是如何沟通和合作的？
--OK. 00:27:37,040 --> 00:27:38,000
好的。
--So all right. 00:27:38,000 --> 00:27:40,160
所以好吧。
--So how do we implement an abstraction? 00:27:40,160 --> 00:27:43,880
那么我们如何实现抽象呢？
--So abstractions could be implemented 00:27:43,880 --> 00:27:46,480
所以可以实现抽象
--through software or hardware or both. 00:27:46,480 --> 00:27:50,560
通过软件或硬件或两者。
--And in fact, software is not just one thing. 00:27:50,560 --> 00:27:53,440
事实上，软件不仅仅是一回事。
--There are layers to our software stack. 00:27:53,440 --> 00:27:56,120
我们的软件栈有很多层。
--So for example, you're writing in some high-level language. 00:27:56,120 --> 00:28:02,600
因此，例如，您正在使用某种高级语言编写。
--And you have a compiler and runtime and some libraries 00:28:02,600 --> 00:28:06,680
你有一个编译器和运行时以及一些库
--that are taking the source code and turning it 00:28:06,680 --> 00:28:09,080
正在获取源代码并进行转换
--into something to execute. 00:28:09,080 --> 00:28:10,840
变成要执行的东西。
--That's running on top of an operating system, which 00:28:10,840 --> 00:28:13,800
它运行在操作系统之上，
--is software, which is running on top of hardware. 00:28:13,800 --> 00:28:17,400
是运行在硬件之上的软件。
--OK. 00:28:17,400 --> 00:28:17,920
好的。
--So just as some examples of how these things can 00:28:17,920 --> 00:28:21,440
所以就像这些东西如何可以的一些例子
--be done very differently, let's start 00:28:21,440 --> 00:28:23,560
做得非常不同，让我们开始吧
--by looking at P threads. 00:28:23,560 --> 00:28:25,280
通过查看 P 线程。
--So you're familiar with P threads already from 2013, 00:28:25,320 --> 00:28:28,160
所以你从 2013 年就已经熟悉 P 线程了，
--I think. 00:28:28,160 --> 00:28:29,040
我认为。
--So P thread, you can create a new thread. 00:28:29,040 --> 00:28:34,920
所以P线程，可以新建一个线程。
--And so how is that implemented? 00:28:34,920 --> 00:28:37,720
那是如何实施的呢？
--Well, there is a library call into P thread create. 00:28:37,720 --> 00:28:43,240
嗯，有一个库调用 P 线程创建。
--And that's implemented somehow. 00:28:43,240 --> 00:28:45,680
这是以某种方式实施的。
--There's usually some kernel support for that. 00:28:45,680 --> 00:28:48,000
通常有一些内核支持。
--So the kernel needs to know that you've 00:28:48,000 --> 00:28:50,760
所以内核需要知道你已经
--created this if you want it to run on a different core. 00:28:50,760 --> 00:28:53,800
如果您希望它在不同的核心上运行，请创建它。
--So that's something that the operating system knows about. 00:28:53,840 --> 00:28:57,200
所以这是操作系统知道的事情。
--And then the operating system is already 00:28:57,200 --> 00:28:59,520
然后操作系统已经
--managing execution of things on different cores. 00:28:59,520 --> 00:29:02,480
管理事物在不同核心上的执行。
--So it's already talking to the hardware to make that work. 00:29:02,480 --> 00:29:05,800
所以它已经在与硬件对话以使其工作。
--So in the case of P threads, really a lot of it 00:29:05,800 --> 00:29:09,560
所以在 P 线程的情况下，真的很多
--is happening at the library level and the kernel level. 00:29:09,560 --> 00:29:14,280
发生在库级别和内核级别。
--But in the case of ISPC, the compiler, 00:29:14,280 --> 00:29:19,760
但是对于 ISPC，编译器，
--the operating system is actually not involved normally 00:29:19,760 --> 00:29:23,680
操作系统实际上没有正常参与
--because what we do is the compiler simply 00:29:23,720 --> 00:29:25,800
因为我们所做的只是编译器
--generates vector instructions. 00:29:25,800 --> 00:29:27,760
生成向量指令。
--And these are just directly executed. 00:29:27,760 --> 00:29:29,520
而这些只是直接执行。
--And the hardware will simply go ahead and do them in parallel. 00:29:29,520 --> 00:29:33,240
硬件将简单地继续并并行执行它们。
--And we don't have to get any special libraries 00:29:33,240 --> 00:29:35,280
而且我们不需要任何特殊的图书馆
--or the kernel involved to do that, just the compiler. 00:29:35,280 --> 00:29:38,480
或涉及执行此操作的内核，只是编译器。
--So the compiler did all the heavy lifting in that case. 00:29:38,480 --> 00:29:43,720
所以编译器在那种情况下完成了所有繁重的工作。
--So that's something to keep in mind, 00:29:43,720 --> 00:29:45,640
所以要记住这一点，
--which is that these abstractions can be implemented 00:29:45,640 --> 00:29:48,600
也就是可以实现这些抽象
--through different combinations of hardware and software 00:29:48,600 --> 00:29:51,200
通过硬件和软件的不同组合
--and different parts of the stack. 00:29:51,200 --> 00:29:53,560
和堆栈的不同部分。
--OK, so now, actually, I think I'm 00:29:53,560 --> 00:29:58,800
好的，所以现在，实际上，我想我是
--going to take an intermission break now. 00:29:58,800 --> 00:30:00,720
现在要休息一下。
--So I like to stop in the middle for a minute or two. 00:30:00,720 --> 00:30:04,640
所以我喜欢在中间停一两分钟。
--So we're not quite at the halfway point, 00:30:04,640 --> 00:30:06,600
所以我们还没有走到一半，
--but I'm about to launch into a lot of stuff here. 00:30:06,600 --> 00:30:09,400
但我要在这里开始做很多事情。
--So we'll take a two-minute intermission break. 00:30:09,400 --> 00:30:12,320
所以我们将进行两分钟的中场休息。
--So don't leave the room. 00:30:12,320 --> 00:30:13,960
所以不要离开房间。
--But you can stand up and move around and get 00:30:13,960 --> 00:30:16,240
但你可以站起来四处走动
--the blood flowing to your brain again. 00:30:16,240 --> 00:30:17,840
血液再次流向你的大脑。
--And then we'll start up after that. 00:30:17,840 --> 00:30:19,300
然后我们会在那之后开始。
--Yeah, does ISPCs task with your ISP threads now? 00:30:20,300 --> 00:30:26,780
是的，现在 ISPC 是否与您的 ISP 线程一起工作？
--Yeah, probably, yeah. 00:30:26,780 --> 00:30:28,980
是的，可能是的。
--Yeah. 00:30:28,980 --> 00:30:30,540
是的。
--Yeah. 00:30:49,300 --> 00:30:50,860
是的。
--Yeah. 00:31:19,300 --> 00:31:20,860
是的。
--OK, so now we're going to discuss three abstractions 00:31:49,300 --> 00:32:02,420
好的，现在我们要讨论三个抽象
--for parallel programming, shared address space, message 00:32:02,420 --> 00:32:05,740
用于并行编程、共享地址空间、消息
--passing, and data parallel. 00:32:05,740 --> 00:32:07,180
传递和数据并行。
--So I'll walk through all three of these. 00:32:07,180 --> 00:32:10,860
所以我将介绍所有这三个。
--And you'll be using all of these in this class. 00:32:10,860 --> 00:32:13,180
您将在本课程中使用所有这些。
--You'll be using them in the assignments, for example. 00:32:13,180 --> 00:32:17,020
例如，您将在作业中使用它们。
--The first one, you'll use in assignment 3. 00:32:17,020 --> 00:32:19,540
第一个，您将在作业 3 中使用。
--The second one, you use in assignment 4. 00:32:19,540 --> 00:32:21,260
第二个，你在作业 4 中使用。
--And the third one, you use in assignment 2, confusingly. 00:32:21,260 --> 00:32:26,580
第三个，你在作业 2 中使用，令人困惑。
--OK, so shared address space. 00:32:26,580 --> 00:32:28,340
好的，所以共享地址空间。
--So the idea here, the way to think 00:32:28,340 --> 00:32:31,660
所以这里的想法，思考的方式
--about this from the programmer's point of view 00:32:31,660 --> 00:32:35,060
从程序员的角度来看这个
--is that the way that you're now, I'm 00:32:35,060 --> 00:32:36,660
那是你现在的样子吗，我
--going to actually go ahead and use the word threads 00:32:36,660 --> 00:32:38,740
将真正继续并使用线程这个词
--because I'm just used to saying that. 00:32:38,740 --> 00:32:40,700
因为我只是习惯这么说。
--So the way that the threads interact with each other 00:32:40,700 --> 00:32:44,580
所以线程相互交互的方式
--is that the whole machine has a common address space. 00:32:44,620 --> 00:32:50,020
是整个机器有一个共同的地址空间。
--So if threads want to communicate, 00:32:50,020 --> 00:32:53,060
所以如果线程想要通信，
--they can read and write the same memory when they choose to. 00:32:53,060 --> 00:32:57,340
他们可以选择读取和写入相同的内存。
--And they can also choose to have private variables 00:32:57,340 --> 00:33:00,220
他们也可以选择拥有私有变量
--and access just their own data. 00:33:00,220 --> 00:33:01,740
并只访问他们自己的数据。
--But when they want to cooperate and communicate, 00:33:01,740 --> 00:33:04,420
但是当他们想要合作交流的时候，
--they do it by reading and writing the same data. 00:33:04,420 --> 00:33:08,260
他们通过读取和写入相同的数据来做到这一点。
--And this is a little bit like if you 00:33:08,260 --> 00:33:10,980
这有点像如果你
--were trying to work together with friends 00:33:10,980 --> 00:33:13,540
正在尝试与朋友一起工作
--and you were standing in front of a whiteboard, 00:33:13,540 --> 00:33:15,820
而你正站在一块白板前，
--and the way that you communicated 00:33:15,820 --> 00:33:17,220
以及你沟通的方式
--was you wrote things on the whiteboard 00:33:17,220 --> 00:33:18,700
你在白板上写过东西吗
--and then other people could look at those things 00:33:18,700 --> 00:33:20,740
然后其他人可以看那些东西
--on the whiteboard and read them. 00:33:20,740 --> 00:33:22,140
在白板上阅读。
--That's a little bit like what it's like. 00:33:22,140 --> 00:33:25,100
这有点像它的样子。
--Now, a thing about this is this is actually very similar. 00:33:25,100 --> 00:33:29,580
现在，关于这一点的一点是，这实际上非常相似。
--And this is the smallest change. 00:33:29,580 --> 00:33:32,340
这是最小的变化。
--Of all of the abstractions we're going to talk about, 00:33:32,340 --> 00:33:34,780
在我们要讨论的所有抽象中，
--this is most similar to just conventional sequential 00:33:34,780 --> 00:33:39,020
这与传统的顺序最相似
--programming. 00:33:39,020 --> 00:33:41,620
编程。
--Because in the normal case, when we 00:33:41,620 --> 00:33:43,260
因为在正常情况下，当我们
--have different procedures, when different parts of your code 00:33:43,260 --> 00:33:47,620
有不同的程序，当你的代码的不同部分
--are interacting with each other, how do they do that? 00:33:47,620 --> 00:33:49,940
彼此互动，他们是如何做到的？
--Well, they do it by reading and writing 00:33:49,940 --> 00:33:51,540
好吧，他们通过阅读和写作来做到这一点
--data in the address space. 00:33:51,540 --> 00:33:53,180
地址空间中的数据。
--So that should seem very familiar. 00:33:53,180 --> 00:33:57,500
所以这应该看起来很熟悉。
--OK, all right, so the communication part 00:33:57,500 --> 00:34:03,140
好的，好的，那么通信部分
--is really easy in the shared address space case 00:34:03,140 --> 00:34:05,980
在共享地址空间的情况下真的很容易
--because you can always communicate by reading 00:34:05,980 --> 00:34:08,460
因为你总是可以通过阅读来交流
--and writing the same data. 00:34:08,460 --> 00:34:10,260
并写入相同的数据。
--The wrinkle, though, is synchronization. 00:34:10,260 --> 00:34:13,780
然而，问题在于同步。
--So how do you know when the data that you want is there? 00:34:13,780 --> 00:34:19,380
那么你怎么知道你想要的数据何时存在呢？
--So for example, if I just read an address in memory, 00:34:19,380 --> 00:34:22,860
例如，如果我只是读取内存中的一个地址，
--how do I know whether I got the up-to-date copy of the value 00:34:22,860 --> 00:34:26,140
我怎么知道我是否获得了值的最新副本
--or I got an old out-of-date copy of the value? 00:34:26,140 --> 00:34:29,460
或者我得到了价值的旧副本？
--Usually, that's the part that requires some extra work. 00:34:29,460 --> 00:34:33,940
通常，这是需要一些额外工作的部分。
--So for example, so that's one type of synchronization 00:34:33,940 --> 00:34:37,700
例如，这是一种同步
--is knowing whether something is ready to be read. 00:34:37,700 --> 00:34:41,220
知道是否有东西可以被阅读。
--Another type of synchronization is around mutual exclusion. 00:34:41,220 --> 00:34:45,060
另一种类型的同步是围绕互斥的。
--So for example, if we are incrementing a variable, 00:34:45,060 --> 00:34:49,940
例如，如果我们递增一个变量，
--if two concurrent threads simultaneously 00:34:49,940 --> 00:34:52,420
如果两个并发线程同时
--try to increment the same variable, 00:34:52,420 --> 00:34:54,580
尝试增加相同的变量，
--then you can end up with the wrong answer 00:34:54,580 --> 00:34:56,460
那么你可能会得到错误的答案
--because they both read the initial value. 00:34:56,460 --> 00:34:59,540
因为他们都读取了初始值。
--Then in their registers, they increment that, 00:34:59,540 --> 00:35:02,020
然后在他们的寄存器中，他们递增，
--and then they store back an updated value, 00:35:02,020 --> 00:35:04,660
然后他们存储一个更新的值，
--but you just lost one of the increments, potentially. 00:35:04,660 --> 00:35:07,820
但是您可能只是失去了其中一个增量。
--So if you've taken 4.10, or if you take 4.10, 00:35:07,820 --> 00:35:11,980
所以如果你已经上了 4.10，或者如果你上了 4.10，
--you'll spend a lot of time thinking about that problem 00:35:11,980 --> 00:35:14,180
你会花很多时间思考这个问题
--because that shows up a lot in kernels. 00:35:14,180 --> 00:35:17,700
因为这在内核中出现了很多。
--OK, so the idea is you just communicate 00:35:17,700 --> 00:35:22,900
好的，所以我的想法是你只是沟通
--by reading and writing shared variables. 00:35:22,900 --> 00:35:26,380
通过读写共享变量。
--And the extra work that you do is 00:35:26,380 --> 00:35:29,300
你所做的额外工作是
--adding things like locks and other types of synchronization. 00:35:29,300 --> 00:35:32,420
添加诸如锁和其他类型的同步之类的东西。
--So in a future lecture, soon, we'll 00:35:32,420 --> 00:35:35,340
所以在以后的讲座中，很快，我们将
--look at real examples of code written in this style. 00:35:35,340 --> 00:35:38,420
查看以这种风格编写的代码的真实示例。
--And what you'll see is a lot of the extra code that shows up 00:35:38,420 --> 00:35:42,140
你会看到很多额外的代码
--is all due to the synchronization primitives. 00:35:42,140 --> 00:35:44,660
都是由于同步原语。
--Now, I said that the idea is that we 00:35:48,940 --> 00:35:52,740
现在，我说我们的想法是
--have a common address space. 00:35:52,740 --> 00:35:55,900
有一个共同的地址空间。
--So how do you think this might be implemented 00:35:55,900 --> 00:35:58,460
那么你认为这可能如何实施
--in the hardware? 00:35:58,460 --> 00:35:59,620
在硬件？
--So one way to do it is to physically share 00:35:59,620 --> 00:36:04,140
因此，一种方法是实际分享
--the same memory. 00:36:04,140 --> 00:36:06,060
同样的记忆。
--So in fact, in the early days of these kinds of machines, 00:36:06,060 --> 00:36:09,180
所以事实上，在这些机器的早期，
--this is how everybody thought of the problem, which 00:36:09,180 --> 00:36:11,220
大家都是这样想问题的，
--is we have memory. 00:36:11,220 --> 00:36:14,380
是我们有记忆。
--So memory is sitting here. 00:36:14,380 --> 00:36:16,300
所以记忆就在这里。
--And we have something like a bus or some other kind 00:36:16,300 --> 00:36:19,180
我们有公共汽车之类的东西
--of interconnect. 00:36:19,180 --> 00:36:20,380
互连。
--And then we have more than one processor plugged 00:36:20,380 --> 00:36:22,540
然后我们插入了不止一个处理器
--into this bus, or whatever it is. 00:36:22,540 --> 00:36:25,380
进入这辆公共汽车，或者不管它是什么。
--And then they can all go and access memory. 00:36:25,380 --> 00:36:28,620
然后他们都可以去访问内存。
--Well, for what it's worth also, this is also 00:36:33,260 --> 00:36:35,140
好吧，就它的价值而言，这也是
--called sometimes a dance hall architecture. 00:36:35,140 --> 00:36:38,380
有时称为舞厅建筑。
--You may wonder, what does it have to do with dancing? 00:36:38,380 --> 00:36:41,020
你可能想知道，这和跳舞有什么关系？
--And the inspiration was this is like a middle school dance 00:36:41,020 --> 00:36:46,500
灵感是这就像中学舞会
--where everybody's lined up on the edge of the room 00:36:46,500 --> 00:36:49,420
每个人都排在房间的边缘
--and nobody's in the middle. 00:36:49,420 --> 00:36:51,180
中间没有人。
--So all the processors are on one side, 00:36:51,180 --> 00:36:53,220
所以所有的处理器都在一侧，
--all the memory is on the other side. 00:36:53,220 --> 00:36:55,020
所有的记忆都在另一边。
--That's where that term comes from. 00:36:55,020 --> 00:36:56,820
这就是该术语的来源。
--But the thing that it's actually also called 00:36:56,820 --> 00:36:58,860
但它实际上也被称为
--is symmetric multiprocessing in the sense 00:36:58,860 --> 00:37:01,860
在某种意义上是对称多处理
--that each processor is equally far away from memory. 00:37:01,860 --> 00:37:05,380
每个处理器离内存的距离相等。
--Memory is not closer to any processor 00:37:05,380 --> 00:37:07,380
内存不靠近任何处理器
--than any other processor. 00:37:07,380 --> 00:37:09,300
比任何其他处理器。
--Now, that may sound like a good thing. 00:37:09,300 --> 00:37:11,660
现在，这听起来像是一件好事。
--But I'm going to come back to that in a minute. 00:37:11,660 --> 00:37:13,980
但我会在一分钟内回到那个。
--So yeah, it's equally bad for everybody 00:37:13,980 --> 00:37:17,940
所以是的，这对每个人都同样糟糕
--is one way to think of it. 00:37:17,940 --> 00:37:19,060
是一种思考方式。
--OK, so now an interesting part of the hardware, 00:37:19,060 --> 00:37:22,580
好的，现在是硬件的一个有趣部分，
--if you want to design something this way, where 00:37:22,580 --> 00:37:24,860
如果你想以这种方式设计一些东西，在哪里
--everything is the same distance from memory, 00:37:24,860 --> 00:37:27,260
一切都与记忆有相同的距离，
--is, well, how do you make the interconnect that 00:37:27,260 --> 00:37:30,740
是，嗯，你如何使互连
--connects processors to memory, how 00:37:30,740 --> 00:37:32,340
将处理器连接到内存，如何
--does that continue to be fast as we add more and more 00:37:32,340 --> 00:37:35,460
随着我们添加越来越多，它会继续快速吗
--processors and more and more memory modules? 00:37:35,460 --> 00:37:38,580
处理器和越来越多的内存模块？
--So a really inexpensive kind of interconnect is just a bus. 00:37:38,580 --> 00:37:42,740
因此，一种真正便宜的互连就是总线。
--But only one thing can be on the bus at a time. 00:37:42,740 --> 00:37:45,300
但是一次只能有一件事在公共汽车上。
--So that obviously doesn't have scalable bandwidth. 00:37:45,300 --> 00:37:48,580
所以这显然没有可扩展的带宽。
--So later, we'll have a whole lecture on how 00:37:48,580 --> 00:37:50,300
所以稍后，我们将有一个完整的讲座
--you build scalable interconnects. 00:37:50,300 --> 00:37:52,300
您构建可扩展的互连。
--I'm not going to really get into that now. 00:37:52,300 --> 00:37:54,500
我现在不打算真正进入那个。
--There are fancier things that you can do. 00:37:54,660 --> 00:37:56,820
您可以做一些更有趣的事情。
--But they start to get more and more expensive. 00:37:56,820 --> 00:38:00,660
但它们开始变得越来越昂贵。
--OK, so if we look at real hardware, 00:38:00,660 --> 00:38:04,140
好的，所以如果我们看看真正的硬件，
--so where do we see this approach to building a shared address 00:38:04,140 --> 00:38:08,100
那么我们在哪里可以看到这种构建共享地址的方法
--space? 00:38:08,100 --> 00:38:09,140
空间？
--Well, first of all, on a modern processor, 00:38:09,140 --> 00:38:14,540
好吧，首先，在现代处理器上，
--you have, say, four cores. 00:38:14,540 --> 00:38:16,180
你有，比如说，四个核心。
--Let me pick a different color here. 00:38:16,180 --> 00:38:17,780
让我在这里选择不同的颜色。
--So we've got, say, four cores. 00:38:17,780 --> 00:38:20,220
所以我们有四个核心。
--And they all physically share the same cache. 00:38:20,220 --> 00:38:24,180
它们都在物理上共享相同的缓存。
--In that case, at least to get to that cache, 00:38:25,180 --> 00:38:28,260
在那种情况下，至少要到达那个缓存，
--that is shared by all the different cores equally. 00:38:28,260 --> 00:38:32,100
由所有不同的核心平等共享。
--So that's one way that you can design things like this. 00:38:32,100 --> 00:38:37,340
所以这是你可以设计这样的东西的一种方式。
--And AMD has other processors that are a bit like this. 00:38:37,340 --> 00:38:41,300
 AMD 还有其他类似的处理器。
--Now, this is a different processor. 00:38:41,300 --> 00:38:43,460
现在，这是一个不同的处理器。
--This is the Sun Niagara 2. 00:38:43,460 --> 00:38:45,020
这是 Sun Niagara 2。
--This is designed to support lots and lots 00:38:45,020 --> 00:38:48,580
这是为了支持很多很多
--of latency-tolerant tasks. 00:38:48,580 --> 00:38:51,380
容忍延迟的任务。
--So they had far more processors here. 00:38:51,380 --> 00:38:54,100
所以他们在这里有更多的处理器。
--They have eight processors. 00:38:54,100 --> 00:38:56,580
他们有八个处理器。
--But in order to connect eight things to lots of other things, 00:38:56,580 --> 00:38:59,340
但是为了将八个事物与许多其他事物联系起来，
--they had to have a fancier interconnect. 00:38:59,340 --> 00:39:01,820
他们必须有一个更好的互连。
--And what you can notice on the die 00:39:01,820 --> 00:39:03,620
你可以在骰子上注意到什么
--is that interconnect is starting to get non-trivially large. 00:39:03,620 --> 00:39:06,740
是互连开始变得非常大。
--It's almost as large as one of the processors. 00:39:06,740 --> 00:39:09,860
它几乎和其中一个处理器一样大。
--OK, so simply trying to build, so building a large machine 00:39:09,860 --> 00:39:14,820
好的，所以简单地尝试构建，构建一台大型机器
--with, say, about hundreds or thousands of processors in it 00:39:14,820 --> 00:39:17,700
比如说，里面有成百上千个处理器
--and having them all be equally far away from memory 00:39:17,700 --> 00:39:21,300
并让它们都离记忆同样远
--turns out to be really hard. 00:39:21,300 --> 00:39:23,540
结果真的很难。
--So the way to get around that problem 00:39:23,540 --> 00:39:28,620
所以解决这个问题的方法
--is to give up on the idea of everybody being equally 00:39:28,620 --> 00:39:32,060
就是放弃人人平等的想法
--close to all of the memory. 00:39:32,060 --> 00:39:33,340
接近所有的记忆。
--And instead, everybody gets a nearby piece 00:39:33,340 --> 00:39:37,820
相反，每个人都会得到附近的一块
--of the overall physical memory. 00:39:37,820 --> 00:39:40,820
的整体物理内存。
--But they can still access all of the other pieces. 00:39:40,820 --> 00:39:43,420
但他们仍然可以访问所有其他部分。
--It just takes longer to get there. 00:39:43,420 --> 00:39:45,740
到达那里需要更长的时间。
--So this is called non-uniform memory access, or NUMA. 00:39:45,740 --> 00:39:52,360
所以这被称为非统一内存访问，或 NUMA。
--And so the idea is that the memory, everybody 00:39:52,360 --> 00:39:57,160
所以这个想法是记忆，每个人
--can still access all the memory, but there's 00:39:57,160 --> 00:40:01,280
仍然可以访问所有内存，但是有
--a piece of the memory that's near each processor. 00:40:01,280 --> 00:40:04,240
每个处理器附近的一块内存。
--So this is good, because now there 00:40:04,240 --> 00:40:08,840
所以这很好，因为现在有
--are things like my stack and my code 00:40:08,840 --> 00:40:12,040
是我的堆栈和代码之类的东西
--that should always be private to me. 00:40:12,040 --> 00:40:14,280
那对我来说应该永远是私人的。
--So I will just keep those in my own local memory. 00:40:14,280 --> 00:40:16,960
所以我只会将它们保存在我自己的本地内存中。
--I don't need to go far away to get those. 00:40:16,960 --> 00:40:20,160
我不需要到很远的地方去拿那些。
--Also, as you'll see later, the way 00:40:20,160 --> 00:40:22,520
另外，正如您稍后将看到的那样，
--to get a parallel program to run really fast 00:40:22,520 --> 00:40:24,440
让并行程序运行得非常快
--is you divide up the data. 00:40:24,440 --> 00:40:25,880
是你划分数据。
--And hopefully, you're mostly working on data 00:40:25,880 --> 00:40:28,440
希望您主要处理数据
--that other processors aren't working on. 00:40:28,440 --> 00:40:30,720
其他处理器不工作。
--So we can put that data in our local memory. 00:40:30,720 --> 00:40:33,640
所以我们可以把这些数据放在我们的本地内存中。
--I can still access the other data. 00:40:33,640 --> 00:40:35,400
我仍然可以访问其他数据。
--But if I'm spending 95% of my time going 00:40:35,400 --> 00:40:38,560
但如果我把 95% 的时间花在
--to just my local memory, then that's good for two reasons. 00:40:38,560 --> 00:40:41,880
只是我的本地记忆，那么这有两个原因。
--First, the latency is nice and low, 00:40:41,880 --> 00:40:44,520
首先，延迟很好而且很低，
--because I can get there quickly. 00:40:44,520 --> 00:40:46,400
因为我可以很快到达那里。
--And it's also good from a bandwidth point of view, 00:40:46,400 --> 00:40:48,440
从带宽的角度来看，它也很好，
--because that traffic isn't going out 00:40:48,440 --> 00:40:50,640
因为流量不会消失
--over the bigger interconnect and slowing down 00:40:50,640 --> 00:40:52,920
在更大的互连和减速
--all those other accesses. 00:40:52,920 --> 00:40:55,080
所有这些其他访问。
--So this is a way to build large-scale shared address 00:40:55,080 --> 00:40:59,320
所以这是一种建立大规模共享地址的方法
--space machines. 00:40:59,320 --> 00:41:00,120
太空机器。
--It does introduce a new complication, though, 00:41:02,640 --> 00:41:04,960
不过，它确实引入了一个新的并发症，
--for the programmer, potentially, which is now memory 00:41:04,960 --> 00:41:08,000
对于程序员来说，潜在地，现在是内存
--might be nearby and faster or far away and slower. 00:41:08,000 --> 00:41:11,920
可能在附近更快，也可能在远处更慢。
--So the programmers may have to think about that now. 00:41:11,920 --> 00:41:15,600
所以程序员现在可能不得不考虑一下。
--So in terms of examples of this, 00:41:15,600 --> 00:41:19,040
因此，就此示例而言，
--if you just have a machine, like even a laptop or a desktop, 00:41:19,040 --> 00:41:22,200
如果你只有一台机器，比如笔记本电脑或台式机，
--that has two sockets in it, then today, you 00:41:22,200 --> 00:41:26,160
里面有两个插座，那么今天，你
--have a non-uniform memory access machine, 00:41:26,160 --> 00:41:29,440
有一个非统一内存访问机器，
--because the memory is actually shared across these two 00:41:29,440 --> 00:41:33,160
因为内存实际上是在这两个之间共享的
--sockets. 00:41:33,160 --> 00:41:33,800
插座。
--So if this core over here wants to get to the memory over here, 00:41:33,800 --> 00:41:37,200
所以如果这里的这个核心想要访问这里的内存，
--it's going to take a little bit longer to get there. 00:41:37,200 --> 00:41:39,440
到达那里需要更长的时间。
--And then if you want to build a really big machine that 00:41:42,840 --> 00:41:45,120
然后如果你想建造一台真正的大机器
--has a shared address space, here's 00:41:45,120 --> 00:41:47,600
有一个共享的地址空间，这里是
--one example of this, the SGI Altix, then you can do that. 00:41:47,600 --> 00:41:52,880
一个这样的例子，SGI Altix，那么你就可以做到这一点。
--It's just going to take longer to get to some of the memory 00:41:52,880 --> 00:41:55,600
只是需要更长的时间才能获得一些记忆
--than to other parts of the memory. 00:41:55,600 --> 00:41:57,080
比内存的其他部分。
--But the abstraction still works, and you can still 00:41:57,080 --> 00:41:59,840
但是抽象仍然有效，你仍然可以
--get good performance this way. 00:41:59,840 --> 00:42:03,480
通过这种方式获得良好的性能。
--So then that's the first model that I 00:42:03,480 --> 00:42:06,240
那么这就是我的第一个模型
--want to talk about, which is the shared address space machine. 00:42:06,240 --> 00:42:09,520
要说的，也就是共享地址空间的机器。
--So it's a simple idea from a programmer's point of view, 00:42:09,520 --> 00:42:12,600
所以从程序员的角度来看，这是一个简单的想法，
--which is we just all share the same address space. 00:42:12,600 --> 00:42:15,960
这就是我们都共享相同的地址空间。
--Now, OK, it turns out that from a programmer's point of view, 00:42:15,960 --> 00:42:20,480
现在，好吧，事实证明，从程序员的角度来看，
--this sounds great. 00:42:20,480 --> 00:42:22,040
这听起来不错。
--From a hardware implementation point of view, 00:42:22,040 --> 00:42:24,080
从硬件实现的角度来看，
--there are some challenges. 00:42:24,080 --> 00:42:26,080
有一些挑战。
--It's not so much about the memory. 00:42:26,080 --> 00:42:27,680
这与记忆无关。
--It's about the caches. 00:42:27,680 --> 00:42:29,600
这是关于缓存的。
--So once we start caching data and we're all 00:42:29,600 --> 00:42:32,680
所以一旦我们开始缓存数据，我们就全部
--sharing the data, then we have a coherence problem 00:42:32,680 --> 00:42:36,760
共享数据，那么我们就会遇到连贯性问题
--where different copies may get out of sync with respect 00:42:36,760 --> 00:42:40,080
不同的副本可能会不同步
--to each other. 00:42:40,080 --> 00:42:41,280
对彼此。
--So we'll actually have a couple of lectures 00:42:41,280 --> 00:42:43,960
所以我们实际上会有几个讲座
--on the topic of how the memory system works under the covers, 00:42:43,960 --> 00:42:48,200
关于内存系统如何在幕后工作的话题，
--and there are interesting details about that. 00:42:48,200 --> 00:42:50,760
并且有一些有趣的细节。
--So we'll get to that later on in the class. 00:42:50,760 --> 00:42:53,960
所以我们稍后会在课堂上讨论这个问题。
--OK, so in part because there's some extra cost involved 00:42:53,960 --> 00:42:59,640
好的，部分原因是涉及一些额外费用
--with implementing cache coherence, 00:42:59,640 --> 00:43:02,320
通过实现缓存一致性，
--there's also been this long tradition 00:43:02,320 --> 00:43:03,840
也有这么悠久的传统
--of building parallel machines that 00:43:03,840 --> 00:43:06,300
构建并行机器的
--don't depend on any special hardware support. 00:43:06,300 --> 00:43:09,280
不依赖于任何特殊的硬件支持。
--So this next abstraction I'm going to talk about 00:43:09,280 --> 00:43:11,920
所以我要谈论的下一个抽象
--is message passing. 00:43:11,920 --> 00:43:14,160
是消息传递。
--And the idea here is that each thread has only private data. 00:43:14,160 --> 00:43:22,560
这里的想法是每个线程只有私有数据。
--There is no shared address space. 00:43:22,560 --> 00:43:25,280
没有共享地址空间。
--The addresses that you can access 00:43:25,280 --> 00:43:27,400
您可以访问的地址
--are always private to you. 00:43:27,400 --> 00:43:29,800
始终是您的私人信息。
--And if you want to communicate with another thread, 00:43:29,800 --> 00:43:32,640
如果你想与另一个线程通信，
--the way that you do it is you put together a message 00:43:32,640 --> 00:43:36,400
你这样做的方式是你把一条信息放在一起
--and you send it through the network to that other thread, 00:43:36,400 --> 00:43:39,000
然后你通过网络将它发送到另一个线程，
--and it receives the message, and then it interprets it 00:43:39,000 --> 00:43:41,360
它接收消息，然后解释它
--and decides what to do with that. 00:43:41,360 --> 00:43:43,680
并决定如何处理。
--So for example, if I've got some, 00:43:43,680 --> 00:43:46,520
例如，如果我有一些，
--and usually the things you send and receive are contiguous, 00:43:46,520 --> 00:43:49,920
通常你发送和接收的东西是连续的，
--or at least it works well that way. 00:43:49,920 --> 00:43:51,360
或者至少它以这种方式运作良好。
--So maybe here's some variable, and I 00:43:51,360 --> 00:43:53,520
所以也许这里有一些变量，而我
--want to send it over to this other thread. 00:43:53,520 --> 00:43:55,880
想将它发送到另一个线程。
--So I will say, I'm going to send it. 00:43:55,880 --> 00:43:58,440
所以我会说，我要发送它。
--Here's its starting address. 00:43:58,440 --> 00:44:00,520
这是它的起始地址。
--I'm sending it to thread two, and maybe you 00:44:00,520 --> 00:44:03,800
我将它发送到线程二，也许你
--add a tag to it so that it can interpret 00:44:03,800 --> 00:44:05,800
给它添加一个标签，以便它可以解释
--what kind of message it is. 00:44:05,800 --> 00:44:07,520
这是什么信息。
--And then on this thread, it's going to execute explicitly 00:44:07,520 --> 00:44:09,920
然后在这个线程上，它将显式执行
--receive. 00:44:09,920 --> 00:44:10,680
收到。
--It'll say, here's where it should go. 00:44:10,680 --> 00:44:12,800
它会说，这是它应该去的地方。
--You might specify who you're receiving it from, 00:44:12,800 --> 00:44:15,120
你可以指定你从谁那里收到它，
--or that might just be left as a wild card. 00:44:15,120 --> 00:44:18,760
或者这可能只是作为一个通配符。
--And maybe you have a special tag that you only 00:44:18,760 --> 00:44:21,320
也许你有一个特殊的标签，你只
--want to receive messages with that specific tag. 00:44:21,320 --> 00:44:24,400
想要接收带有该特定标签的消息。
--OK, so this is another approach. 00:44:24,400 --> 00:44:27,760
好的，所以这是另一种方法。
--A big advantage of this is that it 00:44:27,760 --> 00:44:29,880
这样做的一大优点是它
--doesn't require any special hardware 00:44:29,880 --> 00:44:33,040
不需要任何特殊硬件
--at all other than a network. 00:44:33,040 --> 00:44:35,680
除了网络。
--If you can get onto a network and send information 00:44:35,680 --> 00:44:39,120
如果你能进入网络并发送信息
--between computers, then you can write code that 00:44:39,120 --> 00:44:42,160
在计算机之间，那么你可以编写代码
--will work with message passing. 00:44:42,160 --> 00:44:44,720
将与消息传递一起工作。
--Now, most people, well, OK, first of all, 00:44:44,720 --> 00:44:47,960
现在，大多数人，好吧，首先，
--in assignments three and four, you 00:44:47,960 --> 00:44:49,920
在作业三和四中，你
--will get to contrast these two programming models, 00:44:49,920 --> 00:44:53,160
将对比这两种编程模型，
--because you're going to write a particular program 00:44:53,160 --> 00:44:55,360
因为你要写一个特定的程序
--in an assignment three using the shared address space model. 00:44:55,360 --> 00:44:58,240
在作业三中使用共享地址空间模型。
--And then you're going to write the same program 00:44:58,240 --> 00:45:00,160
然后你要写同样的程序
--for assignment four in message passing. 00:45:00,160 --> 00:45:02,720
消息传递中的作业四。
--And you can conclude for yourself 00:45:02,720 --> 00:45:04,360
你可以自己总结
--which of these you prefer, or maybe you 00:45:04,360 --> 00:45:06,040
你更喜欢哪一个，或者你可能
--like them both equally well. 00:45:06,040 --> 00:45:07,720
同样喜欢他们两个。
--Many people, I'd say the vast majority of people, 00:45:07,720 --> 00:45:10,320
很多人，我会说绝大多数人，
--prefer the shared address space model, 00:45:10,320 --> 00:45:13,760
更喜欢共享地址空间模型，
--because this one is a little more rigid in terms 00:45:13,760 --> 00:45:17,680
因为这个在术语上有点严格
--of how communication works. 00:45:17,680 --> 00:45:20,440
沟通是如何运作的。
--And we will go through examples of this in the next week or two. 00:45:20,440 --> 00:45:24,200
我们将在接下来的一两周内讨论这方面的例子。
--You'll see code written in this style. 00:45:24,200 --> 00:45:26,920
您会看到以这种风格编写的代码。
--But the big selling point of this 00:45:26,920 --> 00:45:28,760
但是这个的最大卖点
--is that it's really easy to build 00:45:28,760 --> 00:45:30,280
是真的很容易建造
--the hardware for these machines. 00:45:30,280 --> 00:45:32,080
这些机器的硬件。
--If you want to have an enormously large machine, 00:45:32,080 --> 00:45:36,840
如果你想拥有一台非常大的机器，
--then it's easy to do that. 00:45:36,840 --> 00:45:38,880
那么很容易做到这一点。
--All you need is a fast interconnect. 00:45:38,880 --> 00:45:41,080
您所需要的只是一个快速互连。
--And you don't need any other special hardware 00:45:41,080 --> 00:45:43,720
而且您不需要任何其他特殊硬件
--to worry about coherence or anything like that. 00:45:43,720 --> 00:45:45,920
担心连贯性或类似的事情。
--You can just plug it together and start 00:45:45,920 --> 00:45:48,000
你可以把它插在一起然后开始
--running message passing code. 00:45:48,000 --> 00:45:50,800
运行消息传递代码。
--OK, so there have been a lot of examples of this. 00:45:50,800 --> 00:45:52,800
好的，所以有很多这样的例子。
--So for example, IBM, well, first of all, a while ago, 00:45:52,800 --> 00:45:58,400
例如，IBM，嗯，首先，不久前，
--they had a machine called Deep Blue that 00:45:58,400 --> 00:46:00,760
他们有一台叫深蓝的机器
--was the first computer to beat the best 00:46:00,760 --> 00:46:02,840
是第一台击败最好的计算机
--human in the world at chess. 00:46:02,840 --> 00:46:04,400
国际象棋中的人类。
--And it had this kind of message passing architecture. 00:46:04,400 --> 00:46:07,440
它具有这种消息传递架构。
--Then they had something called Blue Gene. 00:46:07,440 --> 00:46:09,480
然后他们有一种叫做蓝色基因的东西。
--And you can also just take just any kind of machine 00:46:09,480 --> 00:46:15,800
你也可以拿任何一种机器
--and just stick them together. 00:46:15,800 --> 00:46:17,000
把它们粘在一起。
--So in your usual data warehouse place 00:46:17,000 --> 00:46:20,000
所以在您通常的数据仓库位置
--where you've got lots and lots of racks of servers, 00:46:20,000 --> 00:46:22,840
你有很多服务器机架，
--they could all be working together with this model. 00:46:22,840 --> 00:46:26,200
他们都可以使用这个模型一起工作。
--So for example, even in this class, 00:46:26,200 --> 00:46:28,280
因此，例如，即使在这堂课中，
--we'll be using a cluster of machines 00:46:28,280 --> 00:46:30,160
我们将使用一组机器
--that we call late days. 00:46:30,160 --> 00:46:32,160
我们称之为迟到的日子。
--And well, there are details about all the nodes. 00:46:32,160 --> 00:46:36,480
而且，还有关于所有节点的详细信息。
--But you can write message passing code on top of them. 00:46:36,480 --> 00:46:42,840
但是您可以在它们之上编写消息传递代码。
--But the communication performance 00:46:42,840 --> 00:46:46,280
但通讯性能
--is not so great because they're communicating 00:46:46,280 --> 00:46:48,120
不是很好，因为他们在交流
--through ethernet, which is not especially fast. 00:46:48,120 --> 00:46:51,080
通过以太网，这不是特别快。
--So the good news is it's easy to plug machines together 00:46:51,080 --> 00:46:54,080
所以好消息是很容易将机器连接在一起
--and write code. 00:46:54,080 --> 00:46:55,120
并编写代码。
--But the bad news is there's a decent chance 00:46:55,120 --> 00:46:57,280
但坏消息是有一个不错的机会
--that the interconnect is going to be a bottleneck for you. 00:46:57,280 --> 00:47:01,560
互连将成为您的瓶颈。
--So for that reason, the people who build high performance 00:47:01,560 --> 00:47:04,280
因此，出于这个原因，打造高绩效的人
--message passing machines build really 00:47:04,280 --> 00:47:06,680
消息传递机器真正构建
--exotic and fast interconnects. 00:47:06,680 --> 00:47:10,200
异国情调和快速互连。
--So we've talked about both shared address 00:47:10,200 --> 00:47:12,560
所以我们已经讨论了共享地址
--space and message passing. 00:47:12,560 --> 00:47:14,440
空间和消息传递。
--And I said it's important not to confuse abstraction 00:47:14,440 --> 00:47:18,080
我说重要的是不要混淆抽象
--and implementation. 00:47:18,080 --> 00:47:19,760
和实施。
--And I was talking about hardware for shared address spaces 00:47:19,760 --> 00:47:22,840
我在谈论共享地址空间的硬件
--and hardware for message passing. 00:47:22,840 --> 00:47:24,800
和消息传递的硬件。
--But it turns out that you can actually 00:47:24,800 --> 00:47:26,440
但事实证明你实际上可以
--implement either of those models on either type of hardware. 00:47:26,480 --> 00:47:30,040
在任何一种硬件上实现这些模型中的任何一个。
--They're not tied rigidly to one type of hardware. 00:47:30,040 --> 00:47:33,920
它们并不严格依赖于一种类型的硬件。
--So for example, let's say you like to do message passing. 00:47:33,920 --> 00:47:38,040
因此，例如，假设您喜欢进行消息传递。
--Or maybe your evil instructor is making 00:47:38,040 --> 00:47:40,920
或者也许你邪恶的导师正在
--you do message passing even if you don't want to. 00:47:40,920 --> 00:47:44,160
即使您不想，您也会进行消息传递。
--Can you run that on a machine that 00:47:44,160 --> 00:47:46,520
你能在一台机器上运行它吗
--has a shared address space? 00:47:46,520 --> 00:47:48,520
有共享地址空间吗？
--Well, yes. 00:47:48,520 --> 00:47:49,040
嗯，是。
--In fact, there are really fast implementations 00:47:49,040 --> 00:47:51,940
其实真的有快速的实现
--of message passing, which is if we're 00:47:51,940 --> 00:47:54,520
消息传递，如果我们是
--built based on shared address spaces, 00:47:54,520 --> 00:47:56,560
基于共享地址空间构建，
--because to send a message with a shared address space, 00:47:56,560 --> 00:47:59,400
因为要发送具有共享地址空间的消息，
--all you have to do is pass a pointer that points to it 00:47:59,400 --> 00:48:02,440
你所要做的就是传递一个指向它的指针
--in memory, for example. 00:48:02,440 --> 00:48:03,680
例如，在内存中。
--You don't actually have to copy it through the network 00:48:03,680 --> 00:48:06,200
您实际上不必通过网络复制它
--or anything like that. 00:48:06,200 --> 00:48:07,480
或类似的东西。
--So there are, in fact, really fast implementations 00:48:07,480 --> 00:48:09,880
所以实际上有非常快的实现
--of message passing built on shared address space hardware. 00:48:09,880 --> 00:48:14,920
建立在共享地址空间硬件上的消息传递。
--You can go the other direction, but that's not as nice. 00:48:14,920 --> 00:48:19,800
你可以去另一个方向，但那不是很好。
--So I can write shared address space code 00:48:19,800 --> 00:48:22,480
所以我可以写共享地址空间的代码
--and run it on a machine that has no hardware support 00:48:22,520 --> 00:48:24,840
在没有硬件支持的机器上运行
--for a shared address space. 00:48:24,840 --> 00:48:26,800
用于共享地址空间。
--You can use tricks in the operating system 00:48:26,800 --> 00:48:28,720
您可以在操作系统中使用技巧
--where you write protect pages and use page fault handlers 00:48:28,720 --> 00:48:33,120
您在哪里编写保护页面并使用页面错误处理程序
--to move data back and forth and emulate what the hardware does 00:48:33,120 --> 00:48:37,600
来回移动数据并模拟硬件的功能
--in the caches. 00:48:37,600 --> 00:48:39,440
在缓存中。
--And it will functionally work, but it's usually quite slow. 00:48:39,440 --> 00:48:44,280
它会在功能上起作用，但通常很慢。
--So it's possible, but that's not usually very fast. 00:48:44,280 --> 00:48:47,440
所以这是可能的，但这通常不是很快。
--OK. 00:48:47,960 --> 00:48:49,960
好的。
--OK. 00:48:49,960 --> 00:48:51,120
好的。
--Now, the last major model I want to talk about 00:48:51,120 --> 00:48:54,440
现在，我要说的最后一个主要模型
--is data parallel, and this is the one 00:48:54,440 --> 00:48:56,280
是数据并行的，这是一个
--you're going to be focusing on first in this class. 00:48:56,280 --> 00:49:01,120
你将在这门课上专注于第一。
--OK, so let's see. 00:49:01,120 --> 00:49:04,080
好的，让我们看看。
--So comparing data parallel with what we've talked about so far, 00:49:04,080 --> 00:49:08,000
因此，将数据与我们目前所讨论的内容进行比较，
--the shared address space model is really 00:49:08,000 --> 00:49:11,400
共享地址空间模型确实
--the least restrictive. 00:49:11,400 --> 00:49:12,920
限制最少。
--Because you have that shared address space, 00:49:12,920 --> 00:49:15,280
因为你有共享地址空间，
--you can communicate however you choose to communicate. 00:49:15,280 --> 00:49:18,920
你可以用你选择的方式进行交流。
--It's very easy to do that. 00:49:18,920 --> 00:49:21,520
这很容易做到。
--With message passing, as you'll see when you start actually 00:49:21,520 --> 00:49:25,880
通过消息传递，正如您实际开始时所看到的那样
--writing software this way, it makes the communication 00:49:25,880 --> 00:49:29,560
以这种方式编写软件，它使通信
--more structured. 00:49:29,560 --> 00:49:30,840
更有条理。
--Because you want to bundle things together into messages. 00:49:30,840 --> 00:49:33,880
因为你想把东西打包成消息。
--You don't want to send individual bytes as messages, 00:49:33,880 --> 00:49:36,800
您不想将单个字节作为消息发送，
--because that's too slow. 00:49:36,800 --> 00:49:38,440
因为那太慢了。
--So usually you end up restructuring your code a bit 00:49:38,440 --> 00:49:41,440
所以通常你最终会稍微重构你的代码
--to try to send messages as infrequently as you can. 00:49:41,440 --> 00:49:44,960
尽可能少地发送消息。
--It constrains that a little bit. 00:49:45,840 --> 00:49:48,880
它限制了一点点。
--The data parallel case is the most restricted 00:49:48,880 --> 00:49:53,680
数据并行情况是最受限制的
--in terms of its applicability. 00:49:53,680 --> 00:49:56,240
就其适用性而言。
--So there are programs where this works really well, 00:49:56,240 --> 00:50:00,360
所以有些程序非常有效，
--and cases where it just doesn't work at all. 00:50:00,360 --> 00:50:02,720
以及它根本不起作用的情况。
--When it works well, though, it works very, very well, 00:50:02,720 --> 00:50:05,880
但是，当它运作良好时，它运作得非常非常好，
--and it's very nice for programmers. 00:50:05,880 --> 00:50:08,040
这对程序员来说非常好。
--And GPUs are built all around this idea of data parallelism. 00:50:08,040 --> 00:50:13,240
 GPU 就是围绕这种数据并行性理念构建的。
--So it's an important model. 00:50:13,280 --> 00:50:15,880
所以这是一个重要的模型。
--And we'll talk about that next here. 00:50:15,880 --> 00:50:20,680
接下来我们将讨论这个问题。
--So in the old, old days of computers, 00:50:20,680 --> 00:50:25,280
所以在过去的计算机时代，
--we had vector supercomputers, which 00:50:25,280 --> 00:50:27,280
我们有矢量超级计算机，
--did lots of things in parallel by having vector instructions. 00:50:27,280 --> 00:50:31,800
通过向量指令并行地做很多事情。
--These were much wider even than the ones we see today. 00:50:31,800 --> 00:50:34,800
这些甚至比我们今天看到的要宽得多。
--You could maybe do 100 or more elements in parallel. 00:50:34,800 --> 00:50:40,600
您可以并行处理 100 个或更多元素。
--And in that case, the thing that was being done in parallel 00:50:40,600 --> 00:50:46,280
在那种情况下，并行进行的事情
--was one instruction. 00:50:46,280 --> 00:50:48,600
是一个指令。
--And today, though, we've moved to, as I said, 00:50:48,600 --> 00:50:54,480
但是今天，正如我所说，我们已经转移到，
--this single program multiple data model, which 00:50:54,480 --> 00:50:58,000
这个单程序多数据模型，
--is we're going to basically do the same work over a lot 00:50:58,000 --> 00:51:02,520
我们基本上会在很多地方做同样的工作吗
--of data, but we're not going to rigidly march 00:51:02,520 --> 00:51:05,280
的数据，但我们不会硬性前进
--through one instruction at a time necessarily. 00:51:05,280 --> 00:51:07,640
必须一次通过一条指令。
--We're going to say, here's a function, 00:51:07,640 --> 00:51:10,120
我们要说，这是一个函数，
--and we want to apply the same function to all of our data. 00:51:10,120 --> 00:51:13,760
我们想对所有数据应用相同的函数。
--So go do that somehow, but we're not necessarily 00:51:13,760 --> 00:51:16,960
所以以某种方式去做，但我们不一定
--going to constrain them to be doing an absolute lock step. 00:51:16,960 --> 00:51:22,320
将限制他们进行绝对锁定步骤。
--OK. 00:51:22,320 --> 00:51:24,600
好的。
--So in ISPC, which we talked about already, 00:51:24,600 --> 00:51:30,280
所以在我们已经讨论过的 ISPC 中，
--in terms of data parallelism, there's 00:51:30,280 --> 00:51:32,200
在数据并行性方面，有
--something that's a little bit like data parallelism, 00:51:32,200 --> 00:51:35,240
有点像数据并行性，
--but only in a very loose way, which 00:51:35,240 --> 00:51:37,880
但只是以一种非常松散的方式，
--I talked about the for each primitive, 00:51:38,240 --> 00:51:42,760
我谈到了每个原语，
--and I said that I can point to a loop 00:51:42,760 --> 00:51:45,280
我说我可以指向一个循环
--and replace the normal for loop with a for each loop, 00:51:45,280 --> 00:51:47,960
并将普通的 for 循环替换为 for each 循环，
--and this is telling the system that it 00:51:47,960 --> 00:51:50,080
这是告诉系统它
--can take all the iterations of the loop 00:51:50,080 --> 00:51:52,120
可以接受循环的所有迭代
--and operate on them in parallel. 00:51:52,120 --> 00:51:54,640
并并行操作它们。
--Now, technically, this is only control parallelism. 00:51:54,640 --> 00:51:59,180
现在，从技术上讲，这只是控制并行性。
--I've just said the iterations of the loop 00:51:59,180 --> 00:52:01,120
我刚才说了循环的迭代
--can be run in parallel. 00:52:01,120 --> 00:52:03,160
可以并行运行。
--The ISPC doesn't really think or care 00:52:03,160 --> 00:52:05,960
 ISPC 并不真正思考或关心
--about what's going on with the data inside of that loop. 00:52:05,960 --> 00:52:09,280
关于该循环内的数据发生了什么。
--So if you, I'm going to show you examples in a second, 00:52:09,280 --> 00:52:12,520
所以如果你，我马上给你看例子，
--but you can easily break your code this way. 00:52:12,520 --> 00:52:16,040
但是您可以通过这种方式轻松破坏您的代码。
--If you give it code where the operations are not actually 00:52:16,040 --> 00:52:19,640
如果你给它代码的操作实际上不是
--independent, then strange things can happen. 00:52:19,640 --> 00:52:22,520
独立，那么奇怪的事情就会发生。
--It's not thinking about data in a principled way 00:52:22,520 --> 00:52:26,640
它没有以原则性的方式考虑数据
--when it comes to data parallelism. 00:52:26,640 --> 00:52:30,240
当谈到数据并行性时。
--OK. 00:52:30,240 --> 00:52:31,600
好的。
--But let's look at some examples here. 00:52:31,600 --> 00:52:33,560
但是让我们在这里看一些例子。
--For example, here's a new made-up ISPC function 00:52:33,760 --> 00:52:40,040
例如，这是一个新的虚构的 ISPC 函数
--where what we want to do is compute 00:52:40,040 --> 00:52:41,920
我们要做的是计算
--the absolute value of something and then 00:52:41,920 --> 00:52:44,960
某物的绝对值然后
--generate two copies of it. 00:52:44,960 --> 00:52:46,600
生成它的两个副本。
--For example, if I have, say, 1, negative 2, negative 3, 00:52:46,600 --> 00:52:52,240
例如，如果我有，比如说，1，负数 2，负数 3，
--then what I want to generate is I'm 00:52:52,240 --> 00:52:55,240
那么我想要生成的是
--generating two 1's, two 2's, two 3's, and so on. 00:52:55,240 --> 00:53:03,280
生成两个 1、两个 2、两个 3 等等。
--So that's what this code is doing. 00:53:03,280 --> 00:53:07,080
这就是这段代码所做的。
--I'm not sure why that's very interesting, 00:53:07,080 --> 00:53:08,800
我不确定为什么这很有趣，
--but it fits on the slide. 00:53:08,800 --> 00:53:11,880
但它适合幻灯片。
--So you can see that we've got elements of I, 00:53:11,880 --> 00:53:16,160
所以你可以看到我们有 I 的元素，
--and I is going to correspond to the input elements. 00:53:16,160 --> 00:53:20,320
我将对应于输入元素。
--And then we're generating two output elements. 00:53:20,320 --> 00:53:23,320
然后我们生成两个输出元素。
--So we're taking absolute values, and then we're copying it. 00:53:23,320 --> 00:53:27,920
所以我们采用绝对值，然后复制它。
--OK. 00:53:27,920 --> 00:53:28,420
好的。
--So that is like a form of data parallelism. 00:53:28,420 --> 00:53:31,160
所以这就像一种数据并行形式。
--We're getting the parallelism out of the fact 00:53:31,160 --> 00:53:33,000
我们从事实中得到并行性
--that we can do it independently across all of our input data. 00:53:33,040 --> 00:53:38,440
我们可以在所有输入数据中独立完成。
--OK, wow, I forgot about that. 00:53:38,440 --> 00:53:40,760
好吧，哇，我忘记了。
--Hang on. 00:53:40,760 --> 00:53:41,440
不挂断。
--Let's, all right. 00:53:41,440 --> 00:53:44,360
让我们，好吧。
--So OK, that'll take too long. 00:53:44,360 --> 00:53:47,600
好吧，那会花很长时间。
--All right. 00:53:47,600 --> 00:53:48,280
好的。
--So this is a valid ISPC program, so that will compile. 00:53:48,280 --> 00:53:55,280
所以这是一个有效的 ISPC 程序，因此可以编译。
--But it wasn't really thinking at all about what 00:53:55,280 --> 00:53:57,520
但它根本没有考虑什么
--was going on in the loop. 00:53:57,520 --> 00:53:59,200
在循环中进行。
--So here's another example. 00:53:59,200 --> 00:54:01,960
这是另一个例子。
--And what we're doing is looking at an element 00:54:01,960 --> 00:54:07,400
我们正在做的是查看一个元素
--to see whether or not it is negative. 00:54:07,400 --> 00:54:11,400
看看它是否是负面的。
--And if the input element is negative, 00:54:11,400 --> 00:54:13,960
如果输入元素为负，
--then we're going to copy it to, we're 00:54:13,960 --> 00:54:17,000
然后我们将它复制到，我们是
--going to shift it left one position. 00:54:17,000 --> 00:54:19,480
要把它移到一个位置。
--And if it's not negative, then we're 00:54:19,480 --> 00:54:21,020
如果它不是负面的，那么我们就是
--just going to copy it to the same position in the output. 00:54:21,020 --> 00:54:24,440
只是将它复制到输出中的相同位置。
--So you may copy it one to the left, 00:54:24,440 --> 00:54:26,760
所以你可以把它复制到左边，
--or maybe just straight down into the output array. 00:54:26,760 --> 00:54:31,540
或者直接进入输出数组。
--So ISPC is completely happy with this, in the sense 00:54:31,620 --> 00:54:34,860
所以 ISPC 对此完全满意，从某种意义上说
--that it will generate code, and it'll run it in parallel. 00:54:34,860 --> 00:54:38,020
它会生成代码，并且会并行运行。
--As a programmer, would you be completely happy with this? 00:54:38,020 --> 00:54:41,940
作为一名程序员，你会对此完全满意吗？
--What can happen here? 00:54:41,940 --> 00:54:43,140
这里会发生什么？
--They overwrite the value one, three, four. 00:54:47,140 --> 00:54:51,580
它们会覆盖值一、三、四。
--Right, so if you have positive and negative values 00:54:51,580 --> 00:54:54,620
对，所以如果你有正值和负值
--next to each other, then two different concurrent instances 00:54:54,620 --> 00:54:59,420
彼此相邻，然后是两个不同的并发实例
--may be writing to the same output. 00:54:59,420 --> 00:55:02,500
可能正在写入相同的输出。
--And so what will happen, from the programmer's point of view, 00:55:02,500 --> 00:55:07,340
那么从程序员的角度来看，会发生什么，
--is that the program can become non-deterministic now. 00:55:07,340 --> 00:55:10,460
是程序现在可以变得不确定。
--So the value that we get out, now actually in ISPC, 00:55:10,460 --> 00:55:13,940
所以我们得到的价值，现在实际上在 ISPC 中，
--because it's rigidly walking through with vectors and loops, 00:55:13,940 --> 00:55:17,460
因为它严格地遍历向量和循环，
--it won't actually be non-deterministic 00:55:17,460 --> 00:55:21,100
它实际上不会是不确定的
--unless you use tasks. 00:55:21,100 --> 00:55:22,700
除非你使用任务。
--But if you wrote something that was data parallel like this, 00:55:22,700 --> 00:55:27,620
但是如果你像这样写一些数据并行的东西，
--and if it was a little less rigid, 00:55:27,620 --> 00:55:29,020
如果它不那么僵硬，
--then you would have something that was non-deterministic. 00:55:29,020 --> 00:55:32,460
那么你会得到一些不确定的东西。
--OK, so that's all right. 00:55:32,460 --> 00:55:36,140
好的，这样就可以了。
--So what we could do, I don't necessarily 00:55:36,140 --> 00:55:40,860
所以我们能做什么，我不一定
--want to get super hung up on all these details, 00:55:40,860 --> 00:55:42,820
想要超级关注所有这些细节，
--but what we could do is, so how can we 00:55:42,820 --> 00:55:46,660
但我们能做的是，所以我们怎么能
--take advantage of data parallelism 00:55:46,660 --> 00:55:48,860
利用数据并行性
--in a more principled way, so that we 00:55:48,860 --> 00:55:50,740
以更有原则的方式，让我们
--don't have weird problems like the one that we just saw? 00:55:50,740 --> 00:55:53,860
没有像我们刚才看到的那样奇怪的问题？
--So one abstraction for this is something 00:55:53,860 --> 00:55:57,100
所以对此的一个抽象是
--called streams, where the idea is 00:55:57,100 --> 00:56:00,420
称为流，其中的想法是
--that we have input data coming in, 00:56:00,420 --> 00:56:03,660
我们有输入数据进来，
--and we're going to generate output data going out. 00:56:03,660 --> 00:56:06,500
我们将生成输出数据。
--And we have some function, pure function, 00:56:06,500 --> 00:56:08,780
我们有一些功能，纯功能，
--that we apply to the inputs, and we use 00:56:08,780 --> 00:56:11,300
我们应用于输入，我们使用
--that to generate the outputs. 00:56:11,300 --> 00:56:13,700
生成输出。
--So for example, if I want to, I have two arrays. 00:56:13,700 --> 00:56:18,380
因此，例如，如果我愿意，我有两个数组。
--x is my input, y is my output. 00:56:18,380 --> 00:56:21,980
 x 是我的输入，y 是我的输出。
--And I simply want to generate the absolute value 00:56:21,980 --> 00:56:25,380
我只是想产生绝对值
--of the input as the output. 00:56:25,380 --> 00:56:27,860
输入作为输出。
--So this is an ISPC program that does that. 00:56:27,860 --> 00:56:30,780
所以这是一个执行此操作的 ISPC 程序。
--So it just tests. 00:56:30,780 --> 00:56:32,180
所以它只是测试。
--If it's negative, then we invert it 00:56:32,180 --> 00:56:34,220
如果它是负的，那么我们将它反转
--to take its absolute value, and we generate output that way. 00:56:34,220 --> 00:56:40,460
取其绝对值，然后我们以这种方式生成输出。
--And that would be great, in the sense 00:56:40,460 --> 00:56:42,700
从某种意义上说，那会很棒
--that there's no non-determinism. 00:56:42,700 --> 00:56:44,420
没有不确定性。
--It would run in parallel. 00:56:44,420 --> 00:56:46,500
它会并行运行。
--That all looks good. 00:56:46,500 --> 00:56:47,340
这一切看起来不错。
--OK, so in this model, in the stream model, 00:56:50,500 --> 00:56:54,980
好的，所以在这个模型中，在流模型中，
--we have streams. 00:56:54,980 --> 00:56:56,100
我们有溪流。
--This is the data that we are operating on. 00:56:56,100 --> 00:56:58,740
这是我们正在操作的数据。
--So it's some collection of elements. 00:56:58,740 --> 00:57:00,580
所以它是一些元素的集合。
--And we know that we can process each element independently. 00:57:00,580 --> 00:57:03,620
而且我们知道我们可以独立处理每个元素。
--So that's good. 00:57:03,620 --> 00:57:05,380
所以这很好。
--And then the kernel, the thing that we apply to it, 00:57:05,380 --> 00:57:08,180
然后是内核，我们应用到它的东西，
--so in this case, this is our quote unquote kernel. 00:57:08,180 --> 00:57:11,980
所以在这种情况下，这是我们的 quote unquote 内核。
--This is some side effect free function. 00:57:11,980 --> 00:57:14,940
这是一些无副作用的功能。
--So we can apply them in any order, 00:57:14,940 --> 00:57:16,580
所以我们可以按任何顺序应用它们，
--since they're these nice pure functions. 00:57:16,580 --> 00:57:19,220
因为它们是这些很好的纯函数。
--So that's the basic idea of the stream model. 00:57:19,220 --> 00:57:22,220
这就是流模型的基本思想。
--That's one way to have data parallelism 00:57:22,220 --> 00:57:25,260
这是实现数据并行性的一种方式
--and avoid some of these data races or things like that. 00:57:25,260 --> 00:57:31,140
并避免其中一些数据竞争或类似的事情。
--So for example, let's say we want 00:57:31,140 --> 00:57:35,100
例如，假设我们想要
--to do more than one thing to it. 00:57:35,100 --> 00:57:36,420
对它做不止一件事。
--In the previous example, we were just 00:57:36,420 --> 00:57:37,960
在前面的例子中，我们只是
--calculating the absolute value. 00:57:37,960 --> 00:57:39,340
计算绝对值。
--But let's say we have multiple things 00:57:39,340 --> 00:57:41,180
但是假设我们有很多东西
--that we want to do to the data. 00:57:41,180 --> 00:57:43,260
我们想对数据做的。
--So we're applying foo first, because that's 00:57:43,260 --> 00:57:47,820
所以我们首先应用 foo，因为那是
--our standard procedure name, and then bar. 00:57:47,820 --> 00:57:50,860
我们的标准程序名称，然后是栏。
--So we do foo, and we do bar. 00:57:50,860 --> 00:57:53,260
所以我们做 foo，我们做 bar。
--And we can just stream the output of foo 00:57:53,260 --> 00:57:56,140
我们可以流式传输 foo 的输出
--into make it the input into bar. 00:57:56,140 --> 00:57:59,740
into 使其成为 bar 的输入。
--So we create a temporary stream or array. 00:57:59,740 --> 00:58:04,100
所以我们创建一个临时流或数组。
--And that gets generated in the middle. 00:58:04,100 --> 00:58:07,300
那是在中间产生的。
--And then the compiler can take this 00:58:07,300 --> 00:58:09,020
然后编译器可以接受这个
--and understand what's going on, and then 00:58:09,020 --> 00:58:11,220
并了解发生了什么，然后
--create a lot of parallelism. 00:58:11,220 --> 00:58:13,500
创造很多并行性。
--So this is one way that we can think about data parallelism 00:58:13,500 --> 00:58:16,900
所以这是我们可以考虑数据并行性的一种方式
--with stream programming. 00:58:16,900 --> 00:58:20,220
与流编程。
--Now, I won't belabor this too much. 00:58:21,220 --> 00:58:24,420
现在，我不会过多地强调这一点。
--But it turns out, though, if I just back up and look 00:58:24,420 --> 00:58:30,180
但事实证明，如果我只是倒退看看
--at this example, one thing that's a little unfortunate 00:58:30,180 --> 00:58:33,420
在这个例子中，有一件事有点不幸
--here is I have to create this temporary thing in the middle. 00:58:33,420 --> 00:58:37,460
这是我必须在中间创建这个临时的东西。
--The thing that starts to happen if you start using streams 00:58:37,460 --> 00:58:40,140
如果您开始使用流，就会开始发生的事情
--a lot is you realize, well, it's kind of a waste 00:58:40,140 --> 00:58:43,140
很多是你意识到的，好吧，这是一种浪费
--that we have to write the temporary out 00:58:43,140 --> 00:58:45,260
我们必须写出临时的
--and waste bandwidth doing that. 00:58:45,260 --> 00:58:46,580
这样做会浪费带宽。
--It would be nice if we could bring something in and compose 00:58:46,580 --> 00:58:49,540
如果我们能带些东西进来作曲就好了
--together both foo and bar and do them together. 00:58:49,580 --> 00:58:52,980
把 foo 和 bar 放在一起，一起做。
--And maybe the compiler doesn't necessarily 00:58:52,980 --> 00:58:54,980
也许编译器不一定
--know how to do that without some help from the programmer. 00:58:54,980 --> 00:58:57,940
知道如何在没有程序员帮助的情况下做到这一点。
--So you may end up wanting to have new operators that 00:58:57,940 --> 00:59:02,500
所以你可能最终想要拥有新的运营商
--do fancier and fancier things. 00:59:02,500 --> 00:59:05,140
做越来越花哨的事情。
--So for example, several slides ago, 00:59:05,140 --> 00:59:07,540
例如，几张幻灯片之前，
--I showed you code that would take an input array, 00:59:07,540 --> 00:59:11,180
我向您展示了采用输入数组的代码，
--take the absolute value, but then 00:59:11,180 --> 00:59:13,020
取绝对值，然后
--double the number of elements in the output. 00:59:13,020 --> 00:59:15,460
将输出中的元素数量加倍。
--So we get twice as many output elements as input elements. 00:59:15,460 --> 00:59:19,180
所以我们得到的输出元素是输入元素的两倍。
--And if we want to do that, that's not necessarily 00:59:19,180 --> 00:59:21,820
如果我们想这样做，那不一定
--a great match for this stream model of one-to-one input 00:59:21,820 --> 00:59:24,740
非常适合这种一对一输入的流模型
--and output. 00:59:24,740 --> 00:59:25,620
和输出。
--So we might want to have a new primitive which says, 00:59:25,620 --> 00:59:28,780
所以我们可能想要一个新的原语，它说，
--OK, double the number of elements in the array. 00:59:28,780 --> 00:59:32,060
好的，将数组中的元素数量加倍。
--For every input, generate two outputs. 00:59:32,060 --> 00:59:35,180
对于每个输入，生成两个输出。
--And then we can take the absolute value of that, 00:59:35,180 --> 00:59:37,220
然后我们可以取它的绝对值，
--and then that would all be nice. 00:59:37,220 --> 00:59:40,700
然后一切都会很好。
--So the issue is that then, OK, so one potential disadvantage 00:59:40,700 --> 00:59:44,900
所以问题是，好吧，一个潜在的缺点
--is we may need to add more and more things into the model 00:59:44,940 --> 00:59:50,260
我们可能需要在模型中添加越来越多的东西
--to make sure we can capture everything we 00:59:50,260 --> 00:59:52,620
以确保我们能够捕捉到我们想要的一切
--want to do stream programming. 00:59:52,620 --> 00:59:53,980
想做流式编程。
--So if you're doing relatively simple things with a stream 00:59:53,980 --> 00:59:57,460
所以如果你用流做相对简单的事情
--model, it works well. 00:59:57,460 --> 00:59:58,540
型号，效果不错。
--If things start to get really complicated, 00:59:58,540 --> 01:00:00,340
如果事情开始变得非常复杂，
--then it starts to get a little less nice. 01:00:00,340 --> 01:00:04,340
然后它开始变得不那么好。
--So some other important parts of the stream model, 01:00:04,340 --> 01:00:08,260
所以流模型的其他一些重要部分，
--and these primitives show up in other places 01:00:08,260 --> 01:00:10,340
这些原语出现在其他地方
--too in data parallelism, is that often the data 01:00:10,340 --> 01:00:13,420
在数据并行性方面也是如此，通常是数据
--that you want to operate on or produce 01:00:13,420 --> 01:00:17,140
你想操作或生产的
--may not be contiguous to begin with. 01:00:17,140 --> 01:00:19,660
一开始可能不连续。
--But you really do want to compute on it 01:00:19,660 --> 01:00:21,740
但你真的想计算它
--as contiguous data. 01:00:21,740 --> 01:00:23,740
作为连续数据。
--So then the primitives that are helpful here 01:00:23,740 --> 01:00:26,300
那么这里有用的原语
--are things called gather and scatter, which you've probably 01:00:26,300 --> 01:00:28,800
是聚集和分散的东西，你可能已经
--heard about already. 01:00:28,800 --> 01:00:30,340
听说过。
--So the idea with gather is that not only you say, well, 01:00:30,340 --> 01:00:35,660
所以 gather 的想法是，不仅你会说，嗯，
--here's my input. 01:00:35,660 --> 01:00:38,300
这是我的意见。
--What I want to do is, this is pointing to memory. 01:00:38,300 --> 01:00:42,220
我想要做的是，这是指向内存。
--And then this is another element. 01:00:42,220 --> 01:00:43,620
然后这是另一个元素。
--And this array contains the indices 01:00:43,620 --> 01:00:45,700
这个数组包含索引
--that I actually want in wherever they are. 01:00:45,700 --> 01:00:48,900
无论他们身在何处，我实际上都想要。
--And this is saying, go grab all of these 01:00:48,900 --> 01:00:52,020
这就是说，去抓住所有这些
--and arrange them contiguously into this array. 01:00:52,020 --> 01:00:56,180
并将它们连续排列到这个数组中。
--And then I can use that as input to some stream routine. 01:00:56,180 --> 01:01:02,220
然后我可以将其用作某些流例程的输入。
--And now it'll be nice and contiguous and all is good. 01:01:02,220 --> 01:01:05,100
现在它会很好而且很连续，一切都很好。
--That's what gather does. 01:01:05,100 --> 01:01:06,780
这就是收集所做的。
--And then scatter does the output version of that. 01:01:06,780 --> 01:01:10,300
然后 scatter 执行它的输出版本。
--So with scatter, I have some output and indices 01:01:10,300 --> 01:01:13,780
所以有了分散，我有一些输出和索引
--where I want to actually store it. 01:01:13,780 --> 01:01:15,220
我想实际存储它的地方。
--And then it will go actually store them there. 01:01:15,220 --> 01:01:18,100
然后它将实际存储在那里。
--So you can see, here is the equivalent ISPC 01:01:18,100 --> 01:01:22,580
所以你可以看到，这是等效的 ISPC
--code for gather and scatter. 01:01:22,580 --> 01:01:25,820
聚集和分散的代码。
--As I mentioned before, the Intel's vector instructions 01:01:25,820 --> 01:01:31,420
正如我之前提到的，英特尔的矢量指令
--do include a gather load instruction. 01:01:31,420 --> 01:01:35,380
确实包括收集加载指令。
--They do not include a scatter, though. 01:01:35,380 --> 01:01:40,140
不过，它们不包括散点图。
--So then this is the visualization 01:01:40,500 --> 01:01:42,060
那么这就是可视化
--of what gather does. 01:01:42,060 --> 01:01:43,500
收集的东西。
--We give it a pointer. 01:01:43,500 --> 01:01:47,020
我们给它一个指针。
--It says gather. 01:01:47,020 --> 01:01:48,820
它说聚集。
--This R1 is pointing to where the array begins. 01:01:48,820 --> 01:01:52,500
这个 R1 指向数组开始的地方。
--R0 is the indices. 01:01:52,500 --> 01:01:55,380
 R0 是指数。
--So here's our indices. 01:01:55,380 --> 01:01:57,700
所以这是我们的指数。
--And then we want to, sorry, that's the memory base. 01:01:57,700 --> 01:02:00,780
然后我们想，抱歉，那是内存基础。
--So that's pointing here. 01:02:00,780 --> 01:02:02,020
所以它指向这里。
--We want to generate the result here. 01:02:02,020 --> 01:02:03,900
我们想在这里生成结果。
--And so it's just going to do a whole bunch of, effectively, 01:02:03,900 --> 01:02:07,300
所以它会做一大堆，有效的，
--memory loads and stick things together contiguously for you. 01:02:07,300 --> 01:02:10,900
内存加载并为您连续地将东西粘在一起。
--So that's what gather does. 01:02:10,900 --> 01:02:13,500
这就是收集的作用。
--So GPUs typically do have support for gather and scatter. 01:02:13,500 --> 01:02:18,940
所以 GPU 通常确实支持收集和分散。
--So you will see those operations there. 01:02:18,940 --> 01:02:23,260
所以你会在那里看到那些操作。
--OK, so to summarize the data parallel model, 01:02:23,260 --> 01:02:28,380
好的，总结一下数据并行模型，
--this is designed for the case where you have, 01:02:28,380 --> 01:02:33,740
这是为你有的情况而设计的，
--so the thing is, if the thing you're trying to calculate 01:02:34,500 --> 01:02:37,500
所以问题是，如果你要计算的东西
--involves effectively applying the same computation to lots 01:02:37,500 --> 01:02:41,460
涉及对批次有效地应用相同的计算
--of data, then data parallelism should work very well. 01:02:41,460 --> 01:02:46,180
的数据，那么数据并行性应该工作得很好。
--And things like GPUs are all built 01:02:46,180 --> 01:02:48,300
 GPU之类的东西都是内置的
--around taking a lot of advantage of data parallelism. 01:02:48,300 --> 01:02:51,220
围绕着充分利用数据并行性。
--So if this fits what you're trying to do, 01:02:51,220 --> 01:02:54,020
所以如果这符合你想要做的，
--then this is very nice. 01:02:54,020 --> 01:02:57,420
那么这很好。
--And it's basically like mapping some function 01:02:57,420 --> 01:03:00,460
它基本上就像映射一些功能
--onto a large amount of data. 01:03:00,460 --> 01:03:02,460
到大量数据上。
--And in fact, even if you are targeting 01:03:02,580 --> 01:03:05,620
事实上，即使你的目标是
--a machine that supports message passing or shared address 01:03:05,620 --> 01:03:08,580
支持消息传递或共享地址的机器
--space, if your program has data parallelism, 01:03:08,580 --> 01:03:12,620
空间，如果你的程序有数据并行性，
--then you should be able to get some really good performance. 01:03:12,620 --> 01:03:15,820
那么你应该能够获得一些非常好的性能。
--And when we start talking about specific code examples, 01:03:15,820 --> 01:03:18,780
当我们开始谈论具体的代码示例时，
--you'll see that in practice. 01:03:18,780 --> 01:03:20,580
你会在实践中看到这一点。
--So data parallel is not just a programming abstraction. 01:03:20,580 --> 01:03:24,820
所以数据并行不仅仅是一种编程抽象。
--It's a good way to think about how 01:03:24,820 --> 01:03:27,180
这是思考如何做的好方法
--you're going to structure your code, 01:03:27,180 --> 01:03:28,700
你要构建你的代码，
--even if you're targeting some other model. 01:03:28,700 --> 01:03:30,580
即使您的目标是其他模型。
--So just to wrap things up here, just a couple more slides here. 01:03:33,460 --> 01:03:39,100
因此，为了总结一下，这里再放几张幻灯片。
--So to review, we talked about three different models, 01:03:39,100 --> 01:03:41,740
所以回顾一下，我们谈到了三种不同的模型，
--shared address space, message passing, and data parallel. 01:03:41,740 --> 01:03:45,300
共享地址空间、消息传递和数据并行。
--The shared address space is communication 01:03:45,300 --> 01:03:48,940
共享地址空间是通信
--occurs through loading and storing memory 01:03:48,940 --> 01:03:51,580
通过加载和存储内存发生
--in the shared address space. 01:03:51,580 --> 01:03:53,500
在共享地址空间中。
--In message passing, it's all about sending messages to, 01:03:53,500 --> 01:03:56,740
在消息传递中，就是将消息发送到，
--it's all done through sending messages to other threads 01:03:56,740 --> 01:03:59,460
这一切都是通过向其他线程发送消息来完成的
--because you only have a private memory address space. 01:03:59,460 --> 01:04:02,180
因为你只有一个私有内存地址空间。
--There's no shared address space. 01:04:02,460 --> 01:04:04,980
没有共享地址空间。
--And in data parallel, you're taking, effectively, 01:04:04,980 --> 01:04:07,700
在并行数据中，你正在有效地，
--some function or some computation, 01:04:07,700 --> 01:04:09,420
一些功能或一些计算，
--and you're mapping it across some collection of data. 01:04:09,420 --> 01:04:13,340
并且您正在将其映射到一些数据集合中。
--So OK. 01:04:13,340 --> 01:04:16,620
那么好吧。
--Now, all right, so one of the reasons, 01:04:16,620 --> 01:04:19,580
现在，好吧，原因之一，
--one of the last things I want to emphasize here 01:04:19,580 --> 01:04:22,300
我想在这里强调的最后一件事
--is that in practice, it's not the case 01:04:22,300 --> 01:04:24,420
在实践中，情况并非如此
--that you just get to form an opinion about your favorite 01:04:24,420 --> 01:04:27,620
你只是对你最喜欢的形成了意见
--programming model. 01:04:27,620 --> 01:04:28,620
编程模型。
--You say, ah, I really like shared address space. 01:04:28,620 --> 01:04:31,400
你说啊，我很喜欢共享地址空间。
--I really don't like message passing. 01:04:31,400 --> 01:04:33,440
我真的不喜欢消息传递。
--I'm lukewarm on data parallel, or whatever it is. 01:04:33,440 --> 01:04:36,000
我对数据并行不冷不热，或者不管它是什么。
--You really want to be good at all of these different models, 01:04:36,000 --> 01:04:38,540
你真的想擅长所有这些不同的模型，
--because in practice, you usually have 01:04:38,540 --> 01:04:40,780
因为在实践中，你通常有
--to do all of the above if you're really 01:04:40,780 --> 01:04:43,180
做以上所有事情，如果你真的
--trying to take full advantage of high-end machines. 01:04:43,180 --> 01:04:49,000
试图充分利用高端机器。
--So in particular, within a multi-core chip, 01:04:49,000 --> 01:04:54,400
因此，特别是在多核芯片中，
--you will always have shared address space support 01:04:54,400 --> 01:04:57,120
您将始终拥有共享地址空间支持
--because they just physically share caches, 01:04:57,120 --> 01:04:59,960
因为他们只是在物理上共享缓存，
--and it's really easy to support it there. 01:04:59,960 --> 01:05:02,640
在那里支持它真的很容易。
--So you're always going to see shared address space 01:05:02,640 --> 01:05:05,320
所以你总是会看到共享地址空间
--at a small scale. 01:05:05,320 --> 01:05:07,400
在小范围内。
--At a large scale, you may not have the hardware support 01:05:07,400 --> 01:05:10,560
大规模时，您可能没有硬件支持
--for cache coherence. 01:05:10,560 --> 01:05:11,640
用于缓存一致性。
--So at a larger scale, you may need to use message 01:05:11,640 --> 01:05:14,600
所以在更大的范围内，你可能需要使用消息
--passing to communicate. 01:05:14,600 --> 01:05:17,360
通过沟通。
--And it's also very common that we have not only CPUs, 01:05:17,360 --> 01:05:20,440
而且很常见的是我们不仅有 CPU，
--but GPUs, and GPUs are all about data parallelism. 01:05:20,440 --> 01:05:24,200
但是 GPU 和 GPU 都是关于数据并行性的。
--So you may be mixing a very data parallel-oriented style 01:05:24,200 --> 01:05:28,720
所以你可能混合了一种非常面向数据的并行风格
--of execution with using either one of the other two 01:05:28,760 --> 01:05:33,000
使用其他两个中的任何一个执行
--models for the parts of your code 01:05:33,000 --> 01:05:34,560
代码部分的模型
--that don't fit data parallelism so well, 01:05:34,560 --> 01:05:37,520
不太适合数据并行性，
--and they may be talking to each other that way. 01:05:37,520 --> 01:05:40,680
他们可能就是这样互相交谈的。
--So for example, the Roadrunner machine at Los Alamos National 01:05:40,680 --> 01:05:46,980
例如，洛斯阿拉莫斯国家公园的 Roadrunner 机器
--Labs, this was 10 years ago, the fastest computer 01:05:46,980 --> 01:05:52,120
实验室，这是 10 年前，最快的计算机
--in the world for some period of time. 01:05:52,120 --> 01:05:54,680
在世界上一段时间。
--And it was basically composed of lots and lots 01:05:54,680 --> 01:05:58,640
它基本上由很多很多组成
--of things at the smaller scale. 01:05:58,640 --> 01:06:01,560
较小规模的事物。
--We've got lots of these IBM cell GPUs. 01:06:01,560 --> 01:06:05,760
我们有很多这样的 IBM 单元 GPU。
--And within them, they had a shared address space. 01:06:05,760 --> 01:06:09,000
在它们内部，它们有一个共享的地址空间。
--But across different nodes, you did not 01:06:09,000 --> 01:06:13,040
但是跨不同的节点，你没有
--have a shared address space. 01:06:13,040 --> 01:06:14,500
有一个共享的地址空间。
--You had message passing. 01:06:14,500 --> 01:06:16,740
你有消息传递。
--So you had to have one program that 01:06:16,740 --> 01:06:18,960
所以你必须有一个程序
--would take advantage of both of those models at the same time. 01:06:18,960 --> 01:06:21,920
将同时利用这两种模型。
--OK. 01:06:22,280 --> 01:06:25,280
好的。
--So to wrap things up, we've been talking about abstractions 01:06:25,280 --> 01:06:30,280
所以总而言之，我们一直在谈论抽象
--and implementations. 01:06:30,280 --> 01:06:32,040
和实施。
--And we saw ISPC as one example, and then we 01:06:32,040 --> 01:06:36,720
我们将 ISPC 视为一个例子，然后我们
--talked about three other abstractions. 01:06:36,720 --> 01:06:40,080
谈到了其他三个抽象。
--And let's see. 01:06:40,080 --> 01:06:41,960
让我们看看。
--So when you're designing a new abstraction, 01:06:41,960 --> 01:06:43,880
所以当你设计一个新的抽象时，
--so just historically, the way these abstractions came about, 01:06:43,880 --> 01:06:46,920
所以从历史上看，这些抽象的产生方式，
--actually, usually when somebody invents a new abstraction, 01:06:46,920 --> 01:06:50,040
实际上，通常当有人发明了一种新的抽象概念时，
--it's because at a low level, they 01:06:50,080 --> 01:06:52,440
这是因为在低层次上，他们
--think they have a really efficient way 01:06:52,440 --> 01:06:54,080
认为他们有一个非常有效的方法
--to implement it in hardware. 01:06:54,080 --> 01:06:56,320
在硬件中实现它。
--So initially, these things all started off 01:06:56,320 --> 01:06:58,320
所以最初，这些事情都开始了
--as things that were very tied to hardware. 01:06:58,320 --> 01:07:00,600
作为与硬件非常相关的东西。
--But over time, people realized, oh, wait, really? 01:07:00,600 --> 01:07:03,800
但随着时间的推移，人们意识到，哦，等等，真的吗？
--This abstraction is less tied to the hardware than we thought. 01:07:03,800 --> 01:07:06,480
这种抽象不像我们想象的那样与硬件相关。
--We can implement it on different machines and so on. 01:07:06,480 --> 01:07:10,320
我们可以在不同的机器上实现它等等。
--OK. 01:07:10,320 --> 01:07:11,480
好的。
--And one thing that's important, as I just said a minute ago, 01:07:11,480 --> 01:07:14,240
有一件事很重要，正如我刚才所说的，
--is you'll want to be able to think about things 01:07:14,240 --> 01:07:16,160
你是否希望能够思考事情
--from multiple different perspectives. 01:07:16,160 --> 01:07:19,440
从多个不同的角度。
--So that's actually it for today. 01:07:19,520 --> 01:07:23,200
这就是今天的内容。
--For once, we're finishing ahead of schedule, which is not bad. 01:07:23,200 --> 01:07:28,280
这一次，我们提前完成了，这还不错。
--OK. 01:07:28,280 --> 01:07:28,800
好的。
--So I'll see you on Wednesday, and we'll 01:07:28,800 --> 01:07:31,120
所以我周三见，我们会
--talk more about parallel programming then. 01:07:31,120 --> 01:07:34,360
然后再谈谈并行编程。
