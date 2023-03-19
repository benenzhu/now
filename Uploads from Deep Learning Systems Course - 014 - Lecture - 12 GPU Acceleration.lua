--Okay, hello everyone, welcome back to Deep Learning Systems, 00:00:00,000 --> 00:00:07,000
好的，大家好，欢迎回到深度学习系统，
--Every-Single Implementation. In the last lecture, we talked about how we can use 00:00:07,000 --> 00:00:12,160
每次实施。在上一节课中，我们讨论了如何使用
--different acceleration techniques, especially how can we make use of memory 00:00:12,160 --> 00:00:17,120
不同的加速技术，尤其是我们如何利用内存
--reuse to be able to accelerate our linear algebra operations on a CPU. So today 00:00:17,120 --> 00:00:24,800
重用能够加速我们在 CPU 上的线性代数运算。所以今天
--we're going to go to a different related topic, which is, you know, imagine that 00:00:24,800 --> 00:00:29,760
我们将转到一个不同的相关主题，也就是说，你知道，想象一下
--we start to use modern acceleration hardware like a GPU, how can we, you know, 00:00:29,760 --> 00:00:35,200
我们开始使用像 GPU 这样的现代加速硬件，我们怎么能，你知道，
--leverage some of the properties of GPU to help us accelerate some of our 00:00:35,200 --> 00:00:38,800
利用 GPU 的一些特性来帮助我们加速我们的一些
--computations. Of course, the topic of GPU acceleration is quite large, so it's 00:00:38,800 --> 00:00:44,160
计算。当然，GPU加速这个话题比较大，所以
--impossible to cover everything within a single lecture. Our hope is that 00:00:44,160 --> 00:00:48,960
不可能在一次讲座中涵盖所有内容。我们的希望是
--hopefully this lecture is going to give you enough of a background so that we 00:00:48,960 --> 00:00:53,600
希望本次讲座能为您提供足够的背景知识，以便我们
--can start exploring this topic and you will be able to make use of lessons 00:00:53,600 --> 00:00:58,200
可以开始探索这个主题，你将能够利用课程
--you learned in this class to be able to work on some of your homework stream. 00:00:58,200 --> 00:01:04,360
你在这门课上学到了能够完成你的一些家庭作业流。
--So let's get started. This lecture is going to focus on two parts. So the first part, 00:01:04,360 --> 00:01:09,400
让我们开始吧。本次讲座将围绕两个部分展开。所以第一部分，
--we're going to do a high-level overview of GPU programming, and the second part 00:01:09,400 --> 00:01:15,920
我们将对 GPU 编程进行高级概述，第二部分
--we're going to do a case study on how can we leverage the techniques we learned 00:01:15,920 --> 00:01:20,360
我们将做一个关于如何利用我们学到的技术的案例研究
--in the first part to be able to accelerate matrix publications on a GPU. 00:01:20,360 --> 00:01:26,560
在第一部分中，能够在 GPU 上加速矩阵发布。
--So let's start with the first part. So first, what is a GPU? So if you start to 00:01:27,280 --> 00:01:33,840
那么让我们从第一部分开始。那么首先，什么是 GPU？所以如果你开始
--think about a GPU, by the way, in this lecture we're going to use NVIDIA's 00:01:33,840 --> 00:01:39,800
考虑一下 GPU，顺便说一下，在本次讲座中我们将使用 NVIDIA 的
--CUDA as the primary programming model, and this is because, you know, you can 00:01:39,800 --> 00:01:43,960
CUDA 作为主要的编程模型，这是因为，你知道，你可以
--find a lot more materials around CUDA, but there are also other relevant GPU 00:01:43,960 --> 00:01:48,800
找了很多关于CUDA的资料，不过也有其他相关的GPU
--programming models, such as SYCL, one API from Intel, and OpenCL that you can also 00:01:48,800 --> 00:01:54,240
编程模型，例如 SYCL，一种来自 Intel 的 API，以及您还可以使用的 OpenCL
--go and take a look at. So to come back to your topic, what is a GPU? So normally, 00:01:54,400 --> 00:01:59,920
去看看。那么回到您的主题，什么是 GPU？所以通常情况下，
--if you look at parallel computing, you will find that the most familiar thing 00:01:59,920 --> 00:02:04,080
如果你看一下并行计算，你会发现最熟悉的东西
--you are looking at would be just having multiple kinds of general-purpose 00:02:04,080 --> 00:02:09,040
你正在看的只是有多种通用的
--processors in here, right? So general-purpose processors can include 00:02:09,040 --> 00:02:14,400
处理器在这里，对吧？所以通用处理器可以包括
--things like, for example, here we have four CPU cores. And one of the key 00:02:14,400 --> 00:02:20,640
例如，这里我们有四个 CPU 内核。而关键之一
--properties of those general-purpose processors is that they have a lot of 00:02:20,680 --> 00:02:25,560
这些通用处理器的特性是它们有很多
--the flexibility in terms of control, how you can go and ask each of these cores 00:02:25,560 --> 00:02:32,200
控制方面的灵活性，你如何去询问这些核心中的每一个
--to do differences. For example, I could run my web browser on one of my CPU cores 00:02:32,200 --> 00:02:38,440
做差异。例如，我可以在我的一个 CPU 内核上运行我的网络浏览器
--while running a game on another CPU core without a problem. This is because each 00:02:38,440 --> 00:02:42,880
在另一个 CPU 核心上运行游戏时没有问题。这是因为每个
--of the CPU cores have their own control. You can imagine that in order to perform 00:02:42,880 --> 00:02:47,520
的 CPU 核心有自己的控制权。你可以想象，为了执行
--some tasks, each of the hardware will have two kinds of things. One kind of 00:02:47,520 --> 00:02:52,400
有些任务，每个硬件都会有两种东西。一种
--thing is what we call commander unit, which is the control unit that tries to 00:02:52,400 --> 00:02:56,480
事情就是我们所说的指挥官单位，它是试图
--give commands on, hey, what are the next steps you want to go and work on? And 00:02:56,480 --> 00:03:00,960
发出命令，嘿，你下一步想做什么？和
--then there will be soldiers that go and really execute those tasks. And those 00:03:00,960 --> 00:03:04,880
然后会有士兵去真正执行这些任务。以及那些
--soldiers are what we call data paths that allows us to be able to fetch data 00:03:04,880 --> 00:03:09,520
士兵就是我们所说的数据路径，它使我们能够获取数据
--from the memory, doing computations or registers and store the data back. A 00:03:09,520 --> 00:03:15,520
从内存中进行计算或寄存器并将数据存储回来。 A
--typical CPU will have a very strong commander unit or control unit that 00:03:15,520 --> 00:03:23,240
典型的 CPU 会有一个非常强大的指挥单元或控制单元
--allows us to do different kinds of tasks. The brown trains, they can have 00:03:23,240 --> 00:03:27,080
允许我们做不同种类的任务。棕色的火车，他们可以有
--flexibilities, have to have each of a core doing different things, while you 00:03:27,080 --> 00:03:31,000
灵活性，必须让每个核心做不同的事情，而你
--can even have a single core context switching between different tasks very 00:03:31,000 --> 00:03:34,920
甚至可以有一个单一的核心上下文在不同的任务之间切换非常
--flexibly. So as a result, there are a lot of the emphasis on being able to have 00:03:34,920 --> 00:03:40,640
灵活地。因此，很多人都强调能够拥有
--flexible control. On the other hand, one thing that people start to realize, at 00:03:40,640 --> 00:03:45,200
灵活控制。另一方面，人们开始意识到一件事，在
--least in the area of graphics, is that when we start to go and render things, we 00:03:45,200 --> 00:03:51,680
至少在图形领域，当我们开始渲染东西时，我们
--are doing a lot of similar things, right? We are, for example, you want to be able 00:03:51,680 --> 00:03:55,880
正在做很多类似的事情，对吧？我们是，例如，你希望能够
--to add brightness to an entire image. Likely what you need to do is you want 00:03:55,880 --> 00:04:00,680
为整个图像增加亮度。可能你需要做的就是你想要的
--to be able to add the same value to all the pixels. So that's the same task. You 00:04:00,680 --> 00:04:05,800
能够将相同的值添加到所有像素。所以这是同样的任务。你
--don't need a lot of commanders to be able to command the soldiers. Instead, 00:04:05,800 --> 00:04:11,480
不需要很多指挥官就能指挥士兵。反而，
--you want a huge amount of soldiers that go ahead and perform the task, while 00:04:11,480 --> 00:04:15,600
您需要大量士兵继续执行任务，而
--having a few commanders to come and give command on how exactly you 00:04:15,600 --> 00:04:20,200
有几个指挥官来指挥你究竟如何
--want to do things. And that kind of motivates a different kind of hardware 00:04:20,200 --> 00:04:24,000
想做事。而这种激励了一种不同类型的硬件
--architecture, which is kind of a GPU architecture on the right-hand side. Of 00:04:24,000 --> 00:04:29,600
架构，这是右侧的一种 GPU 架构。的
--course, this is an illustration of what roughly is going on, but you can find 00:04:29,600 --> 00:04:33,960
当然，这是对大致情况的说明，但您可以找到
--that there's a huge amount of green areas here that correspond to the 00:04:34,000 --> 00:04:37,960
这里有大量的绿色区域对应于
--computing soldiers that allows people to come in and do highly intensive 00:04:37,960 --> 00:04:43,160
允许人们进来并做高度密集的计算士兵
--arithmetic tasks. While there's still control units, we will have fewer 00:04:43,160 --> 00:04:49,040
算术任务。虽然还有控制单元，但我们的数量会更少
--controllers that control a huge group of soldiers. As a result, it's harder to say 00:04:49,040 --> 00:04:54,000
控制一大群士兵的控制器。结果一言难尽
--like, you know, soldier one, go ahead and go north. Soldier two, go ahead and go 00:04:54,000 --> 00:04:58,960
就像，你知道的，士兵一号，继续往北走。士兵二，继续前进
--south and do a completely different task. And that's not what GPU is good at. But 00:04:58,960 --> 00:05:03,320
向南并执行完全不同的任务。而这并不是 GPU 擅长的。但
--instead, if we go ahead and say, hey, all those soldiers should do similar 00:05:03,320 --> 00:05:08,160
相反，如果我们继续说，嘿，所有那些士兵都应该做类似的事情
--tasks, and those tasks come from a single commander, likely it is 00:05:08,160 --> 00:05:13,280
任务，而这些任务来自一个指挥官，很可能是
--something that a task, that a massive parallel computing unit like 00:05:13,280 --> 00:05:17,720
一个任务，一个巨大的并行计算单元，比如
--GPU is good at. So that's kind of one of the main differences between CPU 00:05:17,720 --> 00:05:22,440
GPU擅长。所以这是 CPU 之间的主要区别之一
--and GPU. And why do we need GPU programming? So I still remember when 00:05:22,440 --> 00:05:28,080
和显卡。为什么我们需要 GPU 编程？所以我还记得什么时候
--I started work on deep learning, the first machine learning, deep learning 00:05:28,200 --> 00:05:34,160
我开始研究深度学习，第一个机器学习，深度学习
--model that we built, actually we tried to attempt and run it on a CPU that we 00:05:34,160 --> 00:05:40,240
我们构建的模型，实际上我们试图尝试在我们的 CPU 上运行它
--had using the most state-of-the-art libraries, which leverages like FFT for 00:05:40,240 --> 00:05:45,080
使用了最先进的库，它利用像 FFT
--convolution. It still took us about a week then to be able to even run that 00:05:45,080 --> 00:05:50,120
卷积。我们仍然花了大约一周的时间才能够运行它
--model end-to-end. But then we started to switch over to a GPU and that time got 00:05:50,120 --> 00:05:55,240
模型端到端。但后来我们开始切换到 GPU，时间到了
--reduced to several hours, which is kind of amazing speedup that you can get. 00:05:55,280 --> 00:05:59,680
减少到几个小时，这是您可以获得的惊人加速。
--Because, of course, there's no free lunch, right? So the trade-off here is 00:06:00,280 --> 00:06:06,120
因为，当然，天下没有免费的午餐，对吧？所以这里的权衡是
--we are trying to dedicate a lot more resources to the compute and trying to 00:06:06,120 --> 00:06:13,320
我们正在尝试将更多资源用于计算并尝试
--ask all the computation units to do the similar things. So as a result, by 00:06:13,320 --> 00:06:18,080
要求所有计算单元做类似的事情。因此，通过
--leveraging a GPU, you can usually observe more than 10x or sometimes 100x 00:06:18,080 --> 00:06:23,520
利用 GPU，您通常可以观察到 10 倍以上，有时甚至是 100 倍
--speedup versus traditional kind of computing. And GPU is still in the 00:06:23,520 --> 00:06:27,720
加速与传统类型的计算。而GPU还在
--powerhouse that powers almost all the deep learning workloads today. Of 00:06:27,720 --> 00:06:32,520
为当今几乎所有深度学习工作负载提供动力的强大动力。的
--course, there are even more specialized hardware being coming up, right, which 00:06:32,520 --> 00:06:36,480
当然，还有更多专门的硬件正在出现，对吧，
--we don't have time to talk about today, but still a very important topic that 00:06:36,480 --> 00:06:42,240
我们今天没有时间谈论，但仍然是一个非常重要的话题
--you know, all of us are, but GPU itself is kind of indispensable nowadays in 00:06:42,880 --> 00:06:48,720
你知道，我们所有人都是，但 GPU 本身在当今是不可或缺的
--order to run deep learning workloads. So here's like why GPU gives you this 00:06:48,840 --> 00:06:55,760
为了运行深度学习工作负载。所以这就是为什么 GPU 给你这个
--massive parallelism, but then there's a question of how we can come back and 00:06:55,760 --> 00:06:59,880
大规模的并行性，但是还有一个问题是我们如何返回并
--program those massively parallel units. That comes back to the GPU programming 00:06:59,880 --> 00:07:06,280
对那些大规模并行单元进行编程。回到 GPU 编程
--model. In this case, we're going to use KUDAS terminology in this lecture, but 00:07:06,280 --> 00:07:12,720
模型。在这种情况下，我们将在本次讲座中使用 KUDAS 术语，但是
--you know, usually there's a direct mapping between those concepts and other 00:07:12,760 --> 00:07:16,840
你知道，通常这些概念和其他概念之间存在直接映射
--GPU programming models. For example, you know, the mapping between KUDAS to 00:07:16,840 --> 00:07:20,760
GPU 编程模型。比如你知道的，KUDAS到
--OpenCL, which is a programming model that's used by some ARM GPUs and other 00:07:20,760 --> 00:07:25,200
OpenCL，它是一些 ARM GPU 和其他 GPU 使用的编程模型
--mobile GPUs. SYCL is another one that is, you know, that is being pushed by a 00:07:25,200 --> 00:07:32,080
移动 GPU。 SYCL 是另一个，你知道，它是由一个
--lot of the Kurogana's open community standard. And Apple had a standard 00:07:32,080 --> 00:07:37,960
很多 Kurogana 的开放社区标准。苹果有一个标准
--called METL that is working on similar things. So effectively, a GPU 00:07:37,960 --> 00:07:43,680
称为 METL，正在从事类似的工作。如此有效，GPU
--programming model is what we call a single instruction multiple thread. The idea is 00:07:43,680 --> 00:07:48,440
编程模型就是我们所说的单指令多线程。这个想法是
--that we're going to specify the code that one thread is going to execute. So 00:07:48,440 --> 00:07:54,040
我们将指定一个线程将要执行的代码。所以
--in here, there's this specific concept of single thread. And effectively, all 00:07:54,040 --> 00:07:59,840
在这里，有单线程这个特定的概念。实际上，所有
--the threads execute the same code. But then there's a question of, you know, if 00:07:59,840 --> 00:08:04,160
线程执行相同的代码。但还有一个问题，你知道，如果
--all the threads execute the same code, but what's the difference between the 00:08:04,160 --> 00:08:06,680
所有线程都执行相同的代码，但是它们之间有什么区别
--threads? The idea is that each of the threads will have their own context, 00:08:06,680 --> 00:08:10,720
线程？这个想法是每个线程都有自己的上下文，
--specifically their locations, the thread ID. And then, you know, there 00:08:11,000 --> 00:08:18,320
特别是它们的位置，线程 ID。然后，你知道，那里
--can be slightly different executions in terms of data they load and data they 00:08:18,320 --> 00:08:22,840
就它们加载的数据和它们加载的数据而言，执行可能会略有不同
--store into. Another interesting thing is that we're going to group the threads 00:08:22,840 --> 00:08:28,000
存入。另一个有趣的事情是我们要对线程进行分组
--onto what we call blocks. And the threads within the same blocks also 00:08:28,040 --> 00:08:33,120
到我们所说的块上。并且同一块内的线程也
--share some kind of common resources so that they will be able to, you know, 00:08:33,120 --> 00:08:37,920
共享某种公共资源，这样他们就能够，你知道，
--for example, they had a shared memory that allowed, you know, thread within 00:08:37,920 --> 00:08:41,880
例如，他们有一个共享内存，允许线程在
--the same block to be able to share data with each other. Finally, all the 00:08:41,880 --> 00:08:47,840
同一个块，以便能够彼此共享数据。最后，所有的
--thread blocks are then grouped into what we call a launching grid that 00:08:47,840 --> 00:08:51,480
然后线程块被分组到我们所说的启动网格中
--contains multiple blocks. And now when we say, you know, hey, I want to go 00:08:51,480 --> 00:08:55,720
包含多个块。现在当我们说，你知道，嘿，我想去
--ahead and launch a GPU kernel, what we really say is we're going to launch all 00:08:55,720 --> 00:09:00,160
提前启动 GPU 内核，我们真正要说的是我们将启动所有
--this grid of thread blocks that contains multiple threads within the 00:09:00,160 --> 00:09:04,680
这个线程块网格包含多个线程
--grid. Okay, so one of the interesting things you can find in here is that 00:09:04,680 --> 00:09:08,920
网格。好的，你可以在这里找到的一件有趣的事情是
--this GPU kernel model contains two levels of hierarchy. We have the thread 00:09:09,480 --> 00:09:13,800
这个 GPU 内核模型包含两个级别的层次结构。我们有线程
--block as a first level, and the launching grid as a second level. And 00:09:13,800 --> 00:09:19,520
块作为第一级，发射网格作为第二级。和
--these kind of two-level hierarchy will also come back when we start to talk 00:09:19,560 --> 00:09:23,600
当我们开始谈话时，这种两级等级也会回来
--about more advanced programming models such as shared memory programming. 00:09:23,600 --> 00:09:26,720
关于更高级的编程模型，例如共享内存编程。
--Okay, so to give you a sense of what it might look like, let's start to look at 00:09:27,600 --> 00:09:32,000
好的，为了让您了解它的外观，让我们开始看看
--a simple CUDA code in here. And in here, this is an example code that performs 00:09:32,000 --> 00:09:38,720
这里有一个简单的 CUDA 代码。在这里，这是执行的示例代码
--vector add. So on top, let's assume that we want to do ci equals ai times bi. So 00:09:38,720 --> 00:09:48,280
矢量添加。因此，最重要的是，假设我们想要 ci 等于 ai 乘以 bi。所以
--in fact, we have vector add in here. And you can find the code on the top is how 00:09:48,280 --> 00:09:53,920
事实上，我们在这里添加了向量。你可以找到顶部的代码是如何
--we do that in a CPU. So effectively, you write a for loop over the other 00:09:53,920 --> 00:09:59,960
我们在 CPU 中执行此操作。如此有效，你在另一个上面写了一个 for 循环
--iteration domains, and then you are just assigning the result of 00:09:59,960 --> 00:10:04,840
迭代域，然后你只是分配的结果
--computation to ci. So if you want to do that on GPU, what you want to do 00:10:04,840 --> 00:10:11,160
计算到 ci。所以如果你想在 GPU 上做那件事，你想做什么
--instead, is that you want to launch as many threads that are equals to the 00:10:11,160 --> 00:10:17,480
相反，您是否希望启动与
--amount of, that's bigger than the amount of element actually than in the 00:10:17,480 --> 00:10:23,440
的数量，这比元素的数量实际比在
--array. Okay, then we're going to do this kind of computation. In here, the 00:10:23,440 --> 00:10:27,880
大批。好，那我们就来做这样的计算。在这里，
--thread index gives you the relative position of a thread within a thread 00:10:27,880 --> 00:10:33,120
线程索引为您提供线程在线程中的相对位置
--block, while the block index gives you a relative position of that particular 00:10:33,120 --> 00:10:38,760
块，而块索引给你一个特定的相对位置
--thread block within a launching grid. And the block index corresponds to the 00:10:38,760 --> 00:10:43,880
启动网格中的线程块。块索引对应于
--number of thread within a thread block. So this computation effectively gives 00:10:43,880 --> 00:10:48,240
线程块中的线程数。所以这个计算有效地给出了
--you the global of that of the of the thread that this particular launching 00:10:48,240 --> 00:10:55,440
你这个特定启动的线程的全局
--thread is in. And here, the code tries to do, effectively computes a global 00:10:55,440 --> 00:11:01,360
线程在。在这里，代码试图做，有效地计算全局
--thread index. And then for each of the threads, it's only doing one computation. So 00:11:01,360 --> 00:11:05,880
线程索引。然后对于每个线程，它只进行一次计算。所以
--if the thread ID is smaller than the number of element, we're just going to 00:11:05,880 --> 00:11:10,760
如果线程 ID 小于元素数，我们将
--perform that one computation, load from A, load from B, do the addition, and then 00:11:10,760 --> 00:11:16,520
执行那个计算，从 A 加载，从 B 加载，做加法，然后
--write the result back on the C. And each of the threads is only going to do that one 00:11:16,520 --> 00:11:22,280
将结果写回 C。每个线程只做那个
--element computation in parallel. So we can also come back to this visualization 00:11:22,320 --> 00:11:27,320
元素并行计算。所以我们也可以回到这个可视化
--that hopefully gives you a better sense of what's going on in here. So let's 00:11:27,320 --> 00:11:32,320
希望能让您更好地了解这里发生的事情。让我们
--assume that we're going to launch, each of thread block contains four threads. 00:11:32,320 --> 00:11:37,360
假设我们要启动，每个线程块包含四个线程。
--And in this case, let's assume that we're going to launch two thread blocks. So in 00:11:37,360 --> 00:11:42,560
在这种情况下，假设我们要启动两个线程块。所以在
--total, there are eight threads in here. And so the block dimension equals 00:11:42,560 --> 00:11:49,880
总共有八个线程。所以块维度等于
--four, because each of the thread block contains four elements. And effectively, 00:11:49,880 --> 00:11:55,120
四、因为每个线程块都包含四个元素。并且有效地，
--we can find that the global of that we have in here, depending on thread index 00:11:55,120 --> 00:11:59,360
我们可以找到我们在这里的全局，这取决于线程索引
--and block index, each of thread is in, you will compute a global index 00:11:59,360 --> 00:12:04,040
和块索引，每个线程都在，你将计算一个全局索引
--that corresponds to 0, 1, 2, 3, 4, 5, 6, 7. So you will get the global index that 00:12:04,040 --> 00:12:09,840
对应于 0、1、2、3、4、5、6、7。因此您将获得全局索引
--corresponds to each of the element in here. And of course, we need to be 00:12:09,840 --> 00:12:14,440
对应于这里的每一个元素。当然，我们需要
--careful so that the number of total threads covers is bigger than the number 00:12:14,480 --> 00:12:19,920
小心，使覆盖的总线程数大于数字
--of elements in here. Let's assume it is the case in this particular example. So 00:12:19,920 --> 00:12:24,880
这里的元素。让我们假设在这个特定示例中就是这种情况。所以
--in here, we can find that each of the threads effectively computes their own 00:12:24,880 --> 00:12:29,200
在这里，我们可以发现每个线程有效地计算自己的
--individual global offset. And that's the only difference between the code that 00:12:29,200 --> 00:12:35,480
单独的全局偏移量。这是代码之间的唯一区别
--we executed on the same or different threads. That's why you can find it's 00:12:35,480 --> 00:12:39,240
我们在相同或不同的线程上执行。这就是为什么你可以找到它
--called single instruction. Effectively, all the threads are launching the same 00:12:39,240 --> 00:12:44,120
称为单指令。实际上，所有线程都启动相同的
--piece of code, except that their environment thread index and block index 00:12:44,120 --> 00:12:49,200
一段代码，除了他们的环境线程索引和块索引
--are going to be different. So as a result, they are executing different code 00:12:49,200 --> 00:12:53,320
会有所不同。因此，他们正在执行不同的代码
--paths in here. And for each of the threads, it's going to load the data from A and B 00:12:53,320 --> 00:12:58,840
路径在这里。对于每个线程，它将从 A 和 B 加载数据
--and store onto C. So you can find that it's got an interesting pattern in here, right? 00:12:58,840 --> 00:13:04,560
然后存储到 C 上。所以你会发现它在这里有一个有趣的模式，对吧？
--So in order to be able to parallelize the original sequential CPU code, 00:13:04,560 --> 00:13:11,400
所以为了能够并行化原始的顺序 CPU 代码，
--what we do is that we are trying to distribute the work of each of the element 00:13:11,800 --> 00:13:16,680
我们所做的是尝试分配每个元素的工作
--computation onto different threads. So each of the threads is doing different tasks. 00:13:16,680 --> 00:13:21,160
计算到不同的线程上。所以每个线程都在做不同的任务。
--And after all the threads finish that work, we get the result of vector add in an 00:13:21,160 --> 00:13:28,680
在所有线程完成该工作后，我们得到 vector add 的结果
--efficient way. On the other hand, I also want us to pause a second. Because right 00:13:28,680 --> 00:13:34,400
有效的方式。另一方面，我也希望我们暂停一下。因为对
--now, what we did is we kind of manually translate a CPU code. That was a 00:13:34,400 --> 00:13:40,600
现在，我们所做的是手动翻译 CPU 代码。那是一个
--sequential code, onto a parallel CUDA code that allows us to be able to run on 00:13:40,640 --> 00:13:46,120
顺序代码，到并行 CUDA 代码上，使我们能够运行
--GPU. It's an actual question to ask, is it possible to translate arbitrary CPU 00:13:46,120 --> 00:13:53,760
显卡。这是一个实际的问题，是否可以翻译任意 CPU
--code onto the CUDA version? If we pause a bit, think about this question. Of 00:13:53,760 --> 00:14:01,960
代码到 CUDA 版本？如果我们停顿一下，想想这个问题。的
--course, it doesn't seem to be so, right? It seems to be some saying there's no 00:14:01,960 --> 00:14:07,040
当然，好像不是这样的吧？好像有人说没有
--pre-launching here. So what happened? What makes this program particularly easy 00:14:07,040 --> 00:14:12,320
在这里预发布。所以发生了什么事？是什么让这个程序特别简单
--to be able to translate onto a GPU program? The reason is that you'll find 00:14:12,320 --> 00:14:18,120
能够转化为 GPU 程序？原因是你会发现
--that when you look at this computation, for each of our eyes, the computation is 00:14:18,120 --> 00:14:23,080
当你看这个计算时，对于我们每一只眼睛来说，计算是
--not dependent on each other, right? So as a result, we will be able to, this is 00:14:23,080 --> 00:14:28,200
不会互相依赖吧？因此，我们将能够，这是
--called a data parallel program, allows us to perform each of element computation 00:14:28,200 --> 00:14:34,520
称为数据并行程序，允许我们执行每个元素计算
--independently. If we have a different kind of program, such a parallelization 00:14:34,520 --> 00:14:39,320
独立地。如果我们有不同类型的程序，例如并行化
--might be harder. For example, if I'm going to write ci equals c maximal of i 00:14:39,320 --> 00:14:48,080
可能更难。例如，如果我要写 ci 等于 c maximal of i
--minus 1, 0 plus ai. In this case, you can find that the result of, and I'm going to 00:14:48,080 --> 00:14:56,400
负 1、0 加 ai。在这种情况下，您可以找到结果，我将
--do for all i's. In this case, you can find that a result of ci is going to be 00:14:56,400 --> 00:15:01,440
尽我所能。在这种情况下，您可以发现 ci 的结果将是
--dependent on a result of a previous element. Of course, there is also a parallel algorithm 00:15:01,440 --> 00:15:06,640
取决于前一个元素的结果。当然还有并行算法
--that does this, called parallel scan. But it's still non-trivial to directly do it 00:15:06,640 --> 00:15:12,200
这样做，称为并行扫描。但直接去做仍然很重要
--using the data parallel computation. So really, in a lot of cases, the ability to 00:15:12,200 --> 00:15:18,000
使用数据并行计算。所以真的，在很多情况下，能够
--parallelize depends on how much independence we have across each element 00:15:18,000 --> 00:15:23,520
并行化取决于我们在每个元素之间有多少独立性
--of computation. Of course, in this case, so far we have only shown the 00:15:23,520 --> 00:15:31,680
的计算。当然，在这种情况下，到目前为止我们只展示了
--GPU side of the code, which is on the top. In order to really go ahead and run this 00:15:31,680 --> 00:15:37,640
代码的 GPU 端，位于顶部。为了真正继续运行这个
--program on my machine, you also need what we call a host side of a code, or a CPU 00:15:37,640 --> 00:15:45,120
在我的机器上编程，你还需要我们所说的代码的主机端，或 CPU
--side of a code, that allows us to be able to launch a kernel. So 00:15:45,120 --> 00:15:50,400
代码的一侧，它使我们能够启动内核。所以
--specifically, in this code, what I try to do is we start with three data, three 00:15:50,680 --> 00:15:57,080
具体来说，在这段代码中，我尝试做的是我们从三个数据开始，三个
--arrays that come from CPU. And then what I'm going to do is I'm going to call 00:15:57,080 --> 00:16:01,200
来自 CPU 的数组。然后我要做的就是打电话
--CUDA allocate. It's going to allocate my data on the GPU DRAM. So if you think 00:16:01,200 --> 00:16:06,920
CUDA 分配。它将在 GPU DRAM 上分配我的数据。所以如果你认为
--about a typical host and a GPU setting, you will have this GPU, this host, and 00:16:06,920 --> 00:16:17,760
关于典型的主机和 GPU 设置，您将拥有这个 GPU、这个主机和
--there's a PCIe bus that connects between them. So when we're trying to call CUDA 00:16:17,920 --> 00:16:23,840
它们之间有一个 PCIe 总线连接。所以当我们尝试调用 CUDA
--alloc, what you are effectively doing is you're allocating memories that points 00:16:23,840 --> 00:16:30,360
 alloc，你实际上在做的是分配指向内存的内存
--to a region on a GPU. So if you simply call CUDA alloc, actually at this point, 00:16:30,360 --> 00:16:34,800
到 GPU 上的一个区域。所以如果你简单地调用 CUDA 分配，实际上在这一点上，
--it will not correspond to any regions on a CPU, unless you use some kind of 00:16:34,800 --> 00:16:39,960
它不会对应于 CPU 上的任何区域，除非你使用某种
--unified memory feature of CUDA programming. So when you call CUDA memory 00:16:39,960 --> 00:16:46,160
CUDA编程的统一内存特性。所以当你调用 CUDA 内存时
--copy, these operations help us to be able to take original memory and copy 00:16:46,160 --> 00:16:53,120
复制，这些操作帮助我们能够获取原始内存并复制
--the data onto the corresponding regions on GPU. So effectively, the original data 00:16:53,120 --> 00:16:59,200
数据到 GPU 上的相应区域。如此有效，原始数据
--sits on a host, and we are going to copy it onto the GPU memory. And then what 00:16:59,200 --> 00:17:05,320
位于主机上，我们将把它复制到 GPU 内存中。然后什么
--you're doing here is we're going to calculate how many thread blocks we need 00:17:05,320 --> 00:17:10,120
你在这里做的是我们要计算我们需要多少线程块
--in order to cover the total number of elements in here, in this number of 00:17:10,400 --> 00:17:14,960
为了覆盖这里的元素总数，在这个数量
--elements. And what I'm going to say is we're going to launch 512 threads per 00:17:14,960 --> 00:17:20,000
元素。我要说的是我们要启动 512 个线程
--block. And imagine that n equals 124. Now we need two blocks to cover this. And 00:17:20,000 --> 00:17:30,160
堵塞。想象一下 n 等于 124。现在我们需要两个块来覆盖它。和
--then we are going to launch a CUDA kernel with so many threads on per block 00:17:30,160 --> 00:17:37,200
然后我们将启动一个 CUDA 内核，每个块上有这么多线程
--and number of blocks by passing in the GPU pointer. This code still runs on the 00:17:37,200 --> 00:17:43,520
和块数通过传入 GPU 指针。这段代码仍然运行在
--host, and then the corresponding GPU code is going to start launching on the 00:17:43,520 --> 00:17:48,600
主机，然后相应的 GPU 代码将开始在主机上启动
--GPU side. Finally, we're going to copy the data from the GPU memory back on the 00:17:48,600 --> 00:17:56,120
GPU 端。最后，我们要将 GPU 内存中的数据复制回
--CPU. And then we'll be able to go and verify the correctness of the C CPU, in 00:17:56,120 --> 00:18:02,400
中央处理器。然后我们就可以去验证 C CPU 的正确性，在
--this case, to see if it really corresponds to the result of the addition. So this 00:18:02,400 --> 00:18:08,240
这种情况，看它是否真的对应加法的结果。所以这
--code kind of demonstrates the entire workflow of GPU computing, right? Because 00:18:08,240 --> 00:18:12,360
代码演示了 GPU 计算的整个工作流程，对吧？因为
--usually the data starts on CPU, you want to allocate memory on the GPU, you copy 00:18:12,360 --> 00:18:17,800
通常数据开始在 CPU 上，你想在 GPU 上分配内存，你复制
--the data from a CPU or GPU, perform some computation and copy it back. On the 00:18:17,800 --> 00:18:23,920
来自 CPU 或 GPU 的数据，执行一些计算并将其复制回来。在
--other hand, this is not really what happened in most of the different 00:18:23,920 --> 00:18:27,960
另一方面，这并不是大多数不同国家发生的事情
--computation. But actually, this was the code that I initially write when I 00:18:27,960 --> 00:18:31,280
计算。但实际上，这是我最初编写的代码
--started learning GPU programming. So to give an anecdote, so when I started 00:18:31,280 --> 00:18:35,560
开始学习GPU编程。讲个轶事，所以当我开始
--working on accelerating differently, the first CUDA acceleration code I wrote is 00:18:35,560 --> 00:18:40,600
致力于不同的加速，我写的第一个 CUDA 加速代码是
--like this. I'm trying to write an accelerated convolution kernel. So what 00:18:40,600 --> 00:18:45,240
像这样。我正在尝试编写加速卷积核。所以呢
--we did is, let's take the data from the CPU arrays, copy it to the GPU, run the 00:18:45,240 --> 00:18:53,600
我们所做的是，让我们从 CPU 阵列中获取数据，将其复制到 GPU，运行
--CUDA-based acceleration and copy it back. But then I found out, hmm, it seems that at 00:18:53,600 --> 00:18:59,800
基于CUDA的加速并复制回来。但是后来我发现，嗯，好像在
--most I can only get about 1.3x speedup versus the FFDW-based CPU 00:18:59,800 --> 00:19:07,200
与基于 FFDW 的 CPU 相比，我最多只能获得大约 1.3 倍的加速
--implementation I had. What happened? It seems that they all told me that GPU is 00:19:07,240 --> 00:19:13,000
我有实施。发生了什么？好像都跟我说GPU是
--very powerful. I shouldn't have only get 1.3x speedup. So then, if you dig 00:19:13,000 --> 00:19:19,720
很强大。我不应该只获得 1.3 倍的加速。那么，如果你挖
--deeper, you'll find that actually the bottleneck of computation is wasted on 00:19:19,720 --> 00:19:24,640
再深入一点，你会发现其实计算的瓶颈是浪费在
--the memory copies in here. Because we're kind of copying the data back and forth 00:19:24,640 --> 00:19:28,880
内存复制在这里。因为我们有点来回复制数据
--from CPU and GPU, and PCIe bus is coming in the bottleneck. So in real world 00:19:28,880 --> 00:19:34,720
从 CPU 和 GPU 来看，PCIe 总线正在进入瓶颈。所以在现实世界中
--examples, most of a CUDA code execution is not going to look like this. Instead, 00:19:34,720 --> 00:19:39,520
例如，大多数 CUDA 代码执行不会像这样。反而，
--we're going to try to allocate the memory on CUDA, on GPU. I want to keep 00:19:39,520 --> 00:19:46,840
我们将尝试在 GPU 上的 CUDA 上分配内存。我想保留
--the data on GPU as much as possible. So if I'm going to run one layout 00:19:46,840 --> 00:19:50,800
GPU 上的数据尽可能多。所以如果我要运行一个布局
--convolution, I'm going to take that input data on GPU, run a convolution result, 00:19:50,800 --> 00:19:55,760
卷积，我将在 GPU 上获取输入数据，运行卷积结果，
--write it on GPU memory, and the second time I'm going to run follow-up 00:19:55,760 --> 00:20:00,280
写在GPU显存上，第二次跑follow-up
--computations. So rather than other cases, I'm going to directly load the data 00:20:00,280 --> 00:20:04,320
计算。所以我将直接加载数据而不是其他情况
--from the GPU memory and run computations. It seems to be so obvious today, but 00:20:04,400 --> 00:20:09,400
从 GPU 内存和运行计算。今天看来很明显，但是
--that was kind of a mistake that I made when we started to work on GPU 00:20:09,400 --> 00:20:13,800
这是我在开始使用 GPU 时犯的错误
--computation. So real-world applications really try to keep data in GPU memory as 00:20:13,800 --> 00:20:19,520
计算。所以现实世界的应用程序真的试图将数据保存在 GPU 内存中
--long as possible. That's why when you start to look at, when you start to 00:20:19,520 --> 00:20:25,560
尽可能长。这就是为什么当你开始看，当你开始
--write code, like PyTorch or Needle even, when you start to write computations, 00:20:25,560 --> 00:20:29,240
当您开始编写计算时，甚至编写代码，例如 PyTorch 或 Needle，
--you wouldn't call .numPy as often, because .numPy will bring that data 00:20:29,240 --> 00:20:33,480
您不会经常调用 .numPy，因为 .numPy 会带来该数据
--back on the CPU and convert that onto a .numPy array. Instead, you would directly run 00:20:33,600 --> 00:20:39,120
返回 CPU 并将其转换为 .numPy 数组。相反，你会直接运行
--computations on the GPU arrays, array pointers, and so one computing 00:20:39,120 --> 00:20:44,840
GPU 数组、数组指针等计算
--for another, they all simply perform GPU kernels and loads from GPU array and 00:20:44,840 --> 00:20:50,640
另一方面，它们都只是简单地执行 GPU 内核并从 GPU 阵列加载和
--writes onto the corresponding GPU array. So this is an example programming model, 00:20:50,640 --> 00:20:57,440
写入相应的 GPU 阵列。所以这是一个示例编程模型，
--CUDA. However, as I told everybody, there are other GPU 00:20:57,440 --> 00:21:04,120
 CUDA。但是，正如我告诉大家的，还有其他 GPU
--programming models. For example, here are two examples of other GPU programming models. On top 00:21:04,120 --> 00:21:09,760
编程模型。例如，这里有两个其他 GPU 编程模型的例子。在上面
--is the OpenCL programming model that's being used for ARM GPUs, and the bottom 00:21:09,760 --> 00:21:15,520
是用于 ARM GPU 的 OpenCL 编程模型，底部
--is a programming model called Metal that is being used on Apple devices. In both 00:21:15,520 --> 00:21:21,640
是一种称为 Metal 的编程模型，正在 Apple 设备上使用。同时
--cases, you can find that there is a very similar correspondence, for example, 00:21:21,640 --> 00:21:25,920
案例，你可以发现有一个非常相似的对应关系，例如，
--except a slightly different keyword. You'll get both A, B, and C. 00:21:26,560 --> 00:21:31,800
除了一个稍微不同的关键字。您将同时获得 A、B 和 C。
--For example, in Metal, there are buffer annotations. In OpenCL, it's called global. 00:21:31,800 --> 00:21:36,040
例如，在 Metal 中，有缓冲区注释。在 OpenCL 中，它被称为全局。
--In OpenCL, there's a global ID that indicates a global thread index. 00:21:36,040 --> 00:21:41,600
在 OpenCL 中，有一个全局 ID 表示全局线程索引。
--Similarly, there is a global ID in the Metal programming model. And in a lot of 00:21:41,600 --> 00:21:48,040
同样，在 Metal 编程模型中也有一个全局 ID。而且在很多
--cases, you will be able to find almost one-to-one translation 00:21:48,040 --> 00:21:52,000
案例，你几乎可以找到一对一的翻译
--correspondence by taking one GPU programming model and manually translate 00:21:52,000 --> 00:21:57,640
通过采用一个 GPU 编程模型并手动翻译对应关系
--to another one. They're not really that different. So that's why a lot 00:21:57,640 --> 00:22:01,040
到另一个。他们并没有那么不同。所以这就是为什么很多
--of the concepts you learn in one case, it's going to be applicable in other 00:22:01,040 --> 00:22:05,400
您在一种情况下学到的概念，将适用于其他情况
--cases as well. So now we've taken a look at the first taste of GPU programming. 00:22:05,400 --> 00:22:16,160
案件也是如此。现在我们已经初步了解了 GPU 编程。
--Let's start to try to dive slightly deeper onto some of the details in here. 00:22:16,160 --> 00:22:21,760
让我们开始尝试更深入地了解这里的一些细节。
--In this particular case, let's come back to what we call a GPU memory hierarchy. 00:22:21,760 --> 00:22:31,520
在这种特殊情况下，让我们回到所谓的 GPU 内存层次结构。
--We know that GPU contains two levels of threading hierarchies. You have 00:22:31,520 --> 00:22:36,160
我们知道 GPU 包含两级线程层次结构。你有
--threads, and those threads form thread blocks. That gives you a launching grade 00:22:36,160 --> 00:22:41,040
线程，这些线程形成线程块。这给了你一个启动等级
--that you launch together. On the other hand, up until now, we have not made use of that 00:22:41,200 --> 00:22:48,640
你们一起发射。另一方面，到目前为止，我们还没有利用它
--factor. All we did so far is, I'm going to find a global index of a GPU thread ID. 00:22:48,640 --> 00:22:55,360
因素。到目前为止我们所做的就是，我将找到一个 GPU 线程 ID 的全局索引。
--I'm going to use that global index to run computations of different elements of a 00:22:55,360 --> 00:22:59,600
我将使用该全局索引来运行 a 的不同元素的计算
--array. But let's come back to this, and let's start to try to think about 00:22:59,600 --> 00:23:09,440
大批。但让我们回到这个问题，让我们开始尝试思考
--additional elements that we will need to use of this multiple level of hierarchies. 00:23:09,440 --> 00:23:15,840
我们需要使用这种多层层次结构的其他元素。
--Specifically, the reason why we need this two-level threading structure is because 00:23:15,840 --> 00:23:22,080
具体来说，我们之所以需要这种二级线程结构是因为
--GPU in nature kind of contains this two-level threading structure. 00:23:22,080 --> 00:23:26,240
GPU 本质上包含这种两级线程结构。
--Within a GPU, each of the blocks can be mapped onto what we call stream multiple 00:23:26,240 --> 00:23:32,720
在 GPU 中，每个块都可以映射到我们所说的多流
--processors that contains multiple computing cores. Effectively, each of the thread blocks can 00:23:32,720 --> 00:23:42,240
包含多个计算核心的处理器。实际上，每个线程块都可以
--get mapped onto one stream multiple processors. In a lot of cases, you can even map several 00:23:42,240 --> 00:23:49,040
被映射到一个流的多个处理器上。在很多情况下，您甚至可以映射多个
--thread blocks onto the same stream multiple processors. Then, each of the threads will get 00:23:49,040 --> 00:23:56,080
线程阻塞到同一流的多个处理器上。然后，每个线程都会得到
--mapped onto what we call a single computing core within that stream multiple processors. 00:23:56,080 --> 00:24:02,160
映射到我们所说的流多个处理器中的单个计算核心。
--So you can find that that's kind of why we have this two-level hierarchy, because 00:24:03,680 --> 00:24:08,000
所以你会发现这就是我们有这种两级层次结构的原因，因为
--we'll come back and look at the GPU themselves. A lot of GPU architectures themselves contain 00:24:08,000 --> 00:24:14,160
我们会回头看看 GPU 本身。很多GPU架构本身包含
--this two-level hierarchy. The global memory here corresponds to the GPU memory. So that's 00:24:14,160 --> 00:24:21,040
这种两级层次结构。这里的全局内存对应GPU内存。所以那是
--the memory you get when you call CUDA malloc and CUDA free, and your free call CUDA free. 00:24:21,040 --> 00:24:26,560
调用 CUDA malloc 和 CUDA free 时获得的内存，以及 free call CUDA free。
--Within a stream multiple processors, though, there's a shared memory that's being shared 00:24:27,120 --> 00:24:32,160
但是，在一个流的多个处理器中，有一个正在共享的共享内存
--across all the threads. So this is the memory that's accessible by all the threads within 00:24:32,160 --> 00:24:37,840
跨所有线程。所以这是内部所有线程都可以访问的内存
--that thread blocks. And this is what we're going to focus on next. And of course, each 00:24:37,840 --> 00:24:42,480
该线程块。这就是我们接下来要关注的。当然，每个
--of the threads have their own local registers as well. So let's take a look at another example, 00:24:42,480 --> 00:24:48,960
的线程也有自己的本地寄存器。那么让我们来看另一个例子，
--a slightly more complicated one. Let's assume that we want to perform a summation 00:24:49,440 --> 00:24:55,600
一个稍微复杂一点的。假设我们要执行求和
--of a window of size 5 in here. So in fact, we are going to do sliding window. We are sliding 00:24:56,240 --> 00:25:00,800
这里有一个大小为 5 的窗口。所以实际上，我们要做滑动窗口。我们在滑动
--the window from left to right. And each of the time, we're going to sum, for example, in here, 00:25:00,800 --> 00:25:07,200
从左到右的窗口。每一次，我们都会总结，例如，在这里，
--I'm going to sum the five elements together. So you can view this window sum as a simplified 00:25:07,200 --> 00:25:14,560
我要把这五个要素加在一起。所以你可以把这个窗口总和看成一个简化的
--version of, for example, convolution. So because it's like a one-dimensional 00:25:14,560 --> 00:25:19,440
例如，卷积的版本。所以因为它就像一个一维的
--convolution with a filter of all ones in here. So the most straightforward implementation we 00:25:19,440 --> 00:25:29,600
与此处的所有过滤器进行卷积。所以我们最直接的实现
--can have is, of course, let's try to distribute all the output elements onto different threads. 00:25:29,600 --> 00:25:35,440
可以有，当然，让我们尝试将所有输出元素分布到不同的线程上。
--So I'm going to launch a GPU kernel that covers each of the element. And then for each element, 00:25:35,440 --> 00:25:41,600
所以我将推出一个涵盖每个元素的 GPU 内核。然后对于每个元素，
--I'm going to perform the sum in here. However, one thing you might notice that this is 00:25:41,600 --> 00:25:48,960
我要在这里进行求和。但是，您可能会注意到，这是
--not the most efficient way of implementing this window. Specifically, let's think about how many 00:25:48,960 --> 00:25:57,040
不是实现此窗口的最有效方法。具体来说，我们想想有多少
--loads we need to load the inputs. For example, for each element in here, I need to be able to load 00:25:57,040 --> 00:26:02,400
loads 我们需要加载输入。例如，对于这里的每个元素，我需要能够加载
--five input elements. So in total, I need to do five times unloading to perform this vanilla 00:26:02,400 --> 00:26:13,040
五个输入元素。所以总的来说，我需要做五次卸载来执行这个香草
--window sum. So what we can do instead is that let's sort of consider a thread block of four 00:26:13,040 --> 00:26:23,600
窗口总和所以我们可以做的是让我们考虑一个由四个线程组成的块
--threads. In this case, if you look at this thread block of four threads, in total, they only have 00:26:23,600 --> 00:26:30,880
线程。在这种情况下，如果您查看四个线程的线程块，它们总共只有
--to load, let's say, eight elements. So you can find that there are a lot of overlaps in their 00:26:30,880 --> 00:26:40,640
加载，比方说，八个元素。所以你可以发现他们有很多重合的地方
--loading. For example, this thread is going to load this piece of element. And this thread is going to 00:26:40,640 --> 00:26:45,760
加载。例如，这个线程要加载这个元素。这个线程将要
--load this piece of element. You can find there are a lot of loading overlap between those threads. 00:26:45,760 --> 00:26:52,240
加载这块元素。您会发现这些线程之间有很多加载重叠。
--And that's where a shared memory is going to become helpful. So the idea here is that, 00:26:52,240 --> 00:26:58,480
这就是共享内存将变得有用的地方。所以这里的想法是，
--first of all, we're going to allocate a temporal shared memory that allows us to fetch 00:26:59,040 --> 00:27:10,320
首先，我们要分配一个临时共享内存，允许我们获取
--these temporal inputs here in the green area. And then we'll have all the threads. We'll try 00:27:10,320 --> 00:27:18,240
这些时间输入在绿色区域。然后我们将拥有所有线程。我们会尝试
--to cooperatively fetch the data onto the shared memory. So in this case, for example, we could 00:27:18,240 --> 00:27:25,120
以协作方式将数据提取到共享内存中。所以在这种情况下，例如，我们可以
--have the first four threads fetch the first four elements, and then have them also fetch the other 00:27:25,120 --> 00:27:30,480
让前四个线程获取前四个元素，然后让它们也获取另一个
--four elements. So in total, each of the threads only have to fetch two elements, as opposed to 00:27:30,480 --> 00:27:35,360
四个要素。所以总的来说，每个线程只需要获取两个元素，而不是
--five elements. So in terms of the number of pre-card loads we see, we save 2 over 5. 00:27:35,360 --> 00:27:43,840
五个要素。因此，就我们看到的预卡加载数量而言，我们比 5 节省了 2。
--That's a 2 over 5 memory load savings. Now if we load the data onto shared memory, 00:27:45,600 --> 00:27:51,600
这是 2 超过 5 的内存负载节省。现在，如果我们将数据加载到共享内存中，
--what we're going to do is call synchronized threads. So this is a function that allows 00:27:51,600 --> 00:27:55,920
我们要做的是调用同步线程。所以这是一个允许
--all the threads to wait, pause a bit, so that we'll allow all the threads to finish. 00:27:55,920 --> 00:28:01,200
所有线程等待，暂停一下，这样我们就可以让所有线程完成。
--And after synced threads finishes, we know that the temporal memory in here already stores the 00:28:02,000 --> 00:28:07,920
在同步线程完成后，我们知道这里的临时内存已经存储了
--data being loaded by all the threads. For that, we can then go ahead and perform 00:28:08,640 --> 00:28:14,320
所有线程正在加载的数据。为此，我们可以继续执行
--the four-loop summations that sums over all the result elements. 00:28:14,960 --> 00:28:20,080
对所有结果元素求和的四循环求和。
--So in this code example, you can find that one of the key advantages we are trying to 00:28:26,800 --> 00:28:31,440
因此，在此代码示例中，您可以发现我们正在尝试的关键优势之一
--get in here is we are trying to leverage the shared memory. And there are memory loading 00:28:32,160 --> 00:28:36,800
进入这里是我们正在尝试利用共享内存。还有内存加载
--reuse between the threads. So we are using the shared memory to store the temporal result. 00:28:36,800 --> 00:28:42,880
线程间复用。所以我们使用共享内存来存储时间结果。
--And then loading from that shared memory to allow us to do our further computations. 00:28:43,440 --> 00:28:48,720
然后从该共享内存加载以允许我们进行进一步的计算。
--And this is a very common technique that's being used in GPU acceleration. 00:28:48,720 --> 00:28:53,280
这是 GPU 加速中使用的一种非常常见的技术。
--So in the first part, we have two high-level takeaways. So the first high-level takeaway is 00:28:58,000 --> 00:29:02,960
所以在第一部分，我们有两个高层次的要点。所以第一个高层次的外卖是
--that the GPU program model fits in this two-level thread hierarchy. We have a launching thread, 00:29:02,960 --> 00:29:08,480
GPU 程序模型适合这种两级线程层次结构。我们有一个启动线程，
--grids and blocks. And then in order for us to be able to make use of shared memory, 00:29:08,480 --> 00:29:14,240
网格和块。然后为了让我们能够使用共享内存，
--you want to be able to cooperatively fetch common areas, common data to the shared memory 00:29:14,240 --> 00:29:19,840
你希望能够协作获取公共区域，公共数据到共享内存
--to help us to increase the memory reuse across different threads. 00:29:19,840 --> 00:29:24,080
帮助我们增加跨不同线程的内存重用。
--Now we have finished discussing the general GPU programming technique. 00:29:26,400 --> 00:29:31,600
现在我们已经讨论完了一般的 GPU 编程技术。
--Let's come back and do a case study on matrix modifications on GPU. 00:29:32,160 --> 00:29:36,640
让我们回过头来做一个关于 GPU 上矩阵修改的案例研究。
--So again, let's start to look at a transposed matrix modification. In this case, 00:29:38,960 --> 00:29:43,840
因此，让我们再次开始研究转置矩阵修改。在这种情况下，
--let's look at the code of Cij equals sum k Aki times Bkj. So we are transporting A in this case. 00:29:45,440 --> 00:30:00,560
让我们看一下 Cij 等于和 k Aki 乘以 Bkj 的代码。所以我们在这种情况下运输 A。
--And there are techniques that we learned from the last lecture that's still going on. 00:30:02,560 --> 00:30:07,040
我们从上一节课中学到的一些技巧仍在继续。
--That's still going to be useful in here. That's what we'll call register tiling. 00:30:08,000 --> 00:30:12,080
这在这里仍然有用。这就是我们所说的寄存器平铺。
--So what we're trying to do is, first of all, we're going to allocate a submatrix V by V, 00:30:12,080 --> 00:30:19,760
所以我们要做的是，首先，我们将通过 V 分配一个子矩阵 V，
--where V is kind of a tiling factor we have in here. And then we're going to also allocate 00:30:19,760 --> 00:30:25,760
其中 V 是我们这里的一种平铺因子。然后我们还要分配
--two temporal inputs, Av and Bv. By the way, the Cab, they will be mapped on to the GPU registers. 00:30:27,840 --> 00:30:36,560
两个时间输入，Av 和 Bv。顺便说一句，Cab，它们将被映射到 GPU 寄存器上。
--And that is kind of the most efficient storage you can get on GPUs. 00:30:37,280 --> 00:30:41,760
这是您可以在 GPU 上获得的最高效的存储。
--Then what we're going to do is, for each of iterations, we are going to load a stripe of this 00:30:43,440 --> 00:30:49,440
然后我们要做的是，对于每次迭代，我们将加载一条这样的
--input data from both A and B. And then we're going to do this inner dot product, outer product 00:30:50,560 --> 00:30:57,360
输入来自 A 和 B 的数据。然后我们要做这个内点积，外积
--operation by just looping over x and y and doing Cyx plus equal Ay times Bx. And this code, 00:30:57,360 --> 00:31:05,920
通过循环 x 和 y 并执行 Cyx 加上等于 Ay 乘以 Bx 来进行操作。而这段代码，
--this principle actually will get unrolled so that they become effectively the register 00:31:05,920 --> 00:31:11,360
这个原则实际上将得到展开，以便它们成为有效的寄存器
--multiply add code. And after we perform these operations, we're going to store 00:31:11,360 --> 00:31:16,720
乘以添加代码。在我们执行这些操作之后，我们要存储
--the data back onto the corresponding memory regions that we're interested in. 00:31:17,680 --> 00:31:22,080
数据返回到我们感兴趣的相应内存区域。
--So this is called register-level tiling. And if you remember from our last lecture, 00:31:23,440 --> 00:31:28,000
所以这被称为寄存器级平铺。如果你还记得我们上次的讲座，
--we know that by tiling A and B by a factor of V. So each of our term, 00:31:28,720 --> 00:31:36,800
我们知道通过将 A 和 B 平铺 V 的一个因子。所以我们的每一项，
--each element of A is going to be reused by V terms. So the total number of memory loads 00:31:38,160 --> 00:31:44,160
 A 的每个元素都将被 V 术语重用。所以总的内存加载次数
--is going to be n cubed divided by V for each of those threads. So as a result, 00:31:44,160 --> 00:31:50,400
对于这些线程中的每一个，将被 n 的立方除以 V。所以结果，
--you get more memory reuse, and it gives you the ability to be able to speed up your computation 00:31:50,400 --> 00:31:55,600
你得到更多的内存重用，它让你能够加速你的计算
--so that memory don't become a bottleneck. If you are interested, I would certainly 00:31:55,680 --> 00:31:59,920
这样内存就不会成为瓶颈。如果你有兴趣，我当然会
--recommend you to go ahead and try to write a CUDA program like this and get a feeling of 00:31:59,920 --> 00:32:05,360
建议您继续尝试编写这样的 CUDA 程序并感受一下
--what kind of acceleration you can get by just tiling over the register factors. 00:32:06,080 --> 00:32:12,560
通过平铺寄存器因子可以获得什么样的加速。
--Of course, because the GPU memory contains this kind of two-level memory hierarchy, 00:32:14,880 --> 00:32:20,640
当然，由于GPU内存包含这种两级内存层次结构，
--so not only we can get reuse through the same threads by using register tilings, 00:32:20,640 --> 00:32:27,760
所以我们不仅可以通过使用寄存器平铺通过相同的线程获得重用，
--we can also try to get reuse across the thread within the thread block. 00:32:27,760 --> 00:32:31,280
我们还可以尝试在线程块中跨线程重用。
--That's where the shared memory fits in. So the second level of tiling 00:32:31,840 --> 00:32:37,600
这就是共享内存的用武之地。所以第二层平铺
--that we can perform here is what we call shared memory tiling. 00:32:38,400 --> 00:32:41,920
我们可以在这里执行的就是我们所说的共享内存平铺。
--So in this case, let's assume that we are going to do a L by L 00:32:44,480 --> 00:32:48,560
所以在这种情况下，让我们假设我们要通过 L 做一个 L
--submatrix. Each of our thread block is going to do an L by L submatrix computation. 00:32:51,200 --> 00:32:55,680
子矩阵。我们的每个线程块都将执行 L × L 子矩阵计算。
--And of course, each of the threads still performs V by V computation. So we are going to launch 00:32:56,320 --> 00:33:01,040
当然，每个线程仍然执行 V 乘 V 计算。所以我们要推出
--L by L divided by V times L over V threads per thread block. In this case, we are going to 00:33:01,600 --> 00:33:08,720
在每个线程块的 V 个线程上，L 除以 L 除以 V 乘以 L。在这种情况下，我们将
--leverage what we call multidimensional thread launch. So there will be a block index is 00:33:08,720 --> 00:33:13,440
利用我们所说的多维线程启动。所以会有一个块索引是
--two-dimensional, and a thread index is also two-dimensional. We can easily translate a 00:33:13,440 --> 00:33:18,640
二维的，线程索引也是二维的。我们可以很容易地翻译一个
--one-dimensional thread block onto multidimensional by just doing modular divisions of the corresponding 00:33:18,640 --> 00:33:24,400
只需对相应的模块进行模块化划分，即可将一维线程块转换为多维
--thread index and so on. But let's come back and take a look at this. Let's assume that each of 00:33:24,400 --> 00:33:30,880
线程索引等。但是，让我们回头看看这个。让我们假设每个
--the thread blocks compute this bigger region, and each of the threads compute this smaller region. 00:33:30,880 --> 00:33:36,240
线程块计算这个更大的区域，每个线程计算这个更小的区域。
--If we look at the code, the data that needs to be computed, the region that needs to be computed 00:33:37,360 --> 00:33:41,920
如果我们看代码，需要计算的数据，需要计算的区域
--by the first thread, you'll find that it's going to need this region of A and this region of B. 00:33:41,920 --> 00:33:49,040
通过第一个线程，你会发现它需要 A 的这个区域和 B 的这个区域。
--If I want to go ahead and compute the data needed by this thread block, this thread, 00:33:50,000 --> 00:33:56,640
如果我想继续计算这个线程块所需的数据，这个线程，
--which is another thread, it's going to need the same piece of memory by A. You can find that, hey, 00:33:56,640 --> 00:34:02,640
这是另一个线程，它需要 A 的同一块内存。你会发现，嘿，
--these threads have reuse across each other. So that's why it's helpful to be able to load in 00:34:03,200 --> 00:34:08,640
这些线程相互重用。所以这就是为什么能够加载是有帮助的
--this S by L memory regions onto the shared memory so that we'll be able to leverage those S by L 00:34:09,360 --> 00:34:18,880
将这个 S×L 的内存区域放到共享内存上，这样我们就可以利用这些 S×L
--regions, and then loading data from those shared memory onto the local GPU computing 00:34:18,880 --> 00:34:25,600
区域，然后将数据从这些共享内存加载到本地 GPU 计算
--cores to run for the computation. So in here, what we do is we will try to first allocate 00:34:25,600 --> 00:34:33,600
运行计算的核心。所以在这里，我们要做的是首先尝试分配
--shared memory of S by L, where the S is kind of driving the tiling factor we had on reduction 00:34:34,320 --> 00:34:43,520
L 共享 S 的内存，其中 S 是一种驱动我们在减少时使用的平铺因子
--dimension. Sometimes it's useful to look at loop powerings and sometimes transposition. 00:34:43,520 --> 00:34:50,560
方面。有时查看循环供电和有时移调很有用。
--So what you do is that we are going to first iterate over the reduction dimension. In each 00:34:51,280 --> 00:35:00,080
所以你要做的是我们将首先迭代缩减维度。每一个
--of the case, we want to be able to fetch the corresponding data first onto the shared memory. 00:35:00,080 --> 00:35:05,040
在这种情况下，我们希望能够首先将相应的数据提取到共享内存中。
--And we know that they are reused across those threads. So let's first have those threads 00:35:05,920 --> 00:35:10,160
我们知道它们在这些线程中被重用。因此，让我们首先拥有这些线程
--working together to fetch the data on the shared memory. And then after we get the data onto the 00:35:10,160 --> 00:35:15,280
一起工作以获取共享内存上的数据。然后在我们把数据放到
--shared memory, what we do next, I'm going to do inner iterations, loading the data from a shared 00:35:15,280 --> 00:35:21,200
共享内存，我们接下来要做的，我要做内部迭代，从共享内存加载数据
--memory, and do the register tile matrix multiplication here. And finally, after we 00:35:21,200 --> 00:35:27,920
内存，并在此处进行寄存器瓦片矩阵乘法。最后，在我们之后
--finish the computation, we're going to write the data back on the global memory, as usual. 00:35:27,920 --> 00:35:32,960
完成计算，我们将像往常一样将数据写回全局内存。
--So if you look at this particular piece of code, you can find that there are two kinds of memory 00:35:36,000 --> 00:35:41,280
所以如果你看这段特殊的代码，你会发现有两种内存
--reuse you're getting here. The first memory reuse is shared memory prefetching. And because 00:35:41,280 --> 00:35:47,920
重用你来到这里。第一个内存重用是共享内存预取。而且因为
--we are doing global to shared memory copying, in this case, 00:35:49,840 --> 00:35:52,800
我们正在进行全局到共享内存的复制，在这种情况下，
--we're getting L amount of reuse, depending on the L tiling factor. And then there's also 00:35:53,600 --> 00:35:58,880
根据 L 平铺因子，我们得到了 L 次重用。然后还有
--shared memory to register reuse. Because you get registered tiling factor of V, 00:35:58,880 --> 00:36:04,640
共享内存注册重用。因为你得到了 V 的注册平铺因子，
--you simply get a V reuses across those elements. So by choosing the L and V carefully, 00:36:05,200 --> 00:36:13,040
您只需在这些元素之间获得 V 重用。所以通过仔细选择 L 和 V，
--we will be able to get a quite efficient GPU implementation. Of course, it's not going to 00:36:13,840 --> 00:36:21,600
我们将能够获得非常高效的 GPU 实现。当然，它不会
--be the most efficient one, but you will be able to get, I think, at least 20% or 40% 00:36:21,600 --> 00:36:26,400
是最有效率的，但我认为你将能够获得至少 20% 或 40%
--utilizations of a GPU cost through this two-level of register tiling. 00:36:26,400 --> 00:36:33,040
通过这两个级别的寄存器平铺来利用 GPU 成本。
--Of course, one of the key questions that one might ask is, how can we go ahead and choose 00:36:34,720 --> 00:36:41,600
当然，人们可能会问的关键问题之一是，我们如何才能继续选择
--the values of L and V? So on a CPU, it's already kind of complicated. You need to go ahead and 00:36:41,600 --> 00:36:48,800
L和V的值？所以在 CPU 上，它已经有点复杂了。你需要继续前进
--think about, on a CPU, I will need to be able to make sure that I pick the bigger amount of V 00:36:48,800 --> 00:36:55,200
想一想，在 CPU 上，我需要能够确保选择更大数量的 V
--so that I will make use of all registers, but not exceeding the total amount of register I have. 00:36:55,840 --> 00:37:04,640
这样我就可以使用所有寄存器，但不会超过我拥有的寄存器总量。
--On GPU, it's even more complicated, because there's a trade-off among the number of registers 00:37:06,640 --> 00:37:12,240
在 GPU 上，它甚至更复杂，因为寄存器数量之间存在权衡
--you have in each of the threads, the number of threads you are able to launch. Because 00:37:12,240 --> 00:37:17,760
您在每个线程中都有，您可以启动的线程数。因为
--the total amount of registers on each of the stream processes, stream-wide processes, 00:37:17,760 --> 00:37:22,480
每个流进程、流范围进程的寄存器总数，
--is a constant factor. That means that we can no longer, if we want to launch a thread with 00:37:22,480 --> 00:37:28,160
是一个常数因子。这意味着我们不能再，如果我们想启动一个线程
--more registers, we're going to only be able to launch fewer threads. And if you're going to 00:37:28,160 --> 00:37:34,640
更多的寄存器，我们将只能启动更少的线程。如果你要
--launch fewer threads in total, one of the problems is that we get less power. So when I start to look 00:37:34,640 --> 00:37:41,440
总共启动更少的线程，问题之一是我们获得的功率更少。所以当我开始寻找
--at code like this, when I'm doing memory fetching, actually, shared memory fetching is slow. So 00:37:41,440 --> 00:37:46,400
在这样的代码中，当我进行内存获取时，实际上，共享内存获取很慢。所以
--one of the things that GPU helps you to do is, if I'm waiting for the memory loads in here, 00:37:47,040 --> 00:37:54,160
GPU 可以帮助你做的一件事是，如果我在这里等待内存加载，
--and there are other idle threads that can come and run computations, what is going to happen 00:37:54,160 --> 00:37:59,600
并且还有其他空闲线程可以运行计算，将会发生什么
--is it's going to context switch to other threads that runs follow-up computations. So in this case, 00:37:59,600 --> 00:38:09,600
它是否会上下文切换到运行后续计算的其他线程。所以在这种情况下，
--in a lot of cases, they will be able to have the data loading and computation run concurrently, 00:38:10,240 --> 00:38:17,040
在很多情况下，他们将能够同时运行数据加载和计算，
--if you have a sufficient amount of threads. Because some of the threads are going to load 00:38:17,040 --> 00:38:19,760
如果您有足够数量的线程。因为一些线程要加载
--the data, so they're going to wait for the data, and you'll context switch to other threads that 00:38:19,760 --> 00:38:23,920
数据，所以他们将等待数据，你将上下文切换到其他线程
--run the computation. But that really depends on if you have a sufficiently large amount of threads. 00:38:23,920 --> 00:38:29,120
运行计算。但这实际上取决于您是否有足够多的线程。
--So that's one trade-off between having more threads versus having less threads, 00:38:29,120 --> 00:38:34,880
所以这是拥有更多线程与拥有更少线程之间的一种权衡，
--but each of the threads making use of more registers. There's also a similar kind of trade-off 00:38:34,880 --> 00:38:41,440
但是每个线程都使用更多的寄存器。还有一种类似的权衡
--in terms of the size of shared memory you can pick. Of course, on one hand, we want to be able 00:38:41,440 --> 00:38:46,160
根据您可以选择的共享内存的大小。当然，一方面，我们希望能够
--to pick a bigger amount of shared memory. But on the other hand, if you have a bigger amount of 00:38:46,160 --> 00:38:50,960
选择更大数量的共享内存。但另一方面，如果你有更多的
--shared memory, there are fewer thread blocks you can fit onto the same stream-multiple processors. 00:38:50,960 --> 00:38:57,600
共享内存，可以安装到同一个流多处理器上的线程块更少。
--And as a result, if one of the thread blocks, in this case, is stored, you don't have other thread 00:38:57,600 --> 00:39:03,120
因此，如果其中一个线程块（在这种情况下）被存储，则您没有其他线程
--blocks to context switch into. So again, that's a very delicate trade-off here. 00:39:03,120 --> 00:39:07,200
上下文切换到的块。所以，这又是一个非常微妙的权衡。
--So when we are trying to go and pick, for example, the values of S, L, and V, 00:39:08,160 --> 00:39:12,640
因此，当我们尝试去选择 S、L 和 V 的值时，
--it is something that is being affected by a lot of factors. One of the ways that people do is 00:39:13,520 --> 00:39:20,720
它受到很多因素的影响。人们做的一种方式是
--people can use what are technical auto-tuning. So the idea is you come out and try out different 00:39:20,720 --> 00:39:26,240
人们可以使用什么是技术自动调整。所以这个想法是你出来尝试不同的
--values of S, L, and V, and see what are the results. And we're going to go ahead and pick 00:39:26,240 --> 00:39:36,400
S、L 和 V 的值，看看结果是什么。我们将继续选择
--a reasonable one based on the auto-tuning results. So that's one typical approach that people 00:39:36,400 --> 00:39:42,560
一个基于自动调整结果的合理的。所以这是人们的一种典型方法
--come and do it. Of course, if you want to do more careful analysis, maybe you will be able to come 00:39:42,560 --> 00:39:48,080
来做吧。当然，如果你想做更仔细的分析，也许你就能来
--with analytical solutions for some of the large cases as well. But in general, it's good to keep 00:39:48,080 --> 00:39:53,280
以及一些大案例的分析解决方案。但总的来说，保留是好的
--in mind that there are a lot of big factors that come into play when looking at the GPU code 00:39:53,280 --> 00:40:00,960
请记住，在查看 GPU 代码时，有很多重要因素会发挥作用
--executions. On the other hand, memory use is, again, a very important factor in here. In this 00:40:00,960 --> 00:40:08,080
处决。另一方面，内存使用在这里又是一个非常重要的因素。在这个
--case, there are both memory use within the same thread and memory use across different threads 00:40:08,080 --> 00:40:14,640
情况下，既有同一线程内的内存使用，也有跨不同线程的内存使用
--on a single GPU block. So far, we have just written this as A equals A computation. 00:40:14,640 --> 00:40:24,240
在单个 GPU 块上。到目前为止，我们只是将其写为 A 等于 A 计算。
--It's the same pseudocode. Effectively, in order to do that, we still need to be able to 00:40:25,440 --> 00:40:30,560
这是相同的伪代码。实际上，为了做到这一点，我们仍然需要能够
--cooperatively fetch all the data of the corresponding regions. So effectively, 00:40:30,560 --> 00:40:37,920
协同获取相应区域的所有数据。如此有效，
--this code is going to be expanded onto the code below. That's going to iterate over 00:40:37,920 --> 00:40:43,840
此代码将扩展到下面的代码中。这将迭代
--the elements, and we're going to divide the entire workload onto the work done by each of the threads 00:40:47,600 --> 00:40:54,080
元素，我们将把整个工作负载分配给每个线程完成的工作
--in here. So each of the fetching here is going to correspond to a cooperative fetching 00:40:54,080 --> 00:41:00,080
在这里。所以这里的每一个抓取都会对应一个协同抓取
--among multiple threads, where each of the threads is going to perform one part of the job. 00:41:00,080 --> 00:41:04,560
在多个线程中，每个线程将执行作业的一部分。
--One of the things you want to notice here is that in the cooperative fetching, 00:41:05,440 --> 00:41:08,480
这里你要注意的一件事是，在合作抓取中，
--the fetching job that thread A did may try to fetch the data that's also needed by another 00:41:10,560 --> 00:41:17,280
线程 A 执行的获取作业可能会尝试获取另一个线程也需要的数据
--thread. So that's why it's called cooperative fetching, because each of the threads is going 00:41:17,280 --> 00:41:21,600
线。这就是为什么它被称为协同抓取，因为每个线程都在进行
--to do their own local jobs, and they collectively fulfill the task of fetching the data onto the 00:41:21,600 --> 00:41:27,280
做他们自己的本地工作，他们共同完成将数据提取到
--corresponding GPU shared memory region. So far, we have covered two use cases. We covered 00:41:27,280 --> 00:41:39,760
相应的 GPU 共享内存区域。到目前为止，我们已经涵盖了两个用例。我们涵盖了
--the simple basic GPU programming models and how we can come and program a GPU. 00:41:42,800 --> 00:41:48,000
简单的基本 GPU 编程模型以及我们如何对 GPU 进行编程。
--We also covered how we can use those techniques, such as shared memory reloading and GPU parallelism 00:41:48,720 --> 00:41:56,640
我们还介绍了如何使用这些技术，例如共享内存重新加载和 GPU 并行性
--to accelerate matrix notifications. There are a lot more GPU programming techniques that you can 00:41:56,640 --> 00:42:02,960
加速矩阵通知。您可以使用更多的 GPU 编程技术
--use to accelerate a GPU code. For example, one of the important things we want to make sure is we 00:42:02,960 --> 00:42:08,640
用于加速 GPU 代码。例如，我们要确定的重要事情之一是我们
--want to be able to make sure that all the threads within a thread block try to load data from a 00:42:08,640 --> 00:42:14,880
希望能够确保线程块中的所有线程都尝试从一个
--continuous region as opposed to from a discontinuous region. And usually, that's going to lead to a 00:42:14,880 --> 00:42:21,440
连续区域与不连续区域相对。通常，这会导致
--better memory utilization here. There's also this concept called shared memory bank conflict, 00:42:21,440 --> 00:42:27,920
这里有更好的内存利用率。还有一个叫做共享内存库冲突的概念，
--where you want to make sure that each of the threads writes to different shared memory banks 00:42:27,920 --> 00:42:32,720
您要确保每个线程都写入不同的共享内存库
--so that each of the shared memory address actually can be grouped onto different regions, 00:42:33,680 --> 00:42:43,200
这样每个共享内存地址实际上都可以分组到不同的区域，
--banking regions. And we want to make sure that each of the threads writes to different regions. 00:42:43,200 --> 00:42:46,560
银行区域。我们要确保每个线程写入不同的区域。
--There's also the technical software pipeline that allows us to do the data loading and computations 00:42:47,280 --> 00:42:53,680
还有允许我们进行数据加载和计算的技术软件管道
--in a concurrent fashion. There are also techniques called warp level optimizations 00:42:54,400 --> 00:42:59,360
以并发的方式。还有一些技术称为 warp level optimizations
--that allows you to perform certain computations at what we call a warp level, where it's even a 00:42:59,360 --> 00:43:06,800
这允许你在我们称之为扭曲级别的地方执行某些计算，它甚至是
--smaller generality of the thread block, where each warp can perform 00:43:06,800 --> 00:43:12,400
线程块的通用性较小，其中每个 warp 都可以执行
--some of our collective computations again. Finally, a lot of the modern hardware comes with this 00:43:12,960 --> 00:43:19,360
我们的一些集体计算再次出现。最后，很多现代硬件都带有这个
--modern acceleration unit called tensor core that allows us to be able to take data from 00:43:19,360 --> 00:43:25,440
称为张量核心的现代加速单元使我们能够从中获取数据
--a specific warp and allows us to do matrix-matrix computations using specialized 00:43:27,120 --> 00:43:35,120
特定的扭曲并允许我们使用专门的方法进行矩阵矩阵计算
--accelerations. All those techniques are important techniques to really get us the maximum benefit 00:43:35,120 --> 00:43:41,600
加速度。所有这些技术都是真正让我们获得最大利益的重要技术
--of a GPU accelerator. If you are interested in understanding all those techniques, you are more 00:43:41,600 --> 00:43:48,080
GPU 加速器。如果你有兴趣了解所有这些技术，你更
--than welcome to check out our CUDA programming guide, and there are a lot of materials on GPU 00:43:48,080 --> 00:43:52,800
欢迎查看我们的 CUDA 编程指南，还有很多关于 GPU 的资料
--programming online that can help you to get started. So, of course, this lecture is going to 00:43:52,800 --> 00:43:58,800
可以帮助您入门的在线编程。所以，当然，这个讲座将
--be served as an introduction material that helps you to get started, and there are a lot more that 00:43:58,800 --> 00:44:04,400
作为入门资料，可以作为入门资料，还有很多
--we can learn together. So, that's the end of today's lecture. Thanks everybody for coming, 00:44:04,400 --> 00:44:10,720
我们可以一起学习。那么，今天的讲座到此结束。谢谢大家的光临
--and in the next lecture, we're going to dive deeper into some of the implementation details 00:44:10,720 --> 00:44:15,040
在下一课中，我们将深入探讨一些实施细节
--of the hardware acceleration library. I will see you in the next lecture. 00:44:15,040 --> 00:44:19,440
硬件加速库。下节课见。
