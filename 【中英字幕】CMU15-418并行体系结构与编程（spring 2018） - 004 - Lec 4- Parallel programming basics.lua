--We're going to actually start looking at some code. 00:00:00,000 --> 00:00:03,200
我们将真正开始查看一些代码。
--Uh, on, on the, the other day what we were discussing is, 00:00:03,200 --> 00:00:06,760
呃，在，在，前几天我们讨论的是，
--we're talking about some parallel programming models. 00:00:06,760 --> 00:00:10,160
我们正在谈论一些并行编程模型。
--As you may recall, we talked about shared address space, 00:00:10,160 --> 00:00:13,360
您可能还记得，我们讨论过共享地址空间，
--message passing, and data parallel. 00:00:13,360 --> 00:00:16,320
消息传递和数据并行。
--And now today we're gonna use, uh, 00:00:16,320 --> 00:00:18,240
现在我们今天要用，呃，
--some simple examples and we're gonna see what the software looks 00:00:18,240 --> 00:00:22,160
一些简单的例子，我们将看到软件的外观
--like if we want to have 00:00:22,160 --> 00:00:23,800
就像我们想拥有
--a functional parallel program written in these three different styles. 00:00:23,800 --> 00:00:27,720
用这三种不同风格编写的功能性并行程序。
--So today, we're going to just get to the point of having functional, 00:00:27,720 --> 00:00:32,680
所以今天，我们将开始讨论功能性的问题，
--hopefully not terribly performing parallel code, 00:00:32,680 --> 00:00:36,880
希望不会非常执行并行代码，
--but we're not yet going to get to the point of 00:00:36,880 --> 00:00:39,040
但我们还没有达到目的
--really optimizing that- the performance of that code. 00:00:39,040 --> 00:00:42,040
真正优化那个——那个代码的性能。
--We will, uh, scratch the surface of those issues today. 00:00:42,040 --> 00:00:46,000
今天，我们将浅谈这些问题的表面。
--Uh, but in the upcoming lectures, 00:00:46,000 --> 00:00:48,000
呃，但是在接下来的讲座中，
--we're gonna dive much more deeply into, uh, 00:00:48,000 --> 00:00:51,000
我们将更深入地探讨，呃，
--issues about how you really squeeze the most performance out of parallel software. 00:00:51,000 --> 00:00:56,200
关于如何真正从并行软件中榨取最大性能的问题。
--Okay. So, okay. 00:00:56,200 --> 00:01:00,280
好的。所以，好吧。
--So, uh, what I'm gonna do is introduce a couple of writing examples now that are good, 00:01:00,280 --> 00:01:06,480
所以，呃，我现在要做的是介绍几个很好的写作例子，
--good, um, examples of code that we might want to parallelize, 00:01:06,480 --> 00:01:10,240
好的，嗯，我们可能想要并行化的代码示例，
--um, so that I can have something to refer to. 00:01:10,240 --> 00:01:13,080
嗯，这样我就有东西可以参考了。
--And the first one of these is actually, uh, 00:01:13,080 --> 00:01:15,840
其中第一个实际上是，呃，
--very similar to what we're going to look at later in our, in our case studies. 00:01:15,840 --> 00:01:20,280
与我们稍后将在我们的案例研究中看到的非常相似。
--So, okay. So this first program, 00:01:20,280 --> 00:01:23,040
所以，好吧。所以这第一个程序，
--what it's doing is, um, 00:01:23,040 --> 00:01:25,120
它正在做的是，嗯，
--imagine you're an oceanographer and you want to simulate, 00:01:25,120 --> 00:01:28,800
想象你是一名海洋学家并且你想要模拟，
--simulate the, uh, the physics of the ocean. 00:01:28,800 --> 00:01:32,400
模拟，呃，海洋的物理学。
--So the ocean is a three-dimensional thing. 00:01:32,400 --> 00:01:35,480
所以海洋是三维的。
--However, um, in this case, 00:01:35,480 --> 00:01:37,600
但是，嗯，在这种情况下，
--what they actually do is because the depth of the ocean is much smaller compared to how wide it is, 00:01:37,600 --> 00:01:44,720
他们实际上做的是因为与海洋的宽度相比，海洋的深度要小得多，
--it's almost like a, 00:01:44,720 --> 00:01:46,320
它几乎就像一个，
--not exactly a plane, 00:01:46,320 --> 00:01:47,880
不完全是一架飞机，
--but it's a very thin three-dimensional object. 00:01:47,880 --> 00:01:50,880
但它是一个非常薄的三维物体。
--And also because, uh, 00:01:51,040 --> 00:01:52,600
还因为，呃，
--pressure and temperature change as you go deeper into it, 00:01:52,600 --> 00:01:55,880
当你深入其中时，压力和温度会发生变化，
--the way they represent it is as a series, 00:01:55,880 --> 00:01:58,360
他们表示它的方式是作为一个系列，
--as a set of, of these different layers, 00:01:58,360 --> 00:02:00,720
作为这些不同层的一组，
--a set of two-dimensional planes at different depths. 00:02:00,720 --> 00:02:04,000
一组不同深度的二维平面。
--So, so it is a 3D matrix, um, 00:02:04,000 --> 00:02:07,840
所以，所以它是一个 3D 矩阵，嗯，
--but you can, but really each, 00:02:07,840 --> 00:02:10,480
但你可以，但实际上每个人，
--each layer is computed separately. 00:02:10,480 --> 00:02:13,920
每一层都是单独计算的。
--Okay. So if we just flip one of these layers over, 00:02:13,920 --> 00:02:17,120
好的。所以如果我们只是翻转其中一层，
--we have a 2D array. 00:02:17,120 --> 00:02:18,600
我们有一个二维数组。
--And what's going on here is, um, 00:02:18,640 --> 00:02:22,840
这里发生的事情是，嗯，
--obviously the ocean is continuous and time is continuous. 00:02:22,840 --> 00:02:26,480
显然海洋是连续的，时间是连续的。
--But when we do things in, 00:02:26,480 --> 00:02:28,280
但是当我们在里面做事的时候，
--in software, we do them, 00:02:28,280 --> 00:02:29,840
在软件中，我们做他们，
--uh, in a more discrete way. 00:02:29,840 --> 00:02:31,640
呃，以一种更离散的方式。
--So we take the space, 00:02:31,640 --> 00:02:34,080
所以我们占用空间，
--the, you know, the, the, 00:02:34,080 --> 00:02:35,440
你知道，那个，那个，
--the two-dimensional space and divide that into grid points. 00:02:35,440 --> 00:02:39,640
二维空间并将其划分为网格点。
--So these are approximations of, 00:02:39,640 --> 00:02:42,240
所以这些是近似值，
--well, that's, that's the correct value at that particular point. 00:02:42,240 --> 00:02:45,640
好吧，那是那个特定点的正确值。
--But it's just discrete points. 00:02:45,640 --> 00:02:47,160
但它只是离散点。
--It's not every continuous point. 00:02:47,160 --> 00:02:49,040
这不是每个连续的点。
--So that's what the array elements represent. 00:02:49,040 --> 00:02:51,880
这就是数组元素所代表的。
--It's what's going on at that particular coordinate in the ocean. 00:02:51,880 --> 00:02:56,480
这就是海洋中特定坐标处发生的事情。
--And then there's also a set of time steps. 00:02:56,480 --> 00:02:58,640
然后还有一组时间步长。
--Because we don't just want a particular instant in time, 00:02:58,640 --> 00:03:01,480
因为我们不只是想要一个特定的瞬间，
--we want to model what happens over time. 00:03:01,480 --> 00:03:04,440
我们想模拟随时间发生的事情。
--So we, we compute, uh, 00:03:04,440 --> 00:03:06,920
所以我们，我们计算，呃，
--the, the values for all the elements at a particular time step, 00:03:06,920 --> 00:03:09,960
 the，所有元素在特定时间步长的值，
--and then we move to the next time step. 00:03:09,960 --> 00:03:12,000
然后我们进入下一个时间步。
--And what we're doing is solving a set of, uh, 00:03:12,000 --> 00:03:16,280
我们正在做的是解决一组，呃，
--partial differential equations. 00:03:16,320 --> 00:03:18,600
偏微分方程。
--Um, and don't worry, we won't reproduce this picture from memory on the exam. 00:03:18,600 --> 00:03:23,280
嗯，别担心，我们不会在考试中凭记忆重现这张照片。
--Um, so there's, there's a lot of, uh, 00:03:23,280 --> 00:03:26,040
嗯，所以有，有很多，呃，
--a lot of equations that are being solved in the, 00:03:26,040 --> 00:03:28,800
许多方程式正在被解决，
--in the real version of this software that's modeling, 00:03:28,800 --> 00:03:32,680
在这个建模软件的真实版本中，
--um, the ocean. 00:03:32,680 --> 00:03:34,040
嗯，海洋。
--We're going to, later on today, 00:03:34,040 --> 00:03:36,040
我们将在今天晚些时候，
--we're going to look at a very simplified version of this code that 00:03:36,040 --> 00:03:39,880
我们将看一下这段代码的一个非常简化的版本
--captures the important communication and parallel challenges of the real software. 00:03:39,880 --> 00:03:45,840
捕获了真实软件的重要通信和并行挑战。
--So, um, I'm not going to get into all the details here. 00:03:46,000 --> 00:03:49,240
所以，嗯，我不打算在这里详细介绍所有细节。
--There's a lot of stuff that goes on. 00:03:49,240 --> 00:03:50,720
有很多事情在发生。
--But the interesting part is, 00:03:50,720 --> 00:03:53,080
但有趣的是，
--it turns out that it spends most of its time, 00:03:53,080 --> 00:03:55,880
事实证明，它花费了大部分时间，
--a vast majority of its time, 00:03:55,880 --> 00:03:57,600
绝大多数时间，
--in a particular part of this computation, 00:03:57,600 --> 00:04:00,640
在这个计算的特定部分，
--which is where, for a particular time step, 00:04:00,640 --> 00:04:03,400
对于特定的时间步长，
--you are solving, you're updating all of the parallel dif- partial 00:04:03,400 --> 00:04:07,240
你正在解决，你正在更新所有并行差异部分
--differential equations for all of the grid elements. 00:04:07,240 --> 00:04:10,360
所有网格元素的微分方程。
--So that's what we're going to focus on later. 00:04:10,360 --> 00:04:12,200
所以这就是我们稍后要关注的。
--That's, that's where it spends most of its time. 00:04:12,200 --> 00:04:15,400
也就是说，这是它花费大部分时间的地方。
--Okay. So that's our first, uh, 00:04:16,120 --> 00:04:18,760
好的。所以这是我们的第一个，呃，
--example application. 00:04:18,760 --> 00:04:20,000
示例应用程序。
--And one thing you may have noticed about it is that it has a very regular structure. 00:04:20,000 --> 00:04:26,600
您可能已经注意到的一件事是它具有非常规则的结构。
--So we have a dense two-dimensional array, 00:04:26,600 --> 00:04:30,040
所以我们有一个密集的二维数组，
--and we're going to be updating elements of that two-dimensional array, uh, over time. 00:04:30,040 --> 00:04:34,680
随着时间的推移，我们将更新那个二维数组的元素。
--The second example, this is also, uh, 00:04:34,680 --> 00:04:38,360
第二个例子，这也是，呃，
--a scientific, uh, uh, 00:04:38,360 --> 00:04:40,760
一个科学的，呃，呃，
--simulation of something physical. 00:04:40,760 --> 00:04:43,080
物理的东西的模拟。
--But here, what we're simulating is, uh, 00:04:43,200 --> 00:04:46,400
但是在这里，我们正在模拟的是，呃，
--stars in, in the gala- in, uh, the universe. 00:04:46,400 --> 00:04:50,160
星星在，在银河中，呃，宇宙。
--So the way- what's happening here is, again, 00:04:50,160 --> 00:04:54,360
所以这里发生的事情是，再一次，
--we have time steps, 00:04:54,360 --> 00:04:55,840
我们有时间步长，
--but what they're trying to do is model 00:04:55,840 --> 00:04:58,200
但他们试图做的是建模
--the gravitational interactions between different stars over time, 00:04:58,200 --> 00:05:02,880
随着时间的推移，不同恒星之间的引力相互作用，
--because they are exerting forces on each other, 00:05:02,880 --> 00:05:05,800
因为他们互相施加力量，
--and they cause things to move around. 00:05:05,800 --> 00:05:07,800
它们使事物四处移动。
--So just as- hopefully, 00:05:07,800 --> 00:05:09,720
所以就像-希望，
--this will show up here. 00:05:09,720 --> 00:05:11,480
这将显示在这里。
--But- so here's just, uh, 00:05:11,480 --> 00:05:14,760
但是-所以这里只是，呃，
--like a little video of some, you know, 00:05:14,760 --> 00:05:17,960
就像一些小视频，你知道的，
--the universe in the early day- early, uh, 00:05:17,960 --> 00:05:20,520
早期的宇宙-早期，呃，
--well, millions of years, 00:05:20,520 --> 00:05:22,040
嗯，数百万年，
--that is, uh, after the Big Bang. 00:05:22,040 --> 00:05:24,120
也就是说，呃，在大爆炸之后。
--So you've got all these particles, 00:05:24,120 --> 00:05:26,560
所以你有所有这些粒子，
--and they're moving around, 00:05:26,560 --> 00:05:27,920
他们四处走动，
--and they are, uh, 00:05:27,920 --> 00:05:29,480
他们是，呃，
--attracting each other, and then moving toward each other. 00:05:29,480 --> 00:05:32,720
相互吸引，然后相互靠近。
--Okay. So that's- that's the idea behind this application. 00:05:32,720 --> 00:05:38,920
好的。这就是 - 这就是这个应用程序背后的想法。
--Now, this- this application is a little different. 00:05:38,920 --> 00:05:43,080
现在，这个——这个应用程序有点不同。
--Um, so unlike the ocean simulation, 00:05:43,080 --> 00:05:46,840
嗯，不像海洋模拟，
--where we have a regular dense 2D array, 00:05:46,840 --> 00:05:50,200
我们有一个规则的密集二维数组，
--the locations of the stars in the galaxy, 00:05:50,200 --> 00:05:53,200
星系中恒星的位置，
--that's much more irregular. 00:05:53,200 --> 00:05:55,240
那更不规则。
--So there are certain areas where they're really clumped together, 00:05:55,240 --> 00:05:59,000
所以在某些区域它们真的聚集在一起，
--and then there may be a lot of empty-ish space, 00:05:59,000 --> 00:06:01,520
然后可能会有很多空的空间，
--and then there may be some others clumped together in other places. 00:06:01,520 --> 00:06:04,720
然后可能还有一些其他人在其他地方聚集在一起。
--So we don't want to represent this with a dense array, 00:06:04,720 --> 00:06:08,600
所以我们不想用密集数组来表示它，
--or matrix, because a lot of the space would be uninteresting. 00:06:08,600 --> 00:06:12,320
或矩阵，因为很多空间会无趣。
--So this is a sparse data structure. 00:06:12,320 --> 00:06:15,120
所以这是一个稀疏数据结构。
--And so it's- it basically, 00:06:15,120 --> 00:06:16,880
所以它-基本上，
--you can think of it as a graph. 00:06:16,880 --> 00:06:18,680
你可以把它想象成一个图表。
--Um, and another thing about it is, 00:06:18,680 --> 00:06:22,160
嗯，关于它的另一件事是，
--um, if you did the naive computation, 00:06:22,160 --> 00:06:24,920
嗯，如果你做了天真的计算，
--it would be very expensive because every body, 00:06:24,920 --> 00:06:29,680
这将是非常昂贵的，因为每个人，
--every star is exerting a force on every other star. 00:06:29,680 --> 00:06:34,120
每颗恒星都对其他恒星施加力。
--So if we did point, you know, 00:06:34,120 --> 00:06:36,400
所以如果我们确实指出，你知道，
--pairwise comparisons of everything with everything, 00:06:36,440 --> 00:06:39,720
对所有事物进行成对比较，
--this would not scale well at all, 00:06:39,720 --> 00:06:41,880
这根本无法很好地扩展，
--if we had a large number of these things, 00:06:41,880 --> 00:06:44,360
如果我们有很多这样的东西，
--a large number of these stars. 00:06:44,360 --> 00:06:46,800
大量的这些明星。
--So the trick that they use to make this more tractable, 00:06:46,800 --> 00:06:50,400
所以他们用来使这更容易处理的技巧，
--is that if- if there are clusters of things, 00:06:50,400 --> 00:06:53,360
是如果-如果有一堆东西，
--if there are things that are farther away, 00:06:53,360 --> 00:06:55,480
如果有更远的东西，
--far enough away from a given star, 00:06:55,480 --> 00:06:58,080
离给定的恒星足够远，
--then instead of- so if we're trying to update what's going on with respect to how 00:06:58,080 --> 00:07:03,800
然后而不是 - 所以如果我们试图更新关于如何发生的事情
--the gravitational forces affect this particular star that I've circled, 00:07:03,800 --> 00:07:07,720
引力影响我圈出的这颗特别的恒星，
--you know, there may be some that are relatively close to it, 00:07:07,720 --> 00:07:11,480
你知道，可能有一些比较接近它，
--that we want to consider individually. 00:07:11,480 --> 00:07:13,960
我们要单独考虑。
--But then there might be, you know, 00:07:13,960 --> 00:07:15,880
但那时可能会有，你知道，
--another group of stars over here or over here, 00:07:15,880 --> 00:07:19,360
另一群星星在这里或这里，
--and they're far enough away that what we do is, 00:07:19,360 --> 00:07:22,320
他们离我们足够远，我们要做的是，
--instead of considering them all individually, 00:07:22,320 --> 00:07:24,640
而不是单独考虑它们，
--we just clump them together into 00:07:24,640 --> 00:07:26,640
我们只是把它们聚集在一起
--one approximate mass and pretend that there's just one big star there. 00:07:26,640 --> 00:07:31,760
一个近似质量并假装那里只有一颗大恒星。
--So that way that- that saves computation time. 00:07:31,800 --> 00:07:34,960
这样就可以节省计算时间。
--So one parameter is there's a certain radius. 00:07:34,960 --> 00:07:38,200
所以一个参数是有一定的半径。
--If you go- if you're within the radius and everything gets computed individually, 00:07:38,200 --> 00:07:42,600
如果你去 - 如果你在半径内并且一切都单独计算，
--if you go beyond that- that radius, 00:07:42,600 --> 00:07:44,640
如果你超越那个——那个半径，
--then- then you start to aggregate things together. 00:07:44,640 --> 00:07:48,400
然后——然后你开始把事情聚合在一起。
--So I've been talking about it in terms of simulating galaxies, 00:07:48,400 --> 00:07:52,880
所以我一直在用模拟星系的方式来谈论它，
--but this is- this- this- this is called an n-body simulation, 00:07:52,880 --> 00:07:56,120
但这是-这-这-这叫做多体模拟，
--and this is something that's done in physics and, 00:07:56,120 --> 00:07:58,680
这是在物理学中所做的事情，
--you know, a lot of other situations. 00:07:58,680 --> 00:08:01,000
你知道，还有很多其他情况。
--Okay. So how is this represented? 00:08:01,760 --> 00:08:04,360
好的。那么这是如何表示的呢？
--Well, it turns out that one of the things you need to do 00:08:04,360 --> 00:08:07,280
好吧，事实证明你需要做的事情之一
--frequently is think about where things are in space. 00:08:07,280 --> 00:08:11,040
经常思考事物在空间中的位置。
--So you need to know how, you know, 00:08:11,040 --> 00:08:13,720
所以你需要知道如何，你知道，
--what are the other stars that are close by as opposed to stars that are far away. 00:08:13,720 --> 00:08:19,560
与远处的星星相比，靠近的其他星星是什么。
--So a data structure that's useful for capturing that kind of spatial information is, 00:08:19,560 --> 00:08:25,600
因此，对于捕获此类空间信息有用的数据结构是，
--um, called a- a quadtree in two dimensions, 00:08:25,600 --> 00:08:28,800
嗯，叫做 a- 二维四叉树，
--and it would be an optree in three dimensions. 00:08:28,800 --> 00:08:32,040
它将是三个维度的optree。
--I'm showing it as a quadtree because that makes sense on a slide. 00:08:32,040 --> 00:08:35,520
我将其显示为四叉树，因为这在幻灯片上很有意义。
--But in the real program, 00:08:35,520 --> 00:08:36,560
但是在真正的程序中，
--it's actually three-dimensional and it's an optree. 00:08:36,560 --> 00:08:40,120
它实际上是三维的，它是一个optree。
--So the idea is- so this is the actual- in physical space here, 00:08:40,120 --> 00:08:46,680
所以这个想法是——所以这是实际的——在物理空间里，
--you can see that there are- there are some regions where there aren't so many stars. 00:08:46,680 --> 00:08:52,960
你可以看到有-有些地区没有那么多星星。
--So in this quadrant down here, 00:08:52,960 --> 00:08:54,680
所以在下面这个象限里，
--we have just this one star. 00:08:54,680 --> 00:08:57,640
我们只有这一颗星。
--And then there are other quadrants where we have more stars. 00:08:57,640 --> 00:09:00,520
然后还有其他象限，我们有更多的星星。
--So what you do is you recursively, uh, 00:09:00,520 --> 00:09:03,320
所以你所做的就是递归地，呃，
--subdivide each space and that gives you a tree, 00:09:03,320 --> 00:09:06,640
细分每个空间，然后给你一棵树，
--and eventually, um, 00:09:06,640 --> 00:09:08,360
最后，嗯，
--you have leaf nodes where you're in your own particular space. 00:09:08,360 --> 00:09:11,640
您在自己的特定空间中有叶节点。
--So for example, right here, 00:09:11,640 --> 00:09:13,920
例如，就在这里，
--we have some things that are clustered fairly close together, 00:09:13,920 --> 00:09:17,680
我们有一些东西非常靠近地聚集在一起，
--and those are- are much deeper into the tree. 00:09:17,680 --> 00:09:21,160
那些是-在树中更深。
--So the reason why this is a handy data structure is that if you want to find things that are, 00:09:21,160 --> 00:09:26,080
所以这是一个方便的数据结构的原因是如果你想找到那些东西，
--uh, nearby, you usually only have to go a little bit up 00:09:26,080 --> 00:09:29,800
呃,附近,一般只要往上走一点点
--the tree and look around at other, 00:09:29,800 --> 00:09:32,200
树，环顾四周，
--you know, siblings or cousins or things like that. 00:09:32,200 --> 00:09:34,920
你知道，兄弟姐妹或堂兄弟姐妹或类似的人。
--Um, so that's- this is the data structure that's used in this computation. 00:09:34,920 --> 00:09:40,640
嗯，那就是——这是在这个计算中使用的数据结构。
--Okay. So in terms of what happens in this code, um, oh, great. 00:09:40,640 --> 00:09:47,200
好的。所以就这段代码中发生的事情而言，嗯，太棒了。
--Yeah. So in terms of what happens in this code, um, uh, 00:09:47,200 --> 00:09:51,080
是的。所以就这段代码中发生的事情而言，嗯，呃，
--in fact, we'll- we'll come back and talk more about this in 00:09:51,080 --> 00:09:53,760
事实上，我们会-我们会回来更多地讨论这个
--a later lecture and go into a lot more detail about it. 00:09:53,760 --> 00:09:56,960
稍后的讲座，并详细介绍它。
--But, um, there are time steps. 00:09:56,960 --> 00:09:59,360
但是，嗯，有时间步骤。
--And an interesting thing is on each time step, 00:09:59,360 --> 00:10:02,320
每个时间步都有一件有趣的事情，
--you have to rebuild this tree, 00:10:02,320 --> 00:10:04,400
你必须重建这棵树，
--this quadtree, because things are moving, 00:10:04,400 --> 00:10:07,160
这个四叉树，因为事物在移动，
--and they may move out of the quadrant that they were in before. 00:10:07,160 --> 00:10:10,720
他们可能会离开他们之前所在的象限。
--So you may have to go back and re- reconstruct this tree. 00:10:10,720 --> 00:10:14,280
所以你可能不得不返回并重新构建这棵树。
--So there are time steps where you build the tree, 00:10:14,280 --> 00:10:16,880
所以在构建树的时候有时间步骤，
--and then you go, um, 00:10:16,880 --> 00:10:18,680
然后你去，嗯，
--visit all of the nodes and figure out the collective impact of all the other forces. 00:10:18,680 --> 00:10:23,720
访问所有节点并找出所有其他力量的集体影响。
--And then you update, um, 00:10:23,760 --> 00:10:26,200
然后你更新，嗯，
--the properties of each node. 00:10:26,200 --> 00:10:28,240
每个节点的属性。
--Okay. So- all right. 00:10:28,240 --> 00:10:31,400
好的。所以——好吧。
--So those are some examples that I'll refer back to. 00:10:31,400 --> 00:10:33,960
所以这些是我将要提到的一些例子。
--And now what we're going to start talking more, uh, 00:10:33,960 --> 00:10:36,040
现在我们要开始谈论更多，呃，
--generally about some of the things we have to worry about 00:10:36,040 --> 00:10:38,840
通常是关于我们必须担心的一些事情
--when we're trying to take a program and turn it into a parallel program. 00:10:38,840 --> 00:10:42,600
当我们试图将一个程序变成一个并行程序时。
--So as you may recall from, uh, 00:10:42,600 --> 00:10:46,280
所以你可能还记得，呃，
--I think it was either, uh, Monday or last week, 00:10:46,280 --> 00:10:49,680
我想要么是，呃，星期一，要么是上周，
--I talked about how when we talk about performance in this class, 00:10:49,680 --> 00:10:53,880
我谈到了当我们谈论这门课的表现时，
--we're going to use the term speedup. 00:10:53,880 --> 00:10:55,840
我们将使用术语加速。
--And that's the ratio of the time it took just on 00:10:55,840 --> 00:10:59,440
这就是它所花费的时间的比率
--one processor versus the time that it's taking on more than one processor. 00:10:59,440 --> 00:11:03,400
一个处理器与它在多个处理器上花费的时间。
--So we want- we want to, um, 00:11:03,400 --> 00:11:06,040
所以我们想要-我们想要，嗯，
--maximize speedup which means hopefully this- this time is getting smaller and smaller. 00:11:06,040 --> 00:11:11,640
最大化加速，这意味着希望这个时间越来越小。
--Okay. So some of the things that we want to think about as we're doing this is we- we 00:11:11,640 --> 00:11:16,760
好的。所以我们在做这件事时想要考虑的一些事情是我们——我们
--want to take the overall work that we're doing in the original, um, 00:11:16,760 --> 00:11:20,520
想把我们在原版中所做的整体工作，嗯，
--sequential program and break it up into pieces 00:11:20,520 --> 00:11:24,000
顺序程序并将其分解成多个部分
--so that the pieces can be given to different processors to work on. 00:11:24,000 --> 00:11:28,000
这样就可以将这些片段交给不同的处理器进行处理。
--So one of the- one of the steps is find- identify things that we can do in parallel. 00:11:28,000 --> 00:11:35,760
因此，其中一个步骤是找到 - 确定我们可以并行执行的事情。
--And then we want to, um, 00:11:35,760 --> 00:11:38,160
然后我们想，嗯，
--kind of divide that up into chunks that correspond to the number of processors that we have. 00:11:38,160 --> 00:11:44,120
将其分成与我们拥有的处理器数量相对应的块。
--And then finally, we need to have, um, 00:11:44,120 --> 00:11:47,360
最后，我们需要，嗯，
--all of those different threads, uh, 00:11:47,360 --> 00:11:50,160
所有这些不同的线程，呃，
--interacting with each other correctly. 00:11:50,160 --> 00:11:52,160
彼此正确互动。
--So we're going to go through this in a- in a lot more detail in some examples here. 00:11:52,160 --> 00:11:57,240
因此，我们将在此处的一些示例中更详细地介绍这一点。
--Okay. And so this is like a graph, uh, 00:11:57,240 --> 00:12:00,120
好的。所以这就像一个图表，呃，
--a more, uh, visual representation of what I just talked about, 00:12:00,120 --> 00:12:03,640
更多，呃，我刚才谈到的视觉表现，
--plus there's an- an extra step here. 00:12:03,640 --> 00:12:05,800
另外，这里还有一个额外的步骤。
--So, uh, we're going to go through all these steps here. 00:12:05,800 --> 00:12:08,880
所以，呃，我们将在这里完成所有这些步骤。
--But the way to think of it is- so this thing at the top, 00:12:08,880 --> 00:12:13,640
但思考它的方式是-所以这个东西在顶部，
--uh, think of this as being some, uh, 00:12:13,640 --> 00:12:17,040
呃，认为这是一些，呃，
--this blob is the computation that you need to do in this program. 00:12:17,040 --> 00:12:21,440
这个 blob 是你需要在这个程序中进行的计算。
--So originally, uh, 00:12:21,440 --> 00:12:23,840
所以最初，呃，
--when one processor is doing all the work, 00:12:23,840 --> 00:12:25,640
当一个处理器完成所有工作时，
--it's just one big blob. 00:12:25,640 --> 00:12:27,200
它只是一个大斑点。
--But then we want to divide it into smaller pieces. 00:12:27,200 --> 00:12:30,840
但是我们想把它分成更小的部分。
--And we want to make sure that we have at least as many, 00:12:30,840 --> 00:12:34,440
我们想确保我们至少有同样多的，
--uh, pieces of- of work as processors. 00:12:34,440 --> 00:12:37,800
呃，作为处理器的一些工作。
--If we have fewer pieces of work than processors, 00:12:37,800 --> 00:12:41,640
如果我们的工作量少于处理器，
--then we will definitely have some processors that won't have anything to do. 00:12:41,640 --> 00:12:45,520
那么我们肯定会有一些处理器不会有任何事情要做。
--Now, what are these- what are these pieces of work? 00:12:45,520 --> 00:12:48,880
现在，这些是什么——这些作品是什么？
--And we- we often call them, uh, tasks. 00:12:48,880 --> 00:12:52,600
而我们——我们经常称它们为，呃，任务。
--So- so a task- so this first step is, 00:12:52,600 --> 00:12:56,440
如此-如此一项任务-所以第一步是，
--we call that decomposition, 00:12:56,440 --> 00:12:57,800
我们称之为分解，
--which is basically- this is a mental step where you- you think about what you're doing, 00:12:57,800 --> 00:13:02,800
基本上-这是一个心理步骤，您-考虑自己在做什么，
--and think what are some natural chunks of work 00:13:02,800 --> 00:13:06,160
并思考一些自然的工作块
--that I could think about dividing up and doing these in parallel. 00:13:06,160 --> 00:13:09,520
我可以考虑分开并并行执行这些操作。
--So for example, in the ocean simulation, 00:13:09,520 --> 00:13:12,560
例如，在海洋模拟中，
--each of those points in the 2D array, 00:13:12,560 --> 00:13:15,880
二维数组中的每个点，
--um, needs to be computed. 00:13:15,880 --> 00:13:17,720
嗯，需要计算。
--So each element is a potential task. 00:13:17,720 --> 00:13:20,600
所以每个元素都是一个潜在的任务。
--Now, there- turns out that there are- are way more of those elements than processors. 00:13:20,600 --> 00:13:26,600
现在，事实证明这些元素的数量远多于处理器。
--So we're not going to- we're going to group them together, 00:13:26,600 --> 00:13:30,440
所以我们不会-我们要把它们组合在一起，
--uh, into larger chunks. 00:13:30,440 --> 00:13:33,360
呃，分成更大的块。
--So that's- that's what this, uh, assignment step is. 00:13:33,360 --> 00:13:36,920
这就是 - 这就是这个，呃，分配步骤。
--So your initial- and another- another example of a task is in the n-body simulation, 00:13:36,920 --> 00:13:42,920
所以你的初始和另一个任务的另一个例子是在 n 体模拟中，
--updating each individual star, you know, 00:13:42,920 --> 00:13:45,480
更新每个单独的星星，你知道的，
--that's a potential, an obvious task. 00:13:45,480 --> 00:13:47,720
这是一项潜在的、显而易见的任务。
--But again, there are probably far more of those than there are processors. 00:13:47,720 --> 00:13:52,560
但同样，这些处理器的数量可能远远超过处理器的数量。
--So then the next step is, uh, 00:13:52,560 --> 00:13:55,320
那么下一步就是，呃，
--to group together the tasks, um, 00:13:55,320 --> 00:13:58,600
将任务组合在一起，嗯，
--in- so that you end up with, uh, 00:13:58,600 --> 00:14:01,200
在-所以你最终会得到，呃，
--get- hopefully giving each processor, uh, 00:14:01,200 --> 00:14:04,040
得到-希望给每个处理器，呃，
--the same amount of work, uh, hopefully. 00:14:04,040 --> 00:14:06,360
同样的工作量，呃，希望如此。
--We want to get that as evenly balanced as possible. 00:14:06,400 --> 00:14:09,120
我们希望尽可能平衡。
--So remember from the very first lecture when I had, uh, 00:14:09,120 --> 00:14:13,200
所以请记住，从第一堂课开始，我有，呃，
--four volunteers come up here and asked them to add up, uh, 00:14:13,200 --> 00:14:16,880
四个志愿者上来让他们加起来，呃，
--a total of 16 numbers but it turns out that I gave one of the people eight numbers, 00:14:16,880 --> 00:14:22,240
总共 16 个数字，但事实证明我给了其中一个人八个数字，
--and the other people had far fewer things to add up. 00:14:22,240 --> 00:14:24,680
而其他人要加起来的东西要少得多。
--So when we did that, 00:14:24,680 --> 00:14:26,440
所以当我们这样做时，
--the other three people ended up finishing early and then everyone was waiting around for 00:14:26,440 --> 00:14:30,560
其他三个人早早结束，然后大家都在等着
--the last, uh, unfortunate volunteer to add up their eight numbers. 00:14:30,560 --> 00:14:34,600
最后一位不幸的志愿者将他们的八个数字相加。
--So that's something we want to avoid. 00:14:34,640 --> 00:14:36,480
所以这是我们想要避免的事情。
--We want to divide up the work evenly. 00:14:36,480 --> 00:14:38,560
我们想平均分配工作。
--Like, remember the second time they did that, 00:14:38,560 --> 00:14:40,800
就像，记得他们第二次那样做，
--they passed, um, 00:14:40,800 --> 00:14:42,200
他们通过了，嗯，
--around those numbers so that everybody had four things to add up and, 00:14:42,200 --> 00:14:45,560
围绕这些数字，这样每个人都有四件事要加起来，
--and it was divided up evenly. 00:14:45,560 --> 00:14:47,000
并且平分了。
--So that's, that's another thing that we want to do. 00:14:47,000 --> 00:14:49,920
这就是我们想要做的另一件事。
--Okay. So, so far what you're basically doing is just dividing up work into chunks. 00:14:49,920 --> 00:14:55,800
好的。所以，到目前为止，您所做的基本上只是将工作分成块。
--But then the next step is, 00:14:55,800 --> 00:14:57,840
但下一步是，
--you have to have the, uh, 00:14:57,840 --> 00:14:59,400
你必须有，呃，
--threads actually work together and cooperate. 00:14:59,400 --> 00:15:02,560
线程实际上一起工作和合作。
--And that step is what we call orchestration. 00:15:02,560 --> 00:15:06,640
这一步就是我们所说的编排。
--And the details of that depend very much on the, uh, 00:15:06,640 --> 00:15:11,000
其细节在很大程度上取决于，呃，
--programming abstraction, like, 00:15:11,000 --> 00:15:13,280
编程抽象，比如，
--and you'll see that when we go through our examples today. 00:15:13,280 --> 00:15:15,880
当我们今天浏览示例时，您会看到这一点。
--So that's going to look very different for 00:15:15,880 --> 00:15:18,920
所以这看起来会非常不同
--shared address space versus message passing versus data parallel. 00:15:18,920 --> 00:15:23,840
共享地址空间与消息传递与数据并行。
--And then finally, the last step is, um, 00:15:23,840 --> 00:15:28,400
最后，最后一步是，嗯，
--not necessarily something that programmers worry about, 00:15:28,400 --> 00:15:31,320
不一定是程序员担心的事情，
--but you can take these, um, 00:15:31,320 --> 00:15:33,560
但你可以拿这些，嗯，
--these threads and decide how they actually get mapped to the physical hardware. 00:15:33,560 --> 00:15:38,640
这些线程并决定它们如何实际映射到物理硬件。
--In many cases, programmers just let the system do whatever it naturally wants to do. 00:15:38,640 --> 00:15:43,360
在很多情况下，程序员只是让系统做它自然想做的事情。
--But there are cases where you might want to be more careful about that. 00:15:43,360 --> 00:15:46,840
但在某些情况下，您可能需要更加小心。
--So, and that would probably depend on if you have, for example, 00:15:46,840 --> 00:15:50,920
所以，这可能取决于你是否有，例如，
--an interconnect where you can only talk to your nearest neighbors, 00:15:50,920 --> 00:15:54,680
您只能与最近的邻居交谈的互连，
--then you may want to make sure that you map the computation onto the machine so that 00:15:54,680 --> 00:15:58,920
那么您可能需要确保将计算映射到机器上，以便
--the, the communication is in fact happening between nearest neighbors. 00:15:58,960 --> 00:16:03,440
那么，通信实际上发生在最近的邻居之间。
--Okay. So those are the steps. 00:16:03,440 --> 00:16:06,160
好的。这些就是步骤。
--And now what I'm going to do is, uh, 00:16:06,160 --> 00:16:07,960
现在我要做的是，呃，
--we're going to go through them. 00:16:07,960 --> 00:16:09,440
我们将通过它们。
--Uh, we're going to start with, uh, decomposition. 00:16:09,440 --> 00:16:12,760
呃，我们将从，呃，分解开始。
--And we're going to talk about some issues to think about for all these different steps. 00:16:12,760 --> 00:16:17,800
我们将讨论所有这些不同步骤中需要考虑的一些问题。
--Okay. So, um, so the point of, uh, 00:16:18,040 --> 00:16:22,000
好的。所以，嗯，重点是，呃，
--decomposition is to break up the code, 00:16:22,000 --> 00:16:24,760
分解就是把代码打散，
--um, so into the tasks. 00:16:24,760 --> 00:16:27,480
嗯，所以进入任务。
--Now, um, okay, 00:16:27,520 --> 00:16:29,720
现在，嗯，好的，
--this usually is not a very difficult thing to do. 00:16:29,720 --> 00:16:32,320
这通常不是一件非常困难的事情。
--The most important thing to think, 00:16:32,320 --> 00:16:33,760
最重要的是要思考，
--one of the most important things to realize is that you, um, 00:16:33,760 --> 00:16:37,680
要意识到的最重要的事情之一是你，嗯，
--you need to have at least as many tasks as threads. 00:16:37,680 --> 00:16:42,480
您至少需要拥有与线程一样多的任务。
--If you, in fact, 00:16:42,480 --> 00:16:43,840
事实上，如果你
--usually you'd like to have more tasks than threads, 00:16:43,840 --> 00:16:47,760
通常你希望有比线程更多的任务，
--because there's a good chance that you won't get this quite right. 00:16:47,760 --> 00:16:51,320
因为很有可能你不会把这件事做对。
--Uh, you know, you won't necessarily, 00:16:51,320 --> 00:16:52,760
呃，你知道，你不一定会，
--the task size won't necessarily, 00:16:52,760 --> 00:16:54,560
任务大小不一定，
--they won't all be equal. 00:16:54,560 --> 00:16:55,920
他们不会都是平等的。
--And you'd like to have some flexibility to maybe shift things around a little bit. 00:16:55,960 --> 00:16:59,840
并且您希望有一些灵活性来稍微改变一下。
--So you want them to be small enough tasks that you have plenty of them. 00:16:59,840 --> 00:17:04,680
所以你希望它们是足够小的任务，你有很多。
--You don't need to go crazy and make each task super, 00:17:04,680 --> 00:17:08,120
你不需要发疯，让每个任务都超级棒，
--super, super small because there's going to be 00:17:08,120 --> 00:17:10,080
超级，超级小，因为会有
--overhead with managing them if they're too low. 00:17:10,080 --> 00:17:13,040
如果它们太低，则管理它们的开销。
--But, but it's reasonable to say, um, 00:17:13,040 --> 00:17:15,960
但是，但是有道理的说，嗯，
--for example, that each star in the galaxy simulation is a task. 00:17:15,960 --> 00:17:20,480
例如，星系模拟中的每颗恒星都是一项任务。
--And, uh, for the ocean simulation, 00:17:20,480 --> 00:17:23,240
而且，呃，对于海洋模拟，
--maybe, um, individual elements in the array might be tasks, 00:17:23,280 --> 00:17:27,200
也许，嗯，数组中的单个元素可能是任务，
--or maybe rows or columns might be tasks. 00:17:27,200 --> 00:17:30,200
或者行或列可能是任务。
--We'll come back and talk about that later. 00:17:30,200 --> 00:17:33,200
我们稍后会回来讨论。
--Okay. Now, the thing about tasks is you want to identify tasks that are independent of each other. 00:17:33,400 --> 00:17:41,720
好的。现在，关于任务的事情是你想要识别彼此独立的任务。
--So this involves thinking about dependencies. 00:17:41,720 --> 00:17:44,920
所以这涉及到考虑依赖性。
--If you have potential tasks that, uh, 00:17:44,920 --> 00:17:47,800
如果你有潜在的任务，呃，
--where one of them can't begin until you finish computing the other one, 00:17:47,800 --> 00:17:51,760
在你计算完另一个之前，其中一个不能开始，
--then that's not really a source of parallelism. 00:17:51,760 --> 00:17:53,960
那么这并不是真正的并行性来源。
--Those are actually things that have to be done, uh, serially. 00:17:53,960 --> 00:17:58,480
这些实际上是必须连续完成的事情。
--Okay. Now, one of the things we'll talk about, uh, 00:17:58,560 --> 00:18:02,880
好的。现在，我们要谈一件事，呃，
--for a minute here is, uh, 00:18:02,880 --> 00:18:04,760
一分钟，呃，
--a common, uh, mistake that you can make at this point is to get 00:18:04,760 --> 00:18:09,040
在这一点上你可能犯的一个常见错误是
--very excited about some portion of the execution that you decide that you can 00:18:09,040 --> 00:18:14,000
对您决定可以执行的某些部分感到非常兴奋
--parallelize nicely and ignore other parts that are harder to deal with, 00:18:14,000 --> 00:18:18,720
很好地并行化并忽略其他难以处理的部分，
--and, and think that that's a good thing to do. 00:18:18,720 --> 00:18:21,120
并且认为这是一件好事。
--So actually, how many people have heard of Amdahl's Law? 00:18:21,120 --> 00:18:24,880
那么实际上，有多少人听说过阿姆达尔定律呢？
--Okay. A bunch of people. 00:18:24,880 --> 00:18:26,760
好的。一群人。
--Good. Okay. Good. 00:18:26,760 --> 00:18:28,400
好的。好的。好的。
--All right. So we're just going to review this quickly, um, 00:18:28,400 --> 00:18:31,480
好的。所以我们要快速回顾一下，嗯，
--and Amdahl's Law, it's named after Gene Amdahl, 00:18:31,480 --> 00:18:34,920
和阿姆达尔定律，它以吉恩·阿姆达尔的名字命名，
--who was, uh, uh, a researcher at IBM. 00:18:34,920 --> 00:18:37,960
谁是，呃，呃，IBM 的研究员。
--And, uh, it limit- basically what it says is the fraction of the program that we're running, 00:18:37,960 --> 00:18:44,800
而且，呃，它限制了——基本上它说的是我们正在运行的程序的一部分，
--uh, sequentially, the part that we're not running in parallel, 00:18:44,800 --> 00:18:48,360
呃，按顺序，我们没有并行运行的部分，
--will ultimately create an upper bound on how much performance we can get with parallelism. 00:18:48,400 --> 00:18:53,520
最终将创建一个上限，说明我们可以通过并行获得多少性能。
--So let's just look at a practical, 00:18:53,520 --> 00:18:56,680
那么让我们来看看一个实际的，
--uh, example of how that could bite us. 00:18:56,680 --> 00:18:59,760
呃，这可能会咬我们的例子。
--Okay. So here's- imagine that we are- we have an image processing, 00:18:59,760 --> 00:19:05,160
好的。所以这里 - 想象我们 - 我们有一个图像处理，
--uh, algorithm where- that involves two steps. 00:19:05,160 --> 00:19:08,360
呃，算法 where- 涉及两个步骤。
--So the first step is that we want to, 00:19:08,360 --> 00:19:12,160
所以第一步是我们要，
--uh, double the brightness of every pixel. 00:19:12,160 --> 00:19:15,280
呃，每个像素的亮度加倍。
--And the second step is that we want to calculate 00:19:15,280 --> 00:19:18,160
第二步是我们要计算
--the average of all the pixel values after we do that. 00:19:18,160 --> 00:19:21,240
我们这样做之后所有像素值的平均值。
--So the nice thing about the, uh, 00:19:21,240 --> 00:19:24,200
所以关于的好处，呃，
--first step is that there are no dependencies there in step one. 00:19:24,200 --> 00:19:28,120
第一步是在第一步中没有依赖项。
--We can independently go to each pixel and just double the value there. 00:19:28,120 --> 00:19:31,920
我们可以独立地访问每个像素并将那里的值加倍。
--That's- that's easy to do in parallel. 00:19:31,920 --> 00:19:34,040
这很容易并行进行。
--The second step, um, 00:19:34,040 --> 00:19:36,840
第二步，嗯，
--when we're computing the average of all the pixels, 00:19:36,840 --> 00:19:39,480
当我们计算所有像素的平均值时，
--that's a reduction of- that's- that's a little bit like the massively parallel example we had, 00:19:39,480 --> 00:19:44,640
那是 - 那是 - 这有点像我们拥有的大规模并行示例，
--um, in our first class where you tried to add up all the numbers 00:19:44,640 --> 00:19:48,600
嗯，在我们的第一节课上，你试着把所有的数字加起来
--of how many courses you're registered for across the whole class. 00:19:48,600 --> 00:19:51,520
您在整个班级注册了多少门课程。
--And remember that had a lot of dependencies in it. 00:19:51,520 --> 00:19:53,920
请记住，它有很多依赖关系。
--So maybe that's challenging. 00:19:53,920 --> 00:19:56,560
所以也许这很有挑战性。
--Okay. So what we'll- let's say that, um, 00:19:56,560 --> 00:20:00,240
好的。那么我们要说的是，嗯，
--since we have an n by n, uh, image, 00:20:00,240 --> 00:20:04,160
因为我们有一个 n 乘 n，呃，图像，
--um, we'll just say that roughly speaking, 00:20:04,160 --> 00:20:07,240
嗯，我们只是粗略地说，
--our sequential- if we did this, uh, 00:20:07,240 --> 00:20:09,160
我们的顺序-如果我们这样做，呃，
--sequentially, we would visit n squared elements and then we'd visit n squared elements again. 00:20:09,160 --> 00:20:14,120
按顺序，我们将访问 n 个平方元素，然后我们将再次访问 n 个平方元素。
--So our time is proportional to two times n squared, let's say. 00:20:14,160 --> 00:20:19,200
所以我们的时间与 n 的平方的两倍成正比，比方说。
--Okay. All right. 00:20:19,200 --> 00:20:21,720
好的。好的。
--Now, uh, let's start trying to do this in parallel. 00:20:21,720 --> 00:20:25,520
现在，呃，让我们开始尝试并行执行此操作。
--And as I said, the first step is easy to parallelize because 00:20:25,520 --> 00:20:28,480
正如我所说，第一步很容易并行化，因为
--every computation on each pixel is entirely independent. 00:20:28,480 --> 00:20:33,040
每个像素上的每个计算都是完全独立的。
--So that one should- that should go well. 00:20:33,040 --> 00:20:35,520
所以那个应该——那应该会进行得很顺利。
--So this- this purple part, 00:20:35,520 --> 00:20:37,520
所以这个-这个紫色的部分，
--which is, uh, step one, uh, 00:20:37,520 --> 00:20:40,680
这是，呃，第一步，呃，
--we'd expect that to, uh, 00:20:40,680 --> 00:20:42,640
我们希望，呃，
--run about p times faster on p processors because the work's completely independent. 00:20:42,640 --> 00:20:48,360
在 p 个处理器上运行速度大约快 p 倍，因为工作是完全独立的。
--So the more processors we throw at it, 00:20:48,360 --> 00:20:50,760
所以我们投入的处理器越多，
--the faster it should run, hopefully. 00:20:50,760 --> 00:20:52,360
希望它运行得越快。
--Hopefully, that's nice and linear. 00:20:52,360 --> 00:20:54,400
希望这很好而且是线性的。
--Okay. Well, what's that going to do overall? 00:20:54,400 --> 00:20:57,960
好的。好吧，那总体上会做什么？
--Well, the, uh, the purple portion of execution time, uh, 00:20:57,960 --> 00:21:01,800
好吧，呃，执行时间的紫色部分，呃，
--so, uh, the- the figure here, 00:21:01,800 --> 00:21:04,240
所以，呃，这里的数字，
--the way to explain this, uh, 00:21:04,240 --> 00:21:05,560
解释这个的方式，呃，
--the- the x-axis is- the horizontal axis is time. 00:21:05,560 --> 00:21:10,280
 - x 轴是 - 横轴是时间。
--And the, uh, y-axis is how much parallelism you're taking advantage of. 00:21:10,400 --> 00:21:14,720
呃，y 轴是您利用了多少并行性。
--So in the sequential program, uh, 00:21:14,720 --> 00:21:17,240
所以在顺序程序中，呃，
--there's no parallelism, so it's one. 00:21:17,240 --> 00:21:19,280
没有并行性，所以它是一个。
--In the, um, in the, um, 00:21:19,280 --> 00:21:22,320
在，嗯，在，嗯，
--parallel program, we have p processors. 00:21:22,320 --> 00:21:25,160
并行程序，我们有 p 个处理器。
--So we're running p times faster in the purple part, 00:21:25,160 --> 00:21:28,160
所以我们在紫色部分的运行速度快了 p 倍，
--but then not running in parallel in the green part. 00:21:28,160 --> 00:21:30,720
但在绿色部分并没有并行运行。
--So if you think about what happens to this- the execution time, 00:21:30,720 --> 00:21:34,560
所以如果你想想这会发生什么——执行时间，
--as we throw more and more processors at this, 00:21:34,560 --> 00:21:37,240
随着我们投入越来越多的处理器，
--um, we- this is the, uh, 00:21:37,240 --> 00:21:40,000
嗯，我们-这是，呃，
--we start off with 2n squared time, that's this time. 00:21:40,000 --> 00:21:43,400
我们从 2n 平方时间开始，就是这个时间。
--And then we, uh, 00:21:43,400 --> 00:21:44,840
然后我们，呃，
--have n squared over p here, 00:21:44,840 --> 00:21:47,600
在这里对 p 进行了 n 平方，
--that gets to be nice and small, 00:21:47,600 --> 00:21:49,360
变得又好又小，
--especially as p gets to be large. 00:21:49,360 --> 00:21:51,280
特别是当 p 变大时。
--But unfortunately, this part here didn't get any smaller. 00:21:51,280 --> 00:21:54,120
但不幸的是，这部分并没有变小。
--So in the limit, if you threw infinite processors at this, 00:21:54,120 --> 00:21:57,520
所以在极限情况下，如果你为此投入无限的处理器，
--it would only run no more than twice as fast, 00:21:57,520 --> 00:22:00,160
它的运行速度不会超过两倍，
--because we didn't do anything to accelerate the second, uh, step. 00:22:00,160 --> 00:22:04,280
因为我们没有做任何事情来加速第二步。
--So we don't want to ignore that. 00:22:04,280 --> 00:22:07,640
所以我们不想忽视这一点。
--So how can we deal with that second step? 00:22:07,640 --> 00:22:11,440
那么我们如何处理第二步呢？
--Well, there are data dependencies there, 00:22:11,440 --> 00:22:14,720
好吧，那里有数据依赖性，
--but a very common trick that, uh, 00:22:14,720 --> 00:22:16,920
但一个很常见的把戏，呃，
--people use in, in situations like this, 00:22:16,920 --> 00:22:19,360
人们在这样的情况下使用，
--is we could have each processor compute a partial sum. 00:22:19,360 --> 00:22:23,200
是我们可以让每个处理器计算一个部分和。
--So they can add up the sum of all of the, uh, 00:22:23,200 --> 00:22:26,760
所以他们可以把所有的总和加起来，呃，
--they can average together all the pixels for the portion of the image that we've given them. 00:22:26,760 --> 00:22:33,360
他们可以对我们提供给他们的图像部分的所有像素进行平均。
--They do that first because they can do that independently of each other. 00:22:33,480 --> 00:22:37,240
他们首先这样做是因为他们可以彼此独立地做到这一点。
--So that part, um, 00:22:37,240 --> 00:22:40,840
所以那部分，嗯，
--so there's one part where, um, 00:22:40,840 --> 00:22:43,880
所以有一部分，嗯，
--that's nice and parallel, 00:22:43,880 --> 00:22:45,320
那很好而且平行，
--which is they compute their, their local sums. 00:22:45,320 --> 00:22:47,760
这是他们计算他们的本地总和。
--But then there's another step, 00:22:47,760 --> 00:22:49,320
但接下来还有一步，
--which is we then have to add all of those together. 00:22:49,320 --> 00:22:52,200
然后我们必须将所有这些加在一起。
--And that will be serialized. 00:22:52,200 --> 00:22:54,880
这将被序列化。
--Um, we'll probably, you know, 00:22:54,880 --> 00:22:56,600
嗯，我们可能会，你知道，
--we'll just do those one at a time. 00:22:56,600 --> 00:22:58,520
我们一次只做一个。
--So that will take, um, 00:22:58,520 --> 00:23:00,440
所以这需要，嗯，
--that won't be parallel. 00:23:00,440 --> 00:23:02,000
那不会是平行的。
--So that's, that's this part here. 00:23:02,040 --> 00:23:04,560
这就是这一部分。
--So it's no parallelism here. 00:23:04,560 --> 00:23:06,840
所以这里没有并行性。
--But, um, the width of that is only p. 00:23:06,840 --> 00:23:10,600
但是，嗯，它的宽度只有 p。
--And, um, and given that n is probably much, 00:23:10,600 --> 00:23:14,760
而且，嗯，考虑到 n 可能很多，
--much, much larger than p typically, 00:23:14,760 --> 00:23:16,920
通常比 p 大得多，
--then in fact we, we won't get perfect speedup, 00:23:16,920 --> 00:23:19,480
那么事实上我们，我们不会得到完美的加速，
--but we'll get something close to real perfect speedup. 00:23:19,480 --> 00:23:22,120
但我们会得到接近真正完美加速的东西。
--So this is a way to get, uh, 00:23:22,120 --> 00:23:24,240
所以这是一种获得，呃，
--potentially very good performance on a program like this. 00:23:24,240 --> 00:23:28,680
在这样的程序上可能会有很好的表现。
--Okay. But in general, um, 00:23:29,120 --> 00:23:32,280
好的。但总的来说，嗯，
--the fraction of the execution time that you are 00:23:32,280 --> 00:23:35,040
你执行时间的一部分
--not parallelizing will limit overall performance. 00:23:35,040 --> 00:23:38,400
不并行化会限制整体性能。
--So for example, if, um, 00:23:38,400 --> 00:23:41,040
例如，如果，嗯，
--only 90% of the code is running in parallel, 00:23:41,040 --> 00:23:44,760
只有 90% 的代码并行运行，
--then even if it's running very nicely in parallel, 00:23:44,760 --> 00:23:47,600
那么即使它并行运行得非常好，
--you're not going to get a speedup of more than 10, and, and so on. 00:23:47,600 --> 00:23:51,920
你不会得到超过 10 的加速，等等。
--And if you have, you know, 00:23:51,920 --> 00:23:53,640
如果你有，你知道，
--even 99% of it is running in parallel, 00:23:53,640 --> 00:23:56,040
甚至 99% 都是并行运行的，
--ultimately you can't get a speedup of more than 100, for example. 00:23:56,040 --> 00:24:00,000
例如，最终你无法获得超过 100 的加速。
--Okay. Okay. So we're talking about decomposition, 00:24:01,120 --> 00:24:05,320
好的。好的。所以我们在谈论分解，
--which is thinking about taking the work and breaking it up into tasks. 00:24:05,320 --> 00:24:09,560
它正在考虑接受工作并将其分解为任务。
--And, uh, so how does that step normally happen? 00:24:09,560 --> 00:24:13,520
而且，呃，那么这一步通常是如何发生的呢？
--So it turns out that this is, 00:24:13,520 --> 00:24:15,760
结果是，
--this is almost always done, 00:24:15,760 --> 00:24:17,560
几乎总是这样做，
--uh, in, in the mind of the programmer. 00:24:17,560 --> 00:24:19,520
呃，在，在程序员的脑海里。
--So this is an exercise for the programmer where they think about what's going on, 00:24:19,520 --> 00:24:23,840
所以这是对程序员的一个练习，让他们思考正在发生的事情，
--and they decide what would be a good set of tasks. 00:24:23,840 --> 00:24:27,320
他们决定什么是好的任务集。
--In an ideal world, 00:24:27,320 --> 00:24:28,680
在一个理想的世界里，
--it would be nice if there were compilers or tools that could automatically figure this out. 00:24:28,680 --> 00:24:33,640
如果有编译器或工具可以自动解决这个问题，那就太好了。
--Um, but, uh, that's a very hard problem for compilers. 00:24:33,640 --> 00:24:37,480
嗯，但是，呃，这对编译器来说是一个非常困难的问题。
--So although people have worked on that problem for many years, 00:24:37,480 --> 00:24:40,560
所以尽管人们多年来一直致力于解决这个问题，
--and in fact I've worked on it, uh, also, uh, 00:24:40,560 --> 00:24:43,440
事实上我已经研究过了，呃，还有，呃，
--there's only been like modest success in that area 00:24:43,440 --> 00:24:46,040
在那个领域只取得了微不足道的成功
--because it's difficult to think about all these dependencies. 00:24:46,040 --> 00:24:49,080
因为很难考虑所有这些依赖关系。
--So this is something that programmers usually think about. 00:24:49,080 --> 00:24:52,200
所以这是程序员通常会思考的问题。
--Okay. So that's the first step, 00:24:52,200 --> 00:24:54,200
好的。所以这是第一步，
--is to identify tasks, um, 00:24:54,200 --> 00:24:56,880
就是识别任务，嗯，
--like, um, where each, 00:24:56,880 --> 00:24:59,080
就像，嗯，每一个，
--the updating the, uh, 00:24:59,080 --> 00:25:00,720
更新，呃，
--the properties of each star in the galaxy simulation, 00:25:00,720 --> 00:25:03,320
星系模拟中每颗恒星的属性，
--or each element in the ocean simulation. 00:25:03,320 --> 00:25:06,560
或海洋模拟中的每个元素。
--And, um, often, so the granularity of a task is 00:25:07,360 --> 00:25:13,680
而且，嗯，通常，任务的粒度是
--usually defined by some natural piece of computation in the code. 00:25:13,680 --> 00:25:18,640
通常由代码中的一些自然计算来定义。
--So for example, a star. 00:25:18,640 --> 00:25:20,640
例如，一个明星。
--But the size of the amount of work that you do, um, 00:25:20,640 --> 00:25:25,200
但是你所做的工作量的大小，嗯，
--that's not necessarily the right amount to, 00:25:25,200 --> 00:25:28,400
这不一定是正确的数额，
--to give entirely to one processor and say that's all that you're going to do. 00:25:28,400 --> 00:25:32,120
完全交给一个处理器并说这就是你要做的一切。
--Chances are you want to bundle together collections of 00:25:32,120 --> 00:25:34,800
您可能希望将以下集合捆绑在一起
--these tasks and assign those to processors. 00:25:34,800 --> 00:25:37,720
这些任务并将其分配给处理器。
--And that's, that's the next step here, assignment. 00:25:37,720 --> 00:25:41,120
那就是，这是这里的下一步，作业。
--Okay. So, all right. 00:25:41,120 --> 00:25:44,000
好的。所以，好吧。
--There are interesting trade-offs, uh, 00:25:44,000 --> 00:25:46,400
有一些有趣的权衡，呃，
--when you're trying to group together these tasks into the right bundles to give to each thread. 00:25:46,440 --> 00:25:53,480
当您尝试将这些任务组合到正确的包中以提供给每个线程时。
--So in an ideal world, 00:25:53,480 --> 00:25:56,680
所以在一个理想的世界里，
--what you would like to do is, first of all, 00:25:56,680 --> 00:25:59,040
你想做的是，首先，
--give, give each processor the same amount of work. 00:25:59,040 --> 00:26:01,560
给，给每个处理器相同的工作量。
--And we, as I mentioned a minute ago, 00:26:01,560 --> 00:26:03,760
而我们，正如我刚才提到的，
--we saw an example where that didn't work with the four people, 00:26:03,760 --> 00:26:06,920
我们看到了一个对四个人不起作用的例子，
--where I didn't balance the work nicely. 00:26:06,920 --> 00:26:09,480
我没有很好地平衡工作。
--But that's not the only goal. 00:26:09,480 --> 00:26:11,400
但这不是唯一的目标。
--Another thing that also really limits performance is communication overhead. 00:26:11,400 --> 00:26:16,560
另一个真正限制性能的因素是通信开销。
--So if, in order to perform your task, 00:26:16,560 --> 00:26:19,520
因此，如果为了执行您的任务，
--if you have to get data from another processor, 00:26:19,520 --> 00:26:22,800
如果您必须从另一个处理器获取数据，
--then that's going to be, uh, 00:26:22,800 --> 00:26:24,640
那将是，呃，
--that's going to be non-trivially expensive. 00:26:24,640 --> 00:26:26,880
那将是非常昂贵的。
--Either that's a cache miss or you're waiting for a message. 00:26:26,880 --> 00:26:30,480
要么是缓存未命中，要么是您正在等待消息。
--But somehow communication, 00:26:30,480 --> 00:26:32,120
但不知何故沟通，
--if communication has to take place and possibly synchronization, 00:26:32,120 --> 00:26:35,840
如果必须进行通信并可能进行同步，
--then that can be a source of, 00:26:35,840 --> 00:26:37,960
那么这可能是一个来源，
--of a lot of performance loss. 00:26:37,960 --> 00:26:40,400
大量的性能损失。
--So the other thing you would like to do is minimize communication. 00:26:40,400 --> 00:26:44,200
所以你想做的另一件事是尽量减少沟通。
--So ideally, the set of tasks that I give to one processor, 00:26:44,200 --> 00:26:48,640
所以理想情况下，我给一个处理器的一组任务，
--it can do almost all of that work with hardly communicating at all with its, 00:26:48,640 --> 00:26:53,960
它可以完成几乎所有的工作，几乎不需要与它沟通，
--with the other processors, hopefully, in an ideal world. 00:26:53,960 --> 00:26:57,720
希望在理想的世界中与其他处理器一起使用。
--Now, it turns out that, um, 00:26:57,720 --> 00:27:01,040
现在，事实证明，嗯，
--unfortunately, these two things are at odds with each other. 00:27:01,040 --> 00:27:05,520
不幸的是，这两件事相互矛盾。
--And we'll talk more about that on Friday. 00:27:05,520 --> 00:27:08,280
我们将在周五详细讨论这一点。
--But basically, um, the thing that you might do, for example, 00:27:08,360 --> 00:27:12,800
但基本上，嗯，你可能会做的事情，例如，
--a good way to ensure that you balance the load evenly would be to 00:27:12,800 --> 00:27:17,440
确保均衡负载的一个好方法是
--randomly assign tasks to processors because that would avoid 00:27:17,440 --> 00:27:22,200
随机分配任务给处理器，因为这样可以避免
--any, uh, systematic, um, biases, 00:27:22,200 --> 00:27:25,800
任何，呃，系统的，嗯，偏见，
--or in cases where you accidentally give one far more work than the other ones. 00:27:25,800 --> 00:27:29,920
或者在您不小心给一个人做的工作比其他人多得多的情况下。
--But that is absolutely the worst thing to do for locality. 00:27:29,920 --> 00:27:33,320
但这绝对是当地最糟糕的事情。
--So that would maximize communication. 00:27:33,320 --> 00:27:36,080
这样可以最大化沟通。
--Similarly, uh, if you're completely trying to minimize communication, 00:27:36,080 --> 00:27:40,840
同样，呃，如果你完全想尽量减少交流，
--in the extreme, you would give all the work to one processor, 00:27:40,840 --> 00:27:44,120
在极端情况下，您会将所有工作交给一个处理器，
--uh, because then it wouldn't have to communicate at all, right? 00:27:44,120 --> 00:27:46,720
呃，因为那样它就根本不需要交流了，对吧？
--Uh, but that would also not be so good for balancing the work. 00:27:46,720 --> 00:27:50,360
呃，但这也不利于平衡工作。
--So, um, we'll talk more about this on Friday, 00:27:50,360 --> 00:27:53,320
所以，嗯，我们将在周五详细讨论这个问题，
--but that's another challenge. 00:27:53,320 --> 00:27:55,640
但这是另一个挑战。
--Now, this, um, this grouping together in the assignment phase, 00:27:55,640 --> 00:28:01,760
现在，这个，嗯，这个在分配阶段分组在一起，
--that can either occur statically or dynamically. 00:28:01,760 --> 00:28:05,000
这可以静态或动态发生。
--When we do it statically, 00:28:05,040 --> 00:28:06,800
当我们静态地做时，
--it means that basically before the program starts to even do the work, 00:28:06,800 --> 00:28:11,440
这意味着基本上在程序开始工作之前，
--you've already decided exactly how you're going to divide everything up. 00:28:11,440 --> 00:28:15,560
您已经确切地决定了如何划分所有内容。
--When you do it dynamically, 00:28:15,560 --> 00:28:17,800
当你动态地做的时候，
--that means you haven't made that decision and you just work it out all along the way. 00:28:17,800 --> 00:28:22,800
这意味着你还没有做出那个决定，你只是一直在努力。
--So I'm going to show you examples of both of those things. 00:28:22,800 --> 00:28:26,480
因此，我将向您展示这两方面的示例。
--Okay. So remember in, 00:28:26,480 --> 00:28:29,800
好的。所以请记住，
--in ISPC, um, uh, the other day, 00:28:29,800 --> 00:28:33,080
在 ISPC 中，嗯，呃，前几天，
--we, we looked at this code where, um, 00:28:33,080 --> 00:28:36,200
我们，我们看了这段代码，嗯，
--in the case on the left over here, 00:28:36,200 --> 00:28:38,480
在左边的情况下，
--you can see that the, um, 00:28:38,480 --> 00:28:41,320
你可以看到，嗯，
--the work that we're doing, 00:28:41,320 --> 00:28:43,000
我们正在做的工作，
--we were using, uh, program count and program index in this, 00:28:43,000 --> 00:28:47,840
我们在此使用，呃，程序计数和程序索引，
--in this case to do interleaved assignment of the work to processors. 00:28:47,840 --> 00:28:52,920
在这种情况下，将工作交错分配给处理器。
--So this is an example of static assignment because the software, 00:28:52,920 --> 00:28:57,840
所以这是一个静态分配的例子，因为软件，
--we already know how we're going to divide up the work. 00:28:57,840 --> 00:29:00,640
我们已经知道我们将如何分配工作。
--We're going to interleave it across these, uh, 00:29:00,640 --> 00:29:04,400
我们要把它交错在这些之间，呃，
--uh, computational instances which happen to be vector lanes in this case. 00:29:04,400 --> 00:29:10,360
呃，在这种情况下恰好是矢量车道的计算实例。
--Okay. So that's static. 00:29:10,360 --> 00:29:12,160
好的。所以这是静态的。
--But I said there's another option which is I could just say, 00:29:12,160 --> 00:29:15,840
但我说还有另一种选择，我只能说，
--instead of going through all that work, 00:29:15,840 --> 00:29:17,520
而不是完成所有这些工作，
--I could simply say that the, 00:29:17,520 --> 00:29:18,800
我可以简单地说，
--the iterations of this outer loop, 00:29:18,800 --> 00:29:20,680
这个外循环的迭代，
--they can be done in parallel and I'll let the system decide how to do that. 00:29:20,680 --> 00:29:25,360
它们可以并行完成，我会让系统决定如何做。
--Now, the system could either take that for each and statically interleave, 00:29:25,360 --> 00:29:30,520
现在，系统可以为每个静态交错获取它，
--or it could decide to just, 00:29:30,560 --> 00:29:32,760
或者它可以决定只是，
--uh, hand things out on the fly. 00:29:32,760 --> 00:29:36,360
呃，把事情交出去。
--Okay. So now let's look at some more, 00:29:36,360 --> 00:29:41,880
好的。现在让我们再看一些，
--uh, examples of both types of assignments. 00:29:41,880 --> 00:29:44,240
呃，两种类型的作业的例子。
--So for example, um, 00:29:44,240 --> 00:29:45,960
例如，嗯，
--we're going to look at, uh, 00:29:45,960 --> 00:29:47,480
我们要看看，呃，
--a different type of static assignment. 00:29:47,480 --> 00:29:49,760
一种不同类型的静态赋值。
--So in this case, um, 00:29:49,760 --> 00:29:51,720
所以在这种情况下，嗯，
--we want- let's say we have two processors. 00:29:51,720 --> 00:29:54,000
我们想要 - 假设我们有两个处理器。
--So we only need to divide the work in half. 00:29:54,000 --> 00:29:56,440
所以我们只需要将工作分成两半。
--And we're going to call sine x. 00:29:56,440 --> 00:30:00,720
我们将调用正弦 x。
--But, uh, what we're doing is we're adding, 00:30:00,720 --> 00:30:04,160
但是，呃，我们正在做的是我们正在添加，
--we're adding more code here. 00:30:04,160 --> 00:30:05,960
我们在这里添加更多代码。
--And effectively what this code does is we have an array, 00:30:05,960 --> 00:30:11,720
这段代码所做的实际上是我们有一个数组，
--and it has, you know, 00:30:11,720 --> 00:30:13,120
它有，你知道，
--all these elements in it, 00:30:13,120 --> 00:30:14,320
里面所有这些元素，
--and this is the input values that we're calculating on, 00:30:14,320 --> 00:30:17,960
这是我们计算的输入值，
--and then we're going to generate an output array that 00:30:17,960 --> 00:30:19,600
然后我们将生成一个输出数组
--has exactly the same number of elements. 00:30:19,600 --> 00:30:22,000
具有完全相同数量的元素。
--And what we're doing here is we're just dividing it in half. 00:30:22,000 --> 00:30:25,400
我们在这里所做的只是将其一分为二。
--So in fact, what it does, 00:30:25,400 --> 00:30:28,000
所以事实上，它的作用，
--if you look carefully, 00:30:28,000 --> 00:30:29,280
如果你仔细看，
--it's calling, uh, pthread create, 00:30:29,280 --> 00:30:32,600
它在调用，呃，pthread create，
--and creating, uh, a child thread. 00:30:32,600 --> 00:30:35,960
并创建，呃，一个子线程。
--And the child thread gets the right half, 00:30:35,960 --> 00:30:39,040
子线程得到右半部分，
--and the parent thread gets the left half, 00:30:39,040 --> 00:30:41,600
父线程获取左半部分，
--or, or maybe vice versa, one of those. 00:30:41,600 --> 00:30:44,400
或者，反之亦然，其中之一。
--So we, we create another thread with pthreads, 00:30:44,400 --> 00:30:47,200
所以我们，我们用 pthreads 创建另一个线程，
--and now we have two threads, 00:30:47,200 --> 00:30:48,200
现在我们有两个线程，
--and each of them do half of the work. 00:30:48,200 --> 00:30:50,640
他们每个人都做了一半的工作。
--Okay. So what do you think about this? 00:30:50,640 --> 00:30:53,720
好的。所以，对于这个你有什么想法？
--Is this, is this a good way to write parallel software, 00:30:53,720 --> 00:30:58,760
这是，这是编写并行软件的好方法吗，
--or do you see something that, 00:30:58,760 --> 00:31:00,200
或者你看到了什么，
--that concerns you about this? 00:31:00,200 --> 00:31:02,600
你关心这个吗？
--I'm not, I'm not worried about the pthread part specifically. 00:31:05,560 --> 00:31:09,000
我不是，我并不特别担心 pthread 部分。
--I just meant, what about this decision 00:31:09,000 --> 00:31:10,880
我的意思是，这个决定怎么样
--about how we're dividing up the work? 00:31:10,880 --> 00:31:12,880
关于我们如何分工？
--Are there, are there any hazards to doing it this way? 00:31:12,880 --> 00:31:16,680
有没有，这样做有什么危害吗？
--Yeah. 00:31:16,840 --> 00:31:18,160
是的。
--And it may not use all the hardware. 00:31:18,160 --> 00:31:20,400
而且它可能不会使用所有硬件。
--Right. Yeah. Yeah. 00:31:20,400 --> 00:31:22,120
正确的。是的。是的。
--Well, at least, you know, in this case, 00:31:22,120 --> 00:31:23,640
好吧，至少，你知道，在这种情况下，
--we've- the code is hardwired to only create two threads. 00:31:23,640 --> 00:31:28,040
我们已经-代码被硬连接到只创建两个线程。
--So if we run that on a processor that has four cores on it, 00:31:28,040 --> 00:31:32,000
所以如果我们在一个有四个内核的处理器上运行它，
--well, we only have two threads. 00:31:32,000 --> 00:31:33,680
好吧，我们只有两个线程。
--So it's not necessarily gonna take advantage of all the different pieces, 00:31:33,680 --> 00:31:37,120
所以它不一定会利用所有不同的部分，
--all the hardware. 00:31:37,120 --> 00:31:38,480
所有的硬件。
--Let's say we just have two, uh, cores though. 00:31:38,480 --> 00:31:41,960
假设我们只有两个，呃，核心。
--Um, is there anything potentially not good about doing, 00:31:41,960 --> 00:31:46,680
嗯，这样做有什么不好的地方吗，
--doing the assignment this way? 00:31:46,680 --> 00:31:49,320
以这种方式做作业？
--Yeah. 00:31:50,320 --> 00:31:52,000
是的。
--Um, one half of the array might have like, uh, significantly, 00:31:52,000 --> 00:31:58,640
嗯，数组的一半可能有，呃，很明显，
--like, I'm not sure if it applies for sign specifically, 00:31:58,640 --> 00:32:02,080
就像，我不确定它是否专门适用于标志，
--but significantly bigger numbers. 00:32:02,080 --> 00:32:03,800
但明显更大的数字。
--Yeah. 00:32:03,800 --> 00:32:04,040
是的。
--Which would take more time. 00:32:04,040 --> 00:32:05,400
这将花费更多时间。
--Whereas if you have them like, 00:32:05,400 --> 00:32:07,080
而如果你有他们喜欢，
--kind of do a thing where they meet in the middle, 00:32:07,080 --> 00:32:09,480
有点像他们在中间相遇的地方，
--they would end when they're both done. 00:32:09,480 --> 00:32:13,320
当他们都完成时，他们就会结束。
--Yeah. Yeah. Exactly. 00:32:13,320 --> 00:32:14,640
是的。是的。确切地。
--So yeah. So again, that's a good point. 00:32:14,640 --> 00:32:17,240
嗯是的。再一次，这是一个很好的观点。
--So set aside the specific details of what signed is. 00:32:17,240 --> 00:32:20,280
所以先把signed是什么的具体细节搁置一旁。
--But if we think more generically about calling some routine foo, 00:32:20,280 --> 00:32:24,200
但是如果我们更一般地考虑调用一些例程 foo，
--and it's gonna, uh, calculate something based on an input array, 00:32:24,200 --> 00:32:27,800
它会，呃，根据输入数组计算一些东西，
--it may be that, uh, 00:32:27,800 --> 00:32:29,640
可能是，呃，
--the amount of work varies quite a bit. 00:32:29,640 --> 00:32:31,600
工作量相差很大。
--And it may also be the case that the, 00:32:31,600 --> 00:32:34,080
也可能是这样的，
--the work is much larger for the right-hand side than the left-hand side. 00:32:34,080 --> 00:32:37,920
右侧的工作比左侧大得多。
--So a problem with this is, 00:32:37,920 --> 00:32:40,440
所以这个问题是，
--although we've created two threads, 00:32:40,440 --> 00:32:42,200
虽然我们已经创建了两个线程，
--they- and, and in fact, in this case, 00:32:42,200 --> 00:32:43,920
他们——事实上，在这种情况下，
--they don't communicate probably at all. 00:32:43,920 --> 00:32:46,160
他们可能根本不交流。
--So that's good. Uh, but we don't mean, 00:32:46,160 --> 00:32:48,480
所以这很好。呃，但我们不是说，
--we may not necessarily have balanced the amount of work very much. 00:32:48,480 --> 00:32:51,440
我们不一定非常平衡工作量。
--So it may be that one of them will finish, 00:32:51,440 --> 00:32:53,680
所以可能其中之一会完成，
--uh, far earlier than the other one. 00:32:53,680 --> 00:32:55,920
呃，比另一个早得多。
--So that's a motivation for, uh, dynamic assignment. 00:32:55,920 --> 00:33:00,440
所以这是动态分配的动机。
--So the idea behind dynamic assignment is that you tell the system, 00:33:00,440 --> 00:33:05,400
所以动态分配背后的想法是你告诉系统，
--here's, here's a set of work. 00:33:05,400 --> 00:33:07,280
这是，这是一组工作。
--And you can think of this as being, um, 00:33:07,280 --> 00:33:10,400
你可以认为这是，嗯，
--like a queue where you've just, uh, 00:33:10,400 --> 00:33:12,840
就像一个队列，你刚刚，呃，
--stuck a lot of work into a queue. 00:33:12,840 --> 00:33:15,040
将大量工作排入队列。
--And when you want to do work, 00:33:15,040 --> 00:33:17,000
当你想工作时，
--you grab something off of the queue and you process it. 00:33:17,000 --> 00:33:19,880
你从队列中抓取一些东西然后处理它。
--And when you finish that, you go back to the queue and you 00:33:19,880 --> 00:33:22,120
当你完成后，你回到队列中，然后你
--grab another piece of work and you do that. 00:33:22,120 --> 00:33:24,640
抓住另一件工作，然后您就可以做到。
--And the processors are dynamically going to the queue to grab work. 00:33:24,640 --> 00:33:29,240
并且处理器正在动态地进入队列以获取工作。
--So if one piece of work takes a long time, uh, 00:33:29,240 --> 00:33:32,720
所以如果一件作品需要很长时间，呃，
--that's okay because that processor will spend a while doing it. 00:33:32,720 --> 00:33:36,680
没关系，因为该处理器会花一些时间来做这件事。
--But meanwhile, the other processors, 00:33:36,680 --> 00:33:38,320
但与此同时，其他处理器，
--they can finish their shorter tasks, 00:33:38,320 --> 00:33:40,160
他们可以完成较短的任务，
--go back and grab more work, 00:33:40,160 --> 00:33:41,600
回去抓更多的工作，
--and go back and grab even more work. 00:33:41,600 --> 00:33:43,400
然后回去做更多的工作。
--And hopefully, it will all balance out in the end. 00:33:43,440 --> 00:33:46,560
希望最终一切都会平衡。
--So for example, um, 00:33:46,560 --> 00:33:48,200
例如，嗯，
--I mentioned ISPC has something called a task. 00:33:48,200 --> 00:33:51,400
我提到过 ISPC 有一个叫做任务的东西。
--And this is a way that you can specify, uh, 00:33:51,400 --> 00:33:54,720
这是一种你可以指定的方式，呃，
--work in this style where you say, 00:33:54,720 --> 00:33:57,560
以这种风格工作，你说，
--here are a bunch of chunks of work. 00:33:57,560 --> 00:34:00,000
这是一大堆工作。
--And then the system dynamically, 00:34:00,000 --> 00:34:02,760
然后系统动态地，
--it has essentially a pointer that, 00:34:02,760 --> 00:34:04,720
它本质上有一个指针，
--that will point to the next task that is to be handed out. 00:34:04,720 --> 00:34:08,160
这将指向要分发的下一个任务。
--So initially, you start running and each core gets a task, 00:34:08,160 --> 00:34:13,280
所以一开始，你开始运行，每个核心都有一个任务，
--um, and whichever one finishes first will go back. 00:34:13,280 --> 00:34:16,640
嗯，谁先完成谁就回去。
--So let's say this one finishes first, 00:34:16,640 --> 00:34:18,360
所以假设这个先完成，
--it'll go back and get the next thing. 00:34:18,360 --> 00:34:20,360
它会返回并得到下一件事。
--And then this pointer will point to the next thing in the list. 00:34:20,360 --> 00:34:23,920
然后这个指针将指向列表中的下一个事物。
--Okay. So what do you think about this approach? 00:34:23,920 --> 00:34:27,000
好的。那么您如何看待这种方法？
--Uh, not necessarily ISP specifically, 00:34:27,000 --> 00:34:29,400
呃，不一定是特定的 ISP，
--but more generically speaking, 00:34:29,400 --> 00:34:31,040
但更一般地说，
--what about, what, 00:34:31,040 --> 00:34:32,440
什么什么，
--what about runtime assignment or dynamic assignment? 00:34:32,440 --> 00:34:36,320
运行时分配或动态分配怎么样？
--So an advantage of it is probably does a good job of balancing the load. 00:34:36,320 --> 00:34:42,080
所以它的一个优点可能是很好地平衡负载。
--So that's an advantage. Do you see any disadvantages or? 00:34:42,080 --> 00:34:45,040
所以这是一个优势。你看到任何缺点或？
--Yeah. 00:34:45,040 --> 00:34:45,360
是的。
--Right now it has, uh, communication for like 00:34:45,360 --> 00:34:47,560
现在它有，呃，通讯方式
--locking the data structure and making sure that each task runs at once. 00:34:47,560 --> 00:34:50,400
锁定数据结构并确保每个任务同时运行。
--Yeah, exactly. So grabbing something from a queue, well, 00:34:50,400 --> 00:34:53,520
是的，完全正确。所以从队列中抓取一些东西，嗯，
--first of all, there's software overhead to go to that queue and, 00:34:53,520 --> 00:34:57,000
首先，有软件开销去那个队列，
--and just to go access it. 00:34:57,000 --> 00:34:58,720
只是去访问它。
--But not only is there some extra computation, 00:34:58,720 --> 00:35:01,400
但不仅有一些额外的计算，
--but you probably have to have a lock to protect that queue. 00:35:01,400 --> 00:35:04,480
但你可能必须有一个锁来保护那个队列。
--So if, uh, 00:35:04,480 --> 00:35:05,960
所以，如果，呃，
--the processors are all going at the queue at the same time, 00:35:05,960 --> 00:35:08,560
处理器都同时进入队列，
--they're going to have to serialize trying to pull things off of that queue. 00:35:08,560 --> 00:35:12,240
他们将不得不序列化，试图从队列中取出东西。
--So that, so there may be, uh, 00:35:12,240 --> 00:35:13,960
所以，所以可能会有，呃，
--there's typically more significant runtime overhead with dynamic scheduling, 00:35:13,960 --> 00:35:19,040
动态调度通常会有更显着的运行时开销，
--with dynamic assignment. 00:35:19,040 --> 00:35:20,960
动态分配。
--And, um, we'll get back to that. 00:35:20,960 --> 00:35:24,640
而且，嗯，我们会回到那个。
--We'll talk a lot more about that on, uh, Friday. 00:35:24,640 --> 00:35:28,440
我们会在，呃，星期五更多地讨论这个问题。
--Okay. So now we've gotten through the, 00:35:29,240 --> 00:35:31,600
好的。所以现在我们已经完成了，
--the first two steps and next comes this orchestration step. 00:35:31,600 --> 00:35:35,560
前两个步骤，接下来是这个编排步骤。
--And this is where we need to put in, uh, 00:35:35,720 --> 00:35:38,360
这就是我们需要投入的地方，呃，
--the software primitives that allow the threads to actually communicate with each other, 00:35:38,360 --> 00:35:42,560
允许线程实际相互通信的软件原语，
--and synchronize with each other if they, whenever they need to do that. 00:35:42,560 --> 00:35:46,200
并在需要时相互同步。
--Okay. So here are the things that we need to worry about as a programmer, 00:35:46,200 --> 00:35:52,040
好的。所以这是我们作为程序员需要担心的事情，
--more generically for this step. 00:35:52,040 --> 00:35:53,920
更一般地用于此步骤。
--And you're going to see, um, this. 00:35:53,920 --> 00:35:56,360
你会看到，嗯，这个。
--And you're going to see examples of this as we go through our, 00:35:56,360 --> 00:36:00,120
当我们通过我们的，你会看到这样的例子，
--uh, demo program in a little bit here. 00:36:00,120 --> 00:36:03,200
呃，演示程序在这里一点点。
--But, uh, first of all, 00:36:03,360 --> 00:36:05,560
但是，呃，首先，
--you typically to, 00:36:05,560 --> 00:36:07,680
你通常会，
--to minimize the overhead of communicating, 00:36:07,680 --> 00:36:11,360
最小化通信开销，
--you want to be, uh, 00:36:11,360 --> 00:36:12,560
你想成为，呃，
--thoughtful about how you structure the code, 00:36:12,560 --> 00:36:15,720
深思熟虑你如何构建代码，
--uh, around the communication. 00:36:15,720 --> 00:36:17,640
呃，围绕沟通。
--For example, in message passing, uh, 00:36:17,640 --> 00:36:20,400
例如，在消息传递中，呃，
--messages are con- usually contiguous chunks of memory. 00:36:20,400 --> 00:36:24,280
消息通常是连续的内存块。
--And the overhead of sending each message is non-trivial. 00:36:24,280 --> 00:36:28,120
发送每条消息的开销是不小的。
--So it's in your interest to try to group together a number of, 00:36:28,120 --> 00:36:32,520
因此，尝试将一些组合在一起符合您的兴趣，
--a whole chunk of data to send to another thread. 00:36:32,520 --> 00:36:35,760
将一整块数据发送到另一个线程。
--Don't just send one byte or one word. 00:36:35,760 --> 00:36:38,000
不要只发送一个字节或一个字。
--You want to send a lot of things if you can. 00:36:38,000 --> 00:36:40,680
如果可以的话，你想寄很多东西。
--And by doing it less frequently, 00:36:40,680 --> 00:36:42,800
通过减少这样做的频率，
--then, uh, that helps to amortize the overhead of sending it. 00:36:42,800 --> 00:36:46,520
然后，呃，这有助于分摊发送它的开销。
--Now, on the other hand, 00:36:46,520 --> 00:36:47,760
现在，另一方面，
--if you go too extreme in that direction, 00:36:47,760 --> 00:36:49,440
如果你在那个方向上走得太极端，
--then you may be- end up stalling a lot. 00:36:49,440 --> 00:36:51,640
那么你可能会 - 最终拖延很多。
--Uh, so you have to be careful about that. 00:36:51,640 --> 00:36:53,720
呃，所以你必须小心。
--Okay. Now, another thing to think about is synchronization. 00:36:53,720 --> 00:36:57,600
好的。现在，要考虑的另一件事是同步。
--So if you're about to compute something but you're, uh, 00:36:57,600 --> 00:37:01,240
所以如果你要计算一些东西，但是你，呃，
--you depend on inputs from some other thread, 00:37:01,240 --> 00:37:03,200
你依赖于来自其他线程的输入，
--you need to make sure you don't start too early. 00:37:03,200 --> 00:37:05,360
你需要确保你不会太早开始。
--So that's another thing that you'll see. 00:37:05,360 --> 00:37:08,000
所以这是你会看到的另一件事。
--Um, and, uh, you know, 00:37:08,000 --> 00:37:11,040
嗯，还有，嗯，你知道的，
--you- you want to think about, uh, 00:37:11,040 --> 00:37:12,920
你-你想想想，呃，
--how you organize your data structures to, to help this. 00:37:12,920 --> 00:37:15,880
你如何组织你的数据结构来帮助这个。
--So if we do this well, um, 00:37:15,880 --> 00:37:18,840
所以如果我们做得好，嗯，
--this is a situation where we're trying to avoid some bad things. 00:37:18,840 --> 00:37:22,640
这是我们试图避免一些坏事的情况。
--So in particular, 00:37:22,640 --> 00:37:24,680
所以特别是，
--communicating and synchronizing can be potentially very expensive. 00:37:24,680 --> 00:37:29,480
通信和同步可能非常昂贵。
--So we want to do it in a way where we don't waste a lot of time doing that. 00:37:29,520 --> 00:37:33,600
所以我们希望以一种不会浪费很多时间的方式来做这件事。
--If you do it in a- in a good way, 00:37:33,600 --> 00:37:35,720
如果你以一种好的方式去做，
--then potentially when you get to the point of saying, okay, 00:37:35,720 --> 00:37:39,640
然后可能当你说，好吧，
--I need to receive a message from another thread, it's already there. 00:37:39,640 --> 00:37:43,200
我需要从另一个线程接收消息，它已经存在了。
--So you don't have to actually stall and wait for it. 00:37:43,200 --> 00:37:45,680
所以你不必真的停下来等待它。
--And if you want to grab a lock, 00:37:45,680 --> 00:37:47,360
如果你想抢一把锁，
--the lock is available, 00:37:47,360 --> 00:37:48,840
锁可用，
--maybe you even have it in your cache already. 00:37:48,840 --> 00:37:50,800
也许你甚至已经把它放在你的缓存中了。
--So that might be very fast. 00:37:50,800 --> 00:37:53,120
所以这可能非常快。
--Um, we want to worry about locality and minimize overheads. 00:37:53,120 --> 00:37:58,280
嗯，我们想担心局部性并尽量减少开销。
--So basically, uh, we want the code to behave correctly and waste 00:37:58,320 --> 00:38:02,720
所以基本上，呃，我们希望代码能够正确运行并浪费
--as little time as possible on all of this synchronization and communication. 00:38:02,720 --> 00:38:08,240
尽可能少的时间在所有这些同步和通信上。
--So last step here is, um, 00:38:08,320 --> 00:38:12,560
所以这里的最后一步是，嗯，
--mapping the- these virtual thread- the threads, uh, 00:38:12,560 --> 00:38:16,480
映射 - 这些虚拟线程 - 线程，呃，
--onto the actual hardware. 00:38:16,480 --> 00:38:18,320
到实际的硬件上。
--And, uh, we're not really going to talk much about that in this class. 00:38:18,320 --> 00:38:23,280
而且，呃，我们真的不会在这节课上谈论太多。
--Um, it's not- on the list of things that programmers worry about, 00:38:23,280 --> 00:38:26,880
嗯，这不在程序员担心的事情清单上，
--this is the lowest, uh, 00:38:26,880 --> 00:38:28,160
这是最低的，呃，
--thing on the list typically. 00:38:28,160 --> 00:38:30,600
通常是清单上的东西。
--So, uh, the way it often happens. 00:38:30,600 --> 00:38:33,480
所以，呃，它经常发生的方式。
--So in- in many cases, 00:38:33,480 --> 00:38:35,640
所以在很多情况下，
--if you think about just creating, uh, 00:38:35,640 --> 00:38:37,360
如果你只想着创造，呃，
--regular software threads like P threads, 00:38:37,360 --> 00:38:39,800
常规软件线程，如 P 线程，
--then it's really the operating system that's thinking 00:38:39,800 --> 00:38:42,240
那么真正在思考的是操作系统
--about how to map them onto processors. 00:38:42,240 --> 00:38:44,800
关于如何将它们映射到处理器。
--And in many cases, 00:38:44,800 --> 00:38:46,600
而且在很多情况下，
--it may not matter very much. 00:38:46,600 --> 00:38:48,200
这可能并不重要。
--If you have a large-scale system with a- with a particular type of interconnect, 00:38:48,200 --> 00:38:52,360
如果您有一个大型系统 - 具有特定类型的互连，
--then it may be more important to- to control that. 00:38:52,360 --> 00:38:55,640
那么控制它可能更重要。
--It can be done by the compiler, 00:38:55,680 --> 00:38:58,520
它可以由编译器完成，
--and that's what ISPC does because basically these, uh, 00:38:58,520 --> 00:39:02,320
这就是 ISPC 所做的，因为基本上这些，呃，
--virtual computation, uh, units, 00:39:02,320 --> 00:39:05,320
虚拟计算，呃，单位，
--these are actually vector slots. 00:39:05,320 --> 00:39:07,160
这些实际上是向量槽。
--So the compiler decides where they go in the vectors. 00:39:07,160 --> 00:39:10,960
所以编译器决定它们在向量中的位置。
--And, uh, in GPUs, 00:39:10,960 --> 00:39:13,080
而且，呃，在 GPU 中，
--this- this mapping is actually done by the hardware. 00:39:13,080 --> 00:39:16,240
 this- 这个映射实际上是由硬件完成的。
--So as an aside, you know, 00:39:16,240 --> 00:39:18,720
顺便说一句，你知道，
--one thing that might be interesting here is to what extent do you, you know, 00:39:18,720 --> 00:39:22,680
这里可能有趣的一件事是你在多大程度上，你知道，
--what- when you have to time multiplex threads onto the same hardware, um, okay. 00:39:22,680 --> 00:39:28,680
什么 - 当您必须将线程多路复用到同一硬件上时，嗯，好吧。
--Well, first of all, that's not necessarily something you always want to do, 00:39:28,680 --> 00:39:32,720
好吧，首先，这不一定是你一直想做的事情，
--um, in general, 00:39:32,720 --> 00:39:34,040
嗯，总的来说，
--but we heard, uh, last week or last Friday, 00:39:34,040 --> 00:39:36,120
但我们听说，呃，上周或上周五，
--we talked about how one way to tolerate latency of loading things is to have 00:39:36,120 --> 00:39:40,800
我们讨论了一种容忍加载延迟的方法是
--more concurrency than hardware resources so that you can actually swap between, 00:39:40,800 --> 00:39:46,280
比硬件资源更多的并发性，这样你就可以实际交换，
--uh, sets of threads, uh, 00:39:46,280 --> 00:39:48,120
呃，线程组，呃，
--so that you can hide the latency of a read miss, for example. 00:39:48,120 --> 00:39:51,280
例如，这样您就可以隐藏读取未命中的延迟。
--But- but given that once you start time multiplexing, 00:39:51,280 --> 00:39:54,200
但是-但是一旦你开始时间多路复用，
--the question is should you put, uh, 00:39:54,200 --> 00:39:56,200
问题是你应该把，呃，
--like related or unrelated threads together on the same piece of hardware? 00:39:56,200 --> 00:40:00,120
喜欢在同一块硬件上一起使用相关或不相关的线程吗？
--And it turns out that there are arguments for both things. 00:40:00,120 --> 00:40:03,440
事实证明，这两件事都有争论。
--If you put things that are closely related together, 00:40:03,440 --> 00:40:05,600
如果将密切相关的事物放在一起，
--maybe that's good for communication locality. 00:40:05,600 --> 00:40:08,200
也许这对本地通信有好处。
--But on the flip side, 00:40:08,200 --> 00:40:09,880
但另一方面，
--maybe they have exactly the same kind of performance bottleneck. 00:40:09,880 --> 00:40:13,320
也许他们有完全相同的性能瓶颈。
--Maybe, for example, they're both bandwidth limited. 00:40:13,320 --> 00:40:16,240
例如，也许它们都是带宽受限的。
--So putting them on the same processor may make 00:40:16,240 --> 00:40:18,640
所以把它们放在同一个处理器上可能会使
--that bandwidth problem even worse as opposed to putting 00:40:18,640 --> 00:40:22,240
与将带宽问题相比，带宽问题更糟
--together things that are more diverse in terms of their bottlenecks. 00:40:22,240 --> 00:40:26,880
将瓶颈更加多样化的事物放在一起。
--Okay. And then a last thing before we start to get into our example is, um, 00:40:26,880 --> 00:40:32,120
好的。然后在我们开始进入我们的例子之前的最后一件事是，嗯，
--my- the blob that I've, you know, 00:40:32,120 --> 00:40:35,040
我-我的一团东西，你知道的，
--I've shown you this picture of computation that we're dividing up. 00:40:35,040 --> 00:40:39,480
我已经向您展示了我们正在划分的这张计算图片。
--And technically, I was talking about computation, 00:40:39,480 --> 00:40:42,800
从技术上讲，我在谈论计算，
--but it's going to be very natural for you to also think about it as dividing up data. 00:40:42,800 --> 00:40:48,040
但是您也很自然地将其视为划分数据。
--So in programs where you're performing essentially the same computation or, 00:40:48,040 --> 00:40:53,120
所以在你执行基本相同计算的程序中，或者，
--or very similar computations on a whole lot of data, 00:40:53,120 --> 00:40:56,080
或对大量数据进行非常相似的计算，
--then you can think of it as just carving up the data structure and then doing 00:40:56,080 --> 00:41:00,640
那么你可以认为它只是分割数据结构然后做
--whatever you need to do to each part of the- those chunks of those data structures. 00:41:00,640 --> 00:41:06,240
无论您需要对这些数据结构的每个部分执行什么操作。
--Okay. So what we're going to do, uh, 00:41:06,240 --> 00:41:09,560
好的。那么我们要做的，呃，
--right now is take our, uh, 00:41:09,560 --> 00:41:11,200
现在是我们的，呃，
--two-minute intermission break, uh, 00:41:11,200 --> 00:41:13,400
两分钟中场休息，呃，
--and then after that, we will go through an example of a parallel program. 00:41:13,400 --> 00:41:17,560
然后，我们将通过一个并行程序的例子。
--So bad news, 00:41:17,560 --> 00:41:26,520
这么坏的消息，
--there's no quiz today, uh, 00:41:26,520 --> 00:41:28,680
今天没有测验，呃
--but, uh, stay tuned for that. 00:41:28,680 --> 00:41:32,600
但是，呃，敬请期待。
--Yeah. The worst news is there will be one on Friday. 00:41:32,600 --> 00:41:37,120
是的。最坏的消息是周五会有一个。
--Okay. 00:42:17,560 --> 00:42:42,440
好的。
--So what we're going to do now is, uh, 00:42:42,440 --> 00:42:45,960
所以我们现在要做的是，呃，
--go through our first example of a, of a parallel program. 00:42:45,960 --> 00:42:49,680
通过我们的第一个并行程序示例。
--And we need something that's simple enough that the code will fit on the slide, 00:42:49,680 --> 00:42:53,760
我们需要一些足够简单的东西，代码可以放在幻灯片上，
--and hopefully you'll even be able to read it, uh, from where you're sitting. 00:42:53,760 --> 00:42:57,680
并且希望你甚至能够阅读它，嗯，从你坐的地方。
--And what we're going to look at is a, 00:42:57,680 --> 00:43:00,200
我们要看的是，
--a simplified version of the ocean simulation. 00:43:00,200 --> 00:43:03,600
海洋模拟的简化版本。
--And, and remember the ocean simulation has, uh, 00:43:03,600 --> 00:43:07,000
而且，记住海洋模拟有，呃，
--these 2D arrays and we're updating each element based on some fancy partial differential equations. 00:43:07,000 --> 00:43:13,680
这些二维数组，我们正在根据一些奇特的偏微分方程更新每个元素。
--So we're going to, since we don't really, 00:43:13,720 --> 00:43:16,040
所以我们要去，因为我们真的没有，
--the math part, uh, 00:43:16,040 --> 00:43:17,760
数学部分，呃，
--isn't something that's super important for our discussion here. 00:43:17,760 --> 00:43:20,720
对我们在这里的讨论来说并不是特别重要的事情。
--So we're going to, uh, 00:43:20,720 --> 00:43:21,960
所以我们要，呃，
--grossly oversimplify the computation as just averaging together elements. 00:43:21,960 --> 00:43:27,080
将计算严重简化为仅将元素平均在一起。
--Now, it turns out that in terms of, uh, 00:43:27,080 --> 00:43:29,800
现在，结果表明，呃，
--communication and dependencies and all those things, that's perfectly fine. 00:43:29,800 --> 00:43:33,720
沟通和依赖关系以及所有这些都很好。
--We have the same communication patterns if we, 00:43:33,720 --> 00:43:36,600
如果我们有相同的沟通模式，
--even if we just simplify that. 00:43:36,600 --> 00:43:38,200
即使我们只是简化它。
--So, so the idea is we, uh, 00:43:38,200 --> 00:43:41,040
所以，所以我们的想法是，呃，
--to update a particular element here A, 00:43:41,080 --> 00:43:44,360
在此处更新特定元素 A，
--we are going to average together, 00:43:44,360 --> 00:43:46,880
我们要一起平均，
--um, it and its, its, uh, neighbors. 00:43:46,880 --> 00:43:50,120
嗯，它和它的，它的，呃，邻居。
--So we take, you know, 00:43:50,120 --> 00:43:52,120
所以我们采取，你知道的，
--itself and its four neighbors and we're going to average that together, 00:43:52,120 --> 00:43:56,240
它本身和它的四个邻居，我们要一起平均，
--and that's the new value. 00:43:56,240 --> 00:43:57,640
这就是新的价值。
--So that's, that's close enough for our purposes. 00:43:57,640 --> 00:44:01,560
就是这样，这对我们的目的来说已经足够接近了。
--Okay. And we have a n by n grid, um, 00:44:01,560 --> 00:44:06,280
好的。我们有一个 n 网格，嗯，
--but we're going to add, uh, 00:44:06,280 --> 00:44:07,600
但我们要添加，呃，
--some extra row on the top and the bottom. 00:44:07,600 --> 00:44:09,760
顶部和底部的一些额外行。
--So we actually have like an n plus 2 by an n plus 2 grid. 00:44:09,760 --> 00:44:13,320
所以我们实际上有一个 n 加 2 乘一个 n 加 2 的网格。
--And this is what the, uh, 00:44:13,320 --> 00:44:16,600
这就是，呃，
--sequential code looks like. 00:44:16,600 --> 00:44:18,000
顺序代码看起来像。
--So I'm going to just talk through these steps here because we're going to 00:44:18,000 --> 00:44:21,080
所以我将在这里讨论这些步骤，因为我们要
--be, uh, modifying this code, 00:44:21,080 --> 00:44:24,240
是，呃，修改这段代码，
--uh, three different ways for the different programming models. 00:44:24,240 --> 00:44:27,720
呃，针对不同编程模型的三种不同方式。
--Okay. So what's going on here? 00:44:27,720 --> 00:44:30,240
好的。那么这是怎么回事？
--Well, we have our, uh, 00:44:30,240 --> 00:44:32,040
嗯，我们有我们的，呃，
--2D array and we're just going to look at one array. 00:44:32,040 --> 00:44:34,920
二维数组，我们只看一个数组。
--Uh, actually, you would do this for all the different layers, 00:44:34,920 --> 00:44:37,240
呃，实际上，你会为所有不同的层做这个，
--but to simplify it, 00:44:37,240 --> 00:44:38,360
但为了简化它，
--we're just going to look at one 2D array. 00:44:38,520 --> 00:44:41,240
我们只看一个二维数组。
--And somehow that gets initialized and we're not worried about that part right now. 00:44:41,240 --> 00:44:45,600
不知何故，它被初始化了，我们现在不担心那部分。
--But in the solver, um, 00:44:45,600 --> 00:44:47,840
但是在求解器中，嗯，
--one of the things that it does is it iterates until it, 00:44:47,840 --> 00:44:51,080
它所做的其中一件事就是迭代直到它，
--it thinks that the computation has converged, uh, close enough. 00:44:51,080 --> 00:44:54,800
它认为计算已经收敛，呃，足够接近了。
--So to do that, 00:44:54,800 --> 00:44:56,880
所以要做到这一点，
--there is a test, um, that it computes. 00:44:56,880 --> 00:45:00,600
有一个测试，嗯，它计算。
--So if it thinks that you're finished, 00:45:00,600 --> 00:45:02,600
所以如果它认为你完成了，
--so you iterate until you're done. 00:45:02,600 --> 00:45:04,600
所以你迭代直到你完成。
--And the test for whether you're done is that there, 00:45:04,600 --> 00:45:08,240
测试你是否完成的是，
--it- as it's updating each element, 00:45:08,240 --> 00:45:10,960
它-因为它正在更新每个元素，
--it compares the new value with the previous value. 00:45:10,960 --> 00:45:14,240
它将新值与先前值进行比较。
--And then it adds up all the absolute value of all those differences. 00:45:14,240 --> 00:45:18,320
然后它将所有这些差异的所有绝对值加起来。
--And then it takes that and, 00:45:18,320 --> 00:45:21,480
然后它需要那个，
--uh, compares that to some threshold. 00:45:21,480 --> 00:45:23,720
呃，将其与某个阈值进行比较。
--So once that difference sort of drops below a threshold, 00:45:23,720 --> 00:45:27,080
所以一旦这种差异下降到阈值以下，
--then we stop iterating. 00:45:27,080 --> 00:45:28,360
然后我们停止迭代。
--So that's the outer loop around all of this stuff. 00:45:28,360 --> 00:45:31,080
这就是所有这些东西的外循环。
--And in the inner loop, it's fairly simple. 00:45:31,080 --> 00:45:33,200
在内部循环中，它相当简单。
--Okay. So, so because of that, 00:45:33,200 --> 00:45:34,960
好的。所以，正因为如此，
--we have this, uh, diff value. 00:45:34,960 --> 00:45:37,600
我们有这个，呃，差异值。
--That's the, uh, sum of the absolute value of 00:45:37,600 --> 00:45:40,240
那是，呃，绝对值的总和
--the differences over all the elements as we're updating them. 00:45:40,240 --> 00:45:43,320
我们更新所有元素时的差异。
--And then you have, uh, 00:45:43,320 --> 00:45:45,240
然后你有，呃，
--in the middle, we have a 2D loop. 00:45:45,240 --> 00:45:47,880
在中间，我们有一个二维循环。
--Uh, we just walk over both dimensions of the 2D array. 00:45:47,880 --> 00:45:51,560
呃，我们只是遍历二维数组的两个维度。
--And then we have to remember the old value so that we can calculate that difference. 00:45:51,560 --> 00:45:56,640
然后我们必须记住旧值，以便我们可以计算出差异。
--But then the key part is we just do this averaging that we saw on the previous slide. 00:45:56,640 --> 00:46:01,960
但关键部分是我们只是做我们在上一张幻灯片上看到的平均。
--So it's not too complicated. 00:46:01,960 --> 00:46:03,880
所以它并不太复杂。
--That's, that's the sequential code. 00:46:03,880 --> 00:46:05,520
那就是，那是顺序代码。
--So now we want to run this in parallel. 00:46:05,560 --> 00:46:07,800
所以现在我们想并行运行它。
--Okay. So, um, what do you- how, 00:46:07,800 --> 00:46:14,200
好的。所以，嗯，你是怎么做的，
--how can we run this in parallel? 00:46:14,200 --> 00:46:16,000
我们如何并行运行它？
--So any thoughts on that? 00:46:16,000 --> 00:46:18,680
那么对此有什么想法吗？
--Well, one of the things I mentioned is dependencies. 00:46:18,680 --> 00:46:23,200
好吧，我提到的其中一件事是依赖性。
--So, so first we want to think about what are, 00:46:23,200 --> 00:46:26,200
所以，首先我们要考虑什么是，
--what is our source of parallelisms? 00:46:26,200 --> 00:46:28,080
我们的并行性来源是什么？
--If we think about updating each of those different elements, 00:46:28,080 --> 00:46:31,200
如果我们考虑更新每个不同的元素，
--how do they depend on each other? 00:46:31,200 --> 00:46:33,400
他们如何相互依赖？
--Well, we're averaging an element with its neighbors, 00:46:33,400 --> 00:46:37,240
好吧，我们正在用它的邻居平均一个元素，
--its left, right, up, and down neighbors. 00:46:37,240 --> 00:46:39,600
它的左、右、上、下邻居。
--So as we go through those two loops, 00:46:39,600 --> 00:46:42,480
所以当我们经历这两个循环时，
--um, we calculate something here in the middle based on, 00:46:42,480 --> 00:46:47,280
嗯，我们在中间计算一些东西，基于，
--you know, these four things. 00:46:47,280 --> 00:46:49,120
你知道的，这四件事。
--So that, that means that the particular iteration of, you know, 00:46:49,120 --> 00:46:53,240
所以，这意味着特定的迭代，你知道，
--j depends on the thing we produce in the previous iteration of j. 00:46:53,240 --> 00:46:57,840
 j 取决于我们在 j 的前一次迭代中产生的东西。
--And also, you know, 00:46:57,840 --> 00:46:59,520
而且，你知道，
--depends on the element that we produced in 00:46:59,520 --> 00:47:02,000
取决于我们生产的元素
--the previous iteration of the outer loop also. 00:47:02,000 --> 00:47:06,280
外循环的前一次迭代也是如此。
--So these little red arrows are data dependencies. 00:47:06,280 --> 00:47:10,440
所以这些红色的小箭头是数据依赖。
--And you notice a lot of them there. 00:47:10,440 --> 00:47:12,640
你注意到那里有很多。
--So if we just say, hey, 00:47:12,640 --> 00:47:15,680
所以如果我们只是说，嘿，
--let's just run those loops in parallel, 00:47:15,680 --> 00:47:18,160
让我们并行运行这些循环，
--you know, what might happen? 00:47:18,160 --> 00:47:19,960
你知道，可能会发生什么？
--If we just ignore the dependencies, 00:47:19,960 --> 00:47:22,440
如果我们只是忽略依赖关系，
--what would, what would occur? 00:47:22,440 --> 00:47:24,640
会发生什么？
--Raising conditions? 00:47:24,640 --> 00:47:27,400
提高条件？
--Yeah, there'd be data races. 00:47:27,400 --> 00:47:29,080
是的，会有数据竞赛。
--So you'd get some answer, 00:47:29,080 --> 00:47:31,400
所以你会得到一些答案，
--um, and then you'd run it again and you'd get a different answer. 00:47:31,400 --> 00:47:34,040
嗯，然后你再次运行它，你会得到不同的答案。
--It would be non-deterministic and, uh, 00:47:34,040 --> 00:47:36,720
这将是不确定的，呃，
--basically things would be updating and not worrying about data dependencies. 00:47:36,720 --> 00:47:40,600
基本上事情会更新而不用担心数据依赖性。
--So maybe that's not so good. 00:47:40,600 --> 00:47:42,960
所以也许这不是很好。
--So is this hopeless? 00:47:42,960 --> 00:47:45,880
那么这是无望的吗？
--What do you, do you see any, any path forward here? 00:47:45,880 --> 00:47:49,120
你怎么看，你看到这里有什么前进的道路吗？
--What's, what's a way that we can, something we could do? Yeah. 00:47:49,120 --> 00:47:51,560
什么是我们可以做的事情？是的。
--So, uh, instead of, uh, 00:47:51,560 --> 00:47:54,520
所以，呃，而不是，呃，
--sort of, uh, having data races, 00:47:54,520 --> 00:47:56,200
有点，呃，有数据竞争，
--you can isolate, uh, the, the, uh, 00:47:56,200 --> 00:47:59,320
你可以隔离，呃，那个，呃，
--so you can first divide the grid into multiple parts, 00:47:59,320 --> 00:48:01,880
所以你可以先把网格分成多个部分，
--and you can isolate those parts, 00:48:01,880 --> 00:48:03,440
你可以隔离那些部分，
--and only communicate after, say, like 20 rounds. 00:48:03,440 --> 00:48:06,320
并且只在大约 20 轮之后进行交流。
--Okay. We could do that. 00:48:06,320 --> 00:48:08,120
好的。我们可以做到。
--We could, uh, we could, uh, 00:48:08,120 --> 00:48:10,560
我们可以，呃，我们可以，呃，
--like basic, that's one possibility. 00:48:10,560 --> 00:48:13,280
像基本的，这是一种可能性。
--Um, any, any other thoughts? 00:48:13,280 --> 00:48:15,480
嗯，还有其他想法吗？
--So we, we could, the programmer could decide that that was okay, 00:48:15,480 --> 00:48:18,280
所以我们，我们可以，程序员可以决定那没问题，
--that they were willing to do that. Any other thoughts? 00:48:18,280 --> 00:48:20,440
他们愿意这样做。还有其他想法吗？
--Yep. Uh, there's independence along the diagonals, so you can go along the diagonals. 00:48:20,440 --> 00:48:26,240
是的。呃，沿着对角线是独立的，所以你可以沿着对角线走。
--Yep. Exactly. So it turns out that along the diagonals, 00:48:26,240 --> 00:48:30,160
是的。确切地。所以事实证明，沿着对角线，
--there are, there is independence, as you just mentioned. 00:48:30,160 --> 00:48:32,600
有，有独立性，正如你刚才提到的。
--So once you do, uh, 00:48:32,600 --> 00:48:34,400
所以一旦你这样做了，呃，
--once you calculate this node here, 00:48:34,400 --> 00:48:36,360
一旦你在这里计算这个节点，
--you can actually go ahead and calculate these nodes. 00:48:36,360 --> 00:48:39,360
您实际上可以继续计算这些节点。
--Um, so we could, we could rewrite the loop structure, 00:48:39,360 --> 00:48:43,320
嗯，所以我们可以，我们可以重写循环结构，
--and then go along these diagonals, 00:48:43,320 --> 00:48:45,920
然后沿着这些对角线，
--and that would not have data races. 00:48:45,920 --> 00:48:48,280
那不会有数据竞争。
--What do you think about that performance-wise? 00:48:48,280 --> 00:48:50,840
您如何看待这种表现？
--How, any drawbacks to that? 00:48:50,840 --> 00:48:54,320
怎么样，有什么缺点吗？
--Yep. Um, not all the diagonals are that long. 00:48:54,320 --> 00:48:59,440
是的。嗯，并不是所有的对角线都那么长。
--So, like, especially the end diagonals, 00:48:59,440 --> 00:49:02,720
所以，特别是末端对角线，
--a lot of the working threads would just be sitting there for a little bit. 00:49:02,720 --> 00:49:07,280
许多工作线程只会在那里停留一会儿。
--Yeah. So some of those diagonals are really short, 00:49:07,280 --> 00:49:09,640
是的。所以其中一些对角线真的很短，
--so we wouldn't have enough work to keep a lot of processors busy necessarily. 00:49:09,640 --> 00:49:12,640
所以我们没有足够的工作来让很多处理器必然忙碌。
--Yeah. Or it's cache performance. 00:49:12,640 --> 00:49:14,640
是的。或者是缓存性能。
--Right? So we're going to be accessing data in some weird diagonal access pattern, 00:49:14,640 --> 00:49:19,440
正确的？所以我们将以某种奇怪的对角线访问模式访问数据，
--so that's probably not great for spatial locality. 00:49:19,440 --> 00:49:22,000
所以这可能不适合空间局部性。
--And another thing is that there'd be a little, 00:49:22,000 --> 00:49:24,320
另一件事是会有一点，
--there'd be more software overhead to calculate 00:49:24,320 --> 00:49:26,840
会有更多的软件开销来计算
--the indices if we're going along diagonals probably. 00:49:26,840 --> 00:49:30,200
如果我们沿着对角线走的话可能是指数。
--So this is, um, 00:49:30,200 --> 00:49:32,000
所以这是，嗯，
--so we're not going to do this. 00:49:32,000 --> 00:49:34,120
所以我们不打算这样做。
--Um, any other thoughts? 00:49:34,120 --> 00:49:36,360
嗯，还有其他想法吗？
--So, okay. So we are going to, 00:49:36,360 --> 00:49:39,240
所以，好吧。所以我们要，
--in a similar spirit to the suggestion that we just like relax the order a bit, 00:49:39,240 --> 00:49:44,520
本着与我们只是想放宽订单的建议类似的精神，
--we are going to relax things. 00:49:44,560 --> 00:49:46,120
我们要放松一下。
--Um, but here's what, what we're going to do. 00:49:46,120 --> 00:49:48,480
嗯，但这就是我们要做的。
--Oh, was there another comment? 00:49:48,480 --> 00:49:50,280
哦，还有其他评论吗？
--So like, could you just use the old array entirely and like make a new array that's useful? 00:49:50,280 --> 00:49:55,240
那么，你能不能完全使用旧数组，然后创建一个有用的新数组？
--Okay. That's a good, uh, good, good suggestion. 00:49:55,240 --> 00:49:58,200
好的。这是一个很好，呃，很好，很好的建议。
--So one thing that you may worry about with, uh, 00:49:58,200 --> 00:50:01,200
所以有一件事你可能会担心，呃，
--data races where the problem is we're in the middle of 00:50:01,200 --> 00:50:03,560
问题在于我们正处于数据竞争之中
--updating something and we're reading that thing that we're updating, 00:50:03,560 --> 00:50:07,160
更新一些东西，我们正在阅读我们正在更新的东西，
--and that's causing the data races. 00:50:07,160 --> 00:50:08,520
这导致了数据竞争。
--So one possibility would be create two copies of the matrix, 00:50:08,520 --> 00:50:12,800
所以一种可能性是创建矩阵的两个副本，
--have, and then you would basically flip back and forth one, in one iteration. 00:50:12,800 --> 00:50:17,400
有，然后你基本上会在一次迭代中来回翻转一个。
--One of them would be the input and you'd be writing in the other one, 00:50:17,400 --> 00:50:20,040
其中一个将是输入，而您将在另一个中写入，
--and then the next time you would go the other direction. 00:50:20,040 --> 00:50:22,640
然后下一次你会去另一个方向。
--So if you did that, 00:50:22,640 --> 00:50:23,840
所以如果你这样做，
--then you would only be reading from something that wasn't changing. 00:50:23,840 --> 00:50:27,160
那么你只会从没有改变的东西中阅读。
--And so that, that would work. 00:50:27,160 --> 00:50:29,240
这样，那将起作用。
--Um, the reason we won't do that is it turns out, um, 00:50:29,240 --> 00:50:33,120
嗯，我们不这样做的原因是事实证明，嗯，
--that scientific programmers perhaps 00:50:33,120 --> 00:50:35,400
科学程序员也许
--irrationally are unwilling to duplicate data like this. 00:50:35,400 --> 00:50:39,200
非理性地不愿意复制这样的数据。
--Because what they want to do is fill all of the memory in the machine, 00:50:39,200 --> 00:50:42,640
因为他们要做的是填满机器中的所有内存，
--uh, with data and they're not even willing to cut that in half usually. 00:50:42,640 --> 00:50:47,440
呃，有了数据，他们通常甚至不愿意把它减半。
--So, uh, most scientific programmers would just say that's a non-starter. 00:50:47,440 --> 00:50:51,800
所以，呃，大多数科学程序员只会说这是不可能的。
--Um, you can argue about whether that makes sense or not, 00:50:51,800 --> 00:50:54,040
嗯，你可以争论这是否有意义，
--but that's, that's the way they think. 00:50:54,040 --> 00:50:55,680
但这就是他们的想法。
--Okay. So it turns out that there's something that's almost like that, 00:50:55,680 --> 00:51:00,720
好的。所以事实证明有一些东西几乎是这样的，
--um, that is, uh, slightly different. 00:51:00,720 --> 00:51:04,720
嗯，也就是说，呃，有点不同。
--So if I showed you a, a chessboard, 00:51:04,720 --> 00:51:08,480
所以如果我给你看一个棋盘
--um, maybe that would give you an idea about what we could do. 00:51:08,480 --> 00:51:12,360
嗯，也许这会让你知道我们能做什么。
--So there's something called red-black ordering. 00:51:12,560 --> 00:51:15,000
所以有一种叫做红黑排序的东西。
--And the idea here is instead of updating all of the elements at one time in one phase, 00:51:15,000 --> 00:51:21,040
这里的想法不是在一个阶段一次更新所有元素，
--we update all of the red elements in a chessboard, 00:51:21,040 --> 00:51:26,040
我们更新棋盘中的所有红色元素，
--and then we go back and we update all the black elements. 00:51:26,040 --> 00:51:29,200
然后我们回去更新所有的黑色元素。
--And this effectively gets us something similar to what we would get when we, 00:51:29,200 --> 00:51:33,960
这有效地让我们得到了类似于我们会得到的东西，
--if we had two copies of the entire, uh, array, 00:51:33,960 --> 00:51:36,920
如果我们有整个，呃，数组的两个副本，
--which is now when I'm updating, um, 00:51:36,920 --> 00:51:40,360
现在是我更新的时候，嗯，
--something that's red, I only have to read itself, 00:51:40,360 --> 00:51:43,920
红色的东西，我只需要阅读它自己，
--which isn't a problem, 00:51:43,920 --> 00:51:44,960
这不是问题，
--and other elements that are black. 00:51:44,960 --> 00:51:47,080
和其他黑色元素。
--And the black elements are not being updated right now. 00:51:47,080 --> 00:51:49,720
黑色元素现在没有更新。
--So they should all, uh, 00:51:49,720 --> 00:51:51,240
所以他们都应该，呃，
--stay the same throughout this phase. 00:51:51,240 --> 00:51:53,400
在整个阶段保持不变。
--And then you flip and then you do the other color reading other elements. 00:51:53,400 --> 00:51:57,640
然后你翻转然后你做其他颜色阅读其他元素。
--Now, this technically, this changes the output compared to the sequential program. 00:51:57,640 --> 00:52:02,680
现在，从技术上讲，与顺序程序相比，这改变了输出。
--You're not getting exactly the same answer you would have 00:52:02,680 --> 00:52:05,440
你没有得到完全相同的答案
--gotten if you just went through sequentially. 00:52:05,440 --> 00:52:07,320
如果您只是按顺序进行，就会得到。
--But, um, it turns out usually for these kinds of simulations, 00:52:07,320 --> 00:52:11,280
但是，嗯，结果通常是对于这些类型的模拟，
--um, this is probably close enough. 00:52:11,280 --> 00:52:13,400
嗯，这可能足够接近了。
--And also it does have the advantage that it is deterministic. 00:52:13,400 --> 00:52:16,600
而且它确实具有确定性的优点。
--So we got rid of the data races, um, 00:52:16,600 --> 00:52:18,960
所以我们摆脱了数据竞争，嗯，
--and we didn't have to double, uh, 00:52:18,960 --> 00:52:21,280
而且我们不必加倍，呃，
--the number of elements, 00:52:21,280 --> 00:52:22,480
元素的数量，
--but we didn't have to duplicate the whole thing. 00:52:22,480 --> 00:52:24,440
但我们不必复制整个过程。
--So this is what we'll do. 00:52:24,440 --> 00:52:26,680
所以这就是我们要做的。
--Okay. So now, okay. 00:52:26,680 --> 00:52:30,040
好的。所以现在，好吧。
--So what should be the gra- oh, question? 00:52:30,040 --> 00:52:33,640
那么问题应该是什么？
--So in that case, when we- once we- once we update the red first, 00:52:33,640 --> 00:52:38,480
所以在那种情况下，当我们-一旦我们-一旦我们首先更新红色，
--then when we go to update the black, 00:52:38,480 --> 00:52:39,960
然后当我们去更新黑色时，
--aren't the blacks surrounded by updated reds? 00:52:39,960 --> 00:52:42,120
黑色不是被更新的红色包围了吗？
--Yeah. So they will need- they will get the updated reds. 00:52:42,120 --> 00:52:45,720
是的。所以他们将需要——他们将获得更新的红色。
--Um, but, um, as long as we make sure that all those updates to the reds have 00:52:45,720 --> 00:52:50,440
嗯，但是，嗯，只要我们确保对红色的所有更新都有
--been properly pushed out and everybody can see them, 00:52:50,440 --> 00:52:53,720
被适当地推出，每个人都可以看到它们，
--then there shouldn't be any data races. 00:52:53,720 --> 00:52:55,120
那么就不应该有任何数据竞争。
--So we have to entirely separate those two phases. 00:52:55,120 --> 00:52:58,840
所以我们必须将这两个阶段完全分开。
--Uh, before- you don't want to, like, 00:52:58,840 --> 00:53:01,600
呃，之前-你不想，比如，
--when you're finishing the updates to the reds, 00:53:01,640 --> 00:53:03,760
当你完成对红色的更新时，
--you don't want any processors to be running ahead and starting to do updates to 00:53:03,760 --> 00:53:07,240
您不希望任何处理器提前运行并开始更新
--the blacks while other ones haven't finished doing updates to the reds. 00:53:07,240 --> 00:53:10,440
黑人，而其他人还没有完成对红色的更新。
--So there's a synchronization point in the middle called a barrier, 00:53:10,440 --> 00:53:13,960
所以中间有一个同步点叫做屏障，
--where we force all the threads to catch up before we move on to the next phase. 00:53:13,960 --> 00:53:18,040
在进入下一阶段之前，我们强制所有线程赶上进度。
--So if we do that, 00:53:18,040 --> 00:53:19,160
所以如果我们这样做，
--then, uh, it will be deterministic. 00:53:19,160 --> 00:53:21,520
然后，呃，这将是确定性的。
--If we didn't, then we'd have a problem. 00:53:21,520 --> 00:53:23,680
如果我们不这样做，那我们就有麻烦了。
--So in- in the parentheses there, 00:53:23,680 --> 00:53:26,400
所以在括号里，
--it says- it says respect dependency on red cells, 00:53:26,400 --> 00:53:28,720
它说-它说尊重对红细胞的依赖，
--but it doesn't respect the dependency on red cells, right? 00:53:28,720 --> 00:53:31,320
但它不尊重对红细胞的依赖，对吧？
--Uh, let's see. 00:53:31,320 --> 00:53:37,080
嗯，让我们看看。
--Well, in other words, it's using the red cells from 00:53:37,080 --> 00:53:39,400
嗯，换句话说，它使用的是来自
--this time step as opposed to the previous time step, right? 00:53:39,400 --> 00:53:41,480
这个时间步与之前的时间步相对，对吧？
--So it's not- it's actually- it's realizing it doesn't need to respect that dependency. 00:53:41,480 --> 00:53:45,360
所以它不是——实际上是——它意识到它不需要尊重这种依赖性。
--Yes, that's right. Yeah, that's correct. 00:53:45,360 --> 00:53:47,640
恩，那就对了。是的，这是正确的。
--Um, yeah, there is some communication that used to occur. 00:53:47,640 --> 00:53:51,200
嗯，是的，曾经有过一些交流。
--When we look in the- we'll go look at the different programming models and, 00:53:51,200 --> 00:53:54,480
当我们查看 - 我们将查看不同的编程模型，并且，
--uh, hopefully make that clear. 00:53:54,480 --> 00:53:56,160
呃，希望能说清楚。
--I- I mean, that's not a very clear sentence though on this. 00:53:56,160 --> 00:53:58,600
我-我的意思是，这不是一个非常明确的句子。
--Uh, so stay tuned, uh, 00:53:58,600 --> 00:54:00,160
嗯，敬请期待，嗯，
--and then hopefully it'll be more clear what that means. 00:54:00,160 --> 00:54:02,440
然后希望它会更清楚这意味着什么。
--Okay. So- so what should the tasks be? 00:54:02,440 --> 00:54:06,600
好的。那么-那么任务应该是什么？
--We have, um, it could be individual grid elements, 00:54:06,600 --> 00:54:10,600
我们有，嗯，它可以是单独的网格元素，
--but we have a gigantic number of them. 00:54:10,600 --> 00:54:13,040
但是我们有很多。
--We have n squared grid elements, 00:54:13,040 --> 00:54:15,320
我们有 n 个平方网格元素，
--and I'll just go ahead and tell you that n is going- 00:54:15,320 --> 00:54:17,440
我会继续告诉你 n 会 -
--n itself is typically going to be much larger than p. 00:54:17,440 --> 00:54:20,920
 n 本身通常会比 p 大得多。
--So we don't need to make individual grid elements the tasks. 00:54:20,920 --> 00:54:25,840
所以我们不需要将单个网格元素作为任务。
--Instead, how- let's make, uh, 00:54:25,840 --> 00:54:28,800
相反，如何-让我们做，呃，
--rows of the matrix tasks because that's still more than enough tasks for our purposes. 00:54:28,800 --> 00:54:35,600
矩阵任务的行，因为对于我们的目的来说，这些任务仍然绰绰有余。
--So one question is, okay, 00:54:35,600 --> 00:54:38,360
所以一个问题是，好吧，
--so rows will be our tasks, 00:54:38,360 --> 00:54:40,600
所以行将是我们的任务，
--and then the next thing is to bundle them together so that we 00:54:40,600 --> 00:54:44,160
接下来就是将它们捆绑在一起，这样我们
--have, uh, the right number of bundles for p processors. 00:54:44,160 --> 00:54:48,280
有，呃，p 个处理器的正确数量的捆绑包。
--So here- here are two options. 00:54:48,280 --> 00:54:50,680
所以在这里-这里有两个选择。
--We could do them, uh, 00:54:50,680 --> 00:54:52,320
我们可以做到，呃，
--like I've shown here, 00:54:52,320 --> 00:54:54,000
就像我在这里展示的那样，
--where we- if we had- if we were targeting four processors, 00:54:54,000 --> 00:54:58,120
我们——如果我们有——如果我们的目标是四个处理器，
--we could, uh, 00:54:58,120 --> 00:54:59,520
我们可以，呃，
--do contiguous sets of rows as the, 00:54:59,520 --> 00:55:03,360
将连续的行集作为，
--um, the- the bundles, 00:55:03,360 --> 00:55:05,040
嗯，那-捆绑包，
--or we could do this. 00:55:05,040 --> 00:55:06,800
或者我们可以这样做。
--We could interleave them. 00:55:06,800 --> 00:55:07,920
我们可以将它们交织在一起。
--So we could just go, you know, 00:55:07,920 --> 00:55:09,360
所以我们可以走了，你知道的，
--0, 1, 2, 3, 4, 0, 1, 2, 3, 0, 1, 2, 3. 00:55:09,360 --> 00:55:12,280
 0、1、2、3、4、0、1、2、3、0、1、2、3。
--This is actually 1, 2, 3, 4. 00:55:12,280 --> 00:55:14,280
这实际上是 1、2、3、4。
--So this is another option. 00:55:14,280 --> 00:55:17,040
所以这是另一种选择。
--Okay. So which of these is better or does it matter? 00:55:17,040 --> 00:55:21,800
好的。那么这些哪个更好或者重要吗？
--Well, actually, whoops, the answer's on there. 00:55:21,800 --> 00:55:25,160
好吧，实际上，哎呀，答案就在那里。
--Okay. Well, it depends. 00:55:25,160 --> 00:55:26,960
好的。这得看情况。
--We'll actually spend a while, uh, okay. 00:55:26,960 --> 00:55:29,880
我们实际上会花一段时间，呃，好吧。
--Well, how can we think about this? 00:55:29,880 --> 00:55:32,200
好吧，我们该如何考虑呢？
--So let's say for- for starters, 00:55:32,200 --> 00:55:34,240
所以让我们说 - 对于初学者来说，
--let's imagine that we're targeting not a GPU or SIMD vector instructions, 00:55:34,240 --> 00:55:38,760
假设我们的目标不是 GPU 或 SIMD 矢量指令，
--but we're just targeting, uh, threads on cores. 00:55:38,760 --> 00:55:41,880
但我们只是针对，呃，核心线程。
--That's the machine that we're targeting. 00:55:41,880 --> 00:55:43,960
这就是我们的目标机器。
--And another thing that I should mention, 00:55:43,960 --> 00:55:47,320
还有一件事我要提一下，
--which, uh, someone asked about before, 00:55:47,320 --> 00:55:50,680
呃，之前有人问过，
--is we have to make sure that before you move on to 00:55:50,680 --> 00:55:55,080
我们必须确保在你继续之前
--the next phase of- of updating the black elements and vice versa, 00:55:55,080 --> 00:55:59,280
下一阶段更新黑色元素，反之亦然，
--that you make sure that all the threads have finished updating the previous color. 00:55:59,280 --> 00:56:03,720
您确保所有线程都已完成更新以前的颜色。
--So there's a synchronization step here where you- you do- you're working on 00:56:03,720 --> 00:56:08,600
所以这里有一个同步步骤，你 - 你 - 你正在处理
--the red cells and you have to make sure that- that everybody has caught up. 00:56:08,600 --> 00:56:13,440
红细胞，你必须确保 - 每个人都赶上了。
--And once they've all caught up, 00:56:13,440 --> 00:56:15,160
一旦他们都赶上了，
--then, uh, you will need to read values that were produced pro- 00:56:15,160 --> 00:56:19,800
然后，呃，你将需要读取亲生成的值
--possibly by other processors in the previous step. 00:56:19,800 --> 00:56:23,320
可能由上一步中的其他处理器执行。
--So that's going to involve communication. 00:56:23,320 --> 00:56:26,320
所以这将涉及沟通。
--So with that in mind, um, 00:56:26,320 --> 00:56:29,400
考虑到这一点，嗯，
--if our goal is to minimize communication, 00:56:29,400 --> 00:56:32,400
如果我们的目标是尽量减少沟通，
--then, uh, there is a difference between these two approaches. 00:56:32,400 --> 00:56:36,320
那么，呃，这两种方法之间是有区别的。
--So if you- when- when do you need to communicate? 00:56:36,320 --> 00:56:40,720
所以如果你——什么时候——什么时候需要沟通？
--Well, I- if I'm- if I'm updating some internal node in the middle of my, uh, block here, 00:56:40,720 --> 00:56:47,840
好吧，我-如果我-如果我在我的，呃，块这里更新一些内部节点，
--I only need, uh, these other nodes. 00:56:47,880 --> 00:56:51,600
我只需要，呃，这些其他节点。
--And if these are all ones that are assigned to me and they were in my cache or my local memory, 00:56:51,600 --> 00:56:57,400
如果这些都是分配给我的并且它们在我的缓存或本地内存中，
--then I can read the values I generated the last time without communicating with any other processor. 00:56:57,400 --> 00:57:03,120
然后我可以读取上次生成的值，而无需与任何其他处理器通信。
--However, when I'm updating this element here, uh, along a boundary. 00:57:03,120 --> 00:57:09,360
但是，当我在这里更新这个元素时，嗯，沿着边界。
--So for that one, 00:57:09,360 --> 00:57:10,880
所以对于那个，
--I'm going to need all of these elements and this one here was produced by another processor. 00:57:10,880 --> 00:57:17,400
我将需要所有这些元素，而这里的这个元素是由另一个处理器生成的。
--So there has to be communication between processors, uh, 00:57:17,440 --> 00:57:20,960
所以处理器之间必须有通信，呃，
--along the boundaries between these sets of rows that we give to the processors. 00:57:20,960 --> 00:57:25,840
沿着我们给处理器的这些行集之间的边界。
--So, um, so I've highlighted in gray. 00:57:25,840 --> 00:57:29,200
所以，嗯，所以我用灰色突出显示。
--If you do it block-wise, 00:57:29,200 --> 00:57:31,200
如果你按块做，
--then you only communicate by- along these block boundaries. 00:57:31,200 --> 00:57:34,840
那么你只能通过这些块边界进行通信。
--If you do it interleaved, 00:57:34,840 --> 00:57:36,760
如果你交错地做，
--there's actually going to be many more boundaries. 00:57:36,760 --> 00:57:39,560
实际上会有更多的界限。
--Essentially, every row is now on a boundary. 00:57:39,560 --> 00:57:42,080
本质上，每一行现在都在边界上。
--So there'll be more communication because of that. 00:57:42,080 --> 00:57:44,880
因此会有更多的交流。
--So- so on a- on a- on an idealized machine, 00:57:44,880 --> 00:57:49,920
所以-在-在-在理想化的机器上，
--um, the case on the left would probably be much better just because of communication. 00:57:49,920 --> 00:57:54,600
嗯，左边的情况可能因为沟通会好很多。
--Now, there are a lot of other things that go on in the memory system. 00:57:54,600 --> 00:57:57,360
现在，记忆系统中还有很多其他事情在进行。
--So, uh, we'll come back and revisit this next week and talk 00:57:57,360 --> 00:58:00,680
所以，呃，我们下周会回来重新讨论这个问题并谈谈
--about, uh, why there are other reasons why that may or may not be the best approach. 00:58:00,680 --> 00:58:05,240
关于，呃，为什么还有其他原因可能是也可能不是最好的方法。
--But for- for now, 00:58:05,240 --> 00:58:07,640
但是暂时，
--we're going to go forward with this assignment on the left. 00:58:07,640 --> 00:58:11,040
我们将继续进行左侧的这项任务。
--That's how we're going to divide up the work. 00:58:11,040 --> 00:58:12,960
这就是我们要分工的方式。
--Okay. So it's time to now look at, uh, 00:58:12,960 --> 00:58:17,280
好的。所以现在是时候看看，呃，
--uh, these three different versions of the code, 00:58:17,280 --> 00:58:19,480
呃，这三个不同版本的代码，
--and we're going to start with data parallel. 00:58:19,480 --> 00:58:21,760
我们将从并行数据开始。
--So, okay, here's the code for the data parallel version of this co- of this program. 00:58:21,760 --> 00:58:30,240
所以，好吧，这是这个程序的数据并行版本的代码。
--And the thing that, uh, 00:58:30,240 --> 00:58:32,000
还有那个，呃，
--will strike you, uh, potenti- potentially, 00:58:32,000 --> 00:58:34,920
会打击你，呃，潜在的，潜在的，
--and it'll especially be clear as we look at the other two versions, 00:58:34,920 --> 00:58:38,480
当我们查看其他两个版本时，它会特别清楚，
--is that not that much has changed in some- in some sense. 00:58:38,480 --> 00:58:42,320
是不是在某些方面发生了太大的变化——在某种意义上。
--So a- a feature of the data parallel programming paradigm is 00:58:42,360 --> 00:58:46,480
所以a-数据并行编程范例的一个特征是
--that the language and runtime system do a lot of the heavy lifting for you. 00:58:46,480 --> 00:58:50,480
语言和运行时系统为你做了很多繁重的工作。
--As a programmer, mostly what you do is just effectively point at things and say, 00:58:50,480 --> 00:58:55,600
作为一名程序员，大部分时间你所做的只是有效地指出事物并说，
--yeah, do that in parallel there. 00:58:55,600 --> 00:58:58,400
是的，在那里并行进行。
--Um, you know, I want to divide this up, um, along, you know, 00:58:58,400 --> 00:59:02,800
嗯，你知道，我想把它分开，嗯，一起，你知道，
--chunks of rows, make it happen system, 00:59:02,800 --> 00:59:06,120
大块的行，让它发生系统，
--and then it kind of fills in a lot of the details for you. 00:59:06,120 --> 00:59:09,520
然后它会为您填写很多细节。
--So what we did here is in the solver, um, 00:59:09,560 --> 00:59:14,160
所以我们在这里所做的是在求解器中，嗯，
--we were parallelizing, um, 00:59:14,160 --> 00:59:17,440
我们正在并行化，嗯，
--we're only parallelizing along the outer loop. 00:59:17,440 --> 00:59:20,480
我们只是沿着外循环并行化。
--So we don't- we- we parallelize along this loop, 00:59:20,480 --> 00:59:24,080
所以我们不-我们-我们沿着这个循环并行化，
--not- not along this one because entire rows always get assigned the same process. 00:59:24,080 --> 00:59:29,520
不-不沿着这一行，因为总是为整行分配相同的过程。
--So we don't need to put a- a- any special primitive around that. 00:59:29,520 --> 00:59:33,760
所以我们不需要在它周围放一个- 一个- 任何特殊的原语。
--But we have a for all command here, 00:59:33,760 --> 00:59:36,400
但是我们这里有一个 for all 命令，
--which is like the for each that I mentioned for ISTC. 00:59:36,400 --> 00:59:39,120
这就像我为 ISTC 提到的每个。
--This tells the- the language that these iterations can be done in parallel. 00:59:39,120 --> 00:59:44,440
这告诉语言这些迭代可以并行完成。
--And in fact, we would all- it's not shown here, 00:59:44,440 --> 00:59:46,800
事实上，我们都会-这里没有显示，
--but we would also give it a hint that would say, um, 00:59:46,800 --> 00:59:49,960
但我们也会给它一个提示，说，嗯，
--and please group them in contiguous blocks. 00:59:49,960 --> 00:59:53,720
并将它们分组在连续的块中。
--So now, we could leave that up to the system. 00:59:53,720 --> 00:59:56,280
所以现在，我们可以将其留给系统。
--It could maybe just do it however it wants to, 00:59:56,280 --> 00:59:58,240
它可以随心所欲地做，
--but we could- in these data parallel languages, 00:59:58,240 --> 01:00:00,680
但我们可以——在这些数据并行语言中，
--you can often give it a hint like that. 01:00:00,680 --> 01:00:02,920
你可以经常给它这样的提示。
--Um, we're not showing that hint here. 01:00:02,920 --> 01:00:05,480
嗯，我们不在这里显示该提示。
--Okay. So what else is different? 01:00:05,480 --> 01:00:07,160
好的。那么还有什么不同呢？
--Well, not much is different. 01:00:07,160 --> 01:00:09,240
嗯，没什么不同。
--Another thing that you see here is that at the part where we were adding up, um, 01:00:09,240 --> 01:00:13,840
你在这里看到的另一件事是，在我们加起来的部分，嗯，
--the- those, uh, absolute values of the differences between the old and new values, 01:00:13,840 --> 01:00:18,680
那些，呃，新旧值之差的绝对值，
--uh, that has to be a special kind of reduction operation because when- 01:00:18,680 --> 01:00:23,320
呃，这一定是一种特殊的归约操作，因为当-
--remember when I talked about ISPC and how you couldn't put, uh, 01:00:23,320 --> 01:00:27,720
记得当我谈到 ISPC 时，你怎么不能把，呃，
--the- the, um, you had to be careful about how you were doing a reduction in that code. 01:00:27,720 --> 01:00:32,080
那——那，嗯，你必须小心你是如何减少那段代码的。
--Well, the same thing happens here. 01:00:32,080 --> 01:00:33,800
好吧，同样的事情发生在这里。
--What you wanted to do is compute partial sums locally and then add them up serial later. 01:00:33,800 --> 01:00:39,480
您想要做的是在本地计算部分和，然后稍后将它们相加。
--So this r- reduce add does that. 01:00:39,480 --> 01:00:42,760
所以这个 r-reduce add 就是这样做的。
--It will put in all of the work to do that. 01:00:42,760 --> 01:00:45,960
它将投入所有工作来做到这一点。
--Um, but basically, um, 01:00:45,960 --> 01:00:48,200
嗯，但基本上，嗯，
--the code changed very little here. 01:00:48,200 --> 01:00:50,360
这里的代码变化很小。
--Uh, we just pointed to things and said, 01:00:50,360 --> 01:00:52,280
呃，我们只是指着东西说，
--that's a source of parallelism, do it that way. 01:00:52,280 --> 01:00:54,760
那是并行性的来源，就那样做。
--Okay. So that- that was quick. 01:00:54,760 --> 01:00:58,080
好的。所以那-那很快。
--Um, now, let's look at the other models. 01:00:58,080 --> 01:01:02,960
嗯，现在，让我们看看其他模型。
--And the point of this exercise is not for me to convince you that data parallel is the best thing ever. 01:01:02,960 --> 01:01:07,080
这个练习的目的不是要让你相信数据并行是有史以来最好的事情。
--Um, sometimes it works really well if you have very regular data structures, 01:01:07,080 --> 01:01:11,120
嗯，如果你有非常规则的数据结构，有时它会工作得很好，
--but as your code gets more irregular, 01:01:11,120 --> 01:01:13,280
但是随着你的代码变得更加不规则，
--it may not map very well. 01:01:13,280 --> 01:01:14,760
它可能无法很好地映射。
--But let's- now, let's compare this with, 01:01:14,760 --> 01:01:17,080
但是让我们-现在，让我们比较一下，
--uh, how we would do this in the other two models. 01:01:17,080 --> 01:01:19,520
呃，我们将如何在其他两个模型中做到这一点。
--So first, we'll look at the shared address space code. 01:01:19,520 --> 01:01:23,920
因此，首先，我们将查看共享地址空间代码。
--Okay. So I showed this picture before and it's going to become more- okay. 01:01:23,920 --> 01:01:30,920
好的。所以我之前展示过这张照片，它会变得更-好吧。
--Both shared address space and message passing, 01:01:30,920 --> 01:01:34,000
共享地址空间和消息传递，
--those parallel programming abstractions are a bit lower level. 01:01:34,000 --> 01:01:38,080
那些并行编程抽象级别较低。
--The programmer has to fill in some more detail than what you just saw with data parallel, 01:01:38,080 --> 01:01:43,160
程序员必须填写一些比你刚刚看到的数据并行更多的细节，
--where the language or compiler was doing almost all of the interesting stuff for us. 01:01:43,160 --> 01:01:47,480
语言或编译器为我们做了几乎所有有趣的事情。
--So the way that this will work is, 01:01:47,480 --> 01:01:50,760
所以这将起作用的方式是，
--we'll have a computation phase where you update all of one color, 01:01:50,760 --> 01:01:55,480
我们将有一个计算阶段，您可以在其中更新所有一种颜色，
--and then you have to wait until everyone catches up. 01:01:55,480 --> 01:01:58,760
然后你必须等到每个人都赶上来。
--And there's a special primitive for that called a barrier. 01:01:58,760 --> 01:02:01,720
并且有一个特殊的原语称为屏障。
--So a barrier is something that says, okay, 01:02:01,720 --> 01:02:04,680
所以障碍是说，好吧，
--everybody has to wait until everybody catches up, 01:02:04,680 --> 01:02:06,880
每个人都必须等到每个人都赶上，
--and then you can go forward after that. 01:02:06,880 --> 01:02:08,800
然后你可以继续前进。
--So the- the- these yellow things are barriers. 01:02:08,800 --> 01:02:11,800
所以-这些-这些黄色的东西是障碍。
--And then, uh, you go on and do the next phase, 01:02:11,800 --> 01:02:14,520
然后，呃，你继续做下一个阶段，
--and when you get to the next phase, 01:02:14,520 --> 01:02:15,800
当你进入下一阶段时，
--communication will occur. 01:02:15,800 --> 01:02:17,360
沟通会发生。
--Now, in a shared address space model, 01:02:17,360 --> 01:02:20,400
现在，在共享地址空间模型中，
--communication just happens by loading and storing memory. 01:02:20,400 --> 01:02:24,000
通信只是通过加载和存储内存发生的。
--So what you'll see is there's nothing special or different about that in the code. 01:02:24,000 --> 01:02:27,600
所以你会看到代码中没有什么特别或不同的地方。
--That'll just happen because you have a shared address space. 01:02:27,600 --> 01:02:31,680
那只会发生，因为您有一个共享的地址空间。
--And you'll see there is a lock that we need for updating something. 01:02:31,680 --> 01:02:36,280
你会看到我们需要一把锁来更新一些东西。
--So now let's look at that code. 01:02:36,280 --> 01:02:38,840
现在让我们看一下该代码。
--Okay. Well, here- this is the first draft of this code. 01:02:38,840 --> 01:02:42,360
好的。好吧，这是此代码的初稿。
--Maybe this isn't really what we want, 01:02:42,360 --> 01:02:43,920
也许这不是我们真正想要的，
--but I wanna talk through some things that are going on here. 01:02:43,920 --> 01:02:47,480
但我想谈谈这里发生的一些事情。
--So notice there's a lot more code now. 01:02:47,480 --> 01:02:50,240
所以请注意现在有更多的代码。
--And okay. 01:02:50,240 --> 01:02:52,760
好吧。
--So let me start with what's going on up here in the declaration. 01:02:52,760 --> 01:02:57,240
那么让我从声明中的内容开始。
--So we need a barrier, 01:02:57,240 --> 01:02:59,120
所以我们需要一道屏障，
--and we're going to need a lock. 01:02:59,120 --> 01:03:01,040
我们需要一把锁。
--And we're going to do, um, 01:03:01,040 --> 01:03:04,880
我们要做的，嗯，
--static, uh, assignment in these, uh, blocks of rows. 01:03:04,880 --> 01:03:10,720
静态，呃，这些，呃，行块中的赋值。
--And the code is going to calculate that. 01:03:10,720 --> 01:03:13,360
代码将对其进行计算。
--It needs to know its thread ID. 01:03:13,360 --> 01:03:15,440
它需要知道它的线程 ID。
--This is a little bit like the program instance that we saw before with ISPC. 01:03:15,440 --> 01:03:19,680
这有点像我们之前用 ISPC 看到的程序实例。
--So based on your thread ID, 01:03:19,680 --> 01:03:21,400
因此，根据您的线程 ID，
--which we somehow magically get, uh, 01:03:21,400 --> 01:03:23,640
我们不知何故神奇地得到了，呃，
--we use that to calculate, um, 01:03:23,640 --> 01:03:26,760
我们用它来计算，嗯，
--the min and max, um, 01:03:26,760 --> 01:03:29,280
最小值和最大值，嗯，
--based on like n and the number of processors. 01:03:29,280 --> 01:03:32,560
基于 like n 和处理器的数量。
--So in other words, in this, 01:03:32,560 --> 01:03:34,720
所以换句话说，在这个，
--in this chunk of rows, 01:03:34,720 --> 01:03:36,680
在这一行中，
--we wanna know, okay, 01:03:36,680 --> 01:03:38,160
我们想知道，好吧，
--for me specifically, 01:03:38,160 --> 01:03:39,560
具体对我来说，
--where do I begin and where do I end? 01:03:39,560 --> 01:03:41,400
我从哪里开始，又从哪里结束？
--Where, where am I beginning and ending rows in this? 01:03:41,400 --> 01:03:44,600
在哪里，我在哪里开始和结束行？
--And then you're going to iterate across them. 01:03:44,600 --> 01:03:46,600
然后你将遍历它们。
--So you'll see the outer loop is now iterating not from 0 to n minus 1, 01:03:46,600 --> 01:03:52,160
所以你会看到外循环现在不是从 0 迭代到 n 减 1，
--but from, uh, my min to my max. 01:03:52,160 --> 01:03:55,960
但是从，呃，我的最小值到最大值。
--But you'll see that the inner part of the loop body looks the same as it did before. 01:03:55,960 --> 01:04:01,440
但是您会看到循环体的内部看起来和以前一样。
--We just, uh, we just go ahead and access the array elements. 01:04:01,440 --> 01:04:07,600
我们只是，呃，我们只是继续访问数组元素。
--That looks just like it did in the sequential code. 01:04:07,600 --> 01:04:10,480
这看起来就像它在顺序代码中所做的那样。
--One thing that's new though is we wanna add up, 01:04:10,480 --> 01:04:14,120
有一件事是新的，虽然我们想加起来，
--we wanna accumulate all of these, 01:04:14,120 --> 01:04:16,080
我们想积累所有这些，
--the sum of all of these differences, 01:04:16,080 --> 01:04:18,080
所有这些差异的总和，
--and we wanna put in a lock for that because if we don't have a lock, 01:04:18,080 --> 01:04:22,000
我们想为此加一把锁，因为如果我们没有锁，
--then we can have a data race and we can accidentally drop updates if 01:04:22,040 --> 01:04:26,040
那么我们可以进行数据竞争，如果
--two things read and, and then miss each other's updates. 01:04:26,040 --> 01:04:29,760
两件事读and，然后错过对方的更新。
--So we put in a lock for that, 01:04:29,760 --> 01:04:31,920
所以我们为此加了一把锁，
--and then we have, uh, 01:04:31,920 --> 01:04:33,480
然后我们有，呃，
--some barriers also in the code. 01:04:33,480 --> 01:04:36,600
代码中也存在一些障碍。
--Okay. Do you see anything here that looks, 01:04:36,600 --> 01:04:41,080
好的。你看到这里有什么东西看起来，
--uh, suboptimal, optimal to you? 01:04:41,080 --> 01:04:43,680
呃，次优，最适合你？
--So as it's written, this code will not be particularly fast. 01:04:45,240 --> 01:04:50,360
所以正如它所写的那样，这段代码不会特别快。
--Do you see, is something kind of leaping out of you as a bottleneck? 01:04:50,480 --> 01:04:55,960
你看，有什么东西从你身上跳出来成为瓶颈吗？
--Yeah. 01:04:55,960 --> 01:04:57,360
是的。
--Even if it's locked and unlocked. 01:04:57,360 --> 01:04:59,160
即使它被锁定和解锁。
--Right. 01:04:59,160 --> 01:04:59,680
正确的。
--It's a lot of free thread though. 01:04:59,680 --> 01:05:01,160
虽然有很多免费线程。
--Right. So in the inner loop, 01:05:01,160 --> 01:05:03,920
正确的。所以在内循环中，
--in the inner loop body, 01:05:03,920 --> 01:05:05,640
在内部循环体中，
--we are locking and unlocking. 01:05:05,640 --> 01:05:07,520
我们正在锁定和解锁。
--So how frequently will that occur? 01:05:07,520 --> 01:05:10,440
那么这种情况发生的频率是多少？
--I mean, how much work is occurring in between those locks and unlocks? 01:05:10,440 --> 01:05:13,880
我的意思是，在这些锁定和解锁之间发生了多少工作？
--Well, the only other thing that we do is we do this addition. 01:05:13,880 --> 01:05:17,720
好吧，我们唯一要做的就是做这个加法。
--So that's not gonna take very long, 01:05:17,720 --> 01:05:19,440
所以这不会花很长时间，
--just a couple of cycles. 01:05:19,440 --> 01:05:21,520
只是几个周期。
--So if we have a lot of processors running, 01:05:21,520 --> 01:05:24,120
所以如果我们有很多处理器在运行，
--and they will be contending very heavily for that lock. 01:05:24,120 --> 01:05:27,920
他们将非常激烈地争夺那把锁。
--So that, that will probably be a major bottleneck. 01:05:27,920 --> 01:05:31,720
因此，这可能是一个主要瓶颈。
--Um, okay. Well, maybe we can fix that. 01:05:31,720 --> 01:05:35,560
嗯，好的。好吧，也许我们可以解决这个问题。
--Okay. So first of all, we need locks. 01:05:35,560 --> 01:05:37,880
好的。所以首先，我们需要锁。
--I think hopefully this is review for people, 01:05:37,880 --> 01:05:39,880
我希望这是对人们的评论，
--but if we didn't have the locks, 01:05:39,880 --> 01:05:41,680
但如果我们没有锁，
--then we could lose updates because you would 01:05:41,680 --> 01:05:44,440
那么我们可能会丢失更新，因为你会
--bring things into registers on two different threads, 01:05:44,440 --> 01:05:47,160
将事物放入两个不同线程的寄存器中，
--try to update them, 01:05:47,240 --> 01:05:48,520
尝试更新它们，
--write them back, and end up losing one of the updates. 01:05:48,520 --> 01:05:52,080
将它们写回去，并最终丢失其中一个更新。
--So that's why we need locks. 01:05:52,080 --> 01:05:54,040
所以这就是我们需要锁的原因。
--And locks can come in different flavors. 01:05:54,040 --> 01:05:56,320
锁可以有不同的风格。
--Here I'm showing them just as a lock with an explicit variable. 01:05:56,320 --> 01:06:01,080
在这里，我将它们展示为带有显式变量的锁。
--Um, people have also proposed having just, uh, 01:06:01,080 --> 01:06:04,400
嗯，人们还提议，呃，
--some wrapper that says, um, 01:06:04,400 --> 01:06:06,600
一些包装纸说，嗯，
--all of this code here has to be done atomically somehow. 01:06:06,600 --> 01:06:10,080
这里的所有这些代码都必须以某种方式自动完成。
--And then there are instructions to do this for just individual math operations. 01:06:10,080 --> 01:06:14,800
然后有针对单个数学运算执行此操作的说明。
--But for today, we're just gonna stick with 01:06:14,800 --> 01:06:16,960
但就今天而言，我们要坚持
--regular locks and, and, uh, 01:06:17,000 --> 01:06:19,520
普通锁和，和，呃，
--the same ideas would apply more or less to the other, the other primitives. 01:06:19,520 --> 01:06:23,600
同样的想法或多或少适用于另一个，其他原语。
--Okay. So instead of, uh, 01:06:23,600 --> 01:06:25,400
好的。所以不是，呃，
--putting the lock here, uh, what else can we do? 01:06:25,400 --> 01:06:29,040
把锁放在这里，呃，我们还能做什么？
--Can we, can we, is there something obvious to do to make this faster? 01:06:29,040 --> 01:06:32,400
我们可以，我们可以，有什么明显的方法可以使它更快吗？
--Each, each thread can store its own diff, 01:06:32,400 --> 01:06:35,760
每个，每个线程都可以存储自己的差异，
--and after it's finished, 01:06:35,760 --> 01:06:37,720
完成后，
--it just can be added to the, to the diff. 01:06:37,720 --> 01:06:40,640
它可以添加到 diff 中。
--Right. So, uh, it's the trick I talked about almost, you know, 01:06:40,640 --> 01:06:44,480
正确的。所以，呃，这就是我几乎谈到的技巧，你知道的，
--at the beginning of the lecture where instead of 01:06:44,480 --> 01:06:47,040
在讲座开始时而不是
--accumulating it all the time into a global thing, 01:06:47,040 --> 01:06:49,560
把它一直积累成一个全球性的东西，
--what we do is we will, uh, 01:06:49,560 --> 01:06:52,480
我们要做的是，我们会，呃，
--have a local diff. 01:06:52,480 --> 01:06:54,400
有一个地方差异。
--So each thread will figure out its portion of that total sum. 01:06:54,400 --> 01:06:58,800
所以每个线程都会计算出它在总和中的份额。
--And only after we've finished iterating over all of our work, 01:06:58,800 --> 01:07:03,000
只有在我们完成所有工作的迭代之后，
--at that point, we can accumulate those partial sums into one global sum. 01:07:03,000 --> 01:07:07,760
到那时，我们可以将这些部分总和累积为一个全局总和。
--But that will only occur once after we've done, 01:07:07,760 --> 01:07:11,600
但这只会在我们完成后发生一次，
--like, both, all of the work in our loops. 01:07:11,600 --> 01:07:14,000
就像我们循环中的所有工作一样。
--So that will occur far, far less frequently. 01:07:14,000 --> 01:07:16,800
所以这种情况发生的频率要低得多。
--So that should help a lot to avoid that, 01:07:16,800 --> 01:07:19,680
所以这应该有助于避免这种情况，
--make, having that be a bottleneck. 01:07:19,680 --> 01:07:21,440
使之成为瓶颈。
--Okay. So that's one trick. 01:07:21,440 --> 01:07:23,680
好的。所以这是一招。
--Um, now, what about the barriers? 01:07:23,680 --> 01:07:27,040
嗯，现在，障碍呢？
--Um, so barrier, 01:07:27,040 --> 01:07:30,200
嗯，所以障碍，
--the way it works is you tell the barrier how many threads are trying to synchronize for 01:07:30,200 --> 01:07:35,360
它的工作方式是你告诉屏障有多少线程正在尝试同步
--the barrier and they will all stall until they all arrive. 01:07:35,360 --> 01:07:38,880
屏障，他们都会停下来，直到他们都到达。
--And I already talked about why we needed this, 01:07:38,880 --> 01:07:41,400
我已经谈过为什么我们需要这个，
--which is you don't want, 01:07:41,400 --> 01:07:42,920
这是你不想要的，
--when you're in the middle of updating the red elements, 01:07:42,920 --> 01:07:45,960
当你正在更新红色元素时，
--you don't want to have any process finishing early and then jumping ahead and 01:07:45,960 --> 01:07:49,280
你不想让任何过程提前完成然后跳到前面
--starting to update black elements based on red elements that have not yet been updated. 01:07:49,280 --> 01:07:53,800
开始根据尚未更新的红色元素更新黑色元素。
--That would, that would be a problem. 01:07:53,800 --> 01:07:55,880
那会，那会是一个问题。
--Now, if we look at the code, 01:07:55,880 --> 01:07:57,840
现在，如果我们看一下代码，
--it actually has three barriers in it, in each iteration. 01:07:57,840 --> 01:08:01,880
在每次迭代中，它实际上包含三个障碍。
--Assuming you have good eyesight, 01:08:01,880 --> 01:08:04,680
假设你的视力很好，
--um, can anyone explain why are there three barriers here? 01:08:04,680 --> 01:08:09,280
嗯，谁能解释一下为什么这里有三个障碍？
--I mean, you would have expected one at least, 01:08:09,280 --> 01:08:11,840
我的意思是，你至少会期待一个，
--but why are there three of them? 01:08:11,840 --> 01:08:14,120
但是为什么是三个呢？
--Yep. 01:08:17,120 --> 01:08:18,680
是的。
--So if you don't have a barrier in the end, 01:08:18,680 --> 01:08:21,160
所以如果你最后没有障碍，
--some of the threads can actually go through and go to the first barrier. 01:08:21,160 --> 01:08:24,640
一些线程实际上可以通过并到达第一个障碍。
--So your first barrier will never be complete and so will your second barrier. 01:08:24,640 --> 01:08:27,960
所以你的第一个障碍永远不会完成，你的第二个障碍也是如此。
--Oh, one thing I forgot to say about barriers is they're 01:08:27,960 --> 01:08:32,760
哦，关于障碍我忘了说一件事是它们是
--designed so that if you hit them back to back, 01:08:32,760 --> 01:08:35,440
设计成如果你背靠背击打它们，
--the right thing will happen. 01:08:35,440 --> 01:08:36,720
正确的事情将会发生。
--So if one thread, um, you know, jumps, anyway, 01:08:36,880 --> 01:08:40,400
所以如果一个线程，嗯，你知道，无论如何，跳转，
--barriers are reusable kind of back to back and they'll work. 01:08:40,400 --> 01:08:43,440
障碍是可重复使用的背靠背，它们会起作用。
--They basically reset themselves. 01:08:43,440 --> 01:08:45,040
他们基本上重置了自己。
--But, but yeah, so if we, 01:08:45,040 --> 01:08:46,960
但是，但是，是的，所以如果我们，
--if we didn't have, um, 01:08:46,960 --> 01:08:49,120
如果我们没有，嗯，
--if I took out this barrier, 01:08:49,120 --> 01:08:51,120
如果我去掉这个障碍，
--then the problem is that one thread could wrap around here and actually 01:08:51,120 --> 01:08:56,200
那么问题是一个线程可以绕到这里，实际上
--reset the overall difference before other threads were finished, 01:08:56,200 --> 01:09:01,400
在其他线程完成之前重置整体差异，
--reading it to decide whether they should terminate. 01:09:01,400 --> 01:09:04,240
阅读它以决定他们是否应该终止。
--So in fact, some of them could get different results 01:09:04,280 --> 01:09:07,360
所以实际上，其中一些可能会得到不同的结果
--for whether they should terminate or not because someone would reset it to zero. 01:09:07,360 --> 01:09:11,720
他们是否应该终止，因为有人会将其重置为零。
--Anybody who read it after that would go, 01:09:11,720 --> 01:09:13,400
任何在那之后读过它的人都会去，
--woo, hey, we're, we're done. 01:09:13,400 --> 01:09:15,480
哇，嘿，我们，我们完成了。
--Wow, our overall, uh, 01:09:15,480 --> 01:09:18,240
哇，我们的整体，呃，
--we've totally converged. 01:09:18,240 --> 01:09:19,520
我们已经完全融合了。
--There was no difference at all. 01:09:19,520 --> 01:09:21,280
完全没有区别。
--So we don't want that to happen. 01:09:21,280 --> 01:09:22,560
所以我们不希望这种情况发生。
--That's why this last barrier is here. 01:09:22,560 --> 01:09:24,760
这就是最后一个障碍在这里的原因。
--Um, why is this barrier here? 01:09:24,760 --> 01:09:26,800
额，这个结界怎么会在这里？
--This first barrier is here because before, 01:09:26,800 --> 01:09:29,720
第一个障碍在这里是因为之前，
--you want to make sure you finish resetting the difference before you start, 01:09:29,720 --> 01:09:33,480
你想确保在开始之前完成重置差异，
--oh, sorry, it's about your local difference. 01:09:33,520 --> 01:09:35,320
哦，对不起，这是关于你当地的差异。
--You want to reset that before you start accumulating into it. 01:09:35,320 --> 01:09:39,240
您想在开始积累之前重置它。
--Um, and then finally, uh, 01:09:39,240 --> 01:09:41,360
嗯，最后，嗯，
--you don't want to test it until you've finished all of, uh, those accumulations. 01:09:41,360 --> 01:09:46,000
在完成所有这些积累之前，您不想对其进行测试。
--Okay. So it turns out that this is real- the reason why we have 01:09:46,000 --> 01:09:48,960
好的。所以事实证明这是真实的——这就是为什么我们有
--three barriers here is because of the awkwardness of dealing with this, 01:09:48,960 --> 01:09:54,480
这里的三个障碍是因为处理这个的尴尬，
--um, this diff variable and, and the mydiff variable. 01:09:54,480 --> 01:09:58,880
嗯，这个 diff 变量和，以及 mydiff 变量。
--So it turns out that there's a way to get around this, 01:09:58,880 --> 01:10:02,200
所以事实证明有一种方法可以解决这个问题，
--which is- it's essentially just a naming problem. 01:10:02,200 --> 01:10:05,040
这是-它本质上只是一个命名问题。
--We could have, uh, uh, 01:10:05,040 --> 01:10:07,280
我们可以，呃，呃，
--an array with three instances of diff and effectively pipeline those things across 01:10:07,280 --> 01:10:13,840
一个包含三个 diff 实例的数组，并有效地将这些东西通过管道传递
--different iterations so there's a little more work involved with that. 01:10:13,840 --> 01:10:17,800
不同的迭代，所以涉及到更多的工作。
--But if you did that, basically, 01:10:17,800 --> 01:10:19,760
但如果你这样做，基本上，
--you take- you now want to reference, 01:10:19,760 --> 01:10:22,800
你拿-你现在想参考，
--you know, index, uh, modulo 3. 01:10:22,800 --> 01:10:25,320
你知道，索引，呃，模 3。
--It turns out if you do this, 01:10:25,320 --> 01:10:26,920
事实证明，如果你这样做，
--then it, it actually fixes this problem of overriding diff before you should, 01:10:26,920 --> 01:10:32,000
然后它，它实际上解决了这个在你应该之前覆盖差异的问题，
--you know, while the people are still busy accessing it because based on this index, 01:10:32,000 --> 01:10:37,200
你知道，当人们还在忙于访问它时，因为基于这个索引，
--every- each thread would always be pointing to the right copy of diff anyway. 01:10:37,200 --> 01:10:41,120
无论如何，每个线程总是指向 diff 的正确副本。
--And diff is only- it's only a scalar, 01:10:41,120 --> 01:10:43,600
 diff 只是-它只是一个标量，
--so having three of them is, 01:10:43,600 --> 01:10:44,800
所以他们三个是，
--is not any space overhead to worry about. 01:10:44,800 --> 01:10:47,360
无需担心任何空间开销。
--And if we do that, now we can get away with just one barrier in this case. 01:10:47,360 --> 01:10:51,440
如果我们这样做，现在我们就可以在这种情况下摆脱一个障碍。
--So that's, that's interesting. 01:10:51,440 --> 01:10:53,560
就是这样，这很有趣。
--Okay. So that's another type of trick you might be able to use. 01:10:53,560 --> 01:10:57,240
好的。所以这是您可以使用的另一种技巧。
--Um, now, one thing about a barrier is that barriers might be, 01:10:57,560 --> 01:11:04,000
嗯，现在，关于障碍的一件事是，障碍可能是，
--they're a little- they're a bit heavyweight because it's one way, 01:11:04,000 --> 01:11:07,520
他们有点-他们有点重量级，因为这是一种方式，
--one way to deal with, uh, 01:11:07,520 --> 01:11:08,960
一种处理方式，呃，
--dependencies is to just throw in a barrier and that will 01:11:08,960 --> 01:11:11,720
依赖关系只是设置一个障碍，这将
--force all the threads to all catch up to each other. 01:11:11,720 --> 01:11:14,360
迫使所有线程都相互追赶。
--But what if you knew that you- what if you had more precise information? 01:11:14,360 --> 01:11:19,800
但是如果你知道你——如果你有更精确的信息怎么办？
--If you knew, oh, wait a minute, 01:11:19,800 --> 01:11:21,360
如果你知道，哦，等一下，
--I don't need all of the data to be updated. 01:11:21,360 --> 01:11:23,400
我不需要更新所有数据。
--I just need a specific location to be updated. 01:11:23,400 --> 01:11:26,200
我只需要更新一个特定的位置。
--If you knew that more specifically, 01:11:26,240 --> 01:11:28,200
如果你更具体地知道这一点，
--then you could have more precise, uh, 01:11:28,200 --> 01:11:31,120
那么你可以有更精确的，呃，
--dependence information and maybe just wait 01:11:31,120 --> 01:11:33,440
依赖信息，也许只是等待
--specifically for the things you need and not force everything to catch up. 01:11:33,440 --> 01:11:37,360
专门针对您需要的东西，而不是强迫一切都赶上。
--So for example, if you need x and you, uh, 01:11:37,360 --> 01:11:41,880
例如，如果你需要 x 而你，呃，
--realize that you could potentially imagine having some synchronization associated with it. 01:11:41,880 --> 01:11:47,280
意识到您可能会想象与之相关的一些同步。
--Now, um, let's see, 01:11:47,280 --> 01:11:49,320
现在，嗯，让我们看看，
--I need to draw like a little skull and crossbones here. 01:11:49,320 --> 01:11:53,680
我需要在这里画一个小骷髅和交叉骨。
--Uh, because the way that this code is written, 01:11:53,680 --> 01:11:56,480
呃，因为这段代码的编写方式，
--this is incredibly dangerous code as written. 01:11:56,480 --> 01:11:59,400
这是编写的非常危险的代码。
--Never, never write this code because, uh, 01:11:59,400 --> 01:12:02,520
永远，永远不要写这段代码，因为，呃，
--you need to have something in the middle called a fence. 01:12:02,520 --> 01:12:05,760
你需要在中间有一个叫做栅栏的东西。
--And if you don't have a fence in this code, 01:12:05,760 --> 01:12:08,560
如果你在这段代码中没有栅栏，
--then, uh, it will not work at all. 01:12:08,560 --> 01:12:11,320
那么，呃，它根本不起作用。
--And we have a full lecture on that later, uh, this semester. 01:12:11,320 --> 01:12:14,560
稍后，呃，本学期我们将对此进行完整的讲座。
--So when we talk about memory consistency models, 01:12:14,560 --> 01:12:16,880
所以当我们谈论内存一致性模型时，
--we'll see why this code is written as code you should never, ever, ever write. 01:12:16,880 --> 01:12:21,200
我们将了解为什么将此代码编写为您永远不应该编写的代码。
--Okay. So I'm not saying that the concept of breaking it up into smaller dependencies is bad. 01:12:21,640 --> 01:12:26,720
好的。所以我并不是说将它分解成更小的依赖项的概念是不好的。
--I just meant don't write code where you use 01:12:26,720 --> 01:12:28,600
我只是说不要在你使用的地方写代码
--normal memory locations as synchronization flies because that will not work. 01:12:28,600 --> 01:12:32,160
正常的内存位置作为同步飞行，因为那将不起作用。
--Okay. So, so far we looked at, uh, 01:12:32,160 --> 01:12:34,680
好的。所以，到目前为止我们看了，呃，
--two of the models, data parallel and shared address space, 01:12:34,680 --> 01:12:38,560
两种模型，数据并行和共享地址空间，
--and we have one more to go. 01:12:38,560 --> 01:12:40,040
我们还有一个要去。
--So, um, and this one's going to look, uh, quite a bit different. 01:12:40,040 --> 01:12:45,000
所以，嗯，这个看起来，嗯，有点不同。
--So, uh, remember that with message passing, 01:12:45,000 --> 01:12:50,160
所以，呃，请记住，通过消息传递，
--communication only occurs through messages that you send to other threads, 01:12:50,200 --> 01:12:54,800
通信仅通过您发送到其他线程的消息发生，
--and then they receive messages. 01:12:54,800 --> 01:12:56,680
然后他们收到消息。
--And the only memory you can access is private memory. 01:12:56,680 --> 01:13:00,120
您唯一可以访问的内存是私有内存。
--So when we have a, a matrix, 01:13:00,120 --> 01:13:03,000
所以当我们有一个矩阵时，
--and we're operating on different parts of the matrix, 01:13:03,000 --> 01:13:06,000
我们在矩阵的不同部分进行操作，
--that means that the different parts that we assign to the different processors, 01:13:06,000 --> 01:13:10,360
这意味着我们分配给不同处理器的不同部分，
--they live only in the local memory of those processors. 01:13:10,360 --> 01:13:14,880
它们仅存在于这些处理器的本地内存中。
--We can't just arbitrarily load and store anywhere in the matrix, 01:13:14,880 --> 01:13:19,320
我们不能随意加载和存储矩阵中的任何位置，
--only to the part of it that's local to us. 01:13:19,480 --> 01:13:22,280
仅限于我们本地的部分。
--So if we are dividing this up by blocks of rows, 01:13:22,280 --> 01:13:26,080
因此，如果我们将其按行块划分，
--the local memories will have only, 01:13:26,080 --> 01:13:29,360
当地的记忆将只有，
--um, your portion of, 01:13:29,360 --> 01:13:31,600
嗯，你的部分，
--of the address, uh, of the addresses. 01:13:31,600 --> 01:13:35,080
地址，呃，地址。
--So remember, uh, 01:13:35,080 --> 01:13:38,040
所以记住，呃，
--that's not going to be an issue if I'm updating this thing and I need, 01:13:38,040 --> 01:13:41,320
如果我正在更新这个东西并且我需要，那不会成为问题，
--you know, these four elements, that looks fine. 01:13:41,320 --> 01:13:43,720
你知道，这四个元素，看起来不错。
--But what happens when I'm updating this element here and I need this, this, 01:13:43,720 --> 01:13:48,600
但是当我在这里更新这个元素时会发生什么，我需要这个，这个，
--this, this, and whoops, that? 01:13:48,600 --> 01:13:50,960
这个，这个，还有那个？
--So the thing that's, 01:13:50,960 --> 01:13:52,760
所以事情是这样的
--I can't just reference that thing and expect something good to happen. 01:13:52,760 --> 01:13:57,000
我不能只参考那件事并期待好事发生。
--So one of the things that we do is, well, 01:13:57,000 --> 01:14:00,000
所以我们做的其中一件事就是，嗯，
--to not have our code be really awkward, 01:14:00,000 --> 01:14:02,640
为了不让我们的代码真的很尴尬，
--we will actually allocate an additional row along the boundary in memory. 01:14:02,640 --> 01:14:08,320
实际上，我们将在内存中沿着边界分配一个额外的行。
--So this is redundant, 01:14:08,320 --> 01:14:10,280
所以这是多余的，
--this is extra memory. 01:14:10,280 --> 01:14:12,760
这是额外的内存。
--We call this a ghost, uh, 01:14:12,760 --> 01:14:14,480
我们称之为幽灵，呃，
--ghost row or ghost cells. 01:14:14,480 --> 01:14:16,480
幽灵行或幽灵细胞。
--And this is a holding place where we can, 01:14:16,480 --> 01:14:19,080
这是一个我们可以的地方，
--where we're going to insert the data that we will have to get from other processors. 01:14:19,080 --> 01:14:23,480
我们将在其中插入必须从其他处理器获取的数据。
--This is just to keep the code nice and simple. 01:14:23,480 --> 01:14:26,000
这只是为了保持代码简洁明了。
--So that way when we're updating something here, 01:14:26,000 --> 01:14:29,720
这样当我们在这里更新一些东西时，
--we can just go ahead and use our original code that will reference something up here, 01:14:29,720 --> 01:14:35,280
我们可以继续使用我们的原始代码来引用上面的内容，
--even though that's not really, 01:14:35,280 --> 01:14:37,240
即使那不是真的，
--uh, necessarily up to date unless we're careful. 01:14:37,240 --> 01:14:40,120
呃，必须是最新的，除非我们小心。
--So then the idea is we're going to pass rows up and down. 01:14:40,120 --> 01:14:44,600
那么我们的想法是我们要上下传递行。
--And we're going to do this using, uh, send and receive. 01:14:44,600 --> 01:14:48,360
我们将使用，呃，发送和接收来做到这一点。
--So we will, at, 01:14:48,360 --> 01:14:51,400
所以我们将在
--at the boundaries of the computation, 01:14:51,400 --> 01:14:54,320
在计算的边界，
--we're going to receive rows from other, 01:14:54,320 --> 01:14:57,840
我们将从其他人那里接收行，
--from our neighboring processors, 01:14:57,840 --> 01:14:59,800
来自我们邻近的处理器，
--and we're going to copy that data into those ghost rows. 01:14:59,800 --> 01:15:02,600
我们将把这些数据复制到那些幽灵行中。
--And then we can go ahead and do that chunk of work. 01:15:02,600 --> 01:15:05,840
然后我们可以继续做那部分工作。
--We can finish doing all the red or black cells, 01:15:05,840 --> 01:15:09,000
我们可以完成所有的红色或黑色单元格，
--and then we have to pass them again, 01:15:09,000 --> 01:15:11,060
然后我们必须再次通过它们，
--and then wait, and then do that again. 01:15:11,060 --> 01:15:13,640
然后等待，然后再做一次。
--Okay. So here's, uh, yeah, 01:15:13,640 --> 01:15:16,640
好的。所以这是，呃，是的，
--this code gets, uh, more complicated. 01:15:16,640 --> 01:15:20,120
这段代码变得，呃，更复杂了。
--So I'm going to go through parts of this here. 01:15:20,120 --> 01:15:22,720
所以我将在这里讨论其中的一部分。
--So, um, let me, uh, 01:15:22,720 --> 01:15:26,560
所以，嗯，让我，呃，
--explain what's happening here. 01:15:26,560 --> 01:15:27,680
解释这里发生了什么。
--So in the middle, 01:15:27,680 --> 01:15:29,240
所以在中间，
--I apologize, this is really small font, so it's hard to see. 01:15:29,240 --> 01:15:31,640
抱歉，这个字体真的很小，所以很难看清。
--But the part I just highlighted, 01:15:31,640 --> 01:15:33,360
但我刚才强调的部分，
--that's, that's the main work in the middle. 01:15:33,360 --> 01:15:35,760
也就是，这就是中间的主要工作。
--And it looks very much like, 01:15:35,760 --> 01:15:38,280
它看起来非常像，
--uh, what we had, uh, in the other code. 01:15:38,280 --> 01:15:41,160
呃，我们在其他代码中有什么。
--One thing that's different though is the loop index is just, uh, 01:15:41,160 --> 01:15:46,000
有一点不同的是，循环索引只是，呃，
--basically the, it's, 01:15:46,000 --> 01:15:48,840
基本上，它是，
--they're all the same because it's just from like zero to, 01:15:48,840 --> 01:15:52,720
它们都是一样的，因为它只是从零到，
--uh, whatever the size is here. 01:15:52,720 --> 01:15:54,880
呃，不管这里有多大。
--So you're just accessing your own local memory, 01:15:54,880 --> 01:15:57,680
所以你只是访问你自己的本地内存，
--and that's what's going on. 01:15:57,680 --> 01:15:59,400
这就是正在发生的事情。
--But the interesting things are up here, 01:15:59,400 --> 01:16:02,000
但有趣的事情都在这里，
--we're passing these, uh, 01:16:02,000 --> 01:16:03,800
我们正在通过这些，呃，
--ghost rows back and forth. 01:16:03,800 --> 01:16:05,520
来回排鬼。
--So you'll notice that you will send the rows, 01:16:05,520 --> 01:16:09,800
所以你会注意到你会发送行，
--and you'll receive the rows. 01:16:09,800 --> 01:16:12,040
你会收到这些行。
--So you send them up and down. 01:16:12,040 --> 01:16:14,840
所以你上下发送它们。
--Now, if you're the one on the very top or the very bottom, 01:16:14,840 --> 01:16:17,120
现在，如果你是最顶层或最底层的人，
--you don't send them off the edge. 01:16:17,120 --> 01:16:18,440
您不会将它们发送到边缘。
--So that's what the conditional test is there for. 01:16:18,440 --> 01:16:20,680
这就是条件测试的目的。
--And then you receive them from your neighbors, 01:16:20,680 --> 01:16:22,520
然后你从你的邻居那里收到它们，
--and you copy them in, 01:16:22,520 --> 01:16:23,720
然后你复制它们，
--and then you can go ahead and do the work. 01:16:23,720 --> 01:16:25,960
然后你就可以继续工作了。
--Now, um, what's all of this at the bottom? 01:16:25,960 --> 01:16:29,120
现在，嗯，底部的这些是什么？
--So all of that is basically the reduction and, and test at the end. 01:16:29,120 --> 01:16:34,480
所以所有这些基本上都是减少和最后的测试。
--So you can locally calculate the sum of 01:16:34,480 --> 01:16:38,000
所以你可以在本地计算总和
--the differences as you're updating the values, 01:16:38,000 --> 01:16:40,280
更新值时的差异，
--but now everyone has to agree on whether, 01:16:40,280 --> 01:16:43,320
但现在每个人都必须同意是否，
--uh, the, the, you've reached convergence or not. 01:16:43,320 --> 01:16:46,200
呃，你是否达到收敛。
--So the way that it does that is it picks one lucky, uh, processor, processor 0. 01:16:46,200 --> 01:16:52,040
所以它这样做的方式是选择一个幸运的，呃，处理器，处理器 0。
--And processor 0 is, 01:16:52,040 --> 01:16:55,640
处理器 0 是，
--if you're not processor 0, 01:16:55,640 --> 01:16:57,720
如果你不是处理器 0，
--then you send processor 0 message with your partial difference in it. 01:16:57,720 --> 01:17:02,440
然后你发送处理器 0 消息，其中包含你的部分差异。
--It receives all of those messages, 01:17:02,440 --> 01:17:04,200
它接收所有这些消息，
--adds them all up, 01:17:04,200 --> 01:17:05,280
把它们全部加起来，
--and then sends them back out to the other processors. 01:17:05,360 --> 01:17:08,000
然后将它们发送回其他处理器。
--So the ones that are not processor 0 just do the send, 01:17:08,000 --> 01:17:12,120
所以那些不是处理器 0 的只是发送，
--and then they wait to get the done flag. 01:17:12,120 --> 01:17:14,520
然后他们等待获得完成标志。
--And if you are processor 1, 01:17:14,520 --> 01:17:16,240
如果你是处理器 1，
--then you've got a lot of work to do here, um, 01:17:16,240 --> 01:17:18,680
那么你在这里有很多工作要做，嗯，
--getting all these messages, adding them up, 01:17:18,680 --> 01:17:20,280
获取所有这些消息，将它们加起来，
--and then sending out those messages. 01:17:20,280 --> 01:17:22,720
然后发送这些消息。
--Okay. So now it turns out that that last step, 01:17:23,280 --> 01:17:28,560
好的。所以现在事实证明，最后一步，
--because that pattern happens relatively frequently, uh, 01:17:28,560 --> 01:17:31,880
因为这种模式发生得比较频繁，呃，
--the languages that support this usually have 01:17:31,880 --> 01:17:33,920
支持这个的语言通常有
--some kind of reduction primitive that will automatically do all the stuff that you saw there. 01:17:33,920 --> 01:17:38,600
某种还原原语，它会自动完成你在那里看到的所有事情。
--But if we look at, um, 01:17:38,600 --> 01:17:41,280
但如果我们看，嗯，
--if we look at this code and what's going on here. 01:17:41,280 --> 01:17:44,280
如果我们看一下这段代码，看看这里发生了什么。
--So interestingly, you know, 01:17:44,280 --> 01:17:46,680
很有趣，你知道，
--we're computing on our local address space, 01:17:46,680 --> 01:17:49,040
我们正在计算我们的本地地址空间，
--and this code is sending entire rows at a time, 01:17:49,040 --> 01:17:52,760
这段代码一次发送整行，
--um, not individual elements, 01:17:52,760 --> 01:17:54,560
嗯，不是个别元素，
--and that's on purpose so that we can get decent performance. 01:17:54,560 --> 01:17:57,920
这是故意的，以便我们可以获得不错的性能。
--Now, it turns out the code that I showed you is, uh, 01:17:57,920 --> 01:18:02,120
现在，事实证明我给你看的代码是，呃，
--badly broken in one important way. 01:18:02,120 --> 01:18:04,200
以一种重要的方式严重损坏。
--If we were using- okay. 01:18:04,200 --> 01:18:05,880
如果我们使用 - 好吧。
--Well, uh, what- okay. 01:18:05,880 --> 01:18:08,680
好吧，呃，什么-好吧。
--The question is, when you do a send, uh, what happens? 01:18:08,680 --> 01:18:12,200
问题是，当你发送时，嗯，会发生什么？
--Do you wait? Uh, one- one possibility is that if you have a synchronous send, 01:18:12,200 --> 01:18:16,800
你等吗？呃，一种可能性是，如果你有一个同步发送，
--then when I try to send a message until the receiver has received it, I will block. 01:18:16,800 --> 01:18:21,520
然后当我尝试发送消息直到接收者收到它时，我将阻止。
--So let's assume we have that kind of send. 01:18:21,520 --> 01:18:24,400
所以让我们假设我们有那种发送。
--What's wrong with the code? 01:18:24,400 --> 01:18:26,720
代码有什么问题？
--Go back and look at the code. 01:18:26,720 --> 01:18:29,400
回去看看代码。
--It turns out this code will deadlock. 01:18:29,400 --> 01:18:32,360
事实证明这段代码会死锁。
--Why will it deadlock? 01:18:32,360 --> 01:18:34,640
为什么会死锁？
--Every thread is sending. 01:18:35,280 --> 01:18:38,680
每个线程都在发送。
--Right. Yeah. So every thread is saying, okay, 01:18:38,680 --> 01:18:42,480
正确的。是的。所以每个线程都在说，好吧，
--we start off, we all send a row down. 01:18:42,480 --> 01:18:44,560
我们出发了，我们都派了一排下来。
--Okay. And then we all send a row up. 01:18:44,560 --> 01:18:47,320
好的。然后我们都发送一行。
--And, uh, wait a minute. 01:18:47,320 --> 01:18:49,640
而且，呃，等一下。
--Nobody's doing a receive. 01:18:49,640 --> 01:18:50,920
没有人在做接收。
--Why isn't anybody doing a receive? 01:18:50,920 --> 01:18:52,120
为什么没有人做接收？
--Oh, right. Because we're all sending to somebody else, 01:18:52,120 --> 01:18:54,360
啊对。因为我们都在发送给其他人，
--and they're all waiting for somebody else to receive. 01:18:54,360 --> 01:18:56,120
他们都在等待别人接收。
--So. You could have even processors send first, 01:18:56,120 --> 01:18:59,680
所以。你甚至可以让处理器先发送，
--and odd processors receive first. 01:18:59,680 --> 01:19:01,600
奇数处理器首先接收。
--Yeah. Exactly. 01:19:01,600 --> 01:19:02,960
是的。确切地。
--So, uh, and here's a picture of that. 01:19:02,960 --> 01:19:05,240
所以，呃，这是一张照片。
--So that's one way to solve the problem, 01:19:05,240 --> 01:19:07,400
所以这是解决问题的一种方法，
--is we can switch evens and odds. 01:19:07,400 --> 01:19:09,680
是我们可以转换偶数和赔率。
--And then this is code that will not deadlock. 01:19:09,680 --> 01:19:11,680
然后这是不会死锁的代码。
--It's very similar, but it fixed that problem. 01:19:11,680 --> 01:19:13,960
它非常相似，但它解决了这个问题。
--Um, another thing that you can use, 01:19:13,960 --> 01:19:15,560
嗯，你可以使用的另一件事，
--is use non-blocking sends and receive. 01:19:15,560 --> 01:19:17,440
是使用非阻塞发送和接收。
--Okay. So last slide here. 01:19:17,440 --> 01:19:19,680
好的。最后一张幻灯片在这里。
--Um, so we talked at a high level about the different steps in writing a parallel code, 01:19:19,680 --> 01:19:24,600
嗯，所以我们在较高层次上讨论了编写并行代码的不同步骤，
--about, uh, decomposition and assignment. 01:19:24,600 --> 01:19:27,040
关于，呃，分解和赋值。
--We looked at the different programming models. 01:19:27,040 --> 01:19:29,440
我们研究了不同的编程模型。
--Um, and in the next two lectures, 01:19:29,440 --> 01:19:31,160
嗯，在接下来的两节课中，
--we're going to dive into more detail about, 01:19:31,160 --> 01:19:33,800
我们将深入探讨更多细节，
--uh, issues that affect performance. So, that's all. 01:19:33,800 --> 01:19:37,720
呃，影响性能的问题。所以，就是这样。
