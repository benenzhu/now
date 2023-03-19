--All right, it looks like the technical issues got fixed, 00:00:00,000 --> 00:00:02,520
好吧，看起来技术问题已经解决了，
--so maybe you better take my thought. 00:00:02,520 --> 00:00:05,000
所以也许你最好考虑一下我的想法。
--So greetings and welcome everybody. 00:00:05,600 --> 00:00:07,880
所以向大家致以问候和欢迎。
--I guess this is the first time we've officially met, 00:00:07,880 --> 00:00:09,400
我想这是我们第一次正式见面，
--and my name is Greg Keston. 00:00:09,400 --> 00:00:10,760
我叫格雷格·凯斯顿。
--I was at CMU from 1999 through 2015, 00:00:10,760 --> 00:00:13,960
我从 1999 年到 2015 年在 CMU，
--went and hung out at the beach in San Diego for a couple of years, 00:00:13,960 --> 00:00:16,480
去了圣地亚哥的海滩闲逛了几年，
--and now I'm back. 00:00:16,480 --> 00:00:18,200
现在我回来了。
--So I'm one of the cast of many instructors this semester. 00:00:18,200 --> 00:00:22,800
所以我是这学期众多导师的演员之一。
--This is my first time through 418. 00:00:22,800 --> 00:00:24,440
这是我第一次通过418。
--Randy, as you've noticed, is sort of the lead instructor. 00:00:24,440 --> 00:00:26,520
正如您所注意到的，兰迪有点像首席讲师。
--Todd's the lead instructor of the fall, but I'm having fun. 00:00:26,640 --> 00:00:30,640
托德是秋季的首席讲师，但我玩得很开心。
--If you bounce over to this directory in AFS, 00:00:30,640 --> 00:00:32,440
如果您跳转到 AFS 中的这个目录，
--you'll find the code that's the basis for this recitation. 00:00:32,440 --> 00:00:36,440
您会找到作为此背诵基础的代码。
--You'll also find a PowerPoint version of these slides 00:00:36,440 --> 00:00:38,200
您还会找到这些幻灯片的 PowerPoint 版本
--if you prefer them to PDF. 00:00:38,200 --> 00:00:40,200
如果您更喜欢它们而不是 PDF。
--You don't need it, so if you don't have your laptop, 00:00:41,880 --> 00:00:43,440
你不需要它，所以如果你没有笔记本电脑，
--no problem at all. 00:00:43,440 --> 00:00:44,680
一点问题都没有。
--Now that we've got projection, we're in good shape. 00:00:44,680 --> 00:00:46,680
现在我们有了投影，我们的状态很好。
--And so, you know, today's class is sort of a grab bag 00:00:50,840 --> 00:00:53,560
所以，你知道，今天的课有点抢手
--of miscellaneous things. 00:00:53,560 --> 00:00:55,560
的杂项。
--Related to the class so far. 00:00:57,120 --> 00:00:59,120
到目前为止与课程相关。
--So we've talked a lot about optimizing performance, 00:00:59,120 --> 00:01:02,440
所以我们已经讨论了很多关于优化性能的问题，
--you know, for a processor, right? 00:01:02,440 --> 00:01:05,760
你知道，对于处理器，对吧？
--How many of you guys have looked at slash proc slash CPU info before? 00:01:05,760 --> 00:01:10,600
你们中有多少人以前看过 slash proc slash CPU 信息？
--How many of you have not? 00:01:10,600 --> 00:01:13,040
你们有多少人没有？
--Okay. 00:01:13,040 --> 00:01:14,040
好的。
--How many of you are familiar with slash proc in general? 00:01:14,040 --> 00:01:17,040
你们中有多少人通常熟悉 slash proc？
--How many are not? 00:01:17,040 --> 00:01:19,400
有多少不是？
--Okay. 00:01:19,400 --> 00:01:20,400
好的。
--Let's talk about that. 00:01:20,400 --> 00:01:21,400
我们来谈谈吧。
--So back in the day, you know, where it was uphill both ways to class 00:01:21,400 --> 00:01:24,520
所以回到过去，你知道，去上课的路上都是上坡路
--and all those other things your grandparents might have said. 00:01:24,520 --> 00:01:27,880
以及您的祖父母可能说过的所有其他事情。
--When you wanted to get information from the operating system kernel, 00:01:27,880 --> 00:01:31,600
当你想从操作系统内核获取信息时，
--what you actually had to do was make a system call. 00:01:31,600 --> 00:01:35,000
您实际上要做的是进行系统调用。
--And making a system call encountered a certain amount of overhead. 00:01:35,000 --> 00:01:37,880
并且进行系统调用会遇到一定的开销。
--And then you'd ask the operating system a question, 00:01:37,880 --> 00:01:39,880
然后你会问操作系统一个问题，
--it would answer, and it would come back, right? 00:01:39,880 --> 00:01:42,160
它会回答，它会回来，对吧？
--And then you'd have your answer. 00:01:42,160 --> 00:01:44,160
然后你就会得到你的答案。
--In modern operating systems, there's this thing called slash proc. 00:01:45,360 --> 00:01:49,000
在现代操作系统中，有一个叫做 slash proc 的东西。
--It's what's called a virtual file system. 00:01:49,000 --> 00:01:51,720
这就是所谓的虚拟文件系统。
--A virtual file system. 00:01:51,720 --> 00:01:52,720
一个虚拟文件系统。
--It's not a real file system, but it looks like a file system. 00:01:52,840 --> 00:01:55,600
它不是一个真正的文件系统，但它看起来像一个文件系统。
--Okay? 00:01:56,720 --> 00:01:57,600
好的？
--And so, if you bounce over to, let's see. 00:01:57,600 --> 00:02:01,320
所以，如果你跳到，让我们看看。
--Bounce over to, you know, unix.android, and you do nls on slash proc. 00:02:01,320 --> 00:02:07,880
跳转到 unix.android，然后在 slash proc 上执行 nls。
--You can see a bazillion things there, okay? 00:02:07,880 --> 00:02:11,080
你可以在那里看到无数的东西，好吗？
--This is information the kernel is exporting to you. 00:02:11,080 --> 00:02:14,120
这是内核输出给你的信息。
--It's showing you, and it's making it look like a file system, 00:02:14,120 --> 00:02:17,800
它向你展示，让它看起来像一个文件系统，
--just because that's an easy way for us as humans to access data, 00:02:17,800 --> 00:02:22,760
仅仅因为这是我们人类访问数据的一种简单方式，
--either as humans or programmatically, right? 00:02:22,760 --> 00:02:25,480
无论是作为人类还是以编程方式，对吗？
--We can easily write programs that can open files, read files, parse them, do whatever, 00:02:25,480 --> 00:02:30,040
我们可以很容易地编写程序来打开文件、读取文件、解析文件，做任何事情，
--right? 00:02:30,040 --> 00:02:31,160
正确的？
--So slash proc exports a whole bunch of system state, making it look like a file 00:02:31,160 --> 00:02:35,360
所以 slash proc 导出了一大堆系统状态，让它看起来像一个文件
--system, because that's convenient for us, and avoids the overhead of having to make 00:02:35,360 --> 00:02:41,200
系统，因为这对我们来说很方便，并且避免了必须制作的开销
--a system call each time, because the file system is already sort of baked in. 00:02:41,200 --> 00:02:44,920
每次一个系统调用，因为文件系统已经有点内置了。
--If you take operating systems, you'll take a look at how that works. 00:02:44,920 --> 00:02:47,600
如果你学习操作系统，你将了解它是如何工作的。
--These things that you see that are numbered represent processes. 00:02:47,600 --> 00:02:51,280
您看到的这些编号的东西代表过程。
--Those are process IDs, okay? 00:02:51,280 --> 00:02:54,000
这些是进程 ID，好吗？
--So when you see this whole list of directories, you see all those numbers. 00:02:54,000 --> 00:02:56,960
因此，当您看到整个目录列表时，您会看到所有这些数字。
--Each of those directories that's numbered represents a particular process. 00:02:56,960 --> 00:03:00,560
每个带编号的目录都代表一个特定的进程。
--And if I were to do an ls on one of these, we'll say 15.9.77. 00:03:00,560 --> 00:03:07,520
如果我对其中之一执行 ls，我们会说 15.9.77。
--That one's gone now, so we'll look for another one. 00:03:07,520 --> 00:03:09,360
那个现在不见了，所以我们会寻找另一个。
--Two, five, five, six. 00:03:09,360 --> 00:03:15,280
二、五、五、六。
--All right, let's do this. 00:03:15,280 --> 00:03:16,360
好吧，让我们开始吧。
--If I do a pn, it'll show me my own processes. 00:03:16,360 --> 00:03:18,920
如果我执行 pn，它会显示我自己的流程。
--My own process shill is 37684. 00:03:18,920 --> 00:03:24,760
我自己的进程 shill 是 37684。
--So I can do an ls on slash proc slash 37684, and I can see this directory 00:03:24,760 --> 00:03:29,400
所以我可以在 slash proc slash 37684 上执行 ls，我可以看到这个目录
--that contains all sorts of information about my process, right? 00:03:29,400 --> 00:03:32,560
包含关于我的过程的各种信息，对吗？
--Each of these files contain different things. 00:03:32,560 --> 00:03:35,120
这些文件中的每一个都包含不同的内容。
--I don't want to spend a lot of time in this particular class diving through that, 00:03:35,120 --> 00:03:39,040
我不想花很多时间在这个特定的课程上，
--because it's really not necessarily related to parallel programming, but 00:03:39,040 --> 00:03:42,640
因为它真的不一定与并行编程有关，但是
--it's a good thing to know, okay? 00:03:42,640 --> 00:03:44,960
知道是件好事，好吗？
--And so if you look there, you'll see directories that relate to my file 00:03:44,960 --> 00:03:48,360
所以如果你看那里，你会看到与我的文件相关的目录
--descriptors, relate to file info, relate to my memory map, and so on. 00:03:48,360 --> 00:03:53,600
描述符，与文件信息相关，与我的内存映射相关，等等。
--If I do an ls on fd, 00:03:53,600 --> 00:04:02,120
如果我在 fd 上执行 ls，
--you'll see a directory for each of the file descriptors I have open. 00:04:02,120 --> 00:04:05,080
您将看到我打开的每个文件描述符的目录。
--So you'll see a file representing my standard in, my standard out. 00:04:06,320 --> 00:04:09,880
所以你会看到一个文件代表我的标准输入，我的标准输出。
--File descriptors 15, 16, 17, 18, 19, and 2, right? 00:04:09,880 --> 00:04:13,800
文件描述符 15、16、17、18、19 和 2，对吗？
--My standard error, and so on. 00:04:13,800 --> 00:04:14,920
我的标准错误，等等。
--If we take a look at 00:04:19,280 --> 00:04:22,400
如果我们看一下
--any one of these files, let's see. 00:04:26,840 --> 00:04:29,760
这些文件中的任何一个，让我们看看。
--What's a good one to look at? 00:04:36,040 --> 00:04:37,880
有什么好看的？
--Let's say maps. 00:04:37,880 --> 00:04:38,840
让我们说地图。
--We'll see my current process memory map. 00:04:40,600 --> 00:04:43,080
我们将看到我当前的进程内存映射。
--Yeah. 00:04:43,560 --> 00:04:44,040
是的。
--Let me see if I can also view. 00:04:44,040 --> 00:04:52,040
让我看看我是否也可以查看。
--Customize. 00:04:52,040 --> 00:04:54,040
定制。
--View. 00:04:54,040 --> 00:04:56,040
看法。
--View. 00:04:56,040 --> 00:04:58,040
看法。
--View. 00:04:58,040 --> 00:05:00,040
看法。
--View. 00:05:00,040 --> 00:05:02,040
看法。
--View. 00:05:02,040 --> 00:05:04,040
看法。
--View. 00:05:04,040 --> 00:05:06,040
看法。
--View. 00:05:06,040 --> 00:05:08,040
看法。
--View. 00:05:08,040 --> 00:05:10,040
看法。
--View. 00:05:10,040 --> 00:05:12,040
看法。
--There it is. 00:05:12,160 --> 00:05:14,160
就在那里。
--It should be able to change the font side. 00:05:31,760 --> 00:05:34,860
它应该能够改变字体的一面。
--User interface thing. 00:05:37,360 --> 00:05:38,660
用户界面的事情。
--There we go. 00:05:38,660 --> 00:05:40,660
我们开始了。
--That's very big now, but that's okay. 00:05:42,040 --> 00:05:49,640
现在已经很大了，不过没关系。
--I mean, when it comes to teaching, I always wonder what it is that I can accomplish inside 00:05:49,640 --> 00:05:56,840
我的意思是，说到教学，我总是想知道我能在内心完成什么
--a single class. 00:05:56,840 --> 00:05:57,840
一个班级。
--And I've been trying for years, but I haven't been able to figure out a way to core dump 00:05:57,840 --> 00:06:01,880
而且我已经尝试了很多年，但一直无法找到核心转储的方法
--into a collection of students. 00:06:01,880 --> 00:06:02,880
到学生集合中。
--And I'm not sure if I could actually core dump into your brains if you consider that 00:06:02,880 --> 00:06:07,400
如果你考虑的话，我不确定我是否真的可以将核心转储到你的大脑中
--to your benefit or detriment, right? 00:06:07,400 --> 00:06:09,680
对你有利或不利，对吧？
--But what I've sort of discovered is that I can tell you sort of what you need to learn, 00:06:09,680 --> 00:06:15,160
但我发现我可以告诉你一些你需要学习的东西，
--and I can motivate you to learn it, and sort of help you figure out when you've learned 00:06:15,160 --> 00:06:19,640
我可以激励你去学习它，并在某种程度上帮助你弄清楚你什么时候学会了
--it. 00:06:19,640 --> 00:06:20,640
它。
--And that's sort of good enough because then you can go back and do that, right? 00:06:20,640 --> 00:06:23,480
这已经足够好了，因为你可以回去做那个，对吧？
--And so if you sort of right now realize that slash proc has a bunch of these different 00:06:23,480 --> 00:06:27,000
所以如果你现在意识到 slash proc 有很多不同的东西
--things, then I think that's sort of good enough for us. 00:06:27,000 --> 00:06:31,920
事情，那么我认为这对我们来说已经足够了。
--Now I can get back to my own proc, sort of interesting. 00:06:31,920 --> 00:06:38,920
现在我可以回到我自己的过程，有点有趣。
--It may be, but I think there may be a bigger issue. 00:06:39,160 --> 00:06:44,160
可能是，但我认为可能存在更大的问题。
--We'll find out in a second. 00:06:44,160 --> 00:06:45,160
我们马上就会知道。
--The thing that I want you to see from slash proc right now is this thing called CPU info. 00:06:45,160 --> 00:06:54,160
我想让你现在从 slash proc 看到的东西是这个叫做 CPU 信息的东西。
--And CPU info gives you information, shockingly and amazingly, about your CPU. 00:06:54,160 --> 00:07:02,160
 CPU 信息为您提供有关您的 CPU 的信息，令人震惊和惊奇。
--Nobody would have ever guessed that, I know. 00:07:02,160 --> 00:07:07,160
没有人会猜到这一点，我知道。
--When you see a vendor ID of genuine Intel, I think you may wonder if this is an AMD processor. 00:07:07,400 --> 00:07:16,400
当您看到正品英特尔的供应商 ID 时，我想您可能想知道这是否是 AMD 处理器。
--Model name, again, shocking, Xeon E5-3680 version 2 at 2.8 GHz, right? 00:07:16,400 --> 00:07:28,400
型号名称，再次令人震惊，至强 E5-3680 第 2 版，频率为 2.8 GHz，对吗？
--So this file tells you all about your processor, and if you look, the format is pretty easy, 00:07:28,400 --> 00:07:36,400
所以这个文件告诉你所有关于你的处理器，如果你看，格式很简单，
--there's a label, there's a colon, there's the information. 00:07:36,640 --> 00:07:40,640
有标签，有冒号，有信息。
--It's designed to be easily read by humans and also easily processed by things like shell 00:07:40,640 --> 00:07:44,640
它被设计成易于人类阅读，也易于被 shell 之类的东西处理
--scripts and so on. 00:07:44,640 --> 00:07:45,640
脚本等等。
--Yeah? 00:07:45,640 --> 00:07:46,640
是的？
--Is there anything in this file that's unique to a specific process, or is it just the same 00:07:46,640 --> 00:07:50,640
此文件中是否有特定进程独有的内容，或者只是相同的内容
--file that every process has a link to? 00:07:50,640 --> 00:07:52,640
每个进程都有链接的文件？
--There is nothing about this that's unique to a process. 00:07:52,640 --> 00:07:55,640
没有什么是流程所独有的。
--Because in this particular case, every process is sharing the same processor. 00:07:55,640 --> 00:08:00,640
因为在这种特殊情况下，每个进程都共享同一个处理器。
--Now, if we talk about looking at your process's information, what they do is they use UNIX 00:08:00,880 --> 00:08:06,880
现在，如果我们谈论查看您的进程的信息，他们所做的就是他们使用 UNIX
--file permissions to make sure that only the owner of the process can see the private parts 00:08:06,880 --> 00:08:11,880
文件权限以确保只有进程的所有者才能看到私有部分
--of that process. 00:08:11,880 --> 00:08:12,880
那个过程。
--So although you can inspect your own file descriptors, I can't inspect your file descriptors 00:08:12,880 --> 00:08:16,880
所以虽然你可以检查你自己的文件描述符，但我不能检查你的文件描述符
--to see what files you have opened. 00:08:16,880 --> 00:08:18,880
查看您打开了哪些文件。
--And although you can see your memory map, I can't go in and see your memory map. 00:08:18,880 --> 00:08:23,880
而且虽然你可以看到你的内存映射，但是我不能进去看你的内存映射。
--So that's protected by the standard UNIX read, write, and execute permissions for the 00:08:23,880 --> 00:08:28,880
所以它受到标准 UNIX 读、写和执行权限的保护
--user, the group, and the world. 00:08:29,120 --> 00:08:31,120
用户、组和世界。
--Does that make sense? 00:08:31,120 --> 00:08:33,120
那有意义吗？
--So it works really nicely in that you can dive down really deep into your own processes. 00:08:33,120 --> 00:08:38,120
所以它工作得非常好，因为你可以深入了解你自己的流程。
--You can get all the general information about the system state. 00:08:38,120 --> 00:08:41,120
您可以获得有关系统状态的所有一般信息。
--And if you're the system administrator running this route, there are actually some of these 00:08:41,120 --> 00:08:44,120
如果你是运行这条路线的系统管理员，实际上有一些
--things you can use. 00:08:44,120 --> 00:08:45,120
你可以使用的东西。
--They're called tunables. 00:08:45,120 --> 00:08:46,120
它们被称为可调参数。
--And you can actually change values of some of these files to change some of the system 00:08:46,120 --> 00:08:49,120
你实际上可以改变其中一些文件的值来改变一些系统
--performance parameters. 00:08:49,120 --> 00:08:51,120
性能参数。
--And so Slashproc is really a beautiful interface, I think. 00:08:51,120 --> 00:08:57,120
所以我认为 Slashproc 确实是一个漂亮的界面。
--Okay. 00:08:57,360 --> 00:08:58,360
好的。
--So this gives us a whole bunch of details about our processor. 00:08:58,360 --> 00:09:03,360
因此，这为我们提供了有关处理器的大量详细信息。
--And as it turns out, most of it is pretty intuitive. 00:09:03,360 --> 00:09:08,360
事实证明，其中大部分都非常直观。
--But some things get slightly strange. 00:09:08,360 --> 00:09:12,360
但是有些事情变得有点奇怪。
--We see things like core ID and processor number and so on. 00:09:12,360 --> 00:09:20,360
我们看到诸如核心 ID 和处理器编号等内容。
--And so you'll see that there's a processor 1 and processor 2 and processor 3 and processor 00:09:20,360 --> 00:09:25,360
所以你会看到有一个处理器 1 和处理器 2 和处理器 3 和处理器
--4 and processor 7 and blah 9 and so on. 00:09:25,600 --> 00:09:29,600
4 和处理器 7 和 blah 9 等等。
--11. 00:09:29,600 --> 00:09:30,600
 11.
--Do you think we actually have, I don't know, it looks like 20, 30 something actual 40 actual 00:09:30,600 --> 00:09:39,600
你认为我们实际上有吗，我不知道，看起来像 20、30 实际有 40 实际
--cores on this? 00:09:39,600 --> 00:09:41,600
核心在这？
--Do you think we actually have 40 processors on this, 0 to 39? 00:09:41,600 --> 00:09:47,600
你认为我们实际上有 40 个处理器，0 到 39？
--How many people think we actually have what, you know, 40 of what most people would consider 00:09:47,600 --> 00:09:51,600
有多少人认为我们实际上拥有大多数人认为的 40 个
--processors on this system? 00:09:51,600 --> 00:09:53,600
这个系统上的处理器？
--How many people think that there's something here that's looking like a processor that 00:09:53,840 --> 00:09:59,840
有多少人认为这里有一些看起来像处理器的东西
--may not be an actual processor? 00:09:59,840 --> 00:10:03,840
可能不是真正的处理器？
--Yeah. 00:10:03,840 --> 00:10:05,840
是的。
--So there's this thing called a sibling. 00:10:05,840 --> 00:10:09,840
所以有一个叫做兄弟姐妹的东西。
--Siblings. 00:10:10,080 --> 00:10:24,080
兄弟姐妹。
--20. 00:10:24,080 --> 00:10:26,080
 20.
--Well, we have 40 processors and 20 siblings. 00:10:26,080 --> 00:10:31,080
嗯，我们有 40 个处理器和 20 个兄弟。
--What might that suggest? 00:10:31,080 --> 00:10:38,080
这可能意味着什么？
--What do you think might give us the impression of having more processors than we actually 00:10:38,320 --> 00:10:41,320
您认为什么可能会给我们这样的印象：处理器数量比实际多
--do? 00:10:41,320 --> 00:10:42,320
做？
--Yeah. 00:10:42,320 --> 00:10:43,320
是的。
--We have like one processor with 20 cores and two threads for every core. 00:10:43,320 --> 00:10:48,320
我们有一个处理器，有 20 个内核，每个内核有两个线程。
--Yeah, we get a lot of hyper-threading going on, right? 00:10:48,320 --> 00:10:52,320
是的，我们有很多超线程正在进行，对吧？
--And so that's exactly what this is. 00:10:52,320 --> 00:10:54,320
这就是事实。
--And so we bounce over back to my PowerPoint presentation for a second. 00:10:54,320 --> 00:11:01,320
因此，我们暂时回到我的 PowerPoint 演示文稿。
--Ta-da! 00:11:01,320 --> 00:11:04,320
哒哒！
--Here are some of the things that are probably worth just looking at from the perspective 00:11:04,560 --> 00:11:08,560
从这个角度来看，这里有一些可能值得一看的东西
--of this class and how they're related. 00:11:08,560 --> 00:11:12,560
这个类的以及它们是如何相关的。
--The model name is shockingly and amazingly the model name. 00:11:12,560 --> 00:11:15,560
型号名称令人震惊和惊讶的是型号名称。
--CPU megahertz is interesting because it's the speed right now. 00:11:15,560 --> 00:11:23,560
 CPU 兆赫兹很有趣，因为它是现在的速度。
--The speed right now. 00:11:23,560 --> 00:11:25,560
现在的速度。
--A lot of times the model name includes the maximum speed of the processor. 00:11:25,560 --> 00:11:29,560
很多时候型号名称包括处理器的最大速度。
--But processors these days are really weird, right? 00:11:29,560 --> 00:11:31,560
但是现在的处理器真的很奇怪，对吧？
--They have a speed stepping where they'll actually slow down to save energy. 00:11:31,800 --> 00:11:35,800
他们有一个速度步进，他们实际上会放慢速度以节省能量。
--And they have a turbo mode they can run in for a short period of time before they burn 00:11:35,800 --> 00:11:38,800
它们有涡轮模式，可以在燃烧前运行一小段时间
--themselves out and still go into it for brief periods and then step back. 00:11:38,800 --> 00:11:42,800
他们自己出去了，但仍然会短暂地投入其中，然后退后一步。
--And so what that CPU speed is, it tells you what speed it's running at right at this moment. 00:11:42,800 --> 00:11:48,800
那么 CPU 的速度是多少，它会告诉你此时它的运行速度是多少。
--As opposed to the information often times given in the model name, which will tell you 00:11:48,800 --> 00:11:51,800
与模型名称中经常给出的信息相反，它会告诉您
--its maximum speed. 00:11:51,800 --> 00:11:53,800
它的最大速度。
--But it reports, yeah? 00:11:53,800 --> 00:11:55,800
但它报告，是吗？
--If siblings is the number of hyperthreads, why was it reporting 40 cores? 00:11:56,040 --> 00:12:01,040
如果 siblings 是超线程的数量，为什么它报告 40 个核心？
--Because when it reports a core in the way this is going to report it, it's going to 00:12:01,040 --> 00:12:07,040
因为当它以这种方式报告核心时，它将
--turn out to include a hyperthread. 00:12:07,040 --> 00:12:10,040
结果包括一个超线程。
--Because the hyperthread is exposed to the operating system as if it's a core, such 00:12:10,040 --> 00:12:13,040
因为超线程暴露给操作系统就好像它是一个核心一样，这样
--that the operating system can schedule processes onto it. 00:12:13,040 --> 00:12:17,040
操作系统可以在其上安排进程。
--Because an operating system doesn't have an understanding of a hyperthreading ability, 00:12:17,040 --> 00:12:20,040
因为操作系统不了解超线程能力，
--it has an understanding of I need to dispatch a task. 00:12:20,040 --> 00:12:23,040
它了解我需要分派任务。
--On the slide it says siblings is the number of hyperthreads. 00:12:23,280 --> 00:12:27,280
在幻灯片上它说 siblings 是超线程的数量。
--And we saw siblings 20, but we saw- 00:12:27,280 --> 00:12:30,280
我们看到了 20 岁的兄弟姐妹，但我们看到了——
--Per core. 00:12:30,280 --> 00:12:31,280
每个核心。
--Oh. 00:12:31,280 --> 00:12:32,280
哦。
--Yes, that's multiplied. 00:12:34,280 --> 00:12:36,280
是的，这是成倍增加的。
--Cache size. 00:12:36,280 --> 00:12:37,280
缓存大小。
--Only the outermost cache is shown. 00:12:37,280 --> 00:12:41,280
仅显示最外层的缓存。
--So when you look at these processors, often times they have a cache per core, right? 00:12:41,280 --> 00:12:45,280
因此，当您查看这些处理器时，通常每个内核都有一个缓存，对吗？
--That's not shown here. 00:12:45,280 --> 00:12:46,280
这里没有显示。
--What's shown here is effectively the level three cache. 00:12:46,280 --> 00:12:49,280
这里显示的实际上是三级缓存。
--The cache that's shared by all the cores. 00:12:49,280 --> 00:12:52,280
由所有内核共享的缓存。
--Okay, so it's only showing the outermost cache. 00:12:52,520 --> 00:12:55,520
好的，所以它只显示最外层的缓存。
--Siblings, processors, CPU cores, core ID, physical ID. 00:12:55,520 --> 00:13:00,520
兄弟、处理器、CPU 内核、内核 ID、物理 ID。
--That's going to be the socket number. 00:13:00,520 --> 00:13:02,520
那将是套接字编号。
--That's going to be like socket zero or socket one. 00:13:02,520 --> 00:13:04,520
这就像插座零或插座一。
--So if you have a multiprocessor system, you have like two processors, each of which has 00:13:04,520 --> 00:13:08,520
所以如果你有一个多处理器系统，你有两个处理器，每个处理器都有
--eight cores, right? 00:13:08,520 --> 00:13:09,520
八核对不对？
--That socket ID is going to tell you that. 00:13:09,520 --> 00:13:13,520
该套接字 ID 会告诉您这一点。
--Flags will tell you about the capabilities of the processor. 00:13:13,520 --> 00:13:17,520
标志将告诉您有关处理器的功能。
--For example, we've been using AVX2 instructions. 00:13:17,520 --> 00:13:21,520
例如，我们一直在使用 AVX2 指令。
--And the flags will show you that these processors have that capability. 00:13:21,760 --> 00:13:25,760
这些标志将向您展示这些处理器具有该功能。
--So there is just this treasure trove of information there. 00:13:25,760 --> 00:13:29,760
所以那里只有这个信息宝库。
--And the trick to it is not to get distracted by all of it. 00:13:29,760 --> 00:13:32,760
诀窍是不要被所有这些分散注意力。
--Because it really is easy to open it up and sort of tap through. 00:13:32,760 --> 00:13:35,760
因为打开它并轻敲它真的很容易。
--Blah, blah, blah, blah, blah, blah, blah. 00:13:35,760 --> 00:13:37,760
呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜
--Right? 00:13:37,760 --> 00:13:38,760
正确的？
--And you saw what I did when I was looking for something in particular, right? 00:13:38,760 --> 00:13:42,760
当我在寻找特别的东西时，你看到了我所做的，对吧？
--I made use of breadth. 00:13:42,760 --> 00:13:44,760
我利用了广度。
--Right? 00:13:45,000 --> 00:13:49,000
正确的？
--I knew what information I wanted. 00:13:49,000 --> 00:13:51,000
我知道我想要什么信息。
--And I used breadth to go find it. 00:13:51,000 --> 00:13:53,000
我用广度去找到它。
--How many people are familiar with breadth? 00:13:53,000 --> 00:13:55,000
有多少人熟悉广度？
--Excellent. 00:13:55,000 --> 00:13:56,000
出色的。
--How many people are not familiar with breadth? 00:13:56,000 --> 00:13:58,000
有多少人不熟悉广度？
--Excellent. 00:13:58,000 --> 00:13:59,000
出色的。
--Drop by my office. 00:13:59,000 --> 00:14:00,000
顺便来我的办公室。
--We'll chat. 00:14:00,000 --> 00:14:03,000
我们会聊天。
--Breadth is a really great tool. 00:14:03,000 --> 00:14:06,000
广度是一个非常棒的工具。
--Don't feel badly if you're one of the people who didn't raise your hand because you hadn't 00:14:06,000 --> 00:14:10,000
如果您是因为您没有举手而没有举手的人之一，请不要难过
--seen it before. 00:14:10,000 --> 00:14:11,000
以前看过。
--Still, drop by my office and we'll chat. 00:14:11,000 --> 00:14:13,000
不过，顺便来我的办公室，我们聊聊。
--Just in case that you didn't happen to see it before. 00:14:13,240 --> 00:14:17,240
以防万一您之前没有碰巧看到它。
--Prior exposure to breadth is in fact, after careful study, not in any way related to success 00:14:17,240 --> 00:14:21,240
事先接触广度其实经过仔细研究，与成功没有任何关系
--in computer science. 00:14:21,240 --> 00:14:24,240
在计算机科学中。
--However, failing to learn breadth, what you've been told about it, is in fact related to 00:14:24,240 --> 00:14:28,240
然而，未能学习广度，正如你被告知的那样，实际上与
--future success in computer science. 00:14:28,240 --> 00:14:30,240
未来在计算机科学领域取得成功。
--So you should go learn breadth if you haven't already. 00:14:30,240 --> 00:14:34,240
所以如果你还没有，你应该去学习广度。
--Memory bandwidth is in there. 00:14:34,480 --> 00:14:43,480
内存带宽在那里。
--And that's sort of a good thing to look up. 00:14:43,480 --> 00:14:45,480
这是一件值得查找的好事。
--Power consumption is an interesting thing to know. 00:14:45,480 --> 00:14:48,480
功耗是一件有趣的事情。
--The code name is used. 00:14:48,480 --> 00:14:51,480
使用代号。
--This is no longer stuff from slash proc, by the way. 00:14:51,480 --> 00:14:55,480
顺便说一句，这不再是来自 slash proc 的东西。
--This is just good things to know about your processor. 00:14:55,480 --> 00:14:59,480
这是关于您的处理器的好消息。
--You generally want to know the memory bandwidth of your processor. 00:14:59,480 --> 00:15:03,480
您通常想知道处理器的内存带宽。
--This is important if you think, for example, about one of the questions on the assignment 00:15:03,720 --> 00:15:06,720
例如，如果您考虑作业中的其中一个问题，这一点很重要
--that basically asks you to figure out where the bottleneck is. 00:15:06,720 --> 00:15:10,720
这基本上要求您找出瓶颈在哪里。
--Are we bottlenecking because we can't move the data into and out of the processor fast enough? 00:15:10,720 --> 00:15:14,720
我们是否因为无法足够快地将数据移入和移出处理器而成为瓶颈？
--Or are we bottlenecking because we haven't optimized the instructions enough? 00:15:14,720 --> 00:15:18,720
还是因为我们没有充分优化指令而造成瓶颈？
--And it's taking too long. 00:15:18,720 --> 00:15:22,720
而且时间太长了。
--The power consumption is interesting to know because power actually turns out to be really 00:15:22,720 --> 00:15:26,720
了解功耗很有趣，因为功率实际上是
--important in the world. 00:15:26,720 --> 00:15:28,720
在世界上很重要。
--There are many environments that are actually power limited, believe it or not. 00:15:28,720 --> 00:15:32,720
不管你信不信，有许多环境实际上是功率受限的。
--If you're trying to operate a data center in New York City, you're not getting any more power. 00:15:32,720 --> 00:15:36,720
如果您试图在纽约市运营数据中心，您将无法获得更多电力。
--You can't buy it. It's simply not for sale. 00:15:36,720 --> 00:15:39,720
你不能买它。简直是非卖品。
--Con Edism is making all the power they're going to make. 00:15:39,720 --> 00:15:41,720
 Con Edism 正在发挥他们将要发挥的所有作用。
--They've sold all the power they're going to sell. 00:15:41,720 --> 00:15:43,720
他们已经卖掉了所有要卖的电力。
--And that's just the way it is. 00:15:43,720 --> 00:15:45,720
这就是它的方式。
--They've been power limited in New York City since the 70s. 00:15:45,720 --> 00:15:48,720
自 70 年代以来，他们在纽约市一直受到电力限制。
--And that's just not going to change. 00:15:48,720 --> 00:15:51,720
这不会改变。
--And there are many other places that are like that. 00:15:51,720 --> 00:15:53,720
还有很多其他类似的地方。
--And so when you think about power and you think about computation, 00:15:53,720 --> 00:15:57,720
所以当你想到功率和计算时，
--the interesting thing is that at scale, how much power you use is a pretty good proxy 00:15:57,720 --> 00:16:01,720
有趣的是，在规模上，你使用多少功率是一个很好的代理
--for how expensive a computation is. 00:16:01,720 --> 00:16:05,720
一个计算有多昂贵。
--If you can do a computation very quickly using relatively little power, 00:16:05,720 --> 00:16:09,720
如果你可以使用相对较少的功率非常快速地进行计算，
--at scale you're going to be able to do that much cheaper than a competitor who's taking 00:16:09,720 --> 00:16:13,720
在规模上，你将能够比竞争对手更便宜地做到这一点
--many more resources to solve that same problem. 00:16:13,720 --> 00:16:17,720
更多的资源来解决同样的问题。
--And so energy consumption is huge. 00:16:17,720 --> 00:16:20,720
所以能源消耗是巨大的。
--In many cases, we'd actually be willing to trade a slightly slower result for a result 00:16:20,720 --> 00:16:24,720
在许多情况下，我们实际上愿意用稍微慢一点的结果来换取更好的结果
--that uses slightly less energy because we pay for energy. 00:16:24,720 --> 00:16:28,720
因为我们为能源付费，所以使用的能源略少。
--And if we're in our time budget, it doesn't matter. 00:16:28,720 --> 00:16:31,720
如果我们在时间预算之内，那也没关系。
--So energy is actually a really big deal. 00:16:31,720 --> 00:16:33,720
所以能量实际上是一个非常大的问题。
--You want to know the code name of the processors. 00:16:33,720 --> 00:16:37,720
您想知道处理器的代号。
--Like in our case, the code name is Broadwell, which has the same architecture as a Haswell, 00:16:37,720 --> 00:16:42,720
就像在我们的案例中，代码名称是 Broadwell，它具有与 Haswell 相同的架构，
--but the manufacturer is smaller. 00:16:42,720 --> 00:16:46,720
但制造商较小。
--And that's important because that lets you look up the features of your processor 00:16:46,720 --> 00:16:50,720
这很重要，因为它可以让您查看处理器的功能
--to know what resources you have available when you're programming them. 00:16:50,720 --> 00:16:53,720
在编程时了解可用的资源。
--You want to know how many adders you have and how many multipliers you have 00:16:53,720 --> 00:16:56,720
你想知道你有多少个加法器和多少个乘法器
--and how rapidly you can dispatch them. 00:16:56,720 --> 00:16:58,720
以及你能以多快的速度派遣他们。
--Because unless you know that, you don't know how to optimize your code 00:16:58,720 --> 00:17:01,720
因为除非你知道，否则你不知道如何优化你的代码
--to make use of those resources. 00:17:01,720 --> 00:17:03,720
以利用这些资源。
--And so unless you know what processor you have, at that level of detail, 00:17:03,720 --> 00:17:06,720
所以除非你知道你有什么处理器，在那个细节层次上，
--you can't look it up. 00:17:06,720 --> 00:17:08,720
你查不到。
--Once you know what processor you have in terms of which microarchitecture it's using, 00:17:08,720 --> 00:17:12,720
一旦你知道你拥有的处理器以及它使用的微体系结构，
--in terms of exactly how it's implemented, 00:17:12,720 --> 00:17:15,720
就其具体实施方式而言，
--now you can turn around and optimize your code. 00:17:15,720 --> 00:17:18,720
现在你可以转身优化你的代码了。
--Because you know the functional units, you know the latencies, you know the cache sizes, 00:17:18,720 --> 00:17:21,720
因为你知道功能单元，你知道延迟，你知道缓存大小，
--and now you can start to make your code work well with that. 00:17:21,720 --> 00:17:25,720
现在你可以开始让你的代码很好地工作了。
--I think most of you have probably opened this up, but for those of you who haven't, 00:17:33,720 --> 00:17:36,720
我想你们中的大多数人可能已经打开了它，但是对于那些还没有打开的人来说，
--the devil's in the details. 00:17:36,720 --> 00:17:38,720
细节决定成败。
--And if you're looking for the details about our... 00:17:38,720 --> 00:17:40,720
如果您正在寻找有关我们...的详细信息
--Yeah? 00:17:40,720 --> 00:17:41,720
是的？
--Does the fact that the memory has four channels 00:17:41,720 --> 00:17:43,720
内存有四个通道的事实吗
--change the way that we're supposed to think about the bandwidth? 00:17:43,720 --> 00:17:45,720
改变我们应该考虑带宽的方式？
--Does the fact that the memory has channels 00:17:45,720 --> 00:17:47,720
难道内存有通道这个事实
--change the way you're supposed to think about the bandwidth? 00:17:47,720 --> 00:17:49,720
改变您应该考虑带宽的方式？
--So, when it comes to optimizing code for a machine, 00:17:49,720 --> 00:17:53,720
所以，当涉及到为机器优化代码时，
--the frightening thing is that there is no bottom. 00:17:53,720 --> 00:17:57,720
可怕的是没有底。
--There is absolutely no bottom. 00:17:57,720 --> 00:18:00,720
绝对没有底。
--So, when I optimize code, 00:18:00,720 --> 00:18:03,720
所以，当我优化代码时，
--I take a look at that top-end bandwidth number, 00:18:03,720 --> 00:18:06,720
我看一下那个高端带宽数字，
--and I think, I'm lucky to get half. 00:18:06,720 --> 00:18:09,720
我想，我很幸运能得到一半。
--That's the capacity that Greg has with optimizing code. 00:18:09,720 --> 00:18:13,720
这就是 Greg 优化代码的能力。
--Now, I've seen some of the code that Randy's written, 00:18:13,720 --> 00:18:16,720
现在，我看到了兰迪写的一些代码，
--and I've seen him get 80x speedups, 00:18:16,720 --> 00:18:18,720
我见过他获得了 80 倍的加速，
--but I got 40x speedups. 00:18:18,720 --> 00:18:20,720
但我得到了 40 倍的加速。
--Okay? Or less. 00:18:20,720 --> 00:18:22,720
好的？或更少。
--And so, sure, if you know that memory has more channels, 00:18:22,720 --> 00:18:26,720
所以，当然，如果你知道内存有更多通道，
--and you're really, really, really good, 00:18:26,720 --> 00:18:28,720
你真的非常非常好
--you may be able to use that to reason a little more about 00:18:28,720 --> 00:18:31,720
你也许可以用它来推理更多关于
--how many reads and writes you can dispatch simultaneously and so on. 00:18:31,720 --> 00:18:35,720
您可以同时发送多少读写操作等等。
--Can I? The answer is no. 00:18:37,720 --> 00:18:39,720
我可以吗？答案是不。
--Is there not a really clear rule, like, 00:18:40,720 --> 00:18:43,720
有没有一个非常明确的规则，比如，
--you need four processors to use a channel? 00:18:43,720 --> 00:18:46,720
您需要四个处理器才能使用一个通道吗？
--No, there isn't a really clear rule. 00:18:46,720 --> 00:18:48,720
不，没有真正明确的规则。
--The reason is that, because there's latency involved in a memory request, 00:18:48,720 --> 00:18:53,720
原因是，因为内存请求涉及延迟，
--in a hyper-threading processor, you can have several dispatches. 00:18:53,720 --> 00:18:57,720
在超线程处理器中，您可以有多个分派。
--And so, the rule is, at least if there's one, I don't know it. 00:18:57,720 --> 00:19:01,720
所以，规则是，至少如果有的话，我不知道。
--And the rule isn't as simple as n cores for n channels. 00:19:01,720 --> 00:19:05,720
而且规则并不像 n 个通道的 n 个内核那么简单。
--Now, I think it's really important that when I say these things, 00:19:06,720 --> 00:19:10,720
现在，我认为非常重要的是当我说这些话时，
--like, no, there's not a rule, 00:19:10,720 --> 00:19:12,720
就像，不，没有规则，
--what I really mean is, no, there's not a rule that I know. 00:19:12,720 --> 00:19:14,720
我真正的意思是，不，我不知道有什么规则。
--Because I have a feeling, and there's probably not a simple rule. 00:19:14,720 --> 00:19:17,720
因为我有一种感觉，可能没有简单的规则。
--I have a feeling that somebody who knows way more than me 00:19:17,720 --> 00:19:20,720
我有一种感觉，有人比我更了解
--could articulate some scheduling discipline within their architecture 00:19:20,720 --> 00:19:26,720
可以在他们的架构中阐明一些调度规则
--that could be useful in some cases. 00:19:26,720 --> 00:19:29,720
这在某些情况下可能很有用。
--I just don't happen to know it. 00:19:29,720 --> 00:19:31,720
我只是碰巧不知道。
--And when it comes to that aggregate bandwidth, 00:19:35,720 --> 00:19:37,720
当谈到总带宽时，
--it's important to realize that you very rarely see all of that. 00:19:37,720 --> 00:19:40,720
重要的是要意识到你很少看到所有这些。
--That aggregate bandwidth may be with a particular request pattern 00:19:40,720 --> 00:19:43,720
该聚合带宽可能具有特定的请求模式
--that might be mostly reads or something, right? 00:19:43,720 --> 00:19:45,720
那可能主要是阅读什么的，对吧？
--And now you have a mixed read-write pattern, 00:19:45,720 --> 00:19:47,720
现在你有一个混合的读写模式，
--and so you're not going to see that. 00:19:47,720 --> 00:19:48,720
所以你不会看到那个。
--Like I said, when I look at a program, 00:19:48,720 --> 00:19:51,720
就像我说的，当我看一个节目时，
--and it's a general purpose program, 00:19:51,720 --> 00:19:53,720
这是一个通用程序，
--and I see myself popping out about half of my memory bandwidth, 00:19:53,720 --> 00:19:56,720
我看到自己突然用掉了大约一半的内存带宽，
--I think, jeez, I'm probably not really going to get more than that. 00:19:56,720 --> 00:20:00,720
我想，哎呀，我可能真的不会得到更多。
--If I was in a situation where I had to, 00:20:00,720 --> 00:20:03,720
如果我处于不得不这样做的境地，
--then I would probably start benchmarking the system and say, 00:20:03,720 --> 00:20:05,720
然后我可能会开始对系统进行基准测试并说，
--okay, if I do all reads, 00:20:05,720 --> 00:20:07,720
好吧，如果我做所有的阅读，
--and I make this pathogenic process that's all reads, 00:20:07,720 --> 00:20:10,720
我做了这个致病过程，这就是所有的内容，
--what can I get out of it? 00:20:10,720 --> 00:20:11,720
我能从中得到什么？
--And if I make this pathogenic process that's all writes, 00:20:11,720 --> 00:20:14,720
如果我把这个致病过程写下来，
--what can I get out of it? 00:20:14,720 --> 00:20:15,720
我能从中得到什么？
--And as I start to interleave reads into my write stream, 00:20:15,720 --> 00:20:18,720
当我开始将读取交织到我的写入流中时，
--what am I seeing? 00:20:18,720 --> 00:20:19,720
我看到了什么？
--How does that change as that mix changes? 00:20:19,720 --> 00:20:21,720
随着混合的变化，它会如何变化？
--And then I would profile it in terms of my cache performance and so on. 00:20:21,720 --> 00:20:25,720
然后我会根据我的缓存性能等来分析它。
--And I'd have to build a model of what that memory was. 00:20:25,720 --> 00:20:28,720
而且我必须建立一个模型来描述那个记忆是什么。
--And then once I built that model, 00:20:28,720 --> 00:20:31,720
然后一旦我建立了那个模型，
--then I would try to tune my programs to what I empirically saw. 00:20:31,720 --> 00:20:34,720
然后我会尝试将我的程序调整为我凭经验看到的。
--But in terms of a simple rule of thumb, 00:20:34,720 --> 00:20:37,720
但根据一个简单的经验法则，
--I haven't had that luck other than with just very coarse rules in terms of memory. 00:20:37,720 --> 00:20:43,720
除了在记忆方面的非常粗略的规则之外，我没有运气。
--Once I profile a system, like I said, I can often do better. 00:20:43,720 --> 00:20:46,720
就像我说的那样，一旦我分析了一个系统，我通常可以做得更好。
--But that takes a lot of work to be able to profile it. 00:20:46,720 --> 00:20:49,720
但这需要大量工作才能对其进行分析。
--It has to be worth it. 00:20:49,720 --> 00:20:52,720
它必须是值得的。
--So here's a link to some processor, 00:20:52,720 --> 00:20:54,720
所以这是一些处理器的链接，
--to a document that's got a whole bunch of details about the architecture that we have. 00:20:54,720 --> 00:20:58,720
到一份文档，该文档包含关于我们所拥有的体系结构的大量详细信息。
--Also, Chapter 5 of your old 213 textbook. 00:20:58,720 --> 00:21:01,720
另外，您的旧 213 教科书的第 5 章。
--It's an amazing textbook. 00:21:01,720 --> 00:21:03,720
这是一本了不起的教科书。
--Chapter 5 also covers this architecture in a lot of detail. 00:21:03,720 --> 00:21:06,720
第 5 章还详细介绍了该体系结构。
--And so if you're looking for that information about the processor, 00:21:06,720 --> 00:21:11,720
因此，如果您正在寻找有关处理器的信息，
--a great place to look. 00:21:11,720 --> 00:21:12,720
一个很棒的地方。
--So here's some stuff that I extracted from those documents. 00:21:12,720 --> 00:21:18,720
所以这是我从这些文档中提取的一些内容。
--Things that are interesting to know. 00:21:18,720 --> 00:21:19,720
有趣的事情。
--The functional units, the parts of the processor actually do the work. 00:21:19,720 --> 00:21:23,720
功能单元，处理器的部分实际上完成了工作。
--Remember, our model of this processor is that it's sort of like an assembly line. 00:21:23,720 --> 00:21:27,720
请记住，我们的处理器模型有点像装配线。
--Instructions come in. 00:21:27,720 --> 00:21:28,720
指令进来。
--They get decoded. 00:21:28,720 --> 00:21:29,720
他们被解码。
--They get dispatched. 00:21:29,720 --> 00:21:30,720
他们被派遣。
--They execute out of order as long as there are no data dependencies 00:21:30,720 --> 00:21:34,720
只要没有数据依赖性，它们就会乱序执行
--or other structural hazards that prevent that. 00:21:34,720 --> 00:21:37,720
或其他阻止这种情况的结构性危险。
--They come out into a retirement unit. 00:21:37,720 --> 00:21:39,720
他们来到退休单位。
--Things get committed to the real world in order out of that retirement unit. 00:21:39,720 --> 00:21:45,720
为了离开那个退休单位，事情会致力于现实世界。
--There are many copies of the registers. 00:21:45,720 --> 00:21:47,720
登记册有很多副本。
--In 213, we talked about a register set. 00:21:47,720 --> 00:21:49,720
 213我们讲了一个寄存器集。
--But actually, there are many copies of those registers within the processor 00:21:49,720 --> 00:21:52,720
但实际上，处理器中有很多这些寄存器的副本
--that allow for things to happen in parallel. 00:21:52,720 --> 00:21:56,720
允许事情并行发生。
--Hyper-threading, it's not just one instruction stream that can execute in parallel, 00:21:56,720 --> 00:22:00,720
超线程，不仅仅是一条指令流可以并行执行，
--but it can keep track of multiple instruction streams. 00:22:00,720 --> 00:22:03,720
但它可以跟踪多个指令流。
--So the operating system may dispatch two different processors 00:22:03,720 --> 00:22:07,720
所以操作系统可能会分派两个不同的处理器
--or two different threads, 00:22:07,720 --> 00:22:08,720
或者两个不同的线程，
--thinking it's dispatching them to two different processors 00:22:08,720 --> 00:22:11,720
认为它正在将它们分派给两个不同的处理器
--because hyper-threads are represented as cores, 00:22:11,720 --> 00:22:14,720
因为超线程被表示为核心，
--when in reality those two processors are just hyper-threads 00:22:14,720 --> 00:22:17,720
而实际上这两个处理器只是超线程
--associated with the same hardware. 00:22:17,720 --> 00:22:19,720
与相同的硬件相关联。
--That just means that the processor has the ability to tag which flow they're part of 00:22:19,720 --> 00:22:23,720
这只是意味着处理器有能力标记它们属于哪个流
--and keep them separate as it retires them. 00:22:23,720 --> 00:22:28,720
并在退休时将它们分开。
--These functional units are actually like the stations inside the processor 00:22:28,720 --> 00:22:31,720
这些功能单元实际上就像处理器内部的站
--that are doing the work. 00:22:31,720 --> 00:22:34,720
正在做的工作。
--Functional units can do different things. 00:22:34,720 --> 00:22:36,720
功能单元可以做不同的事情。
--Here we see the eight functional units. 00:22:36,720 --> 00:22:38,720
在这里我们看到了八个功能单元。
--If we look at their capabilities, things like integer arithmetic, 00:22:38,720 --> 00:22:41,720
如果我们看看他们的能力，比如整数运算，
--meaning adds and subtracts and things like that, 00:22:41,720 --> 00:22:44,720
意思是加减法之类的，
--branches and so on, 00:22:44,720 --> 00:22:46,720
分支机构等，
--we can see what we can actually do 00:22:46,720 --> 00:22:48,720
我们可以看到我们实际上能做什么
--and how many of them we can actually do at a time. 00:22:48,720 --> 00:22:50,720
以及我们一次实际上可以做多少。
--Saturating the functional units would mean that we're doing everything we can 00:22:50,720 --> 00:22:53,720
使功能单元饱和意味着我们正在竭尽所能
--at a particular point in time, 00:22:53,720 --> 00:22:55,720
在特定的时间点，
--but that's usually not possible 00:22:55,720 --> 00:22:57,720
但这通常是不可能的
--because the particular instruction stream we have doesn't support that. 00:22:57,720 --> 00:23:00,720
因为我们拥有的特定指令流不支持它。
--There's not enough parallelism. 00:23:00,720 --> 00:23:06,720
没有足够的并行性。
--We can do four different independent integer operations, 00:23:06,720 --> 00:23:10,720
我们可以做四种不同的独立整数运算，
--things like adds and subtracts and shifts. 00:23:10,720 --> 00:23:14,720
诸如加减法和移位之类的东西。
--It takes two functional units to store an address. 00:23:14,720 --> 00:23:17,720
它需要两个功能单元来存储一个地址。
--That's an interesting observation, I think. 00:23:17,720 --> 00:23:20,720
我认为这是一个有趣的观察。
--One to compute the address and the other to store it, 00:23:20,720 --> 00:23:23,720
一个计算地址，另一个存储地址，
--which makes sense if you think about it 00:23:23,720 --> 00:23:25,720
如果你考虑一下，这是有道理的
--because those are really very, very different types of things. 00:23:25,720 --> 00:23:29,720
因为那些真的是非常非常不同类型的东西。
--One is math and one is memory. 00:23:29,720 --> 00:23:35,720
一个是数学，一个是记忆。
--In thinking about how it is that we can use these functional units, 00:23:35,720 --> 00:23:40,720
在思考我们如何使用这些功能单元时，
--there are a couple of things that we want to think about. 00:23:40,720 --> 00:23:45,720
我们需要考虑几件事。
--Latency and issue time are two critical ones. 00:23:45,720 --> 00:23:51,720
延迟和发布时间是两个关键因素。
--Latency is how long it actually takes to do one instance of the instruction. 00:23:51,720 --> 00:23:57,720
延迟是执行指令的一个实例实际需要多长时间。
--How many clock cycles that takes. 00:23:57,720 --> 00:24:00,720
需要多少个时钟周期。
--Something like a multiply is a much longer instruction 00:24:00,720 --> 00:24:04,720
像乘法这样的指令要长得多
--than something like an add or a shift 00:24:04,720 --> 00:24:07,720
比添加或转移之类的东西
--in terms of the number of clock cycles. 00:24:07,720 --> 00:24:10,720
在时钟周期数方面。
--But that doesn't tell the whole story 00:24:10,720 --> 00:24:13,720
但这并不能说明全部
--because there's the issue time, 00:24:13,720 --> 00:24:15,720
因为有问题的时间，
--which is the minimum number of clock cycles 00:24:15,720 --> 00:24:18,720
这是最小时钟周期数
--between times we can issue an instruction. 00:24:18,720 --> 00:24:21,720
在两次之间我们可以发出指令。
--Remember here our model is a pipeline. 00:24:21,720 --> 00:24:23,720
请记住，我们的模型是一个管道。
--In an ideal world, even if it takes four clock cycles, 00:24:23,720 --> 00:24:27,720
在理想世界中，即使需要四个时钟周期，
--four stations in this pipeline to do something, 00:24:27,720 --> 00:24:30,720
这条管道中的四个站做某事，
--we can start a new instruction every clock cycle 00:24:30,720 --> 00:24:33,720
我们可以在每个时钟周期开始一条新指令
--because one moves down, one moves in. 00:24:33,720 --> 00:24:35,720
因为一个向下移动，一个向内移动。
--One moves down, one moves in. 00:24:35,720 --> 00:24:38,720
一个向下移动，一个向内移动。
--That's the ideal assembly line. 00:24:38,720 --> 00:24:40,720
那是理想的装配线。
--In reality, because of the way these things work, 00:24:40,720 --> 00:24:42,720
事实上，由于这些事情的运作方式，
--we may have to wait. 00:24:42,720 --> 00:24:44,720
我们可能需要等待。
--We may have to put one in, let it move a couple of stations, 00:24:44,720 --> 00:24:47,720
我们可能得放一个进去，让它移动几个站，
--and then put another one in. 00:24:47,720 --> 00:24:50,720
然后再放一个进去。
--That's our issue time. 00:24:50,720 --> 00:24:57,720
那是我们的问题时间。
--Those two parameters are really important. 00:24:57,720 --> 00:25:00,720
这两个参数真的很重要。
--How long it actually takes for a single instruction 00:25:00,720 --> 00:25:02,720
一条指令实际需要多长时间
--and how rapidly we can feed them into the processor. 00:25:02,720 --> 00:25:05,720
以及我们将它们送入处理器的速度有多快。
--How well that pipelining is supporting that particular instruction. 00:25:05,720 --> 00:25:10,720
流水线对特定指令的支持程度。
--The capacity is what we talked about earlier. 00:25:10,720 --> 00:25:12,720
容量就是我们之前谈到的。
--How many functional units support this? 00:25:12,720 --> 00:25:16,720
有多少功能单元支持这个？
--Back in the day, a simple capacity number was good enough. 00:25:16,720 --> 00:25:19,720
在过去，一个简单的容量数字就足够了。
--If you said you could do four adds, 00:25:19,720 --> 00:25:21,720
如果你说你可以做四次加法，
--that four adds was really descriptive. 00:25:21,720 --> 00:25:23,720
这四个添加确实是描述性的。
--If you said you could do four adds and three subtracts 00:25:23,720 --> 00:25:25,720
如果你说你可以做四次加法和三次减法
--and two whatever, that was really descriptive. 00:25:25,720 --> 00:25:28,720
还有两个，这真的是描述性的。
--When you look at the modern processors, 00:25:28,720 --> 00:25:29,720
当您查看现代处理器时，
--they get a little nuanced. 00:25:29,720 --> 00:25:31,720
他们变得有点微妙。
--As you see here, some functional units 00:25:31,720 --> 00:25:34,720
正如你在这里看到的，一些功能单元
--do sort of a basket of things. 00:25:34,720 --> 00:25:37,720
做各种各样的事情。
--One or the other or the other. 00:25:37,720 --> 00:25:42,720
一个或另一个或另一个。
--You may not be able to do all the things at the same time. 00:25:42,720 --> 00:25:48,720
您可能无法同时完成所有事情。
--Here's a chunk of code. 00:25:48,720 --> 00:25:52,720
这是一段代码。
--Looking through what Randy did with this 00:25:52,720 --> 00:25:54,720
看看兰迪用这个做了什么
--is sort of amazing actually. 00:25:54,720 --> 00:25:56,720
实际上有点惊人。
--I took this example and I optimized it as best as I could. 00:25:56,720 --> 00:26:01,720
我以这个例子为例，并尽我所能对其进行了优化。
--As I couldn't hand wave, I thought I had a pretty good answer. 00:26:01,720 --> 00:26:04,720
由于我无法挥手，我认为我有一个很好的答案。
--I had like a 25 times speedup. 00:26:04,720 --> 00:26:06,720
我有 25 倍的加速。
--Then I went and looked at the bottom of Randy's notes 00:26:06,720 --> 00:26:09,720
然后我去看看兰迪笔记的底部
--from this recitation last year. 00:26:09,720 --> 00:26:11,720
从去年的这段朗诵中。
--He had an 80 times speedup. 00:26:11,720 --> 00:26:14,720
他有80倍的加速。
--Then I went back and I really worked as hard as I could. 00:26:14,720 --> 00:26:18,720
然后我回去了，我真的尽了最大的努力。
--I had like a 40 times speedup. 00:26:18,720 --> 00:26:21,720
我有 40 倍的加速。
--Then I cheated and looked at his notes. 00:26:21,720 --> 00:26:27,720
然后我作弊并查看了他的笔记。
--Look at this code. 00:26:27,720 --> 00:26:29,720
看看这段代码。
--If you look at this code, 00:26:29,720 --> 00:26:30,720
如果你看这段代码，
--the first thing you want to draw your eye to 00:26:30,720 --> 00:26:32,720
您想吸引眼球的第一件事
--when you're optimizing is the inner work loop. 00:26:32,720 --> 00:26:35,720
当您优化时是内部工作循环。
--You guys remember Amdahl's Law? 00:26:35,720 --> 00:26:38,720
大家还记得阿姆达尔定律吗？
--Anybody? 00:26:38,720 --> 00:26:41,720
有人吗？
--Anybody at all? 00:26:41,720 --> 00:26:42,720
有人吗？
--Fill me in. 00:26:42,720 --> 00:26:44,720
填写我。
--If there's a part of a program that's sequential, 00:26:44,720 --> 00:26:46,720
如果程序的一部分是顺序的，
--then there's a limit to how fast you can speed it up. 00:26:46,720 --> 00:26:49,720
那么你可以加速的速度是有限的。
--Okay. 00:26:49,720 --> 00:26:50,720
好的。
--That's a specific instance of Amdahl's Law 00:26:50,720 --> 00:26:52,720
这是阿姆达尔定律的一个具体例子
--that if there's a parallel part of the program 00:26:52,720 --> 00:26:56,720
如果程序有并行部分
--and a sequential part of the program, 00:26:56,720 --> 00:26:57,720
和程序的顺序部分，
--it's never going to run faster than the sequential part of the program. 00:26:57,720 --> 00:27:00,720
它永远不会比程序的顺序部分运行得更快。
--If there's a part of a program that's not optimized, 00:27:00,720 --> 00:27:02,720
如果程序有一部分没有优化，
--then there's a limit to how fast you can get the program optimized. 00:27:02,720 --> 00:27:05,720
那么您优化程序的速度就会受到限制。
--Okay. 00:27:05,720 --> 00:27:06,720
好的。
--More generally, 00:27:06,720 --> 00:27:07,720
更普遍，
--what's the most general form of Amdahl's Law? 00:27:07,720 --> 00:27:11,720
阿姆达尔定律最一般的形式是什么？
--If you think about your program's activity as a pie chart, okay, 00:27:11,720 --> 00:27:17,720
如果您将程序的活动视为饼图，好吧，
--and you think about optimizing each of the activities 00:27:17,720 --> 00:27:20,720
你考虑优化每项活动
--as some pie slice there, 00:27:20,720 --> 00:27:22,720
作为一些馅饼切片，
--at the end of the day, 00:27:22,720 --> 00:27:24,720
在一天结束时，
--if you pick a small slice, 00:27:24,720 --> 00:27:26,720
如果你挑一小片，
--you can only make a small improvement. 00:27:26,720 --> 00:27:30,720
你只能做一个小的改进。
--Right? 00:27:30,720 --> 00:27:31,720
正确的？
--If your slice represents only 10% of the pie, 00:27:31,720 --> 00:27:33,720
如果你的切片只占馅饼的 10%，
--you can't make more than a 10% improvement in that program. 00:27:33,720 --> 00:27:37,720
你不能在那个程序中取得超过 10% 的改进。
--Right? 00:27:37,720 --> 00:27:38,720
正确的？
--Because if you take that from 10% of the time to zero time, 00:27:38,720 --> 00:27:43,720
因为如果你把它从 10% 的时间变成零时间，
--you've eliminated 10% of the time. 00:27:43,720 --> 00:27:46,720
你已经淘汰了 10% 的时间。
--As a result of this, 00:27:46,720 --> 00:27:47,720
结果，
--small optimizations in more common activities 00:27:47,720 --> 00:27:52,720
更常见活动中的小优化
--tend to make a much bigger difference 00:27:52,720 --> 00:27:54,720
往往会产生更大的不同
--than big optimizations in activities that are really short. 00:27:54,720 --> 00:27:57,720
而不是在非常短的活动中进行大的优化。
--Right? 00:27:57,720 --> 00:27:58,720
正确的？
--So when we're trying to optimize a program, 00:27:58,720 --> 00:28:00,720
所以当我们试图优化一个程序时，
--we usually focus in initially at the inner work loop. 00:28:00,720 --> 00:28:04,720
我们通常首先关注内部工作循环。
--The parts of that program we spin, 00:28:04,720 --> 00:28:06,720
我们旋转的那个程序的部分，
--and spin, and spin, and spin, and spin, 00:28:06,720 --> 00:28:07,720
旋转，旋转，旋转，旋转，
--and spin, and spin, and spin, and spin, 00:28:07,720 --> 00:28:09,720
旋转，旋转，旋转，旋转，
--and spend all of our time. 00:28:09,720 --> 00:28:10,720
并花费我们所有的时间。
--Right? 00:28:10,720 --> 00:28:11,720
正确的？
--Because if I can make even a small improvement in an inner work loop, 00:28:11,720 --> 00:28:15,720
因为如果我能在内部工作循环中做出哪怕一点点改进，
--I've probably made, right, 00:28:15,720 --> 00:28:17,720
我可能做过，对吧，
--that small improvement on the whole program. 00:28:17,720 --> 00:28:19,720
整个程序的小改进。
--But if I make the first three instructions go away, 00:28:19,720 --> 00:28:22,720
但如果我让前三个指令消失，
--right, 00:28:22,720 --> 00:28:23,720
正确的，
--I've made my whole program like 0.5% faster. 00:28:23,720 --> 00:28:26,720
我让我的整个程序快了 0.5%。
--I've eliminated three instructions. 00:28:26,720 --> 00:28:28,720
我已经删除了三个指令。
--Right? 00:28:28,720 --> 00:28:29,720
正确的？
--So when you're looking at something like this, 00:28:29,720 --> 00:28:30,720
所以当你看到这样的东西时，
--you want to dive right into the inner work loop. 00:28:30,720 --> 00:28:33,720
你想直接进入内部工作循环。
--The parts of that program that are the ones that get spun over, 00:28:33,720 --> 00:28:36,720
该程序的部分是被旋转的部分，
--and over, and over again. 00:28:36,720 --> 00:28:38,720
一遍又一遍。
--So in this case, 00:28:38,720 --> 00:28:39,720
所以在这种情况下，
--it's pretty easy to see that we've got a nested for loop. 00:28:39,720 --> 00:28:43,720
很容易看出我们有一个嵌套的 for 循环。
--So we're going to dive in and focus on the inner for loop. 00:28:43,720 --> 00:28:48,720
因此，我们将深入研究并专注于内部 for 循环。
--Because that's the inner work loop. 00:28:48,720 --> 00:28:49,720
因为那是内部工作循环。
--That's where we're spending most of our time. 00:28:49,720 --> 00:28:52,720
那是我们花费大部分时间的地方。
--So that's where we can make the biggest difference in performance. 00:28:52,720 --> 00:28:56,720
所以这就是我们可以在性能上产生最大差异的地方。
--Okay? 00:28:56,720 --> 00:28:57,720
好的？
--That bright red part. 00:28:57,720 --> 00:29:01,720
那鲜红色的部分。
--So now my question is, 00:29:01,720 --> 00:29:02,720
所以现在我的问题是，
--how many times is this being executed? 00:29:02,720 --> 00:29:06,720
这被执行了多少次？
--And if we look at our for loop, 00:29:06,720 --> 00:29:08,720
如果我们看一下我们的 for 循环，
--it's for j equals 1, 00:29:08,720 --> 00:29:10,720
这是因为 j 等于 1，
--j is less than or equal to terms. 00:29:10,720 --> 00:29:12,720
 j 小于或等于项。
--Right? 00:29:12,720 --> 00:29:13,720
正确的？
--And then we look at the outer loop, 00:29:13,720 --> 00:29:14,720
然后我们看看外层循环，
--and we see the outer loop is running, right, n times. 00:29:14,720 --> 00:29:20,720
我们看到外循环正在运行，对，n 次。
--So n times term times. 00:29:20,720 --> 00:29:22,720
所以 n 次学期。
--Right? 00:29:22,720 --> 00:29:23,720
正确的？
--Because the number of times the inner loop runs, 00:29:23,720 --> 00:29:26,720
因为内循环运行的次数，
--times the number of times the outer loop runs. 00:29:26,720 --> 00:29:29,720
外循环运行次数的倍数。
--Because the inner loop runs terms times for each run of the outer loop. 00:29:29,720 --> 00:29:33,720
因为内循环为外循环的每次运行运行术语时间。
--So this thing is really busy. 00:29:33,720 --> 00:29:34,720
所以这件事真的很忙。
--Right? 00:29:34,720 --> 00:29:35,720
正确的？
--So we look at this inner work loop, 00:29:35,720 --> 00:29:37,720
所以我们看看这个内部工作循环，
--and we wonder, like, what's painful here? 00:29:37,720 --> 00:29:40,720
我们想知道，这里有什么痛苦的？
--What could be costing us performance? 00:29:40,720 --> 00:29:42,720
什么可能会影响我们的表现？
--Like, where are we spending our time? 00:29:42,720 --> 00:29:44,720
比如，我们把时间花在哪里了？
--Because optimizing someplace we're not spending our time is not going to be helpful. 00:29:44,720 --> 00:29:49,720
因为优化我们不花时间的地方不会有帮助。
--Well, multiplications are really slow operations. 00:29:49,720 --> 00:29:52,720
好吧，乘法是非常慢的操作。
--Right? 00:29:52,720 --> 00:29:53,720
正确的？
--If I look at this, 00:29:53,720 --> 00:29:54,720
如果我看这个，
--the most expensive operations I see are multiplications and divisions. 00:29:54,720 --> 00:29:59,720
我看到的最昂贵的操作是乘法和除法。
--Divisions are even more painful than multiplication. 00:29:59,720 --> 00:30:02,720
除法比乘法更痛苦。
--So the focus here, at least initially, 00:30:02,720 --> 00:30:05,720
所以这里的重点，至少在最初，
--is going to be on reducing the number of multiplications and divisions. 00:30:05,720 --> 00:30:08,720
将减少乘法和除法的次数。
--Does that make sense? 00:30:08,720 --> 00:30:10,720
那有意义吗？
--Because if we can reduce the number of multiplications and divisions in this inner work loop, 00:30:10,720 --> 00:30:14,720
因为如果我们可以减少这个内部工作循环中的乘法和除法的次数，
--life is going to get better at this. 00:30:14,720 --> 00:30:16,720
生活会因此变得更好。
--We initially benchmark this 00:30:20,720 --> 00:30:23,720
我们最初对此进行基准测试
--and see we're at 7 nanoseconds per element. 00:30:23,720 --> 00:30:27,720
并且看到我们在每个元素 7 纳秒。
--Okay. 00:30:27,720 --> 00:30:28,720
好的。
--That's where we're starting. 00:30:28,720 --> 00:30:29,720
这就是我们的起点。
--And like Todd said last class, 00:30:29,720 --> 00:30:30,720
就像托德上节课说的，
--it's really important to get your initial measure. 00:30:30,720 --> 00:30:33,720
获得初始测量非常重要。
--A lot of people will start out, 00:30:33,720 --> 00:30:35,720
很多人会开始，
--and they'll think about this in their head. 00:30:35,720 --> 00:30:38,720
他们会在脑海中思考这个问题。
--And they'll think, okay, 00:30:38,720 --> 00:30:39,720
他们会想，好吧，
--this is going to be expensive, 00:30:39,720 --> 00:30:40,720
这会很贵，
--and this is going to be expensive, 00:30:40,720 --> 00:30:41,720
这将是昂贵的，
--and this is going to be expensive, 00:30:41,720 --> 00:30:42,720
这将是昂贵的，
--and they'll start optimizing before they've even written it down. 00:30:42,720 --> 00:30:45,720
他们甚至在写下来之前就会开始优化。
--Don't do that. 00:30:45,720 --> 00:30:47,720
不要那样做。
--Okay? 00:30:47,720 --> 00:30:49,720
好的？
--Successful software is grown. 00:30:49,720 --> 00:30:51,720
成功的软件是成长起来的。
--It's not sort of born. 00:30:51,720 --> 00:30:55,720
这不是天生的。
--Your first goal is correctness. 00:30:55,720 --> 00:30:57,720
你的首要目标是正确性。
--Get it right. 00:30:57,720 --> 00:30:59,720
修正它。
--Express the idea as simply as you can, 00:30:59,720 --> 00:31:01,720
尽可能简单地表达想法，
--as correctly as you can, 00:31:01,720 --> 00:31:02,720
尽可能正确，
--and prove that it's correct. 00:31:02,720 --> 00:31:05,720
并证明它是正确的。
--The last thing you want to do is go down the path to optimization 00:31:05,720 --> 00:31:08,720
您最不想做的就是沿着优化之路前进
--and then find out that you actually had a problem 00:31:08,720 --> 00:31:10,720
然后发现你确实有问题
--in one of these equations and have to change it. 00:31:10,720 --> 00:31:12,720
在这些方程式之一中，必须改变它。
--And now all of your optimization is wasted 00:31:12,720 --> 00:31:15,720
现在你所有的优化都白费了
--because the computation changed. 00:31:15,720 --> 00:31:18,720
因为计算改变了。
--Step, you know, zero is get it correct. 00:31:18,720 --> 00:31:23,720
步骤，你知道，零是正确的。
--Then go down the path of optimization. 00:31:23,720 --> 00:31:25,720
然后走优化之路。
--Now that you have it correct, right, 00:31:25,720 --> 00:31:27,720
现在你已经正确了，对吧，
--find out what you have. 00:31:27,720 --> 00:31:32,720
找出你有什么。
--Get a good measurement. 00:31:32,720 --> 00:31:34,720
获得良好的测量。
--Get that measurement with as much precision as you easily can. 00:31:34,720 --> 00:31:38,720
尽可能精确地进行测量。
--Okay? 00:31:38,720 --> 00:31:39,720
好的？
--If the innermost work loop happened to be in a function 00:31:39,720 --> 00:31:41,720
如果最内层的工作循环碰巧在一个函数中
--and you could measure the time in that function, 00:31:41,720 --> 00:31:43,720
你可以测量那个函数的时间，
--prove that that's where you're spending your time. 00:31:43,720 --> 00:31:46,720
证明那是你花时间的地方。
--Right? 00:31:46,720 --> 00:31:47,720
正确的？
--Get as much of a picture as you can 00:31:47,720 --> 00:31:48,720
尽可能多地拍一张照片
--to prove to yourself that you're going after the biggest slice of that pie 00:31:48,720 --> 00:31:52,720
向自己证明你正在追求最大的一块馅饼
--because you can make no bigger a difference than the size of the slice. 00:31:52,720 --> 00:31:56,720
因为你不能做出比切片大小更大的差异。
--That's Amdahl's Law. 00:31:56,720 --> 00:31:59,720
这就是阿姆达尔定律。
--And it's foolish to waste time optimizing something that doesn't matter 00:31:59,720 --> 00:32:02,720
浪费时间优化无关紧要的事情是愚蠢的
--because you didn't take a little bit of time to figure it out. 00:32:02,720 --> 00:32:06,720
因为你没有花一点时间去弄明白。
--It's foolish to spend more and more and more and more and more and more time, 00:32:06,720 --> 00:32:09,720
花费越来越多越来越多的时间是愚蠢的，
--okay, on things, 00:32:09,720 --> 00:32:11,720
好的，关于事情，
--making smaller and smaller and smaller difference 00:32:11,720 --> 00:32:13,720
差异越来越小
--if there's a bigger slice that you can go after. 00:32:13,720 --> 00:32:15,720
如果有更大的切片你可以去。
--And you get that by instrumentation. 00:32:15,720 --> 00:32:19,720
你通过仪器得到它。
--Okay? 00:32:19,720 --> 00:32:21,720
好的？
--Back when I was a grad student, 00:32:21,720 --> 00:32:23,720
回到我读研究生的时候，
--I wrote this proxy for the Department of Defense. 00:32:23,720 --> 00:32:27,720
我为国防部写了这份委托书。
--It was a secure proxy. 00:32:27,720 --> 00:32:29,720
这是一个安全的代理。
--It enabled certain Department of Defense systems to connect to the Internet. 00:32:29,720 --> 00:32:32,720
它使某些国防部系统能够连接到 Internet。
--And it parsed all the traffic going up and back. 00:32:32,720 --> 00:32:35,720
它解析了所有往返的流量。
--And when this thing was first deployed, they loved it. 00:32:35,720 --> 00:32:42,720
当这个东西首次部署时，他们很喜欢它。
--Solved a billion problems for them. 00:32:42,720 --> 00:32:44,720
为他们解决了十亿个问题。
--And then about three weeks later, 00:32:44,720 --> 00:32:46,720
然后大约三周后，
--we started getting calls that the whole thing was too slow. 00:32:46,720 --> 00:32:53,720
我们开始接到电话说整个过程太慢了。
--Well, what happened? 00:32:53,720 --> 00:32:56,720
那么，发生了什么事？
--Well, I took a look at what they were doing. 00:32:57,720 --> 00:32:59,720
好吧，我看看他们在做什么。
--They were no longer using it for simple web pages. 00:32:59,720 --> 00:33:01,720
他们不再将它用于简单的网页。
--They were using it for these huge monsters. 00:33:01,720 --> 00:33:04,720
他们用它来对付这些巨大的怪物。
--And I'm like, okay, 00:33:04,720 --> 00:33:06,720
我想，好吧，
--these pages have 10,000 times as much data as what we planned on. 00:33:06,720 --> 00:33:11,720
这些页面的数据量是我们计划的 10,000 倍。
--No wonder it's slow. 00:33:11,720 --> 00:33:13,720
难怪它很慢。
--And I went about the process of optimizing this code. 00:33:13,720 --> 00:33:16,720
我着手优化这段代码的过程。
--I spent months optimizing this code. 00:33:16,720 --> 00:33:20,720
我花了几个月的时间优化这段代码。
--I went and I dove into the inner work loops 00:33:20,720 --> 00:33:22,720
我去了，我潜入了内部工作循环
--and I changed the representations of data structures. 00:33:22,720 --> 00:33:25,720
我改变了数据结构的表示。
--I used compression in various places. 00:33:25,720 --> 00:33:27,720
我在不同的地方使用了压缩。
--I optimized which order things were evaluated in loops. 00:33:27,720 --> 00:33:30,720
我优化了在循环中评估事物的顺序。
--They were short circuit faster. 00:33:30,720 --> 00:33:32,720
它们短路得更快。
--Blah, blah, blah, blah, blah. 00:33:32,720 --> 00:33:34,720
哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇
--I got something like a 2% performance improvement. 00:33:34,720 --> 00:33:39,720
我得到了大约 2% 的性能提升。
--I was getting ready to go on these strategies for even more performance. 00:33:39,720 --> 00:33:43,720
我正准备继续这些策略以获得更高的性能。
--But all these things were good. 00:33:43,720 --> 00:33:44,720
但所有这些都很好。
--I mean, if you looked at the part of the code I was working on, 00:33:44,720 --> 00:33:46,720
我的意思是，如果你看过我正在处理的那部分代码，
--I had like 180% improvements. 00:33:46,720 --> 00:33:50,720
我有 180% 的改进。
--But they were all these small little things, right? 00:33:50,720 --> 00:33:55,720
但它们都是这些小东西，对吧？
--And then I graduated. 00:33:55,720 --> 00:34:01,720
然后我毕业了。
--And then I was in the faculty. 00:34:01,720 --> 00:34:03,720
然后我在学院。
--And so my old advisor had the office across the hall from me. 00:34:03,720 --> 00:34:06,720
因此，我的老顾问办公室就在我对面。
--And one day I'm sitting there in my office and he just walks in and does this. 00:34:06,720 --> 00:34:11,720
有一天，我坐在办公室里，他走进来就做了这件事。
--And I follow him over to his office 00:34:11,720 --> 00:34:13,720
我跟着他到他的办公室
--and I see on his screen my proxy code. 00:34:13,720 --> 00:34:18,720
我在他的屏幕上看到了我的代理代码。
--More precisely, I see the proxy code in one window and strace in another window. 00:34:18,720 --> 00:34:23,720
更准确地说，我在一个窗口中看到了代理代码，在另一个窗口中看到了 strace。
--How many of you guys are familiar with strace? 00:34:23,720 --> 00:34:26,720
你们中有多少人熟悉 strace？
--Strace traces system calls. 00:34:26,720 --> 00:34:29,720
 Strace 跟踪系统调用。
--And in particular, the entire screen was filled with calls to break. 00:34:29,720 --> 00:34:34,720
尤其是，满屏都是break的呼声。
--Something like 14,000 of them. 00:34:34,720 --> 00:34:38,720
大约有 14,000 个。
--And then I immediately knew what the problem was. 00:34:38,720 --> 00:34:42,720
然后我立即知道问题出在哪里。
--You see, break is the system call that Malik uses to ask for more memory. 00:34:42,720 --> 00:34:49,720
你看，break 是 Malik 用来请求更多内存的系统调用。
--Can you think of any reason why Malik should need to ask for many, many, many pages more memory, 00:34:49,720 --> 00:34:54,720
你能想到 Malik 需要请求很多很多页面更多内存的任何原因吗？
--14,000 times, moving a webpage from here to here? 00:34:54,720 --> 00:35:00,720
 14,000 次，将一个网页从这里移动到这里？
--No. 00:35:00,720 --> 00:35:02,720
不。
--You see, I knew immediately then what was wrong because I remember doing it. 00:35:02,720 --> 00:35:07,720
你看，我马上就知道出了什么问题，因为我记得我做过这件事。
--At about 3 a.m. one night, when I had a deadline to be at a team project meeting the next morning, 00:35:07,720 --> 00:35:13,720
一天晚上凌晨 3 点左右，当我有一个截止日期要参加第二天早上的团队项目会议时，
--I was too tired to figure out exactly how big a buffer needed to be. 00:35:13,720 --> 00:35:17,720
我太累了，无法弄清楚究竟需要多大的缓冲区。
--I mean, there was a static limit and I knew how to figure it out. 00:35:17,720 --> 00:35:20,720
我的意思是，有一个静态限制，我知道如何解决。
--And if I worked my way through the state machine, it would be I could figure it out. 00:35:20,720 --> 00:35:23,720
如果我通过状态机工作，我就能弄清楚。
--But I didn't want to get it wrong in the middle of the night. 00:35:23,720 --> 00:35:25,720
却不想半夜弄错了。
--All I needed to have was a demo the next day. 00:35:25,720 --> 00:35:29,720
我所需要的只是第二天的演示。
--And so I wrote myself really quickly a growable buffer with Malik and dropped that in. 00:35:29,720 --> 00:35:36,720
所以我很快就和 Malik 一起给自己写了一个可增长的缓冲区，然后把它放进去了。
--And since I didn't intend for this growable buffer to be part of the final solution, 00:35:36,720 --> 00:35:41,720
因为我不打算让这个可增长的缓冲区成为最终解决方案的一部分，
--I didn't bother putting a free. 00:35:41,720 --> 00:35:48,720
我没有打扰免费。
--That sounds painful. 00:35:48,720 --> 00:35:50,720
听起来很痛苦。
--What's that? 00:35:50,720 --> 00:35:51,720
那是什么？
--That sounds painful. 00:35:51,720 --> 00:35:52,720
听起来很痛苦。
--Yes, that sounds painful. 00:35:52,720 --> 00:35:53,720
是的，这听起来很痛苦。
--By 14,000 times or so. 00:35:53,720 --> 00:35:59,720
大约 14,000 次。
--And then I offered to fix my bug because I knew what it was. 00:35:59,720 --> 00:36:02,720
然后我提出修复我的错误，因为我知道它是什么。
--Because it was like three minutes to figure out what this was. 00:36:03,720 --> 00:36:05,720
因为花了三分钟时间才弄明白这是什么。
--I just didn't have it in me that particular night. 00:36:05,720 --> 00:36:07,720
那个特定的晚上我只是没有它。
--And I went slithering back to my office. 00:36:07,720 --> 00:36:11,720
然后我溜回了我的办公室。
--Because the last three months of my graduate program, I spent optimizing things that didn't matter. 00:36:11,720 --> 00:36:16,720
因为我研究生课程的最后三个月，我花了很多时间来优化无关紧要的事情。
--Because I didn't bother to look to see what the bottleneck was in my code. 00:36:16,720 --> 00:36:23,720
因为我懒得去看代码中的瓶颈是什么。
--If I had taken ten seconds to profile that, I would have seen that it was in system calls, not in computation. 00:36:23,720 --> 00:36:32,720
如果我花十秒钟来分析它，我会发现它是在系统调用中，而不是在计算中。
--And then I would have remembered that night and fixed it. 00:36:32,720 --> 00:36:35,720
然后我会记得那天晚上并修复它。
--And this problem would have been fixed in legitimately less than five minutes. 00:36:35,720 --> 00:36:39,720
而且这个问题本来可以在不到五分钟的时间内得到解决。
--But instead, I spent three months optimizing. 00:36:39,720 --> 00:36:43,720
但是相反，我花了三个月的时间进行优化。
--And then our client spent three months suffering. 00:36:43,720 --> 00:36:47,720
然后我们的客户度过了三个月的痛苦。
--And then my advisor had to fix it. 00:36:47,720 --> 00:36:50,720
然后我的顾问不得不修复它。
--And the only thing I could remember as I slithered my way back to my office was what he had told me probably the first time I had met him. 00:36:50,720 --> 00:36:58,720
在我溜回办公室的路上，我唯一记得的就是他可能在我第一次见到他时告诉我的话。
--A conversation about entirely different things. 00:36:58,720 --> 00:37:03,720
关于完全不同事物的对话。
--Which is that human intuition is a poor indicator of system performance. 00:37:03,720 --> 00:37:07,720
也就是说，人类的直觉是系统性能的不良指标。
--Measure it. 00:37:07,720 --> 00:37:09,720
测量它。
--Because I think we were having a conversation about something else and I said, I think blah, blah, blah. 00:37:09,720 --> 00:37:12,720
因为我认为我们正在谈论其他事情，我说，我觉得废话，废话，废话。
--And he said, no, no, no. 00:37:12,720 --> 00:37:13,720
他说，不，不，不。
--Human intuition is a poor indicator of system performance. 00:37:13,720 --> 00:37:16,720
人的直觉是系统性能的不良指标。
--Measure it. 00:37:16,720 --> 00:37:17,720
测量它。
--In other words, I don't believe a word you say. 00:37:17,720 --> 00:37:19,720
换句话说，我不相信你说的话。
--Show me. 00:37:19,720 --> 00:37:20,720
给我看看。
--He was right then. 00:37:20,720 --> 00:37:22,720
他当时是对的。
--He was right when I graduated. 00:37:22,720 --> 00:37:23,720
我毕业时他是对的。
--He's still right today. 00:37:23,720 --> 00:37:24,720
他今天还是对的。
--Although now he's retired living in a lake house. 00:37:24,720 --> 00:37:26,720
虽然现在他退休了，住在湖边的房子里。
--So you need to benchmark. 00:37:26,720 --> 00:37:31,720
所以你需要进行基准测试。
--I can't emphasize that enough. 00:37:31,720 --> 00:37:33,720
我怎么强调都不为过。
--Whatever you think you know, it'll feel good to know that you know it. 00:37:33,720 --> 00:37:36,720
无论你认为你知道什么，知道你知道它会感觉很好。
--All right? 00:37:36,720 --> 00:37:38,720
好的？
--Simple improvements. 00:37:38,720 --> 00:37:43,720
简单的改进。
--Okay. 00:37:43,720 --> 00:37:44,720
好的。
--What am I doing here? 00:37:44,720 --> 00:37:46,720
我在这是要干嘛？
--You can see the boldface, right? 00:37:46,720 --> 00:37:48,720
你可以看到黑体字，对吧？
--Those three lines on the left, computation is signed over on the right. 00:37:48,720 --> 00:37:54,720
左边那三行，计算在右边签名。
--It'll be easier if you can see the original code on your own system. 00:37:54,720 --> 00:38:00,720
如果你能在自己的系统上看到原始代码，那就更容易了。
--But for those of you who can't, you can look at it later. 00:38:00,720 --> 00:38:03,720
但是对于那些不能的人，您可以稍后再看。
--All we're doing is precomputing something. 00:38:03,720 --> 00:38:05,720
我们所做的只是预先计算一些东西。
--We're taking something out that was being computed as part of the loop that didn't need to be computed as part of the loop. 00:38:05,720 --> 00:38:12,720
我们正在取出一些作为循环的一部分计算的东西，这些东西不需要作为循环的一部分计算。
--We're just refactoring it to get it out of the innermost loop, putting it inside the other loop. 00:38:12,720 --> 00:38:16,720
我们只是重构它，让它脱离最内层的循环，将它放在另一个循环中。
--Because it wasn't actually changing. 00:38:16,720 --> 00:38:18,720
因为它实际上并没有改变。
--That term was not changing, so we can just move it out by a loop. 00:38:18,720 --> 00:38:22,720
该术语没有改变，因此我们可以通过循环将其移出。
--So now we're down to 6.16. 00:38:22,720 --> 00:38:25,720
所以现在我们降到了 6.16。
--Okay. 00:38:25,720 --> 00:38:26,720
好的。
--That's not a huge gain, but that was a gain that was cheap, right? 00:38:26,720 --> 00:38:29,720
这不是一个巨大的收益，但这是一个便宜的收益，对吧？
--That was almost free. 00:38:29,720 --> 00:38:35,720
那几乎是免费的。
--Okay. 00:38:35,720 --> 00:38:36,720
好的。
--So now let's focus on this. 00:38:36,720 --> 00:38:41,720
所以现在让我们专注于此。
--The division here is very, very, very costly. 00:38:41,720 --> 00:38:44,720
这里的分裂非常、非常、非常昂贵。
--Okay. 00:38:44,720 --> 00:38:45,720
好的。
--And it's also independent of the variable in the outermost loop. 00:38:45,720 --> 00:38:54,720
而且它也独立于最外层循环中的变量。
--Okay. 00:38:54,720 --> 00:38:57,720
好的。
--Nice. 00:38:57,720 --> 00:38:58,720
好的。
--We've refactored that division, gotten it out of the way, and now we're down to half of what we were before. 00:38:58,720 --> 00:39:07,720
我们重构了那个部门，把它移开了，现在我们只剩下以前的一半了。
--Cool. 00:39:07,720 --> 00:39:13,720
凉爽的。
--Now let's take a look at that inner work loop in assembly. 00:39:13,720 --> 00:39:15,720
现在让我们看一下汇编中的内部工作循环。
--Ah! 00:39:15,720 --> 00:39:17,720
啊!
--No, just kidding. 00:39:17,720 --> 00:39:18,720
不仅仅在开玩笑。
--I actually like assembly. 00:39:18,720 --> 00:39:21,720
我其实很喜欢组装。
--So assembly is bad initially when you first start reading assembly because you don't know what the instructions mean. 00:39:21,720 --> 00:39:25,720
因此，当您第一次开始阅读汇编时，汇编最初是不好的，因为您不知道说明的含义。
--And you look, blah, blah, blah. 00:39:25,720 --> 00:39:27,720
你看，等等，等等，等等。
--What is that? 00:39:27,720 --> 00:39:28,720
那是什么？
--You can't even pronounce it, right? 00:39:28,720 --> 00:39:30,720
你甚至不能发音，对吧？
--And then you realize that it's a fused multiply and add. 00:39:30,720 --> 00:39:33,720
然后你意识到它是一个融合的乘法和加法。
--And once you get to the point where you can look at the instructions and know what they are, 00:39:33,720 --> 00:39:36,720
一旦你到了可以查看说明并知道它们是什么的地步，
--it's actually much simpler to read in some sense than, like, other code. 00:39:36,720 --> 00:39:39,720
从某种意义上说，它实际上比其他代码更容易阅读。
--So as long as you focus on a few lines, right, it's simple and direct. 00:39:39,720 --> 00:39:43,720
所以只要把重点放在几行上，对吧，简单直接。
--But you have to get to the point where you actually can read it. 00:39:43,720 --> 00:39:46,720
但是你必须达到你真正可以阅读它的程度。
--And so over on the right, we see sort of, we see the assembly code that we're looking at, 00:39:46,720 --> 00:39:50,720
所以在右边，我们看到了一些，我们看到了我们正在查看的汇编代码，
--and then we see, you know, the reverse-engineered C code. 00:39:50,720 --> 00:39:54,720
然后我们看到，你知道的，逆向工程的 C 代码。
--So we started out with C. 00:39:54,720 --> 00:39:56,720
所以我们从 C 开始。
--We compiled it and got the assembly. 00:39:56,720 --> 00:39:58,720
我们编译了它并得到了程序集。
--And now for the benefit of everybody here, we've now translated this back to C. 00:39:58,720 --> 00:40:02,720
现在，为了这里的每个人的利益，我们现在将其翻译回 C。
--So we're seeing the C that represents the exact assembly. 00:40:02,720 --> 00:40:05,720
所以我们看到 C 代表确切的程序集。
--So you can read the code on the right, and that's going to mean to you the same thing as the code on the left. 00:40:05,720 --> 00:40:09,720
所以你可以阅读右边的代码，这对你来说与左边的代码意义相同。
--Otherwise, it might. 00:40:09,720 --> 00:40:12,720
否则，它可能。
--All right. 00:40:12,720 --> 00:40:13,720
好的。
--If we look at this, we see that this is all pretty simple stuff. 00:40:13,720 --> 00:40:16,720
如果我们看一下这个，我们就会发现这都是非常简单的事情。
--I mean, like an addition, right, a not equals, a test. 00:40:16,720 --> 00:40:22,720
我的意思是，就像一个加法，对，一个不等于，一个测试。
--That's really fast, right? 00:40:22,720 --> 00:40:25,720
这真的很快，对吧？
--And if we think about our capacity for multiply, right, we see that's the bottleneck. 00:40:25,720 --> 00:40:30,720
如果我们考虑一下我们的繁殖能力，对吧，我们就会发现这就是瓶颈。
--The problem with the multiply is when you insert a multiply, you have to wait three cycles before you can put the next one in. 00:40:30,720 --> 00:40:36,720
乘法的问题是当你插入一个乘法时，你必须等待三个周期才能放入下一个。
--So now we're going to use a technique called loop unrolling. 00:40:42,720 --> 00:40:45,720
所以现在我们要使用一种称为循环展开的技术。
--This is a 213 technique. 00:40:45,720 --> 00:40:48,720
这是一个 213 技术。
--You've heard it's very, very denier in your old 213 textbook. 00:40:48,720 --> 00:40:51,720
你在旧的 213 教科书中听说过它非常非常否认。
--I'm not sure if you remember it or not. 00:40:51,720 --> 00:40:53,720
我不确定你是否记得它。
--But loops are very painful. 00:40:53,720 --> 00:40:55,720
但是循环非常痛苦。
--They're good for humans, but they're very painful for actual code performance. 00:40:55,720 --> 00:40:59,720
它们对人类有益，但对实际代码性能来说却非常痛苦。
--And the reason is if you think about a loop, and you think about, you know, the nature of a loop, 00:40:59,720 --> 00:41:05,720
原因是如果你考虑一个循环，你知道，你知道，循环的本质，
--the idea for most loops is they repeat, and they repeat, and they repeat, and they repeat, and they repeat, and they repeat, and they repeat, and they repeat, and they repeat. 00:41:05,720 --> 00:41:11,720
大多数循环的想法是重复，重复，重复，重复，重复，重复，重复，重复，重复，重复。
--And the end of the loop is the exceptional case, right? 00:41:11,720 --> 00:41:14,720
循环结束是例外情况，对吧？
--A loop may run 1,000 times and only end once. 00:41:14,720 --> 00:41:18,720
一个循环可能运行 1,000 次并且只结束一次。
--The problem with the loops is you have to test that condition each one of those 1,000 times, right? 00:41:18,720 --> 00:41:25,720
循环的问题是您必须对这 1,000 次中的每一个条件进行测试，对吗？
--Even though it's only relevant once. 00:41:25,720 --> 00:41:28,720
即使它只相关一次。
--So one-tenth of 1% of the time, does that test do anything useful? 00:41:28,720 --> 00:41:32,720
那么 1% 的十分之一的时间，该测试有什么用吗？
--Yet you have to do that test every time. 00:41:32,720 --> 00:41:34,720
然而，您每次都必须进行该测试。
--So if you have a small loop, that test may be a substantial overhead on the amount of work you have to do. 00:41:34,720 --> 00:41:40,720
因此，如果您有一个小循环，那么该测试可能会大大增加您必须完成的工作量。
--To make it worse than that, they do bad things to processors. 00:41:40,720 --> 00:41:44,720
更糟糕的是，他们对处理器做了坏事。
--Because processors, right, are these deep pipelines these days, right? 00:41:44,720 --> 00:41:49,720
因为处理器，对吧，现在这些都是深度流水线，对吧？
--And they pack this pipeline full of work. 00:41:49,720 --> 00:41:52,720
他们把这条管道装满了工作。
--And they do this because they predict, right? 00:41:52,720 --> 00:41:55,720
他们这样做是因为他们预测，对吧？
--They take this whole instruction stream, and they start cramming it into the processor. 00:41:55,720 --> 00:41:59,720
他们获取整个指令流，然后开始将其塞入处理器。
--But when you get to a branch, there's a choice, right? 00:41:59,720 --> 00:42:03,720
但是，当您到达分支机构时，可以选择，对吗？
--Do we go back to the beginning of this loop or not? 00:42:03,720 --> 00:42:06,720
我们是否回到这个循环的开头？
--And if they guess wrong, that whole loop has to, all that work inside the pipeline has to get thrown away. 00:42:06,720 --> 00:42:13,720
如果他们猜错了，整个循环都必须被丢弃，管道内的所有工作都必须被丢弃。
--It's called flushing the pipe, okay? 00:42:13,720 --> 00:42:17,720
这叫做冲洗管道，好吗？
--So processors go from simple policies like predict the loop is taken, because most of them are, to having statistical predictors, okay? 00:42:17,720 --> 00:42:24,720
所以处理器从简单的策略开始，比如预测循环被采用，因为它们中的大多数是，到具有统计预测器，好吗？
--The bottom line is this, right? 00:42:25,720 --> 00:42:28,720
底线是这样，对吧？
--Loops are really painful, okay? 00:42:28,720 --> 00:42:31,720
循环真的很痛苦，好吗？
--The other thing about them, in terms of instruction level parallelism, I forgot this point, 00:42:31,720 --> 00:42:35,720
关于它们的另一件事，就指令级并行性而言，我忘记了这一点，
--is that if you think about the instruction flow, and all you have is your work, 00:42:35,720 --> 00:42:39,720
如果你考虑指令流程，你所拥有的就是你的工作，
--it's very easy to parallelize that work inside the pipeline, okay? 00:42:39,720 --> 00:42:43,720
在管道内并行化该工作非常容易，好吗？
--Unless there's a data dependency, your out-of-order execution can execute it out-of-order. 00:42:43,720 --> 00:42:48,720
除非存在数据依赖性，否则您的乱序执行可以乱序执行。
--But once you start to have conditionals in there, right, that forms dependencies that serializes the work, 00:42:48,720 --> 00:42:55,720
但是一旦你开始在那里有条件，就形成了序列化工作的依赖关系，
--even if the prediction isn't a problem. 00:42:55,720 --> 00:42:58,720
即使预测不是问题。
--So, loops, right, involve the overhead of the test, they have branch penalties, 00:42:58,720 --> 00:43:05,720
所以，循环，对，涉及测试的开销，它们有分支惩罚，
--they decrease the opportunity for parallelism, alright? 00:43:05,720 --> 00:43:10,720
它们减少了并行的机会，好吗？
--So we have this technique called loop unrolling, alright? 00:43:10,720 --> 00:43:13,720
所以我们有这种称为循环展开的技术，好吗？
--And so, maybe what we do is we unroll a loop, and we do 2 units of work every loop, 00:43:14,720 --> 00:43:21,720
所以，也许我们要做的是展开一个循环，每个循环我们做 2 个工作单元，
--or 4 units of work every loop, or 8 units of work every loop. 00:43:21,720 --> 00:43:25,720
或每个循环 4 个工作单位，或每个循环 8 个工作单位。
--And then we stop the loop early, like if we're trying to do 30 things, 00:43:25,720 --> 00:43:30,720
然后我们提前停止循环，就像我们尝试做 30 件事一样，
--and we have 8 times unrolling, we may only get to 24 with our loop. 00:43:30,720 --> 00:43:34,720
我们有 8 次展开，我们的循环可能只能达到 24 次。
--And then we have to special case the last 3 at the end. Does that make sense? 00:43:34,720 --> 00:43:40,720
然后我们必须在最后对最后 3 个进行特殊处理。那有意义吗？
--So what happens here is we've stretched out this loop, 00:43:40,720 --> 00:43:43,720
所以这里发生的是我们延长了这个循环，
--stretching out the length of code that's not interrupted by tests, right? 00:43:43,720 --> 00:43:48,720
延长未被测试中断的代码长度，对吗？
--Providing more opportunity for parallelism, not interfering with our pipeline as much. 00:43:48,720 --> 00:43:54,720
提供更多的并行机会，而不是过多地干扰我们的管道。
--Okay, so now we're in a much better position. 00:43:54,720 --> 00:43:57,720
好的，现在我们处于一个更好的位置。
--Of course, there's a trade-off here, and that's that our code is now much larger, 00:43:57,720 --> 00:44:01,720
当然，这里有一个权衡，那就是我们的代码现在更大了，
--because instead of our loop being 3 lines long, our loop is going to be many times longer, 00:44:01,720 --> 00:44:05,720
因为我们的循环不是 3 行长，而是要长很多倍，
--which means it's got to do each of those 3 things in sequence that perform 3 iterations of the loop, 00:44:05,720 --> 00:44:11,720
这意味着它必须按顺序执行这 3 件事中的每件事，以执行循环的 3 次迭代，
--because we're flattening out that loop to some extent. 00:44:11,720 --> 00:44:14,720
因为我们在某种程度上拉平了这个循环。
--And then at the end, it has to deal with whatever special case is left over. 00:44:14,720 --> 00:44:19,720
最后，它必须处理遗留的任何特殊情况。
--So this is a classic time-performance trade-off. 00:44:19,720 --> 00:44:22,720
所以这是一个经典的时间性能权衡。
--We're having a whole bunch more instructions in order to get them to execute faster. 00:44:22,720 --> 00:44:28,720
为了让它们执行得更快，我们有更多的指令。
--And in extremes, this is bad, okay? 00:44:28,720 --> 00:44:31,720
在极端情况下，这很糟糕，好吗？
--Because if I have a ton of instructions, 00:44:31,720 --> 00:44:33,720
因为如果我有大量的指示，
--now I'm not going to be able to take advantage of my instruction cache or my processor, right? 00:44:33,720 --> 00:44:38,720
现在我将无法利用我的指令缓存或处理器，对吗？
--Because if I have a small set of instructions I'm looping over a lot, I have great locality. 00:44:38,720 --> 00:44:44,720
因为如果我有一小部分指令，我会循环很多次，所以我有很大的局部性。
--If I unroll those very same instructions, they're in different places of memory. 00:44:44,720 --> 00:44:47,720
如果我展开那些完全相同的指令，它们位于不同的内存位置。
--They don't look alike. They have a much bigger footprint in my cache. 00:44:47,720 --> 00:44:51,720
他们看起来不一样。它们在我的缓存中占用的空间要大得多。
--And now it pushes other things out of my cache, or even itself out of the cache, okay? 00:44:51,720 --> 00:44:59,720
现在它将其他东西推出我的缓存，甚至将它自己推出缓存，好吗？
--In older processors, where general-purpose registers were scarce, right? 00:44:59,720 --> 00:45:04,720
在较旧的处理器中，通用寄存器很少，对吧？
--Once we start unrolling the loops, we may need more variables. 00:45:04,720 --> 00:45:07,720
一旦我们开始展开循环，我们可能需要更多变量。
--Because each instance of that loop that's sort of been unrolled may be separate. 00:45:07,720 --> 00:45:11,720
因为每个被展开的循环实例都可能是独立的。
--And now we may not have enough registers for our variables. 00:45:11,720 --> 00:45:14,720
现在我们的变量可能没有足够的寄存器。
--And so now the compiler may end up spilling variables onto the stack. 00:45:14,720 --> 00:45:19,720
所以现在编译器可能最终将变量溢出到堆栈上。
--Now, in older processors, the 32-bit processors that had very few general-purpose registers, 00:45:19,720 --> 00:45:24,720
现在，在旧的处理器中，32 位处理器只有很少的通用寄存器，
--this was a very big concern. 00:45:24,720 --> 00:45:26,720
这是一个非常大的问题。
--On the modern 64-bit processors that coincidentally also have way more general-purpose registers, 00:45:26,720 --> 00:45:31,720
在巧合的还有更多通用寄存器的现代 64 位处理器上，
--you have to work some to cause a spill. 00:45:31,720 --> 00:45:34,720
你必须做一些工作才能造成泄漏。
--But you still want to see that in the assembly, right? 00:45:34,720 --> 00:45:36,720
但是您仍然希望在程序集中看到它，对吗？
--You'll actually see that in the generated assembly. 00:45:36,720 --> 00:45:39,720
您实际上会在生成的程序集中看到它。
--If it takes the register and moves it to the stack and then moves it back from the stack to the register, 00:45:39,720 --> 00:45:42,720
如果它获取寄存器并将其移入堆栈，然后将其从堆栈移回寄存器，
--you know that you've caused that. 00:45:42,720 --> 00:45:45,720
你知道是你造成的。
--Right? 00:45:45,720 --> 00:45:47,720
正确的？
--So it's observable. 00:45:47,720 --> 00:45:49,720
所以它是可观察的。
--Also, in some types of embedded systems, 00:45:49,720 --> 00:45:52,720
此外，在某些类型的嵌入式系统中，
--there can be reasons not to do this for reasons of memory constraints or other things. 00:45:52,720 --> 00:45:57,720
由于内存限制或其他原因，可能有不这样做的原因。
--Okay. 00:45:57,720 --> 00:45:59,720
好的。
--So now, if you go through it, you can dive in. 00:45:59,720 --> 00:46:01,720
所以现在，如果你通过它，你可以潜入。
--You can actually see the code, you know, yourself. 00:46:01,720 --> 00:46:03,720
您实际上可以自己查看代码。
--It's in that directory. 00:46:03,720 --> 00:46:05,720
它在那个目录中。
--You see that this is our new inner work loop. 00:46:05,720 --> 00:46:08,720
你看这是我们新的内部工作循环。
--The code is down on the right. 00:46:08,720 --> 00:46:12,720
代码在右下方。
--So now we see we have six clock cycles for two elements. 00:46:12,720 --> 00:46:16,720
所以现在我们看到两个元素有六个时钟周期。
--We've decreased multiply by one. 00:46:16,720 --> 00:46:18,720
我们减少了乘以一。
--So maybe we made a small difference, 00:46:18,720 --> 00:46:20,720
所以也许我们做了一些小改变，
--but we're not going to see a big improvement coming yet. 00:46:20,720 --> 00:46:26,720
但我们还不会看到大的改进。
--Now we're going to make a little bit of an assumption, 00:46:26,720 --> 00:46:29,720
现在我们要做一个假设，
--which is that the floating point math is associative and distributive. 00:46:29,720 --> 00:46:34,720
这就是浮点数学是关联的和分配的。
--Okay? 00:46:34,720 --> 00:46:35,720
好的？
--Just like real numbers would be. 00:46:35,720 --> 00:46:37,720
就像实数一样。
--Technically speaking, floating point math is neither associative nor distributive 00:46:37,720 --> 00:46:41,720
从技术上讲，浮点数学既不是结合的也不是分配的
--because of the way floating points round. 00:46:41,720 --> 00:46:44,720
因为浮点圆的方式。
--You do the same computation in different ways, you may end up with slightly different values. 00:46:44,720 --> 00:46:48,720
您以不同的方式进行相同的计算，最终可能会得到略有不同的值。
--Right? 00:46:48,720 --> 00:46:50,720
正确的？
--The advice I give everyone with floating points 00:46:50,720 --> 00:46:52,720
我给大家的建议是浮点数
--is never use the equal equal sign with floating point numbers. 00:46:52,720 --> 00:46:55,720
永远不要将等号与浮点数一起使用。
--Okay? 00:46:57,720 --> 00:46:58,720
好的？
--Always subtract them, right? 00:46:58,720 --> 00:47:00,720
总是减去它们，对吧？
--And look for a difference less than a certain value. 00:47:00,720 --> 00:47:03,720
并寻找小于某个值的差异。
--Because if you do complex computation with floating point numbers 00:47:03,720 --> 00:47:06,720
因为如果你用浮点数做复杂的计算
--and you happen to compute them differently 00:47:06,720 --> 00:47:09,720
而你碰巧以不同的方式计算它们
--because you have a value coming from one system 00:47:09,720 --> 00:47:12,720
因为你有来自一个系统的价值
--and you're doing a computation on another system or whatever, 00:47:12,720 --> 00:47:14,720
你正在另一个系统或其他系统上进行计算，
--the rounding may work differently 00:47:14,720 --> 00:47:16,720
舍入可能会有所不同
--and you may have two values that for all intents and purposes are exactly the same, 00:47:16,720 --> 00:47:19,720
你可能有两个值，它们在所有意图和目的上都完全相同，
--but they're not because of floating point rounding. 00:47:19,720 --> 00:47:22,720
但它们不是因为浮点舍入。
--Right? 00:47:22,720 --> 00:47:23,720
正确的？
--Engineers always talk about things in terms of tolerance. 00:47:23,720 --> 00:47:25,720
工程师总是从容忍度的角度来谈论事情。
--Close enough. 00:47:25,720 --> 00:47:26,720
足够接近。
--And when you're doing floating point math, you have to assume the mindset of an engineer. 00:47:26,720 --> 00:47:29,720
当您进行浮点数学运算时，您必须具备工程师的思维方式。
--You have to ask the question, 00:47:29,720 --> 00:47:31,720
你必须问这个问题，
--are these two numbers within tolerance of each other? 00:47:31,720 --> 00:47:33,720
这两个数字是否在彼此的容差范围内？
--Where the tolerance is whatever it is for your application. 00:47:33,720 --> 00:47:36,720
公差与您的应用程序无关。
--But for this point, we're going to assume that 00:47:38,720 --> 00:47:40,720
但是对于这一点，我们假设
--for the purposes of this particular code, 00:47:40,720 --> 00:47:44,720
出于此特定代码的目的，
--the sine function, right, 00:47:44,720 --> 00:47:46,720
正弦函数，对，
--this math can be distributed and associated without changing values. 00:47:46,720 --> 00:47:49,720
该数学可以在不更改值的情况下进行分发和关联。
--In some sense, we're just assuming that 00:47:49,720 --> 00:47:51,720
在某种意义上，我们只是假设
--the way we chose to distribute things originally 00:47:51,720 --> 00:47:54,720
我们最初选择分配东西的方式
--and the association we chose to have 00:47:54,720 --> 00:47:56,720
以及我们选择的协会
--was just coincidental based upon how we wrote it down. 00:47:56,720 --> 00:47:58,720
根据我们写下来的方式，这只是巧合。
--We really didn't actually think about that. 00:47:58,720 --> 00:48:00,720
我们真的没有考虑过这一点。
--I mean, we just wrote it out, right? 00:48:00,720 --> 00:48:02,720
我的意思是，我们只是把它写出来，对吧？
--So we're actually not changing it. 00:48:02,720 --> 00:48:04,720
所以我们实际上并没有改变它。
--So now we've done that, 00:48:07,720 --> 00:48:09,720
所以现在我们已经做到了，
--and because of that, we've been able to refactor this code. 00:48:09,720 --> 00:48:12,720
因此，我们能够重构这段代码。
--So now we're reducing the delay of three cycles, 00:48:14,720 --> 00:48:17,720
所以现在我们正在减少三个周期的延迟，
--but we're computing two elements in that time, 00:48:17,720 --> 00:48:19,720
但我们当时正在计算两个元素，
--so our clocks per element is down to one and a half. 00:48:19,720 --> 00:48:21,720
所以我们每个元素的时钟下降到一个半。
--Okay. 00:48:22,720 --> 00:48:23,720
好的。
--We're battling this one, right? 00:48:23,720 --> 00:48:25,720
我们正在与这个战斗，对吧？
--We're doing all sorts of these micro-optimizations, 00:48:25,720 --> 00:48:27,720
我们正在进行各种微优化，
--fighting for it, but we're getting benefit here. 00:48:27,720 --> 00:48:30,720
为它而战，但我们在这里得到了好处。
--Now we start to think about this, 00:48:32,720 --> 00:48:34,720
现在我们开始考虑这个，
--and this is more properly where you can tell the difference 00:48:35,720 --> 00:48:37,720
这是更恰当的地方，你可以分辨出不同之处
--between Randy's skill and mine, 00:48:37,720 --> 00:48:39,720
在兰迪和我的技能之间，
--because this represents a scribbling note 00:48:39,720 --> 00:48:42,720
因为这代表了一个涂鸦笔记
--in the corner of Randy's notes here, 00:48:42,720 --> 00:48:44,720
在兰迪笔记的一角，
--because it took him like three seconds to figure this out. 00:48:44,720 --> 00:48:47,720
因为他花了大约三秒钟才弄明白。
--If we keep unrolling more, 00:48:49,720 --> 00:48:51,720
如果我们继续展开更多，
--we'll be limited by addition to the update now, okay? 00:48:51,720 --> 00:48:54,720
我们现在将受到更新的限制，好吗？
--So in other words, 00:48:55,720 --> 00:48:57,720
所以换句话说，
--the addition is now becoming the bottleneck. 00:48:57,720 --> 00:48:59,720
添加现在成为瓶颈。
--All right? 00:49:00,720 --> 00:49:01,720
好的？
--The fused multiply and add units 00:49:02,720 --> 00:49:04,720
融合的乘法和加法单位
--are what's becoming limited. 00:49:04,720 --> 00:49:06,720
是什么变得有限。
--All right? 00:49:07,720 --> 00:49:08,720
好的？
--And then we also start to become limited 00:49:09,720 --> 00:49:12,720
然后我们也开始变得有限
--by the overhead of setting up the loop, 00:49:12,720 --> 00:49:14,720
通过设置循环的开销，
--not dividing things evenly, 00:49:15,720 --> 00:49:16,720
没有平均分配东西，
--needing to clean up, 00:49:16,720 --> 00:49:17,720
需要清理，
--all the other things we talked about 00:49:17,720 --> 00:49:18,720
我们谈论的所有其他事情
--in terms of loop unrolling overhead. 00:49:18,720 --> 00:49:20,720
在循环展开开销方面。
--All right. 00:49:22,720 --> 00:49:23,720
好的。
--So if you look on the left, 00:49:23,720 --> 00:49:25,720
所以如果你看左边，
--you can see the number of times of unrolling. 00:49:25,720 --> 00:49:27,720
你可以看到展开的次数。
--Two times unrolling, three times unrolling, 00:49:27,720 --> 00:49:28,720
两次展开，三次展开，
--four times unrolling, five times unrolling. 00:49:28,720 --> 00:49:30,720
四次展开，五次展开。
--And you can see the performance improvement. 00:49:32,720 --> 00:49:35,720
你可以看到性能的提升。
--It's not uniform, 00:49:35,720 --> 00:49:37,720
不是统一的，
--because of all those artifacts we talked about. 00:49:37,720 --> 00:49:39,720
因为我们谈到了所有这些人工制品。
--But you can see there's generally a downward trend. 00:49:39,720 --> 00:49:41,720
但是你可以看到总体上有下降趋势。
--When we took the number of terms up to 16, 00:49:42,720 --> 00:49:44,720
当我们将项数增加到 16 时，
--we see that we actually have a nice relative low 00:49:45,720 --> 00:49:48,720
我们看到我们实际上有一个不错的相对低点
--at four times improvement. 00:49:48,720 --> 00:49:49,720
提高了四倍。
--Why? 00:49:49,720 --> 00:49:50,720
为什么？
--Four, eight, 12, 16. 00:49:50,720 --> 00:49:53,720
四、八、十二、十六。
--No cleanup at the end. 00:49:53,720 --> 00:49:54,720
最后没有清理。
--Okay? 00:49:56,720 --> 00:49:57,720
好的？
--So it divides evenly, 00:49:57,720 --> 00:49:58,720
所以平均分配，
--so we do much better there. 00:49:58,720 --> 00:50:00,720
所以我们在那里做得更好。
--All right? 00:50:05,720 --> 00:50:06,720
好的？
--Now, this 0.7 nanoseconds per element, 00:50:08,720 --> 00:50:14,720
现在，每个元素 0.7 纳秒，
--that's like 10 times better than what we started, right? 00:50:14,720 --> 00:50:17,720
这比我们开始的时候好 10 倍，对吧？
--I think we started at something like seven and a half. 00:50:17,720 --> 00:50:19,720
我想我们大约从七点半开始。
--So we battled it, right? 00:50:20,720 --> 00:50:22,720
所以我们战斗了，对吧？
--With a whole bunch of these old school optimizations. 00:50:22,720 --> 00:50:25,720
有了一大堆这些老派的优化。
--But we've gotten pretty good results in the end. 00:50:26,720 --> 00:50:29,720
但我们最终取得了不错的成绩。
--Okay. 00:50:30,720 --> 00:50:31,720
好的。
--Now we're going to let loose 00:50:31,720 --> 00:50:32,720
现在我们要放手
--by vectorizing our best solution. 00:50:32,720 --> 00:50:34,720
通过矢量化我们的最佳解决方案。
--Right? 00:50:35,720 --> 00:50:36,720
正确的？
--Go, go ISPC! 00:50:36,720 --> 00:50:38,720
去，去 ISPC！
--Right? 00:50:39,720 --> 00:50:40,720
正确的？
--Because this is sort of easy. 00:50:40,720 --> 00:50:41,720
因为这很容易。
--I mean, think about how much we've had to fight the fight 00:50:41,720 --> 00:50:46,720
我的意思是，想一想我们为这场斗争付出了多少努力
--and get into the dirt, right? 00:50:46,720 --> 00:50:49,720
进入泥土，对吧？
--To get the optimization we've had so far. 00:50:49,720 --> 00:50:51,720
为了获得我们迄今为止的优化。
--Think about how painful that's been. 00:50:51,720 --> 00:50:53,720
想想那是多么痛苦。
--Okay? 00:50:54,720 --> 00:50:55,720
好的？
--We've tried some things. 00:50:57,720 --> 00:50:58,720
我们已经尝试了一些东西。
--We've reasoned as best as we could. 00:50:58,720 --> 00:51:00,720
我们已经尽力推理了。
--We've gotten it right sometimes. 00:51:00,720 --> 00:51:01,720
我们有时做对了。
--We've gotten it wrong sometimes. 00:51:01,720 --> 00:51:03,720
有时我们弄错了。
--We've found this non-uniform stuff and figured out why 00:51:03,720 --> 00:51:06,720
我们发现了这种不均匀的东西并弄清楚了原因
--and picked the right values and so on. 00:51:06,720 --> 00:51:08,720
并选择正确的值等等。
--Right? 00:51:08,720 --> 00:51:09,720
正确的？
--I mean, it's been a 30-minute story in class, 00:51:10,720 --> 00:51:12,720
我的意思是，这是一个 30 分钟的课堂故事，
--but in all seriousness, 00:51:12,720 --> 00:51:13,720
但说真的，
--it probably took Randy three weeks to get there. 00:51:13,720 --> 00:51:16,720
兰迪可能花了三个星期才到达那里。
--I can assure you, in three weeks, I didn't get there. 00:51:17,720 --> 00:51:20,720
我可以向你保证，在三周内，我没有到达那里。
--I got about halfway there. 00:51:20,720 --> 00:51:22,720
我走到一半了。
--Okay? 00:51:23,720 --> 00:51:24,720
好的？
--So now, ta-da! 00:51:26,720 --> 00:51:29,720
所以现在，哒哒！
--A quick little ISPC right here to vectorize it, 00:51:30,720 --> 00:51:34,720
一个快速的小 ISPC 就在这里对其进行矢量化，
--and we're going to be good to go. 00:51:34,720 --> 00:51:36,720
我们将一切顺利。
--I want you to notice the two bold-faced lines in the upper left. 00:51:36,720 --> 00:51:40,720
我想让你注意左上角的两条黑体字。
--There's a word there that I'd like us to pay attention to. 00:51:43,720 --> 00:51:47,720
那里有一个词，我希望我们注意。
--Any idea what it is? 00:51:48,720 --> 00:51:50,720
知道它是什么吗？
--Uniform! 00:51:52,720 --> 00:51:53,720
制服！
--Yeah, the only word that's in common between those two lines. 00:51:53,720 --> 00:51:55,720
是的，这两行之间唯一的共同词。
--Somebody remind me what a uniform variable is. 00:51:56,720 --> 00:52:00,720
有人提醒我什么是统一变量。
--Okay? 00:52:00,720 --> 00:52:01,720
好的？
--The same across all instances. 00:52:05,720 --> 00:52:07,720
所有实例都相同。
--So if a value is computed upon a uniform variable in one instance, 00:52:07,720 --> 00:52:13,720
因此，如果在一个实例中根据统一变量计算一个值，
--is that computed value going to be available in another instance, 00:52:13,720 --> 00:52:17,720
是计算值将在另一个实例中可用，
--or is it going to need to be recomputed there? 00:52:17,720 --> 00:52:19,720
还是需要在那里重新计算？
--What do you guys in the back think? 00:52:22,720 --> 00:52:24,720
后面的你们怎么看？
--Okay. 00:52:25,720 --> 00:52:26,720
好的。
--Oh, man. 00:52:30,720 --> 00:52:31,720
天啊。
--Back of the class. 00:52:34,720 --> 00:52:35,720
课后。
--Yeah, you want to get this shit away from me because I'm dangerous. 00:52:35,720 --> 00:52:37,720
是的，你想把这狗屎从我身边拿走，因为我很危险。
--All right, somebody back here. 00:52:40,720 --> 00:52:41,720
好吧，有人回来了。
--What do you think? 00:52:41,720 --> 00:52:42,720
你怎么认为？
--Okay. 00:52:43,720 --> 00:52:44,720
好的。
--Hang on. 00:52:44,720 --> 00:52:45,720
不挂断。
--You're going the wrong way. 00:52:46,720 --> 00:52:47,720
你走错路了。
--I'm headed this way. 00:52:47,720 --> 00:52:48,720
我正往这边走。
--Oh. 00:52:56,720 --> 00:52:57,720
哦。
--So is that value, you compute this thing in one instance, 00:52:59,720 --> 00:53:03,720
那个值也是，你在一个实例中计算这个东西，
--is it going to be available in the other instance? 00:53:03,720 --> 00:53:05,720
它会在另一个实例中可用吗？
--Yeah, I mean, if we don't make it uniform, then they're all independent, right? 00:53:12,720 --> 00:53:15,720
是的，我的意思是，如果我们不统一，那么它们都是独立的，对吗？
--And then if we change it in one, it doesn't change with the others, right? 00:53:15,720 --> 00:53:18,720
然后如果我们改变其中一个，它不会随其他改变，对吗？
--But if we make it uniform and we change it in one place, 00:53:18,720 --> 00:53:22,720
但是如果我们使它统一并且我们在一个地方改变它，
--then it's changed everywhere, right? 00:53:22,720 --> 00:53:24,720
然后到处都变了，对吧？
--Hopefully. 00:53:26,720 --> 00:53:27,720
希望。
--Okay. 00:53:29,720 --> 00:53:30,720
好的。
--So now my question is, is that good or bad? 00:53:30,720 --> 00:53:32,720
所以现在我的问题是，这是好事还是坏事？
--Yeah. 00:53:33,720 --> 00:53:34,720
是的。
--Yeah, and so that depends, right? 00:53:53,720 --> 00:53:55,720
是的，所以这取决于，对吧？
--I mean, there's a reason you have to ask for something to be uniform 00:53:55,720 --> 00:53:58,720
我的意思是，你必须要求统一的东西是有原因的
--or, like, leave it not, right? 00:53:58,720 --> 00:54:00,720
或者，就像，不要离开它，对吗？
--And the answer depends on what's going on. 00:54:00,720 --> 00:54:02,720
答案取决于正在发生的事情。
--If we make something uniform, A, it's shared by everyone, 00:54:02,720 --> 00:54:05,720
如果我们制作统一的东西，A，它会被所有人共享，
--so we won't have multiple copies, 00:54:05,720 --> 00:54:07,720
所以我们不会有多个副本，
--and B, that change is visible everywhere. 00:54:07,720 --> 00:54:09,720
 B，这种变化随处可见。
--If we don't, then we have multiple copies, right? 00:54:09,720 --> 00:54:12,720
如果我们不这样做，那么我们有多个副本，对吗？
--And the changes are independent. 00:54:12,720 --> 00:54:14,720
并且变化是独立的。
--Yes. 00:54:14,720 --> 00:54:15,720
是的。
--Oh, I just wanted to add that in this case, I think it would be good 00:54:15,720 --> 00:54:20,720
哦，我只是想补充一下，在这种情况下，我认为这会很好
--because we are, since it is uniform, 00:54:20,720 --> 00:54:23,720
因为我们是，因为它是统一的，
--it's not that it's going to be, 00:54:23,720 --> 00:54:27,720
并不是说它会是，
--the computation needs to be redone over and over, 00:54:27,720 --> 00:54:30,720
计算需要一遍又一遍地重做，
--but it's going to be done by a normal arithmetic unit and not a vector unit, 00:54:30,720 --> 00:54:34,720
但它将由一个普通的算术单元而不是一个向量单元来完成，
--and if we're going to be involved in a vector unit, is that good? 00:54:34,720 --> 00:54:38,720
如果我们要参与矢量单元，那好吗？
--I mean, that's actually, I didn't actually think of that, 00:54:38,720 --> 00:54:40,720
我的意思是，实际上，我并没有真正想到这一点，
--but you're exactly, you're actually true as a matter of how that's going to feed through the pipeline. 00:54:40,720 --> 00:54:44,720
但你是确切的，你实际上是真实的，因为这将如何通过管道提供。
--Now, keep in mind that when we add vectorization, 00:54:44,720 --> 00:54:49,720
现在，请记住，当我们添加矢量化时，
--we're really changing the way we use the functional units. 00:54:49,720 --> 00:54:52,720
我们真的在改变我们使用功能单元的方式。
--We're not necessarily adding more, but I think you're right. 00:54:52,720 --> 00:54:55,720
我们不一定要添加更多，但我认为你是对的。
--It's going to feed through the pipeline much better. 00:54:55,720 --> 00:54:57,720
它会更好地通过管道。
--Yes. 00:54:57,720 --> 00:54:58,720
是的。
--Why does it feel like a lot of these optimizations that you've talked about 00:54:58,720 --> 00:55:01,720
为什么感觉你说了很多这些优化
--seem like the kind of thing that a compiler would do with O3 and like math? 00:55:01,720 --> 00:55:06,720
看起来像是编译器会用 O3 做的事情，就像数学一样？
--You know, so some of the optimization, the question is, will a compiler do this for us? 00:55:06,720 --> 00:55:10,720
你知道，所以一些优化，问题是，编译器会为我们做这件事吗？
--And the answer is, in many cases, it will. 00:55:10,720 --> 00:55:13,720
答案是，在很多情况下，它会。
--But some things it can't. 00:55:13,720 --> 00:55:15,720
但有些事情它不能。
--For example, it doesn't know whether that computation is distributive and associative or not. 00:55:15,720 --> 00:55:20,720
例如，它不知道该计算是否具有分配性和关联性。
--So it couldn't make any of those. 00:55:20,720 --> 00:55:22,720
所以它不能做任何这些。
--And worse than that, not only could it not make the optimizations initially 00:55:22,720 --> 00:55:27,720
更糟糕的是，它不仅不能在最初进行优化
--with changing the association of the distribution, 00:55:27,720 --> 00:55:30,720
随着分布关联的改变，
--it couldn't make any optimizations that were apparent after doing that. 00:55:30,720 --> 00:55:33,720
这样做之后，它无法进行任何明显的优化。
--So, yes, although compilers can do a lot of things, 00:55:33,720 --> 00:55:36,720
所以，是的，虽然编译器可以做很多事情，
--there are still a lot of optimization blockers that can prevent compilers from doing these things. 00:55:36,720 --> 00:55:41,720
仍然有很多优化阻止程序可以阻止编译器做这些事情。
--Which is why I always say, benchmark it first, right? 00:55:41,720 --> 00:55:45,720
这就是为什么我总是说，首先对其进行基准测试，对吗？
--We didn't start optimizing the C code. 00:55:45,720 --> 00:55:47,720
我们没有开始优化 C 代码。
--We started running it with flags and looking at what assembly it produced. 00:55:47,720 --> 00:55:52,720
我们开始使用标志运行它并查看它生成的程序集。
--And that's why we looked at that assembly. 00:55:52,720 --> 00:55:55,720
这就是我们查看该集会的原因。
--To see what did the compiler actually give us. 00:55:55,720 --> 00:55:58,720
看看编译器实际上给了我们什么。
--So if it unrolled it, we're not going to unroll it because that's done. 00:55:58,720 --> 00:56:01,720
所以如果它展开它，我们不会展开它，因为那已经完成了。
--That's not our problem. 00:56:01,720 --> 00:56:03,720
那不是我们的问题。
--I don't know the exact flags that we used. 00:56:06,720 --> 00:56:08,720
我不知道我们使用的确切标志。
--But all of these were run with at least O3. 00:56:08,720 --> 00:56:10,720
但所有这些都至少与 O3 一起运行。
--I don't know whether FastMath was used. 00:56:12,720 --> 00:56:13,720
我不知道是否使用了 FastMath。
--And I can imagine he has, but I just don't know that. 00:56:13,720 --> 00:56:16,720
我可以想象他有，但我只是不知道。
--These things have trouble with mathematical rules and all sorts of other things. 00:56:17,720 --> 00:56:21,720
这些东西在数学规则和其他各种东西上都有问题。
--They don't know whether a condition is likely to be true. 00:56:21,720 --> 00:56:23,720
他们不知道条件是否可能为真。
--You declare an integer variable, you think it's from 0 to N, 00:56:23,720 --> 00:56:27,720
你声明一个整数变量，你认为它是从0到N，
--and it looks at it and says it can be from negative whatever to whatever. 00:56:27,720 --> 00:56:30,720
它看着它并说它可以从消极的任何东西到任何东西。
--You know it's not going to overflow, it has to worry about it. 00:56:30,720 --> 00:56:33,720
你知道它不会溢出，它必须担心它。
--There are a lot of things that come into mind as you actually look at the differences 00:56:33,720 --> 00:56:36,720
当您实际查看差异时，会想到很多事情
--between the types as understood by the programmer, 00:56:36,720 --> 00:56:38,720
在程序员理解的类型之间，
--and the type limits as understood by the hardware. 00:56:38,720 --> 00:56:41,720
以及硬件理解的类型限制。
--Anyway, the fact that those two are declared as uniform 00:56:42,720 --> 00:56:47,720
无论如何，这两个被宣布为统一的事实
--actually turns out to make a performance improvement 00:56:47,720 --> 00:56:49,720
实际上是为了提高性能
--because we don't have to recompute those values in each of the instances. 00:56:49,720 --> 00:56:54,720
因为我们不必在每个实例中重新计算这些值。
--Diving in here. 00:57:00,720 --> 00:57:02,720
在这里潜水。
--This ran in 0.63 nanoseconds per element 00:57:05,720 --> 00:57:08,720
每个元素的运行时间为 0.63 纳秒
--versus 7.16 for the unvectorized code, 00:57:08,720 --> 00:57:10,720
与非矢量化代码的 7.16 相比，
--which was a speedup of 9.83 times. 00:57:10,720 --> 00:57:13,720
这是 9.83 倍的加速。
--A speedup of more than 8 times seems strange, right? 00:57:17,720 --> 00:57:20,720
超过8倍的加速似乎很奇怪吧？
--Why does a speedup of more than 8 times seem strange? 00:57:21,720 --> 00:57:24,720
为什么超过8倍的加速看起来很奇怪？
--Yeah, it's an 8-wide vector. 00:57:28,720 --> 00:57:29,720
是的，它是一个 8 宽的向量。
--So if I go from doing 8 things in series to 8 things in parallel, 00:57:29,720 --> 00:57:33,720
所以如果我从串联做 8 件事变成并行做 8 件事，
--I shouldn't see more than an 8x speedup. 00:57:33,720 --> 00:57:35,720
我不应该看到超过 8 倍的加速。
--But what I've done by declaring those as uniform 00:57:36,720 --> 00:57:39,720
但是我通过将它们声明为制服所做的
--is I've actually taken that work out of what has to be done 8 times 00:57:39,720 --> 00:57:43,720
我实际上已经从必须完成的工作中删除了 8 次
--and made it done just once. 00:57:43,720 --> 00:57:45,720
并让它只完成一次。
--Correct, but before we had that code which was part of that inner work loop, 00:57:52,720 --> 00:57:56,720
正确，但在我们拥有属于内部工作循环的代码之前，
--and now by making it uniform, 00:57:56,720 --> 00:57:58,720
现在通过使其统一，
--it in effect gets pulled out of that inner work loop and done once per loop, 00:57:58,720 --> 00:58:02,720
它实际上被拉出那个内部工作循环并且每个循环完成一次，
--not with each of the inner works. 00:58:02,720 --> 00:58:04,720
不是每个内部作品。
--So that work is now taking one-eighth of what it was 00:58:06,720 --> 00:58:09,720
所以这项工作现在只占原来的八分之一
--because we're parallelizing everything else, 00:58:09,720 --> 00:58:11,720
因为我们正在并行化其他一切，
--and that's being factored out. 00:58:11,720 --> 00:58:13,720
这正在被考虑在内。
--And so the demo is really in the details sometimes. 00:58:15,720 --> 00:58:18,720
因此，演示有时真的很详细。
--So, what's that? 00:58:21,720 --> 00:58:23,720
那么，那是什么？
--We consider optimization to be a sport, right? 00:58:25,720 --> 00:58:28,720
我们认为优化是一项运动，对吗？
--We've got to keep score. 00:58:28,720 --> 00:58:30,720
我们必须保持得分。
--We've got to keep score, right? 00:58:31,720 --> 00:58:33,720
我们必须保持得分，对吗？
--So vectorizing was easy. 00:58:33,720 --> 00:58:34,720
所以矢量化很容易。
--The thing about vectorizing is it was a free, basically, 5.4x speedup. 00:58:34,720 --> 00:58:39,720
关于向量化的事情是它是免费的，基本上是 5.4 倍的加速。
--Any of the individual optimizations we did, 00:58:40,720 --> 00:58:43,720
我们所做的任何个别优化，
--you know, with the conventional optimizations, 00:58:43,720 --> 00:58:45,720
你知道，通过传统的优化，
--got anywhere between effectively 0 and 7x speedup. 00:58:45,720 --> 00:58:48,720
有效地获得了 0 到 7 倍的加速。
--But they were all painful. 00:58:48,720 --> 00:58:50,720
但是他们都很痛苦。
--But collectively, conventional optimization got us 15x speedup 00:58:51,720 --> 00:58:56,720
但总的来说，常规优化使我们的速度提高了 15 倍
--for the first three weeks of work. 00:58:56,720 --> 00:58:58,720
工作的前三周。
--The last 15 minutes of work got us 5.4x speedup 00:58:58,720 --> 00:59:03,720
最后 15 分钟的工作让我们获得了 5.4 倍的加速
--for a total speedup of 82x. 00:59:03,720 --> 00:59:07,720
总加速为 82 倍。
--Okay? 00:59:10,720 --> 00:59:11,720
好的？
--So, I guess, what's the point of today, 00:59:11,720 --> 00:59:16,720
所以，我想，今天的重点是什么，
--of this part of today's class? 00:59:16,720 --> 00:59:18,720
今天课程的这一部分？
--The point of this part of today's class is that we're spending a lot of time 00:59:18,720 --> 00:59:21,720
今天这节课的重点是我们花了很多时间
--this semester talking about architectural features 00:59:21,720 --> 00:59:25,720
这学期讲建筑特色
--and talking about ways of using those architectural features. 00:59:25,720 --> 00:59:29,720
并讨论使用这些架构特性的方法。
--But you can't forget your basic 213 program. 00:59:29,720 --> 00:59:33,720
但是您不能忘记您的基本 213 程序。
--Because it got us 3x the speedup of vectorization. 00:59:34,720 --> 00:59:37,720
因为它使我们的矢量化速度提高了 3 倍。
--Right? 00:59:40,720 --> 00:59:41,720
正确的？
--In some sense, vectorization turned out to be the cheap trick. 00:59:41,720 --> 00:59:44,720
从某种意义上说，矢量化被证明是一种廉价的技巧。
--Now, if in the real world you're writing code, 00:59:45,720 --> 00:59:50,720
现在，如果你在现实世界中编写代码，
--you're going to probably try this the other way around, right? 00:59:50,720 --> 00:59:54,720
您可能会尝试相反的方法，对吗？
--You're going to probably take 30 seconds or whatever, 00:59:54,720 --> 00:59:56,720
你可能需要 30 秒或其他时间，
--some short amount of time, 00:59:56,720 --> 00:59:58,720
一些很短的时间，
--and optimize the basics 213 style as best as you can. 00:59:58,720 --> 01:00:01,720
并尽可能优化基础 213 样式。
--Not spend three weeks on it, right? 01:00:02,720 --> 01:00:04,720
不会花三个星期吧？
--You're then going to turn on vectorization because that's free, 01:00:04,720 --> 01:00:07,720
然后你要打开矢量化，因为它是免费的，
--and then you're going to ask yourself, 01:00:07,720 --> 01:00:08,720
然后你会问自己，
--am I good enough? 01:00:08,720 --> 01:00:09,720
我够好吗？
--Is this the best way to spend my time? 01:00:10,720 --> 01:00:12,720
这是打发时间的最佳方式吗？
--In some cases, the answer is yes. 01:00:13,720 --> 01:00:14,720
在某些情况下，答案是肯定的。
--In some cases, the answer is no. 01:00:14,720 --> 01:00:16,720
在某些情况下，答案是否定的。
--Right? 01:00:17,720 --> 01:00:18,720
正确的？
--Most of the code we write is not in our work loops 01:00:18,720 --> 01:00:22,720
我们编写的大部分代码不在我们的工作循环中
--inside the most demanding parts of the kernels of our software. 01:00:22,720 --> 01:00:25,720
在我们软件内核中最苛刻的部分。
--We write the code, 01:00:25,720 --> 01:00:26,720
我们写代码，
--and our goal should be to make our code as expressive as possible. 01:00:26,720 --> 01:00:29,720
我们的目标应该是使我们的代码尽可能具有表现力。
--That is to say, make it as easy to read and maintain. 01:00:30,720 --> 01:00:32,720
也就是说，使其易于阅读和维护。
--Which means that optimization hurts code quality. 01:00:32,720 --> 01:00:35,720
这意味着优化会损害代码质量。
--Right? 01:00:38,720 --> 01:00:39,720
正确的？
--It makes it more likely that you or someone else will introduce a bug, 01:00:39,720 --> 01:00:42,720
它使您或其他人更有可能引入错误，
--which makes it more likely that your company is going to encounter 01:00:42,720 --> 01:00:45,720
这使您的公司更有可能遇到
--some penalty as a result of what you've done. 01:00:45,720 --> 01:00:47,720
由于你的所作所为而受到一些惩罚。
--Either a delay in the production of the software 01:00:47,720 --> 01:00:50,720
要么延迟软件的生产
--because the bug is going to have to be caught and fixed, 01:00:50,720 --> 01:00:52,720
因为必须捕获并修复错误，
--or an injury to a customer because they're going to experience the bug. 01:00:52,720 --> 01:00:55,720
或对客户造成伤害，因为他们将遇到该错误。
--Right? 01:00:56,720 --> 01:00:57,720
正确的？
--But once we get to these inner work loops inside the kernels of our software, 01:00:57,720 --> 01:01:00,720
但是一旦我们进入软件内核中的这些内部工作循环，
--then optimization matters, 01:01:00,720 --> 01:01:01,720
那么优化很重要，
--because there's a difference between doing something for our customer and not. 01:01:01,720 --> 01:01:05,720
因为为我们的客户做某事与不为我们的客户做某事是有区别的。
--Being able to deliver that result 01:01:05,720 --> 01:01:07,720
能够交付该结果
--before the customer hits the X in the upper right-hand corner of the screen and not. 01:01:07,720 --> 01:01:11,720
在客户点击屏幕右上角的 X 之前，而不是。
--Making the activity in that game more realistic or not, and so on. 01:01:12,720 --> 01:01:18,720
使该游戏中的活动更逼真或更不真实，等等。
--And then it actually matters. 01:01:19,720 --> 01:01:21,720
然后它真的很重要。
--And generally speaking, you need to get something within some budget. 01:01:22,720 --> 01:01:25,720
一般来说，您需要在预算范围内获得一些东西。
--There's a certain amount of smoothness you need to have. 01:01:25,720 --> 01:01:27,720
你需要有一定的平滑度。
--And beyond that, the human can't tell. 01:01:27,720 --> 01:01:29,720
除此之外，人类无法分辨。
--There's a certain amount of resolution you need to have, 01:01:29,720 --> 01:01:31,720
你需要有一定的决心，
--or whatever it is you're working on. 01:01:31,720 --> 01:01:33,720
或者无论你在做什么。
--And beyond that, it doesn't matter. 01:01:33,720 --> 01:01:34,720
除此之外，没关系。
--And you're going to optimize until you get within your budget. 01:01:34,720 --> 01:01:37,720
并且您将进行优化，直到您达到预算。
--Okay. 01:01:39,720 --> 01:01:40,720
好的。
--Any questions about that? 01:01:41,720 --> 01:01:43,720
有什么问题吗？
--All right. 01:01:44,720 --> 01:01:45,720
好的。
--Somehow I actually think that I ran through this ten minutes faster than I expected. 01:01:45,720 --> 01:01:49,720
不知何故，我实际上认为我比我预期的要快十分钟。
--And so I apologize for that. 01:01:49,720 --> 01:01:50,720
所以我为此道歉。
--I actually thought I was going to run long. 01:01:50,720 --> 01:01:52,720
我实际上以为我会跑很长时间。
--But you get ten minutes free. 01:01:52,720 --> 01:01:53,720
但是你有十分钟的空闲时间。
--I'll collect it from you next time. 01:01:53,720 --> 01:01:55,720
下次我会向你收取。
--And so plan on running, you know, ten minutes late projects here. 01:01:57,720 --> 01:02:00,720
所以计划在这里运行，你知道的，延迟十分钟的项目。
--As always, guys, I'm here to help. 01:02:02,720 --> 01:02:03,720
一如既往，伙计们，我是来帮忙的。
--If you go to my webpage and click on the little link, 01:02:03,720 --> 01:02:05,720
如果你去我的网页并点击那个小链接，
--you can see my schedule and come find me. 01:02:05,720 --> 01:02:07,720
你可以看到我的日程安排，然后来找我。
--I've got office hours over in the NI building, 01:02:07,720 --> 01:02:09,720
我在 NI 大楼的办公时间结束了，
--but also here, but also not here. 01:02:09,720 --> 01:02:11,720
又在这里，又不在这里。
--But also in Gates, in the common area on the fifth floor. 01:02:11,720 --> 01:02:13,720
但也在盖茨，在五楼的公共区域。
--So I'd love for you to drop by, say hello, chat. 01:02:13,720 --> 01:02:15,720
所以我希望你能顺便过来，打个招呼，聊天。
--Have a great afternoon. 01:02:17,720 --> 01:02:18,720
祝你下午愉快。
