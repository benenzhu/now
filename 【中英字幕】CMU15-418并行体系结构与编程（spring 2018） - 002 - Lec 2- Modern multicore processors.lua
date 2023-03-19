--So, just if you're, you might not have seen this, but I just announced on Piazza recently 00:00:00,000 --> 00:00:09,000
所以，如果你是，你可能没有看到这个，但我最近刚刚在 Piazza 上宣布
--that I'll be holding office hours this afternoon, right after class, for those of you trying 00:00:09,000 --> 00:00:14,360
我将在今天下午，下课后，为你们中的那些尝试
--to get moving on assignment one. 00:00:14,360 --> 00:00:17,080
继续执行任务一。
--Otherwise, our regular office hours will start on Sunday, and you can see the schedule on 00:00:17,080 --> 00:00:22,360
否则，我们的正常办公时间将从周日开始，您可以在
--the staff webpage. 00:00:22,360 --> 00:00:26,080
员工网页。
--So that's, I won't normally make announcements like that, except that this was such a recent 00:00:26,080 --> 00:00:33,400
所以那是，我通常不会发布这样的公告，除非这是最近
--post, and I know a lot of people will be pretty busy this weekend trying to get moving on 00:00:33,400 --> 00:00:39,440
发布，我知道这个周末很多人会很忙，试图继续前进
--assignment one. 00:00:39,440 --> 00:00:41,320
作业一。
--So today what I want to do is talk about sort of a hardware perspective on parallel computing, 00:00:41,320 --> 00:00:49,520
所以今天我想做的是从硬件角度谈谈并行计算，
--and make use of the sort of types of processors that you're familiar with in a laptop or desktop 00:00:49,520 --> 00:00:57,000
并在笔记本电脑或台式机中使用您熟悉的处理器类型
--machine, a conventional processor, but then sort of show how that's been adapted and modified, 00:00:57,000 --> 00:01:04,220
机器，一个传统的处理器，然后展示它是如何被改编和修改的，
--some of the concepts in it, to create GPUs, graphic processing units, which are a very 00:01:04,220 --> 00:01:09,720
其中的一些概念，创建 GPU，图形处理单元，这是一个非常
--important class of machines nowadays for parallel computing. 00:01:09,720 --> 00:01:15,020
当今用于并行计算的重要机器类别。
--And I think the main theme of this is you'll find that in order to exploit parallelism, 00:01:15,020 --> 00:01:20,540
我认为这的主题是你会发现为了利用并行性，
--the hardware people have sort of set up potential for parallel computing at many different levels 00:01:20,540 --> 00:01:28,180
硬件人员具有在许多不同级别上进行并行计算的潜力
--in the hierarchy, some of which are invisible, nominally invisible to the programmer, and 00:01:28,180 --> 00:01:34,100
在层次结构中，其中一些是不可见的，名义上对程序员是不可见的，并且
--others which the programmer or the compiler must explicitly generate the appropriate code 00:01:34,100 --> 00:01:40,200
程序员或编译器必须显式生成适当代码的其他内容
--for it to do. 00:01:40,200 --> 00:01:41,720
让它去做。
--And so this is a case where you kind of have to understand the hardware well enough to 00:01:41,720 --> 00:01:46,920
因此，在这种情况下，您必须对硬件有足够的了解才能
--do the software work that will make the hardware reach its maximum potential. 00:01:46,920 --> 00:01:53,920
做能让硬件发挥最大潜力的软件工作。
--I was so impressed, by the way, with my guest lecturer's toys that I went to the Apple store 00:01:53,920 --> 00:01:58,880
顺便说一句，我的客座讲师的玩具给我留下了深刻的印象，所以我去了苹果商店
--yesterday and loaded up on them. 00:01:58,880 --> 00:02:02,800
昨天并加载了它们。
--So you remember from last time there was a discussion about what's been the problem, 00:02:02,800 --> 00:02:08,360
所以你记得上次讨论过问题出在哪里，
--what happened in 2004 that it changed the face of computers in a very significant way. 00:02:08,360 --> 00:02:15,460
 2004 年发生的事情极大地改变了计算机的面貌。
--Anyone remember? 00:02:15,460 --> 00:02:16,460
有人记得吗？
--Yes. 00:02:16,460 --> 00:02:17,460
是的。
--Basically, that picture of reaching the power wall that once you go above about 100 watts 00:02:17,460 --> 00:02:27,300
基本上，一旦你超过 100 瓦，就会达到功率墙的图片
--on a chip, it's just too darn hot. 00:02:27,300 --> 00:02:30,220
在芯片上，它太热了。
--Imagine a light bulb, a big bright light bulb, trying to put it in a box. 00:02:30,220 --> 00:02:35,340
想象一个灯泡，一个明亮的大灯泡，试图把它放在一个盒子里。
--You need a very large fan for that to work. 00:02:35,340 --> 00:02:37,820
你需要一个非常大的风扇才能工作。
--And of course, it's especially critical for something like a phone, because not only would 00:02:37,820 --> 00:02:42,200
当然，这对于手机之类的东西尤其重要，因为不仅会
--your battery disappear in about five minutes, but also you'd get a really hot and uncomfortable 00:02:42,200 --> 00:02:49,620
你的电池会在大约五分钟内耗尽，而且你会感到非常热和不舒服
--feeling there. 00:02:49,620 --> 00:02:52,060
感觉在那里。
--So anyways, that was the sort of plateau that was hit. 00:02:52,060 --> 00:02:57,820
所以无论如何，这就是那种被击中的高原。
--I mean, people knew it was coming, but somehow nobody was prepared for it, and it absolutely 00:02:57,820 --> 00:03:03,240
我的意思是，人们知道它要来了，但不知何故没有人为此做好准备，而且它绝对
--totally changed the face of things. 00:03:03,240 --> 00:03:05,600
彻底改变了事情的面貌。
--And the shift for that has been we've gone all parallel, and all the sort of future predictions 00:03:05,600 --> 00:03:15,000
而为此发生的转变是我们已经平行进行，以及所有未来的预测
--about how you're going to get more performance out of machines is through parallelism. 00:03:15,000 --> 00:03:19,360
关于如何从机器中获得更多性能的方法是通过并行性。
--And then what was it that you guys sort of wrote or implemented a few parallel programs 00:03:19,360 --> 00:03:27,380
然后你们编写或实现了一些并行程序是什么
--last time involving adding numbers? 00:03:27,380 --> 00:03:31,120
上次涉及数字加法？
--And so you saw some of the challenges for that. 00:03:31,120 --> 00:03:33,440
所以你看到了一些挑战。
--You saw problems of load balance. 00:03:33,440 --> 00:03:36,040
你看到了负载平衡的问题。
--You saw problems of communication latency. 00:03:36,040 --> 00:03:38,860
您看到了通信延迟问题。
--You saw problems of underutilization when you're all trying to work collectively, but 00:03:38,860 --> 00:03:43,320
当你们都试图集体工作时，你看到了未充分利用的问题，但是
--each of you probably only spent about two seconds apiece doing any real computation. 00:03:43,320 --> 00:03:48,280
你们每个人可能只花了大约两秒钟做任何真正的计算。
--And so in a way, the machine was very underutilized. 00:03:48,280 --> 00:03:51,900
所以在某种程度上，这台机器没有得到充分利用。
--So those are the kind of themes that we saw in a physical demonstration, but those show 00:03:51,900 --> 00:03:56,440
所以这些是我们在物理演示中看到的那种主题，但那些显示
--up over and over again in the real world as well. 00:03:56,440 --> 00:04:03,420
在现实世界中也一遍又一遍。
--So today is sort of computer architecture, and as I said, and we'll look at performance. 00:04:03,420 --> 00:04:11,660
所以今天是计算机体系结构，正如我所说，我们将研究性能。
--One is parallelism. 00:04:11,660 --> 00:04:12,660
一是并行性。
--The other is a big theme of this course is one of the biggest problems of scaling up 00:04:12,660 --> 00:04:17,980
另一个是这个课程的大主题是扩大规模的最大问题之一
--computation is often just getting things from memory from some or from one place to another 00:04:17,980 --> 00:04:23,220
计算通常只是从内存中获取一些东西或从一个地方到另一个地方
--more largely. 00:04:23,220 --> 00:04:25,540
更主要的是。
--And you can have lots of parallel units, but if you can't feed them the memory values that 00:04:25,540 --> 00:04:31,700
你可以有很多并行单元，但如果你不能为它们提供内存值
--they're looking for, then they won't be very useful. 00:04:31,780 --> 00:04:37,740
他们正在寻找，那么他们将不会很有用。
--And so again, these are sort of ideas that we'll pick up and use in many different forms 00:04:37,740 --> 00:04:43,700
同样，这些是我们将以多种不同形式采用和使用的想法
--throughout the course. 00:04:43,700 --> 00:04:45,900
在整个课程中。
--So let's look at parallelism, and we'll use this very simple piece of code as an example. 00:04:45,900 --> 00:04:51,860
那么让我们看看并行性，我们将使用这段非常简单的代码作为示例。
--And what you'll see in it is that the outer loop is over n, and n is basically n independent 00:04:51,860 --> 00:04:59,900
你会在里面看到的是外层循环超过了n，而n基本上是n独立的
--values of x for which we want to compute sine of x. 00:04:59,900 --> 00:05:04,460
我们要计算 x 的正弦值的 x 值。
--And we'll use a Taylor expansion over some number of terms. 00:05:04,460 --> 00:05:09,860
我们将对一些项使用泰勒展开。
--And so you can think of that for each value of x, we want to expand out that equation 00:05:09,860 --> 00:05:15,820
所以你可以考虑对于 x 的每个值，我们想展开这个方程
--down to, say, 15 terms. 00:05:15,820 --> 00:05:21,820
减少到，比如说，15 个术语。
--But the main point to notice is that these are all completely independent of each other. 00:05:21,820 --> 00:05:28,060
但要注意的要点是，这些都是完全相互独立的。
--So you'll see we're computing over this value i. 00:05:28,060 --> 00:05:34,300
所以你会看到我们正在计算这个值 i。
--And there's no relation, and within this loop over i, you see that it's only referencing 00:05:34,300 --> 00:05:41,060
并且没有任何关系，在 i 的这个循环中，你会看到它只是引用
--values of i or values that are the same across all values of i. 00:05:41,060 --> 00:05:46,820
i 的值或 i 的所有值都相同的值。
--So this is sort of the perfect example of parallelism, what sometimes it's called embarrassingly 00:05:46,820 --> 00:05:52,540
所以这是并行性的完美例子，有时它被称为令人尴尬的
--parallel computation, meaning that you just have a bunch of completely unrelated independent 00:05:52,540 --> 00:05:59,140
并行计算，意味着你只有一堆完全不相关的独立
--stuff you're trying to compute. 00:05:59,140 --> 00:06:01,120
你试图计算的东西。
--And so in principle, you should just be able to expand out and do as much of that as you 00:06:01,120 --> 00:06:06,020
所以原则上，你应该能够扩展并尽可能多地做
--have resources available. 00:06:06,020 --> 00:06:13,340
有可用资源。
--So let's imagine we've compiled this code, and we convert it. 00:06:13,340 --> 00:06:21,380
所以让我们假设我们已经编译了这段代码，并且我们转换了它。
--Of course, the compiler generates assembly code, and in 213, 513, we all learned x86. 00:06:21,460 --> 00:06:28,020
当然编译器生成的是汇编代码，213、513我们都学过x86。
--And this is not. 00:06:28,020 --> 00:06:29,020
而这不是。
--This is some generic assembly code that looks vaguely like either ARM or MIPS code. 00:06:29,020 --> 00:06:36,320
这是一些通用的汇编代码，看起来有点像 ARM 或 MIPS 代码。
--So it's something we don't really cover, and you might not have seen. 00:06:36,320 --> 00:06:39,580
所以这是我们没有真正涵盖的内容，您可能没有看到。
--But in general, you should understand the general idea of it anyhow. 00:06:39,580 --> 00:06:44,140
但总的来说，无论如何你应该了解它的大概意思。
--And the main thing I'll say throughout this term, if you're used to x86, especially the 00:06:44,140 --> 00:06:48,540
如果您习惯了 x86，尤其是
--remember the version that we look at, the so-called AT&T format that 213 uses, is that 00:06:49,540 --> 00:06:56,580
请记住我们看到的版本，即 213 使用的所谓 AT&amp;T 格式，是
--usually this code, everything's written backwards. 00:06:56,580 --> 00:07:00,540
通常这段代码，一切都写反了。
--So for example, this instruction here means that r0 gets the memory value that's read 00:07:00,540 --> 00:07:10,440
因此，例如，此处的这条指令意味着 r0 获取读取的内存值
--where you get the address from r1. 00:07:10,440 --> 00:07:14,380
从 r1 获取地址的位置。
--That's kind of hard to read. 00:07:14,380 --> 00:07:18,100
这有点难读。
--It's the left arrow. 00:07:18,100 --> 00:07:19,460
是左箭头。
--So think of it, the destination is on the left, and the source is on the right, which 00:07:19,460 --> 00:07:24,180
所以想一想，目的地在左边，源头在右边，这
--is actually the more reasonable way to do it. 00:07:24,180 --> 00:07:26,940
实际上是更合理的做法。
--We just had to get used to the sort of backward version that AT&T code is in 213. 00:07:26,940 --> 00:07:34,220
我们只需要习惯 AT&amp;T 代码在 213 中的那种落后版本。
--So we'll use code like this. 00:07:34,220 --> 00:07:36,260
所以我们将使用这样的代码。
--And really, the details of the code aren't that important, except to sell it. 00:07:36,260 --> 00:07:40,620
事实上，代码的细节并不那么重要，除了卖掉它。
--And you can kind of guess what these instructions do. 00:07:40,620 --> 00:07:43,860
你可以猜到这些指令的作用。
--The first one loads, so it reads from memory and stores it into a register. 00:07:43,860 --> 00:07:50,140
第一个加载，因此它从内存中读取并将其存储到寄存器中。
--The second one then multiplies register 0 by itself and stores it in r1. 00:07:50,140 --> 00:07:56,820
第二个然后将寄存器 0 与自身相乘并将其存储在 r1 中。
--And then the third one multiplies register 0 by register 1 and stores it in r1. 00:07:56,820 --> 00:08:02,580
然后第三个将寄存器 0 乘以寄存器 1 并将其存储在 r1 中。
--So you can see that that computation is for this numerator computation here, the cube 00:08:02,580 --> 00:08:09,660
所以你可以看到这里的计算是针对这个分子的计算，即立方体
--of x sub i. 00:08:09,660 --> 00:08:12,500
x子i。
--The observation here is there's really not much potential for parallelism here. 00:08:13,420 --> 00:08:22,300
这里的观察是这里的并行性真的没有太大的潜力。
--Well, that's jumping ahead a little. 00:08:22,300 --> 00:08:23,980
好吧，那是向前跳了一点。
--So when we talk sort of a simplistic view of computer architecture, 00:08:23,980 --> 00:08:30,900
所以当我们谈论计算机体系结构的一种简单化观点时，
--you just imagine a machine that just will step through the code one 00:08:30,900 --> 00:08:35,780
你只是想像一台机器，它只会单步执行代码
--instruction at a time. 00:08:35,780 --> 00:08:37,500
一次指令。
--It will start the first one and finish it, and then it will start the second one 00:08:37,500 --> 00:08:41,820
它会开始第一个并完成它，然后它会开始第二个
--and finish it. 00:08:41,860 --> 00:08:42,500
并完成它。
--So it's completely classic sequential execution model. 00:08:42,500 --> 00:08:47,660
所以它完全是经典的顺序执行模型。
--And so if we did that, it would just chug along one step at a time 00:08:47,660 --> 00:08:55,140
因此，如果我们这样做，它只会一次向前迈出一步
--doing these operations. 00:08:55,140 --> 00:08:58,460
做这些操作。
--And we mentioned last time in class that since about the late 1990s, 00:08:58,460 --> 00:09:11,620
我们上次在课堂上提到，大约从 1990 年代后期开始，
--pretty much any microprocessor actually 00:09:11,620 --> 00:09:14,940
实际上几乎任何微处理器
--was what they call a superscalar one, meaning 00:09:14,940 --> 00:09:17,420
就是他们所说的超标量，意思是
--that it had multiple ability to extract information 00:09:17,420 --> 00:09:26,500
它具有多种提取信息的能力
--from a single instruction stream and extract parallelism out of it, 00:09:26,500 --> 00:09:31,540
从单个指令流中提取并行性，
--sometimes called ILP or instruction level parallelism. 00:09:31,540 --> 00:09:35,660
有时称为 ILP 或指令级并行。
--And the idea of it is that there is sort of replicated logic 00:09:35,660 --> 00:09:40,900
它的想法是有一种复制的逻辑
--for extracting instructions out of the instruction stream and then 00:09:40,900 --> 00:09:46,140
用于从指令流中提取指令，然后
--multiple ALUs to perform multiple operations in parallel. 00:09:46,140 --> 00:09:51,540
多个 ALU 并行执行多个操作。
--But this has to be done. 00:09:51,540 --> 00:09:52,580
但这是必须要做的。
--This is with just conventional code, no special software. 00:09:52,580 --> 00:09:57,340
这只是常规代码，没有特殊软件。
--And so this has to be done in a way that preserves 00:09:57,340 --> 00:09:59,660
所以这必须以一种保留的方式来完成
--the semantics of the program, meaning that you assume that things have 00:09:59,660 --> 00:10:05,220
程序的语义，意味着你假设事物有
--to look as if they're going in a sequential fashion. 00:10:05,260 --> 00:10:09,060
看起来好像它们是按顺序进行的。
--And so the problem in this code is you'll 00:10:09,060 --> 00:10:11,260
所以这段代码中的问题是你会
--see that there's really not much potential 00:10:11,260 --> 00:10:14,700
看真的没多大潜力
--for ILP in these instructions. 00:10:14,700 --> 00:10:16,620
对于这些说明中的 ILP。
--I have to read from memory before I can start multiplying. 00:10:16,620 --> 00:10:21,980
在我开始乘法之前，我必须从记忆中读取。
--I have to do the first multiply before I can do the second. 00:10:21,980 --> 00:10:25,300
我必须先做第一个乘法，然后才能做第二个。
--So those three instructions would have 00:10:25,300 --> 00:10:27,700
所以这三个指令会有
--to go in exactly that order without any making use 00:10:27,700 --> 00:10:31,980
完全按那个顺序走
--of this superscalar hardware. 00:10:31,980 --> 00:10:34,320
这个超标量硬件。
--So already, it's a challenge to try and get 00:10:34,320 --> 00:10:38,240
所以已经，尝试并获得它是一个挑战
--actual true instruction level parallelism out of a program. 00:10:38,240 --> 00:10:41,200
程序中实际真正的指令级并行性。
--And that picture actually looks like what was called 00:10:43,760 --> 00:10:47,400
那张照片实际上看起来像所谓的
--the original Pentium processor. 00:10:47,400 --> 00:10:50,880
原始的奔腾处理器。
--Since the late 1990s, at least all the upper end processors 00:10:50,880 --> 00:10:59,720
自 1990 年代后期以来，至少所有的高端处理器
--moved to what they call out-of-order processing. 00:10:59,720 --> 00:11:01,800
转移到他们所谓的无序处理。
--And this was covered in one lecture in 213.513. 00:11:01,800 --> 00:11:07,080
这在 213.513 的一个讲座中有所介绍。
--It's chapter five of a book that I know and love 00:11:07,080 --> 00:11:12,120
这是我所了解和喜爱的一本书的第五章
--that you might find useful at various points in this course. 00:11:12,120 --> 00:11:15,800
您可能会发现在本课程的各个方面都有用。
--But it's not really the topic of this course. 00:11:15,800 --> 00:11:18,520
但这不是本课程的主题。
--So the idea is that starting at that point with what they call 00:11:18,520 --> 00:11:23,160
所以我们的想法是从那一点开始，他们称之为
--out-of-order execution, at that point, it had reached this. 00:11:23,160 --> 00:11:28,280
乱序执行，到时候就到了这个地步。
--We hadn't hit the wall yet. 00:11:28,280 --> 00:11:29,720
我们还没有碰壁。
--So we are still cranking up the speed 00:11:29,720 --> 00:11:32,120
所以我们还在加快速度
--of conventional processors. 00:11:32,120 --> 00:11:34,200
传统处理器。
--And what they did was realize we can put a ton of hardware 00:11:34,200 --> 00:11:38,720
他们所做的是意识到我们可以放置大量硬件
--on a chip nowadays and take an ordinary program 00:11:38,720 --> 00:11:43,360
现在在芯片上并采用普通程序
--and extract out of it all kinds of parallelism 00:11:43,360 --> 00:11:46,680
并从中提取出各种并行性
--and get lots of stuff going on at once out of that. 00:11:46,680 --> 00:11:51,240
并从中得到很多东西。
--So the idea of it is to create these souped-up decoders that 00:11:51,240 --> 00:11:58,840
所以它的想法是创造这些增强型解码器
--would yank a whole bunch of instructions out 00:11:58,920 --> 00:12:02,840
会抽出一大堆指令
--of the instruction stream, where the program counter is 00:12:02,840 --> 00:12:08,200
指令流的，其中程序计数器是
--and where it's pointing to for the next, say, 10 instructions, 00:12:08,200 --> 00:12:13,080
以及它指向下一个指令的位置，比如 10 条指令，
--and basically map them into a new kind of computation, 00:12:13,080 --> 00:12:18,720
基本上将它们映射到一种新的计算中，
--sometimes called a data flow computation, that 00:12:18,720 --> 00:12:20,880
有时称为数据流计算，即
--keeps track of which values here being generated 00:12:20,880 --> 00:12:25,960
跟踪此处生成的值
--will then feed which instructions still to come. 00:12:25,960 --> 00:12:28,760
然后将提供哪些指令仍然存在。
--So the sort of data dependencies 00:12:28,760 --> 00:12:30,440
所以那种数据依赖
--in those instructions. 00:12:30,440 --> 00:12:32,240
在这些说明中。
--And then map it through a lot of fancy hardware and control 00:12:32,240 --> 00:12:37,400
然后通过很多花哨的硬件和控制来映射它
--onto a bunch of independent processing units 00:12:37,400 --> 00:12:43,120
到一堆独立的处理单元上
--that can each perform some subset 00:12:43,120 --> 00:12:46,080
每个都可以执行一些子集
--of the possible operations. 00:12:46,080 --> 00:12:47,400
可能的操作。
--So this Pentium 4 was one of the older ones. 00:12:47,400 --> 00:12:50,800
所以这款 Pentium 4 是较旧的处理器之一。
--So it had one unit that could just read and write 00:12:50,800 --> 00:12:53,640
所以它有一个单元可以读写
--from memory, two that could do integer arithmetic, 00:12:53,640 --> 00:12:58,160
从内存中，两个可以进行整数运算，
--one that could do floating-point arithmetic, 00:12:58,160 --> 00:13:00,200
一个可以做浮点运算的，
--and a separate one that would use the so-called SIMD 00:13:00,200 --> 00:13:03,400
和一个单独的将使用所谓的 SIMD
--instructions that we'll talk about before. 00:13:03,400 --> 00:13:06,000
我们之前会讨论的说明。
--A more recent version of this has a lot more of this. 00:13:06,000 --> 00:13:10,480
这个的更新版本有更多这样的内容。
--It has actually two way. 00:13:10,480 --> 00:13:12,520
它实际上有两种方式。
--It can load two and store one value at a time. 00:13:12,520 --> 00:13:16,880
它一次可以加载两个值并存储一个值。
--It can do multiple floating-point operations, 00:13:16,880 --> 00:13:19,920
它可以进行多次浮点运算，
--multiple integer operations. 00:13:19,920 --> 00:13:22,040
多个整数运算。
--All of those can do these so-called SIMD operations. 00:13:22,040 --> 00:13:25,040
所有这些都可以执行这些所谓的 SIMD 操作。
--So there's a lot of raw computing power 00:13:25,040 --> 00:13:29,360
所以有很多原始计算能力
--built into these processors if they can find enough stuff 00:13:29,360 --> 00:13:33,720
如果他们能找到足够的东西，就内置在这些处理器中
--to do from the instruction stream. 00:13:33,720 --> 00:13:37,920
从指令流做。
--And that's not really the topic of this course. 00:13:37,920 --> 00:13:40,120
这不是本课程的主题。
--So we're not going to spend a lot of time 00:13:40,120 --> 00:13:42,240
所以我们不会花很多时间
--talking about it here. 00:13:42,240 --> 00:13:44,040
在这里谈论它。
--But it's important to recognize that at this sort of low level 00:13:44,040 --> 00:13:47,760
但重要的是要认识到在这种低水平
--of even your pure sequential code, 00:13:47,760 --> 00:13:50,920
甚至你的纯顺序代码，
--a lot can be done to make it run faster or slower based 00:13:50,920 --> 00:13:54,200
可以做很多事情来让它运行得更快或更慢
--on how you write that code and how clever your compiler is. 00:13:54,200 --> 00:13:57,200
关于您如何编写该代码以及您的编译器有多聪明。
--There's also a lot of control logic 00:14:02,680 --> 00:14:07,080
还有很多控制逻辑
--that tries to kind of predict what's going on 00:14:07,080 --> 00:14:11,280
试图预测正在发生的事情
--and deal with it when it predicts incorrectly. 00:14:11,280 --> 00:14:13,560
并在预测错误时进行处理。
--So for example, that black logic shows 00:14:13,560 --> 00:14:17,200
因此，例如，黑色逻辑显示
--what's called the branch target buffer, which 00:14:17,200 --> 00:14:19,720
所谓的分支目标缓冲区，它
--keeps a record for all the control flow instructions, 00:14:19,720 --> 00:14:24,480
保留所有控制流指令的记录，
--the jumps, and so forth, where they've gone in the past, 00:14:24,480 --> 00:14:28,920
跳跃等等，他们过去去过的地方，
--predicting that they'll go there in the future again. 00:14:28,920 --> 00:14:32,040
预测他们将来会再次去那里。
--So to try and, instead of having to wait and see 00:14:32,040 --> 00:14:35,000
所以去尝试，而不是等待和观察
--if there's a conditional branch, which way it's going to go, 00:14:35,000 --> 00:14:38,840
如果有一个条件分支，它会走哪条路，
--to basically guess and start predicting 00:14:38,840 --> 00:14:41,880
基本上猜测并开始预测
--as if you are certain that's the way things will go, 00:14:41,880 --> 00:14:45,960
就好像你确定事情会这样，
--begin executing those instructions 00:14:45,960 --> 00:14:48,840
开始执行那些指令
--and hopefully that made the correct guess 00:14:48,840 --> 00:14:51,720
并希望做出正确的猜测
--and it can just zip along without having 00:14:51,720 --> 00:14:54,240
它可以在没有
--to wait for any of this conditional branching logic. 00:14:54,240 --> 00:14:57,920
等待任何这种条件分支逻辑。
--Or if it mispredicted, it basically 00:14:57,920 --> 00:15:02,120
或者如果它预测错误，它基本上
--has to back out and undo the effects. 00:15:02,120 --> 00:15:08,040
必须退出并撤消效果。
--Actually, what it does is it doesn't commit those results 00:15:08,040 --> 00:15:11,600
实际上，它所做的是不提交那些结果
--to the actual registers. 00:15:11,600 --> 00:15:13,680
到实际的寄存器。
--It will just flush away and act like it was a waste of time. 00:15:13,680 --> 00:15:18,720
它只会冲走，就像浪费时间一样。
--So a lot of logic to do that. 00:15:19,600 --> 00:15:21,920
这样做有很多逻辑。
--And all that's managed by this lower black box called 00:15:21,920 --> 00:15:25,760
所有这一切都由这个叫做
--the retirement unit that keeps track of which instructions 00:15:25,760 --> 00:15:28,480
跟踪哪些指令的退休单位
--actually should be completed and updating 00:15:28,480 --> 00:15:31,640
实际上应该完成和更新
--this state accordingly. 00:15:31,640 --> 00:15:33,880
此状态相应。
--As an aside, you probably heard this latest couple 00:15:33,880 --> 00:15:37,520
顺便说一句，你可能听说过这对最新的夫妇
--of malware attacks that just got a lot of press. 00:15:37,520 --> 00:15:44,720
刚刚受到大量媒体报道的恶意软件攻击。
--What are they called? 00:15:44,720 --> 00:15:46,960
他们叫什么？
--Meltdown Inspector. 00:15:46,960 --> 00:15:48,960
崩溃检查员。
--So those involved some very clever people figuring out 00:15:48,960 --> 00:15:53,160
所以那些涉及一些非常聪明的人弄清楚
--that this logic essentially leaks information 00:15:53,160 --> 00:15:58,200
这种逻辑本质上会泄露信息
--about what other processes are doing. 00:15:58,200 --> 00:16:01,080
关于其他进程正在做什么。
--And it's hard to imagine how complex it 00:16:01,080 --> 00:16:04,040
很难想象它有多复杂
--is to exploit these. 00:16:04,040 --> 00:16:06,360
就是利用这些。
--And people knew for years that there is this potential here. 00:16:06,360 --> 00:16:10,200
人们多年来就知道这里有这种潜力。
--But for people to actually be able to exploit it, 00:16:10,200 --> 00:16:13,160
但是为了让人们真正能够利用它，
--that's the new revelation. 00:16:13,160 --> 00:16:15,040
那是新的启示。
--So the point is that if I mispredict a branch 00:16:15,040 --> 00:16:21,840
所以关键是如果我错误地预测了一个分支
--and I start executing some code that 00:16:21,840 --> 00:16:24,000
然后我开始执行一些代码
--accesses some parts of memory that I wouldn't normally 00:16:24,000 --> 00:16:27,200
访问一些我通常不会访问的内存部分
--have the privilege to do, then I can 00:16:27,200 --> 00:16:30,960
有幸做，那我就可以
--look at the cache behavior of that 00:16:30,960 --> 00:16:33,000
看看它的缓存行为
--and see whether I get hits or misses. 00:16:33,000 --> 00:16:35,440
看看我是命中还是未命中。
--And that gives me a little bit, a tiny bit of information. 00:16:35,440 --> 00:16:38,320
这给了我一点点信息。
--The conditional branching and the cache timings 00:16:38,320 --> 00:16:42,640
条件分支和缓存时序
--give me a little bit of information 00:16:42,640 --> 00:16:44,320
给我一些信息
--about what would have happened if I'd actually 00:16:44,320 --> 00:16:46,520
关于如果我真的会发生什么
--access those memory locations. 00:16:46,520 --> 00:16:48,920
访问那些内存位置。
--And then this gets marked as failed. 00:16:48,920 --> 00:16:52,560
然后这被标记为失败。
--It fails these tests because it's 00:16:52,560 --> 00:16:56,920
它没有通过这些测试，因为它是
--out of the range of valid addresses 00:16:56,920 --> 00:16:59,760
超出有效地址范围
--for this particular process. 00:16:59,760 --> 00:17:01,600
对于这个特定的过程。
--But it leaks information via timings 00:17:01,600 --> 00:17:06,880
但它通过时间泄露信息
--and via changes to the branch prediction logic that 00:17:06,880 --> 00:17:10,560
并通过对分支预测逻辑的更改
--can be exploited, essentially. 00:17:10,560 --> 00:17:13,000
本质上可以被利用。
--And you'll see that they're describing 00:17:13,000 --> 00:17:16,080
你会看到他们在描述
--that they're extracting this information at relatively 00:17:16,080 --> 00:17:19,160
他们正在相对地提取这些信息
--low rates in terms of bits per second 00:17:19,160 --> 00:17:21,320
以每秒比特数表示的低速率
--that they're pulling this information out. 00:17:21,320 --> 00:17:23,080
他们正在提取这些信息。
--Because you have to run over and over again 00:17:23,080 --> 00:17:25,720
因为你要跑一遍又一遍
--and set it up in various patterns 00:17:25,720 --> 00:17:28,160
并设置成各种模式
--to get information from these timings. 00:17:28,160 --> 00:17:30,560
从这些时间获取信息。
--But that's, in essence, what those are. 00:17:30,560 --> 00:17:33,280
但本质上，这就是那些。
--And it's really a huge problem because this is right down 00:17:33,280 --> 00:17:37,320
这真的是一个大问题，因为它就在下面
--in the dirty, the main part of the hardware that's 00:17:37,320 --> 00:17:40,720
在肮脏的地方，硬件的主要部分是
--the most performance-critical part of the whole system. 00:17:40,720 --> 00:17:44,760
整个系统中性能最关键的部分。
--And so to make it so that this information doesn't leak out, 00:17:44,760 --> 00:17:49,080
为了不让这些信息泄露出去，
--these timing-based attacks can't occur is really a trick. 00:17:49,080 --> 00:17:52,200
这些基于时间的攻击不能发生真是一个把戏。
--So that's an interesting aside that 00:17:52,200 --> 00:17:55,040
所以这很有趣
--happens to be in the news today. 00:17:55,040 --> 00:17:56,440
今天恰好出现在新闻中。
--So anyways, if you look then up through 2004, 00:18:00,080 --> 00:18:04,880
所以无论如何，如果你回顾 2004 年，
--the hardware designers were just adding 00:18:04,880 --> 00:18:06,680
硬件设计师只是在添加
--more and more of this hardware onto the system 00:18:06,680 --> 00:18:09,760
越来越多的这种硬件进入系统
--to improve the performance of conventional code, 00:18:09,760 --> 00:18:13,840
提高常规代码的性能，
--essentially extracting only very low-level parallelism out 00:18:13,840 --> 00:18:17,520
基本上只提取非常低级的并行性
--of the code itself dynamically as the instructions were 00:18:17,520 --> 00:18:21,280
代码本身动态地作为指令
--fetched out of the instruction stream. 00:18:21,280 --> 00:18:24,560
从指令流中取出。
--And so you could think of that the chip was dedicated 00:18:24,560 --> 00:18:28,360
所以你可以认为芯片是专用的
--to, first, a very big cache and a lot of control logic 00:18:28,360 --> 00:18:33,960
首先，一个非常大的缓存和大量的控制逻辑
--to do this out-of-order execution and branch 00:18:33,960 --> 00:18:37,280
执行此乱序执行和分支
--prediction. 00:18:37,280 --> 00:18:38,680
预言。
--And so forth. 00:18:38,680 --> 00:18:40,120
等等。
--And actually, relatively little, the ALUs, 00:18:40,120 --> 00:18:43,840
实际上，ALU 相对较少，
--if you look at the hardware, the space on the chip 00:18:43,840 --> 00:18:46,800
如果你看硬件，芯片上的空间
--actually took relatively little space. 00:18:46,800 --> 00:18:49,200
实际上占用的空间相对较小。
--And now they've added more and more of those 00:18:49,200 --> 00:18:51,520
现在他们添加了越来越多的
--because, essentially, the hardware is free for that. 00:18:51,520 --> 00:18:55,520
因为，本质上，硬件是免费的。
--And the biggest problems have to do with this control logic 00:18:55,520 --> 00:18:58,680
最大的问题与这种控制逻辑有关
--and making the cache bigger. 00:18:58,680 --> 00:19:02,120
并使缓存更大。
--So that's sort of where the things were going. 00:19:02,120 --> 00:19:06,600
这就是事情的发展方向。
--But now, as you know, we're in a different era 00:19:06,600 --> 00:19:08,640
但是现在，如你所知，我们处在一个不同的时代
--where we can't just, first of all, 00:19:08,640 --> 00:19:10,880
我们不能只是，首先，
--they can only squeeze so much juice out of this rock 00:19:10,880 --> 00:19:15,440
他们只能从这块岩石中榨取这么多汁液
--that they can only extract some amount of instruction-level 00:19:15,440 --> 00:19:18,720
他们只能提取一定数量的指令级
--parallelism, about a three- to five-fold parallelism. 00:19:18,720 --> 00:19:23,720
并行性，大约三到五倍的并行性。
--And then there just wasn't more because the programs weren't 00:19:23,720 --> 00:19:26,280
然后就没有更多了，因为程序不是
--written with parallel computing in mind. 00:19:26,280 --> 00:19:30,600
编写时考虑了并行计算。
--But also because this was just more and more, 00:19:30,600 --> 00:19:33,960
但也因为这只是越来越多，
--they couldn't just shrink the transistors 00:19:33,960 --> 00:19:35,680
他们不能只是缩小晶体管
--and run the chips faster because they 00:19:35,680 --> 00:19:36,960
并更快地运行芯片，因为它们
--reached these power limits. 00:19:36,960 --> 00:19:38,080
达到了这些功率限制。
--So the idea then was to say, well, 00:19:42,520 --> 00:19:46,600
所以当时的想法是说，嗯，
--if we're going to use all this hardware, 00:19:46,600 --> 00:19:48,680
如果我们要使用所有这些硬件，
--instead of just building one giant monolithic processor, 00:19:48,680 --> 00:19:53,480
而不是仅仅构建一个巨大的单片处理器，
--let's go ahead and split it into multiple processors 00:19:53,480 --> 00:20:01,480
让我们继续将它分成多个处理器
--that each of them will be somewhat less 00:20:01,480 --> 00:20:04,520
他们每个人都会少一些
--capable than the original, but I'll have two of them. 00:20:04,560 --> 00:20:08,000
比原来的更有能力，但我会有两个。
--So if you imagine, for example, each of these 00:20:08,000 --> 00:20:10,800
所以，如果你想象，例如，这些中的每一个
--is 25% slower than the original one, or 0.7, 5, the performance. 00:20:10,800 --> 00:20:20,320
比原来慢了 25%，或者 0.7，5，性能。
--But if I have two of them, that would apparently 00:20:20,320 --> 00:20:23,440
但如果我有两个，那显然
--give me a potential for a 1.5 times speedup. 00:20:23,440 --> 00:20:26,400
给我一个 1.5 倍加速的潜力。
--And so I'm ahead of the game. 00:20:26,400 --> 00:20:28,760
所以我领先于比赛。
--OK. 00:20:29,760 --> 00:20:32,200
好的。
--Well, there's a problem that this program that we've written 00:20:32,200 --> 00:20:35,680
好吧，我们写的这个程序有一个问题
--is just a pure sequential program. 00:20:35,680 --> 00:20:37,480
只是一个纯顺序程序。
--It has no parallelism in it at all. 00:20:37,480 --> 00:20:39,960
它根本没有并行性。
--So how am I supposed to, if I map this onto that machine 00:20:39,960 --> 00:20:44,840
那么，如果我将其映射到那台机器上，我该怎么办
--that I just showed, it would only use one of those two 00:20:44,840 --> 00:20:47,160
我刚刚展示的，它只会使用这两个中的一个
--cores, and it would run at 0.75 times the original program. 00:20:47,160 --> 00:20:51,680
核心，它的运行速度是原始程序的 0.75 倍。
--So that didn't seem very attractive. 00:20:51,680 --> 00:20:54,160
所以这看起来不是很吸引人。
--OK. 00:20:55,160 --> 00:20:57,360
好的。
--So one option, and this is essentially 00:20:57,360 --> 00:21:00,120
所以一个选择，这本质上是
--what the first part of the assignment one does, 00:21:00,120 --> 00:21:02,880
作业的第一部分是做什么的，
--is say, well, I know how to write threaded code using 00:21:02,880 --> 00:21:06,560
就是说，好吧，我知道如何使用
--p threads. 00:21:06,560 --> 00:21:07,760
p 线程。
--And so here's a simple example. 00:21:07,760 --> 00:21:09,960
这是一个简单的例子。
--What I'll do is split my n numbers 00:21:09,960 --> 00:21:12,320
我要做的是拆分我的 n 个数字
--into two pieces of size n over 2, approximately, 00:21:12,320 --> 00:21:17,240
分成大小为 n 多于 2 的两块，大约，
--plus or minus 1 each. 00:21:17,240 --> 00:21:19,440
每项正负 1。
--And I'll spin off one thread that 00:21:19,440 --> 00:21:22,280
我将分拆一个线程
--will do the first half of those numbers. 00:21:22,320 --> 00:21:25,600
将完成这些数字的前半部分。
--And then I'll let my main thread do 00:21:25,600 --> 00:21:27,320
然后我会让我的主线程做
--the second half of those numbers. 00:21:27,320 --> 00:21:28,800
这些数字的后半部分。
--So it's a very straightforward split. 00:21:28,800 --> 00:21:32,240
所以这是一个非常简单的拆分。
--And of course, it works in this case, 00:21:32,240 --> 00:21:34,120
当然，它在这种情况下有效，
--because this is a very trivial program to parallelize. 00:21:34,120 --> 00:21:40,360
因为这是一个非常简单的并行化程序。
--But it's kind of a pain now from a programmer's perspective. 00:21:40,360 --> 00:21:43,000
但从程序员的角度来看，这现在有点痛苦。
--P threads is, as you know, not a lot of fun 00:21:43,000 --> 00:21:46,200
如您所知，P 线程并不是很有趣
--to write the code for. 00:21:46,200 --> 00:21:47,240
编写代码。
--And you'll find it's an even harder one 00:21:47,240 --> 00:21:51,200
你会发现它更难
--to try and optimize performance on. 00:21:51,200 --> 00:21:52,920
尝试优化性能。
--There's just a lot of places where 00:21:52,920 --> 00:21:55,120
只是有很多地方
--the code doesn't get the kind of speed-ups you'd expect it to. 00:21:55,120 --> 00:21:57,880
该代码没有获得您期望的那种加速。
--So let's imagine instead that we had a more perfect world, 00:22:02,160 --> 00:22:05,800
所以让我们想象一下，我们有一个更完美的世界，
--where we had a language where we could sort of describe 00:22:05,800 --> 00:22:09,400
我们有一种语言可以描述
--this idea of embarrassingly parallel computing. 00:22:09,400 --> 00:22:11,840
这种令人尴尬的并行计算的想法。
--We could say, for all values of i between 0 and n minus 1, 00:22:11,840 --> 00:22:17,840
我们可以说，对于 0 到 n 减 1 之间的所有 i 值，
--do the following somehow. 00:22:17,840 --> 00:22:20,960
以某种方式执行以下操作。
--You figure out compiler slash hardware how to do this. 00:22:20,960 --> 00:22:26,840
你弄清楚编译器斜线硬件如何做到这一点。
--And it works in this notation here, 00:22:26,840 --> 00:22:29,280
它在这里以这种表示法工作，
--because again, if you look at that loop, 00:22:29,280 --> 00:22:33,360
因为再一次，如果你看那个循环，
--each iteration i is just a completely pure 00:22:33,360 --> 00:22:36,280
每次迭代我只是一个完全纯粹的
--and independent computation from any other value of i. 00:22:36,280 --> 00:22:39,960
和 i 的任何其他值的独立计算。
--So there's nothing really there that 00:22:39,960 --> 00:22:42,600
所以那里真的没有什么
--has to be synchronized, or coordinated, 00:22:42,600 --> 00:22:45,120
必须同步或协调，
--or sequenced in any way. 00:22:45,120 --> 00:22:46,960
或以任何方式排序。
--So you could imagine one version of it 00:22:47,000 --> 00:22:51,600
所以你可以想象它的一个版本
--just splitting this into k different threads, 00:22:51,600 --> 00:22:55,040
只是把它分成 k 个不同的线程，
--spawning k minus 1 of them, having 00:22:55,040 --> 00:22:59,880
产生 k 减 1 个，有
--each work on their appropriate parts of it, 00:22:59,880 --> 00:23:02,600
每个人都在适当的部分工作，
--come back together, and get the result. 00:23:02,600 --> 00:23:05,480
一起回来，得到结果。
--And so that's actually a kind of parallelism 00:23:05,480 --> 00:23:08,480
所以这实际上是一种并行性
--we'll look at later this term. 00:23:08,480 --> 00:23:11,040
我们稍后再看这个术语。
--Another version might try to say, well, 00:23:11,040 --> 00:23:14,280
另一个版本可能会说，嗯，
--let's look at a lower level of hardware. 00:23:14,280 --> 00:23:16,440
让我们看一下较低级别的硬件。
--Because we're really trying to do the same computation 00:23:16,960 --> 00:23:19,360
因为我们真的在尝试做同样的计算
--for all values of i. 00:23:19,360 --> 00:23:21,040
对于 i 的所有值。
--So we can kind of lockstep these together, 00:23:21,040 --> 00:23:23,800
所以我们可以把这些放在一起，
--and we'll look at that today as well. 00:23:23,800 --> 00:23:26,400
我们今天也会讨论这个问题。
--So let's just imagine for a while, 00:23:26,400 --> 00:23:28,760
所以让我们想象一下，
--and there actually is a language that 00:23:28,760 --> 00:23:30,880
实际上有一种语言
--has this general look and feel to it 00:23:30,880 --> 00:23:33,120
具有一般的外观和感觉
--that you'll be using in assignment one. 00:23:33,120 --> 00:23:34,800
你将在作业一中使用。
--So once we have that kind of notation and program, 00:23:39,240 --> 00:23:43,400
所以一旦我们有了那种符号和程序，
--then we can say, well, now we get 00:23:43,400 --> 00:23:45,280
那么我们可以说，好吧，现在我们得到了
--to sort of do whatever is the optimum trade-off, 00:23:45,280 --> 00:23:49,960
做任何事情是最佳的权衡，
--that we can build more but less capable processors on a chip, 00:23:49,960 --> 00:23:58,840
我们可以在芯片上构建更多但功能更弱的处理器，
--but we'll be able to get parallelism that way. 00:23:58,840 --> 00:24:03,320
但我们将能够通过这种方式获得并行性。
--And by the way, one thing you might ask is, well, 00:24:03,320 --> 00:24:05,640
顺便说一下，你可能会问的一件事是，嗯，
--how is this actually saving on power? 00:24:05,640 --> 00:24:07,200
这实际上是如何节省电量的？
--It seems like you're just trying to run 00:24:07,200 --> 00:24:10,800
好像你只是想逃跑
--a bunch of processors at the same time. 00:24:10,800 --> 00:24:12,760
同时处理一堆处理器。
--You're going to heat up the same way. 00:24:12,760 --> 00:24:14,720
你会以同样的方式升温。
--And to some level, that's true, but it turns out 00:24:14,720 --> 00:24:17,920
在某种程度上，这是真的，但事实证明
--that a big part of the power budget for a chip 00:24:17,920 --> 00:24:21,680
芯片功率预算的很大一部分
--is the cost of driving signals from one part of the circuit 00:24:21,680 --> 00:24:25,040
是从电路的一部分驱动信号的成本
--to another. 00:24:25,040 --> 00:24:26,600
给另一个。
--And so if you have a big processor spanning a big chip, 00:24:26,600 --> 00:24:30,540
所以如果你有一个跨越大芯片的大处理器，
--a lot of those signals have to go all the way 00:24:30,540 --> 00:24:32,440
很多这些信号必须一直传递
--from one end to the other, and that 00:24:32,440 --> 00:24:34,560
从一端到另一端，并且
--requires a big wop in drive power to make that happen. 00:24:34,560 --> 00:24:39,920
需要很大的驱动力才能实现这一目标。
--Whereas if you have a smaller number of ones, 00:24:39,920 --> 00:24:42,920
而如果你的人数较少，
--then your communication cost is less. 00:24:42,920 --> 00:24:46,800
那么你的沟通成本就更少了。
--So there is some actual advantage 00:24:46,800 --> 00:24:49,560
所以有一些实际的优势
--just in pure power budget and also in time budget, 00:24:49,560 --> 00:24:53,560
仅在纯功率预算和时间预算方面，
--because it doesn't take as long to get 00:24:53,560 --> 00:24:57,760
因为不需要很长时间
--a signal from one side of the chip to the other this way. 00:24:57,760 --> 00:25:01,840
以这种方式从芯片的一侧到另一侧的信号。
--So you could imagine coming up with various models of what 00:25:01,840 --> 00:25:06,960
所以你可以想象想出各种模型
--the trade-off is between power, performance, and chip area, 00:25:06,960 --> 00:25:12,600
在功率、性能和芯片面积之间进行权衡，
--and coming up and saying, now let's assume the ideal speedup. 00:25:12,600 --> 00:25:16,200
然后过来说，现在让我们假设理想的加速。
--And you could come with, for a given technology, what 00:25:16,200 --> 00:25:18,760
对于给定的技术，您可以使用什么
--would be the ideal number of cores to put on our chip? 00:25:18,760 --> 00:25:23,360
放置在我们芯片上的理想内核数是多少？
--And there's actually some. 00:25:27,200 --> 00:25:28,800
实际上有一些。
--You can buy various systems that look a lot like this, in fact. 00:25:28,800 --> 00:25:34,360
事实上，您可以购买各种看起来很像这样的系统。
--And you can see that a lot of the commercial designs 00:25:37,120 --> 00:25:40,280
你可以看到很多商业设计
--have essentially done that analysis 00:25:40,280 --> 00:25:42,400
基本上已经完成了该分析
--and come up with their own answers. 00:25:42,400 --> 00:25:44,520
并提出自己的答案。
--And of course, they have to do it. 00:25:44,520 --> 00:25:46,880
当然，他们必须这样做。
--They don't often have control over the software, 00:25:46,880 --> 00:25:49,600
他们通常无法控制软件，
--and so they have to do it based on their estimation of what 00:25:49,600 --> 00:25:54,760
所以他们必须根据他们对什么的估计来做
--their customer software is going to look like in terms of these. 00:25:54,760 --> 00:25:58,080
他们的客户软件将看起来像这些。
--How much can it be run in parallel? 00:25:58,080 --> 00:26:00,520
能并行多少？
--How much work will they do to make it go in parallel? 00:26:00,520 --> 00:26:03,600
他们将做多少工作才能使其并行进行？
--But you'll see that all modern processors have 00:26:03,600 --> 00:26:06,400
但是你会看到所有现代处理器都有
--at least more than one core. 00:26:06,400 --> 00:26:07,960
至少不止一个核心。
--Even the ones in a cell phone or a laptop 00:26:07,960 --> 00:26:11,320
即使是手机或笔记本电脑中的那些
--have at the very least two cores, and often more. 00:26:11,320 --> 00:26:14,080
至少有两个核心，通常更多。
--And sort of an extreme version of that 00:26:17,120 --> 00:26:22,120
有点极端的版本
--is these GPUs, graphic processing units, 00:26:22,120 --> 00:26:25,680
是这些GPU，图形处理单元，
--took the idea of cores and really pushed it even further. 00:26:25,680 --> 00:26:29,800
采纳了核心的想法，并真正将其推向了更远的地方。
--They sort of throw out all that baggage of branch prediction, 00:26:29,800 --> 00:26:35,760
他们扔掉了所有分支预测的包袱，
--out of order control logic and stuff, 00:26:35,760 --> 00:26:37,760
乱序控制逻辑和东西，
--and say that is just more ways to not 00:26:37,760 --> 00:26:40,840
并说那只是更多的方法
--get your computation done. 00:26:40,840 --> 00:26:42,920
完成你的计算。
--It's just control logic that is not actually 00:26:42,920 --> 00:26:48,280
这只是控制逻辑，实际上不是
--doing the real computation your program is asking for. 00:26:48,280 --> 00:26:51,840
进行程序要求的实际计算。
--And instead, stuff this hardware with as many cores as it could 00:26:51,840 --> 00:26:56,800
相反，用尽可能多的内核填充这个硬件
--and control it in a very special way that we'll discuss later. 00:26:56,800 --> 00:27:00,160
并以一种我们稍后将讨论的非常特殊的方式控制它。
--And so another version of it is Intel 00:27:01,160 --> 00:27:07,640
所以它的另一个版本是英特尔
--created a series of processors they 00:27:07,640 --> 00:27:10,800
他们创建了一系列处理器
--call Xeon Phi's, which is a really unfortunate name 00:27:10,800 --> 00:27:16,000
叫 Xeon Phi 的，这真是一个不幸的名字
--because it has absolutely nothing 00:27:16,000 --> 00:27:17,320
因为它一无所有
--to do with the Xeon of the Xeon processors we have in Gates. 00:27:17,320 --> 00:27:21,800
与我们在盖茨拥有的 Xeon 处理器中的 Xeon 有关。
--OK. 00:27:21,800 --> 00:27:22,280
好的。
--I found this on the web for reserved passages. 00:27:22,280 --> 00:27:24,880
我在网上找到这个用于保留段落。
--They call Xeon Phi, which is really unfortunate. 00:27:24,880 --> 00:27:27,640
他们叫Xeon Phi，这真是不幸。
--Take a look. 00:27:27,640 --> 00:27:28,160
看一看。
--This is really funny. 00:27:30,400 --> 00:27:32,600
这真的很有趣。
--Reserved passages they call Xeon Phi, 00:27:32,600 --> 00:27:35,160
他们称之为 Xeon Phi 的保留通道，
--which is really unfortunate. 00:27:35,160 --> 00:27:38,360
这真的很不幸。
--That's really neat. 00:27:38,360 --> 00:27:40,920
这真的很整洁。
--How did that happen? 00:27:40,920 --> 00:27:41,800
那是怎么发生的？
--Somehow it thought Siri's been listening to us. 00:27:41,800 --> 00:27:44,360
它以某种方式认为 Siri 一直在听我们讲话。
--OK. 00:27:50,920 --> 00:27:52,760
好的。
--It's technology. 00:27:52,760 --> 00:27:53,880
这是技术。
--So anyways, and we actually have Xeon, an earlier version 00:27:53,880 --> 00:27:57,880
所以无论如何，我们实际上有 Xeon，一个早期版本
--of the Xeon Phi's in the Gates machines, 00:27:57,880 --> 00:28:01,160
盖茨机器中的 Xeon Phi，
--and we'll be using them later this term. 00:28:01,160 --> 00:28:04,520
我们将在本学期晚些时候使用它们。
--And then Apple has gone through a series of chip designs. 00:28:04,520 --> 00:28:08,720
然后苹果经历了一系列的芯片设计。
--The latest is called A10 or 11 in the iPhone 10. 00:28:08,720 --> 00:28:14,840
最新的在 iPhone 10 中称为 A10 或 11。
--And actually, one of Apple's big advantages 00:28:14,840 --> 00:28:17,280
实际上，苹果的一大优势
--over its competitors has been a very good in-house chip 00:28:17,280 --> 00:28:22,440
优于其竞争对手的是一个非常好的内部芯片
--development group that creates their own processor 00:28:22,440 --> 00:28:25,400
创建自己的处理器的开发组
--chips, which are fabricated actually 00:28:25,440 --> 00:28:28,200
实际制造的芯片
--either in Taiwan or Korea, but not by Apple. 00:28:28,200 --> 00:28:33,520
在台湾或韩国，但不是苹果公司。
--That's another story. 00:28:33,520 --> 00:28:34,400
那是另一个故事了。
--So as I mentioned, one of the interesting parts of this code 00:28:40,880 --> 00:28:43,920
所以正如我提到的，这段代码中有趣的部分之一
--is you can imagine that there's like each step. 00:28:43,920 --> 00:28:50,960
你可以想象每一步都有。
--Another way of viewing this is thinking 00:28:50,960 --> 00:28:53,760
另一种看待这个问题的方式是思考
--I want to do x cubed for 1,000 values of x 00:28:53,760 --> 00:29:00,640
我想对 x 的 1,000 个值做 x 的立方
--all at the same time. 00:29:00,640 --> 00:29:02,360
所有在同一时间。
--And then I want to, in the inner loop, 00:29:02,360 --> 00:29:05,480
然后我想在内循环中
--I want to be doing these computations, 00:29:05,480 --> 00:29:09,720
我想做这些计算，
--but over all values of i simultaneously. 00:29:09,720 --> 00:29:12,880
但同时超过 i 的所有值。
--So that's another way, if you think of threads 00:29:12,880 --> 00:29:14,920
所以这是另一种方式，如果你想到线程
--as sort of vertical splitting. 00:29:14,920 --> 00:29:17,040
作为一种垂直分裂。
--I'll spawn off as many copies as I have of threads, 00:29:17,040 --> 00:29:21,640
我会产生尽可能多的线程副本，
--and each of them will be responsible for taking 00:29:21,640 --> 00:29:23,880
他们每个人都将负责
--one value of i from beginning to end in this computation. 00:29:23,880 --> 00:29:28,760
在此计算中从开始到结束 i 的一个值。
--Another is to think of this horizontally, 00:29:28,760 --> 00:29:30,800
另一个是横向思考这个问题，
--that I can simultaneously do all the multiplication, 00:29:30,800 --> 00:29:35,520
我可以同时做所有的乘法，
--the first multiplication of x cubed, 00:29:35,520 --> 00:29:37,480
 x 立方的第一次乘法，
--and then I'll do the second multiplication of x 00:29:37,480 --> 00:29:40,200
然后我会做 x 的第二次乘法
--cubed to get x cubed, and so forth, 00:29:40,200 --> 00:29:43,040
立方得到 x 的立方，等等，
--and step that whole thing one to another at each step 00:29:43,040 --> 00:29:48,720
并在每一步中一步一步地完成整个事情
--doing it for all values of i. 00:29:48,720 --> 00:29:50,280
对 i 的所有值都这样做。
--And I can imagine doing that by throwing more ALUs 00:29:53,480 --> 00:29:58,040
我可以想象通过投入更多 ALU 来做到这一点
--into my processor that are capable of performing 00:29:58,040 --> 00:30:02,960
进入我的处理器，能够执行
--operations, assuming that there's 00:30:02,960 --> 00:30:06,960
操作，假设有
--no actual dependencies between the operations I'm performing, 00:30:06,960 --> 00:30:10,120
我正在执行的操作之间没有实际依赖关系，
--so that they can all operate in parallel, 00:30:10,120 --> 00:30:12,320
这样它们就可以并行运行，
--and doing it with a single instruction that 00:30:12,320 --> 00:30:15,720
并通过一条指令完成
--will sequence these things. 00:30:16,720 --> 00:30:19,600
将对这些东西进行排序。
--And so that sometimes is called SIMD processing, 00:30:19,600 --> 00:30:22,640
因此，有时称为 SIMD 处理，
--which stands for Single Instruction Multiple Data. 00:30:22,640 --> 00:30:25,080
代表单指令多数据。
--So the idea is there's one instruction stream. 00:30:25,080 --> 00:30:28,960
所以这个想法是有一个指令流。
--It's saying add, but it's saying add eight values 00:30:28,960 --> 00:30:38,440
它说的是加法，但它说的是加八个值
--in one place, and eight values from another, 00:30:38,440 --> 00:30:41,160
在一个地方，另一个地方有八个值，
--and store those as eight different values. 00:30:41,160 --> 00:30:44,000
并将它们存储为八个不同的值。
--Sometimes those are referred to as vectors. 00:30:44,000 --> 00:30:46,880
有时这些被称为向量。
--So imagine your data is aggregated 00:30:46,880 --> 00:30:48,680
所以想象一下你的数据是聚合的
--into vectors of size eight, and you can do this all together. 00:30:48,680 --> 00:30:52,280
变成大小为 8 的向量，你可以一起做这一切。
--So this original program we saw is just 00:30:56,840 --> 00:31:03,920
所以我们看到的这个原始程序只是
--doing one value at a time. 00:31:03,920 --> 00:31:06,600
一次做一个值。
--So it's a pure sequential. 00:31:06,600 --> 00:31:08,040
所以这是一个纯粹的顺序。
--It would not make use of these eight different ALUs 00:31:08,040 --> 00:31:12,680
它不会使用这八个不同的 ALU
--because it's referring to just one data value at a time. 00:31:13,240 --> 00:31:18,720
因为它一次只引用一个数据值。
--But I could imagine a new class of instructions 00:31:27,880 --> 00:31:33,840
但我可以想象一类新的指令
--that can operate on, say, eight different values at a time. 00:31:33,840 --> 00:31:37,760
可以一次对八个不同的值进行操作。
--And that's exactly what you have in the so-called SIMD 00:31:37,760 --> 00:31:41,640
而这正是您在所谓的 SIMD 中所拥有的
--extensions that are supported by basically 00:31:41,640 --> 00:31:45,520
基本上支持的扩展
--all different processors. 00:31:45,520 --> 00:31:46,840
所有不同的处理器。
--And in Intel's latest iteration of these, 00:31:46,840 --> 00:31:50,360
在英特尔的最新迭代中，
--well, Intel's current iteration of these, it's called AVX2. 00:31:50,360 --> 00:31:54,280
好吧，英特尔当前的这些迭代称为 AVX2。
--So AVX stands for Advanced Vector Extensions. 00:31:54,280 --> 00:31:59,160
所以 AVX 代表高级矢量扩展。
--And the idea of it is you have special instructions that 00:31:59,160 --> 00:32:03,520
它的想法是你有特殊的指示
--can operate on eight values at a time. 00:32:03,520 --> 00:32:06,400
一次可以对八个值进行操作。
--Actually, it can operate on 32-bit data at a time, 00:32:06,400 --> 00:32:10,800
实际上，它一次可以操作 32 位数据，
--or 32 bytes of data at a time. 00:32:10,800 --> 00:32:13,720
或一次 32 个字节的数据。
--And if you're doing it with, we'll 00:32:13,720 --> 00:32:15,960
如果你这样做，我们会
--mostly talk about single-precision floating 00:32:15,960 --> 00:32:17,840
多说单精度浮点数
--points, so four-byte quantities, that 00:32:17,840 --> 00:32:20,840
点，所以四字节的数量，即
--means it can operate on eight of them. 00:32:20,840 --> 00:32:24,040
意味着它可以对其中的八个进行操作。
--And you can actually, through a very painful and unpleasant 00:32:24,040 --> 00:32:28,560
你实际上可以通过非常痛苦和不愉快的
--experience, you can write C code that operates and invokes 00:32:28,560 --> 00:32:33,320
有经验，可以写C代码运行调用
--these instructions explicitly. 00:32:33,320 --> 00:32:35,440
这些说明明确。
--And so these are called intrinsics. 00:32:35,480 --> 00:32:36,960
所以这些被称为内在函数。
--You're writing C code, but what you're really doing 00:32:36,960 --> 00:32:39,880
你在写 C 代码，但你真正在做什么
--is essentially giving very detailed instructions 00:32:39,880 --> 00:32:43,200
本质上是给出非常详细的说明
--to the compiler of exactly what instructions it should 00:32:43,200 --> 00:32:46,880
向编译器确切说明它应该执行的指令
--generate, what assembly code it should generate. 00:32:46,880 --> 00:32:50,720
generate，它应该生成什么样的汇编代码。
--And so you'll see that this all has the prefix MM256. 00:32:50,720 --> 00:32:58,160
所以你会看到这一切都有前缀 MM256。
--For some reason, they measure these things not in bytes, 00:32:58,160 --> 00:33:01,440
出于某种原因，他们不是以字节为单位来衡量这些东西，
--but in bits. 00:33:01,440 --> 00:33:02,120
但在位。
--So 32 bytes is 256 bits. 00:33:02,120 --> 00:33:08,160
所以 32 字节是 256 位。
--And so there is a special data type 00:33:08,160 --> 00:33:11,040
所以有一种特殊的数据类型
--called an __M256, which is just 32-bit bytes 00:33:11,040 --> 00:33:16,720
称为 __M256，它只是 32 位字节
--worth of information. 00:33:16,720 --> 00:33:19,520
有价值的信息。
--And then there's essentially these very low-level codes 00:33:19,520 --> 00:33:24,920
然后基本上是这些非常低级的代码
--that tell you what to do. 00:33:24,920 --> 00:33:26,200
告诉你该怎么做。
--So for example, load PS. 00:33:26,200 --> 00:33:29,240
例如，加载 PS。
--So PS means packed single, meaning 00:33:29,240 --> 00:33:34,240
所以PS的意思是packed single，意思是
--a vector's worth of single-precision floating 00:33:34,240 --> 00:33:37,360
向量的单精度浮点值
--quantities. 00:33:37,360 --> 00:33:38,720
数量。
--And then you give a pointer to the starting memory location. 00:33:38,720 --> 00:33:44,840
然后你给出一个指向起始内存位置的指针。
--And you'll see at the upper part here in this loop 00:33:44,840 --> 00:33:49,160
你会在这个循环的上半部分看到
--that what we're doing is we're unrolling this loop 00:33:49,160 --> 00:33:52,040
我们正在做的是展开这个循环
--by a factor of 8, because what we're going to do 00:33:52,040 --> 00:33:55,120
8 倍，因为我们要做的
--is fire off a series of vector instructions 00:33:55,760 --> 00:33:59,680
是触发一系列向量指令
--for the first eight values of i, then come around, 00:33:59,680 --> 00:34:02,960
对于 i 的前八个值，然后过来，
--fire off the vector instructions for the next one, and so forth, 00:34:02,960 --> 00:34:06,640
触发下一条的矢量指令，依此类推，
--and perform that computation in blocks of eight data values 00:34:06,640 --> 00:34:12,560
并在八个数据值的块中执行该计算
--at a time. 00:34:12,560 --> 00:34:13,520
一次。
--But it has this field, as I mentioned, 00:34:13,520 --> 00:34:15,960
但它有这个领域，正如我提到的，
--this horizontal field that we're grabbing. 00:34:15,960 --> 00:34:19,920
我们正在抓住的这个水平领域。
--We're doing all the first set of multiplies 00:34:19,920 --> 00:34:23,520
我们正在做所有的第一组乘法
--for the first eight data values at a time, then the next ones 00:34:23,520 --> 00:34:28,240
一次获取前八个数据值，然后是下一个
--and the next ones. 00:34:28,240 --> 00:34:29,400
和下一个。
--But it's a single instruction that 00:34:29,400 --> 00:34:32,640
但这是一条指令
--does this, a special extension to the regular instruction set. 00:34:32,640 --> 00:34:38,080
这样做是对常规指令集的特殊扩展。
--And this goes on. 00:34:38,080 --> 00:34:39,520
这还在继续。
--You can look at, and you'll see that these all 00:34:39,520 --> 00:34:41,680
你可以看看，你会看到这些
--map pretty directly into the operations that were performed 00:34:41,680 --> 00:34:47,280
直接映射到执行的操作
--in the original code. 00:34:47,280 --> 00:34:48,760
在原始代码中。
--But obviously, this doesn't look anything 00:34:48,760 --> 00:34:50,680
但很明显，这看起来没什么
--like the original code. 00:34:50,680 --> 00:34:51,760
就像原始代码一样。
--We had to rewrite the whole program 00:34:51,760 --> 00:34:54,200
我们不得不重写整个程序
--in this very explicit notation. 00:34:54,200 --> 00:34:55,640
在这个非常明确的符号中。
--I don't recommend it, if you can help it. 00:34:58,520 --> 00:35:02,640
我不推荐它，如果你能帮助它。
--But then if you look at the compiled code, 00:35:02,640 --> 00:35:05,120
但是如果你看一下编译后的代码，
--you'll see it spits out these funny-looking instructions 00:35:05,120 --> 00:35:09,760
你会看到它吐出这些看起来很滑稽的指令
--that each of those is operating on eight values. 00:35:09,760 --> 00:35:15,080
每一个都在八个值上运行。
--So ps, again, is the notation means packed single. 00:35:15,080 --> 00:35:18,880
所以 ps 再次是表示打包单个的符号。
--And so it's a vector load packed single 00:35:18,880 --> 00:35:21,880
所以它是一个矢量负载打包单
--into a register called an XMM register using some address. 00:35:21,880 --> 00:35:27,680
使用一些地址进入称为 XMM 寄存器的寄存器。
--And all these various ones, there's the equivalent. 00:35:27,680 --> 00:35:32,200
所有这些不同的，都有等价物。
--There is the v mul ps is vector multiply packed singles 00:35:32,200 --> 00:35:40,600
有 v mul ps 是向量乘法打包单打
--from using two registers as the source 00:35:40,600 --> 00:35:43,760
从使用两个寄存器作为源
--and another register as the destination. 00:35:43,760 --> 00:35:48,240
另一个注册为目的地。
--So the compiled code, then, looks 00:35:48,240 --> 00:35:50,040
所以编译后的代码看起来
--very different from the compiled code of our original thing. 00:35:50,040 --> 00:35:52,720
与我们原始事物的编译代码非常不同。
--We've very explicitly told the processor 00:35:52,720 --> 00:35:56,120
我们已经非常明确地告诉处理者
--how to extract eight-fold parallelism out of this code. 00:35:56,120 --> 00:36:00,400
如何从这段代码中提取八倍并行性。
--So now you can imagine juicing up 00:36:07,760 --> 00:36:10,560
所以现在你可以想象榨汁
--if we had our mythical 16-core machine, each of which 00:36:10,560 --> 00:36:15,200
如果我们有神话般的 16 核机器，每一个
--had eight of these, eight ALUs worth of vector processing. 00:36:15,200 --> 00:36:22,080
有八个这样的，八个 ALU 的向量处理。
--And I should mention, we'll talk about it in a minute. 00:36:22,080 --> 00:36:24,840
我应该提一下，我们会在一分钟内讨论它。
--But at least now, just think of it 00:36:24,840 --> 00:36:26,760
但至少现在想想
--as each SIMD instruction is operating on eight values. 00:36:26,760 --> 00:36:30,280
因为每个 SIMD 指令都对八个值进行操作。
--And we'll talk about what happens 00:36:30,280 --> 00:36:31,760
我们将讨论会发生什么
--if they're bigger or smaller words than that. 00:36:31,760 --> 00:36:35,920
如果它们比那个更大或更小的话。
--So I could potentially then, at relatively low cost, 00:36:35,920 --> 00:36:41,840
所以我可能会以相对较低的成本，
--because these only take up the real estate of the ALUs, 00:36:41,840 --> 00:36:44,720
因为这些只占用 ALU 的空间，
--which is relatively small, sort of juice up and get 00:36:44,720 --> 00:36:48,320
这是相对较小的，有点果汁了
--potentially 128-fold parallelism out of this program. 00:36:48,320 --> 00:36:52,000
这个程序可能有 128 倍的并行性。
--But in order to do that, I have to have 128 things that 00:36:52,000 --> 00:36:55,000
但为了做到这一点，我必须拥有 128 件东西
--are completely independent of each other that 00:36:55,000 --> 00:36:57,080
彼此完全独立
--can be done parallel. 00:36:57,080 --> 00:36:58,280
可以并行完成。
--Yes, question back there. 00:36:58,280 --> 00:36:59,720
是的，在那里提问。
--So in the previous slide, you mentioned 00:36:59,720 --> 00:37:01,720
所以在上一张幻灯片中，您提到
--the different processor registers, right? 00:37:01,720 --> 00:37:03,720
不同的处理器寄存器，对吧？
--X, Y, and Z. How are they different from the normal 00:37:03,720 --> 00:37:06,720
 X、Y 和 Z。它们与正常的有何不同
--register? 00:37:06,720 --> 00:37:09,520
登记？
--So this is in Intel. 00:37:09,520 --> 00:37:13,400
所以这是在英特尔。
--You remember registers like RAX and RDX. 00:37:13,400 --> 00:37:16,680
您还记得像 RAX 和 RDX 这样的寄存器。
--Those can only hold 64 bits, right? 00:37:16,680 --> 00:37:20,480
那些只能容纳 64 位，对吗？
--The XMM registers are special 32-byte registers, 00:37:20,480 --> 00:37:25,800
 XMM 寄存器是特殊的 32 字节寄存器，
--256-bit registers that are used to support these vector 00:37:25,800 --> 00:37:31,480
用于支持这些向量的 256 位寄存器
--instructions. 00:37:31,480 --> 00:37:32,920
指示。
--So it's a whole different independent register 00:37:32,920 --> 00:37:34,920
所以这是一个完全不同的独立寄存器
--set from the regular program registers. 00:37:34,920 --> 00:37:36,960
从常规程序寄存器设置。
--But they have the same core. 00:37:36,960 --> 00:37:38,720
但它们有相同的内核。
--Yes, the core has all these registers. 00:37:38,720 --> 00:37:42,480
是的，核心有所有这些寄存器。
--And actually, nowadays, even the regular floating point, 00:37:42,480 --> 00:37:47,680
实际上，如今，即使是常规的浮点数，
--the non-vectorized floating point, 00:37:47,680 --> 00:37:49,680
非矢量化浮点数，
--makes use of the XMM registers. 00:37:49,680 --> 00:37:52,320
使用 XMM 寄存器。
--But it will only make use of the sort of lower 4 or 8 00:37:52,320 --> 00:37:56,120
但它只会使用较低的 4 或 8
--bytes of that register instead of the full 32. 00:37:56,120 --> 00:37:59,060
该寄存器的字节而不是完整的 32。
--Question? 00:37:59,060 --> 00:37:59,560
问题？
--You wrote the potential code, but manually 00:37:59,560 --> 00:38:01,560
您编写了潜在的代码，但是手动
--looped and rolled it by 8 times. 00:38:01,560 --> 00:38:03,040
循环并滚动 8 次。
--Is it common for a compiler to actually generate these? 00:38:03,040 --> 00:38:06,520
编译器实际生成这些是否很常见？
--So that's a really good question. 00:38:06,520 --> 00:38:08,600
所以这是一个非常好的问题。
--Isn't there some way I could have my compiler figure this 00:38:08,600 --> 00:38:13,280
有没有什么办法可以让我的编译器解决这个问题
--out and not have to have me do it with intrinsics? 00:38:13,280 --> 00:38:17,680
出来，而不必让我用内在函数来做？
--And the idea is, wouldn't that be nice? 00:38:17,680 --> 00:38:22,720
这个想法是，那不是很好吗？
--And the longer answer is, yes. 00:38:22,720 --> 00:38:26,000
更长的答案是，是的。
--And you can go on the web and find how GCC, 00:38:26,000 --> 00:38:30,000
你可以在网上找到 GCC，
--what it will take to get GCC to automatically vectorize 00:38:30,000 --> 00:38:33,160
让 GCC 自动矢量化需要什么
--this code. 00:38:33,160 --> 00:38:34,240
这个代码。
--And you have to stand on your head 00:38:34,240 --> 00:38:36,000
你必须倒立
--and give it all kinds of hints and special stuff 00:38:36,000 --> 00:38:38,640
并给它各种提示和特殊的东西
--and conditions. 00:38:38,640 --> 00:38:39,880
和条件。
--And finally, if it's all perfect, then kaboom, 00:38:39,880 --> 00:38:42,920
最后，如果这一切都完美，那么 kaboom，
--it will vectorize the code for you. 00:38:42,920 --> 00:38:45,840
它会为你向量化代码。
--So unfortunately, people thought compilers 00:38:45,840 --> 00:38:50,440
不幸的是，人们认为编译器
--would be able to do this. 00:38:50,440 --> 00:38:51,560
将能够做到这一点。
--And there's been a lot of work on it. 00:38:51,560 --> 00:38:53,880
在这方面已经做了很多工作。
--But only for very structured, carefully written code 00:38:53,880 --> 00:38:58,160
但仅适用于非常结构化、精心编写的代码
--can it do automatic vectorization. 00:38:58,160 --> 00:39:00,360
它可以进行自动矢量化吗？
--So the interesting feature about this program 00:39:07,000 --> 00:39:15,120
这个程序的有趣之处
--that we've written is you could imagine exploiting 00:39:15,120 --> 00:39:19,520
我们写的是你可以想象的利用
--both forms of parallelism. 00:39:19,520 --> 00:39:21,680
两种形式的并行性。
--Like I said, you could have multiple threads, each 00:39:21,680 --> 00:39:24,640
就像我说的，你可以有多个线程，每个
--of which use SIMD processing to work on chunks of data. 00:39:24,640 --> 00:39:31,320
其中使用 SIMD 处理来处理数据块。
--So that 128-fold parallelism, you 00:39:32,320 --> 00:39:36,200
所以 128 倍并行性，你
--could imagine via some type of compiler 00:39:36,200 --> 00:39:40,960
可以想象通过某种类型的编译器
--actually pulling out of programs like this. 00:39:40,960 --> 00:39:43,440
实际上退出这样的程序。
--But there's a few sticky points in this. 00:39:47,880 --> 00:39:50,880
但是这里有一些棘手的问题。
--And so let's look at the SIMD execution. 00:39:50,880 --> 00:39:53,920
因此，让我们看一下 SIMD 执行。
--That previous example had the advantage 00:39:53,920 --> 00:39:55,880
前面的例子有优势
--that for all values of i, I was just 00:39:55,880 --> 00:39:57,800
对于 i 的所有值，我只是
--doing the exact same thing. 00:39:57,800 --> 00:40:00,200
做同样的事情。
--And so it was very easy to vectorize. 00:40:00,200 --> 00:40:02,360
因此，矢量化非常容易。
--But what happens if there's a conditional? 00:40:02,360 --> 00:40:05,600
但是如果有条件会发生什么？
--So imagine there's some code in there 00:40:05,600 --> 00:40:07,800
所以想象一下那里有一些代码
--that looks at the value of a of i, call it x, 00:40:07,800 --> 00:40:13,040
查看 i 的 a 的值，称它为 x，
--and does one thing if x is greater than 0 00:40:13,040 --> 00:40:15,280
如果 x 大于 0，则做一件事
--and something different if x is less than or equal to 0. 00:40:15,280 --> 00:40:20,320
如果 x 小于或等于 0，则不同。
--It doesn't matter exactly what it does, 00:40:20,320 --> 00:40:22,080
它做什么并不重要，
--but you get the idea. 00:40:22,080 --> 00:40:24,000
但你明白了。
--Well, the idea in the SIMD world is to say, 00:40:24,000 --> 00:40:27,560
好吧，SIMD 世界的想法是说，
--well, I potentially have to go both ways. 00:40:27,560 --> 00:40:31,000
好吧，我可能必须双向选择。
--But what I'll do is I'll set up a mask so that x greater than 0 00:40:31,000 --> 00:40:39,360
但我要做的是设置一个掩码，使 x 大于 0
--is a test that's performed on all eight values of x 00:40:39,360 --> 00:40:44,920
是对 x 的所有八个值执行的测试
--in parallel. 00:40:44,920 --> 00:40:46,040
在平行下。
--And the result will be either true or false. 00:40:46,040 --> 00:40:48,960
结果要么为真，要么为假。
--And now I'll use that set of trues and falses 00:40:48,960 --> 00:40:54,280
现在我将使用那组真假
--as a so-called mask that determines 00:40:54,680 --> 00:40:57,400
作为所谓的面具，决定
--what takes place next. 00:40:57,400 --> 00:40:59,560
接下来会发生什么。
--So in particular, for all the cases where it's true, 00:40:59,560 --> 00:41:03,520
所以特别是对于所有正确的情况，
--I will go ahead and perform the operations that are listed. 00:41:03,520 --> 00:41:07,200
我将继续执行列出的操作。
--But I will disable the operations 00:41:10,840 --> 00:41:13,520
但我会禁用操作
--that are marked as false. 00:41:13,520 --> 00:41:15,680
被标记为假的。
--Either I won't perform them, or if I perform them, 00:41:15,680 --> 00:41:18,520
要么我不表演它们，要么如果我表演它们，
--I won't save the results in the register. 00:41:18,520 --> 00:41:21,320
我不会将结果保存在寄存器中。
--I'll prevent them from actually writing to the registers. 00:41:21,320 --> 00:41:26,520
我会阻止他们实际写入寄存器。
--And similarly, I'll then do another phase 00:41:26,520 --> 00:41:29,400
同样，我会做另一个阶段
--where I'll say, OK, now let's flip that mask inverted 00:41:29,400 --> 00:41:34,480
我会说，好吧，现在让我们把面具倒过来
--and use that inverted mask to control the next sequence, 00:41:34,480 --> 00:41:38,160
并使用倒置的掩码来控制下一个序列，
--where I do all the work of the else part of the branch. 00:41:38,160 --> 00:41:41,800
我在那里完成分支的其他部分的所有工作。
--And I enable the ones that were false originally 00:41:41,800 --> 00:41:44,760
我启用了那些最初是错误的
--and disable the ones that were true. 00:41:44,760 --> 00:41:47,040
并禁用那些是真的。
--So basically, you've taken this branch 00:41:47,040 --> 00:41:50,640
所以基本上，你已经选择了这个分支
--and you've flattened it out into code 00:41:50,640 --> 00:41:54,400
你已经把它扁平化为代码
--that you can execute, so-called straight line code, 00:41:54,400 --> 00:41:57,600
你可以执行，所谓的直线代码，
--and just chug through it. 00:41:57,600 --> 00:41:59,880
并通过它。
--But for some of the data, we will 00:41:59,880 --> 00:42:02,600
但是对于某些数据，我们将
--allow those updates to occur. 00:42:02,600 --> 00:42:04,600
允许这些更新发生。
--And for others, we won't. 00:42:04,600 --> 00:42:05,980
对于其他人，我们不会。
--And so that, you can see, is the general idea 00:42:05,980 --> 00:42:08,200
所以，你可以看到，这是一般的想法
--for how to handle this. 00:42:08,200 --> 00:42:11,680
如何处理这个。
--And of course, the problem you can see 00:42:11,680 --> 00:42:13,480
当然，你可以看到的问题
--is that at best, I'm going to only get 50% efficiency out 00:42:13,880 --> 00:42:22,880
充其量我只能得到 50% 的效率
--of this, if I have a two-way branch 00:42:22,880 --> 00:42:25,720
其中，如果我有一个双向分支
--and they're roughly equal, a computation 00:42:25,720 --> 00:42:27,920
他们大致相等，计算
--has to be performed on each side of the branch, 00:42:27,920 --> 00:42:30,560
必须在分支的每一侧执行，
--because roughly half of the ALUs will 00:42:30,560 --> 00:42:35,840
因为大约一半的 ALU 会
--be idle on any given operation. 00:42:35,840 --> 00:42:39,520
在任何给定操作上处于空闲状态。
--And in the worst case, of course, if all of them are true, 00:42:39,520 --> 00:42:43,880
在最坏的情况下，当然，如果所有这些都是真的，
--then I don't have to do the false step. 00:42:43,880 --> 00:42:46,040
那么我就不必做错误的步骤了。
--And if all of them are false of these tests, 00:42:46,040 --> 00:42:48,560
如果所有这些测试都是错误的，
--I don't have to do the true part. 00:42:48,560 --> 00:42:49,920
我不必做真实的部分。
--So I can skip over stuff, potentially, 00:42:49,920 --> 00:42:53,200
所以我可以跳过一些东西，有可能，
--if I can detect that I have uniform behavior. 00:42:53,200 --> 00:42:57,680
如果我能检测到我有统一的行为。
--But in the worst case, you could imagine 00:42:57,680 --> 00:42:59,760
但在最坏的情况下，你可以想象
--I end up doing something only on behalf of one element. 00:42:59,760 --> 00:43:04,400
我最终只代表一个元素做某事。
--So all that fancy vector stuff I had, 00:43:04,400 --> 00:43:07,440
所以我所有那些花哨的矢量东西，
--I'm wasting 7 8ths of its computing power. 00:43:07,440 --> 00:43:12,160
我浪费了它八分之七的计算能力。
--But the good news is, after a branch like that, 00:43:15,760 --> 00:43:18,240
但好消息是，在这样的一个分支之后，
--it then comes back together again 00:43:18,240 --> 00:43:22,360
然后它又回到一起
--and now can resume execution. 00:43:22,360 --> 00:43:24,040
现在可以恢复执行了。
--So if there's potential for, because I've 00:43:24,040 --> 00:43:27,600
所以如果有潜力，因为我已经
--kept things all synchronized. 00:43:27,600 --> 00:43:29,200
保持一切同步。
--I'm not out of whack. 00:43:29,200 --> 00:43:31,640
我没有失控。
--All these are at the same point in the program. 00:43:31,640 --> 00:43:34,400
所有这些都在程序中的同一点上。
--They've just come back together. 00:43:34,400 --> 00:43:37,120
他们刚刚一起回来了。
--And now they can continue operating. 00:43:37,120 --> 00:43:40,880
现在他们可以继续运营了。
--So that's sort of how the general idea of SIMD operation 00:43:40,880 --> 00:43:44,480
这就是 SIMD 操作的一般概念
--works, that I can take even data-dependent operations 00:43:44,480 --> 00:43:48,680
有效，我什至可以进行数据相关的操作



--and execute them in this way by doing 00:43:48,680 --> 00:43:51,040
并以这种方式执行它们
--this trick of enabling and disabling 00:43:51,040 --> 00:43:54,120
这个启用和禁用的技巧
--some of the instructions. 00:43:54,120 --> 00:43:55,120
一些说明。
--So the term they use in this, in the SIMD world, 00:44:00,320 --> 00:44:05,080
所以他们在 SIMD 世界中使用的术语，
--and we're going to see a lot of this 00:44:05,080 --> 00:44:07,040
我们会看到很多这样的
--because this is one of the main parts of GPUs as well, 00:44:07,040 --> 00:44:10,240
因为这也是 GPU 的主要部分之一，
--is what they call coherence. 00:44:10,240 --> 00:44:12,160
这就是他们所说的连贯性。
--And that term coherent comes up also 00:44:12,160 --> 00:44:15,040
连贯这个词也出现了
--when you talk about caches later in the term, 00:44:15,040 --> 00:44:17,960
当你在学期后面谈论缓存时，
--has absolutely nothing to do with it. 00:44:17,960 --> 00:44:19,560
与它完全无关。
--So coherence in this sense means the extent 00:44:19,560 --> 00:44:24,040
因此，从这个意义上讲，连贯性意味着范围
--to which everyone wants to do the same thing. 00:44:24,040 --> 00:44:27,440
每个人都想做同样的事情。
--And therefore, I can kind of maximize the utilization 00:44:27,440 --> 00:44:30,080
因此，我可以最大限度地利用
--of this processing capability. 00:44:30,080 --> 00:44:32,280
这种处理能力。
--And anything that gets me away from that 00:44:32,280 --> 00:44:34,640

任何让我远离它的东西
--is referred to as divergence. 00:44:34,680 --> 00:44:37,440
称为背离divergence。
--So you can think of it converging 00:44:37,440 --> 00:44:39,480
所以你可以认为它收敛
--to the sort of ideal of SIMD or diverging away 00:44:39,480 --> 00:44:43,680
到 SIMD 的那种理想或发散
--from that ideal. 00:44:43,680 --> 00:44:46,560
从那个理想。
--Make sense? 00:44:46,560 --> 00:44:47,080
合理？
--So as I mentioned before, like the Gates machines 00:44:53,960 --> 00:44:58,720
所以正如我之前提到的，就像盖茨机器


--and most of the ones of modern era are based on the AVX. 00:44:58,720 --> 00:45:03,320
大多数现代时代都是基于 AVX 的。
--The current generation is called AVX2. 00:45:03,320 --> 00:45:06,040
当前这一代称为 AVX2。
--And the idea is that you saw that prefix 256, 00:45:06,040 --> 00:45:15,400
这个想法是你看到了前缀 256，
--but that's bits. 00:45:15,400 --> 00:45:16,640
但那是位。
--And so essentially, it gives you the choice. 00:45:16,640 --> 00:45:20,640
因此，从本质上讲，它为您提供了选择。
--You can actually do byte level operations 00:45:20,640 --> 00:45:23,280
您实际上可以进行字节级操作
--on 32 bytes independently, like byte and an OR, 00:45:23,280 --> 00:45:27,560
独立地在 32 个字节上，如字节和 OR，
--even byte level addition and arithmetic operations. 00:45:27,560 --> 00:45:31,960
甚至字节级加法和算术运算。
--Similarly for shorts, 2-byte data, 4-byte data, 00:45:31,960 --> 00:45:38,920
同样对于短裤，2字节数据，4字节数据，
--and 8-byte data. 00:45:38,920 --> 00:45:40,640
和 8 字节数据。
--And what happens with these is so the hardware is always 00:45:40,640 --> 00:45:44,600
这些会发生什么，所以硬件总是
--working on 32 bytes. 00:45:44,600 --> 00:45:46,280
处理 32 个字节。
--It's just how those are broken up into blocks. 00:45:46,280 --> 00:45:49,800
这就是将它们分解成块的方式。
--And it has enough logic in there to do in parallel, say, 00:45:49,800 --> 00:45:58,000
它有足够的逻辑可以并行执行，比如说，
--as many multiplies as you're asking for. 00:45:58,000 --> 00:46:01,560
与您要求的一样多。
--And also, floating point operations 00:46:01,680 --> 00:46:03,840
还有，浮点运算
--that can work on single precision or double precision. 00:46:03,840 --> 00:46:07,440
可以处理单精度或双精度。
--And it's just the difference is it 00:46:07,440 --> 00:46:09,120
只是区别在于
--will only do four double precision simultaneously 00:46:09,120 --> 00:46:12,760
只会同时做四个双精度
--or eight single precision simultaneously. 00:46:12,760 --> 00:46:16,400
或同时八个单精度。
--And then the next generation of it 00:46:22,960 --> 00:46:25,720
然后是下一代
--that's just sort of around the corner and the Xeon 00:46:25,720 --> 00:46:28,760
那只是指日可待，至强
--PHYs that I mentioned that we actually have here use. 00:46:28,760 --> 00:46:32,760
我提到的 PHY 我们实际上在这里使用。
--They didn't go from AVX2 to AVX3. 00:46:32,760 --> 00:46:35,400
他们没有从 AVX2 转到 AVX3。
--They went from AVX2 to AVX512, 512, of course, 00:46:35,400 --> 00:46:42,320
他们从 AVX2 到 AVX512，当然是 512，
--being the number of bits now and having nothing 00:46:42,320 --> 00:46:45,040
是现在的位数并且什么都没有
--to do with the generation. 00:46:45,040 --> 00:46:47,040
与一代人有关。
--So they just did the obvious expansion to do that. 00:46:47,040 --> 00:46:51,560
所以他们只是做了明显的扩展来做到这一点。
--And so that's nice. 00:46:55,400 --> 00:46:58,360
所以这很好。
--The people I know that sort of know about this stuff 00:46:58,360 --> 00:47:00,680
我认识的人都知道这件事
--say that's probably about as far as they should take it, 00:47:00,680 --> 00:47:03,480
说这可能是他们应该接受的程度，
--that there's just not that many. 00:47:03,480 --> 00:47:05,800
没有那么多。
--When you try to vectorize these things like divergence, 00:47:05,800 --> 00:47:09,840
当你试图将这些东西向量化时，比如发散，
--how long are the vectors that people really 00:47:09,840 --> 00:47:11,760
人们真正知道的向量有多长
--operate on and so forth sort of argue against just keep 00:47:11,760 --> 00:47:16,440
操作等等有点反对只保留
--making the vectors longer and longer. 00:47:16,440 --> 00:47:18,280
使矢量越来越长。
--So the sort of common belief is this 00:47:18,280 --> 00:47:21,240
所以那种普遍的信念是这样的
--is as far as the 512 will be as far as they go. 00:47:21,240 --> 00:47:23,920
就 512 的极限而言。
--But it's important to remember that this has to be the hardware 00:47:24,560 --> 00:47:31,720
但重要的是要记住这必须是硬件
--has to be very explicitly told to perform these vector 00:47:31,720 --> 00:47:35,120
必须非常明确地告知执行这些向量
--operations. 00:47:35,120 --> 00:47:36,320
操作。
--And so the code that's generated is explicit, 00:47:36,320 --> 00:47:39,480
所以生成的代码是明确的，
--specific to vector operations. 00:47:39,480 --> 00:47:41,960
特定于矢量操作。
--And either you need a terribly clever compiler 00:47:41,960 --> 00:47:45,240
要么你需要一个非常聪明的编译器
--or a terribly patient programmer to generate that kind of code. 00:47:45,240 --> 00:47:50,560
或非常耐心的程序员来生成那种代码。
--And again, you can inspect the .s files, the generated code, 00:47:54,920 --> 00:48:01,000
同样，您可以检查 .s 文件、生成的代码、
--and you can see if your code got vectorized or not. 00:48:01,000 --> 00:48:03,360
您可以查看您的代码是否已矢量化。
--So now let's talk about GPUs. 00:48:11,440 --> 00:48:13,560
那么现在让我们谈谈 GPU。
--And GPUs are a kind of different beast. 00:48:13,560 --> 00:48:16,640
 GPU 是一种不同的野兽。
--They give you essentially this model of what's sometimes 00:48:16,640 --> 00:48:22,480
他们基本上给你这个模型有时是什么
--called SPMD, Single Program Multiple Data. 00:48:22,480 --> 00:48:26,800
称为 SPMD，单程序多数据。
--So it gives you an image not of SIMD, Single Instruction 00:48:26,800 --> 00:48:30,360
所以它给你的图像不是 SIMD，单指令
--Multiple Data, but Single Program Multiple Data, 00:48:30,360 --> 00:48:33,240
多数据，但单程序多数据，
--meaning that different parts of the program 00:48:33,240 --> 00:48:35,720
这意味着程序的不同部分
--can be doing different things. 00:48:35,720 --> 00:48:37,640
可以做不同的事情。
--But underneath the hood, they actually 00:48:37,640 --> 00:48:39,480
但在引擎盖下，他们实际上
--use SIMD to implement much of the logic. 00:48:39,480 --> 00:48:42,800
使用 SIMD 来实现大部分逻辑。
--They use this sort of heterogeneous approach 00:48:42,800 --> 00:48:46,120
他们使用这种异构方法
--to getting this parallel. 00:48:46,120 --> 00:48:49,880
得到这个平行。
--So at some level, you express your computation of saying, 00:48:49,880 --> 00:48:53,480
所以在某种程度上，你表达了你的计算，
--I want n different additions to take place, 00:48:53,480 --> 00:48:57,440
我想要进行 n 种不同的添加，
--adding two vectors of n values each 00:48:57,440 --> 00:49:00,880
将两个向量相加，每个向量包含 n 个值
--and producing an n value result, but also 00:49:00,880 --> 00:49:05,640
并产生一个 n 值结果，而且
--with the capability of enabling and disabling 00:49:05,640 --> 00:49:08,280
具有启用和禁用的能力
--which ones actually happen. 00:49:08,280 --> 00:49:10,560
哪些实际发生了。
--And then the hardware will figure out, 00:49:13,800 --> 00:49:16,200
然后硬件会弄清楚，
--since it doesn't actually have a million units just all 00:49:16,200 --> 00:49:20,840
因为它实际上并没有一百万个单位
--sitting there ready to go, it will figure out 00:49:20,840 --> 00:49:23,360
坐在那里准备出发，它会弄清楚
--how to parcel that out into blocks 00:49:23,360 --> 00:49:26,160
如何把它分成块
--where the underlying block size is actually 32. 00:49:26,160 --> 00:49:29,120
其中底层块大小实际上是 32。
--32 values, not 32 bytes. 00:49:29,120 --> 00:49:32,320
 32 个值，而不是 32 个字节。
--And so that's sometimes referred to as the SIMD width, which 00:49:35,440 --> 00:49:39,160
所以这有时被称为 SIMD 宽度，
--as it mentions, they range from 8 to 32, 00:49:39,160 --> 00:49:41,240
正如它所提到的，它们的范围从 8 到 32，
--but currently most of them are 32. 00:49:41,240 --> 00:49:42,960
但目前他们中的大多数是 32 岁。
--And so they are using the SIMD as this sort 00:49:46,480 --> 00:49:49,480
所以他们使用 SIMD 作为这种
--of low-level implementation issue. 00:49:49,480 --> 00:49:51,040
低水平的实施问题。
--And we'll see that this divergence is something 00:49:51,040 --> 00:49:54,040
我们会看到这种分歧是
--that you have to, as a programmer, 00:49:54,040 --> 00:49:55,960
作为程序员，你必须
--be somewhat sensitive to. 00:49:55,960 --> 00:49:57,560
有点敏感。
--So just to give you a sense of some real hardware, 00:50:00,640 --> 00:50:03,360
所以只是为了让你了解一些真正的硬件，
--the Gates machines that you're using for your first assignment 00:50:03,360 --> 00:50:08,240
你在第一次作业中使用的 Gates 机器
--are a fairly recent 2016 model of Xeons. 00:50:08,240 --> 00:50:13,280
是 Xeons 的最新 2016 型号。
--And they have four cores, each of which 00:50:13,320 --> 00:50:19,000
它们有四个核心，每个核心
--has an AVX, actually AVX2, AVX Generation 2 support, 00:50:19,000 --> 00:50:24,120
有一个AVX，实际上是AVX2，支持AVX Generation 2，
--which if we think about, for the purpose of this class, 00:50:24,120 --> 00:50:26,920
如果我们考虑一下，为了这门课的目的，
--just think about 4-byte data, means we can do, 00:50:26,920 --> 00:50:31,360
想想 4 字节的数据，意味着我们可以做到，
--it's like having eight ALUs that can operate in parallel. 00:50:31,360 --> 00:50:36,760
这就像有八个可以并行运行的 ALU。
--Later in the term, we'll be using a cluster 00:50:36,760 --> 00:50:39,120
在这学期的后面，我们将使用一个集群
--that you can also make use of. 00:50:39,120 --> 00:50:41,800
你也可以利用。
--It only handles batch jobs. 00:50:41,800 --> 00:50:44,400
它只处理批处理作业。
--And it's a bigger version of the Gates machines with 12 cores. 00:50:44,400 --> 00:50:51,280
它是具有 12 个内核的盖茨机器的更大版本。
--We also, in the Gates machines, have attached to them 00:50:54,880 --> 00:50:57,640
我们还在盖茨机器上附加了它们
--NVIDIA, fairly recent models of NVIDIA, GPUs. 00:50:57,640 --> 00:51:03,080
NVIDIA，相当新的 NVIDIA 型号，GPU。
--And they have 20 cores, each of which 00:51:03,080 --> 00:51:06,400
他们有 20 个核心，每个核心
--has 32 ALUs that, like I said, support SIMD. 00:51:06,400 --> 00:51:12,480
有 32 个 ALU，就像我说的那样，支持 SIMD。
--But these cores look very different from an Intel 00:51:12,480 --> 00:51:18,480
但是这些核心看起来与英特尔非常不同
--processor core. 00:51:18,480 --> 00:51:21,240
处理器核心。
--Like I said, they sort of threw out all that fancy branch 00:51:21,240 --> 00:51:24,040
就像我说的，他们扔掉了所有那些花哨的分支
--prediction and a lot of that logic 00:51:24,040 --> 00:51:27,400
预测和很多逻辑
--in favor of much simpler control, 00:51:27,400 --> 00:51:29,960
赞成更简单的控制，
--but therefore the ability to do more work, more ALUs, 00:51:29,960 --> 00:51:34,600
但因此有能力做更多的工作，更多的 ALU，
--stuffed into the same amount of space. 00:51:34,600 --> 00:51:38,080
塞进相同大小的空间。
--So in principle, if you add up the sort of raw compute 00:51:38,080 --> 00:51:40,640
所以原则上，如果你把原始计算的种类加起来
--capability across this whole thing, 00:51:40,640 --> 00:51:43,000
跨越这一切的能力，
--it can go at 8 teraflops, 8 trillion floating point 00:51:43,000 --> 00:51:48,240
它可以达到 8 teraflops，8 万亿浮点数
--operations per second, which is, well, it's a lot of teraflops. 00:51:48,240 --> 00:51:55,120
每秒操作数，嗯，这是很多 teraflops。
--Xeon, if you max this out, let's see, 00:51:55,120 --> 00:52:02,600
 Xeon，如果你把它最大化，让我们看看，
--you can go a couple of gigaflops a piece times 8, 00:52:02,600 --> 00:52:11,920
你可以一次运行几千亿次 8，
--say 20 per core times 4 cores is less than 100 gigaflops, 00:52:11,920 --> 00:52:23,800
假设每个核心 20 个乘以 4 个核心不到 100 gigaflops，
--whereas we're talking potentially 8 teraflops out 00:52:23,800 --> 00:52:30,960
而我们说的可能是 8 teraflops
--of the NVIDIA. 00:52:30,960 --> 00:52:32,440
英伟达的。
--So that's an 80 to 1 just in raw compute power difference. 00:52:32,440 --> 00:52:38,200
所以这只是原始计算能力差异的 80 比 1。
--So you can see the trade-off by sort of casting out 00:52:38,200 --> 00:52:41,240
所以你可以通过排除来看到权衡
--all this fancy control logic and spending all that on ALUs, 00:52:41,240 --> 00:52:48,840
所有这些奇特的控制逻辑并将所有这些花在 ALU 上，
--you can get a lot more raw compute power. 00:52:48,840 --> 00:52:51,240
您可以获得更多的原始计算能力。
--It's a question of whether that can be used by programs. 00:52:51,240 --> 00:52:54,360
这是一个是否可以被程序使用的问题。
--So putting that together, then, for parallel execution, 00:52:54,360 --> 00:53:06,120
所以把它们放在一起，然后，为了并行执行，
--we can see that there's sort of both types of execution. 00:53:06,120 --> 00:53:10,160
我们可以看到有两种类型的执行。
--There's multi-core and SIMD, and actually three kinds. 00:53:10,160 --> 00:53:15,680
有多核和SIMD，实际上是三种。
--And then the low-level, what's called superscalar, 00:53:15,680 --> 00:53:18,520
然后是低级的，也就是所谓的超标量，
--exploiting instruction-level parallelism 00:53:18,520 --> 00:53:20,600
利用指令级并行性
--out of sequential code. 00:53:20,600 --> 00:53:22,360
出顺序码。
--And as you can imagine, if you can 00:53:22,360 --> 00:53:25,120
如你所想，如果你能
--get all three of these working for you, 00:53:25,120 --> 00:53:27,920
让所有这三个为你工作，
--that's what will get you real performance out 00:53:27,920 --> 00:53:29,960
这就是让你真正表现出来的东西
--of one of these machines. 00:53:29,960 --> 00:53:31,000
其中一台机器。
--So that's sort of getting computation done. 00:53:33,960 --> 00:53:36,920
这就是完成计算。
--But what we'll find is an often more challenging problem 00:53:36,920 --> 00:53:40,760
但我们会发现一个通常更具挑战性的问题
--is getting data in and out of the system. 00:53:40,760 --> 00:53:44,440
正在从系统中获取数据。
--And so we'll refer to that in terms of memory. 00:53:44,440 --> 00:53:48,080
因此，我们将在记忆方面提及这一点。
--So the problem is that, as you know, 00:53:48,080 --> 00:53:52,520
所以问题是，如你所知，
--we've been able to make chips that run faster, even 00:53:52,520 --> 00:53:56,080
我们已经能够制造出运行速度更快的芯片，甚至
--despite the sort of power challenges. 00:53:56,080 --> 00:53:58,840
尽管存在各种电源挑战。
--And we've been able to make memories that get bigger. 00:53:58,840 --> 00:54:01,600
我们已经能够创造出越来越大的回忆。
--But one thing that hasn't improved a lot over time 00:54:01,600 --> 00:54:04,120
但是随着时间的推移并没有太大改善的一件事
--is the time to get a byte from memory into the processor. 00:54:04,120 --> 00:54:12,440
是从内存中获取一个字节到处理器的时间。
--And that's the latency, as well as the throughput. 00:54:12,440 --> 00:54:16,160
这就是延迟和吞吐量。
--How many bytes can we stuff, bytes per second, 00:54:16,160 --> 00:54:20,160
我们可以填充多少字节，每秒字节数，
--can we run through the sort of very relatively narrow set 00:54:20,160 --> 00:54:24,840
我们可以通过那种非常相对狭窄的集合吗
--of wires that link the memory to the processor? 00:54:24,840 --> 00:54:30,520
将内存连接到处理器的电线？
--So a typical number would be the DRAM access time, 00:54:30,520 --> 00:54:36,040
所以一个典型的数字是 DRAM 访问时间，
--the memory access time, would be measured 00:54:36,040 --> 00:54:37,920
内存访问时间，将被测量
--in, say, 100 nanoseconds, whereas a 1 gigahertz processor 00:54:37,920 --> 00:54:42,120
比方说，100 纳秒，而一个 1 GHz 的处理器
--has a 1 nanosecond cycle time. 00:54:42,120 --> 00:54:45,240
具有 1 纳秒的循环时间。
--And of course, most processors are a couple gigahertz. 00:54:45,240 --> 00:54:48,400
当然，大多数处理器都是几千兆赫兹。
--Similarly, the memory bandwidth, how many bytes per second 00:54:48,400 --> 00:54:51,120
同样，内存带宽，每秒多少字节
--can we get, would be measured in some tens 00:54:51,120 --> 00:54:53,880
我们能得到吗，将以几十来衡量
--of gigabytes per second, which sounds like a lot, 00:54:53,880 --> 00:54:59,760
每秒千兆字节，这听起来很多，
--but it isn't. 00:54:59,760 --> 00:55:00,400
但事实并非如此。
--If you're trying to feed something 00:55:00,400 --> 00:55:01,960
如果你想喂东西
--that can do 8 teraflops, 8 trillion floating point 00:55:01,960 --> 00:55:05,600
可以做 8 teraflops，8 万亿浮点数
--operations per second, then 20 gigabytes per second 00:55:05,600 --> 00:55:09,040
每秒操作数，然后是每秒 20 GB
--doesn't sound like very much. 00:55:09,040 --> 00:55:11,600
听起来不是很多。
--So what happens in the hardware is 00:55:11,600 --> 00:55:13,600
那么硬件中发生的事情是
--if it tries to do a read and the memory is not 00:55:13,600 --> 00:55:18,320
如果它尝试读取而内存不是
--available in one of its closest in caches, it'll stall. 00:55:18,320 --> 00:55:23,880
在其最近的缓存之一中可用，它会停止。
--It'll basically stop the processor 00:55:23,880 --> 00:55:27,120
它基本上会停止处理器
--and wait until that gets filled. 00:55:27,120 --> 00:55:29,920
等到它被填满。
--Actually, it'll keep the processor going, 00:55:29,920 --> 00:55:32,080
实际上，它会让处理器继续运转，
--but that little unit down at the bottom that 00:55:32,080 --> 00:55:34,280
但底部的那个小单元
--was the memory interface will basically just hang there 00:55:34,280 --> 00:55:38,240
内存接口基本上会挂在那里
--and not return a result. And therefore, the program 00:55:38,240 --> 00:55:41,440
并且不返回结果。因此，该程序
--will kind of hang there and wait until that memory 00:55:41,440 --> 00:55:43,920
会挂在那里等到那段记忆
--value is available. 00:55:43,920 --> 00:55:44,840
值可用。
--And so that's a huge issue, the sort of latency of it. 00:55:48,560 --> 00:55:52,640
所以这是一个大问题，它的延迟。
--And that, of course, is part of the motivation for caches. 00:55:56,080 --> 00:55:58,640
当然，这也是缓存的部分动机。
--If I can take some of the data, the most critical data, 00:55:58,640 --> 00:56:02,840
如果我能拿走一些数据，最关键的数据，
--and move it into a smaller, faster memory, 00:56:02,840 --> 00:56:07,640
并将其移动到更小、更快的内存中，
--and I can keep most of my accesses 00:56:07,640 --> 00:56:09,680
我可以保留大部分访问权限
--confined to those caches, then I won't 00:56:09,680 --> 00:56:12,160
仅限于那些缓存，那么我不会
--have this 100 nanosecond latency. 00:56:12,160 --> 00:56:14,200
有这个 100 纳秒的延迟。
--I'll have more like a 1 clock cycle latency, or maybe 00:56:14,200 --> 00:56:19,920
我会有更像是 1 个时钟周期的延迟，或者也许
--a 5 nanosecond latency, or something much closer 00:56:19,920 --> 00:56:23,200
5 纳秒的延迟，或更接近的东西
--to the clock cycle time. 00:56:23,200 --> 00:56:25,040
到时钟周期时间。
--And that's part of the reason for having 00:56:25,040 --> 00:56:26,720
这就是拥有的部分原因
--these multiple levels of cache that you see, typically 00:56:26,720 --> 00:56:29,760
您看到的这些多级缓存，通常
--three levels on a machine. 00:56:29,760 --> 00:56:31,800
机器上的三个级别。
--The other thing you'll find is that on a multi-core machine, 00:56:31,800 --> 00:56:34,960
你会发现的另一件事是在多核机器上，
--usually the closer in caches are private to a particular 00:56:34,960 --> 00:56:39,360
通常越近的缓存是特定的私有的
--core, whereas the L3, the larger cache, 00:56:39,360 --> 00:56:42,600
核心，而 L3，更大的缓存，
--will be shared across all the cores. 00:56:42,600 --> 00:56:45,440
将在所有核心之间共享。
--And that's actually good in that I can communicate values 00:56:45,440 --> 00:56:49,040
这实际上很好，因为我可以传达价值观
--between the cores by writing to memory in one 00:56:49,040 --> 00:56:52,240
通过写入一个内存在核心之间
--and reading from the other, and having it go through the L3 00:56:52,240 --> 00:56:55,520
并从另一个读取，并让它通过 L3
--cache instead of having to dump all the way out 00:56:55,520 --> 00:56:57,760
缓存而不是一直转储
--to the main memory, the DRAM. 00:56:57,760 --> 00:57:01,800
到主存储器，DRAM。
--So caches actually help you both for latency and bandwidth. 00:57:05,960 --> 00:57:15,600
所以缓存实际上可以帮助您解决延迟和带宽问题。
--Latency, as I said, the difference 00:57:15,600 --> 00:57:17,320
延迟，正如我所说，区别
--between 100 nanoseconds and a few nanoseconds. 00:57:17,320 --> 00:57:21,040
在 100 纳秒到几纳秒之间。
--And also bandwidth, I can get, because these caches are all 00:57:21,040 --> 00:57:25,640
还有带宽，我可以得到，因为这些缓存都是
--on the same chip, I can have a lot more wires that 00:57:25,640 --> 00:57:30,720
在同一个芯片上，我可以有更多的电线
--are a lot shorter, and therefore get a lot higher bandwidth 00:57:30,760 --> 00:57:35,520
更短，因此获得更高的带宽
--through them than I can going across the external chip, 00:57:35,520 --> 00:57:39,760
通过它们比我可以通过外部芯片，
--the DRAM chips, and through the memory bus. 00:57:39,760 --> 00:57:42,920
 DRAM 芯片，并通过内存总线。
--So one thing that's gone on in hardware 00:57:48,120 --> 00:57:51,840
所以硬件中发生的一件事
--is to try to guess, just like it guesses 00:57:51,840 --> 00:57:54,560
就是尝试猜测，就像它猜测的那样
--which way branches will go, it also 00:57:54,560 --> 00:57:57,320
分支将走向何方，它也
--tries to guess what memory locations you're 00:57:57,320 --> 00:57:59,960
试图猜测你的记忆位置
--going to access next. 00:58:00,000 --> 00:58:01,680
接下来要访问。
--And that's called prefetching. 00:58:01,680 --> 00:58:03,000
这就是所谓的预取。
--So it basically, if it sees a pattern going on 00:58:03,000 --> 00:58:06,360
所以基本上，如果它看到一种模式正在发生
--that I'm accessing every fourth memory location because of some 00:58:06,360 --> 00:58:11,200
由于某些原因，我正在访问每四个内存位置
--loop, it doesn't actually look at the code. 00:58:11,200 --> 00:58:13,440
循环，它实际上并不看代码。
--It just accesses, it sort of notices a pattern of addresses. 00:58:13,440 --> 00:58:19,720
它只是访问，它会注意到一种地址模式。
--And it guesses that I'm going to keep accessing 00:58:19,720 --> 00:58:24,320
它猜测我会继续访问
--according to that pattern. 00:58:24,320 --> 00:58:25,960
按照那个模式。
--And it will actually start shifting, 00:58:25,960 --> 00:58:28,600
它实际上会开始转变，
--doing reads from the main memory into the caches 00:58:28,600 --> 00:58:33,040
从主内存读取到缓存
--to anticipate their need, which, by the way, 00:58:33,040 --> 00:58:37,400
预测他们的需求，顺便说一句，
--leaks information of various sorts 00:58:37,400 --> 00:58:41,800
泄露各种信息
--here based on what hits and not. 00:58:41,800 --> 00:58:44,840
这里基于命中和不命中。
--But that's another point. 00:58:44,840 --> 00:58:49,040
但这是另一点。
--But if I can do that, then at least I 00:58:49,040 --> 00:58:51,240
但如果我能做到，那么至少我
--can reduce the impact of some of this latency. 00:58:51,240 --> 00:58:54,280
可以减少一些这种延迟的影响。
--If I can sort of anticipate where 00:58:54,280 --> 00:58:56,920
如果我能预料到哪里
--my fetches are going to occur, then I 00:58:56,920 --> 00:59:00,120
我的提取将要发生，然后我
--can get that going so that by the time 00:59:00,120 --> 00:59:03,560
可以让它继续下去，到时候
--I actually hit the instructions that will do that load, 00:59:03,560 --> 00:59:07,080
我实际上按了执行该负载的说明，
--the data will be available in a cache. 00:59:07,080 --> 00:59:10,440
数据将在缓存中可用。
--And essentially, all hardware does this now. 00:59:10,440 --> 00:59:13,480
本质上，所有硬件现在都这样做。
--So this happened to be some pictures that you've probably 00:59:13,480 --> 00:59:18,080
所以这恰好是一些你可能已经看过的照片
--seen before. 00:59:18,080 --> 00:59:20,360
以前见过。
--But what turns out, if you look at the different editions 00:59:20,360 --> 00:59:23,480
但事实证明，如果你看看不同的版本
--of our book, you'll see that they actually 00:59:23,480 --> 00:59:25,800
我们的书，你会看到他们实际上
--look different, not just because the y-axis has changed, 00:59:25,800 --> 00:59:30,560
看起来不一样，不仅仅是因为y轴改变了，
--but the actual qualitative look is different. 00:59:30,560 --> 00:59:33,640
但实际定性的外观是不同的。
--And part of it is prefetching. 00:59:33,640 --> 00:59:35,080
其中一部分是预取。
--So just to show you, this result was measured on my house. 00:59:35,080 --> 00:59:41,080
所以只是为了告诉你，这个结果是在我家测得的。
--I still have a 2008 vintage iMac. 00:59:41,080 --> 00:59:47,080
我还有一台 2008 年的老式 iMac。
--And it used a processor that was quite the nice thing 00:59:47,080 --> 00:59:51,200
它使用了一个非常棒的处理器
--in its day. 00:59:51,200 --> 00:59:52,480
在它的时代。
--But you'll see that you'll remember with the memory 00:59:52,480 --> 00:59:54,760
但你会发现你会用记忆记住
--mountain that this direction is the total amount of memory. 00:59:54,760 --> 01:00:02,320
mountain说这个方向就是内存总量。
--I'm stepping through an array of data. 01:00:02,320 --> 01:00:05,480
我正在遍历一组数据。
--And this is the total array size. 01:00:05,480 --> 01:00:08,920
这是总数组大小。
--And over on this left end, I'm accessing one word at a time. 01:00:08,920 --> 01:00:14,560
在左端，我一次访问一个词。
--So what happens is up here, I'm in the L1 cache. 01:00:14,560 --> 01:00:17,440
那么这里发生了什么，我在 L1 缓存中。
--It's a very small amount of data. 01:00:17,440 --> 01:00:18,920
这是非常少量的数据。
--I'm cycling through it over and over again. 01:00:18,920 --> 01:00:21,200
我一遍又一遍地骑自行车。
--It's all in the L1 cache. 01:00:21,200 --> 01:00:22,520
都在一级缓存中。
--Life is good. 01:00:22,520 --> 01:00:24,200
生活很好。
--Here, I've gotten outside the L1 cache. 01:00:24,200 --> 01:00:28,520
在这里，我已经脱离了 L1 缓存。
--I'm filling up the L1 cache. 01:00:28,520 --> 01:00:30,120
我正在填充 L1 缓存。
--Oops. 01:00:30,120 --> 01:00:31,480
哎呀。
--Miss, miss, miss, miss. 01:00:31,480 --> 01:00:34,800
小姐，小姐，小姐，小姐。
--And then I come back around, and all that stuff 01:00:34,800 --> 01:00:37,120
然后我回来了，所有这些东西
--has gone from the L1 cache. 01:00:37,120 --> 01:00:38,560
已从 L1 缓存中消失。
--So it's sitting there. 01:00:38,560 --> 01:00:40,160
所以它就坐在那里。
--It's comfortably in the L2 cache. 01:00:40,160 --> 01:00:42,520
它在二级缓存中很舒服。
--And this drop in bandwidth is due to the relative performance 01:00:42,520 --> 01:00:48,200
这种带宽下降是由于相对性能
--of the L1 versus the L2 cache. 01:00:48,200 --> 01:00:50,880
L1 与 L2 缓存的比较。
--And then here, it falls into the main memory. 01:00:50,880 --> 01:00:54,800
然后在这里，它落入主内存。
--And so this system had an L1 and L2 cache, and then main memory. 01:00:54,800 --> 01:00:59,520
所以这个系统有一个 L1 和 L2 缓存，然后是主内存。
--This is the Gates machines, number 32. 01:00:59,520 --> 01:01:03,920
这是盖茨机器，32 号。
--And you see how much less this drop off is. 01:01:03,920 --> 01:01:07,800
你会看到这种下降有多少。
--And it's not because the cache got, oh, and also 01:01:07,800 --> 01:01:10,120
这不是因为缓存得到了，哦，还有
--there's an extra hump, because this is the L2 here. 01:01:10,120 --> 01:01:13,480
有一个额外的驼峰，因为这里是 L2。
--It's a relatively small bump. 01:01:13,480 --> 01:01:15,080
这是一个相对较小的颠簸。
--And then this is the L3 in here. 01:01:15,080 --> 01:01:17,480
然后这是这里的 L3。
--So but the main thing I'm pointing out 01:01:21,040 --> 01:01:24,560
所以但我要指出的主要事情
--is how much less the degradation is when you drop out of L1 01:01:24,560 --> 01:01:30,440
是退出 L1 时退化程度降低了多少
--into L2 and into L3. 01:01:30,440 --> 01:01:32,200
进入 L2 并进入 L3。
--And that's prefetching. 01:01:32,200 --> 01:01:34,400
这就是预取。
--The thing is, seeing my pattern, and it can't reduce, 01:01:34,400 --> 01:01:37,800
问题是，看到我的模式，它不能减少，
--it can't improve throughput, but it can decrease latency. 01:01:37,800 --> 01:01:41,480
它不能提高吞吐量，但可以减少延迟。
--It can anticipate where those are occurring 01:01:41,480 --> 01:01:44,680
它可以预测那些发生的地方
--and stage those reads in advance from the main memory 01:01:44,680 --> 01:01:49,320
并提前从主内存中读取这些数据
--into the cache and keep it going. 01:01:49,320 --> 01:01:52,480
进入缓存并继续运行。
--But you'll see that once I fall out of L3 cache, 01:01:52,480 --> 01:01:56,120
但是你会看到，一旦我脱离了 L3 缓存，
--I'm in trouble again. 01:01:56,120 --> 01:01:57,200
我又遇到麻烦了。
--I'm still just banging on the limited bandwidth 01:01:57,200 --> 01:02:01,200
我仍然只是在有限的带宽上
--capability of my memory bus. 01:02:01,200 --> 01:02:02,880
我的内存总线的能力。
--So anyways, you can see this effect. 01:02:06,240 --> 01:02:08,920
所以无论如何，你可以看到这个效果。
--You have to go back to some pretty old machines, 01:02:08,920 --> 01:02:12,520
你必须回到一些很旧的机器上，
--or like I did this on a Raspberry Pi, 01:02:12,520 --> 01:02:15,560
或者就像我在 Raspberry Pi 上做的那样，
--something like that, in order to see what 01:02:15,560 --> 01:02:18,160
类似的东西，为了看看什么
--it looks like without prefetching nowadays. 01:02:18,160 --> 01:02:20,560
现在看起来没有预取。
--So now there's another way we can 01:02:25,320 --> 01:02:27,320
所以现在我们可以用另一种方法
--try to squeeze more, avoid this latency problem. 01:02:27,320 --> 01:02:33,400
尝试挤压更多，避免这种延迟问题。
--So the problem with latency is basically 01:02:33,400 --> 01:02:38,040
所以延迟的问题基本上是
--I'm stuck waiting for something to happen, 01:02:38,040 --> 01:02:41,600
我被困在等待某事发生，
--a read to occur from memory, say. 01:02:41,600 --> 01:02:44,120
比如说，从内存中进行读取。
--And there's not much I can do until that's completed. 01:02:44,120 --> 01:02:47,280
在完成之前我无能为力。
--And so the processor isn't really being used very well. 01:02:47,400 --> 01:02:50,880
所以处理器并没有真正得到很好的使用。
--It's stalled. 01:02:50,880 --> 01:02:52,840
它停滞不前了。
--So what if there happened to be some other instructions 01:02:52,840 --> 01:02:57,920
那么如果碰巧有一些其他的指令呢
--from another thread that I could execute at the same time? 01:02:57,920 --> 01:03:04,240
来自另一个我可以同时执行的线程？
--While I'm waiting for the read from one, 01:03:04,240 --> 01:03:06,840
当我在等待一个人的阅读时，
--why don't I execute a few instructions from the other? 01:03:06,840 --> 01:03:10,160
我为什么不执行对方的一些指令？
--And so that's what we'll call multi-threading, 01:03:10,160 --> 01:03:14,440
这就是我们所说的多线程，
--where we're interleaving the processing 01:03:14,440 --> 01:03:16,520
我们交错处理的地方
--of independent threads of execution on a single core. 01:03:16,520 --> 01:03:21,640
单个内核上的独立执行线程。
--And here we'll talk about this as a way to avoid latency. 01:03:24,320 --> 01:03:28,080
在这里，我们将讨论这是一种避免延迟的方法。
--So imagine, for example, we had several different threads. 01:03:28,080 --> 01:03:34,480
想象一下，例如，我们有几个不同的线程。
--And the first one, imagine it's like these vector instructions. 01:03:34,480 --> 01:03:39,000
第一个，想象它就像这些矢量指令。
--So it tries to do an eight-way load into a vector register. 01:03:39,000 --> 01:03:43,720
因此它尝试将八路加载到向量寄存器中。
--And kaboom, it stalls. 01:03:43,720 --> 01:03:45,280
 kaboom，它停止了。
--The value isn't in the cache. 01:03:45,280 --> 01:03:48,200
该值不在缓存中。
--Well, what if I had another thread that 01:03:48,200 --> 01:03:51,280
好吧，如果我有另一个线程呢
--also had eight reads ready to go? 01:03:51,280 --> 01:03:54,040
还准备好了八读吗？
--And I could just fire that off and start that computation. 01:03:54,040 --> 01:04:00,080
我可以将其关闭并开始计算。
--And it will hit potentially the same vector load in its code. 01:04:00,080 --> 01:04:04,120
并且它可能会在其代码中遇到相同的矢量负载。
--Imagine they're executing the same program and stall. 01:04:04,120 --> 01:04:08,880
想象一下他们正在执行相同的程序并停止。
--But hey, I've got another thread waiting and so forth. 01:04:08,880 --> 01:04:13,360
但是，嘿，我还有另一个线程在等。
--And so now, basically, I can, in roughly the same amount 01:04:13,360 --> 01:04:18,040
所以现在，基本上，我可以，大致相同的数量
--of time I was spending for one thread, 01:04:18,040 --> 01:04:21,560
我花在一个线程上的时间，
--I'm executing multiple threads. 01:04:21,560 --> 01:04:25,440
我正在执行多个线程。
--And so what would that take to do that? 01:04:25,440 --> 01:04:27,680
那么要做到这一点需要什么？
--It would take enough logic. 01:04:27,680 --> 01:04:30,520
这需要足够的逻辑。
--Well, I still have the same ALUs. 01:04:30,520 --> 01:04:34,720
好吧，我仍然有相同的 ALU。
--But basically, I have multiple what 01:04:34,720 --> 01:04:37,000
但基本上，我有多个什么
--I'll call execution contexts. 01:04:37,000 --> 01:04:39,240
我将调用执行上下文。
--An execution context is minimally 01:04:39,240 --> 01:04:41,920
执行上下文最少
--the register state of each of those threads 01:04:41,960 --> 01:04:45,640
每个线程的寄存器状态
--and enough memory to store, say, the stack, 01:04:45,640 --> 01:04:51,000
和足够的内存来存储，比如说，堆栈，
--or at least the current part of the stack, 01:04:51,000 --> 01:04:54,360
或者至少是堆栈的当前部分，
--and other parts that are needed to execute each of the threads. 01:04:54,360 --> 01:04:58,040
以及执行每个线程所需的其他部分。
--And ideally, you'd have as much. 01:04:58,040 --> 01:05:02,320
理想情况下，你会拥有尽可能多的。
--Also, you see all these threads will be sharing 01:05:02,320 --> 01:05:04,920
此外，您会看到所有这些线程都将共享
--the same caches and so forth. 01:05:04,920 --> 01:05:06,640
相同的缓存等等。
--So if there isn't enough memory, they 01:05:06,640 --> 01:05:09,200
所以如果没有足够的内存，他们
--could start crowding each other out. 01:05:09,200 --> 01:05:11,600
可能会开始互相排挤。
--On the other hand, they're sort of filling 01:05:11,600 --> 01:05:13,800
另一方面，它们有点充实
--in the gaps where nothing useful would be happening anyhow. 01:05:13,800 --> 01:05:16,440
在无论如何都不会发生任何有用的差距中。
--So we're not really losing much ground. 01:05:16,440 --> 01:05:18,760
所以我们并没有真正失去太多优势。
--Question? 01:05:18,760 --> 01:05:19,280
问题？
--Is the improvement there even with just one 01:05:19,280 --> 01:05:21,840
即使只有一个，那里的改进吗？
--physical core and four hyperthreading? 01:05:21,840 --> 01:05:24,440
物理核心和四个超线程？
--Pardon? 01:05:24,440 --> 01:05:24,940
赦免？
--Is the same kind of improvement there 01:05:24,940 --> 01:05:27,240
那里有同样的改进吗
--if we have one core with hyperthreading? 01:05:27,240 --> 01:05:29,560
如果我们有一个超线程核心？
--Well, this is hyperthreading. 01:05:29,560 --> 01:05:31,760
好吧，这就是超线程。
--So that's what we're leading up to. 01:05:31,760 --> 01:05:33,360
这就是我们的目标。
--You've probably heard that term hyperthreading. 01:05:33,360 --> 01:05:35,960
您可能听说过超线程这个术语。
--And hyperthreading is a form of this, exactly, 01:05:35,960 --> 01:05:39,280
超线程就是这种形式，确切地说，
--of multiplexing multiple instruction 01:05:39,280 --> 01:05:42,920
多路复用指令
--streams on the same core at the same time. 01:05:42,920 --> 01:05:47,400
同时在同一核心上流式传输。
--And it's also the same. 01:05:47,400 --> 01:05:48,760
它也是一样的。
--We'll see that both GPUs and conventional processors 01:05:48,760 --> 01:05:53,600
我们将看到 GPU 和传统处理器
--use this same idea in slightly different forms. 01:05:53,600 --> 01:05:57,280
以略有不同的形式使用相同的想法。
--But I'm leading up exactly to that idea. 01:05:57,280 --> 01:05:59,320
但我正是在引导这个想法。
--So this is sometimes referred to as throughput-oriented 01:06:03,560 --> 01:06:06,840
所以这有时被称为面向吞吐量
--computing, meaning that I'm not going to, 01:06:06,880 --> 01:06:09,680
计算，意味着我不会，
--because you'll notice in my example 01:06:09,680 --> 01:06:12,280
因为你会在我的例子中注意到
--here that I actually gave up some performance 01:06:12,280 --> 01:06:16,280
在这里我实际上放弃了一些性能
--of my single thread, my first thread, 01:06:16,280 --> 01:06:18,280
我的单线程，我的第一个线程，
--because there'd be times when one of the other threads 01:06:18,280 --> 01:06:22,200
因为有时其他线程之一
--took priority over it. 01:06:22,200 --> 01:06:23,960
优先于它。
--And I wasn't executing it, even though it 01:06:23,960 --> 01:06:26,240
而且我没有执行它，即使它
--was potentially runnable. 01:06:26,240 --> 01:06:27,480
可能是可运行的。
--I'd completed that stall. 01:06:27,480 --> 01:06:30,480
我已经完成了那个摊位。
--And I could have gone if I'd had the resources available. 01:06:30,480 --> 01:06:33,560
如果我有可用的资源，我本来可以去的。
--But I get held up waiting for another thread. 01:06:33,560 --> 01:06:36,800
但是我在等待另一个线程时遇到了阻碍。
--That's a theme that we'll see in this course a lot, 01:06:37,760 --> 01:06:40,400
这是我们将在本课程中经常看到的主题，
--is often the advantage of having lots of parallelism 01:06:40,400 --> 01:06:46,080
通常是具有大量并行性的优势
--is you can shift your critical resource from time 01:06:46,080 --> 01:06:51,480
您是否可以随时转移您的关键资源
--or latency to throughput. 01:06:51,480 --> 01:06:54,440
或延迟吞吐量。
--How much stuff could I push through the system? 01:06:54,440 --> 01:06:57,680
我可以通过系统推送多少东西？
--And this interleaving is a technique, or multiplexing, 01:06:57,680 --> 01:07:04,800
而这种交织是一种技术，或多路复用，
--is a technique to build more sort of high latency 01:07:04,800 --> 01:07:10,640
是一种构建更多种类的高延迟的技术
--by increasing throughput. 01:07:10,640 --> 01:07:12,840
通过增加吞吐量。
--And that's a fairly critical idea. 01:07:12,840 --> 01:07:14,840
这是一个相当关键的想法。
--Yes, question? 01:07:14,840 --> 01:07:15,920
是的，问题？
--Who should use these threads? 01:07:15,920 --> 01:07:17,680
谁应该使用这些线程？
--Pardon? 01:07:17,680 --> 01:07:18,180
赦免？
--Who should use these threads? 01:07:18,180 --> 01:07:19,600
谁应该使用这些线程？
--Is it the OS, or is it the hardware? 01:07:19,600 --> 01:07:21,840
是操作系统，还是硬件？
--Well, that'll depend on. 01:07:21,840 --> 01:07:24,960
好吧，这取决于。
--I'm talking in very general terms now. 01:07:24,960 --> 01:07:27,480
我现在谈论的是非常笼统的术语。
--And in a minute, I'm going to fork 01:07:27,480 --> 01:07:29,440
一分钟后，我要分叉
--whether it's a CPU or a GPU. 01:07:29,440 --> 01:07:32,200
无论是 CPU 还是 GPU。
--And the answer will be different for those two parts. 01:07:32,200 --> 01:07:36,080
这两个部分的答案会有所不同。
--So that's a good question. 01:07:36,080 --> 01:07:37,440
所以这是一个很好的问题。
--And I'll be getting to that idea shortly. 01:07:37,440 --> 01:07:41,400
我很快就会谈到这个想法。
--And the hardware, too, by the way. 01:07:41,400 --> 01:07:42,800
顺便说一下，硬件也是如此。
--So we'll talk about that. 01:07:42,800 --> 01:07:46,320
所以我们会谈谈这个。
--But the main point I'm trying to make, 01:07:46,320 --> 01:07:48,020
但我想表达的主要观点是
--and this is a very general point, 01:07:48,020 --> 01:07:49,880
这是一个非常普遍的观点，
--is often you can, through parallelism, 01:07:49,880 --> 01:07:54,880
通常你可以通过并行性，
--one of the big advantages is it turns your critical resource 01:07:54,880 --> 01:07:57,800
最大的优势之一是它可以转变您的关键资源
--into how much stuff you can pump through the system, 01:07:57,800 --> 01:08:00,680
进入你可以通过系统泵送多少东西，
--as opposed to how much time does any particular operation 01:08:00,680 --> 01:08:03,360
而不是任何特定操作需要多少时间
--require. 01:08:03,360 --> 01:08:04,680
要求。
--Throughput is easier to achieve. 01:08:04,680 --> 01:08:07,560
吞吐量更容易实现。
--High throughput is easier to achieve than low latency. 01:08:07,560 --> 01:08:10,080
高吞吐量比低延迟更容易实现。
--But there is this trade-off that if I only 01:08:13,880 --> 01:08:16,360
但是有一个权衡，如果我只
--have one thread I'm trying to run on this processor, 01:08:16,360 --> 01:08:20,080
有一个线程我试图在这个处理器上运行，
--I can devote the entire L1 cache to it, 01:08:20,080 --> 01:08:22,880
我可以将整个 L1 缓存用于它，
--and I only have to have the register 01:08:22,880 --> 01:08:24,440
我只需要有寄存器
--state for those registers. 01:08:24,440 --> 01:08:27,120
这些寄存器的状态。
--If I'm trying to do this multiplexing across 16 threads, 01:08:27,120 --> 01:08:33,800
如果我尝试跨 16 个线程执行此多路复用，
--then I have less storage I can devote to any given one of them. 01:08:33,800 --> 01:08:37,800
那么我可以用于其中任何一个的存储空间就更少了。
--And you get the idea. 01:08:40,680 --> 01:08:41,800
你明白了。
--So this shows the general scheme for how that maps. 01:08:44,560 --> 01:08:52,240
所以这显示了映射方式的一般方案。
--And Intel calls this hyper-threading. 01:08:52,240 --> 01:08:57,800
英特尔称之为超线程。
--The non-commercial term for it is 01:08:57,800 --> 01:09:01,400
它的非商业术语是
--simultaneous multi-threading. 01:09:01,400 --> 01:09:04,080
同时多线程。
--And it wasn't invented by Intel, by the way, 01:09:04,080 --> 01:09:05,920
顺便说一句，它不是英特尔发明的，
--so they don't get rights to the naming. 01:09:05,920 --> 01:09:08,720
所以他们没有获得命名权。
--But the idea of it is, in a modern out-of-order processor, 01:09:08,720 --> 01:09:13,600
但它的想法是，在现代乱序处理器中，
--there's so much hardware there for doing other stuff 01:09:13,600 --> 01:09:16,800
那里有很多硬件可以做其他事情
--that it's relatively cheap to throw in enough logic 01:09:16,800 --> 01:09:20,960
投入足够的逻辑相对便宜
--to support a couple of threads running on it. 01:09:20,960 --> 01:09:23,840
支持在其上运行的几个线程。
--What you have to do is replicate the registers 01:09:23,840 --> 01:09:27,920
你所要做的就是复制寄存器
--so that each of the threads has its own independent set 01:09:27,920 --> 01:09:31,760
这样每个线程都有自己独立的集合
--of registers. 01:09:31,760 --> 01:09:33,760
寄存器。
--But they can share those execution units down there, 01:09:33,760 --> 01:09:37,000
但是他们可以在那里共享那些执行单元，
--and they can share the memory and the caches 01:09:37,000 --> 01:09:42,160
他们可以共享内存和缓存
--so that you can do that trick that I showed there 01:09:42,160 --> 01:09:46,480
这样你就可以做我在那里展示的那个技巧
--of if one of the threads gets stalled due to a memory 01:09:46,480 --> 01:09:51,880
如果其中一个线程由于内存而停止
--problem, the hardware can just jump and execute another thread. 01:09:51,880 --> 01:09:57,320
问题，硬件可以跳转并执行另一个线程。
--So what happens with, and we're not 01:09:57,320 --> 01:10:00,240
那么发生了什么，而我们不是
--going to spend a lot of time in this course 01:10:00,240 --> 01:10:02,040
会花很多时间在这门课程上
--because this is really more the topic of a computer architecture 01:10:02,040 --> 01:10:04,920
因为这实际上更像是计算机体系结构的主题
--course because it's not really a software issue. 01:10:04,920 --> 01:10:09,680
当然，因为这不是真正的软件问题。
--But what happens is this hardware up here 01:10:09,680 --> 01:10:14,680
但是这里的这个硬件会发生什么
--is grabbing raw instructions out of the instruction stream. 01:10:14,680 --> 01:10:20,360
从指令流中抓取原始指令。
--And you have enough of that to do it out 01:10:20,360 --> 01:10:22,520
你有足够的能力去做
--of multiple for the different threads. 01:10:22,520 --> 01:10:25,760
多个不同的线程。
--So you end up sharing that. 01:10:25,760 --> 01:10:28,120
所以你最终分享了那个。
--And at any given time, some logic 01:10:28,120 --> 01:10:30,880
在任何给定时间，一些逻辑
--is deciding which of the instruction streams 01:10:30,880 --> 01:10:33,960
正在决定哪个指令流
--I should be extracting instructions from. 01:10:33,960 --> 01:10:36,800
我应该从中提取说明。
--But remember, I told you that then 01:10:36,800 --> 01:10:38,560
但请记住，我当时告诉过你
--forms this pool of operations that 01:10:38,560 --> 01:10:40,520
形成这个操作池
--can be performed based on data dependencies. 01:10:40,520 --> 01:10:43,960
可以基于数据依赖性来执行。
--And those get mapped down into these functional units. 01:10:43,960 --> 01:10:46,920
这些被映射到这些功能单元中。
--And so when that happens with hyper-threading, 01:10:46,920 --> 01:10:50,520
所以当超线程发生这种情况时，
--essentially you're mapping two independent collections 01:10:50,520 --> 01:10:56,760
本质上你是在映射两个独立的集合
--of operations from the two different threads, 01:10:56,760 --> 01:10:59,960
来自两个不同线程的操作，
--or however many threads you support with this, 01:10:59,960 --> 01:11:02,640
或者无论你支持多少线程，
--into these instruction units. 01:11:02,640 --> 01:11:04,840
进入这些指令单元。
--And each of them will fire up and go in parallel. 01:11:04,840 --> 01:11:08,960
他们每个人都会开火并平行进行。
--And what happens, for example, on the memory case 01:11:08,960 --> 01:11:12,440
例如，在内存盒上会发生什么
--is you'll load up a series of memory operations into there. 01:11:12,440 --> 01:11:18,480
你会加载一系列内存操作到那里吗？
--And each of those can fire off. 01:11:18,480 --> 01:11:20,320
每一个都可以开火。
--And it can detect when there's a dependency 01:11:20,320 --> 01:11:24,040
它可以检测何时存在依赖关系
--or when these are independent. 01:11:24,040 --> 01:11:25,320
或者当它们是独立的。
--So if there's two different threads in there, 01:11:25,320 --> 01:11:28,080
所以如果那里有两个不同的线程，
--they just go in whatever order they 01:11:28,080 --> 01:11:29,640
他们只是按照他们的顺序进行
--happen to go in without any fancy, 01:11:29,640 --> 01:11:36,760
碰巧进去没有任何幻想，
--without any OS involvement at all. 01:11:36,760 --> 01:11:38,520
完全没有任何操作系统参与。
--So the hardware is actually making the low-level decisions 01:11:38,520 --> 01:11:42,240
所以硬件实际上在做低级决策
--these operations in the case of hyper-threading. 01:11:43,040 --> 01:11:46,800
这些操作在超线程的情况下。
--But it's up to the OS to have mapped multiple threads 01:11:46,800 --> 01:11:51,240
但是映射多个线程取决于操作系统
--onto this CPU so that it can apply hyper-threading to it. 01:11:51,240 --> 01:11:58,400
到这个 CPU 上，以便它可以对其应用超线程。
--So the OS scheduler is mapping which 01:11:58,400 --> 01:12:02,480
所以操作系统调度程序正在映射
--threads go where in a multi-core processor, 01:12:02,480 --> 01:12:07,240
线程在多核处理器中的位置，
--hyper-threaded processor. 01:12:07,240 --> 01:12:09,480
超线程处理器。
--But the hardware here is deciding 01:12:09,480 --> 01:12:11,680
但是这里的硬件决定了
--how to actually interleave the computation of these two 01:12:11,680 --> 01:12:15,680
如何实际交错计算这两个
--different threads. 01:12:15,680 --> 01:12:17,520
不同的线程。
--And it does it dynamically based on which ones are waiting 01:12:17,520 --> 01:12:20,960
它根据正在等待的人动态地进行
--and which ones are ready to go. 01:12:20,960 --> 01:12:24,160
哪些准备好了。
--It's actually pretty clever. 01:12:24,160 --> 01:12:25,480
它实际上非常聪明。
--So but the main idea of this is, with multi-threading is, 01:12:34,600 --> 01:12:38,320
所以但是这个的主要思想是，多线程是，
--we're trying to make better use of the hardware available. 01:12:38,320 --> 01:12:41,160
我们正在努力更好地利用可用的硬件。
--We're trying to hide the effects of these stalls 01:12:41,160 --> 01:12:44,200
我们试图隐藏这些摊位的影响
--by having more things we can do to fill in the gaps. 01:12:44,200 --> 01:12:47,040
我们可以做更多的事情来填补空白。
--So again, imagine we had this. 01:12:53,080 --> 01:12:57,840
再一次，想象一下我们有这个。
--We're juicing up from our multi-core SIMD, 01:12:57,840 --> 01:13:02,400
我们正在从我们的多核 SIMD 中榨汁，
--multi-threaded logic. 01:13:02,400 --> 01:13:06,520
多线程逻辑。
--In this case, that would potentially 01:13:06,520 --> 01:13:11,560
在这种情况下，这可能
--have 512-way parallelism going on. 01:13:11,560 --> 01:13:15,880
进行 512 路并行。
--Well, we'd be limited, in fact, by what the ALUs could do 01:13:15,880 --> 01:13:19,120
好吧，事实上，我们会受到 ALU 可以做的事情的限制
--for us. 01:13:19,120 --> 01:13:20,240
为了我们。
--But all this assumes that we have 01:13:20,240 --> 01:13:23,440
但所有这一切都假设我们有
--like 512 different things, independent computations that 01:13:23,440 --> 01:13:28,200
像 512 种不同的东西，独立的计算
--can be performed. 01:13:28,200 --> 01:13:29,560
可以执行。
--And really, we could just sort of totally saturate 01:13:29,560 --> 01:13:31,840
真的，我们可以完全饱和
--the hardware and get it working at its maximum speed. 01:13:31,840 --> 01:13:34,520
硬件并使其以最大速度工作。
--And so you can think of a GPU as sort of taking this out 01:13:36,920 --> 01:13:42,440
所以你可以把 GPU 看作是解决这个问题的一种方式
--to a whole different space in performance. 01:13:42,440 --> 01:13:48,120
到一个完全不同的性能空间。
--Like I said, you can think of a modern CPU 01:13:48,120 --> 01:13:51,080
就像我说的，你可以想到现代 CPU
--as having thrown, starting in a world 01:13:51,080 --> 01:13:54,160
作为已经投掷，从一个世界开始
--where we're just trying to extract maximum performance out 01:13:54,160 --> 01:13:56,520
我们只是想获得最大的性能
--of one thread, and now saying, OK, well, I've 01:13:56,520 --> 01:14:00,520
一个线程，现在说，好吧，好吧，我已经
--got more than one thread. 01:14:00,520 --> 01:14:01,840
得到不止一个线程。
--But I still want a lot of performance 01:14:01,840 --> 01:14:03,360
但我还是想要很多性能
--out of each of those ones, to saying, 01:14:03,360 --> 01:14:06,160
从每一个中，说，
--I'm going to have just really crappy performance 01:14:06,160 --> 01:14:08,560
我的表现会很糟糕
--on a per-thread basis, but I'm going 01:14:08,560 --> 01:14:10,200
在每个线程的基础上，但我要去
--to give you a lot of threads. 01:14:10,200 --> 01:14:11,960
给你很多线程。
--You're going to really like this. 01:14:11,960 --> 01:14:13,800
你会真的喜欢这个。
--And it only works for places where the computation is 01:14:13,800 --> 01:14:16,400
它只适用于计算所在的地方
--extremely structured. 01:14:16,400 --> 01:14:18,120
非常结构化。
--And you can imagine it starting in the world of computer 01:14:18,120 --> 01:14:21,000
你可以想象它始于计算机世界
--graphics, where you have all these pixels or rectangles you 01:14:21,000 --> 01:14:26,680
图形，你有所有这些像素或矩形
--want to shade, things that are really 01:14:26,680 --> 01:14:29,240
想要遮阳，真正的东西
--very low-level operations that you 01:14:29,240 --> 01:14:30,900
非常低级的操作，你
--want to do the same thing over and over again on. 01:14:30,900 --> 01:14:34,920
想一遍又一遍地做同样的事情。
--So let me, so in the world of GPUs, 01:14:34,920 --> 01:14:42,840
所以让我，所以在 GPU 的世界里，
--we're looking at NVIDIA, the sort of dominant manufacturer, 01:14:42,840 --> 01:14:46,160
我们关注的是 NVIDIA，那种占主导地位的制造商，
--but there are other companies too. 01:14:46,160 --> 01:14:48,560
但也有其他公司。
--What they refer to as a warp is a collection 01:14:48,560 --> 01:14:52,120
他们所说的经线是一个集合
--of 32 SIMD operations that can be performed, well, 01:14:52,120 --> 01:15:02,320
可以执行的 32 个 SIMD 操作，嗯，
--operations on vectors of size 32 data, not bytes, 01:15:02,320 --> 01:15:07,120
对大小为 32 的数据而不是字节的向量进行操作，
--and in the SIMD mode. 01:15:07,120 --> 01:15:11,640
在 SIMD 模式下。
--And there's a little bit more funkiness to this. 01:15:11,640 --> 01:15:14,920
这还有一点有趣。
--This one is based on a particular model 01:15:14,920 --> 01:15:19,000
这个是基于一个特定的模型
--that the hardware actually has 16 ALUs, 01:15:19,000 --> 01:15:21,760
硬件实际上有 16 个 ALU，
--and it does what they call double-pumping them, 01:15:21,760 --> 01:15:23,640
它会做他们所谓的双泵，
--meaning that it will do first half and then 01:15:23,640 --> 01:15:26,480
意思是它会先做一半然后
--the other half of the vector in order 01:15:26,480 --> 01:15:28,080
向量的另一半按顺序
--to perform a vector operation. 01:15:28,080 --> 01:15:30,120
执行向量运算。
--And it has two of those, so it has actually 01:15:30,120 --> 01:15:33,480
它有两个，所以它实际上有
--32 ALUs, each of which gets double-pumped. 01:15:33,480 --> 01:15:37,000
32 个 ALU，每个 ALU 都是双泵。
--So it's going, basically, it's getting 32-way parallelism 01:15:37,000 --> 01:15:45,360
所以基本上，它正在获得 32 路并行性
--at twice the rate. 01:15:45,360 --> 01:15:46,200
以两倍的速度。
--Anyways, it's hard to exactly reconcile all this stuff. 01:15:46,200 --> 01:15:49,720
无论如何，很难完全调和所有这些东西。
--But the point is that it's got a warp, 01:15:49,720 --> 01:15:54,480
但关键是它有一个扭曲，
--is a computation over, think of it as a vector instruction 01:15:54,480 --> 01:15:57,840
是一个计算结束，把它想象成一个向量指令
--over 32 values. 01:15:57,840 --> 01:16:00,280
超过 32 个值。
--But now what it will do is manage, let me see, 01:16:00,280 --> 01:16:09,160
但现在它要做的是管理，让我看看，
--I'm trying to, it'll come later. 01:16:09,160 --> 01:16:14,480
我正在努力，它会在稍后出现。
--So like this model, 480 is a little bit older 01:16:14,480 --> 01:16:18,360
所以像这个型号，480有点老
--than the ones we have in the gates cluster. 01:16:18,360 --> 01:16:20,160
比我们在盖茨集群中的那些。
--It had 15 cores. 01:16:20,160 --> 01:16:21,360
它有 15 个核心。
--And the idea is that on each of these units, 01:16:24,160 --> 01:16:27,480
这个想法是在每个单元上，
--it actually can process 48 warps worth of data 01:16:27,620 --> 01:16:32,280
它实际上可以处理 48 个数据量
--in a multi-threaded sort of way. 01:16:32,280 --> 01:16:35,520
以多线程的方式。
--Not quite the same as the simultaneous multi-threading 01:16:35,520 --> 01:16:39,280
与同步多线程不太一样
--or hyper-threading, but the same idea 01:16:39,280 --> 01:16:41,120
或超线程，但同样的想法
--that on every given step, the hardware 01:16:41,120 --> 01:16:43,640
在每一步，硬件
--will decide which of 48 different warp vector 01:16:43,640 --> 01:16:47,360
将决定 48 个不同的扭曲向量中的哪一个
--operations to perform. 01:16:47,360 --> 01:16:49,680
要执行的操作。
--And it can use the same latency hiding stuff, 01:16:49,680 --> 01:16:54,000
它可以使用相同的延迟隐藏的东西，
--meaning that if one of them is a 32-way read from memory, 01:16:54,000 --> 01:16:58,880
这意味着如果其中之一是从内存中读取的 32 路，
--and that takes a while to complete, 01:16:58,880 --> 01:17:01,840
这需要一段时间才能完成，
--it can fill in with other vector operations that 01:17:01,840 --> 01:17:04,240
它可以填充其他向量操作
--are ready to execute right away. 01:17:04,240 --> 01:17:06,240
准备好立即执行。
--So it's an extreme version of this throughput-oriented 01:17:06,240 --> 01:17:09,280
所以这是这种面向吞吐量的极端版本
--computing, that it's essentially a 48-wide way 01:17:09,280 --> 01:17:14,720
计算，它本质上是一种 48 宽的方式
--threading on each of these cores. 01:17:14,720 --> 01:17:18,800
在这些内核中的每一个上线程化。
--And then it has, in the case of a 480, it has 15 of those cores. 01:17:18,800 --> 01:17:24,760
然后它有，在 480 的情况下，它有 15 个这样的核心。
--And so if you multiply it out, that 01:17:24,760 --> 01:17:28,000
所以如果你把它相乘，那
--works in the case where you have 23,000-some different data 01:17:28,000 --> 01:17:32,840
适用于您拥有 23,000 多个不同数据的情况
--values that you can operate on independently. 01:17:32,840 --> 01:17:35,960
您可以独立操作的值。
--Then you can keep this whole thing running. 01:17:35,960 --> 01:17:39,600
然后你可以让整个事情继续运行。
--So the logical level of concurrency here is very high. 01:17:39,600 --> 01:17:46,280
所以这里的逻辑并发级别是非常高的。
--The other thing you'll find is that the memory system 01:17:46,280 --> 01:17:49,960
你会发现的另一件事是记忆系统
--is tuned to provide very high throughput 01:17:49,960 --> 01:17:55,080
被调整以提供非常高的吞吐量
--and rely on relatively smaller caches. 01:17:55,080 --> 01:17:58,800
并依赖相对较小的缓存。
--And even the main memory can't be as big. 01:17:58,800 --> 01:18:02,720
甚至主内存也不能那么大。
--These numbers have all increased in the last few years. 01:18:02,720 --> 01:18:05,760
这些数字在过去几年都有所增加。
--But again, the engineering optimization 01:18:05,760 --> 01:18:11,400
但同样，工程优化
--they've made is maximize throughput. 01:18:11,400 --> 01:18:14,080
他们所做的是最大化吞吐量。
--Get your throughput up. 01:18:14,080 --> 01:18:15,880
提高吞吐量。
--Make sure that you've got enough parallelism 01:18:15,880 --> 01:18:17,920
确保你有足够的并行性
--to sort of account for and avoid lots of latency, 01:18:17,920 --> 01:18:25,240
考虑并避免大量延迟，
--and therefore get very high throughput. 01:18:25,240 --> 01:18:28,040
从而获得非常高的吞吐量。
--So that's a big part of the way it performs. 01:18:28,040 --> 01:18:30,880
所以这是它执行方式的重要组成部分。
--And by having smaller caches, again, it 01:18:30,880 --> 01:18:33,000
再一次，通过拥有更小的缓存，它
--can devote more chip area to these ALUs. 01:18:33,000 --> 01:18:34,920
可以为这些 ALU 投入更多的芯片面积。
--So even for the relatively bad case for this, 01:18:34,920 --> 01:18:47,240
所以即使是相对糟糕的情况，
--you'll see the final problem is called Saxby. 01:18:47,240 --> 01:18:51,240
你会看到最后一个问题叫做 Saxby。
--Or even if I'm just reading in two vectors of data 01:18:51,240 --> 01:18:55,200
或者即使我只是读入两个数据向量
--and multiplying them and writing them out. 01:18:55,200 --> 01:18:57,040
并将它们相乘并写出来。
--So this is actually a pretty bad performing code 01:18:57,040 --> 01:19:01,880
所以这实际上是一个性能很差的代码
--because it has a lot of memory. 01:19:01,880 --> 01:19:03,680
因为它有很多内存。
--It requires two reads and a write 01:19:03,680 --> 01:19:06,880
它需要两次读取和一次写入
--for every single arithmetic operation you perform. 01:19:06,880 --> 01:19:12,080
对于您执行的每一个算术运算。
--What's called low arithmetic intensity to this code. 01:19:12,080 --> 01:19:15,040
这段代码所谓的低算术强度。
--So on this model of GPU, it has the potential 01:19:17,760 --> 01:19:23,600
所以在这个型号的GPU上，它有潜力
--to run 400 multiplications every clock. 01:19:23,600 --> 01:19:31,880
每个时钟运行 400 次乘法。
--But that would take a 6.4 terabyte memory pipe, 01:19:31,880 --> 01:19:37,480
但这需要一个 6.4 TB 的内存管道，
--which it doesn't have. 01:19:37,480 --> 01:19:38,560
它没有。
--It has something less than that. 01:19:38,560 --> 01:19:42,920
它有比这更少的东西。
--It has 177 gigabytes. 01:19:42,920 --> 01:19:46,040
它有 177 GB。
--So in this case, what it will do is just run totally 01:19:46,040 --> 01:19:48,840
所以在这种情况下，它会做的就是完全运行
--constrained by that pipe. 01:19:48,840 --> 01:19:50,240
被那个管子限制了。
--So it's only 3% efficient. 01:19:55,920 --> 01:19:57,880
所以它只有3%的效率。
--It's basically starved by memory bandwidth. 01:19:57,880 --> 01:20:01,560
它基本上被内存带宽饿死了。
--But that will still be seven times faster 01:20:01,560 --> 01:20:03,520
但这仍然会快七倍
--than you can pump through my comparable Xeon processor. 01:20:03,520 --> 01:20:07,800
比你可以通过我的同类 Xeon 处理器泵送。
--Because again, the Xeon processor 01:20:07,800 --> 01:20:09,760
又因为，至强处理器
--is limited by its 25. 01:20:09,760 --> 01:20:13,920
受其 25 个限制。
--Actually, the modern Xeons are higher than that. 01:20:13,920 --> 01:20:16,080
实际上，现代至强处理器的性能更高。
--But still, it's the bandwidth for memory 01:20:16,080 --> 01:20:19,520
但是，它仍然是内存的带宽
--that will dominate that particular computation. 01:20:19,520 --> 01:20:22,400
这将主导该特定计算。
--And so that memory bandwidth of the GPU 01:20:22,400 --> 01:20:25,600
这样 GPU 的内存带宽
--is not enough to keep it fully fed, 01:20:25,600 --> 01:20:27,360
不足以让它吃饱，
--but it beats what you can put on a CPU. 01:20:27,360 --> 01:20:29,320
但它胜过你可以放在 CPU 上的东西。
--And so one of the things we'll find 01:20:31,560 --> 01:20:37,960
所以我们会发现其中一件事
--is often memory speed is much more a limitation 01:20:37,960 --> 01:20:41,960
通常内存速度是一个限制
--than arithmetic speed. 01:20:41,960 --> 01:20:43,120
比算术速度。
--And that's true for whether you're programming a GPU 01:20:43,120 --> 01:20:46,160
无论您是在为 GPU 编程，都是如此
--or a conventional processor. 01:20:46,160 --> 01:20:48,360
或传统的处理器。
--And so there's a lot of clever tricks 01:20:48,360 --> 01:20:50,120
所以有很多聪明的技巧
--you as a programmer can do to reduce the bandwidth. 01:20:50,120 --> 01:20:54,200
作为程序员，您可以减少带宽。
--For example, instead of computing something 01:20:54,200 --> 01:20:56,680
例如，而不是计算一些东西
--and storing it and using it multiple times, 01:20:56,680 --> 01:20:59,960
并多次存储和使用它，
--you just recompute it wherever you need it. 01:20:59,960 --> 01:21:02,320
您只需在需要的地方重新计算它。
--Because it's a lot cheaper to compute something 01:21:02,320 --> 01:21:05,040
因为计算一些东西要便宜得多
--than to store it out to memory and then bring it back. 01:21:05,040 --> 01:21:07,880
而不是将其存储到内存中然后再将其取回。
--So things that, as computer scientists, 01:21:07,880 --> 01:21:10,120
所以，作为计算机科学家，
--we'd find totally non-intuitive become the right way 01:21:10,120 --> 01:21:13,480
我们会发现完全非直觉成为正确的方式
--to do things in a world where memory bandwidth is 01:21:13,480 --> 01:21:16,800
在内存带宽有限的世界中做事
--a more precious resource than the cost of performing 01:21:16,800 --> 01:21:22,880
比执行成本更宝贵的资源
--arithmetic operations. 01:21:22,880 --> 01:21:23,840
算术运算。
--So that gives you a very high level understanding of it. 01:21:24,600 --> 01:21:28,440
所以这让你对它有一个非常高层次的理解。
--And especially, we'll try to refine our understanding 01:21:28,440 --> 01:21:31,440
特别是，我们将尝试完善我们的理解
--of GPUs more over time. 01:21:31,440 --> 01:21:34,080
随着时间的推移，更多的 GPU。
--But you can see the main point of them 01:21:34,080 --> 01:21:36,040
但是你可以看到他们的要点
--is they're in a very different space than conventional CPUs. 01:21:36,040 --> 01:21:40,400
它们与传统 CPU 所处的空间截然不同吗？
--And they happen to work really well 01:21:40,400 --> 01:21:42,400
他们碰巧工作得很好
--for certain classes of applications. 01:21:42,400 --> 01:21:44,400
对于某些类别的应用程序。
--And so they've really taken off in how dominant they've 01:21:44,400 --> 01:21:47,760
所以他们真的在他们的统治力上起飞了
--become in a lot of applications. 01:21:47,760 --> 01:21:51,400
成为很多应用程序。
--Dominant they've become in a lot of how critical 01:21:51,400 --> 01:21:55,720
他们在很多方面都变得很重要
--they are as a computing capability 01:21:55,720 --> 01:21:57,760
它们作为一种计算能力
--in many different application domains. 01:21:57,760 --> 01:22:00,080
在许多不同的应用领域。
--The biggest class of customers for NVIDIA these days 01:22:00,080 --> 01:22:03,760
 NVIDIA 目前最大的客户类别
--are car companies. 01:22:03,760 --> 01:22:05,600
是汽车公司。
--And the biggest single customer for NVIDIA is Google. 01:22:05,600 --> 01:22:09,200
 NVIDIA 最大的单一客户是谷歌。
--So figure that out. 01:22:09,200 --> 01:22:12,160
所以弄清楚。
--It's pretty interesting, the world we're living in now, 01:22:12,160 --> 01:22:15,320
这很有趣，我们现在生活的世界，
--and how GPUs are changing things. 01:22:15,320 --> 01:22:18,160
以及 GPU 如何改变事物。
--Now, I'll just point out that the rest of the slides 01:22:18,520 --> 01:22:22,000
现在，我将指出其余的幻灯片
--here are things you might want to look at on your own. 01:22:22,000 --> 01:22:25,920
以下是您可能想自己查看的内容。
--They step through the same kind of ideas as we've done before 01:22:25,920 --> 01:22:29,880
他们逐步完成与我们之前完成的相同类型的想法
--and have you think about these different ideas of where we're 01:22:29,880 --> 01:22:33,120
你有没有想过这些关于我们所处位置的不同想法
--going to get the parallelism and what the limitations will be. 01:22:33,120 --> 01:22:37,840
将获得并行性和限制是什么。
--So it's something worth doing on your own. 01:22:37,840 --> 01:22:40,720
所以这是值得你自己做的事情。
--And I didn't really expect to do it in the class anyhow. 01:22:40,720 --> 01:22:43,960
无论如何，我真的没想到会在课堂上做到这一点。
--So we're good. 01:22:43,960 --> 01:22:44,600
所以我们很好。
--Thank you. 01:22:44,600 --> 01:22:45,560
谢谢。
--Have a good weekend. 01:22:45,560 --> 01:22:47,480
有一个美好的周末。
--Thank you. 01:22:48,160 --> 01:22:50,640
谢谢。
