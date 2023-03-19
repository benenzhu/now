--OK, so welcome back to 4.18. 00:00:00,000 --> 00:00:13,480
好的，欢迎回到 4.18。
--So today, we're going to start talking about parallel software. 00:00:13,480 --> 00:00:16,880
所以今天，我们将开始讨论并行软件。
--Last week, we talked about parallel hardware. 00:00:16,880 --> 00:00:19,920
上周，我们讨论了并行硬件。
--And the theme for all of this week and most of next week will be how we actually write parallel code. 00:00:19,920 --> 00:00:27,760
本周和下周大部分时间的主题将是我们如何实际编写并行代码。
--And in fact, so today's theme is the difference between abstraction and implementation. 00:00:27,760 --> 00:00:33,920
事实上，所以今天的主题是抽象和实现之间的区别。
--So abstractions are things that we create to make life better for programmers, to make it easier to express your code and debug it and so on. 00:00:33,920 --> 00:00:44,840
所以抽象是我们为了让程序员的生活更美好而创造的东西，让你更容易表达你的代码和调试它等等。
--But these abstractions need to be implemented. 00:00:44,840 --> 00:00:48,120
但是这些抽象需要被实现。
--And when we're talking about parallelism, it's easy to make the mistake of confusing abstraction and implementation, because these abstractions are used to express concurrency and communication. 00:00:48,120 --> 00:01:02,480
而当我们在谈论并行时，很容易犯混淆抽象和实现的错误，因为这些抽象是用来表达并发和通信的。
--And the system is also doing communication and managing concurrency. 00:01:02,480 --> 00:01:07,480
而且系统也在做通信和管理并发。
--And you don't want to get these things confused with each other. 00:01:07,480 --> 00:01:11,400
你不想让这些东西彼此混淆。
--So we're going to go through a specific example first, which is a really interesting parallel language called ISPC from Intel. 00:01:11,400 --> 00:01:21,120
所以我们首先要通过一个具体的例子，这是一个非常有趣的并行语言，叫做英特尔的 ISPC。
--And after that, I'm going to talk about several other very popular and common abstractions. 00:01:21,120 --> 00:01:27,960
之后，我将讨论其他几个非常流行和常见的抽象。
--OK, so ISPC, this is a language that you can download. 00:01:27,960 --> 00:01:33,480
好的，ISPC，这是一种您可以下载的语言。
--It's available on GitHub. 00:01:33,480 --> 00:01:35,240
它在 GitHub 上可用。
--It was developed at Intel. 00:01:35,240 --> 00:01:37,720
它是在英特尔开发的。
--And it has this abstraction called, the acronym for it is SPMD, which stands for Single Program Multiple Data, which is a fancy way of saying that you have concurrency where each of the concurrent controls. 00:01:37,720 --> 00:01:57,440
它有这个抽象，它的首字母缩写词是 SPMD，它代表单程序多数据，这是一种奇特的说法，你在每个并发控制中都具有并发性。
--I'm trying hard not to say thread. 00:01:57,440 --> 00:01:59,720
我努力不说线程。
--So you could say thread. 00:01:59,720 --> 00:02:00,920
所以你可以说线程。
--Each of the logical threads, at least, are executing the same code. 00:02:00,920 --> 00:02:07,400
至少，每个逻辑线程都在执行相同的代码。
--Now, they may or may not be executing it at exactly the same time. 00:02:07,400 --> 00:02:10,480
现在，他们可能会或可能不会同时执行它。
--But you hand them all the same, say, procedure or chunk of code. 00:02:10,480 --> 00:02:15,120
但是你交给他们的都是一样的，比如过程或代码块。
--And they all go off and execute that on their own data, on separate pieces of data. 00:02:15,120 --> 00:02:20,680
他们都开始对自己的数据、不同的数据片段执行该操作。
--And that's how you get parallelism. 00:02:20,680 --> 00:02:22,560
这就是您获得并行性的方式。
--So that's a very common way of writing parallel code. 00:02:22,560 --> 00:02:25,960
所以这是一种非常常见的编写并行代码的方式。
--If you think about it, what's the alternative to that? It would be to have completely different programs operating on different pieces of data, for example. 00:02:25,960 --> 00:02:34,960
如果你考虑一下，还有什么替代方案呢？例如，将有完全不同的程序对不同的数据进行操作。
--Now, that is something that happens sometimes if you write something like, say, a web browser or some piece of software where you have completely different tasks unrelated to each other that are doing their own thing. 00:02:34,960 --> 00:02:48,320
现在，如果您编写诸如 Web 浏览器或某些软件之类的东西时，有时会发生这种情况，在这些软件中，您有完全不同的任务，这些任务彼此无关，但它们在做自己的事情。
--They have completely different procedures that they're executing. 00:02:48,320 --> 00:02:51,720
他们执行的程序完全不同。
--But in our class, when we're trying to make things run faster, usually we're giving them the same code. 00:02:51,720 --> 00:02:57,720
但在我们的课堂上，当我们试图让事情运行得更快时，通常我们会给他们相同的代码。
--And they're executing that way. 00:02:57,720 --> 00:03:00,240
他们就是这样执行的。
--All right, now, as you may recall from Friday, this was an example from the lecture. 00:03:00,240 --> 00:03:06,560
好吧，现在，你可能还记得星期五，这是讲座中的一个例子。
--This is not necessarily the most interesting procedure in the world. 00:03:06,560 --> 00:03:10,260
这不一定是世界上最有趣的程序。
--But it fits on one slide. 00:03:10,260 --> 00:03:11,920
但它适合一张幻灯片。
--And we're going to use it as an example today when we talk about ISPC, at least. 00:03:11,920 --> 00:03:17,240
至少，我们今天在谈论 ISPC 时将使用它作为示例。
--So this code is computing signs using Taylor expansion. 00:03:17,280 --> 00:03:22,360
所以这段代码使用泰勒展开来计算符号。
--So we have an outer loop where it's going to generate lots of different values of output. 00:03:22,360 --> 00:03:28,960
所以我们有一个外循环，它将生成许多不同的输出值。
--And then there's an inner loop where it's computing each of these terms. 00:03:28,960 --> 00:03:34,000
然后有一个内部循环，它计算这些项中的每一项。
--So now we're going to look at doing this in parallel. 00:03:34,000 --> 00:03:38,840
所以现在我们要考虑并行执行此操作。
--OK, so in ISPC, the way that this works, it's a restricted model where what you do is you take the pieces of software that you want to run in parallel. 00:03:38,840 --> 00:03:52,800
好的，所以在 ISPC 中，它的工作方式是一个受限模型，您所做的就是获取要并行运行的软件片段。
--And you pull them out and put them into their own separate files. 00:03:52,800 --> 00:03:56,760
然后你将它们拉出来并放入它们自己的单独文件中。
--And the code looks a lot like C code. 00:03:56,760 --> 00:04:00,040
而且代码看起来很像 C 代码。
--But it has the file name, instead of it being .c, it's .ispc. 00:04:00,040 --> 00:04:07,160
但它有文件名，不是.c，而是.ispc。
--So those things will run in parallel. 00:04:07,160 --> 00:04:11,200
所以这些东西将并行运行。
--I'll talk about that more in a second. 00:04:11,200 --> 00:04:13,680
我稍后会详细讨论。
--But then you have the code around that that calls that parallel code. 00:04:13,680 --> 00:04:19,360
但是随后您拥有调用该并行代码的代码。
--So there's, in this case, main.cpp, our main file. 00:04:19,360 --> 00:04:24,160
所以，在这种情况下，我们的主文件是 main.cpp。
--It's going to actually execute sequentially until it gets to the point where it calls a method that's in an ISPC file. 00:04:24,160 --> 00:04:35,280
它实际上会按顺序执行，直到它调用 ISPC 文件中的方法为止。
--OK, now in this abstraction, you'll notice we're not going to use the word thread. 00:04:35,280 --> 00:04:40,240
好的，现在在这个抽象中，您会注意到我们不打算使用线程这个词。
--Instead, we talk about something that sounds a little squishy or a little bit vague. 00:04:40,240 --> 00:04:45,040
相反，我们谈论的东西听起来有点糊涂或有点含糊。
--So the idea is what it's going to spawn is not actually threads, but it's going to have this collection or gang of program instances, so things that are operating concurrently. 00:04:45,040 --> 00:05:00,320
所以这个想法是它要产生的实际上不是线程，而是它会有这个集合或程序实例组，所以事情是同时运行的。
--OK, and if we animate what this looks like, basically what happens is when you're over here in the main file here, until you call that method, you're executing sequentially. 00:05:00,320 --> 00:05:15,320
好的，如果我们为它的外观制作动画，基本上会发生什么，当您在此处的主文件中，直到您调用该方法，您将按顺序执行。
--So there's no concurrency there. 00:05:15,320 --> 00:05:16,680
所以那里没有并发性。
--You're just operating sequentially. 00:05:16,680 --> 00:05:18,680
你只是按顺序操作。
--Then you hit this method that's in an ISPC file. 00:05:18,680 --> 00:05:23,320
然后你点击 ISPC 文件中的这个方法。
--At that point, you're running concurrently. 00:05:23,320 --> 00:05:25,800
那时，您正在同时运行。
--And then when you return from it, then you go back to running sequentially again. 00:05:25,800 --> 00:05:29,800
然后当你从它返回时，你又回到顺序运行。
--So you express all of your parallelism by way of creating these separate ISPC files. 00:05:29,800 --> 00:05:36,600
因此，您通过创建这些单独的 ISPC 文件来表达所有并行性。
--Now, there are other interesting things about this. 00:05:37,280 --> 00:05:41,320
现在，还有其他有趣的事情。
--So so far, I just was talking at a high level. 00:05:41,320 --> 00:05:43,880
到目前为止，我只是在高层次上谈论。
--Now let's look in a little more detail at some of the new keywords that we see in the ISPC file. 00:05:43,880 --> 00:05:52,080
现在让我们更详细地了解一下我们在 ISPC 文件中看到的一些新关键词。
--So first of all, there are a couple of variables, program count and program index. 00:05:52,080 --> 00:06:02,040
首先，有几个变量，程序计数和程序索引。
--So program count is the number of concurrent instances in the gang. 00:06:02,040 --> 00:06:09,280
所以程序计数是帮派中并发实例的数量。
--So how many things are we running in parallel? An interesting thing about ISPC is that you don't set that. 00:06:09,280 --> 00:06:17,600
那么我们并行运行了多少东西？关于 ISPC 的一个有趣的事情是你没有设置它。
--The system, the runtime system, decides what that value should be. 00:06:17,600 --> 00:06:22,640
该系统，即运行时系统，决定该值应该是什么。
--So you can read it in the software as a programmer, but you don't set that. 00:06:22,640 --> 00:06:27,920
所以你可以作为程序员在软件中读取它，但你不设置它。
--So you can see that we're looking at program count here. 00:06:27,920 --> 00:06:32,840
所以你可以看到我们在这里查看程序计数。
--So that's the total number of concurrent things, program instances. 00:06:32,840 --> 00:06:38,000
这就是并发事物、程序实例的总数。
--But sometimes you want to know, well, which instance am I specifically? And that's the point of program index. 00:06:38,000 --> 00:06:45,080
但有时你想知道，嗯，我具体是哪个实例？这就是程序索引的意义所在。
--So that program index variable tells you your instance number from 0 to n minus 1. 00:06:45,080 --> 00:06:53,780
所以那个程序索引变量告诉你你的实例号从 0 到 n 减 1。
--So if you look at the code here, you can see what it's done is we've rewritten the outer loop so that instead of incrementing it by 1, we're hopping ahead by program count. 00:06:53,780 --> 00:07:06,280
因此，如果您查看此处的代码，您可以看到它所做的是我们重写了外层循环，这样我们就不会将其递增 1，而是按程序计数向前跳跃。
--So if program count is, say, 4, then we'll be jumping ahead by 4. 00:07:06,280 --> 00:07:12,080
因此，如果程序计数是 4，那么我们将向前跳 4。
--And there will be four concurrent instances running in parallel. 00:07:12,080 --> 00:07:16,480
并且会有四个并发实例并行运行。
--And they do separate work because this index is calculated taking into account that offset, their particular program index. 00:07:16,480 --> 00:07:26,840
他们分开工作，因为这个索引是在考虑偏移量（他们的特定程序索引）的情况下计算的。
--So you can see that that's then used to access whatever data they're working on. 00:07:26,840 --> 00:07:31,560
所以你可以看到，它随后被用来访问他们正在处理的任何数据。
--So because of this, each instance is actually working on separate work. 00:07:31,560 --> 00:07:37,040
因此，每个实例实际上都在进行单独的工作。
--So one thing that I forgot to say is, what if we just took the original method, sine x, and we simply took it as is and put it into an ISPC file and called it? So what would happen then? Well, it would create program count number of concurrent instances of that code. 00:07:37,040 --> 00:08:01,120
所以我忘记说的一件事是，如果我们只是采用原始方法 sine x，我们只是按原样将其放入 ISPC 文件中并调用它会怎么样？那么会发生什么呢？好吧，它会创建该代码的并发实例的程序计数。
--But since each one of them would do exactly the same work, they would actually be entirely redundant with each other. 00:08:01,120 --> 00:08:08,680
但由于他们每个人都会做完全相同的工作，所以他们实际上完全是多余的。
--So it would not actually make the program run any faster. 00:08:08,680 --> 00:08:12,640
所以它实际上不会使程序运行得更快。
--So what you want to do to make it run faster is you have to divide up the work. 00:08:12,640 --> 00:08:16,520
所以你想做的是让它运行得更快，你必须分工。
--So that's the point of having this extra stuff in here is that we don't want each of them to do all of the work because then we don't run any faster. 00:08:16,520 --> 00:08:26,320
所以这里有这些额外的东西的意义在于我们不希望他们每个人都做所有的工作，因为这样我们就不会跑得更快。
--We have to divide it up. 00:08:26,320 --> 00:08:27,320
我们必须把它分开。
--And that's how it's working in this example. 00:08:27,320 --> 00:08:31,040
这就是它在这个例子中的工作方式。
--Now, there's one other keyword in here, which is uniform. 00:08:31,040 --> 00:08:36,640
现在，这里还有另一个关键字，它是统一的。
--And this is actually just a hint for optimization purposes. 00:08:36,640 --> 00:08:40,880
而这实际上只是出于优化目的的提示。
--What uniform means is that each program instance, if you use that as a type modifier, it means that each copy of that variable will have exactly the same value across all of the concurrent instances. 00:08:40,880 --> 00:08:55,760
统一意味着每个程序实例，如果您将其用作类型修饰符，则意味着该变量的每个副本在所有并发实例中都将具有完全相同的值。
--So there are things that do not have that. 00:08:55,760 --> 00:08:57,560
所以有些东西没有那个。
--So for example, index is not uniform because each concurrent instance is going to have a different value of index depending on what program index and i happen to be. 00:08:57,560 --> 00:09:11,400
因此，例如，索引不是统一的，因为每个并发实例将具有不同的索引值，具体取决于程序索引和 i 恰好是什么。
--OK, so any questions about that? We'll be talking more about this. 00:09:11,400 --> 00:09:16,680
好的，有什么问题吗？我们将更多地讨论这个。
--But, yep? So how is the uniform thing implemented? Is it like one actual value that they can all read? Or can they just make sure that they have separate values that update at the same time? Yep, that's a great question. 00:09:16,680 --> 00:09:34,320
但是，是吗？那么统一的东西是如何实现的呢？它就像一个他们都可以读取的实际值吗？或者他们是否可以确保它们具有同时更新的单独值？是的，这是一个很好的问题。
--So in a minute, I'm going to pull back the covers and show you this really surprising thing about how this is implemented. 00:09:34,320 --> 00:09:40,040
所以稍后，我将拉开封面，向您展示这件非常令人惊讶的事情是如何实施的。
--And then hopefully, it'll make sense why you need to bother to think about uniform because it is an unusual type of hint. 00:09:40,040 --> 00:09:47,560
然后希望，为什么你需要费心去考虑制服是有道理的，因为它是一种不寻常的暗示。
--Normally, when we're writing parallel code and many other abstractions, you do not have something like uniform. 00:09:47,560 --> 00:09:55,240
通常，当我们编写并行代码和许多其他抽象时，您没有类似统一的东西。
--But when I explain what it really does under the covers, hopefully, it'll make more sense. 00:09:55,240 --> 00:10:00,360
但是当我解释它在幕后的真正作用时，希望它会更有意义。
--And if not, we'll talk more about it then, which will be in just a few minutes here. 00:10:00,360 --> 00:10:05,680
如果没有，我们将在几分钟内详细讨论。
--OK, so as I was describing a minute ago, we're using the combination of i and program index to figure out this IDX variable. 00:10:05,680 --> 00:10:15,300
好的，正如我一分钟前所描述的，我们正在使用 i 和程序索引的组合来计算这个 IDX 变量。
--And that controls what data each concurrent instance is actually executing. 00:10:15,300 --> 00:10:20,580
这控制了每个并发实例实际执行的数据。
--And just to look at that, that style of decomposition is called interleaved. 00:10:20,580 --> 00:10:27,180
看一下，这种分解方式称为交错式。
--So just to illustrate this graphically, let's imagine that we have four program instances. 00:10:27,180 --> 00:10:34,460
因此，为了以图形方式说明这一点，让我们假设我们有四个程序实例。
--So program count would be four. 00:10:34,460 --> 00:10:36,900
所以程序数是四个。
--Now, as we're executing along, what this means is that instance 0, since its program index is 0, and since we'd be bumping up the outer loop by four at a time, it's going to be jumping ahead by four. 00:10:36,900 --> 00:10:50,020
现在，当我们继续执行时，这意味着实例 0，因为它的程序索引是 0，并且由于我们一次将外循环增加 4 个，所以它将向前跳 4 个。
--So it would start off with 0, 4, 8, and so on. 00:10:50,020 --> 00:10:54,740
所以它将以 0、4、8 等开始。
--And then the next instances would have the values after that. 00:10:54,740 --> 00:10:58,060
然后下一个实例将具有之后的值。
--So that's what interleaved looks like. 00:10:58,060 --> 00:11:02,860
这就是交错的样子。
--Now, that's not the only way to do it. 00:11:02,860 --> 00:11:04,660
现在，这不是唯一的方法。
--There's another way we can implement this. 00:11:04,660 --> 00:11:09,780
我们还有另一种方法可以实现这一点。
--So actually, I'll hold that thought for a second. 00:11:10,420 --> 00:11:13,900
所以实际上，我会暂时保留这个想法。
--So now I'm going to actually explain what's going on under the covers. 00:11:13,900 --> 00:11:17,820
所以现在我要实际解释幕后发生的事情。
--So ISPC was designed for a specific reason, which is actually to make it easier to write code that takes advantage of SIMD vector instructions. 00:11:17,820 --> 00:11:30,340
所以 ISPC 是出于特定原因而设计的，实际上是为了更容易编写利用 SIMD 矢量指令的代码。
--So you can write code with SIMD vector instructions by just sticking in these special macros or pragmas where you can say, OK, don't do an add, do a vector add, and now do a vector multiply. 00:11:30,340 --> 00:11:44,720
因此，您可以通过插入这些特殊的宏或编译指示来使用 SIMD 向量指令编写代码，您可以说，好的，不要进行加法，进行向量加法，现在进行向量乘法。
--It's a little painful to do that. 00:11:44,720 --> 00:11:46,720
这样做有点痛苦。
--So the idea is programmers have this abstraction, which is, hey, we're not writing SIMD vector code. 00:11:46,720 --> 00:11:53,520
所以这个想法是程序员有这个抽象，嘿，我们不是在写 SIMD 矢量代码。
--We're just writing plain old, more or less generic-looking concurrent code. 00:11:53,520 --> 00:11:58,840
我们只是在编写普通的、或多或少看起来通用的并发代码。
--And now the compiler will play some tricks and generate some interesting code under the covers. 00:11:58,840 --> 00:12:05,000
现在编译器会玩一些花样并在幕后生成一些有趣的代码。
--So the abstraction is that we have these program instances, which are not separate threads, it turns out. 00:12:05,000 --> 00:12:14,000
所以抽象是我们有这些程序实例，结果证明它们不是单独的线程。
--What it generates is just a single thread of execution. 00:12:14,000 --> 00:12:17,800
它生成的只是一个执行线程。
--But it uses the SIMD vector instructions to take advantage of the parallelism. 00:12:17,800 --> 00:12:23,880
但它使用 SIMD 矢量指令来利用并行性。
--So we'll look at the code in a second here. 00:12:23,880 --> 00:12:28,200
因此，我们稍后将在此处查看代码。
--And so in fact, now that I've told you that, you can probably guess what the value of program count is, which is it's the vector width of the machine, basically, taking into account the width of the data types you're operating on, basically. 00:12:28,200 --> 00:12:44,440
所以事实上，既然我已经告诉你了，你可能会猜到程序计数的值是多少，它是机器的向量宽度，基本上，考虑到你正在使用的数据类型的宽度操作，基本上。
--So that's the idea. 00:12:44,440 --> 00:12:48,440
这就是我们的想法。
--And OK, so that's what it's doing. 00:12:48,440 --> 00:12:52,920
好的，这就是它正在做的。
--And I think later, I believe I'll show you what the code looks like, maybe. 00:12:52,920 --> 00:12:57,880
我想稍后，我相信我会向您展示代码的样子，也许吧。
--Yes, we'll get to some examples where we actually see some of the code that's generated in a couple of slides. 00:12:57,880 --> 00:13:03,680
是的，我们将获得一些示例，在这些示例中，我们实际上看到了一些在几张幻灯片中生成的代码。
--But before I get to that, a minute ago, remember, I showed you the fact that this code that we've looked at so far is doing interleaved access of data. 00:13:03,680 --> 00:13:15,560
但在开始之前，请记住，一分钟前，我向您展示了一个事实，即我们目前看到的这段代码正在交错访问数据。
--Now, there's another major common option for accessing the data, which is called blocked assignment rather than interleaved assignment. 00:13:15,560 --> 00:13:23,520
现在，还有另一个访问数据的主要常用选项，称为阻塞赋值而不是交错赋值。
--So here, instead of going round robin across the data elements, you break up the data into contiguous chunks instead. 00:13:23,520 --> 00:13:32,480
所以在这里，您不是在数据元素之间进行循环，而是将数据分解成连续的块。
--So you're not interleaving. 00:13:32,480 --> 00:13:34,080
所以你没有交错。
--You're getting these chunks. 00:13:34,080 --> 00:13:36,520
你得到这些块。
--So here's what the code looks like that will do that. 00:13:36,520 --> 00:13:40,640
因此，这就是执行此操作的代码。
--So notice that the logic here is a little bit different. 00:13:40,640 --> 00:13:45,360
所以请注意这里的逻辑有点不同。
--Now, what we do is we figure out how many contiguous elements are we operating on, and for now, ignore the fact that that may not divide nicely. 00:13:45,360 --> 00:13:55,240
现在，我们要做的是弄清楚我们正在操作多少个连续的元素，现在，忽略这样一个事实，即它可能无法很好地划分。
--And then we figure out which. 00:13:55,240 --> 00:13:58,320
然后我们找出哪个。
--So basically, we're going to take this array of data, so lots and lots of elements here. 00:13:58,320 --> 00:14:04,560
所以基本上，我们将采用这个数据数组，这里有很多元素。
--And then what we do is we divide this into chunks. 00:14:04,560 --> 00:14:09,000
然后我们所做的是将其分成块。
--Like, let's say there are four chunks, because there are four program instances. 00:14:09,000 --> 00:14:15,280
比如，假设有四个块，因为有四个程序实例。
--And now, they need to know, how wide is this, and where do I start? And that's what all of this code is doing down here. 00:14:15,280 --> 00:14:24,040
现在，他们需要知道，这有多宽，我从哪里开始？这就是所有这些代码在这里所做的。
--So you figure out where you start, and you know how many of them there are. 00:14:24,040 --> 00:14:28,640
所以你弄清楚你从哪里开始，你知道有多少人。
--And then you just go ahead and have an inner loop that looks very much like the inner loop we saw before, or code inside of that, that is. 00:14:28,640 --> 00:14:38,280
然后你就可以继续创建一个内部循环，它看起来非常像我们之前看到的内部循环，或者说是其中的代码。
--All right, so these are two options. 00:14:38,280 --> 00:14:41,640
好吧，所以这是两个选择。
--Oh, and then here's what this would look like. 00:14:41,640 --> 00:14:44,120
哦，这就是它的样子。
--You saw interleaved already. 00:14:44,120 --> 00:14:45,360
你已经看到交错了。
--So in the blocked case, you hand out contiguous elements instead of interleaved elements. 00:14:45,360 --> 00:14:52,920
所以在阻塞的情况下，你分发连续的元素而不是交错的元素。
--OK, so which of these things do you think is better, blocked or interleaved? Let's see. 00:14:52,920 --> 00:15:03,880
好的，那么你认为这些东西中哪一个更好，阻塞的还是交错的？让我们来看看。
--Yeah? Depends on your data. 00:15:03,880 --> 00:15:06,160
是的？取决于你的数据。
--OK. 00:15:06,160 --> 00:15:07,440
好的。
--OK. 00:15:07,440 --> 00:15:08,600
好的。
--So do you have an example of when one or the other might be better? Or? Well, in the case of if the data set that you're working on has different amounts of work across that array, if the first one through seven take a lot more time to process the block method, it's not going to be sufficient for the interleaved method. 00:15:08,600 --> 00:15:32,680
那么，您是否有一个例子说明什么时候一个或另一个可能更好？或者？好吧，如果您正在处理的数据集在该数组中有不同的工作量，如果第一个到第七个需要更多时间来处理 block 方法，这将不足以满足交错法。
--That's when you get, you spread out the hard work between the computations that you get. 00:15:32,680 --> 00:15:40,920
那就是当你得到的时候，你在你得到的计算之间分散了艰苦的工作。
--Yeah, so speaking generically, not necessarily for this specific code that we're looking at, but a common disadvantage of blocked assignment is if the computation time, say, scales with the index into the data, let's say it's like n squared time or something, and it gets more and more expensive. 00:15:40,920 --> 00:16:00,440
是的，所以一般来说，不一定是我们正在查看的这个特定代码，但是阻塞赋值的一个常见缺点是，如果计算时间，比如说，随着数据的索引缩放，假设它就像 n 平方时间或一些东西，它变得越来越昂贵。
--If I divide this into even chunks, it may be that the one way over on the left has very little computation to do, and the one way over on the right has a whole lot of computation to do. 00:16:00,440 --> 00:16:11,000
如果我把它分成均匀的块，可能是左边的一种方式需要做的计算很少，而右边的一种方式需要做很多计算。
--So for that reason, interleaving tends to be a little less risky if you have contiguous properties in terms of how long the computation takes. 00:16:11,000 --> 00:16:22,080
因此，出于这个原因，如果您在计算所需的时间方面具有连续的属性，则交错的风险往往会小一些。
--So that's a potential advantage of blocked. 00:16:22,080 --> 00:16:24,360
所以这是阻塞的潜在优势。
--Any other thoughts? The block will, each instance will access data that's near each other. 00:16:24,360 --> 00:16:30,240
还有其他想法吗？该块将，每个实例将访问彼此靠近的数据。
--You have better locality, then you will have better cache performance. 00:16:30,240 --> 00:16:33,640
你有更好的局部性，那么你就会有更好的缓存性能。
--If you know the computation for each array element, it's going to be pretty even across the entire array. 00:16:33,640 --> 00:16:41,600
如果您知道每个数组元素的计算，那么它在整个数组中的计算会非常均匀。
--Yeah, so another thing about, as you learned from 2.13, spatial locality is good for caches. 00:16:41,640 --> 00:16:49,040
是的，还有一件事，正如您从 2.13 中学到的，空间局部性对缓存很有用。
--So one thing when we look at this picture is accessing contiguous data, that sounds more cache friendly. 00:16:49,040 --> 00:16:56,080
所以当我们看这张图片时，有一件事是访问连续数据，这听起来对缓存更友好。
--And in fact, for most, in many situations, that would be a valid argument. 00:16:56,080 --> 00:17:02,440
事实上，对于大多数人来说，在许多情况下，这都是一个有效的论点。
--It turns out in a case of ISPC, that's not really very compelling because it's just one thread, and we're going to kind of look at some details about that. 00:17:02,440 --> 00:17:12,440
事实证明，在 ISPC 的情况下，这并不是很有吸引力，因为它只是一个线程，我们将要看一些关于它的细节。
--But in general, if you had separate threads and they were accessing data in separate caches, then normally blocked would have a big advantage from spatial locality. 00:17:12,440 --> 00:17:22,280
但一般来说，如果您有单独的线程并且它们在单独的缓存中访问数据，那么通常阻塞将从空间局部性中获得很大优势。
--Any other thoughts? So it turns out that for ISPC, there actually is a very clear winner between blocked and interleaved. 00:17:22,280 --> 00:17:29,240
还有其他想法吗？所以事实证明，对于 ISPC，分块和交错之间实际上有一个非常明显的赢家。
--It's really not, it's not close. 00:17:29,240 --> 00:17:32,360
真的不是，不是很近。
--And it's not for any of the reasons I've heard so far. 00:17:32,360 --> 00:17:34,920
而且这不是出于我目前所听到的任何原因。
--Oh, yeah? Interleaved, like typically what happens is that instance is 1, 2, 3 executed simultaneously. 00:17:34,920 --> 00:17:41,300
哦耶？交错，通常发生的情况是实例 1、2、3 同时执行。
--So if it's interleaved, then you're actually taking away a bunch of words. 00:17:41,300 --> 00:17:45,980
所以如果它是交错的，那么你实际上是在拿走一堆单词。
--Yes, that's right. 00:17:45,980 --> 00:17:47,060
恩，那就对了。
--So in fact, and that actually has a big, that's the root cause of the big advantage for ISPC. 00:17:47,060 --> 00:17:54,780
所以事实上，这实际上有很大的优势，这是 ISPC 的巨大优势的根本原因。
--So if we look at this over time, what happens is, so in the pictures I showed you before, I was actually showing you what it looks like from the perspective of a particular program instance. 00:17:54,780 --> 00:18:07,340
所以如果我们随着时间的推移看这个，会发生什么，所以在我之前给你看的图片中，我实际上是从一个特定的程序实例的角度向你展示它的样子。
--But if we think about what's happening in time, in the interleaved case, the first four iterations, 0 through 3, they are being computed on by a vector, by one vector instruction. 00:18:07,340 --> 00:18:20,580
但是如果我们考虑及时发生的事情，在交错的情况下，前四次迭代，0 到 3，它们是由一个向量计算的，一个向量指令。
--And so that's what's happening at any moment in time. 00:18:20,580 --> 00:18:25,580
这就是随时发生的事情。
--So we actually march along like this. 00:18:25,580 --> 00:18:29,060
所以我们实际上是这样前进的。
--OK, that's interleaved. 00:18:29,060 --> 00:18:31,100
好的，那是交错的。
--And if we look at now, what's nice about that is when I want to bring that data into the register, the vector register to operate on it, the data that I want for the vector happens to be contiguous in memory. 00:18:31,100 --> 00:18:46,940
如果我们现在看，当我想将该数据放入寄存器，向量寄存器对其进行操作时，这有什么好处，我想要的向量数据恰好在内存中是连续的。
--And there are vector load instructions that will bring in big chunks of data. 00:18:46,940 --> 00:18:52,420
并且有矢量加载指令将引入大块数据。
--And they work really well as long as the data you're bringing in is contiguous already. 00:18:52,420 --> 00:18:57,060
只要您引入的数据已经连续，它们就可以很好地工作。
--So with one vector load, essentially the cost of one load operation, we can bring in all of that data. 00:18:57,060 --> 00:19:03,380
因此，通过一次矢量加载，基本上是一次加载操作的成本，我们可以引入所有这些数据。
--In fact, if the vector is wider than this, if it has 8 or 16 elements, we could bring it all in in basically one cycle, assuming it hits in the cache. 00:19:03,380 --> 00:19:12,380
事实上，如果向量比这更宽，如果它有 8 或 16 个元素，我们基本上可以在一个周期内将其全部放入，假设它命中缓存。
--Now, if you compare that with blocked, this is what happens with blocked. 00:19:12,380 --> 00:19:17,700
现在，如果您将其与阻塞进行比较，这就是阻塞所发生的情况。
--Now, although from the perspective of a particular instance, things look like they're contiguous, that's not what's happening in time. 00:19:17,700 --> 00:19:25,460
现在，尽管从特定实例的角度来看，事情看起来是连续的，但这并不是时间上发生的事情。
--In time, now we're jumping across different elements. 00:19:25,460 --> 00:19:29,500
随着时间的推移，现在我们正在跨越不同的元素。
--We need to load 0, 4, 8, and 12 all at once. 00:19:29,500 --> 00:19:34,260
我们需要同时加载 0、4、8 和 12。
--Now, OK, what do you think happens in the hardware for that? So it turns out there is an instruction that will allow you to do this. 00:19:34,260 --> 00:19:47,140
现在，好吧，你认为硬件会发生什么？所以事实证明有一条指令可以让你这样做。
--There's a vector gather instruction that lets you load lots of non-contiguous data into one vector with one instruction. 00:19:47,140 --> 00:19:56,780
有一个向量收集指令，可让您使用一条指令将大量非连续数据加载到一个向量中。
--But how long does that take, do you think? Does it take one cycle? For those of you who are EEs, or if you've studied much about hardware, that's not going to be anywhere near as fast as doing the vector load. 00:19:56,780 --> 00:20:13,420
但你认为这需要多长时间？需要一个周期吗？对于那些 EE 的人，或者如果你对硬件有很多研究，那不会像矢量加载那样快。
--Because what the hardware really has to do is effectively the moral equivalent of 4 or 8 or however many separate loads. 00:20:13,420 --> 00:20:21,340
因为硬件真正要做的实际上是道德上等同于 4 或 8 或许多单独的负载。
--So it appears to be one instruction from the assembly language programmer's point of view, but performance-wise, this is a costly thing to do. 00:20:21,340 --> 00:20:29,540
因此，从汇编语言程序员的角度来看，它似乎是一条指令，但就性能而言，这是一件代价高昂的事情。
--So for that reason, interleaved is actually much faster in this case. 00:20:29,540 --> 00:20:34,460
因此，出于这个原因，交错在这种情况下实际上要快得多。
--So that's surprising. 00:20:34,460 --> 00:20:35,500
所以这很令人惊讶。
--That's a case where, because of what we're doing, because it's targeting SIMD vector instructions, that was the clear winner. 00:20:35,500 --> 00:20:43,540
在这种情况下，由于我们正在做的事情，因为它针对 SIMD 向量指令，所以它是明显的赢家。
--OK, now you might look at that and say, it's not fun to have to write all that low-level code to specify blocked or interleaved. 00:20:43,540 --> 00:20:53,580
好的，现在您可能会说，必须编写所有低级代码来指定阻塞或交错并不有趣。
--And what if I pick one and get it wrong? That's a shame. 00:20:53,580 --> 00:20:57,140
如果我选错了一个怎么办？太可惜了。
--Wouldn't it be nice if this clever compiler and language could just figure this out for me? So that's the idea of another primitive, which is called forEach. 00:20:57,140 --> 00:21:09,500
如果这个聪明的编译器和语言可以为我解决这个问题，那不是很好吗？这就是另一个原语的想法，称为 forEach。
--So forEach is essentially, it's like a for loop, but you're handing over control of the assignment of the loop iterations to the system. 00:21:09,500 --> 00:21:20,220
所以 forEach 本质上就像一个 for 循环，但是您将循环迭代分配的控制权移交给了系统。
--So what you're telling the system is, you can execute these iterations in parallel. 00:21:20,220 --> 00:21:25,460
所以你告诉系统的是，你可以并行执行这些迭代。
--And you figure out the order in which you want to do that. 00:21:25,460 --> 00:21:29,620
然后你弄清楚你想要这样做的顺序。
--So since the computations are independent for each value of i in the outer loop, we can do them in any order. 00:21:29,620 --> 00:21:37,980
因此，由于计算对于外循环中 i 的每个值都是独立的，因此我们可以按任何顺序进行计算。
--And so we'll let the system choose. 00:21:37,980 --> 00:21:40,340
所以我们会让系统选择。
--So from the programmer's point of view, they're just pointing out the source of parallelism, and they're letting the language synthesize the code. 00:21:40,340 --> 00:21:48,460
所以从程序员的角度来看，他们只是指出并行性的来源，他们让语言综合代码。
--And in the case of ISPC, what it'll do is it'll synthesize the interleaved code that we saw earlier, the first code that we saw in this case, because of the loading of vectors. 00:21:48,460 --> 00:21:58,340
在 ISPC 的情况下，它将做的是合成我们之前看到的交错代码，这是我们在这种情况下看到的第一个代码，因为加载了向量。
--So just to recap what we saw so far, so there's an abstraction, which is that it looks like we have almost conventional single program multiple data parallelism, where we say, OK, here's a procedure. 00:22:02,780 --> 00:22:18,300
所以只是回顾一下我们到目前为止所看到的，所以有一个抽象，看起来我们有几乎传统的单程序多数据并行性，我们说，好的，这是一个过程。
--And instances of that will be executed in parallel. 00:22:18,300 --> 00:22:22,300
并且该实例将并行执行。
--But in fact, the implementation of it was SIMD vector instructions, where there only is one thread of control. 00:22:22,300 --> 00:22:29,500
但实际上，它的实现是SIMD向量指令，这里只有一个控制线程。
--And the concurrency is coming only from these vector instructions. 00:22:29,500 --> 00:22:33,580
并发性仅来自这些矢量指令。
--And it's saving us the headache of having to insert all those macros and think about all those low-level details. 00:22:33,580 --> 00:22:40,020
它让我们免于不得不插入所有这些宏并考虑所有这些低级细节的麻烦。
--So before we move on, though, just to maybe test your understanding of this a little bit, what happens in the case where we want to do a reduction in ISPC? So here, this is a different procedure, where what we want to do is just add up all the values in an array. 00:22:43,660 --> 00:23:01,980
因此，在我们继续之前，也许只是为了稍微测试一下您对此的理解，如果我们想要减少 ISPC，会发生什么情况？所以在这里，这是一个不同的过程，我们想要做的只是将数组中的所有值相加。
--So we want to calculate this sum and return that sum. 00:23:01,980 --> 00:23:07,460
所以我们要计算这个总和并返回那个总和。
--OK, now, interesting thing about this is so, well, in fact, the sum that we get back, everyone should agree on the sum, right? The return value, which is the answer, should be one thing. 00:23:07,460 --> 00:23:25,780
好吧，有趣的是，事实上，我们得到的总和，每个人都应该就总和达成一致，对吧？返回值，也就是答案，应该是一回事。
--So maybe we want to stick the type modifier uniform in front of the declaration of sum. 00:23:25,780 --> 00:23:31,900
所以也许我们想在 sum 的声明前加上类型修饰符 uniform。
--It turns out that if you do that and try to compile it, ISPC will say this is a compilation error. 00:23:31,900 --> 00:23:36,660
事实证明，如果您这样做并尝试编译它，ISPC 会说这是一个编译错误。
--You can't do that. 00:23:36,660 --> 00:23:38,340
你不能那样做。
--So why is that? Yeah? So what the, yeah? You're having multiple, this is just trying to access the same value at once. 00:23:38,340 --> 00:23:49,900
那是为什么呢？是的？那是什么，是吗？你有多个，这只是试图一次访问相同的值。
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
--So the problem is that x sub i, the thing they're trying to add into it, this is definitely not uniform for every instance. 00:23:58,420 --> 00:24:07,420
所以问题是 x sub i，他们试图添加到其中的东西，这绝对不是对每个实例都是统一的。
--They're all reading different values. 00:24:07,420 --> 00:24:09,620
他们都在阅读不同的价值观。
--So if you're trying to concurrently add all these things into it, that would, if you just did something naive here, it would break. 00:24:09,620 --> 00:24:18,300
因此，如果您尝试同时将所有这些东西添加到其中，那么，如果您只是在这里做了一些幼稚的事情，它就会崩溃。
--So here's code that would work in ISPC, where you're trying to do essentially the same thing, where what you need to do instead is you're going to calculate partial sums. 00:24:18,300 --> 00:24:29,380
所以这里是可以在 ISPC 中工作的代码，在这里您尝试做基本相同的事情，您需要做的是计算部分和。
--So each instance is going to first have a loop where it calculates its portion of the total sum. 00:24:29,380 --> 00:24:36,780
所以每个实例都会首先有一个循环，它计算它在总和中的部分。
--And those are not uniform. 00:24:36,780 --> 00:24:38,020
那些并不统一。
--Those are different for each instance. 00:24:38,020 --> 00:24:40,180
这些对于每个实例都是不同的。
--And after we do that, then we will put them together into the final answer. 00:24:40,180 --> 00:24:44,620
在我们这样做之后，我们将把它们放在一起成为最终答案。
--But we'll use a special ISPC primitive called reduce add, which allows us to take a set of different values and turn them into a value that ought to be uniform across all the threads ultimately. 00:24:44,620 --> 00:24:59,420
但是我们将使用一种称为 reduce add 的特殊 ISPC 原语，它允许我们采用一组不同的值并将它们转换为最终应该在所有线程中统一的值。
--OK. 00:24:59,420 --> 00:25:00,220
好的。
--So that would work. 00:25:00,220 --> 00:25:02,460
这样就可以了。
--And in fact, for fun, I'm not going to spend time going through all the details of this. 00:25:02,460 --> 00:25:06,260
事实上，为了好玩，我不会花时间详细介绍这一切。
--But here's an example of what that actually compiles into. 00:25:06,260 --> 00:25:09,900
但这里有一个实际编译成的例子。
--So here, well, first of all, what you can see is here are these vector instructions, like adds and loads and stores and things like that. 00:25:09,900 --> 00:25:21,460
所以在这里，嗯，首先，你可以在这里看到这些向量指令，比如添加、加载、存储等等。
--So up here, what we're seeing is the first part up here. 00:25:21,460 --> 00:25:27,220
所以在这里，我们看到的是这里的第一部分。
--So that's basically this loop. 00:25:27,220 --> 00:25:29,380
所以这基本上就是这个循环。
--And then down here in the bottom, this is the reduction. 00:25:29,380 --> 00:25:35,300
然后在底部，这是减少。
--And notice the reduction is actually not using vector instructions, because what it's doing is it's just adding up all the elements of a vector using conventional instructions. 00:25:35,300 --> 00:25:45,340
请注意，归约实际上并没有使用向量指令，因为它所做的只是使用常规指令将向量的所有元素相加。
--But that gets the right value. 00:25:45,340 --> 00:25:47,540
但这得到了正确的价值。
--OK. 00:25:47,540 --> 00:25:48,020
好的。
--So that's ISPC. 00:25:48,020 --> 00:25:51,580
这就是 ISPC。
--So OK, last thing to say about ISPC is that the size of a gang. 00:25:51,580 --> 00:26:04,580
好吧，关于 ISPC，最后要说的是帮派的规模。
--So the program count variable is set by the system. 00:26:04,580 --> 00:26:08,940
所以程序计数变量是由系统设置的。
--And it's usually the vector width. 00:26:08,940 --> 00:26:11,820
它通常是矢量宽度。
--But many machines have more than one core on them. 00:26:11,820 --> 00:26:15,820
但是很多机器上面都有不止一个核心。
--So if I wanted to run parallel code using ISPC and I have multiple cores, the code I've shown you so far would actually only run on one core. 00:26:15,820 --> 00:26:24,460
因此，如果我想使用 ISPC 运行并行代码并且我有多个内核，那么到目前为止我向您展示的代码实际上只能在一个内核上运行。
--And it wouldn't take advantage of any of those other cores. 00:26:24,460 --> 00:26:27,260
而且它不会利用任何其他核心。
--So ISPC has another piece of their mechanism, which is you can create a task. 00:26:27,260 --> 00:26:34,340
所以 ISPC 有另外一个机制，就是你可以创建一个任务。
--And a task is a thread of control that can run on different cores. 00:26:34,340 --> 00:26:42,540
而一个任务就是一个可以运行在不同内核上的控制线程。
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
--Next, we're going to move on and talk about several other important parallel programming abstractions. 00:26:53,020 --> 00:26:59,860
接下来，我们将继续讨论其他几个重要的并行编程抽象。
--So we're going to talk about the abstraction from the programmer's point of view. 00:26:59,860 --> 00:27:05,820
所以我们要从程序员的角度来谈谈抽象。
--And I'm also going to talk about some examples of machines that support these abstractions. 00:27:05,820 --> 00:27:12,940
我还将讨论一些支持这些抽象的机器示例。
--And the things that are really different in parallel processing are that we have to have the concurrent instances of code communicate and cooperate with each other. 00:27:12,940 --> 00:27:27,780
并行处理中真正不同的是，我们必须让代码的并发实例相互通信和协作。
--So that's what we're going to focus on when we talk about these abstractions. 00:27:27,780 --> 00:27:31,400
所以当我们谈论这些抽象时，这就是我们要关注的。
--What part of the abstraction do you use to talk about how you communicate and cooperate? OK. 00:27:31,400 --> 00:27:38,000
您使用抽象的哪一部分来谈论您如何沟通和合作？好的。
--So all right. 00:27:38,000 --> 00:27:40,160
所以好吧。
--So how do we implement an abstraction? So abstractions could be implemented through software or hardware or both. 00:27:40,160 --> 00:27:50,560
那么我们如何实现抽象呢？所以抽象可以通过软件或硬件或两者来实现。
--And in fact, software is not just one thing. 00:27:50,560 --> 00:27:53,440
事实上，软件不仅仅是一回事。
--There are layers to our software stack. 00:27:53,440 --> 00:27:56,120
我们的软件栈有很多层。
--So for example, you're writing in some high-level language. 00:27:56,120 --> 00:28:02,600
因此，例如，您正在使用某种高级语言编写。
--And you have a compiler and runtime and some libraries that are taking the source code and turning it into something to execute. 00:28:02,600 --> 00:28:10,840
你有一个编译器和运行时以及一些库，它们正在获取源代码并将其转化为可执行的东西。
--That's running on top of an operating system, which is software, which is running on top of hardware. 00:28:10,840 --> 00:28:17,400
它运行在操作系统之上，也就是运行在硬件之上的软件。
--OK. 00:28:17,400 --> 00:28:17,920
好的。
--So just as some examples of how these things can be done very differently, let's start by looking at P threads. 00:28:17,920 --> 00:28:25,280
因此，就像这些事情如何以不同方式完成的一些示例一样，让我们从查看 P 线程开始。
--So you're familiar with P threads already from 2013, I think. 00:28:25,320 --> 00:28:29,040
所以我想您从 2013 年就已经熟悉 P 线程了。
--So P thread, you can create a new thread. 00:28:29,040 --> 00:28:34,920
所以P线程，可以新建一个线程。
--And so how is that implemented? Well, there is a library call into P thread create. 00:28:34,920 --> 00:28:43,240
那是如何实施的呢？嗯，有一个库调用 P 线程创建。
--And that's implemented somehow. 00:28:43,240 --> 00:28:45,680
这是以某种方式实施的。
--There's usually some kernel support for that. 00:28:45,680 --> 00:28:48,000
通常有一些内核支持。
--So the kernel needs to know that you've created this if you want it to run on a different core. 00:28:48,000 --> 00:28:53,800
因此，如果您希望它在不同的内核上运行，内核需要知道您已经创建了它。
--So that's something that the operating system knows about. 00:28:53,840 --> 00:28:57,200
所以这是操作系统知道的事情。
--And then the operating system is already managing execution of things on different cores. 00:28:57,200 --> 00:29:02,480
然后操作系统已经在管理不同内核上的执行。
--So it's already talking to the hardware to make that work. 00:29:02,480 --> 00:29:05,800
所以它已经在与硬件对话以使其工作。
--So in the case of P threads, really a lot of it is happening at the library level and the kernel level. 00:29:05,800 --> 00:29:14,280
所以在 P 线程的情况下，确实有很多是在库级别和内核级别发生的。
--But in the case of ISPC, the compiler, the operating system is actually not involved normally because what we do is the compiler simply generates vector instructions. 00:29:14,280 --> 00:29:27,760
但是在 ISPC 的情况下，编译器，操作系统实际上并没有正常参与，因为我们所做的只是编译器简单地生成向量指令。
--And these are just directly executed. 00:29:27,760 --> 00:29:29,520
而这些只是直接执行。
--And the hardware will simply go ahead and do them in parallel. 00:29:29,520 --> 00:29:33,240
硬件将简单地继续并并行执行它们。
--And we don't have to get any special libraries or the kernel involved to do that, just the compiler. 00:29:33,240 --> 00:29:38,480
而且我们不需要任何特殊的库或涉及的内核来做到这一点，只需要编译器。
--So the compiler did all the heavy lifting in that case. 00:29:38,480 --> 00:29:43,720
所以编译器在那种情况下完成了所有繁重的工作。
--So that's something to keep in mind, which is that these abstractions can be implemented through different combinations of hardware and software and different parts of the stack. 00:29:43,720 --> 00:29:53,560
所以要记住这一点，即这些抽象可以通过硬件和软件的不同组合以及堆栈的不同部分来实现。
--OK, so now, actually, I think I'm going to take an intermission break now. 00:29:53,560 --> 00:30:00,720
好的，所以现在，实际上，我想我现在要休息一下。
--So I like to stop in the middle for a minute or two. 00:30:00,720 --> 00:30:04,640
所以我喜欢在中间停一两分钟。
--So we're not quite at the halfway point, but I'm about to launch into a lot of stuff here. 00:30:04,640 --> 00:30:09,400
所以我们还没有走到一半，但我将在这里开始做很多事情。
--So we'll take a two-minute intermission break. 00:30:09,400 --> 00:30:12,320
所以我们将进行两分钟的中场休息。
--So don't leave the room. 00:30:12,320 --> 00:30:13,960
所以不要离开房间。
--But you can stand up and move around and get the blood flowing to your brain again. 00:30:13,960 --> 00:30:17,840
但是你可以站起来走动，让血液再次流向你的大脑。
--And then we'll start up after that. 00:30:17,840 --> 00:30:19,300
然后我们会在那之后开始。
--Yeah, does ISPCs task with your ISP threads now? Yeah, probably, yeah. 00:30:20,300 --> 00:30:28,980
是的，现在 ISPC 是否与您的 ISP 线程一起工作？是的，可能是的。
--Yeah. 00:30:28,980 --> 00:30:30,540
是的。
--Yeah. 00:30:49,300 --> 00:30:50,860
是的。
--Yeah. 00:31:19,300 --> 00:31:20,860
是的。
--OK, so now we're going to discuss three abstractions for parallel programming, shared address space, message passing, and data parallel. 00:31:49,300 --> 00:32:07,180
好的，现在我们将讨论并行编程、共享地址空间、消息传递和数据并行的三个抽象。
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
--So the idea here, the way to think about this from the programmer's point of view is that the way that you're now, I'm going to actually go ahead and use the word threads because I'm just used to saying that. 00:32:28,340 --> 00:32:40,700
所以这里的想法，从程序员的角度来思考这个问题的方式就是你现在的方式，我将继续使用线程这个词，因为我习惯于这么说。
--So the way that the threads interact with each other is that the whole machine has a common address space. 00:32:40,700 --> 00:32:50,020
所以线程相互交互的方式是整个机器有一个共同的地址空间。
--So if threads want to communicate, they can read and write the same memory when they choose to. 00:32:50,020 --> 00:32:57,340
因此，如果线程想要通信，它们可以在选择时读取和写入相同的内存。
--And they can also choose to have private variables and access just their own data. 00:32:57,340 --> 00:33:01,740
他们还可以选择拥有私有变量并只访问他们自己的数据。
--But when they want to cooperate and communicate, they do it by reading and writing the same data. 00:33:01,740 --> 00:33:08,260
但是当他们想要合作和交流时，他们通过读写相同的数据来实现。
--And this is a little bit like if you were trying to work together with friends and you were standing in front of a whiteboard, and the way that you communicated was you wrote things on the whiteboard and then other people could look at those things on the whiteboard and read them. 00:33:08,260 --> 00:33:22,140
这有点像如果你想和朋友一起工作，你站在白板前，你交流的方式是你在白板上写东西，然后其他人可以在白板上看这些东西白板并阅读它们。
--That's a little bit like what it's like. 00:33:22,140 --> 00:33:25,100
这有点像它的样子。
--Now, a thing about this is this is actually very similar. 00:33:25,100 --> 00:33:29,580
现在，关于这一点的一点是，这实际上非常相似。
--And this is the smallest change. 00:33:29,580 --> 00:33:32,340
这是最小的变化。
--Of all of the abstractions we're going to talk about, this is most similar to just conventional sequential programming. 00:33:32,340 --> 00:33:41,620
在我们将要讨论的所有抽象中，这与传统的顺序编程最相似。
--Because in the normal case, when we have different procedures, when different parts of your code are interacting with each other, how do they do that? Well, they do it by reading and writing data in the address space. 00:33:41,620 --> 00:33:53,180
因为在正常情况下，当我们有不同的程序时，当代码的不同部分相互交互时，它们是如何做到的？好吧，他们通过在地址空间中读写数据来做到这一点。
--So that should seem very familiar. 00:33:53,180 --> 00:33:57,500
所以这应该看起来很熟悉。
--OK, all right, so the communication part is really easy in the shared address space case because you can always communicate by reading and writing the same data. 00:33:57,500 --> 00:34:10,260
好的，好的，所以在共享地址空间的情况下，通信部分真的很容易，因为您始终可以通过读取和写入相同的数据来进行通信。
--The wrinkle, though, is synchronization. 00:34:10,260 --> 00:34:13,780
然而，问题在于同步。
--So how do you know when the data that you want is there? So for example, if I just read an address in memory, how do I know whether I got the up-to-date copy of the value or I got an old out-of-date copy of the value? Usually, that's the part that requires some extra work. 00:34:13,780 --> 00:34:33,940
那么你怎么知道你想要的数据何时存在呢？因此，例如，如果我只是读取内存中的一个地址，我怎么知道我得到的是值的最新副本还是值的旧副本？通常，这是需要一些额外工作的部分。
--So for example, so that's one type of synchronization is knowing whether something is ready to be read. 00:34:33,940 --> 00:34:41,220
因此，例如，这是一种同步类型，它知道是否准备好读取某些内容。
--Another type of synchronization is around mutual exclusion. 00:34:41,220 --> 00:34:45,060
另一种类型的同步是围绕互斥的。
--So for example, if we are incrementing a variable, if two concurrent threads simultaneously try to increment the same variable, then you can end up with the wrong answer because they both read the initial value. 00:34:45,060 --> 00:34:59,540
因此，例如，如果我们正在递增一个变量，如果两个并发线程同时尝试递增同一个变量，那么您可能会得到错误的答案，因为它们都读取了初始值。
--Then in their registers, they increment that, and then they store back an updated value, but you just lost one of the increments, potentially. 00:34:59,540 --> 00:35:07,820
然后在他们的寄存器中，他们增加它，然后他们存储回一个更新的值，但你可能只是丢失了一个增量。
--So if you've taken 4.10, or if you take 4.10, you'll spend a lot of time thinking about that problem because that shows up a lot in kernels. 00:35:07,820 --> 00:35:17,700
所以如果你已经学了 4.10，或者如果你学了 4.10，你会花很多时间思考这个问题，因为它在内核中经常出现。
--OK, so the idea is you just communicate by reading and writing shared variables. 00:35:17,700 --> 00:35:26,380
好的，所以这个想法是你只是通过读写共享变量来进行交流。
--And the extra work that you do is adding things like locks and other types of synchronization. 00:35:26,380 --> 00:35:32,420
您所做的额外工作是添加诸如锁和其他类型的同步之类的东西。
--So in a future lecture, soon, we'll look at real examples of code written in this style. 00:35:32,420 --> 00:35:38,420
所以在以后的讲座中，我们很快就会看到用这种风格编写的代码的真实例子。
--And what you'll see is a lot of the extra code that shows up is all due to the synchronization primitives. 00:35:38,420 --> 00:35:44,660
你会看到很多额外的代码都是由于同步原语而出现的。
--Now, I said that the idea is that we have a common address space. 00:35:48,940 --> 00:35:55,900
现在，我说的是我们有一个共同的地址空间。
--So how do you think this might be implemented in the hardware? So one way to do it is to physically share the same memory. 00:35:55,900 --> 00:36:06,060
那么您认为这可能如何在硬件中实现？因此，一种方法是在物理上共享相同的内存。
--So in fact, in the early days of these kinds of machines, this is how everybody thought of the problem, which is we have memory. 00:36:06,060 --> 00:36:14,380
所以其实早期这种机器，大家是这么想的，就是我们有记忆这个问题。
--So memory is sitting here. 00:36:14,380 --> 00:36:16,300
所以记忆就在这里。
--And we have something like a bus or some other kind of interconnect. 00:36:16,300 --> 00:36:20,380
我们有总线或其他类型的互连。
--And then we have more than one processor plugged into this bus, or whatever it is. 00:36:20,380 --> 00:36:25,380
然后我们有不止一个处理器插入这条总线，或者不管它是什么。
--And then they can all go and access memory. 00:36:25,380 --> 00:36:28,620
然后他们都可以去访问内存。
--Well, for what it's worth also, this is also called sometimes a dance hall architecture. 00:36:33,260 --> 00:36:38,380
好吧，就其价值而言，这有时也被称为舞厅建筑。
--You may wonder, what does it have to do with dancing? And the inspiration was this is like a middle school dance where everybody's lined up on the edge of the room and nobody's in the middle. 00:36:38,380 --> 00:36:51,180
你可能想知道，这和跳舞有什么关系？灵感是这就像一场中学舞会，每个人都排在房间的边缘，没有人在中间。
--So all the processors are on one side, all the memory is on the other side. 00:36:51,180 --> 00:36:55,020
所以所有的处理器都在一侧，所有的内存都在另一侧。
--That's where that term comes from. 00:36:55,020 --> 00:36:56,820
这就是该术语的来源。
--But the thing that it's actually also called is symmetric multiprocessing in the sense that each processor is equally far away from memory. 00:36:56,820 --> 00:37:05,380
但它实际上也被称为对称多处理，因为每个处理器离内存的距离都相等。
--Memory is not closer to any processor than any other processor. 00:37:05,380 --> 00:37:09,300
内存并不比任何其他处理器更靠近任何处理器。
--Now, that may sound like a good thing. 00:37:09,300 --> 00:37:11,660
现在，这听起来像是一件好事。
--But I'm going to come back to that in a minute. 00:37:11,660 --> 00:37:13,980
但我会在一分钟内回到那个。
--So yeah, it's equally bad for everybody is one way to think of it. 00:37:13,980 --> 00:37:19,060
所以，是的，这对每个人都同样不利，这是一种思考方式。
--OK, so now an interesting part of the hardware, if you want to design something this way, where everything is the same distance from memory, is, well, how do you make the interconnect that connects processors to memory, how does that continue to be fast as we add more and more processors and more and more memory modules? So a really inexpensive kind of interconnect is just a bus. 00:37:19,060 --> 00:37:42,740
好的，现在硬件的一个有趣的部分，如果你想以这种方式设计一些东西，其中一切都与内存的距离相同，那么，你如何制作将处理器连接到内存的互连，它如何继续随着我们添加越来越多的处理器和越来越多的内存模块，速度会更快吗？因此，一种真正便宜的互连就是总线。
--But only one thing can be on the bus at a time. 00:37:42,740 --> 00:37:45,300
但是一次只能有一件事在公共汽车上。
--So that obviously doesn't have scalable bandwidth. 00:37:45,300 --> 00:37:48,580
所以这显然没有可扩展的带宽。
--So later, we'll have a whole lecture on how you build scalable interconnects. 00:37:48,580 --> 00:37:52,300
所以稍后，我们将有一个关于如何构建可扩展互连的完整讲座。
--I'm not going to really get into that now. 00:37:52,300 --> 00:37:54,500
我现在不打算真正进入那个。
--There are fancier things that you can do. 00:37:54,660 --> 00:37:56,820
您可以做一些更有趣的事情。
--But they start to get more and more expensive. 00:37:56,820 --> 00:38:00,660
但它们开始变得越来越昂贵。
--OK, so if we look at real hardware, so where do we see this approach to building a shared address space? Well, first of all, on a modern processor, you have, say, four cores. 00:38:00,660 --> 00:38:16,180
好的，那么如果我们看一下真实的硬件，那么我们在哪里可以看到这种构建共享地址空间的方法呢？好吧，首先，在现代处理器上，你有四个内核。
--Let me pick a different color here. 00:38:16,180 --> 00:38:17,780
让我在这里选择不同的颜色。
--So we've got, say, four cores. 00:38:17,780 --> 00:38:20,220
所以我们有四个核心。
--And they all physically share the same cache. 00:38:20,220 --> 00:38:24,180
它们都在物理上共享相同的缓存。
--In that case, at least to get to that cache, that is shared by all the different cores equally. 00:38:25,180 --> 00:38:32,100
在那种情况下，至少要获得由所有不同内核平等共享的缓存。
--So that's one way that you can design things like this. 00:38:32,100 --> 00:38:37,340
所以这是你可以设计这样的东西的一种方式。
--And AMD has other processors that are a bit like this. 00:38:37,340 --> 00:38:41,300
 AMD 还有其他类似的处理器。
--Now, this is a different processor. 00:38:41,300 --> 00:38:43,460
现在，这是一个不同的处理器。
--This is the Sun Niagara 2. 00:38:43,460 --> 00:38:45,020
这是 Sun Niagara 2。
--This is designed to support lots and lots of latency-tolerant tasks. 00:38:45,020 --> 00:38:51,380
这是为了支持大量的延迟容忍任务而设计的。
--So they had far more processors here. 00:38:51,380 --> 00:38:54,100
所以他们在这里有更多的处理器。
--They have eight processors. 00:38:54,100 --> 00:38:56,580
他们有八个处理器。
--But in order to connect eight things to lots of other things, they had to have a fancier interconnect. 00:38:56,580 --> 00:39:01,820
但是为了将八个东西连接到许多其他东西，他们必须有一个更奇特的互连。
--And what you can notice on the die is that interconnect is starting to get non-trivially large. 00:39:01,820 --> 00:39:06,740
您可以在裸片上注意到互连开始变得非常大。
--It's almost as large as one of the processors. 00:39:06,740 --> 00:39:09,860
它几乎和其中一个处理器一样大。
--OK, so simply trying to build, so building a large machine with, say, about hundreds or thousands of processors in it and having them all be equally far away from memory turns out to be really hard. 00:39:09,860 --> 00:39:23,540
好的，所以简单地尝试构建，因此构建一个大型机器，其中包含大约数百或数千个处理器，并且让它们都离内存同样远，结果证明真的很难。
--So the way to get around that problem is to give up on the idea of everybody being equally close to all of the memory. 00:39:23,540 --> 00:39:33,340
所以解决这个问题的方法是放弃每个人都同样接近所有记忆的想法。
--And instead, everybody gets a nearby piece of the overall physical memory. 00:39:33,340 --> 00:39:40,820
相反，每个人都会获得附近的一块整体物理内存。
--But they can still access all of the other pieces. 00:39:40,820 --> 00:39:43,420
但他们仍然可以访问所有其他部分。
--It just takes longer to get there. 00:39:43,420 --> 00:39:45,740
到达那里需要更长的时间。
--So this is called non-uniform memory access, or NUMA. 00:39:45,740 --> 00:39:52,360
所以这被称为非统一内存访问，或 NUMA。
--And so the idea is that the memory, everybody can still access all the memory, but there's a piece of the memory that's near each processor. 00:39:52,360 --> 00:40:04,240
所以想法是内存，每个人仍然可以访问所有内存，但是每个处理器附近都有一块内存。
--So this is good, because now there are things like my stack and my code that should always be private to me. 00:40:04,240 --> 00:40:14,280
所以这很好，因为现在我的堆栈和代码之类的东西对我来说应该始终是私有的。
--So I will just keep those in my own local memory. 00:40:14,280 --> 00:40:16,960
所以我只会将它们保存在我自己的本地内存中。
--I don't need to go far away to get those. 00:40:16,960 --> 00:40:20,160
我不需要到很远的地方去拿那些。
--Also, as you'll see later, the way to get a parallel program to run really fast is you divide up the data. 00:40:20,160 --> 00:40:25,880
此外，正如您稍后将看到的那样，让并行程序真正快速运行的方法是划分数据。
--And hopefully, you're mostly working on data that other processors aren't working on. 00:40:25,880 --> 00:40:30,720
希望您主要处理其他处理器未处理的数据。
--So we can put that data in our local memory. 00:40:30,720 --> 00:40:33,640
所以我们可以把这些数据放在我们的本地内存中。
--I can still access the other data. 00:40:33,640 --> 00:40:35,400
我仍然可以访问其他数据。
--But if I'm spending 95% of my time going to just my local memory, then that's good for two reasons. 00:40:35,400 --> 00:40:41,880
但是，如果我将 95% 的时间都花在本地内存上，那么这很好，原因有二。
--First, the latency is nice and low, because I can get there quickly. 00:40:41,880 --> 00:40:46,400
首先，延迟很好而且很低，因为我可以很快到达那里。
--And it's also good from a bandwidth point of view, because that traffic isn't going out over the bigger interconnect and slowing down all those other accesses. 00:40:46,400 --> 00:40:55,080
从带宽的角度来看，这也很好，因为流量不会通过更大的互连传输，也不会减慢所有其他访问的速度。
--So this is a way to build large-scale shared address space machines. 00:40:55,080 --> 00:41:00,120
所以这是一种构建大规模共享地址空间机器的方法。
--It does introduce a new complication, though, for the programmer, potentially, which is now memory might be nearby and faster or far away and slower. 00:41:02,640 --> 00:41:11,920
但是，对于程序员来说，它确实引入了一个新的复杂问题，即现在内存可能就在附近并且更快，或者远离并且更慢。
--So the programmers may have to think about that now. 00:41:11,920 --> 00:41:15,600
所以程序员现在可能不得不考虑一下。
--So in terms of examples of this, if you just have a machine, like even a laptop or a desktop, that has two sockets in it, then today, you have a non-uniform memory access machine, because the memory is actually shared across these two sockets. 00:41:15,600 --> 00:41:33,800
因此，就此示例而言，如果您只有一台机器，例如笔记本电脑或台式机，其中有两个插槽，那么今天，您有一个非统一内存访问机器，因为内存实际上是共享的这两个插座。
--So if this core over here wants to get to the memory over here, it's going to take a little bit longer to get there. 00:41:33,800 --> 00:41:39,440
所以如果这里的这个核心想要到达这里的内存，它需要更长的时间才能到达那里。
--And then if you want to build a really big machine that has a shared address space, here's one example of this, the SGI Altix, then you can do that. 00:41:42,840 --> 00:41:52,880
然后，如果你想构建一台具有共享地址空间的真正大机器，这里有一个例子，SGI Altix，那么你就可以做到。
--It's just going to take longer to get to some of the memory than to other parts of the memory. 00:41:52,880 --> 00:41:57,080
与内存的其他部分相比，访问某些内存需要更长的时间。
--But the abstraction still works, and you can still get good performance this way. 00:41:57,080 --> 00:42:03,480
但是抽象仍然有效，你仍然可以通过这种方式获得良好的性能。
--So then that's the first model that I want to talk about, which is the shared address space machine. 00:42:03,480 --> 00:42:09,520
这就是我要谈的第一个模型，即共享地址空间机器。
--So it's a simple idea from a programmer's point of view, which is we just all share the same address space. 00:42:09,520 --> 00:42:15,960
所以从程序员的角度来看，这是一个简单的想法，我们只是共享相同的地址空间。
--Now, OK, it turns out that from a programmer's point of view, this sounds great. 00:42:15,960 --> 00:42:22,040
现在，好吧，事实证明，从程序员的角度来看，这听起来不错。
--From a hardware implementation point of view, there are some challenges. 00:42:22,040 --> 00:42:26,080
从硬件实现的角度来看，存在一些挑战。
--It's not so much about the memory. 00:42:26,080 --> 00:42:27,680
这与记忆无关。
--It's about the caches. 00:42:27,680 --> 00:42:29,600
这是关于缓存的。
--So once we start caching data and we're all sharing the data, then we have a coherence problem where different copies may get out of sync with respect to each other. 00:42:29,600 --> 00:42:41,280
所以一旦我们开始缓存数据并且我们都在共享数据，那么我们就会遇到一致性问题，不同的副本可能会彼此不同步。
--So we'll actually have a couple of lectures on the topic of how the memory system works under the covers, and there are interesting details about that. 00:42:41,280 --> 00:42:50,760
因此，我们实际上将就内存系统如何在幕后工作这一主题进行几场讲座，并且有一些有趣的细节。
--So we'll get to that later on in the class. 00:42:50,760 --> 00:42:53,960
所以我们稍后会在课堂上讨论这个问题。
--OK, so in part because there's some extra cost involved with implementing cache coherence, there's also been this long tradition of building parallel machines that don't depend on any special hardware support. 00:42:53,960 --> 00:43:09,280
好的，部分是因为实现高速缓存一致性涉及一些额外的成本，构建不依赖于任何特殊硬件支持的并行机器的悠久传统也是如此。
--So this next abstraction I'm going to talk about is message passing. 00:43:09,280 --> 00:43:14,160
所以我要谈论的下一个抽象是消息传递。
--And the idea here is that each thread has only private data. 00:43:14,160 --> 00:43:22,560
这里的想法是每个线程只有私有数据。
--There is no shared address space. 00:43:22,560 --> 00:43:25,280
没有共享地址空间。
--The addresses that you can access are always private to you. 00:43:25,280 --> 00:43:29,800
您可以访问的地址始终是您的私人地址。
--And if you want to communicate with another thread, the way that you do it is you put together a message and you send it through the network to that other thread, and it receives the message, and then it interprets it and decides what to do with that. 00:43:29,800 --> 00:43:43,680
如果你想与另一个线程通信，你的方法是将一条消息放在一起，然后通过网络将其发送到另一个线程，它接收消息，然后解释它并决定做什么接着就，随即。
--So for example, if I've got some, and usually the things you send and receive are contiguous, or at least it works well that way. 00:43:43,680 --> 00:43:51,360
因此，例如，如果我有一些，通常你发送和接收的东西是连续的，或者至少它以这种方式运行良好。
--So maybe here's some variable, and I want to send it over to this other thread. 00:43:51,360 --> 00:43:55,880
所以也许这里有一些变量，我想将它发送到另一个线程。
--So I will say, I'm going to send it. 00:43:55,880 --> 00:43:58,440
所以我会说，我要发送它。
--Here's its starting address. 00:43:58,440 --> 00:44:00,520
这是它的起始地址。
--I'm sending it to thread two, and maybe you add a tag to it so that it can interpret what kind of message it is. 00:44:00,520 --> 00:44:07,520
我将它发送到第二个线程，也许你可以给它添加一个标签，以便它可以解释它是什么类型的消息。
--And then on this thread, it's going to execute explicitly receive. 00:44:07,520 --> 00:44:10,680
然后在这个线程上，它将显式执行接收。
--It'll say, here's where it should go. 00:44:10,680 --> 00:44:12,800
它会说，这是它应该去的地方。
--You might specify who you're receiving it from, or that might just be left as a wild card. 00:44:12,800 --> 00:44:18,760
您可以指定您从谁那里收到它，或者可能只是作为通配符。
--And maybe you have a special tag that you only want to receive messages with that specific tag. 00:44:18,760 --> 00:44:24,400
也许您有一个特殊标签，您只想接收带有该特定标签的消息。
--OK, so this is another approach. 00:44:24,400 --> 00:44:27,760
好的，所以这是另一种方法。
--A big advantage of this is that it doesn't require any special hardware at all other than a network. 00:44:27,760 --> 00:44:35,680
这样做的一大优势是，除了网络之外，它根本不需要任何特殊硬件。
--If you can get onto a network and send information between computers, then you can write code that will work with message passing. 00:44:35,680 --> 00:44:44,720
如果您可以进入网络并在计算机之间发送信息，那么您就可以编写用于消息传递的代码。
--Now, most people, well, OK, first of all, in assignments three and four, you will get to contrast these two programming models, because you're going to write a particular program in an assignment three using the shared address space model. 00:44:44,720 --> 00:44:58,240
现在，大多数人，好吧，首先，在作业三和作业四中，您将对比这两种编程模型，因为您将在作业三中使用共享地址空间模型编写特定程序。
--And then you're going to write the same program for assignment four in message passing. 00:44:58,240 --> 00:45:02,720
然后您将为消息传递中的作业 4 编写相同的程序。
--And you can conclude for yourself which of these you prefer, or maybe you like them both equally well. 00:45:02,720 --> 00:45:07,720
您可以自己得出结论，您更喜欢其中的哪一个，或者您可能同样喜欢它们。
--Many people, I'd say the vast majority of people, prefer the shared address space model, because this one is a little more rigid in terms of how communication works. 00:45:07,720 --> 00:45:20,440
许多人，我想说绝大多数人，更喜欢共享地址空间模型，因为就通信的工作方式而言，这种模型更加严格。
--And we will go through examples of this in the next week or two. 00:45:20,440 --> 00:45:24,200
我们将在接下来的一两周内讨论这方面的例子。
--You'll see code written in this style. 00:45:24,200 --> 00:45:26,920
您会看到以这种风格编写的代码。
--But the big selling point of this is that it's really easy to build the hardware for these machines. 00:45:26,920 --> 00:45:32,080
但它的最大卖点是为这些机器构建硬件真的很容易。
--If you want to have an enormously large machine, then it's easy to do that. 00:45:32,080 --> 00:45:38,880
如果你想拥有一台非常大的机器，那很容易做到。
--All you need is a fast interconnect. 00:45:38,880 --> 00:45:41,080
您所需要的只是一个快速互连。
--And you don't need any other special hardware to worry about coherence or anything like that. 00:45:41,080 --> 00:45:45,920
而且您不需要任何其他特殊硬件来担心连贯性或类似问题。
--You can just plug it together and start running message passing code. 00:45:45,920 --> 00:45:50,800
您可以将其连接在一起并开始运行消息传递代码。
--OK, so there have been a lot of examples of this. 00:45:50,800 --> 00:45:52,800
好的，所以有很多这样的例子。
--So for example, IBM, well, first of all, a while ago, they had a machine called Deep Blue that was the first computer to beat the best human in the world at chess. 00:45:52,800 --> 00:46:04,400
例如，IBM，嗯，首先，不久前，他们有一台名为“深蓝”的机器，这是第一台在国际象棋中击败世界上最好的人类的计算机。
--And it had this kind of message passing architecture. 00:46:04,400 --> 00:46:07,440
它具有这种消息传递架构。
--Then they had something called Blue Gene. 00:46:07,440 --> 00:46:09,480
然后他们有一种叫做蓝色基因的东西。
--And you can also just take just any kind of machine and just stick them together. 00:46:09,480 --> 00:46:17,000
你也可以拿任何一种机器，把它们粘在一起。
--So in your usual data warehouse place where you've got lots and lots of racks of servers, they could all be working together with this model. 00:46:17,000 --> 00:46:26,200
因此，在您通常拥有大量服务器机架的数据仓库中，它们都可以与该模型协同工作。
--So for example, even in this class, we'll be using a cluster of machines that we call late days. 00:46:26,200 --> 00:46:32,160
因此，例如，即使在这堂课中，我们也会使用我们称之为晚日的机器集群。
--And well, there are details about all the nodes. 00:46:32,160 --> 00:46:36,480
而且，还有关于所有节点的详细信息。
--But you can write message passing code on top of them. 00:46:36,480 --> 00:46:42,840
但是您可以在它们之上编写消息传递代码。
--But the communication performance is not so great because they're communicating through ethernet, which is not especially fast. 00:46:42,840 --> 00:46:51,080
但是通信性能不是很好，因为它们是通过以太网通信的，以太网不是特别快。
--So the good news is it's easy to plug machines together and write code. 00:46:51,080 --> 00:46:55,120
所以好消息是很容易将机器连接在一起并编写代码。
--But the bad news is there's a decent chance that the interconnect is going to be a bottleneck for you. 00:46:55,120 --> 00:47:01,560
但坏消息是互连很有可能成为您的瓶颈。
--So for that reason, the people who build high performance message passing machines build really exotic and fast interconnects. 00:47:01,560 --> 00:47:10,200
因此，出于这个原因，构建高性能消息传递机器的人们构建了真正奇异的快速互连。
--So we've talked about both shared address space and message passing. 00:47:10,200 --> 00:47:14,440
所以我们已经讨论了共享地址空间和消息传递。
--And I said it's important not to confuse abstraction and implementation. 00:47:14,440 --> 00:47:19,760
我说过重要的是不要混淆抽象和实现。
--And I was talking about hardware for shared address spaces and hardware for message passing. 00:47:19,760 --> 00:47:24,800
我在谈论用于共享地址空间的硬件和用于消息传递的硬件。
--But it turns out that you can actually implement either of those models on either type of hardware. 00:47:24,800 --> 00:47:30,040
但事实证明，您实际上可以在任何一种硬件上实现这些模型中的任何一种。
--They're not tied rigidly to one type of hardware. 00:47:30,040 --> 00:47:33,920
它们并不严格依赖于一种类型的硬件。
--So for example, let's say you like to do message passing. 00:47:33,920 --> 00:47:38,040
因此，例如，假设您喜欢进行消息传递。
--Or maybe your evil instructor is making you do message passing even if you don't want to. 00:47:38,040 --> 00:47:44,160
或者即使您不想，您的邪恶导师也会让您进行消息传递。
--Can you run that on a machine that has a shared address space? Well, yes. 00:47:44,160 --> 00:47:49,040
您可以在具有共享地址空间的机器上运行它吗？嗯，是。
--In fact, there are really fast implementations of message passing, which is if we're built based on shared address spaces, because to send a message with a shared address space, all you have to do is pass a pointer that points to it in memory, for example. 00:47:49,040 --> 00:48:03,680
事实上，消息传递确实有快速实现，如果我们是基于共享地址空间构建的，因为要使用共享地址空间发送消息，您所要做的就是传递一个指向它的指针例如，内存。
--You don't actually have to copy it through the network or anything like that. 00:48:03,680 --> 00:48:07,480
您实际上不必通过网络或类似的方式复制它。
--So there are, in fact, really fast implementations of message passing built on shared address space hardware. 00:48:07,480 --> 00:48:14,920
因此，事实上，在共享地址空间硬件上构建了非常快速的消息传递实现。
--You can go the other direction, but that's not as nice. 00:48:14,920 --> 00:48:19,800
你可以去另一个方向，但那不是很好。
--So I can write shared address space code and run it on a machine that has no hardware support for a shared address space. 00:48:19,800 --> 00:48:26,800
所以我可以编写共享地址空间代码并在没有硬件支持共享地址空间的机器上运行它。
--You can use tricks in the operating system where you write protect pages and use page fault handlers to move data back and forth and emulate what the hardware does in the caches. 00:48:26,800 --> 00:48:39,440
您可以在操作系统中使用技巧，在其中写入保护页面并使用页面错误处理程序来回移动数据并模拟硬件在缓存中的作用。
--And it will functionally work, but it's usually quite slow. 00:48:39,440 --> 00:48:44,280
它会在功能上起作用，但通常很慢。
--So it's possible, but that's not usually very fast. 00:48:44,280 --> 00:48:47,440
所以这是可能的，但这通常不是很快。
--OK. 00:48:47,960 --> 00:48:49,960
好的。
--OK. 00:48:49,960 --> 00:48:51,120
好的。
--Now, the last major model I want to talk about is data parallel, and this is the one you're going to be focusing on first in this class. 00:48:51,120 --> 00:49:01,120
现在，我要谈的最后一个主要模型是数据并行，这是您在本课程中首先要关注的模型。
--OK, so let's see. 00:49:01,120 --> 00:49:04,080
好的，让我们看看。
--So comparing data parallel with what we've talked about so far, the shared address space model is really the least restrictive. 00:49:04,080 --> 00:49:12,920
因此，将数据与我们目前讨论的并行数据进行比较，共享地址空间模型实际上是限制最少的。
--Because you have that shared address space, you can communicate however you choose to communicate. 00:49:12,920 --> 00:49:18,920
因为您拥有该共享地址空间，所以您可以按照自己选择的方式进行通信。
--It's very easy to do that. 00:49:18,920 --> 00:49:21,520
这很容易做到。
--With message passing, as you'll see when you start actually writing software this way, it makes the communication more structured. 00:49:21,520 --> 00:49:30,840
通过消息传递，正如您开始以这种方式实际编写软件时所看到的那样，它使通信更加结构化。
--Because you want to bundle things together into messages. 00:49:30,840 --> 00:49:33,880
因为你想把东西打包成消息。
--You don't want to send individual bytes as messages, because that's too slow. 00:49:33,880 --> 00:49:38,440
您不想将单个字节作为消息发送，因为那样太慢了。
--So usually you end up restructuring your code a bit to try to send messages as infrequently as you can. 00:49:38,440 --> 00:49:44,960
所以通常你最终会稍微重构你的代码以尝试尽可能不频繁地发送消息。
--It constrains that a little bit. 00:49:45,840 --> 00:49:48,880
它限制了一点点。
--The data parallel case is the most restricted in terms of its applicability. 00:49:48,880 --> 00:49:56,240
就其适用性而言，数据并行情况是最受限制的。
--So there are programs where this works really well, and cases where it just doesn't work at all. 00:49:56,240 --> 00:50:02,720
所以有些程序非常有效，有些情况下它根本不起作用。
--When it works well, though, it works very, very well, and it's very nice for programmers. 00:50:02,720 --> 00:50:08,040
但是，当它运行良好时，它会非常非常好，并且对程序员来说非常好。
--And GPUs are built all around this idea of data parallelism. 00:50:08,040 --> 00:50:13,240
 GPU 就是围绕这种数据并行性理念构建的。
--So it's an important model. 00:50:13,280 --> 00:50:15,880
所以这是一个重要的模型。
--And we'll talk about that next here. 00:50:15,880 --> 00:50:20,680
接下来我们将讨论这个问题。
--So in the old, old days of computers, we had vector supercomputers, which did lots of things in parallel by having vector instructions. 00:50:20,680 --> 00:50:31,800
所以在过去的计算机时代，我们有向量超级计算机，它通过向量指令并行地做很多事情。
--These were much wider even than the ones we see today. 00:50:31,800 --> 00:50:34,800
这些甚至比我们今天看到的要宽得多。
--You could maybe do 100 or more elements in parallel. 00:50:34,800 --> 00:50:40,600
您可以并行处理 100 个或更多元素。
--And in that case, the thing that was being done in parallel was one instruction. 00:50:40,600 --> 00:50:48,600
在那种情况下，并行完成的事情是一条指令。
--And today, though, we've moved to, as I said, this single program multiple data model, which is we're going to basically do the same work over a lot of data, but we're not going to rigidly march through one instruction at a time necessarily. 00:50:48,600 --> 00:51:07,640
不过，今天，正如我所说，我们已经转移到这个单一程序多数据模型，我们将基本上对大量数据进行相同的工作，但我们不会严格推进必须一次一条指令。
--We're going to say, here's a function, and we want to apply the same function to all of our data. 00:51:07,640 --> 00:51:13,760
我们会说，这是一个函数，我们想对所有数据应用相同的函数。
--So go do that somehow, but we're not necessarily going to constrain them to be doing an absolute lock step. 00:51:13,760 --> 00:51:22,320
所以以某种方式去做，但我们不一定要限制他们做一个绝对的锁定步骤。
--OK. 00:51:22,320 --> 00:51:24,600
好的。
--So in ISPC, which we talked about already, in terms of data parallelism, there's something that's a little bit like data parallelism, but only in a very loose way, which I talked about the for each primitive, and I said that I can point to a loop and replace the normal for loop with a for each loop, and this is telling the system that it can take all the iterations of the loop and operate on them in parallel. 00:51:24,600 --> 00:51:54,640
所以在我们已经讨论过的 ISPC 中，就数据并行性而言，有些东西有点像数据并行性，但只是以一种非常松散的方式，我谈到了每个原语，我说我可以指出到一个循环并将普通的 for 循环替换为 for each 循环，这告诉系统它可以接受循环的所有迭代并对它们进行并行操作。
--Now, technically, this is only control parallelism. 00:51:54,640 --> 00:51:59,180
现在，从技术上讲，这只是控制并行性。
--I've just said the iterations of the loop can be run in parallel. 00:51:59,180 --> 00:52:03,160
我刚刚说过循环的迭代可以并行运行。
--The ISPC doesn't really think or care about what's going on with the data inside of that loop. 00:52:03,160 --> 00:52:09,280
 ISPC 并不真正考虑或关心该循环内的数据发生了什么。
--So if you, I'm going to show you examples in a second, but you can easily break your code this way. 00:52:09,280 --> 00:52:16,040
所以，如果你是，我将在一秒钟内向你展示示例，但你可以轻松地以这种方式破坏你的代码。
--If you give it code where the operations are not actually independent, then strange things can happen. 00:52:16,040 --> 00:52:22,520
如果您在操作实际上不是独立的地方给它代码，那么奇怪的事情就会发生。
--It's not thinking about data in a principled way when it comes to data parallelism. 00:52:22,520 --> 00:52:30,240
当涉及到数据并行性时，它并没有以一种原则性的方式来考虑数据。
--OK. 00:52:30,240 --> 00:52:31,600
好的。
--But let's look at some examples here. 00:52:31,600 --> 00:52:33,560
但是让我们在这里看一些例子。
--For example, here's a new made-up ISPC function where what we want to do is compute the absolute value of something and then generate two copies of it. 00:52:33,760 --> 00:52:46,600
例如，这是一个新的虚构 ISPC 函数，我们想要做的是计算某物的绝对值，然后生成它的两个副本。
--For example, if I have, say, 1, negative 2, negative 3, then what I want to generate is I'm generating two 1's, two 2's, two 3's, and so on. 00:52:46,600 --> 00:53:03,280
例如，如果我有 1、负数 2、负数 3，那么我想要生成的是生成两个 1、两个 2、两个 3 等等。
--So that's what this code is doing. 00:53:03,280 --> 00:53:07,080
这就是这段代码所做的。
--I'm not sure why that's very interesting, but it fits on the slide. 00:53:07,080 --> 00:53:11,880
我不确定为什么这很有趣，但它适合幻灯片。
--So you can see that we've got elements of I, and I is going to correspond to the input elements. 00:53:11,880 --> 00:53:20,320
所以你可以看到我们已经得到了 I 的元素，并且 I 将对应于输入元素。
--And then we're generating two output elements. 00:53:20,320 --> 00:53:23,320
然后我们生成两个输出元素。
--So we're taking absolute values, and then we're copying it. 00:53:23,320 --> 00:53:27,920
所以我们采用绝对值，然后复制它。
--OK. 00:53:27,920 --> 00:53:28,420
好的。
--So that is like a form of data parallelism. 00:53:28,420 --> 00:53:31,160
所以这就像一种数据并行形式。
--We're getting the parallelism out of the fact that we can do it independently across all of our input data. 00:53:31,160 --> 00:53:38,440
由于我们可以跨所有输入数据独立执行，因此我们获得了并行性。
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
--But it wasn't really thinking at all about what was going on in the loop. 00:53:55,280 --> 00:53:59,200
但它并没有真正考虑循环中发生的事情。
--So here's another example. 00:53:59,200 --> 00:54:01,960
这是另一个例子。
--And what we're doing is looking at an element to see whether or not it is negative. 00:54:01,960 --> 00:54:11,400
我们正在做的是查看一个元素，看看它是否是负面的。
--And if the input element is negative, then we're going to copy it to, we're going to shift it left one position. 00:54:11,400 --> 00:54:19,480
如果输入元素是负数，那么我们将把它复制到，我们将把它左移一个位置。
--And if it's not negative, then we're just going to copy it to the same position in the output. 00:54:19,480 --> 00:54:24,440
如果它不是负数，那么我们就将它复制到输出中的相同位置。
--So you may copy it one to the left, or maybe just straight down into the output array. 00:54:24,440 --> 00:54:31,540
所以你可以将它复制到左边，或者直接向下复制到输出数组中。
--So ISPC is completely happy with this, in the sense that it will generate code, and it'll run it in parallel. 00:54:31,620 --> 00:54:38,020
所以 ISPC 对此非常满意，因为它将生成代码并并行运行。
--As a programmer, would you be completely happy with this? What can happen here? They overwrite the value one, three, four. 00:54:38,020 --> 00:54:51,580
作为一名程序员，你会对此完全满意吗？这里会发生什么？它们会覆盖值一、三、四。
--Right, so if you have positive and negative values next to each other, then two different concurrent instances may be writing to the same output. 00:54:51,580 --> 00:55:02,500
是的，所以如果正值和负值彼此相邻，那么两个不同的并发实例可能正在写入相同的输出。
--And so what will happen, from the programmer's point of view, is that the program can become non-deterministic now. 00:55:02,500 --> 00:55:10,460
因此，从程序员的角度来看，将会发生的事情是程序现在可能变得不确定。
--So the value that we get out, now actually in ISPC, because it's rigidly walking through with vectors and loops, it won't actually be non-deterministic unless you use tasks. 00:55:10,460 --> 00:55:22,700
所以我们得到的值，现在实际上是在 ISPC 中，因为它严格地使用向量和循环遍历，所以它实际上不会是不确定的，除非你使用任务。
--But if you wrote something that was data parallel like this, and if it was a little less rigid, then you would have something that was non-deterministic. 00:55:22,700 --> 00:55:32,460
但是如果你写了一些像这样的数据并行的东西，如果它不那么严格，那么你就会有一些不确定的东西。
--OK, so that's all right. 00:55:32,460 --> 00:55:36,140
好的，这样就可以了。
--So what we could do, I don't necessarily want to get super hung up on all these details, but what we could do is, so how can we take advantage of data parallelism in a more principled way, so that we don't have weird problems like the one that we just saw? So one abstraction for this is something called streams, where the idea is that we have input data coming in, and we're going to generate output data going out. 00:55:36,140 --> 00:56:06,500
所以我们可以做的，我不一定想在所有这些细节上挂断，但我们可以做的是，我们如何以更有原则的方式利用数据并行性，这样我们就不会有像我们刚才看到的那样奇怪的问题吗？所以对此的一种抽象是称为流的东西，其思想是我们有输入数据进来，我们将生成输出数据。
--And we have some function, pure function, that we apply to the inputs, and we use that to generate the outputs. 00:56:06,500 --> 00:56:13,700
我们有一些函数，纯函数，我们应用于输入，我们用它来生成输出。
--So for example, if I want to, I have two arrays. 00:56:13,700 --> 00:56:18,380
因此，例如，如果我愿意，我有两个数组。
--x is my input, y is my output. 00:56:18,380 --> 00:56:21,980
 x 是我的输入，y 是我的输出。
--And I simply want to generate the absolute value of the input as the output. 00:56:21,980 --> 00:56:27,860
我只是想生成输入的绝对值作为输出。
--So this is an ISPC program that does that. 00:56:27,860 --> 00:56:30,780
所以这是一个执行此操作的 ISPC 程序。
--So it just tests. 00:56:30,780 --> 00:56:32,180
所以它只是测试。
--If it's negative, then we invert it to take its absolute value, and we generate output that way. 00:56:32,180 --> 00:56:40,460
如果它是负数，那么我们将它取反以获得它的绝对值，然后我们以这种方式生成输出。
--And that would be great, in the sense that there's no non-determinism. 00:56:40,460 --> 00:56:44,420
从没有非确定性的意义上说，那会很棒。
--It would run in parallel. 00:56:44,420 --> 00:56:46,500
它会并行运行。
--That all looks good. 00:56:46,500 --> 00:56:47,340
这一切看起来不错。
--OK, so in this model, in the stream model, we have streams. 00:56:50,500 --> 00:56:56,100
好的，所以在这个模型中，在流模型中，我们有流。
--This is the data that we are operating on. 00:56:56,100 --> 00:56:58,740
这是我们正在操作的数据。
--So it's some collection of elements. 00:56:58,740 --> 00:57:00,580
所以它是一些元素的集合。
--And we know that we can process each element independently. 00:57:00,580 --> 00:57:03,620
而且我们知道我们可以独立处理每个元素。
--So that's good. 00:57:03,620 --> 00:57:05,380
所以这很好。
--And then the kernel, the thing that we apply to it, so in this case, this is our quote unquote kernel. 00:57:05,380 --> 00:57:11,980
然后是内核，我们应用到它的东西，所以在这种情况下，这是我们的 quote unquote 内核。
--This is some side effect free function. 00:57:11,980 --> 00:57:14,940
这是一些无副作用的功能。
--So we can apply them in any order, since they're these nice pure functions. 00:57:14,940 --> 00:57:19,220
所以我们可以按任何顺序应用它们，因为它们是这些很好的纯函数。
--So that's the basic idea of the stream model. 00:57:19,220 --> 00:57:22,220
这就是流模型的基本思想。
--That's one way to have data parallelism and avoid some of these data races or things like that. 00:57:22,220 --> 00:57:31,140
这是实现数据并行性并避免其中一些数据竞争或类似情况的一种方式。
--So for example, let's say we want to do more than one thing to it. 00:57:31,140 --> 00:57:36,420
因此，例如，假设我们想对它做不止一件事。
--In the previous example, we were just calculating the absolute value. 00:57:36,420 --> 00:57:39,340
在前面的例子中，我们只是计算绝对值。
--But let's say we have multiple things that we want to do to the data. 00:57:39,340 --> 00:57:43,260
但是假设我们要对数据做很多事情。
--So we're applying foo first, because that's our standard procedure name, and then bar. 00:57:43,260 --> 00:57:50,860
所以我们首先应用 foo，因为那是我们的标准过程名称，然后是 bar。
--So we do foo, and we do bar. 00:57:50,860 --> 00:57:53,260
所以我们做 foo，我们做 bar。
--And we can just stream the output of foo into make it the input into bar. 00:57:53,260 --> 00:57:59,740
我们可以将 foo 的输出流式传输到 bar 中。
--So we create a temporary stream or array. 00:57:59,740 --> 00:58:04,100
所以我们创建一个临时流或数组。
--And that gets generated in the middle. 00:58:04,100 --> 00:58:07,300
那是在中间产生的。
--And then the compiler can take this and understand what's going on, and then create a lot of parallelism. 00:58:07,300 --> 00:58:13,500
然后编译器可以接受它并理解发生了什么，然后创建大量的并行性。
--So this is one way that we can think about data parallelism with stream programming. 00:58:13,500 --> 00:58:20,220
所以这是我们可以考虑流式编程的数据并行性的一种方式。
--Now, I won't belabor this too much. 00:58:21,220 --> 00:58:24,420
现在，我不会过多地强调这一点。
--But it turns out, though, if I just back up and look at this example, one thing that's a little unfortunate here is I have to create this temporary thing in the middle. 00:58:24,420 --> 00:58:37,460
但事实证明，如果我只是回头看看这个例子，这里有点不幸的是我必须在中间创建这个临时的东西。
--The thing that starts to happen if you start using streams a lot is you realize, well, it's kind of a waste that we have to write the temporary out and waste bandwidth doing that. 00:58:37,460 --> 00:58:46,580
如果您开始大量使用流，开始发生的事情是您意识到，嗯，我们必须写出临时文件并浪费带宽，这是一种浪费。
--It would be nice if we could bring something in and compose together both foo and bar and do them together. 00:58:46,580 --> 00:58:52,980
如果我们可以引入一些东西并将 foo 和 bar 组合在一起并一起执行，那就太好了。
--And maybe the compiler doesn't necessarily know how to do that without some help from the programmer. 00:58:52,980 --> 00:58:57,940
如果没有程序员的帮助，编译器可能不一定知道如何做到这一点。
--So you may end up wanting to have new operators that do fancier and fancier things. 00:58:57,940 --> 00:59:05,140
因此，您可能最终想要拥有新的运营商来做越来越奇特的事情。
--So for example, several slides ago, I showed you code that would take an input array, take the absolute value, but then double the number of elements in the output. 00:59:05,140 --> 00:59:15,460
例如，在几张幻灯片之前，我向您展示了采用输入数组的代码，采用绝对值，然后将输出中的元素数量加倍。
--So we get twice as many output elements as input elements. 00:59:15,460 --> 00:59:19,180
所以我们得到的输出元素是输入元素的两倍。
--And if we want to do that, that's not necessarily a great match for this stream model of one-to-one input and output. 00:59:19,180 --> 00:59:25,620
如果我们想这样做，那不一定非常适合这种一对一输入和输出的流模型。
--So we might want to have a new primitive which says, OK, double the number of elements in the array. 00:59:25,620 --> 00:59:32,060
所以我们可能想要一个新的原语，它说，好的，将数组中的元素数量加倍。
--For every input, generate two outputs. 00:59:32,060 --> 00:59:35,180
对于每个输入，生成两个输出。
--And then we can take the absolute value of that, and then that would all be nice. 00:59:35,180 --> 00:59:40,700
然后我们可以取它的绝对值，这样就很好了。
--So the issue is that then, OK, so one potential disadvantage is we may need to add more and more things into the model to make sure we can capture everything we want to do stream programming. 00:59:40,700 --> 00:59:53,980
所以问题是，好吧，一个潜在的缺点是我们可能需要向模型中添加越来越多的东西，以确保我们可以捕获我们想要进行流编程的一切。
--So if you're doing relatively simple things with a stream model, it works well. 00:59:53,980 --> 00:59:58,540
因此，如果您使用流模型做相对简单的事情，它会很好地工作。
--If things start to get really complicated, then it starts to get a little less nice. 00:59:58,540 --> 01:00:04,340
如果事情开始变得非常复杂，那么它就会开始变得不那么美好。
--So some other important parts of the stream model, and these primitives show up in other places too in data parallelism, is that often the data that you want to operate on or produce may not be contiguous to begin with. 01:00:04,340 --> 01:00:19,660
因此，流模型的其他一些重要部分，以及这些原语也出现在数据并行性的其他地方，通常是您要操作或生成的数据一开始可能不是连续的。
--But you really do want to compute on it as contiguous data. 01:00:19,660 --> 01:00:23,740
但是您确实希望将其作为连续数据进行计算。
--So then the primitives that are helpful here are things called gather and scatter, which you've probably heard about already. 01:00:23,740 --> 01:00:30,340
那么在这里有用的原语就是所谓的聚集和分散，你可能已经听说过。
--So the idea with gather is that not only you say, well, here's my input. 01:00:30,340 --> 01:00:38,300
所以 gather 的想法是，不仅你会说，好吧，这是我的意见。
--What I want to do is, this is pointing to memory. 01:00:38,300 --> 01:00:42,220
我想要做的是，这是指向内存。
--And then this is another element. 01:00:42,220 --> 01:00:43,620
然后这是另一个元素。
--And this array contains the indices that I actually want in wherever they are. 01:00:43,620 --> 01:00:48,900
这个数组包含我真正想要的索引，无论它们在哪里。
--And this is saying, go grab all of these and arrange them contiguously into this array. 01:00:48,900 --> 01:00:56,180
这就是说，抓住所有这些并将它们连续排列到这个数组中。
--And then I can use that as input to some stream routine. 01:00:56,180 --> 01:01:02,220
然后我可以将其用作某些流例程的输入。
--And now it'll be nice and contiguous and all is good. 01:01:02,220 --> 01:01:05,100
现在它会很好而且很连续，一切都很好。
--That's what gather does. 01:01:05,100 --> 01:01:06,780
这就是收集所做的。
--And then scatter does the output version of that. 01:01:06,780 --> 01:01:10,300
然后 scatter 执行它的输出版本。
--So with scatter, I have some output and indices where I want to actually store it. 01:01:10,300 --> 01:01:15,220
所以有了 scatter，我有一些输出和索引，我想实际存储它。
--And then it will go actually store them there. 01:01:15,220 --> 01:01:18,100
然后它将实际存储在那里。
--So you can see, here is the equivalent ISPC code for gather and scatter. 01:01:18,100 --> 01:01:25,820
所以你可以看到，这里是聚集和分散的等效 ISPC 代码。
--As I mentioned before, the Intel's vector instructions do include a gather load instruction. 01:01:25,820 --> 01:01:35,380
正如我之前提到的，Intel 的矢量指令确实包含一个收集加载指令。
--They do not include a scatter, though. 01:01:35,380 --> 01:01:40,140
不过，它们不包括散点图。
--So then this is the visualization of what gather does. 01:01:40,500 --> 01:01:43,500
那么这就是 gather 所做的可视化。
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
--And so it's just going to do a whole bunch of, effectively, memory loads and stick things together contiguously for you. 01:02:03,900 --> 01:02:10,900
所以它会做一大堆，有效的，记忆加载，并为你连续地把东西粘在一起。
--So that's what gather does. 01:02:10,900 --> 01:02:13,500
这就是收集的作用。
--So GPUs typically do have support for gather and scatter. 01:02:13,500 --> 01:02:18,940
所以 GPU 通常确实支持收集和分散。
--So you will see those operations there. 01:02:18,940 --> 01:02:23,260
所以你会在那里看到那些操作。
--OK, so to summarize the data parallel model, this is designed for the case where you have, so the thing is, if the thing you're trying to calculate involves effectively applying the same computation to lots of data, then data parallelism should work very well. 01:02:23,260 --> 01:02:46,180
好的，所以总结一下数据并行模型，这是为您所拥有的情况而设计的，所以问题是，如果您要计算的事情涉及有效地将相同的计算应用于大量数据，那么数据并行应该起作用很好。
--And things like GPUs are all built around taking a lot of advantage of data parallelism. 01:02:46,180 --> 01:02:51,220
像 GPU 这样的东西都是围绕着充分利用数据并行性而构建的。
--So if this fits what you're trying to do, then this is very nice. 01:02:51,220 --> 01:02:57,420
因此，如果这符合您要尝试做的事情，那么这非常好。
--And it's basically like mapping some function onto a large amount of data. 01:02:57,420 --> 01:03:02,460
它基本上就像将一些功能映射到大量数据上。
--And in fact, even if you are targeting a machine that supports message passing or shared address space, if your program has data parallelism, then you should be able to get some really good performance. 01:03:02,580 --> 01:03:15,820
事实上，即使您的目标是支持消息传递或共享地址空间的机器，如果您的程序具有数据并行性，那么您应该能够获得一些非常好的性能。
--And when we start talking about specific code examples, you'll see that in practice. 01:03:15,820 --> 01:03:20,580
当我们开始讨论具体的代码示例时，您会在实践中看到这一点。
--So data parallel is not just a programming abstraction. 01:03:20,580 --> 01:03:24,820
所以数据并行不仅仅是一种编程抽象。
--It's a good way to think about how you're going to structure your code, even if you're targeting some other model. 01:03:24,820 --> 01:03:30,580
这是考虑如何构建代码的好方法，即使您的目标是其他模型。
--So just to wrap things up here, just a couple more slides here. 01:03:33,460 --> 01:03:39,100
因此，为了总结一下，这里再放几张幻灯片。
--So to review, we talked about three different models, shared address space, message passing, and data parallel. 01:03:39,100 --> 01:03:45,300
因此回顾一下，我们讨论了三种不同的模型，共享地址空间、消息传递和数据并行。
--The shared address space is communication occurs through loading and storing memory in the shared address space. 01:03:45,300 --> 01:03:53,500
共享地址空间是通过在共享地址空间中加载和存储内存来进行通信的。
--In message passing, it's all about sending messages to, it's all done through sending messages to other threads because you only have a private memory address space. 01:03:53,500 --> 01:04:02,180
在消息传递中，都是关于将消息发送到，这都是通过向其他线程发送消息来完成的，因为你只有一个私有内存地址空间。
--There's no shared address space. 01:04:02,460 --> 01:04:04,980
没有共享地址空间。
--And in data parallel, you're taking, effectively, some function or some computation, and you're mapping it across some collection of data. 01:04:04,980 --> 01:04:13,340
在数据并行中，您有效地采用了一些函数或一些计算，并将其映射到一些数据集合中。
--So OK. 01:04:13,340 --> 01:04:16,620
那么好吧。
--Now, all right, so one of the reasons, one of the last things I want to emphasize here is that in practice, it's not the case that you just get to form an opinion about your favorite programming model. 01:04:16,620 --> 01:04:28,620
现在，好吧，原因之一，我想在这里强调的最后一件事是，在实践中，您并不是只能对自己喜欢的编程模型形成意见。
--You say, ah, I really like shared address space. 01:04:28,620 --> 01:04:31,400
你说啊，我很喜欢共享地址空间。
--I really don't like message passing. 01:04:31,400 --> 01:04:33,440
我真的不喜欢消息传递。
--I'm lukewarm on data parallel, or whatever it is. 01:04:33,440 --> 01:04:36,000
我对数据并行不冷不热，或者不管它是什么。
--You really want to be good at all of these different models, because in practice, you usually have to do all of the above if you're really trying to take full advantage of high-end machines. 01:04:36,000 --> 01:04:49,000
你真的想精通所有这些不同的模型，因为在实践中，如果你真的想充分利用高端机器，你通常必须做到以上所有。
--So in particular, within a multi-core chip, you will always have shared address space support because they just physically share caches, and it's really easy to support it there. 01:04:49,000 --> 01:05:02,640
因此，特别是在多核芯片中，您将始终拥有共享地址空间支持，因为它们只是在物理上共享高速缓存，而且在那里支持它真的很容易。
--So you're always going to see shared address space at a small scale. 01:05:02,640 --> 01:05:07,400
所以你总是会看到小规模的共享地址空间。
--At a large scale, you may not have the hardware support for cache coherence. 01:05:07,400 --> 01:05:11,640
在大规模情况下，您可能没有缓存一致性的硬件支持。
--So at a larger scale, you may need to use message passing to communicate. 01:05:11,640 --> 01:05:17,360
所以在更大的范围内，你可能需要使用消息传递来进行通信。
--And it's also very common that we have not only CPUs, but GPUs, and GPUs are all about data parallelism. 01:05:17,360 --> 01:05:24,200
而且我们不仅有 CPU，还有 GPU，而且 GPU 都是关于数据并行性的，这也很常见。
--So you may be mixing a very data parallel-oriented style of execution with using either one of the other two models for the parts of your code that don't fit data parallelism so well, and they may be talking to each other that way. 01:05:24,200 --> 01:05:40,680
因此，对于不太适合数据并行性的代码部分，您可能将非常面向数据的并行执行风格与使用其他两种模型中的任何一种混合在一起，并且它们可能会以这种方式相互交谈。
--So for example, the Roadrunner machine at Los Alamos National Labs, this was 10 years ago, the fastest computer in the world for some period of time. 01:05:40,680 --> 01:05:54,680
例如，洛斯阿拉莫斯国家实验室的 Roadrunner 机器，这是 10 年前，在一段时间内是世界上最快的计算机。
--And it was basically composed of lots and lots of things at the smaller scale. 01:05:54,680 --> 01:06:01,560
它基本上是由很多很多较小规模的东西组成的。
--We've got lots of these IBM cell GPUs. 01:06:01,560 --> 01:06:05,760
我们有很多这样的 IBM 单元 GPU。
--And within them, they had a shared address space. 01:06:05,760 --> 01:06:09,000
在它们内部，它们有一个共享的地址空间。
--But across different nodes, you did not have a shared address space. 01:06:09,000 --> 01:06:14,500
但是在不同的节点之间，您没有共享地址空间。
--You had message passing. 01:06:14,500 --> 01:06:16,740
你有消息传递。
--So you had to have one program that would take advantage of both of those models at the same time. 01:06:16,740 --> 01:06:21,920
因此，您必须拥有一个可以同时利用这两种模型的程序。
--OK. 01:06:22,280 --> 01:06:25,280
好的。
--So to wrap things up, we've been talking about abstractions and implementations. 01:06:25,280 --> 01:06:32,040
因此，总结一下，我们一直在谈论抽象和实现。
--And we saw ISPC as one example, and then we talked about three other abstractions. 01:06:32,040 --> 01:06:40,080
我们将 ISPC 视为一个示例，然后我们讨论了其他三个抽象概念。
--And let's see. 01:06:40,080 --> 01:06:41,960
让我们看看。
--So when you're designing a new abstraction, so just historically, the way these abstractions came about, actually, usually when somebody invents a new abstraction, it's because at a low level, they think they have a really efficient way to implement it in hardware. 01:06:41,960 --> 01:06:56,320
所以当你设计一个新的抽象时，从历史上看，这些抽象的产生方式，实际上，通常当有人发明一个新的抽象时，这是因为在低层次上，他们认为他们有一个非常有效的方法来实现它硬件。
--So initially, these things all started off as things that were very tied to hardware. 01:06:56,320 --> 01:07:00,600
所以最初，这些东西都是从与硬件密切相关的东西开始的。
--But over time, people realized, oh, wait, really? This abstraction is less tied to the hardware than we thought. 01:07:00,600 --> 01:07:06,480
但随着时间的推移，人们意识到，哦，等等，真的吗？这种抽象不像我们想象的那样与硬件相关。
--We can implement it on different machines and so on. 01:07:06,480 --> 01:07:10,320
我们可以在不同的机器上实现它等等。
--OK. 01:07:10,320 --> 01:07:11,480
好的。
--And one thing that's important, as I just said a minute ago, is you'll want to be able to think about things from multiple different perspectives. 01:07:11,480 --> 01:07:19,440
有一件事很重要，正如我刚才所说，你会希望能够从多个不同的角度思考问题。
--So that's actually it for today. 01:07:19,520 --> 01:07:23,200
这就是今天的内容。
--For once, we're finishing ahead of schedule, which is not bad. 01:07:23,200 --> 01:07:28,280
这一次，我们提前完成了，这还不错。
--OK. 01:07:28,280 --> 01:07:28,800
好的。
--So I'll see you on Wednesday, and we'll talk more about parallel programming then. 01:07:28,800 --> 01:07:34,360
那么我们周三见，届时我们将更多地讨论并行编程。
