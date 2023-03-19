--We're going to actually start looking at some code. 00:00:00,000 --> 00:00:03,200
我们将真正开始查看一些代码。
--Uh, on, on the, the other day what we were discussing is, we're talking about some parallel programming models. 00:00:03,200 --> 00:00:10,160
呃，前几天我们讨论的是，我们正在谈论一些并行编程模型。
--As you may recall, we talked about shared address space, message passing, and data parallel. 00:00:10,160 --> 00:00:16,320
您可能还记得，我们讨论过共享地址空间、消息传递和数据并行。
--And now today we're gonna use, uh, some simple examples and we're gonna see what the software looks like if we want to have a functional parallel program written in these three different styles. 00:00:16,320 --> 00:00:27,720
现在，今天我们要使用，呃，一些简单的例子，如果我们想要用这三种不同风格编写的功能性并行程序，我们将看看软件是什么样子的。
--So today, we're going to just get to the point of having functional, hopefully not terribly performing parallel code, but we're not yet going to get to the point of really optimizing that- the performance of that code. 00:00:27,720 --> 00:00:42,040
所以今天，我们将只讨论功能性的，希望不会非常执行并行代码，但我们还没有达到真正优化代码性能的地步。
--We will, uh, scratch the surface of those issues today. 00:00:42,040 --> 00:00:46,000
今天，我们将浅谈这些问题的表面。
--Uh, but in the upcoming lectures, we're gonna dive much more deeply into, uh, issues about how you really squeeze the most performance out of parallel software. 00:00:46,000 --> 00:00:56,200
呃，但在接下来的讲座中，我们将更深入地探讨，呃，关于如何真正从并行软件中榨取最大性能的问题。
--Okay. So, okay. 00:00:56,200 --> 00:01:00,280
好的。所以，好吧。
--So, uh, what I'm gonna do is introduce a couple of writing examples now that are good, good, um, examples of code that we might want to parallelize, um, so that I can have something to refer to. 00:01:00,280 --> 00:01:13,080
所以，呃，我现在要做的是介绍几个编写示例，这些示例很好，很好，嗯，我们可能想要并行化的代码示例，嗯，这样我就可以有一些参考。
--And the first one of these is actually, uh, very similar to what we're going to look at later in our, in our case studies. 00:01:13,080 --> 00:01:20,280
其中第一个实际上，呃，与我们稍后将在我们的案例研究中看到的非常相似。
--So, okay. So this first program, what it's doing is, um, imagine you're an oceanographer and you want to simulate, simulate the, uh, the physics of the ocean. 00:01:20,280 --> 00:01:32,400
所以，好吧。所以第一个程序，它正在做的是，嗯，想象你是一名海洋学家，你想要模拟，模拟，呃，海洋的物理学。
--So the ocean is a three-dimensional thing. 00:01:32,400 --> 00:01:35,480
所以海洋是三维的。
--However, um, in this case, what they actually do is because the depth of the ocean is much smaller compared to how wide it is, it's almost like a, not exactly a plane, but it's a very thin three-dimensional object. 00:01:35,480 --> 00:01:50,880
但是，嗯，在这种情况下，他们实际上做的是因为海洋的深度与它的宽度相比要小得多，它几乎像一个，不完全是一个平面，但它是一个非常薄的三维物体。
--And also because, uh, pressure and temperature change as you go deeper into it, the way they represent it is as a series, as a set of, of these different layers, a set of two-dimensional planes at different depths. 00:01:51,040 --> 00:02:04,000
还因为，呃，当你深入它时，压力和温度会发生变化，它们将它表示为一系列，一组，这些不同的层，一组不同深度的二维平面。
--So, so it is a 3D matrix, um, but you can, but really each, each layer is computed separately. 00:02:04,000 --> 00:02:13,920
所以，它是一个 3D 矩阵，嗯，但你可以，但实际上每一层都是单独计算的。
--Okay. So if we just flip one of these layers over, we have a 2D array. 00:02:13,920 --> 00:02:18,600
好的。因此，如果我们只是将这些层中的一个翻转过来，我们就会得到一个二维数组。
--And what's going on here is, um, obviously the ocean is continuous and time is continuous. 00:02:18,640 --> 00:02:26,480
而这里发生的事情是，嗯，显然海洋是连续的，时间是连续的。
--But when we do things in, in software, we do them, uh, in a more discrete way. 00:02:26,480 --> 00:02:31,640
但是当我们在软件中做事时，我们会以一种更离散的方式来做。
--So we take the space, the, you know, the, the, the two-dimensional space and divide that into grid points. 00:02:31,640 --> 00:02:39,640
所以我们把空间，你知道的，二维空间，分成网格点。
--So these are approximations of, well, that's, that's the correct value at that particular point. 00:02:39,640 --> 00:02:45,640
所以这些是近似值，嗯，那是那个特定点的正确值。
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
--Because we don't just want a particular instant in time, we want to model what happens over time. 00:02:58,640 --> 00:03:04,440
因为我们不只是想要一个特定的瞬间，我们想要对随时间发生的事情进行建模。
--So we, we compute, uh, the, the values for all the elements at a particular time step, and then we move to the next time step. 00:03:04,440 --> 00:03:12,000
所以我们，我们计算，呃，所有元素在特定时间步的值，然后我们移动到下一个时间步。
--And what we're doing is solving a set of, uh, partial differential equations. 00:03:12,000 --> 00:03:18,600
我们正在做的是求解一组，呃，偏微分方程。
--Um, and don't worry, we won't reproduce this picture from memory on the exam. 00:03:18,600 --> 00:03:23,280
嗯，别担心，我们不会在考试中凭记忆重现这张照片。
--Um, so there's, there's a lot of, uh, a lot of equations that are being solved in the, in the real version of this software that's modeling, um, the ocean. 00:03:23,280 --> 00:03:34,040
嗯，所以有很多，呃，很多方程式正在这个软件的真实版本中求解，这个软件正在建模，嗯，海洋。
--We're going to, later on today, we're going to look at a very simplified version of this code that captures the important communication and parallel challenges of the real software. 00:03:34,040 --> 00:03:45,840
我们将在今天晚些时候查看此代码的一个非常简化的版本，它捕获了真实软件的重要通信和并行挑战。
--So, um, I'm not going to get into all the details here. 00:03:46,000 --> 00:03:49,240
所以，嗯，我不打算在这里详细介绍所有细节。
--There's a lot of stuff that goes on. 00:03:49,240 --> 00:03:50,720
有很多事情在发生。
--But the interesting part is, it turns out that it spends most of its time, a vast majority of its time, in a particular part of this computation, which is where, for a particular time step, you are solving, you're updating all of the parallel dif- partial differential equations for all of the grid elements. 00:03:50,720 --> 00:04:10,360
但有趣的是，事实证明它花费了大部分时间，绝大部分时间，在这个计算的特定部分，也就是对于特定时间步，你正在解决，你正在更新所有网格元素的所有平行 diff 偏微分方程。
--So that's what we're going to focus on later. 00:04:10,360 --> 00:04:12,200
所以这就是我们稍后要关注的。
--That's, that's where it spends most of its time. 00:04:12,200 --> 00:04:15,400
也就是说，这是它花费大部分时间的地方。
--Okay. So that's our first, uh, example application. 00:04:16,120 --> 00:04:20,000
好的。这就是我们的第一个，呃，示例应用程序。
--And one thing you may have noticed about it is that it has a very regular structure. 00:04:20,000 --> 00:04:26,600
您可能已经注意到的一件事是它具有非常规则的结构。
--So we have a dense two-dimensional array, and we're going to be updating elements of that two-dimensional array, uh, over time. 00:04:26,600 --> 00:04:34,680
所以我们有一个密集的二维数组，我们将随着时间的推移更新该二维数组的元素。
--The second example, this is also, uh, a scientific, uh, uh, simulation of something physical. 00:04:34,680 --> 00:04:43,080
第二个例子，这也是，呃，一个科学的，呃，呃，对某种物理的模拟。
--But here, what we're simulating is, uh, stars in, in the gala- in, uh, the universe. 00:04:43,200 --> 00:04:50,160
但是在这里，我们正在模拟的是，呃，银河系中的恒星，呃，宇宙。
--So the way- what's happening here is, again, we have time steps, but what they're trying to do is model the gravitational interactions between different stars over time, because they are exerting forces on each other, and they cause things to move around. 00:04:50,160 --> 00:05:07,800
所以这里发生的事情是，再次，我们有时间步长，但他们试图做的是模拟不同恒星之间随时间的引力相互作用，因为它们相互施加力，并且它们导致物体移动大约。
--So just as- hopefully, this will show up here. 00:05:07,800 --> 00:05:11,480
因此，希望这会出现在这里。
--But- so here's just, uh, like a little video of some, you know, the universe in the early day- early, uh, well, millions of years, that is, uh, after the Big Bang. 00:05:11,480 --> 00:05:24,120
但是 - 所以这里只是，呃，就像一些早期的宇宙的小视频 - 早期，呃，好吧，数百万年，也就是说，呃，在大爆炸之后。
--So you've got all these particles, and they're moving around, and they are, uh, attracting each other, and then moving toward each other. 00:05:24,120 --> 00:05:32,720
所以你有所有这些粒子，它们在四处移动，它们，呃，相互吸引，然后相互靠近。
--Okay. So that's- that's the idea behind this application. 00:05:32,720 --> 00:05:38,920
好的。这就是 - 这就是这个应用程序背后的想法。
--Now, this- this application is a little different. 00:05:38,920 --> 00:05:43,080
现在，这个——这个应用程序有点不同。
--Um, so unlike the ocean simulation, where we have a regular dense 2D array, the locations of the stars in the galaxy, that's much more irregular. 00:05:43,080 --> 00:05:55,240
嗯，与海洋模拟不同，我们有一个规则的密集二维阵列，银河系中恒星的位置更加不规则。
--So there are certain areas where they're really clumped together, and then there may be a lot of empty-ish space, and then there may be some others clumped together in other places. 00:05:55,240 --> 00:06:04,720
所以在某些区域它们确实聚集在一起，然后可能会有很多空旷的空间，然后可能会有一些其他区域在其他地方聚集在一起。
--So we don't want to represent this with a dense array, or matrix, because a lot of the space would be uninteresting. 00:06:04,720 --> 00:06:12,320
所以我们不想用密集的数组或矩阵来表示它，因为太多的空间会变得无趣。
--So this is a sparse data structure. 00:06:12,320 --> 00:06:15,120
所以这是一个稀疏数据结构。
--And so it's- it basically, you can think of it as a graph. 00:06:15,120 --> 00:06:18,680
因此，基本上，您可以将其视为图表。
--Um, and another thing about it is, um, if you did the naive computation, it would be very expensive because every body, every star is exerting a force on every other star. 00:06:18,680 --> 00:06:34,120
嗯，关于它的另一件事是，嗯，如果你进行天真的计算，那将是非常昂贵的，因为每个物体，每颗恒星都在对其他恒星施加力。
--So if we did point, you know, pairwise comparisons of everything with everything, this would not scale well at all, if we had a large number of these things, a large number of these stars. 00:06:34,120 --> 00:06:46,800
因此，如果我们确实指出，你知道，将所有事物与所有事物进行成对比较，如果我们有大量这样的东西，大量这些星星，那么这根本就不会很好地扩展。
--So the trick that they use to make this more tractable, is that if- if there are clusters of things, if there are things that are farther away, far enough away from a given star, then instead of- so if we're trying to update what's going on with respect to how the gravitational forces affect this particular star that I've circled, you know, there may be some that are relatively close to it, that we want to consider individually. 00:06:46,800 --> 00:07:13,960
所以他们用来使这更容易处理的技巧是，如果-如果有事物的集群，如果有更远的事物，离给定的恒星足够远，那么而不是-所以如果我们正在尝试更新关于引力如何影响我圈出的这颗特定恒星的最新情况，你知道，可能有一些相对接近它，我们想单独考虑。
--But then there might be, you know, another group of stars over here or over here, and they're far enough away that what we do is, instead of considering them all individually, we just clump them together into one approximate mass and pretend that there's just one big star there. 00:07:13,960 --> 00:07:31,760
但是，你知道，可能会有另一组恒星在这边或这边，它们离得足够远，我们所做的是，不是单独考虑它们，而是将它们聚集成一个近似的质量，然后假装那里只有一颗大星星。
--So that way that- that saves computation time. 00:07:31,800 --> 00:07:34,960
这样就可以节省计算时间。
--So one parameter is there's a certain radius. 00:07:34,960 --> 00:07:38,200
所以一个参数是有一定的半径。
--If you go- if you're within the radius and everything gets computed individually, if you go beyond that- that radius, then- then you start to aggregate things together. 00:07:38,200 --> 00:07:48,400
如果你去 - 如果你在半径内并且所有东西都被单独计算，如果你超出那个 - 那个半径，那么 - 然后你开始把东西聚集在一起。
--So I've been talking about it in terms of simulating galaxies, but this is- this- this- this is called an n-body simulation, and this is something that's done in physics and, you know, a lot of other situations. 00:07:48,400 --> 00:08:01,000
所以我一直在谈论模拟星系，但这是-这-这-这被称为 n 体模拟，这是物理学中所做的事情，你知道，还有很多其他情况。
--Okay. So how is this represented? Well, it turns out that one of the things you need to do frequently is think about where things are in space. 00:08:01,760 --> 00:08:11,040
好的。那么这是如何表示的呢？好吧，事实证明，您需要经常做的一件事就是考虑事物在空间中的位置。
--So you need to know how, you know, what are the other stars that are close by as opposed to stars that are far away. 00:08:11,040 --> 00:08:19,560
所以你需要知道，你知道，与远处的星星相比，靠近的其他星星是什么。
--So a data structure that's useful for capturing that kind of spatial information is, um, called a- a quadtree in two dimensions, and it would be an optree in three dimensions. 00:08:19,560 --> 00:08:32,040
因此，对于捕获这种空间信息有用的数据结构是，嗯，称为 a- 二维四叉树，它是三维的 optree。
--I'm showing it as a quadtree because that makes sense on a slide. 00:08:32,040 --> 00:08:35,520
我将其显示为四叉树，因为这在幻灯片上很有意义。
--But in the real program, it's actually three-dimensional and it's an optree. 00:08:35,520 --> 00:08:40,120
但是在真正的程序中，它实际上是三维的，它是一个optree。
--So the idea is- so this is the actual- in physical space here, you can see that there are- there are some regions where there aren't so many stars. 00:08:40,120 --> 00:08:52,960
所以这个想法是——所以这是实际的——在物理空间里，你可以看到有——有些区域没有那么多星星。
--So in this quadrant down here, we have just this one star. 00:08:52,960 --> 00:08:57,640
所以在下面的这个象限中，我们只有这一颗星。
--And then there are other quadrants where we have more stars. 00:08:57,640 --> 00:09:00,520
然后还有其他象限，我们有更多的星星。
--So what you do is you recursively, uh, subdivide each space and that gives you a tree, and eventually, um, you have leaf nodes where you're in your own particular space. 00:09:00,520 --> 00:09:11,640
所以你要做的是递归地，呃，细分每个空间，然后给你一棵树，最终，嗯，你在你自己的特定空间中有叶节点。
--So for example, right here, we have some things that are clustered fairly close together, and those are- are much deeper into the tree. 00:09:11,640 --> 00:09:21,160
因此，例如，就在这里，我们有一些东西非常靠近地聚集在一起，而且这些东西 - 在树中更深。
--So the reason why this is a handy data structure is that if you want to find things that are, uh, nearby, you usually only have to go a little bit up the tree and look around at other, you know, siblings or cousins or things like that. 00:09:21,160 --> 00:09:34,920
所以这是一个方便的数据结构的原因是，如果你想找到附近的东西，你通常只需要往树上爬一点，看看周围的其他人，你知道的，兄弟姐妹或堂兄弟姐妹或像这样的东西。
--Um, so that's- this is the data structure that's used in this computation. 00:09:34,920 --> 00:09:40,640
嗯，那就是——这是在这个计算中使用的数据结构。
--Okay. So in terms of what happens in this code, um, oh, great. 00:09:40,640 --> 00:09:47,200
好的。所以就这段代码中发生的事情而言，嗯，太棒了。
--Yeah. So in terms of what happens in this code, um, uh, in fact, we'll- we'll come back and talk more about this in a later lecture and go into a lot more detail about it. 00:09:47,200 --> 00:09:56,960
是的。所以就这段代码中发生的事情而言，嗯，呃，事实上，我们会 - 我们会在稍后的讲座中回来更多地讨论这个问题，并深入了解它的更多细节。
--But, um, there are time steps. 00:09:56,960 --> 00:09:59,360
但是，嗯，有时间步骤。
--And an interesting thing is on each time step, you have to rebuild this tree, this quadtree, because things are moving, and they may move out of the quadrant that they were in before. 00:09:59,360 --> 00:10:10,720
有趣的是在每个时间步，你必须重建这棵树，这棵四叉树，因为事物在移动，它们可能会移出它们之前所在的象限。
--So you may have to go back and re- reconstruct this tree. 00:10:10,720 --> 00:10:14,280
所以你可能不得不返回并重新构建这棵树。
--So there are time steps where you build the tree, and then you go, um, visit all of the nodes and figure out the collective impact of all the other forces. 00:10:14,280 --> 00:10:23,720
所以在构建树的过程中有时间步骤，然后你去，嗯，访问所有节点并找出所有其他力的集体影响。
--And then you update, um, the properties of each node. 00:10:23,760 --> 00:10:28,240
然后你更新，嗯，每个节点的属性。
--Okay. So- all right. 00:10:28,240 --> 00:10:31,400
好的。所以——好吧。
--So those are some examples that I'll refer back to. 00:10:31,400 --> 00:10:33,960
所以这些是我将要提到的一些例子。
--And now what we're going to start talking more, uh, generally about some of the things we have to worry about when we're trying to take a program and turn it into a parallel program. 00:10:33,960 --> 00:10:42,600
现在我们要开始更多地讨论，呃，一般来说，当我们试图把一个程序变成一个并行程序时，我们必须担心的一些事情。
--So as you may recall from, uh, I think it was either, uh, Monday or last week, I talked about how when we talk about performance in this class, we're going to use the term speedup. 00:10:42,600 --> 00:10:55,840
所以你可能还记得，呃，我想是，呃，星期一或上周，我谈到了当我们在这门课上谈论性能时，我们将如何使用加速这个术语。
--And that's the ratio of the time it took just on one processor versus the time that it's taking on more than one processor. 00:10:55,840 --> 00:11:03,400
这是它只在一个处理器上花费的时间与它在多个处理器上花费的时间的比率。
--So we want- we want to, um, maximize speedup which means hopefully this- this time is getting smaller and smaller. 00:11:03,400 --> 00:11:11,640
所以我们想要 - 我们想要，嗯，最大化加速，这意味着希望这个 - 这个时间越来越小。
--Okay. So some of the things that we want to think about as we're doing this is we- we want to take the overall work that we're doing in the original, um, sequential program and break it up into pieces so that the pieces can be given to different processors to work on. 00:11:11,640 --> 00:11:28,000
好的。所以我们在做这件事时想要考虑的一些事情是我们 - 我们想把我们在原始的，嗯，顺序程序中所做的整体工作分解成几个部分，以便这些部分可以交给不同的处理器来处理。
--So one of the- one of the steps is find- identify things that we can do in parallel. 00:11:28,000 --> 00:11:35,760
因此，其中一个步骤是找到 - 确定我们可以并行执行的事情。
--And then we want to, um, kind of divide that up into chunks that correspond to the number of processors that we have. 00:11:35,760 --> 00:11:44,120
然后我们想，嗯，将其分成与我们拥有的处理器数量相对应的块。
--And then finally, we need to have, um, all of those different threads, uh, interacting with each other correctly. 00:11:44,120 --> 00:11:52,160
最后，我们需要让所有这些不同的线程，呃，正确地相互交互。
--So we're going to go through this in a- in a lot more detail in some examples here. 00:11:52,160 --> 00:11:57,240
因此，我们将在此处的一些示例中更详细地介绍这一点。
--Okay. And so this is like a graph, uh, a more, uh, visual representation of what I just talked about, plus there's an- an extra step here. 00:11:57,240 --> 00:12:05,800
好的。所以这就像一个图表，呃，更多，呃，我刚才谈到的内容的视觉表示，再加上这里还有一个额外的步骤。
--So, uh, we're going to go through all these steps here. 00:12:05,800 --> 00:12:08,880
所以，呃，我们将在这里完成所有这些步骤。
--But the way to think of it is- so this thing at the top, uh, think of this as being some, uh, this blob is the computation that you need to do in this program. 00:12:08,880 --> 00:12:21,440
但是思考它的方式是——所以这个在顶部的东西，呃，把它想象成一些，呃，这个 blob 是你需要在这个程序中做的计算。
--So originally, uh, when one processor is doing all the work, it's just one big blob. 00:12:21,440 --> 00:12:27,200
所以最初，呃，当一个处理器完成所有工作时，它只是一个大斑点。
--But then we want to divide it into smaller pieces. 00:12:27,200 --> 00:12:30,840
但是我们想把它分成更小的部分。
--And we want to make sure that we have at least as many, uh, pieces of- of work as processors. 00:12:30,840 --> 00:12:37,800
我们希望确保我们至少拥有与处理器一样多的工作。
--If we have fewer pieces of work than processors, then we will definitely have some processors that won't have anything to do. 00:12:37,800 --> 00:12:45,520
如果我们的工作比处理器少，那么我们肯定会有一些处理器无事可做。
--Now, what are these- what are these pieces of work? And we- we often call them, uh, tasks. 00:12:45,520 --> 00:12:52,600
现在，这些是什么——这些作品是什么？而我们——我们经常称它们为，呃，任务。
--So- so a task- so this first step is, we call that decomposition, which is basically- this is a mental step where you- you think about what you're doing, and think what are some natural chunks of work that I could think about dividing up and doing these in parallel. 00:12:52,600 --> 00:13:09,520
所以-这是一项任务-所以第一步是，我们称之为分解，这基本上是-这是一个心理步骤，您-您考虑自己在做什么，并考虑我可以做哪些自然的工作考虑分开并并行执行这些操作。
--So for example, in the ocean simulation, each of those points in the 2D array, um, needs to be computed. 00:13:09,520 --> 00:13:17,720
因此，例如，在海洋模拟中，二维数组中的每个点，嗯，都需要计算。
--So each element is a potential task. 00:13:17,720 --> 00:13:20,600
所以每个元素都是一个潜在的任务。
--Now, there- turns out that there are- are way more of those elements than processors. 00:13:20,600 --> 00:13:26,600
现在，事实证明这些元素的数量远多于处理器。
--So we're not going to- we're going to group them together, uh, into larger chunks. 00:13:26,600 --> 00:13:33,360
所以我们不会 - 我们将把它们组合在一起，呃，分成更大的块。
--So that's- that's what this, uh, assignment step is. 00:13:33,360 --> 00:13:36,920
这就是 - 这就是这个，呃，分配步骤。
--So your initial- and another- another example of a task is in the n-body simulation, updating each individual star, you know, that's a potential, an obvious task. 00:13:36,920 --> 00:13:47,720
所以你的初始任务和另一个任务的另一个例子是在 n 体模拟中，更新每个单独的恒星，你知道，这是一个潜在的，明显的任务。
--But again, there are probably far more of those than there are processors. 00:13:47,720 --> 00:13:52,560
但同样，这些处理器的数量可能远远超过处理器的数量。
--So then the next step is, uh, to group together the tasks, um, in- so that you end up with, uh, get- hopefully giving each processor, uh, the same amount of work, uh, hopefully. 00:13:52,560 --> 00:14:06,360
那么下一步是，呃，将任务组合在一起，嗯，在 - 这样你最终得到，呃，希望 - 希望给每个处理器，呃，相同数量的工作，呃，希望如此。
--We want to get that as evenly balanced as possible. 00:14:06,400 --> 00:14:09,120
我们希望尽可能平衡。
--So remember from the very first lecture when I had, uh, four volunteers come up here and asked them to add up, uh, a total of 16 numbers but it turns out that I gave one of the people eight numbers, and the other people had far fewer things to add up. 00:14:09,120 --> 00:14:24,680
所以记得从第一堂课开始，当我有，呃，四个志愿者来到这里，要求他们加起来，呃，总共 16 个数字，但结果我给了其中一个人 8 个数字，而其他人要加起来的东西要少得多。
--So when we did that, the other three people ended up finishing early and then everyone was waiting around for the last, uh, unfortunate volunteer to add up their eight numbers. 00:14:24,680 --> 00:14:34,600
所以当我们这样做的时候，其他三个人提前完成，然后每个人都在等待最后一个，呃，不幸的志愿者把他们的八个数字加起来。
--So that's something we want to avoid. 00:14:34,640 --> 00:14:36,480
所以这是我们想要避免的事情。
--We want to divide up the work evenly. 00:14:36,480 --> 00:14:38,560
我们想平均分配工作。
--Like, remember the second time they did that, they passed, um, around those numbers so that everybody had four things to add up and, and it was divided up evenly. 00:14:38,560 --> 00:14:47,000
就像，记得他们第二次这样做，他们通过了，嗯，围绕这些数字，这样每个人都有四件事要加起来，然后平均分配。
--So that's, that's another thing that we want to do. 00:14:47,000 --> 00:14:49,920
这就是我们想要做的另一件事。
--Okay. So, so far what you're basically doing is just dividing up work into chunks. 00:14:49,920 --> 00:14:55,800
好的。所以，到目前为止，您所做的基本上只是将工作分成块。
--But then the next step is, you have to have the, uh, threads actually work together and cooperate. 00:14:55,800 --> 00:15:02,560
但下一步是，你必须让，呃，线程真正协同工作。
--And that step is what we call orchestration. 00:15:02,560 --> 00:15:06,640
这一步就是我们所说的编排。
--And the details of that depend very much on the, uh, programming abstraction, like, and you'll see that when we go through our examples today. 00:15:06,640 --> 00:15:15,880
其细节在很大程度上取决于，呃，编程抽象，就像，当我们今天浏览我们的示例时，您会看到这一点。
--So that's going to look very different for shared address space versus message passing versus data parallel. 00:15:15,880 --> 00:15:23,840
因此，对于共享地址空间、消息传递和数据并行而言，这看起来非常不同。
--And then finally, the last step is, um, not necessarily something that programmers worry about, but you can take these, um, these threads and decide how they actually get mapped to the physical hardware. 00:15:23,840 --> 00:15:38,640
最后，最后一步是，嗯，不一定是程序员担心的事情，但你可以采用这些，嗯，这些线程并决定它们如何实际映射到物理硬件。
--In many cases, programmers just let the system do whatever it naturally wants to do. 00:15:38,640 --> 00:15:43,360
在很多情况下，程序员只是让系统做它自然想做的事情。
--But there are cases where you might want to be more careful about that. 00:15:43,360 --> 00:15:46,840
但在某些情况下，您可能需要更加小心。
--So, and that would probably depend on if you have, for example, an interconnect where you can only talk to your nearest neighbors, then you may want to make sure that you map the computation onto the machine so that the, the communication is in fact happening between nearest neighbors. 00:15:46,840 --> 00:16:03,440
所以，这可能取决于你是否有，例如，你只能与最近的邻居交谈的互连，那么你可能需要确保将计算映射到机器上，以便通信在最近邻居之间发生的事实。
--Okay. So those are the steps. 00:16:03,440 --> 00:16:06,160
好的。这些就是步骤。
--And now what I'm going to do is, uh, we're going to go through them. 00:16:06,160 --> 00:16:09,440
现在我要做的是，呃，我们将通过它们。
--Uh, we're going to start with, uh, decomposition. 00:16:09,440 --> 00:16:12,760
呃，我们将从，呃，分解开始。
--And we're going to talk about some issues to think about for all these different steps. 00:16:12,760 --> 00:16:17,800
我们将讨论所有这些不同步骤中需要考虑的一些问题。
--Okay. So, um, so the point of, uh, decomposition is to break up the code, um, so into the tasks. 00:16:18,040 --> 00:16:27,480
好的。所以，嗯，分解的重点是分解代码，嗯，分解成任务。
--Now, um, okay, this usually is not a very difficult thing to do. 00:16:27,520 --> 00:16:32,320
现在，嗯，好吧，这通常不是一件很难的事情。
--The most important thing to think, one of the most important things to realize is that you, um, you need to have at least as many tasks as threads. 00:16:32,320 --> 00:16:42,480
最重要的是要思考，最重要的事情之一是你，嗯，你需要至少和线程一样多的任务。
--If you, in fact, usually you'd like to have more tasks than threads, because there's a good chance that you won't get this quite right. 00:16:42,480 --> 00:16:51,320
事实上，如果您通常希望拥有比线程更多的任务，因为您很可能无法做到这一点。
--Uh, you know, you won't necessarily, the task size won't necessarily, they won't all be equal. 00:16:51,320 --> 00:16:55,920
呃，你知道，你不一定，任务大小不一定，他们不会都相等。
--And you'd like to have some flexibility to maybe shift things around a little bit. 00:16:55,960 --> 00:16:59,840
并且您希望有一些灵活性来稍微改变一下。
--So you want them to be small enough tasks that you have plenty of them. 00:16:59,840 --> 00:17:04,680
所以你希望它们是足够小的任务，你有很多。
--You don't need to go crazy and make each task super, super, super small because there's going to be overhead with managing them if they're too low. 00:17:04,680 --> 00:17:13,040
你不需要疯狂地让每项任务都变得超级、超级、超级小，因为如果它们太低，管理它们会产生开销。
--But, but it's reasonable to say, um, for example, that each star in the galaxy simulation is a task. 00:17:13,040 --> 00:17:20,480
但是，但是有道理的说，嗯，比如说，星系模拟中的每颗恒星都是一个任务。
--And, uh, for the ocean simulation, maybe, um, individual elements in the array might be tasks, or maybe rows or columns might be tasks. 00:17:20,480 --> 00:17:30,200
而且，呃，对于海洋模拟，也许，嗯，数组中的单个元素可能是任务，或者行或列可能是任务。
--We'll come back and talk about that later. 00:17:30,200 --> 00:17:33,200
我们稍后会回来讨论。
--Okay. Now, the thing about tasks is you want to identify tasks that are independent of each other. 00:17:33,400 --> 00:17:41,720
好的。现在，关于任务的事情是你想要识别彼此独立的任务。
--So this involves thinking about dependencies. 00:17:41,720 --> 00:17:44,920
所以这涉及到考虑依赖性。
--If you have potential tasks that, uh, where one of them can't begin until you finish computing the other one, then that's not really a source of parallelism. 00:17:44,920 --> 00:17:53,960
如果您有潜在的任务，呃，其中一个任务在您完成另一个任务的计算之前无法开始，那么这并不是真正的并行性来源。
--Those are actually things that have to be done, uh, serially. 00:17:53,960 --> 00:17:58,480
这些实际上是必须连续完成的事情。
--Okay. Now, one of the things we'll talk about, uh, for a minute here is, uh, a common, uh, mistake that you can make at this point is to get very excited about some portion of the execution that you decide that you can parallelize nicely and ignore other parts that are harder to deal with, and, and think that that's a good thing to do. 00:17:58,560 --> 00:18:21,120
好的。现在，我们要讨论的一件事，呃，在这里花一分钟时间，呃，一个常见的，呃，你在这一点上可能犯的错误是对你决定执行的某些部分感到非常兴奋您可以很好地并行化并忽略其他更难处理的部分，并且认为这是一件好事。
--So actually, how many people have heard of Amdahl's Law? Okay. A bunch of people. 00:18:21,120 --> 00:18:26,760
那么实际上，有多少人听说过阿姆达尔定律呢？好的。一群人。
--Good. Okay. Good. 00:18:26,760 --> 00:18:28,400
好的。好的。好的。
--All right. So we're just going to review this quickly, um, and Amdahl's Law, it's named after Gene Amdahl, who was, uh, uh, a researcher at IBM. 00:18:28,400 --> 00:18:37,960
好的。所以我们要快速回顾一下，嗯，阿姆达尔定律，它是以吉恩·阿姆达尔的名字命名的，他是 IBM 的一名研究员。
--And, uh, it limit- basically what it says is the fraction of the program that we're running, uh, sequentially, the part that we're not running in parallel, will ultimately create an upper bound on how much performance we can get with parallelism. 00:18:37,960 --> 00:18:53,520
而且，呃，它限制了——基本上它说的是我们正在运行的程序的一部分，呃，顺序地，我们没有并行运行的部分，最终会创造一个上限，我们可以达到多少性能获得并行性。
--So let's just look at a practical, uh, example of how that could bite us. 00:18:53,520 --> 00:18:59,760
因此，让我们看一个实际的例子，呃，它会如何影响我们。
--Okay. So here's- imagine that we are- we have an image processing, uh, algorithm where- that involves two steps. 00:18:59,760 --> 00:19:08,360
好的。所以这里是 - 想象我们 - 我们有一个图像处理，呃，算法 - 这涉及两个步骤。
--So the first step is that we want to, uh, double the brightness of every pixel. 00:19:08,360 --> 00:19:15,280
所以第一步是我们想要，呃，将每个像素的亮度加倍。
--And the second step is that we want to calculate the average of all the pixel values after we do that. 00:19:15,280 --> 00:19:21,240
第二步是我们要计算所有像素值的平均值。
--So the nice thing about the, uh, first step is that there are no dependencies there in step one. 00:19:21,240 --> 00:19:28,120
所以，呃，第一步的好处是在第一步中没有依赖关系。
--We can independently go to each pixel and just double the value there. 00:19:28,120 --> 00:19:31,920
我们可以独立地访问每个像素并将那里的值加倍。
--That's- that's easy to do in parallel. 00:19:31,920 --> 00:19:34,040
这很容易并行进行。
--The second step, um, when we're computing the average of all the pixels, that's a reduction of- that's- that's a little bit like the massively parallel example we had, um, in our first class where you tried to add up all the numbers of how many courses you're registered for across the whole class. 00:19:34,040 --> 00:19:51,520
第二步，嗯，当我们计算所有像素的平均值时，这是对 - 那 - 这有点像我们在第一堂课中尝试将所有像素加起来的大规模并行示例您在整个班级注册的课程数量。
--And remember that had a lot of dependencies in it. 00:19:51,520 --> 00:19:53,920
请记住，它有很多依赖关系。
--So maybe that's challenging. 00:19:53,920 --> 00:19:56,560
所以也许这很有挑战性。
--Okay. So what we'll- let's say that, um, since we have an n by n, uh, image, um, we'll just say that roughly speaking, our sequential- if we did this, uh, sequentially, we would visit n squared elements and then we'd visit n squared elements again. 00:19:56,560 --> 00:20:14,120
好的。那么我们要说的是，嗯，因为我们有一个 n × n，呃，图像，嗯，我们只是粗略地说，我们的顺序 - 如果我们这样做，呃，顺序地，我们会访问n 个平方元素，然后我们将再次访问 n 个平方元素。
--So our time is proportional to two times n squared, let's say. 00:20:14,160 --> 00:20:19,200
所以我们的时间与 n 的平方的两倍成正比，比方说。
--Okay. All right. 00:20:19,200 --> 00:20:21,720
好的。好的。
--Now, uh, let's start trying to do this in parallel. 00:20:21,720 --> 00:20:25,520
现在，呃，让我们开始尝试并行执行此操作。
--And as I said, the first step is easy to parallelize because every computation on each pixel is entirely independent. 00:20:25,520 --> 00:20:33,040
正如我所说，第一步很容易并行化，因为每个像素上的每个计算都是完全独立的。
--So that one should- that should go well. 00:20:33,040 --> 00:20:35,520
所以那个应该——那应该会进行得很顺利。
--So this- this purple part, which is, uh, step one, uh, we'd expect that to, uh, run about p times faster on p processors because the work's completely independent. 00:20:35,520 --> 00:20:48,360
所以这个 - 这个紫色部分，呃，第一步，呃，我们希望它，呃，在 p 个处理器上运行速度快 p 倍，因为工作是完全独立的。
--So the more processors we throw at it, the faster it should run, hopefully. 00:20:48,360 --> 00:20:52,360
因此，我们投入的处理器越多，它运行的速度就越快，这是有希望的。
--Hopefully, that's nice and linear. 00:20:52,360 --> 00:20:54,400
希望这很好而且是线性的。
--Okay. Well, what's that going to do overall? Well, the, uh, the purple portion of execution time, uh, so, uh, the- the figure here, the way to explain this, uh, the- the x-axis is- the horizontal axis is time. 00:20:54,400 --> 00:21:10,280
好的。好吧，那总体上会做什么？好吧，呃，执行时间的紫色部分，呃，所以，呃，这里的图，解释这个的方式，呃，x 轴是 - 水平轴是时间。
--And the, uh, y-axis is how much parallelism you're taking advantage of. 00:21:10,400 --> 00:21:14,720
呃，y 轴是您利用了多少并行性。
--So in the sequential program, uh, there's no parallelism, so it's one. 00:21:14,720 --> 00:21:19,280
所以在顺序程序中，呃，没有并行性，所以它是一个。
--In the, um, in the, um, parallel program, we have p processors. 00:21:19,280 --> 00:21:25,160
在，嗯，在，嗯，并行程序中，我们有 p 个处理器。
--So we're running p times faster in the purple part, but then not running in parallel in the green part. 00:21:25,160 --> 00:21:30,720
所以我们在紫色部分的运行速度快了 p 倍，但在绿色部分并没有并行运行。
--So if you think about what happens to this- the execution time, as we throw more and more processors at this, um, we- this is the, uh, we start off with 2n squared time, that's this time. 00:21:30,720 --> 00:21:43,400
所以如果你想一想这会发生什么 - 执行时间，因为我们投入越来越多的处理器，嗯，我们 - 这是，呃，我们从 2n 平方时间开始，就是这个时间。
--And then we, uh, have n squared over p here, that gets to be nice and small, especially as p gets to be large. 00:21:43,400 --> 00:21:51,280
然后我们，呃，在这里对 p 进行了 n 平方，它变得又好又小，尤其是当 p 变大时。
--But unfortunately, this part here didn't get any smaller. 00:21:51,280 --> 00:21:54,120
但不幸的是，这部分并没有变小。
--So in the limit, if you threw infinite processors at this, it would only run no more than twice as fast, because we didn't do anything to accelerate the second, uh, step. 00:21:54,120 --> 00:22:04,280
所以在极限情况下，如果你为此投入无限的处理器，它的运行速度不会超过两倍，因为我们没有做任何事情来加速第二步，呃，步骤。
--So we don't want to ignore that. 00:22:04,280 --> 00:22:07,640
所以我们不想忽视这一点。
--So how can we deal with that second step? Well, there are data dependencies there, but a very common trick that, uh, people use in, in situations like this, is we could have each processor compute a partial sum. 00:22:07,640 --> 00:22:23,200
那么我们如何处理第二步呢？好吧，那里存在数据依赖性，但是人们在这种情况下使用的一个非常常见的技巧是我们可以让每个处理器计算一个部分和。
--So they can add up the sum of all of the, uh, they can average together all the pixels for the portion of the image that we've given them. 00:22:23,200 --> 00:22:33,360
因此，他们可以将所有的总和相加，呃，他们可以将我们提供给他们的图像部分的所有像素平均在一起。
--They do that first because they can do that independently of each other. 00:22:33,480 --> 00:22:37,240
他们首先这样做是因为他们可以彼此独立地做到这一点。
--So that part, um, so there's one part where, um, that's nice and parallel, which is they compute their, their local sums. 00:22:37,240 --> 00:22:47,760
所以那部分，嗯，所以有一个部分，嗯，这是很好的和并行的，他们计算他们的本地总和。
--But then there's another step, which is we then have to add all of those together. 00:22:47,760 --> 00:22:52,200
但是还有另一个步骤，那就是我们必须将所有这些加在一起。
--And that will be serialized. 00:22:52,200 --> 00:22:54,880
这将被序列化。
--Um, we'll probably, you know, we'll just do those one at a time. 00:22:54,880 --> 00:22:58,520
嗯，我们可能会，你知道，我们一次只做一个。
--So that will take, um, that won't be parallel. 00:22:58,520 --> 00:23:02,000
所以这将需要，嗯，那不会是平行的。
--So that's, that's this part here. 00:23:02,040 --> 00:23:04,560
这就是这一部分。
--So it's no parallelism here. 00:23:04,560 --> 00:23:06,840
所以这里没有并行性。
--But, um, the width of that is only p. 00:23:06,840 --> 00:23:10,600
但是，嗯，它的宽度只有 p。
--And, um, and given that n is probably much, much, much larger than p typically, then in fact we, we won't get perfect speedup, but we'll get something close to real perfect speedup. 00:23:10,600 --> 00:23:22,120
而且，嗯，假设 n 通常比 p 大很多很多，那么实际上我们不会得到完美的加速，但我们会得到接近真正完美的加速。
--So this is a way to get, uh, potentially very good performance on a program like this. 00:23:22,120 --> 00:23:28,680
所以这是一种在这样的程序上获得，呃，潜在非常好的性能的方法。
--Okay. But in general, um, the fraction of the execution time that you are not parallelizing will limit overall performance. 00:23:29,120 --> 00:23:38,400
好的。但总的来说，嗯，您未并行化的执行时间部分会限制整体性能。
--So for example, if, um, only 90% of the code is running in parallel, then even if it's running very nicely in parallel, you're not going to get a speedup of more than 10, and, and so on. 00:23:38,400 --> 00:23:51,920
因此，例如，如果，嗯，只有 90% 的代码并行运行，那么即使它并行运行得非常好，你也不会获得超过 10 的加速，等等。
--And if you have, you know, even 99% of it is running in parallel, ultimately you can't get a speedup of more than 100, for example. 00:23:51,920 --> 00:24:00,000
如果你知道，即使 99% 是并行运行的，最终你也无法获得超过 100 的加速比，例如。
--Okay. Okay. So we're talking about decomposition, which is thinking about taking the work and breaking it up into tasks. 00:24:01,120 --> 00:24:09,560
好的。好的。所以我们谈论的是分解，也就是考虑把工作分解成任务。
--And, uh, so how does that step normally happen? So it turns out that this is, this is almost always done, uh, in, in the mind of the programmer. 00:24:09,560 --> 00:24:19,520
而且，呃，那么这一步通常是如何发生的呢？所以事实证明，这几乎总是在程序员的脑海中完成。
--So this is an exercise for the programmer where they think about what's going on, and they decide what would be a good set of tasks. 00:24:19,520 --> 00:24:27,320
所以这是对程序员的一个练习，他们思考正在发生的事情，并决定什么是一组好的任务。
--In an ideal world, it would be nice if there were compilers or tools that could automatically figure this out. 00:24:27,320 --> 00:24:33,640
在理想情况下，如果有编译器或工具可以自动解决这个问题，那就太好了。
--Um, but, uh, that's a very hard problem for compilers. 00:24:33,640 --> 00:24:37,480
嗯，但是，呃，这对编译器来说是一个非常困难的问题。
--So although people have worked on that problem for many years, and in fact I've worked on it, uh, also, uh, there's only been like modest success in that area because it's difficult to think about all these dependencies. 00:24:37,480 --> 00:24:49,080
因此，尽管人们多年来一直致力于解决这个问题，事实上我也致力于解决这个问题，但是，呃，也，呃，在那个领域只取得了适度的成功，因为很难考虑所有这些依赖关系。
--So this is something that programmers usually think about. 00:24:49,080 --> 00:24:52,200
所以这是程序员通常会思考的问题。
--Okay. So that's the first step, is to identify tasks, um, like, um, where each, the updating the, uh, the properties of each star in the galaxy simulation, or each element in the ocean simulation. 00:24:52,200 --> 00:25:06,560
好的。所以这是第一步，是确定任务，嗯，比如，嗯，每个任务，更新银河系模拟中每颗恒星的属性，或者海洋模拟中的每个元素。
--And, um, often, so the granularity of a task is usually defined by some natural piece of computation in the code. 00:25:07,360 --> 00:25:18,640
而且，嗯，通常，任务的粒度通常由代码中的一些自然计算来定义。
--So for example, a star. 00:25:18,640 --> 00:25:20,640
例如，一个明星。
--But the size of the amount of work that you do, um, that's not necessarily the right amount to, to give entirely to one processor and say that's all that you're going to do. 00:25:20,640 --> 00:25:32,120
但是你所做的工作量的大小，嗯，这不一定是正确的，完全交给一个处理器并说这就是你要做的全部。
--Chances are you want to bundle together collections of these tasks and assign those to processors. 00:25:32,120 --> 00:25:37,720
您可能希望将这些任务的集合捆绑在一起并将它们分配给处理器。
--And that's, that's the next step here, assignment. 00:25:37,720 --> 00:25:41,120
那就是，这是这里的下一步，作业。
--Okay. So, all right. 00:25:41,120 --> 00:25:44,000
好的。所以，好吧。
--There are interesting trade-offs, uh, when you're trying to group together these tasks into the right bundles to give to each thread. 00:25:44,000 --> 00:25:53,480
有一些有趣的权衡，呃，当你试图将这些任务组合到正确的包中以提供给每个线程时。
--So in an ideal world, what you would like to do is, first of all, give, give each processor the same amount of work. 00:25:53,480 --> 00:26:01,560
所以在一个理想的世界里，你想要做的是，首先，给每个处理器相同数量的工作。
--And we, as I mentioned a minute ago, we saw an example where that didn't work with the four people, where I didn't balance the work nicely. 00:26:01,560 --> 00:26:09,480
正如我在一分钟前提到的，我们看到了一个例子，在这个例子中，四个人没有合作，我没有很好地平衡工作。
--But that's not the only goal. 00:26:09,480 --> 00:26:11,400
但这不是唯一的目标。
--Another thing that also really limits performance is communication overhead. 00:26:11,400 --> 00:26:16,560
另一个真正限制性能的因素是通信开销。
--So if, in order to perform your task, if you have to get data from another processor, then that's going to be, uh, that's going to be non-trivially expensive. 00:26:16,560 --> 00:26:26,880
因此，如果为了执行您的任务，如果您必须从另一个处理器获取数据，那么这将是，呃，这将是非常昂贵的。
--Either that's a cache miss or you're waiting for a message. 00:26:26,880 --> 00:26:30,480
要么是缓存未命中，要么是您正在等待消息。
--But somehow communication, if communication has to take place and possibly synchronization, then that can be a source of, of a lot of performance loss. 00:26:30,480 --> 00:26:40,400
但是不知何故通信，如果必须进行通信并且可能需要同步，那么这可能会导致大量性能损失。
--So the other thing you would like to do is minimize communication. 00:26:40,400 --> 00:26:44,200
所以你想做的另一件事是尽量减少沟通。
--So ideally, the set of tasks that I give to one processor, it can do almost all of that work with hardly communicating at all with its, with the other processors, hopefully, in an ideal world. 00:26:44,200 --> 00:26:57,720
所以理想情况下，我给一个处理器的一组任务，它可以完成几乎所有的工作，而几乎不与它、与其他处理器通信，希望在理想的世界中。
--Now, it turns out that, um, unfortunately, these two things are at odds with each other. 00:26:57,720 --> 00:27:05,520
现在，事实证明，嗯，不幸的是，这两件事是相互矛盾的。
--And we'll talk more about that on Friday. 00:27:05,520 --> 00:27:08,280
我们将在周五详细讨论这一点。
--But basically, um, the thing that you might do, for example, a good way to ensure that you balance the load evenly would be to randomly assign tasks to processors because that would avoid any, uh, systematic, um, biases, or in cases where you accidentally give one far more work than the other ones. 00:27:08,360 --> 00:27:29,920
但是基本上，嗯，你可能会做的事情，例如，一个确保你均衡负载的好方法是随机分配任务给处理器，因为这会避免任何，呃，系统的，嗯，偏见，或者在您不小心给一个人做的工作比其他人多得多的情况。
--But that is absolutely the worst thing to do for locality. 00:27:29,920 --> 00:27:33,320
但这绝对是当地最糟糕的事情。
--So that would maximize communication. 00:27:33,320 --> 00:27:36,080
这样可以最大化沟通。
--Similarly, uh, if you're completely trying to minimize communication, in the extreme, you would give all the work to one processor, uh, because then it wouldn't have to communicate at all, right? Uh, but that would also not be so good for balancing the work. 00:27:36,080 --> 00:27:50,360
类似地，呃，如果你完全想尽量减少通信，在极端情况下，你会将所有工作交给一个处理器，呃，因为那样它就根本不需要通信了，对吧？呃，但这也不利于平衡工作。
--So, um, we'll talk more about this on Friday, but that's another challenge. 00:27:50,360 --> 00:27:55,640
所以，嗯，我们将在周五详细讨论这个问题，但这是另一个挑战。
--Now, this, um, this grouping together in the assignment phase, that can either occur statically or dynamically. 00:27:55,640 --> 00:28:05,000
现在，这个，嗯，这个在分配阶段分组在一起，可以静态或动态发生。
--When we do it statically, it means that basically before the program starts to even do the work, you've already decided exactly how you're going to divide everything up. 00:28:05,040 --> 00:28:15,560
当我们静态地进行时，这意味着基本上在程序开始工作之前，您已经准确地决定了如何划分所有内容。
--When you do it dynamically, that means you haven't made that decision and you just work it out all along the way. 00:28:15,560 --> 00:28:22,800
当你动态地做这件事时，这意味着你还没有做出那个决定，你只是一直在努力解决它。
--So I'm going to show you examples of both of those things. 00:28:22,800 --> 00:28:26,480
因此，我将向您展示这两方面的示例。
--Okay. So remember in, in ISPC, um, uh, the other day, we, we looked at this code where, um, in the case on the left over here, you can see that the, um, the work that we're doing, we were using, uh, program count and program index in this, in this case to do interleaved assignment of the work to processors. 00:28:26,480 --> 00:28:52,920
好的。所以请记住，在 ISPC 中，嗯，呃，前几天，我们查看了这段代码，嗯，在左边的例子中，你可以看到，嗯，我们正在做的工作，我们在这里使用，呃，程序计数和程序索引，在这种情况下，将工作交错分配给处理器。
--So this is an example of static assignment because the software, we already know how we're going to divide up the work. 00:28:52,920 --> 00:29:00,640
所以这是一个静态分配的例子，因为软件，我们已经知道我们将如何分配工作。
--We're going to interleave it across these, uh, uh, computational instances which happen to be vector lanes in this case. 00:29:00,640 --> 00:29:10,360
我们将把它交错在这些，呃，呃，在这种情况下恰好是矢量车道的计算实例中。
--Okay. So that's static. 00:29:10,360 --> 00:29:12,160
好的。所以这是静态的。
--But I said there's another option which is I could just say, instead of going through all that work, I could simply say that the, the iterations of this outer loop, they can be done in parallel and I'll let the system decide how to do that. 00:29:12,160 --> 00:29:25,360
但我说还有另一种选择，我可以说，我可以简单地说，这个外循环的迭代可以并行完成，我会让系统决定如何要做到这一点。
--Now, the system could either take that for each and statically interleave, or it could decide to just, uh, hand things out on the fly. 00:29:25,360 --> 00:29:36,360
现在，系统可以为每个人获取它并静态交错，或者它可以决定只是，呃，即时分发东西。
--Okay. So now let's look at some more, uh, examples of both types of assignments. 00:29:36,360 --> 00:29:44,240
好的。那么现在让我们再看一些，嗯，这两种类型的任务的例子。
--So for example, um, we're going to look at, uh, a different type of static assignment. 00:29:44,240 --> 00:29:49,760
因此，例如，嗯，我们将研究，呃，一种不同类型的静态赋值。
--So in this case, um, we want- let's say we have two processors. 00:29:49,760 --> 00:29:54,000
所以在这种情况下，嗯，我们想要 - 假设我们有两个处理器。
--So we only need to divide the work in half. 00:29:54,000 --> 00:29:56,440
所以我们只需要将工作分成两半。
--And we're going to call sine x. 00:29:56,440 --> 00:30:00,720
我们将调用正弦 x。
--But, uh, what we're doing is we're adding, we're adding more code here. 00:30:00,720 --> 00:30:05,960
但是，呃，我们正在做的是添加，我们在这里添加更多代码。
--And effectively what this code does is we have an array, and it has, you know, all these elements in it, and this is the input values that we're calculating on, and then we're going to generate an output array that has exactly the same number of elements. 00:30:05,960 --> 00:30:22,000
这段代码所做的实际上是我们有一个数组，它有，你知道的，里面有所有这些元素，这是我们计算的输入值，然后我们将生成一个输出数组具有完全相同数量的元素。
--And what we're doing here is we're just dividing it in half. 00:30:22,000 --> 00:30:25,400
我们在这里所做的只是将其一分为二。
--So in fact, what it does, if you look carefully, it's calling, uh, pthread create, and creating, uh, a child thread. 00:30:25,400 --> 00:30:35,960
所以实际上，它所做的，如果你仔细看，它是调用，呃，pthread create，并创建，呃，一个子线程。
--And the child thread gets the right half, and the parent thread gets the left half, or, or maybe vice versa, one of those. 00:30:35,960 --> 00:30:44,400
子线程获得右半部分，父线程获得左半部分，或者反之亦然。
--So we, we create another thread with pthreads, and now we have two threads, and each of them do half of the work. 00:30:44,400 --> 00:30:50,640
所以我们，我们用 pthreads 创建了另一个线程，现在我们有两个线程，每个线程做一半的工作。
--Okay. So what do you think about this? Is this, is this a good way to write parallel software, or do you see something that, that concerns you about this? I'm not, I'm not worried about the pthread part specifically. 00:30:50,640 --> 00:31:09,000
好的。所以，对于这个你有什么想法？这是，这是编写并行软件的好方法，还是您看到了让您担心的事情？我不是，我并不特别担心 pthread 部分。
--I just meant, what about this decision about how we're dividing up the work? Are there, are there any hazards to doing it this way? Yeah. 00:31:09,000 --> 00:31:18,160
我的意思是，关于我们如何划分工作的这个决定怎么样？有没有，这样做有什么危害吗？是的。
--And it may not use all the hardware. 00:31:18,160 --> 00:31:20,400
而且它可能不会使用所有硬件。
--Right. Yeah. Yeah. 00:31:20,400 --> 00:31:22,120
正确的。是的。是的。
--Well, at least, you know, in this case, we've- the code is hardwired to only create two threads. 00:31:22,120 --> 00:31:28,040
好吧，至少，你知道，在这种情况下，我们已经- 代码被硬连接到只创建两个线程。
--So if we run that on a processor that has four cores on it, well, we only have two threads. 00:31:28,040 --> 00:31:33,680
因此，如果我们在具有四个内核的处理器上运行它，那么，我们只有两个线程。
--So it's not necessarily gonna take advantage of all the different pieces, all the hardware. 00:31:33,680 --> 00:31:38,480
所以它不一定会利用所有不同的部分，所有的硬件。
--Let's say we just have two, uh, cores though. 00:31:38,480 --> 00:31:41,960
假设我们只有两个，呃，核心。
--Um, is there anything potentially not good about doing, doing the assignment this way? Yeah. 00:31:41,960 --> 00:31:52,000
嗯，这样做有什么不好的地方吗，以这种方式完成作业？是的。
--Um, one half of the array might have like, uh, significantly, like, I'm not sure if it applies for sign specifically, but significantly bigger numbers. 00:31:52,000 --> 00:32:03,800
嗯，数组的一半可能有，呃，很明显，我不确定它是否特别适用于符号，但数字明显更大。
--Yeah. 00:32:03,800 --> 00:32:04,040
是的。
--Which would take more time. 00:32:04,040 --> 00:32:05,400
这将花费更多时间。
--Whereas if you have them like, kind of do a thing where they meet in the middle, they would end when they're both done. 00:32:05,400 --> 00:32:13,320
而如果你让他们喜欢，在他们中间相遇的地方做一件事，当他们都完成时他们就会结束。
--Yeah. Yeah. Exactly. 00:32:13,320 --> 00:32:14,640
是的。是的。确切地。
--So yeah. So again, that's a good point. 00:32:14,640 --> 00:32:17,240
嗯是的。再一次，这是一个很好的观点。
--So set aside the specific details of what signed is. 00:32:17,240 --> 00:32:20,280
所以先把signed是什么的具体细节搁置一旁。
--But if we think more generically about calling some routine foo, and it's gonna, uh, calculate something based on an input array, it may be that, uh, the amount of work varies quite a bit. 00:32:20,280 --> 00:32:31,600
但是，如果我们更笼统地考虑调用一些例程 foo，它会，呃，根据输入数组计算一些东西，那么，呃，工作量可能会有很大差异。
--And it may also be the case that the, the work is much larger for the right-hand side than the left-hand side. 00:32:31,600 --> 00:32:37,920
也可能是右侧的工作量比左侧大得多。
--So a problem with this is, although we've created two threads, they- and, and in fact, in this case, they don't communicate probably at all. 00:32:37,920 --> 00:32:46,160
所以这个问题是，虽然我们已经创建了两个线程，但它们 - 事实上，在这种情况下，它们可能根本不通信。
--So that's good. Uh, but we don't mean, we may not necessarily have balanced the amount of work very much. 00:32:46,160 --> 00:32:51,440
所以这很好。呃,但是我们不是说,我们不一定很平衡工作量。.
--So it may be that one of them will finish, uh, far earlier than the other one. 00:32:51,440 --> 00:32:55,920
所以他们中的一个可能比另一个完成得早得多。
--So that's a motivation for, uh, dynamic assignment. 00:32:55,920 --> 00:33:00,440
所以这是动态分配的动机。
--So the idea behind dynamic assignment is that you tell the system, here's, here's a set of work. 00:33:00,440 --> 00:33:07,280
所以动态分配背后的想法是你告诉系统，这是，这是一组工作。
--And you can think of this as being, um, like a queue where you've just, uh, stuck a lot of work into a queue. 00:33:07,280 --> 00:33:15,040
你可以把它想象成，嗯，就像一个队列，你只是，呃，把很多工作塞进了一个队列。
--And when you want to do work, you grab something off of the queue and you process it. 00:33:15,040 --> 00:33:19,880
当你想工作时，你从队列中抓取一些东西然后处理它。
--And when you finish that, you go back to the queue and you grab another piece of work and you do that. 00:33:19,880 --> 00:33:24,640
当你完成后，你回到队列中，抓起另一件工作，然后你就这样做了。
--And the processors are dynamically going to the queue to grab work. 00:33:24,640 --> 00:33:29,240
并且处理器正在动态地进入队列以获取工作。
--So if one piece of work takes a long time, uh, that's okay because that processor will spend a while doing it. 00:33:29,240 --> 00:33:36,680
因此，如果一项工作需要很长时间，呃，那没关系，因为处理器会花一些时间来完成它。
--But meanwhile, the other processors, they can finish their shorter tasks, go back and grab more work, and go back and grab even more work. 00:33:36,680 --> 00:33:43,400
但与此同时，其他处理器，他们可以完成较短的任务，回去抢更多的工作，然后回去抢更多的工作。
--And hopefully, it will all balance out in the end. 00:33:43,440 --> 00:33:46,560
希望最终一切都会平衡。
--So for example, um, I mentioned ISPC has something called a task. 00:33:46,560 --> 00:33:51,400
例如，嗯，我提到 ISPC 有一个叫做任务的东西。
--And this is a way that you can specify, uh, work in this style where you say, here are a bunch of chunks of work. 00:33:51,400 --> 00:34:00,000
这是一种你可以指定的方式，呃，在你说的这种风格中工作，这里有一大堆工作。
--And then the system dynamically, it has essentially a pointer that, that will point to the next task that is to be handed out. 00:34:00,000 --> 00:34:08,160
然后系统是动态的，它本质上有一个指针，它将指向下一个要分发的任务。
--So initially, you start running and each core gets a task, um, and whichever one finishes first will go back. 00:34:08,160 --> 00:34:16,640
所以一开始，你开始运行，每个核心都有一个任务，嗯，哪个先完成就会返回。
--So let's say this one finishes first, it'll go back and get the next thing. 00:34:16,640 --> 00:34:20,360
所以假设这个首先完成，它会返回并获得下一件事。
--And then this pointer will point to the next thing in the list. 00:34:20,360 --> 00:34:23,920
然后这个指针将指向列表中的下一个事物。
--Okay. So what do you think about this approach? Uh, not necessarily ISP specifically, but more generically speaking, what about, what, what about runtime assignment or dynamic assignment? So an advantage of it is probably does a good job of balancing the load. 00:34:23,920 --> 00:34:42,080
好的。那么您如何看待这种方法？呃，不一定是特定的 ISP，但更一般地说，运行时分配或动态分配怎么样？所以它的一个优点可能是很好地平衡负载。
--So that's an advantage. Do you see any disadvantages or? Yeah. 00:34:42,080 --> 00:34:45,360
所以这是一个优势。你看到任何缺点或？是的。
--Right now it has, uh, communication for like locking the data structure and making sure that each task runs at once. 00:34:45,360 --> 00:34:50,400
现在它有，呃，通信，比如锁定数据结构和确保每个任务同时运行。
--Yeah, exactly. So grabbing something from a queue, well, first of all, there's software overhead to go to that queue and, and just to go access it. 00:34:50,400 --> 00:34:58,720
是的，完全正确。所以从队列中抓取一些东西，嗯，首先，有软件开销去那个队列，并且只是去访问它。
--But not only is there some extra computation, but you probably have to have a lock to protect that queue. 00:34:58,720 --> 00:35:04,480
但不仅有一些额外的计算，而且您可能必须有一个锁来保护该队列。
--So if, uh, the processors are all going at the queue at the same time, they're going to have to serialize trying to pull things off of that queue. 00:35:04,480 --> 00:35:12,240
因此，如果，呃，处理器都同时进入队列，他们将不得不序列化以尝试从队列中取出东西。
--So that, so there may be, uh, there's typically more significant runtime overhead with dynamic scheduling, with dynamic assignment. 00:35:12,240 --> 00:35:20,960
因此，可能会有，呃，动态调度和动态分配通常会有更显着的运行时开销。
--And, um, we'll get back to that. 00:35:20,960 --> 00:35:24,640
而且，嗯，我们会回到那个。
--We'll talk a lot more about that on, uh, Friday. 00:35:24,640 --> 00:35:28,440
我们会在，呃，星期五更多地讨论这个问题。
--Okay. So now we've gotten through the, the first two steps and next comes this orchestration step. 00:35:29,240 --> 00:35:35,560
好的。所以现在我们已经完成了前两个步骤，接下来是编排步骤。
--And this is where we need to put in, uh, the software primitives that allow the threads to actually communicate with each other, and synchronize with each other if they, whenever they need to do that. 00:35:35,720 --> 00:35:46,200
这就是我们需要放入的地方，呃，允许线程实际相互通信的软件原语，并在需要时相互同步。
--Okay. So here are the things that we need to worry about as a programmer, more generically for this step. 00:35:46,200 --> 00:35:53,920
好的。所以这里是我们作为程序员需要担心的事情，更笼统地说是为了这一步。
--And you're going to see, um, this. 00:35:53,920 --> 00:35:56,360
你会看到，嗯，这个。
--And you're going to see examples of this as we go through our, uh, demo program in a little bit here. 00:35:56,360 --> 00:36:03,200
当我们在这里稍微介绍一下我们的演示程序时，您将看到这方面的示例。
--But, uh, first of all, you typically to, to minimize the overhead of communicating, you want to be, uh, thoughtful about how you structure the code, uh, around the communication. 00:36:03,360 --> 00:36:17,640
但是，呃，首先，你通常会，为了尽量减少通信的开销，你想要，嗯，考虑一下你如何构建代码，嗯，围绕通信。
--For example, in message passing, uh, messages are con- usually contiguous chunks of memory. 00:36:17,640 --> 00:36:24,280
例如，在消息传递中，呃，消息通常是连续的内存块。
--And the overhead of sending each message is non-trivial. 00:36:24,280 --> 00:36:28,120
发送每条消息的开销是不小的。
--So it's in your interest to try to group together a number of, a whole chunk of data to send to another thread. 00:36:28,120 --> 00:36:35,760
因此，尝试将大量数据组合在一起以发送到另一个线程符合您的兴趣。
--Don't just send one byte or one word. 00:36:35,760 --> 00:36:38,000
不要只发送一个字节或一个字。
--You want to send a lot of things if you can. 00:36:38,000 --> 00:36:40,680
如果可以的话，你想寄很多东西。
--And by doing it less frequently, then, uh, that helps to amortize the overhead of sending it. 00:36:40,680 --> 00:36:46,520
通过降低发送频率，呃，这有助于分摊发送它的开销。
--Now, on the other hand, if you go too extreme in that direction, then you may be- end up stalling a lot. 00:36:46,520 --> 00:36:51,640
现在，另一方面，如果你在那个方向上走得太极端，那么你最终可能会停滞不前。
--Uh, so you have to be careful about that. 00:36:51,640 --> 00:36:53,720
呃，所以你必须小心。
--Okay. Now, another thing to think about is synchronization. 00:36:53,720 --> 00:36:57,600
好的。现在，要考虑的另一件事是同步。
--So if you're about to compute something but you're, uh, you depend on inputs from some other thread, you need to make sure you don't start too early. 00:36:57,600 --> 00:37:05,360
所以如果你要计算一些东西，但是你，呃，你依赖于来自其他线程的输入，你需要确保你不会开始得太早。
--So that's another thing that you'll see. 00:37:05,360 --> 00:37:08,000
所以这是你会看到的另一件事。
--Um, and, uh, you know, you- you want to think about, uh, how you organize your data structures to, to help this. 00:37:08,000 --> 00:37:15,880
嗯，嗯，你知道，你想想想，嗯，你如何组织你的数据结构来帮助这个。
--So if we do this well, um, this is a situation where we're trying to avoid some bad things. 00:37:15,880 --> 00:37:22,640
所以如果我们做得好，嗯，这是我们试图避免一些坏事的情况。
--So in particular, communicating and synchronizing can be potentially very expensive. 00:37:22,640 --> 00:37:29,480
因此，特别是通信和同步可能非常昂贵。
--So we want to do it in a way where we don't waste a lot of time doing that. 00:37:29,520 --> 00:37:33,600
所以我们希望以一种不会浪费很多时间的方式来做这件事。
--If you do it in a- in a good way, then potentially when you get to the point of saying, okay, I need to receive a message from another thread, it's already there. 00:37:33,600 --> 00:37:43,200
如果您以一种好的方式进行，那么当您说到要说的时候，可能会说，好吧，我需要从另一个线程接收消息，它已经存在了。
--So you don't have to actually stall and wait for it. 00:37:43,200 --> 00:37:45,680
所以你不必真的停下来等待它。
--And if you want to grab a lock, the lock is available, maybe you even have it in your cache already. 00:37:45,680 --> 00:37:50,800
如果你想获取一个锁，这个锁是可用的，也许你甚至已经在你的缓存中了。
--So that might be very fast. 00:37:50,800 --> 00:37:53,120
所以这可能非常快。
--Um, we want to worry about locality and minimize overheads. 00:37:53,120 --> 00:37:58,280
嗯，我们想担心局部性并尽量减少开销。
--So basically, uh, we want the code to behave correctly and waste as little time as possible on all of this synchronization and communication. 00:37:58,320 --> 00:38:08,240
所以基本上，呃，我们希望代码能够正确运行，并在所有这些同步和通信上浪费尽可能少的时间。
--So last step here is, um, mapping the- these virtual thread- the threads, uh, onto the actual hardware. 00:38:08,320 --> 00:38:18,320
所以这里的最后一步是，嗯，将这些虚拟线程映射到实际硬件上。
--And, uh, we're not really going to talk much about that in this class. 00:38:18,320 --> 00:38:23,280
而且，呃，我们真的不会在这节课上谈论太多。
--Um, it's not- on the list of things that programmers worry about, this is the lowest, uh, thing on the list typically. 00:38:23,280 --> 00:38:30,600
嗯，这不在程序员担心的事情清单上，这通常是清单上最低的，嗯，事情。
--So, uh, the way it often happens. 00:38:30,600 --> 00:38:33,480
所以，呃，它经常发生的方式。
--So in- in many cases, if you think about just creating, uh, regular software threads like P threads, then it's really the operating system that's thinking about how to map them onto processors. 00:38:33,480 --> 00:38:44,800
所以在很多情况下，如果你只想创建，呃，像 P 线程这样的常规软件线程，那么实际上是操作系统在考虑如何将它们映射到处理器上。
--And in many cases, it may not matter very much. 00:38:44,800 --> 00:38:48,200
在许多情况下，这可能并不重要。
--If you have a large-scale system with a- with a particular type of interconnect, then it may be more important to- to control that. 00:38:48,200 --> 00:38:55,640
如果您的大型系统具有 - 具有特定类型的互连，那么控制它可能更重要。
--It can be done by the compiler, and that's what ISPC does because basically these, uh, virtual computation, uh, units, these are actually vector slots. 00:38:55,680 --> 00:39:07,160
它可以由编译器完成，这就是 ISPC 所做的，因为基本上这些，呃，虚拟计算，呃，单位，这些实际上是向量槽。
--So the compiler decides where they go in the vectors. 00:39:07,160 --> 00:39:10,960
所以编译器决定它们在向量中的位置。
--And, uh, in GPUs, this- this mapping is actually done by the hardware. 00:39:10,960 --> 00:39:16,240
而且，呃，在 GPU 中，这个 - 这个映射实际上是由硬件完成的。
--So as an aside, you know, one thing that might be interesting here is to what extent do you, you know, what- when you have to time multiplex threads onto the same hardware, um, okay. 00:39:16,240 --> 00:39:28,680
因此，顺便说一句，你知道，这里可能有趣的一件事是你在多大程度上，你知道，当你必须将多路复用线程计时到同一硬件上时，嗯，好吧。
--Well, first of all, that's not necessarily something you always want to do, um, in general, but we heard, uh, last week or last Friday, we talked about how one way to tolerate latency of loading things is to have more concurrency than hardware resources so that you can actually swap between, uh, sets of threads, uh, so that you can hide the latency of a read miss, for example. 00:39:28,680 --> 00:39:51,280
好吧，首先，这不一定是你总是想做的事情，嗯，一般来说，但我们听说，呃，上周或上周五，我们讨论了如何容忍加载延迟的一种方法是提高并发性而不是硬件资源，这样你就可以在，呃，线程组之间交换，呃，这样你就可以隐藏读取未命中的延迟，例如。
--But- but given that once you start time multiplexing, the question is should you put, uh, like related or unrelated threads together on the same piece of hardware? And it turns out that there are arguments for both things. 00:39:51,280 --> 00:40:03,440
但是-但是考虑到一旦你开始时间多路复用，问题是你应该把，呃，相关或不相关的线程放在同一块硬件上吗？事实证明，这两件事都有争论。
--If you put things that are closely related together, maybe that's good for communication locality. 00:40:03,440 --> 00:40:08,200
如果你把密切相关的东西放在一起，也许这对交流局部性有好处。
--But on the flip side, maybe they have exactly the same kind of performance bottleneck. 00:40:08,200 --> 00:40:13,320
但另一方面，也许他们有完全相同的性能瓶颈。
--Maybe, for example, they're both bandwidth limited. 00:40:13,320 --> 00:40:16,240
例如，也许它们都是带宽受限的。
--So putting them on the same processor may make that bandwidth problem even worse as opposed to putting together things that are more diverse in terms of their bottlenecks. 00:40:16,240 --> 00:40:26,880
因此，将它们放在同一个处理器上可能会使带宽问题变得更糟，而不是将瓶颈方面更加多样化的东西放在一起。
--Okay. And then a last thing before we start to get into our example is, um, my- the blob that I've, you know, I've shown you this picture of computation that we're dividing up. 00:40:26,880 --> 00:40:39,480
好的。然后在我们开始进入我们的示例之前的最后一件事是，嗯，我的 - 我的斑点，你知道，我已经向你展示了我们正在划分的计算图。
--And technically, I was talking about computation, but it's going to be very natural for you to also think about it as dividing up data. 00:40:39,480 --> 00:40:48,040
从技术上讲，我在谈论计算，但您也很自然地将其视为划分数据。
--So in programs where you're performing essentially the same computation or, or very similar computations on a whole lot of data, then you can think of it as just carving up the data structure and then doing whatever you need to do to each part of the- those chunks of those data structures. 00:40:48,040 --> 00:41:06,240
因此，在您对大量数据执行基本相同的计算或非常相似的计算的程序中，您可以将其视为只是分割数据结构，然后对每个部分执行您需要执行的任何操作the-那些数据结构的块。
--Okay. So what we're going to do, uh, right now is take our, uh, two-minute intermission break, uh, and then after that, we will go through an example of a parallel program. 00:41:06,240 --> 00:41:17,560
好的。所以我们现在要做的是，呃，两分钟的中场休息，呃，然后，我们将通过一个并行程序的例子。
--So bad news, there's no quiz today, uh, but, uh, stay tuned for that. 00:41:17,560 --> 00:41:32,600
好坏消息，今天没有测验，呃，但是，呃，敬请期待。
--Yeah. The worst news is there will be one on Friday. 00:41:32,600 --> 00:41:37,120
是的。最坏的消息是周五会有一个。
--Okay. 00:42:17,560 --> 00:42:42,440
好的。
--So what we're going to do now is, uh, go through our first example of a, of a parallel program. 00:42:42,440 --> 00:42:49,680
所以我们现在要做的是，呃，通过我们的第一个并行程序示例。
--And we need something that's simple enough that the code will fit on the slide, and hopefully you'll even be able to read it, uh, from where you're sitting. 00:42:49,680 --> 00:42:57,680
我们需要一些足够简单的东西，代码可以放在幻灯片上，希望你甚至可以从你坐的地方阅读它。
--And what we're going to look at is a, a simplified version of the ocean simulation. 00:42:57,680 --> 00:43:03,600
我们要看的是一个简化版的海洋模拟。
--And, and remember the ocean simulation has, uh, these 2D arrays and we're updating each element based on some fancy partial differential equations. 00:43:03,600 --> 00:43:13,680
而且，记住海洋模拟有，呃，这些二维数组，我们正在根据一些奇特的偏微分方程更新每个元素。
--So we're going to, since we don't really, the math part, uh, isn't something that's super important for our discussion here. 00:43:13,720 --> 00:43:20,720
所以我们要，因为我们不是真的，数学部分，呃，不是我们在这里讨论的超级重要的东西。
--So we're going to, uh, grossly oversimplify the computation as just averaging together elements. 00:43:20,720 --> 00:43:27,080
所以我们将，呃，将计算过分简化为只是对元素进行平均。
--Now, it turns out that in terms of, uh, communication and dependencies and all those things, that's perfectly fine. 00:43:27,080 --> 00:43:33,720
现在，事实证明，就呃，沟通和依赖关系以及所有这些方面而言，这完全没问题。
--We have the same communication patterns if we, even if we just simplify that. 00:43:33,720 --> 00:43:38,200
即使我们只是简化它，我们也有相同的通信模式。
--So, so the idea is we, uh, to update a particular element here A, we are going to average together, um, it and its, its, uh, neighbors. 00:43:38,200 --> 00:43:50,120
所以，我们的想法是，呃，在这里更新一个特定的元素 A，我们将一起平均，嗯，它和它的，呃，它的邻居。
--So we take, you know, itself and its four neighbors and we're going to average that together, and that's the new value. 00:43:50,120 --> 00:43:57,640
所以我们取它本身和它的四个邻居，我们将把它们平均在一起，这就是新的价值。
--So that's, that's close enough for our purposes. 00:43:57,640 --> 00:44:01,560
就是这样，这对我们的目的来说已经足够接近了。
--Okay. And we have a n by n grid, um, but we're going to add, uh, some extra row on the top and the bottom. 00:44:01,560 --> 00:44:09,760
好的。我们有一个 n 格，嗯，但是我们要添加，嗯，在顶部和底部添加一些额外的行。
--So we actually have like an n plus 2 by an n plus 2 grid. 00:44:09,760 --> 00:44:13,320
所以我们实际上有一个 n 加 2 乘一个 n 加 2 的网格。
--And this is what the, uh, sequential code looks like. 00:44:13,320 --> 00:44:18,000
这就是，呃，顺序代码的样子。
--So I'm going to just talk through these steps here because we're going to be, uh, modifying this code, uh, three different ways for the different programming models. 00:44:18,000 --> 00:44:27,720
所以我将在这里讨论这些步骤，因为我们将，呃，修改这段代码，呃，针对不同编程模型的三种不同方式。
--Okay. So what's going on here? Well, we have our, uh, 2D array and we're just going to look at one array. 00:44:27,720 --> 00:44:34,920
好的。那么这是怎么回事？好吧，我们有我们的，呃，2D 阵列，我们将只看一个阵列。
--Uh, actually, you would do this for all the different layers, but to simplify it, we're just going to look at one 2D array. 00:44:34,920 --> 00:44:41,240
呃，实际上，你会对所有不同的层都这样做，但为了简化它，我们只看一个二维数组。
--And somehow that gets initialized and we're not worried about that part right now. 00:44:41,240 --> 00:44:45,600
不知何故，它被初始化了，我们现在不担心那部分。
--But in the solver, um, one of the things that it does is it iterates until it, it thinks that the computation has converged, uh, close enough. 00:44:45,600 --> 00:44:54,800
但是在求解器中，嗯，它所做的其中一件事就是迭代直到它认为计算已经收敛，呃，足够接近。
--So to do that, there is a test, um, that it computes. 00:44:54,800 --> 00:45:00,600
所以要做到这一点，有一个测试，嗯，它会计算。
--So if it thinks that you're finished, so you iterate until you're done. 00:45:00,600 --> 00:45:04,600
因此，如果它认为您已完成，那么您将进行迭代直到完成。
--And the test for whether you're done is that there, it- as it's updating each element, it compares the new value with the previous value. 00:45:04,600 --> 00:45:14,240
测试是否完成的方法是，当它更新每个元素时，它会将新值与先前值进行比较。
--And then it adds up all the absolute value of all those differences. 00:45:14,240 --> 00:45:18,320
然后它将所有这些差异的所有绝对值加起来。
--And then it takes that and, uh, compares that to some threshold. 00:45:18,320 --> 00:45:23,720
然后它需要那个，呃，将它与某个阈值进行比较。
--So once that difference sort of drops below a threshold, then we stop iterating. 00:45:23,720 --> 00:45:28,360
因此，一旦这种差异下降到阈值以下，我们就会停止迭代。
--So that's the outer loop around all of this stuff. 00:45:28,360 --> 00:45:31,080
这就是所有这些东西的外循环。
--And in the inner loop, it's fairly simple. 00:45:31,080 --> 00:45:33,200
在内部循环中，它相当简单。
--Okay. So, so because of that, we have this, uh, diff value. 00:45:33,200 --> 00:45:37,600
好的。所以，正因为如此，我们有这个，呃，差异值。
--That's the, uh, sum of the absolute value of the differences over all the elements as we're updating them. 00:45:37,600 --> 00:45:43,320
这是，呃，我们正在更新所有元素的差异的绝对值之和。
--And then you have, uh, in the middle, we have a 2D loop. 00:45:43,320 --> 00:45:47,880
然后你有，呃，在中间，我们有一个二维循环。
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
--Okay. So, um, what do you- how, how can we run this in parallel? So any thoughts on that? Well, one of the things I mentioned is dependencies. 00:46:07,800 --> 00:46:23,200
好的。那么，嗯，你怎么办，我们怎样才能并行运行它？那么对此有什么想法吗？好吧，我提到的其中一件事是依赖性。
--So, so first we want to think about what are, what is our source of parallelisms? If we think about updating each of those different elements, how do they depend on each other? Well, we're averaging an element with its neighbors, its left, right, up, and down neighbors. 00:46:23,200 --> 00:46:39,600
所以，首先我们要考虑什么是并行性，我们的并行性来源是什么？如果我们考虑更新每个不同的元素，它们如何相互依赖？好吧，我们正在平均一个元素及其邻居，它的左、右、上和下邻居。
--So as we go through those two loops, um, we calculate something here in the middle based on, you know, these four things. 00:46:39,600 --> 00:46:49,120
因此，当我们经历这两个循环时，嗯，我们根据这四件事在中间计算出一些东西。
--So that, that means that the particular iteration of, you know, j depends on the thing we produce in the previous iteration of j. 00:46:49,120 --> 00:46:57,840
因此，这意味着 j 的特定迭代取决于我们在 j 的前一次迭代中产生的东西。
--And also, you know, depends on the element that we produced in the previous iteration of the outer loop also. 00:46:57,840 --> 00:47:06,280
而且，你知道，这也取决于我们在外循环的前一次迭代中生成的元素。
--So these little red arrows are data dependencies. 00:47:06,280 --> 00:47:10,440
所以这些红色的小箭头是数据依赖。
--And you notice a lot of them there. 00:47:10,440 --> 00:47:12,640
你注意到那里有很多。
--So if we just say, hey, let's just run those loops in parallel, you know, what might happen? If we just ignore the dependencies, what would, what would occur? Raising conditions? Yeah, there'd be data races. 00:47:12,640 --> 00:47:29,080
所以如果我们只是说，嘿，让我们并行运行这些循环，你知道，会发生什么？如果我们只是忽略依赖关系，会发生什么？提高条件？是的，会有数据竞赛。
--So you'd get some answer, um, and then you'd run it again and you'd get a different answer. 00:47:29,080 --> 00:47:34,040
所以你会得到一些答案，嗯，然后你再次运行它，你会得到一个不同的答案。
--It would be non-deterministic and, uh, basically things would be updating and not worrying about data dependencies. 00:47:34,040 --> 00:47:40,600
这将是不确定的，呃，基本上事情会更新而不用担心数据依赖性。
--So maybe that's not so good. 00:47:40,600 --> 00:47:42,960
所以也许这不是很好。
--So is this hopeless? What do you, do you see any, any path forward here? What's, what's a way that we can, something we could do? Yeah. 00:47:42,960 --> 00:47:51,560
那么这是无望的吗？你怎么看，你看到这里有什么前进的道路吗？什么是我们可以做的事情？是的。
--So, uh, instead of, uh, sort of, uh, having data races, you can isolate, uh, the, the, uh, so you can first divide the grid into multiple parts, and you can isolate those parts, and only communicate after, say, like 20 rounds. 00:47:51,560 --> 00:48:06,320
所以，呃，而不是，呃，有点，呃，有数据竞争，你可以隔离，呃，那个，那个，呃，所以你可以先把网格分成多个部分，然后你可以隔离这些部分，并且只交流后，比如说，20 轮。
--Okay. We could do that. 00:48:06,320 --> 00:48:08,120
好的。我们可以做到。
--We could, uh, we could, uh, like basic, that's one possibility. 00:48:08,120 --> 00:48:13,280
我们可以，呃，我们可以，呃，像基本的那样，这是一种可能性。
--Um, any, any other thoughts? So we, we could, the programmer could decide that that was okay, that they were willing to do that. Any other thoughts? Yep. Uh, there's independence along the diagonals, so you can go along the diagonals. 00:48:13,280 --> 00:48:26,240
嗯，还有其他想法吗？所以我们，我们可以，程序员可以决定那没问题，他们愿意这样做。还有其他想法吗？是的。呃，沿着对角线是独立的，所以你可以沿着对角线走。
--Yep. Exactly. So it turns out that along the diagonals, there are, there is independence, as you just mentioned. 00:48:26,240 --> 00:48:32,600
是的。确切地。所以事实证明，沿着对角线，有，有独立性，正如你刚才提到的。
--So once you do, uh, once you calculate this node here, you can actually go ahead and calculate these nodes. 00:48:32,600 --> 00:48:39,360
所以一旦你这样做了，呃，一旦你在这里计算了这个节点，你实际上可以继续计算这些节点。
--Um, so we could, we could rewrite the loop structure, and then go along these diagonals, and that would not have data races. 00:48:39,360 --> 00:48:48,280
嗯，所以我们可以，我们可以重写循环结构，然后沿着这些对角线走，这样就不会出现数据竞争。
--What do you think about that performance-wise? How, any drawbacks to that? Yep. Um, not all the diagonals are that long. 00:48:48,280 --> 00:48:59,440
您如何看待这种表现？怎么样，有什么缺点吗？是的。嗯，并不是所有的对角线都那么长。
--So, like, especially the end diagonals, a lot of the working threads would just be sitting there for a little bit. 00:48:59,440 --> 00:49:07,280
所以，尤其是末端对角线，很多工作线程会在那里停留一小会儿。
--Yeah. So some of those diagonals are really short, so we wouldn't have enough work to keep a lot of processors busy necessarily. 00:49:07,280 --> 00:49:12,640
是的。所以其中一些对角线真的很短，所以我们没有足够的工作来让很多处理器保持忙碌。
--Yeah. Or it's cache performance. 00:49:12,640 --> 00:49:14,640
是的。或者是缓存性能。
--Right? So we're going to be accessing data in some weird diagonal access pattern, so that's probably not great for spatial locality. 00:49:14,640 --> 00:49:22,000
正确的？所以我们将以一些奇怪的对角线访问模式访问数据，所以这可能不适合空间局部性。
--And another thing is that there'd be a little, there'd be more software overhead to calculate the indices if we're going along diagonals probably. 00:49:22,000 --> 00:49:30,200
另一件事是，如果我们可能沿着对角线前进，计算指数的软件开销会更多一些。
--So this is, um, so we're not going to do this. 00:49:30,200 --> 00:49:34,120
所以这是，嗯，所以我们不打算这样做。
--Um, any other thoughts? So, okay. So we are going to, in a similar spirit to the suggestion that we just like relax the order a bit, we are going to relax things. 00:49:34,120 --> 00:49:46,120
嗯，还有其他想法吗？所以，好吧。因此，我们将本着与我们只是想放宽命令的建议类似的精神，我们将放宽一些事情。
--Um, but here's what, what we're going to do. 00:49:46,120 --> 00:49:48,480
嗯，但这就是我们要做的。
--Oh, was there another comment? So like, could you just use the old array entirely and like make a new array that's useful? Okay. That's a good, uh, good, good suggestion. 00:49:48,480 --> 00:49:58,200
哦，还有其他评论吗？那么，你能不能完全使用旧数组，然后创建一个有用的新数组？好的。这是一个很好，呃，很好，很好的建议。
--So one thing that you may worry about with, uh, data races where the problem is we're in the middle of updating something and we're reading that thing that we're updating, and that's causing the data races. 00:49:58,200 --> 00:50:08,520
所以你可能会担心一件事，呃，数据竞争，问题是我们正在更新一些东西，我们正在阅读我们正在更新的东西，这导致了数据竞争。
--So one possibility would be create two copies of the matrix, have, and then you would basically flip back and forth one, in one iteration. 00:50:08,520 --> 00:50:17,400
因此，一种可能性是创建矩阵的两个副本，然后你基本上可以在一次迭代中来回翻转一个。
--One of them would be the input and you'd be writing in the other one, and then the next time you would go the other direction. 00:50:17,400 --> 00:50:22,640
其中一个将是输入，您将在另一个中编写，然后下一次您将转向另一个方向。
--So if you did that, then you would only be reading from something that wasn't changing. 00:50:22,640 --> 00:50:27,160
所以如果你这样做，那么你只会从没有改变的东西中读取。
--And so that, that would work. 00:50:27,160 --> 00:50:29,240
这样，那将起作用。
--Um, the reason we won't do that is it turns out, um, that scientific programmers perhaps irrationally are unwilling to duplicate data like this. 00:50:29,240 --> 00:50:39,200
嗯，我们不这样做的原因是事实证明，嗯，科学程序员可能非理性地不愿意像这样复制数据。
--Because what they want to do is fill all of the memory in the machine, uh, with data and they're not even willing to cut that in half usually. 00:50:39,200 --> 00:50:47,440
因为他们想要做的是用数据填充机器中的所有内存，而且他们通常甚至不愿意将其减半。
--So, uh, most scientific programmers would just say that's a non-starter. 00:50:47,440 --> 00:50:51,800
所以，呃，大多数科学程序员只会说这是不可能的。
--Um, you can argue about whether that makes sense or not, but that's, that's the way they think. 00:50:51,800 --> 00:50:55,680
嗯，你可以争论这是否有意义，但那是他们的想法。
--Okay. So it turns out that there's something that's almost like that, um, that is, uh, slightly different. 00:50:55,680 --> 00:51:04,720
好的。所以事实证明，有一些东西几乎是这样的，嗯，就是，呃，略有不同。
--So if I showed you a, a chessboard, um, maybe that would give you an idea about what we could do. 00:51:04,720 --> 00:51:12,360
因此，如果我向您展示一个棋盘，嗯，也许这会让您了解我们可以做什么。
--So there's something called red-black ordering. 00:51:12,560 --> 00:51:15,000
所以有一种叫做红黑排序的东西。
--And the idea here is instead of updating all of the elements at one time in one phase, we update all of the red elements in a chessboard, and then we go back and we update all the black elements. 00:51:15,000 --> 00:51:29,200
这里的想法不是在一个阶段一次更新所有元素，而是更新棋盘中的所有红色元素，然后我们返回并更新所有黑色元素。
--And this effectively gets us something similar to what we would get when we, if we had two copies of the entire, uh, array, which is now when I'm updating, um, something that's red, I only have to read itself, which isn't a problem, and other elements that are black. 00:51:29,200 --> 00:51:47,080
这有效地让我们得到了一些类似于当我们有整个，呃，数组的两个副本时我们会得到的东西，现在我正在更新，嗯，一些红色的东西，我只需要读取它自己，这不是问题，其他元素是黑色的。
--And the black elements are not being updated right now. 00:51:47,080 --> 00:51:49,720
黑色元素现在没有更新。
--So they should all, uh, stay the same throughout this phase. 00:51:49,720 --> 00:51:53,400
所以他们应该，呃，在这个阶段保持不变。
--And then you flip and then you do the other color reading other elements. 00:51:53,400 --> 00:51:57,640
然后你翻转然后你做其他颜色阅读其他元素。
--Now, this technically, this changes the output compared to the sequential program. 00:51:57,640 --> 00:52:02,680
现在，从技术上讲，与顺序程序相比，这改变了输出。
--You're not getting exactly the same answer you would have gotten if you just went through sequentially. 00:52:02,680 --> 00:52:07,320
如果您只是按顺序进行，您不会得到完全相同的答案。
--But, um, it turns out usually for these kinds of simulations, um, this is probably close enough. 00:52:07,320 --> 00:52:13,400
但是，嗯，通常对于这些类型的模拟，嗯，这可能已经足够接近了。
--And also it does have the advantage that it is deterministic. 00:52:13,400 --> 00:52:16,600
而且它确实具有确定性的优点。
--So we got rid of the data races, um, and we didn't have to double, uh, the number of elements, but we didn't have to duplicate the whole thing. 00:52:16,600 --> 00:52:24,440
所以我们摆脱了数据竞争，嗯，我们不必加倍，嗯，元素的数量，但我们不必复制整个东西。
--So this is what we'll do. 00:52:24,440 --> 00:52:26,680
所以这就是我们要做的。
--Okay. So now, okay. 00:52:26,680 --> 00:52:30,040
好的。所以现在，好吧。
--So what should be the gra- oh, question? So in that case, when we- once we- once we update the red first, then when we go to update the black, aren't the blacks surrounded by updated reds? Yeah. So they will need- they will get the updated reds. 00:52:30,040 --> 00:52:45,720
那么问题应该是什么？所以在那种情况下，当我们-一旦我们-一旦我们先更新红色，然后当我们去更新黑色时，黑色不是被更新的红色包围了吗？是的。所以他们将需要——他们将获得更新的红色。
--Um, but, um, as long as we make sure that all those updates to the reds have been properly pushed out and everybody can see them, then there shouldn't be any data races. 00:52:45,720 --> 00:52:55,120
嗯，但是，嗯，只要我们确保所有这些红色更新都已正确推出并且每个人都能看到它们，就不应该有任何数据竞争。
--So we have to entirely separate those two phases. 00:52:55,120 --> 00:52:58,840
所以我们必须将这两个阶段完全分开。
--Uh, before- you don't want to, like, when you're finishing the updates to the reds, you don't want any processors to be running ahead and starting to do updates to the blacks while other ones haven't finished doing updates to the reds. 00:52:58,840 --> 00:53:10,440
呃，之前 - 你不想，比如，当你完成对红色的更新时，你不希望任何处理器提前运行并开始对黑色进行更新，而其他处理器还没有完成对红色进行更新。
--So there's a synchronization point in the middle called a barrier, where we force all the threads to catch up before we move on to the next phase. 00:53:10,440 --> 00:53:18,040
所以中间有一个称为屏障的同步点，我们在进入下一阶段之前强制所有线程赶上进度。
--So if we do that, then, uh, it will be deterministic. 00:53:18,040 --> 00:53:21,520
所以如果我们这样做，那么，呃，它将是确定性的。
--If we didn't, then we'd have a problem. 00:53:21,520 --> 00:53:23,680
如果我们不这样做，那我们就有麻烦了。
--So in- in the parentheses there, it says- it says respect dependency on red cells, but it doesn't respect the dependency on red cells, right? Uh, let's see. 00:53:23,680 --> 00:53:37,080
所以在——括号里，它说——它说尊重对红细胞的依赖，但它不尊重对红细胞的依赖，对吧？嗯，让我们看看。
--Well, in other words, it's using the red cells from this time step as opposed to the previous time step, right? So it's not- it's actually- it's realizing it doesn't need to respect that dependency. 00:53:37,080 --> 00:53:45,360
好吧，换句话说，它使用的是这个时间步的红细胞，而不是之前的时间步，对吧？所以它不是——实际上是——它意识到它不需要尊重这种依赖性。
--Yes, that's right. Yeah, that's correct. 00:53:45,360 --> 00:53:47,640
恩，那就对了。是的，这是正确的。
--Um, yeah, there is some communication that used to occur. 00:53:47,640 --> 00:53:51,200
嗯，是的，曾经有过一些交流。
--When we look in the- we'll go look at the different programming models and, uh, hopefully make that clear. 00:53:51,200 --> 00:53:56,160
当我们查看时 - 我们将查看不同的编程模型，呃，希望能弄清楚这一点。
--I- I mean, that's not a very clear sentence though on this. 00:53:56,160 --> 00:53:58,600
我-我的意思是，这不是一个非常明确的句子。
--Uh, so stay tuned, uh, and then hopefully it'll be more clear what that means. 00:53:58,600 --> 00:54:02,440
呃，敬请期待，呃，然后希望它会更清楚这意味着什么。
--Okay. So- so what should the tasks be? We have, um, it could be individual grid elements, but we have a gigantic number of them. 00:54:02,440 --> 00:54:13,040
好的。那么-那么任务应该是什么？我们有，嗯，它可能是单独的网格元素，但我们有大量的网格元素。
--We have n squared grid elements, and I'll just go ahead and tell you that n is going- n itself is typically going to be much larger than p. 00:54:13,040 --> 00:54:20,920
我们有 n 个平方网格元素，我会继续告诉你 n 会变大——n 本身通常会比 p 大得多。
--So we don't need to make individual grid elements the tasks. 00:54:20,920 --> 00:54:25,840
所以我们不需要将单个网格元素作为任务。
--Instead, how- let's make, uh, rows of the matrix tasks because that's still more than enough tasks for our purposes. 00:54:25,840 --> 00:54:35,600
相反，让我们制作，呃，矩阵任务的行，因为对于我们的目的来说，这些任务仍然绰绰有余。
--So one question is, okay, so rows will be our tasks, and then the next thing is to bundle them together so that we have, uh, the right number of bundles for p processors. 00:54:35,600 --> 00:54:48,280
所以一个问题是，好吧，所以行将是我们的任务，然后下一件事就是将它们捆绑在一起，这样我们就有了，呃，p 个处理器的正确数量的捆绑包。
--So here- here are two options. 00:54:48,280 --> 00:54:50,680
所以在这里-这里有两个选择。
--We could do them, uh, like I've shown here, where we- if we had- if we were targeting four processors, we could, uh, do contiguous sets of rows as the, um, the- the bundles, or we could do this. 00:54:50,680 --> 00:55:06,800
我们可以这样做，呃，就像我在这里展示的那样，我们 - 如果我们有 - 如果我们的目标是四个处理器，我们可以，呃，做连续的行集作为，嗯， - 捆绑，或者我们可以做到这一点。
--We could interleave them. 00:55:06,800 --> 00:55:07,920
我们可以将它们交织在一起。
--So we could just go, you know, 0, 1, 2, 3, 4, 0, 1, 2, 3, 0, 1, 2, 3. 00:55:07,920 --> 00:55:12,280
所以我们可以去，你知道，0, 1, 2, 3, 4, 0, 1, 2, 3, 0, 1, 2, 3。
--This is actually 1, 2, 3, 4. 00:55:12,280 --> 00:55:14,280
这实际上是 1、2、3、4。
--So this is another option. 00:55:14,280 --> 00:55:17,040
所以这是另一种选择。
--Okay. So which of these is better or does it matter? Well, actually, whoops, the answer's on there. 00:55:17,040 --> 00:55:25,160
好的。那么这些哪个更好或者重要吗？好吧，实际上，哎呀，答案就在那里。
--Okay. Well, it depends. 00:55:25,160 --> 00:55:26,960
好的。这得看情况。
--We'll actually spend a while, uh, okay. 00:55:26,960 --> 00:55:29,880
我们实际上会花一段时间，呃，好吧。
--Well, how can we think about this? So let's say for- for starters, let's imagine that we're targeting not a GPU or SIMD vector instructions, but we're just targeting, uh, threads on cores. 00:55:29,880 --> 00:55:41,880
好吧，我们该如何考虑呢？所以让我们说 - 对于初学者来说，让我们假设我们的目标不是 GPU 或 SIMD 矢量指令，但我们只是针对，呃，内核上的线程。
--That's the machine that we're targeting. 00:55:41,880 --> 00:55:43,960
这就是我们的目标机器。
--And another thing that I should mention, which, uh, someone asked about before, is we have to make sure that before you move on to the next phase of- of updating the black elements and vice versa, that you make sure that all the threads have finished updating the previous color. 00:55:43,960 --> 00:56:03,720
另一件我应该提到的事情，呃，之前有人问过，我们必须确保在你进入下一阶段更新黑色元素之前，反之亦然，你确保所有的线程已完成更新以前的颜色。
--So there's a synchronization step here where you- you do- you're working on the red cells and you have to make sure that- that everybody has caught up. 00:56:03,720 --> 00:56:13,440
所以这里有一个同步步骤，你 - 你 - 你正在处理红细胞，你必须确保 - 每个人都赶上了。
--And once they've all caught up, then, uh, you will need to read values that were produced pro- possibly by other processors in the previous step. 00:56:13,440 --> 00:56:23,320
一旦他们都赶上了，那么，呃，您将需要读取可能由其他处理器在上一步中生成的值。
--So that's going to involve communication. 00:56:23,320 --> 00:56:26,320
所以这将涉及沟通。
--So with that in mind, um, if our goal is to minimize communication, then, uh, there is a difference between these two approaches. 00:56:26,320 --> 00:56:36,320
所以考虑到这一点，嗯，如果我们的目标是尽量减少沟通，那么，嗯，这两种方法之间是有区别的。
--So if you- when- when do you need to communicate? Well, I- if I'm- if I'm updating some internal node in the middle of my, uh, block here, I only need, uh, these other nodes. 00:56:36,320 --> 00:56:51,600
所以如果你——什么时候——什么时候需要沟通？好吧，我-如果我-如果我在我的，呃，块这里更新一些内部节点，我只需要，呃，这些其他节点。
--And if these are all ones that are assigned to me and they were in my cache or my local memory, then I can read the values I generated the last time without communicating with any other processor. 00:56:51,600 --> 00:57:03,120
如果这些都是分配给我的，并且它们在我的缓存或本地内存中，那么我可以读取上次生成的值，而无需与任何其他处理器通信。
--However, when I'm updating this element here, uh, along a boundary. 00:57:03,120 --> 00:57:09,360
但是，当我在这里更新这个元素时，嗯，沿着边界。
--So for that one, I'm going to need all of these elements and this one here was produced by another processor. 00:57:09,360 --> 00:57:17,400
所以对于那个，我将需要所有这些元素，而这里的这个是由另一个处理器生成的。
--So there has to be communication between processors, uh, along the boundaries between these sets of rows that we give to the processors. 00:57:17,440 --> 00:57:25,840
所以处理器之间必须有通信，呃，沿着我们给处理器的这些行集之间的边界。
--So, um, so I've highlighted in gray. 00:57:25,840 --> 00:57:29,200
所以，嗯，所以我用灰色突出显示。
--If you do it block-wise, then you only communicate by- along these block boundaries. 00:57:29,200 --> 00:57:34,840
如果你按块进行，那么你只能沿着这些块边界进行通信。
--If you do it interleaved, there's actually going to be many more boundaries. 00:57:34,840 --> 00:57:39,560
如果你交错地做，实际上会有更多的边界。
--Essentially, every row is now on a boundary. 00:57:39,560 --> 00:57:42,080
本质上，每一行现在都在边界上。
--So there'll be more communication because of that. 00:57:42,080 --> 00:57:44,880
因此会有更多的交流。
--So- so on a- on a- on an idealized machine, um, the case on the left would probably be much better just because of communication. 00:57:44,880 --> 00:57:54,600
所以-所以在-在-在理想化的机器上，嗯，左边的情况可能会因为沟通而好得多。
--Now, there are a lot of other things that go on in the memory system. 00:57:54,600 --> 00:57:57,360
现在，记忆系统中还有很多其他事情在进行。
--So, uh, we'll come back and revisit this next week and talk about, uh, why there are other reasons why that may or may not be the best approach. 00:57:57,360 --> 00:58:05,240
所以，呃，我们将在下周回来重新讨论这个问题，并讨论，呃，为什么还有其他原因可以说明这可能是也可能不是最好的方法。
--But for- for now, we're going to go forward with this assignment on the left. 00:58:05,240 --> 00:58:11,040
但就目前而言，我们将继续进行左侧的这项任务。
--That's how we're going to divide up the work. 00:58:11,040 --> 00:58:12,960
这就是我们要分工的方式。
--Okay. So it's time to now look at, uh, uh, these three different versions of the code, and we're going to start with data parallel. 00:58:12,960 --> 00:58:21,760
好的。所以现在是时候看看，呃，呃，这三个不同版本的代码，我们将从数据并行开始。
--So, okay, here's the code for the data parallel version of this co- of this program. 00:58:21,760 --> 00:58:30,240
所以，好吧，这是这个程序的数据并行版本的代码。
--And the thing that, uh, will strike you, uh, potenti- potentially, and it'll especially be clear as we look at the other two versions, is that not that much has changed in some- in some sense. 00:58:30,240 --> 00:58:42,320
嗯，有一点会让您，呃，潜在地，并且当我们查看其他两个版本时会特别清楚，那就是在某种意义上并没有那么多变化。
--So a- a feature of the data parallel programming paradigm is that the language and runtime system do a lot of the heavy lifting for you. 00:58:42,360 --> 00:58:50,480
所以 a- 数据并行编程范例的一个特点是语言和运行时系统为你做了很多繁重的工作。
--As a programmer, mostly what you do is just effectively point at things and say, yeah, do that in parallel there. 00:58:50,480 --> 00:58:58,400
作为一名程序员，您所做的大部分事情只是有效地指向事物并说，是的，在那里并行进行。
--Um, you know, I want to divide this up, um, along, you know, chunks of rows, make it happen system, and then it kind of fills in a lot of the details for you. 00:58:58,400 --> 00:59:09,520
嗯，你知道，我想把它分开，嗯，沿着，你知道的，大块的行，让它发生系统，然后它会为你填充很多细节。
--So what we did here is in the solver, um, we were parallelizing, um, we're only parallelizing along the outer loop. 00:59:09,560 --> 00:59:20,480
所以我们在这里所做的是在求解器中，嗯，我们正在并行化，嗯，我们只是沿着外循环并行化。
--So we don't- we- we parallelize along this loop, not- not along this one because entire rows always get assigned the same process. 00:59:20,480 --> 00:59:29,520
所以我们不-我们-我们沿着这个循环并行化，而不是-不沿着这个循环并行化，因为总是为整行分配相同的进程。
--So we don't need to put a- a- any special primitive around that. 00:59:29,520 --> 00:59:33,760
所以我们不需要在它周围放一个- 一个- 任何特殊的原语。
--But we have a for all command here, which is like the for each that I mentioned for ISTC. 00:59:33,760 --> 00:59:39,120
但是我们这里有一个 for all 命令，就像我为 ISTC 提到的 for each 命令一样。
--This tells the- the language that these iterations can be done in parallel. 00:59:39,120 --> 00:59:44,440
这告诉语言这些迭代可以并行完成。
--And in fact, we would all- it's not shown here, but we would also give it a hint that would say, um, and please group them in contiguous blocks. 00:59:44,440 --> 00:59:53,720
事实上，我们会全部 - 这里没有显示，但我们也会给它一个提示，说，嗯，请将它们分组在连续的块中。
--So now, we could leave that up to the system. 00:59:53,720 --> 00:59:56,280
所以现在，我们可以将其留给系统。
--It could maybe just do it however it wants to, but we could- in these data parallel languages, you can often give it a hint like that. 00:59:56,280 --> 01:00:02,920
它可以随心所欲地做，但我们可以——在这些数据并行语言中，你通常可以给它这样的提示。
--Um, we're not showing that hint here. 01:00:02,920 --> 01:00:05,480
嗯，我们不在这里显示该提示。
--Okay. So what else is different? Well, not much is different. 01:00:05,480 --> 01:00:09,240
好的。那么还有什么不同呢？嗯，没什么不同。
--Another thing that you see here is that at the part where we were adding up, um, the- those, uh, absolute values of the differences between the old and new values, uh, that has to be a special kind of reduction operation because when- remember when I talked about ISPC and how you couldn't put, uh, the- the, um, you had to be careful about how you were doing a reduction in that code. 01:00:09,240 --> 01:00:32,080
你在这里看到的另一件事是，在我们加起来的部分，嗯，那些，呃，旧值和新值之间差异的绝对值，呃，那必须是一种特殊的归约操作，因为什么时候 - 记得当我谈到 ISPC 以及你如何不能把，呃，那个 - 嗯，你必须小心你如何减少那个代码。
--Well, the same thing happens here. 01:00:32,080 --> 01:00:33,800
好吧，同样的事情发生在这里。
--What you wanted to do is compute partial sums locally and then add them up serial later. 01:00:33,800 --> 01:00:39,480
您想要做的是在本地计算部分和，然后稍后将它们相加。
--So this r- reduce add does that. 01:00:39,480 --> 01:00:42,760
所以这个 r-reduce add 就是这样做的。
--It will put in all of the work to do that. 01:00:42,760 --> 01:00:45,960
它将投入所有工作来做到这一点。
--Um, but basically, um, the code changed very little here. 01:00:45,960 --> 01:00:50,360
嗯，但基本上，嗯，这里的代码变化很小。
--Uh, we just pointed to things and said, that's a source of parallelism, do it that way. 01:00:50,360 --> 01:00:54,760
呃，我们只是指着东西说，那是并行性的来源，就那样做。
--Okay. So that- that was quick. 01:00:54,760 --> 01:00:58,080
好的。所以那-那很快。
--Um, now, let's look at the other models. 01:00:58,080 --> 01:01:02,960
嗯，现在，让我们看看其他模型。
--And the point of this exercise is not for me to convince you that data parallel is the best thing ever. 01:01:02,960 --> 01:01:07,080
这个练习的目的不是要让你相信数据并行是有史以来最好的事情。
--Um, sometimes it works really well if you have very regular data structures, but as your code gets more irregular, it may not map very well. 01:01:07,080 --> 01:01:14,760
嗯，如果你有非常规则的数据结构，有时它会工作得很好，但随着你的代码变得越来越不规则，它可能无法很好地映射。
--But let's- now, let's compare this with, uh, how we would do this in the other two models. 01:01:14,760 --> 01:01:19,520
但是，让我们——现在，让我们将其与，呃，我们将如何在其他两个模型中做到这一点进行比较。
--So first, we'll look at the shared address space code. 01:01:19,520 --> 01:01:23,920
因此，首先，我们将查看共享地址空间代码。
--Okay. So I showed this picture before and it's going to become more- okay. 01:01:23,920 --> 01:01:30,920
好的。所以我之前展示过这张照片，它会变得更-好吧。
--Both shared address space and message passing, those parallel programming abstractions are a bit lower level. 01:01:30,920 --> 01:01:38,080
共享地址空间和消息传递，那些并行编程抽象都比较低。
--The programmer has to fill in some more detail than what you just saw with data parallel, where the language or compiler was doing almost all of the interesting stuff for us. 01:01:38,080 --> 01:01:47,480
程序员必须填写一些比你刚刚看到的数据并行更多的细节，语言或编译器为我们做了几乎所有有趣的事情。
--So the way that this will work is, we'll have a computation phase where you update all of one color, and then you have to wait until everyone catches up. 01:01:47,480 --> 01:01:58,760
所以这将起作用的方式是，我们将有一个计算阶段，你更新所有一种颜色，然后你必须等到每个人都赶上来。
--And there's a special primitive for that called a barrier. 01:01:58,760 --> 01:02:01,720
并且有一个特殊的原语称为屏障。
--So a barrier is something that says, okay, everybody has to wait until everybody catches up, and then you can go forward after that. 01:02:01,720 --> 01:02:08,800
所以障碍就是说，好吧，每个人都必须等到每个人都赶上来，然后你才能继续前进。
--So the- the- these yellow things are barriers. 01:02:08,800 --> 01:02:11,800
所以-这些-这些黄色的东西是障碍。
--And then, uh, you go on and do the next phase, and when you get to the next phase, communication will occur. 01:02:11,800 --> 01:02:17,360
然后，呃，你继续做下一个阶段，当你进入下一个阶段时，沟通就会发生。
--Now, in a shared address space model, communication just happens by loading and storing memory. 01:02:17,360 --> 01:02:24,000
现在，在共享地址空间模型中，通信只是通过加载和存储内存来进行。
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
--Maybe this isn't really what we want, but I wanna talk through some things that are going on here. 01:02:42,360 --> 01:02:47,480
也许这不是我们真正想要的，但我想谈谈这里发生的一些事情。
--So notice there's a lot more code now. 01:02:47,480 --> 01:02:50,240
所以请注意现在有更多的代码。
--And okay. 01:02:50,240 --> 01:02:52,760
好吧。
--So let me start with what's going on up here in the declaration. 01:02:52,760 --> 01:02:57,240
那么让我从声明中的内容开始。
--So we need a barrier, and we're going to need a lock. 01:02:57,240 --> 01:03:01,040
所以我们需要一个屏障，我们需要一把锁。
--And we're going to do, um, static, uh, assignment in these, uh, blocks of rows. 01:03:01,040 --> 01:03:10,720
我们将在这些行块中进行，嗯，静态，呃，赋值。
--And the code is going to calculate that. 01:03:10,720 --> 01:03:13,360
代码将对其进行计算。
--It needs to know its thread ID. 01:03:13,360 --> 01:03:15,440
它需要知道它的线程 ID。
--This is a little bit like the program instance that we saw before with ISPC. 01:03:15,440 --> 01:03:19,680
这有点像我们之前用 ISPC 看到的程序实例。
--So based on your thread ID, which we somehow magically get, uh, we use that to calculate, um, the min and max, um, based on like n and the number of processors. 01:03:19,680 --> 01:03:32,560
因此，基于您的线程 ID，我们以某种方式神奇地获得，呃，我们使用它来计算，嗯，最小值和最大值，嗯，基于 n 和处理器的数量。
--So in other words, in this, in this chunk of rows, we wanna know, okay, for me specifically, where do I begin and where do I end? Where, where am I beginning and ending rows in this? And then you're going to iterate across them. 01:03:32,560 --> 01:03:46,600
所以换句话说，在这一行中，我们想知道，好吧，特别是对我来说，我从哪里开始，从哪里结束？在哪里，我在哪里开始和结束行？然后你将遍历它们。
--So you'll see the outer loop is now iterating not from 0 to n minus 1, but from, uh, my min to my max. 01:03:46,600 --> 01:03:55,960
所以你会看到外循环现在不是从 0 迭代到 n 减 1，而是从，呃，我的最小值到我的最大值。
--But you'll see that the inner part of the loop body looks the same as it did before. 01:03:55,960 --> 01:04:01,440
但是您会看到循环体的内部看起来和以前一样。
--We just, uh, we just go ahead and access the array elements. 01:04:01,440 --> 01:04:07,600
我们只是，呃，我们只是继续访问数组元素。
--That looks just like it did in the sequential code. 01:04:07,600 --> 01:04:10,480
这看起来就像它在顺序代码中所做的那样。
--One thing that's new though is we wanna add up, we wanna accumulate all of these, the sum of all of these differences, and we wanna put in a lock for that because if we don't have a lock, then we can have a data race and we can accidentally drop updates if two things read and, and then miss each other's updates. 01:04:10,480 --> 01:04:29,760
有一件事是新的，我们想加起来，我们想累加所有这些，所有这些差异的总和，我们想为此加一把锁，因为如果我们没有锁，那么我们可以有一个数据竞争，如果两件事读取和，我们可能会不小心丢弃更新，然后错过彼此的更新。
--So we put in a lock for that, and then we have, uh, some barriers also in the code. 01:04:29,760 --> 01:04:36,600
所以我们为此设置了一个锁，然后我们在代码中也有一些障碍。
--Okay. Do you see anything here that looks, uh, suboptimal, optimal to you? So as it's written, this code will not be particularly fast. 01:04:36,600 --> 01:04:50,360
好的。你看到这里有什么东西看起来，呃，次优，对你来说是最佳的吗？所以正如它所写的那样，这段代码不会特别快。
--Do you see, is something kind of leaping out of you as a bottleneck? Yeah. 01:04:50,480 --> 01:04:57,360
你看，有什么东西从你身上跳出来成为瓶颈吗？是的。
--Even if it's locked and unlocked. 01:04:57,360 --> 01:04:59,160
即使它被锁定和解锁。
--Right. 01:04:59,160 --> 01:04:59,680
正确的。
--It's a lot of free thread though. 01:04:59,680 --> 01:05:01,160
虽然有很多免费线程。
--Right. So in the inner loop, in the inner loop body, we are locking and unlocking. 01:05:01,160 --> 01:05:07,520
正确的。所以在内循环中，在内循环体中，我们在加锁和解锁。
--So how frequently will that occur? I mean, how much work is occurring in between those locks and unlocks? Well, the only other thing that we do is we do this addition. 01:05:07,520 --> 01:05:17,720
那么这种情况发生的频率是多少？我的意思是，在这些锁定和解锁之间发生了多少工作？好吧，我们唯一要做的就是做这个加法。
--So that's not gonna take very long, just a couple of cycles. 01:05:17,720 --> 01:05:21,520
所以这不会花很长时间，只需几个周期。
--So if we have a lot of processors running, and they will be contending very heavily for that lock. 01:05:21,520 --> 01:05:27,920
因此，如果我们有很多处理器在运行，它们将非常激烈地争夺该锁。
--So that, that will probably be a major bottleneck. 01:05:27,920 --> 01:05:31,720
因此，这可能是一个主要瓶颈。
--Um, okay. Well, maybe we can fix that. 01:05:31,720 --> 01:05:35,560
嗯，好的。好吧，也许我们可以解决这个问题。
--Okay. So first of all, we need locks. 01:05:35,560 --> 01:05:37,880
好的。所以首先，我们需要锁。
--I think hopefully this is review for people, but if we didn't have the locks, then we could lose updates because you would bring things into registers on two different threads, try to update them, write them back, and end up losing one of the updates. 01:05:37,880 --> 01:05:52,080
我希望这是对人们的审查，但如果我们没有锁，那么我们可能会丢失更新，因为您会在两个不同的线程上将内容放入寄存器，尝试更新它们，将它们写回，最终会丢失一个的更新。
--So that's why we need locks. 01:05:52,080 --> 01:05:54,040
所以这就是我们需要锁的原因。
--And locks can come in different flavors. 01:05:54,040 --> 01:05:56,320
锁可以有不同的风格。
--Here I'm showing them just as a lock with an explicit variable. 01:05:56,320 --> 01:06:01,080
在这里，我将它们展示为带有显式变量的锁。
--Um, people have also proposed having just, uh, some wrapper that says, um, all of this code here has to be done atomically somehow. 01:06:01,080 --> 01:06:10,080
嗯，人们还提议只，呃，一些包装器说，嗯，这里的所有这些代码都必须以某种方式自动完成。
--And then there are instructions to do this for just individual math operations. 01:06:10,080 --> 01:06:14,800
然后有针对单个数学运算执行此操作的说明。
--But for today, we're just gonna stick with regular locks and, and, uh, the same ideas would apply more or less to the other, the other primitives. 01:06:14,800 --> 01:06:23,600
但就今天而言，我们将坚持使用常规锁，并且，呃，相同的想法或多或少地适用于其他原语。
--Okay. So instead of, uh, putting the lock here, uh, what else can we do? Can we, can we, is there something obvious to do to make this faster? Each, each thread can store its own diff, and after it's finished, it just can be added to the, to the diff. 01:06:23,600 --> 01:06:40,640
好的。所以与其，呃，把锁放在这里，呃，我们还能做什么？我们可以，我们可以，有什么明显的方法可以使它更快吗？每个线程都可以存储自己的差异，完成后，可以将其添加到差异中。
--Right. So, uh, it's the trick I talked about almost, you know, at the beginning of the lecture where instead of accumulating it all the time into a global thing, what we do is we will, uh, have a local diff. 01:06:40,640 --> 01:06:54,400
正确的。所以，呃，这就是我几乎在讲座开始时谈到的技巧，你知道，我们不会一直将它累积成一个全局的东西，我们要做的是，呃，有一个本地差异。
--So each thread will figure out its portion of that total sum. 01:06:54,400 --> 01:06:58,800
所以每个线程都会计算出它在总和中的份额。
--And only after we've finished iterating over all of our work, at that point, we can accumulate those partial sums into one global sum. 01:06:58,800 --> 01:07:07,760
只有在我们完成所有工作的迭代之后，到那时，我们才能将这些部分总和累积为一个全局总和。
--But that will only occur once after we've done, like, both, all of the work in our loops. 01:07:07,760 --> 01:07:14,000
但这只会在我们完成循环中的所有工作后发生一次。
--So that will occur far, far less frequently. 01:07:14,000 --> 01:07:16,800
所以这种情况发生的频率要低得多。
--So that should help a lot to avoid that, make, having that be a bottleneck. 01:07:16,800 --> 01:07:21,440
因此，这应该有助于避免成为瓶颈。
--Okay. So that's one trick. 01:07:21,440 --> 01:07:23,680
好的。所以这是一招。
--Um, now, what about the barriers? Um, so barrier, the way it works is you tell the barrier how many threads are trying to synchronize for the barrier and they will all stall until they all arrive. 01:07:23,680 --> 01:07:38,880
嗯，现在，障碍呢？嗯，屏障，它的工作方式是你告诉屏障有多少线程正在尝试为屏障同步，它们将全部停止，直到它们全部到达。
--And I already talked about why we needed this, which is you don't want, when you're in the middle of updating the red elements, you don't want to have any process finishing early and then jumping ahead and starting to update black elements based on red elements that have not yet been updated. 01:07:38,880 --> 01:07:53,800
我已经谈过为什么我们需要这个，这是你不想要的，当你正在更新红色元素时，你不希望任何进程提前完成然后跳到前面开始更新基于尚未更新的红色元素的黑色元素。
--That would, that would be a problem. 01:07:53,800 --> 01:07:55,880
那会，那会是一个问题。
--Now, if we look at the code, it actually has three barriers in it, in each iteration. 01:07:55,880 --> 01:08:01,880
现在，如果我们看一下代码，它实际上在每次迭代中都有三个障碍。
--Assuming you have good eyesight, um, can anyone explain why are there three barriers here? I mean, you would have expected one at least, but why are there three of them? Yep. 01:08:01,880 --> 01:08:18,680
假设你的视力很好，嗯，谁能解释一下为什么这里有三个障碍？我的意思是，你至少会想到一个，但为什么会有三个？是的。
--So if you don't have a barrier in the end, some of the threads can actually go through and go to the first barrier. 01:08:18,680 --> 01:08:24,640
所以如果你最后没有障碍，一些线程实际上可以通过并到达第一个障碍。
--So your first barrier will never be complete and so will your second barrier. 01:08:24,640 --> 01:08:27,960
所以你的第一个障碍永远不会完成，你的第二个障碍也是如此。
--Oh, one thing I forgot to say about barriers is they're designed so that if you hit them back to back, the right thing will happen. 01:08:27,960 --> 01:08:36,720
哦，关于障碍我忘了说一件事，那就是它们的设计是这样的，如果你背靠背地击中它们，正确的事情就会发生。
--So if one thread, um, you know, jumps, anyway, barriers are reusable kind of back to back and they'll work. 01:08:36,880 --> 01:08:43,440
因此，如果一个线程，嗯，你知道，跳转，无论如何，障碍是可重复使用的一种背靠背，它们会起作用。
--They basically reset themselves. 01:08:43,440 --> 01:08:45,040
他们基本上重置了自己。
--But, but yeah, so if we, if we didn't have, um, if I took out this barrier, then the problem is that one thread could wrap around here and actually reset the overall difference before other threads were finished, reading it to decide whether they should terminate. 01:08:45,040 --> 01:09:04,240
但是，但是，是的，所以如果我们，如果我们没有，嗯，如果我去掉了这个障碍，那么问题是一个线程可以在这里绕过并在其他线程完成之前重置整体差异，读取它决定他们是否应该终止。
--So in fact, some of them could get different results for whether they should terminate or not because someone would reset it to zero. 01:09:04,280 --> 01:09:11,720
所以事实上，他们中的一些人可能会因为有人将其重置为零而在是否应该终止方面得到不同的结果。
--Anybody who read it after that would go, woo, hey, we're, we're done. 01:09:11,720 --> 01:09:15,480
在那之后读到它的任何人都会说，哇，嘿，我们，我们完成了。
--Wow, our overall, uh, we've totally converged. 01:09:15,480 --> 01:09:19,520
哇，我们的整体，呃，我们已经完全融合了。
--There was no difference at all. 01:09:19,520 --> 01:09:21,280
完全没有区别。
--So we don't want that to happen. 01:09:21,280 --> 01:09:22,560
所以我们不希望这种情况发生。
--That's why this last barrier is here. 01:09:22,560 --> 01:09:24,760
这就是最后一个障碍在这里的原因。
--Um, why is this barrier here? This first barrier is here because before, you want to make sure you finish resetting the difference before you start, oh, sorry, it's about your local difference. 01:09:24,760 --> 01:09:35,320
额，这个结界怎么会在这里？这第一个障碍在这里是因为之前，你要确保在开始之前完成重置差异，哦，抱歉，这是关于你当地的差异。
--You want to reset that before you start accumulating into it. 01:09:35,320 --> 01:09:39,240
您想在开始积累之前重置它。
--Um, and then finally, uh, you don't want to test it until you've finished all of, uh, those accumulations. 01:09:39,240 --> 01:09:46,000
嗯，最后，呃，在你完成所有这些积累之前，你不想测试它。
--Okay. So it turns out that this is real- the reason why we have three barriers here is because of the awkwardness of dealing with this, um, this diff variable and, and the mydiff variable. 01:09:46,000 --> 01:09:58,880
好的。所以事实证明这是真实的——我们在这里有三个障碍的原因是因为处理这个，嗯，这个 diff 变量和，以及 mydiff 变量的尴尬。
--So it turns out that there's a way to get around this, which is- it's essentially just a naming problem. 01:09:58,880 --> 01:10:05,040
所以事实证明有一种方法可以解决这个问题，那就是——它本质上只是一个命名问题。
--We could have, uh, uh, an array with three instances of diff and effectively pipeline those things across different iterations so there's a little more work involved with that. 01:10:05,040 --> 01:10:17,800
我们可以，呃，呃，一个包含三个 diff 实例的数组，并在不同的迭代中有效地流水线化这些东西，所以涉及到更多的工作。
--But if you did that, basically, you take- you now want to reference, you know, index, uh, modulo 3. 01:10:17,800 --> 01:10:25,320
但如果你这样做了，基本上，你现在想要引用，你知道，索引，呃，模 3。
--It turns out if you do this, then it, it actually fixes this problem of overriding diff before you should, you know, while the people are still busy accessing it because based on this index, every- each thread would always be pointing to the right copy of diff anyway. 01:10:25,320 --> 01:10:41,120
事实证明，如果你这样做，那么它实际上解决了这个在你应该之前覆盖 diff 的问题，你知道，当人们仍然忙于访问它时，因为基于这个索引，每个线程总是指向反正差异的正确副本。
--And diff is only- it's only a scalar, so having three of them is, is not any space overhead to worry about. 01:10:41,120 --> 01:10:47,360
而且 diff 只是 - 它只是一个标量，所以拥有三个是，没有任何空间开销需要担心。
--And if we do that, now we can get away with just one barrier in this case. 01:10:47,360 --> 01:10:51,440
如果我们这样做，现在我们就可以在这种情况下摆脱一个障碍。
--So that's, that's interesting. 01:10:51,440 --> 01:10:53,560
就是这样，这很有趣。
--Okay. So that's another type of trick you might be able to use. 01:10:53,560 --> 01:10:57,240
好的。所以这是您可以使用的另一种技巧。
--Um, now, one thing about a barrier is that barriers might be, they're a little- they're a bit heavyweight because it's one way, one way to deal with, uh, dependencies is to just throw in a barrier and that will force all the threads to all catch up to each other. 01:10:57,560 --> 01:11:14,360
嗯，现在，关于障碍的一件事是，障碍可能是，它们有点——它们有点重量级，因为它是一种方式，一种处理依赖关系的方法，呃，依赖性就是加入一个障碍，然后将迫使所有线程都相互追赶。
--But what if you knew that you- what if you had more precise information? If you knew, oh, wait a minute, I don't need all of the data to be updated. 01:11:14,360 --> 01:11:23,400
但是如果你知道你——如果你有更精确的信息怎么办？如果您知道，哦，等一下，我不需要更新所有数据。
--I just need a specific location to be updated. 01:11:23,400 --> 01:11:26,200
我只需要更新一个特定的位置。
--If you knew that more specifically, then you could have more precise, uh, dependence information and maybe just wait specifically for the things you need and not force everything to catch up. 01:11:26,240 --> 01:11:37,360
如果你更具体地知道这一点，那么你可以获得更精确的，呃，依赖信息，也许只是专门等待你需要的东西，而不是强迫一切都赶上。
--So for example, if you need x and you, uh, realize that you could potentially imagine having some synchronization associated with it. 01:11:37,360 --> 01:11:47,280
因此，例如，如果您需要 x 并且您，呃，意识到您可能会想象与它相关联的一些同步。
--Now, um, let's see, I need to draw like a little skull and crossbones here. 01:11:47,280 --> 01:11:53,680
现在，嗯，让我们看看，我需要在这里画一个小骷髅和交叉骨。
--Uh, because the way that this code is written, this is incredibly dangerous code as written. 01:11:53,680 --> 01:11:59,400
呃，因为这段代码的编写方式，这是非常危险的代码。
--Never, never write this code because, uh, you need to have something in the middle called a fence. 01:11:59,400 --> 01:12:05,760
永远，永远不要写这段代码，因为，呃，你需要在中间有一个叫做栅栏的东西。
--And if you don't have a fence in this code, then, uh, it will not work at all. 01:12:05,760 --> 01:12:11,320
如果你在这段代码中没有栅栏，那么，呃，它根本不起作用。
--And we have a full lecture on that later, uh, this semester. 01:12:11,320 --> 01:12:14,560
稍后，呃，本学期我们将对此进行完整的讲座。
--So when we talk about memory consistency models, we'll see why this code is written as code you should never, ever, ever write. 01:12:14,560 --> 01:12:21,200
因此，当我们谈论内存一致性模型时，我们将了解为什么将这段代码编写为您永远不应该编写的代码。
--Okay. So I'm not saying that the concept of breaking it up into smaller dependencies is bad. 01:12:21,640 --> 01:12:26,720
好的。所以我并不是说将它分解成更小的依赖项的概念是不好的。
--I just meant don't write code where you use normal memory locations as synchronization flies because that will not work. 01:12:26,720 --> 01:12:32,160
我的意思是不要在使用正常内存位置的地方编写代码，因为同步会飞，因为那样行不通。
--Okay. So, so far we looked at, uh, two of the models, data parallel and shared address space, and we have one more to go. 01:12:32,160 --> 01:12:40,040
好的。所以，到目前为止，我们研究了两个模型，数据并行和共享地址空间，我们还有一个要走。
--So, um, and this one's going to look, uh, quite a bit different. 01:12:40,040 --> 01:12:45,000
所以，嗯，这个看起来，嗯，有点不同。
--So, uh, remember that with message passing, communication only occurs through messages that you send to other threads, and then they receive messages. 01:12:45,000 --> 01:12:56,680
所以，呃，请记住，对于消息传递，通信仅通过您发送给其他线程的消息发生，然后它们接收消息。
--And the only memory you can access is private memory. 01:12:56,680 --> 01:13:00,120
您唯一可以访问的内存是私有内存。
--So when we have a, a matrix, and we're operating on different parts of the matrix, that means that the different parts that we assign to the different processors, they live only in the local memory of those processors. 01:13:00,120 --> 01:13:14,880
因此，当我们有一个矩阵，并且我们在矩阵的不同部分进行操作时，这意味着我们分配给不同处理器的不同部分，它们仅存在于这些处理器的本地内存中。
--We can't just arbitrarily load and store anywhere in the matrix, only to the part of it that's local to us. 01:13:14,880 --> 01:13:22,280
我们不能随意加载和存储矩阵中的任何地方，只能加载和存储我们本地的部分。
--So if we are dividing this up by blocks of rows, the local memories will have only, um, your portion of, of the address, uh, of the addresses. 01:13:22,280 --> 01:13:35,080
因此，如果我们将其按行块划分，则本地存储器将只有，嗯，您的地址部分，呃，地址部分。
--So remember, uh, that's not going to be an issue if I'm updating this thing and I need, you know, these four elements, that looks fine. 01:13:35,080 --> 01:13:43,720
所以请记住，呃，如果我要更新这个东西，那不会成为问题，我需要，你知道，这四个元素，看起来不错。
--But what happens when I'm updating this element here and I need this, this, this, this, and whoops, that? So the thing that's, I can't just reference that thing and expect something good to happen. 01:13:43,720 --> 01:13:57,000
但是当我在这里更新这个元素并且我需要这个，这个，这个，这个，还有那个，会发生什么？所以事情就是这样，我不能仅仅参考那件事并期望好事发生。
--So one of the things that we do is, well, to not have our code be really awkward, we will actually allocate an additional row along the boundary in memory. 01:13:57,000 --> 01:14:08,320
所以我们做的一件事是，好吧，为了不让我们的代码真的很尴尬，我们实际上会在内存中沿着边界分配一个额外的行。
--So this is redundant, this is extra memory. 01:14:08,320 --> 01:14:12,760
所以这是多余的，这是额外的内存。
--We call this a ghost, uh, ghost row or ghost cells. 01:14:12,760 --> 01:14:16,480
我们称之为幽灵，呃，幽灵行或幽灵细胞。
--And this is a holding place where we can, where we're going to insert the data that we will have to get from other processors. 01:14:16,480 --> 01:14:23,480
这是一个我们可以存放的地方，我们将在其中插入必须从其他处理器获取的数据。
--This is just to keep the code nice and simple. 01:14:23,480 --> 01:14:26,000
这只是为了保持代码简洁明了。
--So that way when we're updating something here, we can just go ahead and use our original code that will reference something up here, even though that's not really, uh, necessarily up to date unless we're careful. 01:14:26,000 --> 01:14:40,120
这样当我们在这里更新某些东西时，我们可以继续使用我们的原始代码来引用这里的东西，即使那不是真的，呃，除非我们小心，否则不一定是最新的。
--So then the idea is we're going to pass rows up and down. 01:14:40,120 --> 01:14:44,600
那么我们的想法是我们要上下传递行。
--And we're going to do this using, uh, send and receive. 01:14:44,600 --> 01:14:48,360
我们将使用，呃，发送和接收来做到这一点。
--So we will, at, at the boundaries of the computation, we're going to receive rows from other, from our neighboring processors, and we're going to copy that data into those ghost rows. 01:14:48,360 --> 01:15:02,600
因此，我们将在计算的边界处从其他处理器接收行，并将这些数据复制到那些幻影行中。
--And then we can go ahead and do that chunk of work. 01:15:02,600 --> 01:15:05,840
然后我们可以继续做那部分工作。
--We can finish doing all the red or black cells, and then we have to pass them again, and then wait, and then do that again. 01:15:05,840 --> 01:15:13,640
我们可以完成所有的红色或黑色单元格，然后我们必须再次通过它们，然后等待，然后再做一遍。
--Okay. So here's, uh, yeah, this code gets, uh, more complicated. 01:15:13,640 --> 01:15:20,120
好的。所以这里是，呃，是的，这段代码变得，呃，更复杂了。
--So I'm going to go through parts of this here. 01:15:20,120 --> 01:15:22,720
所以我将在这里讨论其中的一部分。
--So, um, let me, uh, explain what's happening here. 01:15:22,720 --> 01:15:27,680
所以，嗯，让我，呃，解释一下这里发生了什么。
--So in the middle, I apologize, this is really small font, so it's hard to see. 01:15:27,680 --> 01:15:31,640
所以在中间，我很抱歉，这个字体真的很小，所以很难看清。
--But the part I just highlighted, that's, that's the main work in the middle. 01:15:31,640 --> 01:15:35,760
但是我刚才强调的部分，那就是中间的主要工作。
--And it looks very much like, uh, what we had, uh, in the other code. 01:15:35,760 --> 01:15:41,160
它看起来非常像，呃，我们在其他代码中所拥有的。
--One thing that's different though is the loop index is just, uh, basically the, it's, they're all the same because it's just from like zero to, uh, whatever the size is here. 01:15:41,160 --> 01:15:54,880
有一点不同的是，循环索引只是，呃，基本上，它们都是一样的，因为它只是从零到，呃，无论这里的大小是多少。
--So you're just accessing your own local memory, and that's what's going on. 01:15:54,880 --> 01:15:59,400
所以你只是在访问你自己的本地内存，这就是正在发生的事情。
--But the interesting things are up here, we're passing these, uh, ghost rows back and forth. 01:15:59,400 --> 01:16:05,520
但有趣的事情就在这里，我们来回传递这些，呃，幽灵行。
--So you'll notice that you will send the rows, and you'll receive the rows. 01:16:05,520 --> 01:16:12,040
所以您会注意到您将发送行，并且您将收到行。
--So you send them up and down. 01:16:12,040 --> 01:16:14,840
所以你上下发送它们。
--Now, if you're the one on the very top or the very bottom, you don't send them off the edge. 01:16:14,840 --> 01:16:18,440
现在，如果你是最顶层或最底层的人，你就不会把他们赶出边缘。
--So that's what the conditional test is there for. 01:16:18,440 --> 01:16:20,680
这就是条件测试的目的。
--And then you receive them from your neighbors, and you copy them in, and then you can go ahead and do the work. 01:16:20,680 --> 01:16:25,960
然后你从你的邻居那里收到它们，你把它们抄进去，然后你就可以继续工作了。
--Now, um, what's all of this at the bottom? So all of that is basically the reduction and, and test at the end. 01:16:25,960 --> 01:16:34,480
现在，嗯，底部的这些是什么？所以所有这些基本上都是减少和最后的测试。
--So you can locally calculate the sum of the differences as you're updating the values, but now everyone has to agree on whether, uh, the, the, you've reached convergence or not. 01:16:34,480 --> 01:16:46,200
因此，您可以在更新值时在本地计算差异之和，但现在每个人都必须就，呃，您是否已经达到收敛达成一致。
--So the way that it does that is it picks one lucky, uh, processor, processor 0. 01:16:46,200 --> 01:16:52,040
所以它这样做的方式是选择一个幸运的，呃，处理器，处理器 0。
--And processor 0 is, if you're not processor 0, then you send processor 0 message with your partial difference in it. 01:16:52,040 --> 01:17:02,440
处理器 0 是，如果你不是处理器 0，那么你发送处理器 0 消息，其中包含你的部分差异。
--It receives all of those messages, adds them all up, and then sends them back out to the other processors. 01:17:02,440 --> 01:17:08,000
它接收所有这些消息，将它们全部加起来，然后将它们发送回其他处理器。
--So the ones that are not processor 0 just do the send, and then they wait to get the done flag. 01:17:08,000 --> 01:17:14,520
所以那些不是处理器 0 的只是发送，然后他们等待获得完成标志。
--And if you are processor 1, then you've got a lot of work to do here, um, getting all these messages, adding them up, and then sending out those messages. 01:17:14,520 --> 01:17:22,720
如果你是处理器 1，那么你在这里有很多工作要做，嗯，获取所有这些消息，将它们相加，然后发送这些消息。
--Okay. So now it turns out that that last step, because that pattern happens relatively frequently, uh, the languages that support this usually have some kind of reduction primitive that will automatically do all the stuff that you saw there. 01:17:23,280 --> 01:17:38,600
好的。所以现在结果是最后一步，因为这种模式发生得相对频繁，呃，支持这种模式的语言通常有某种简化原语，它会自动完成你在那里看到的所有事情。
--But if we look at, um, if we look at this code and what's going on here. 01:17:38,600 --> 01:17:44,280
但是如果我们看，嗯，如果我们看这段代码，看看这里发生了什么。
--So interestingly, you know, we're computing on our local address space, and this code is sending entire rows at a time, um, not individual elements, and that's on purpose so that we can get decent performance. 01:17:44,280 --> 01:17:57,920
有趣的是，你知道，我们在本地地址空间上进行计算，这段代码一次发送整行，嗯，而不是单个元素，这是故意的，这样我们可以获得不错的性能。
--Now, it turns out the code that I showed you is, uh, badly broken in one important way. 01:17:57,920 --> 01:18:04,200
现在，事实证明我向您展示的代码在一个重要方面严重损坏。
--If we were using- okay. 01:18:04,200 --> 01:18:05,880
如果我们使用 - 好吧。
--Well, uh, what- okay. 01:18:05,880 --> 01:18:08,680
好吧，呃，什么-好吧。
--The question is, when you do a send, uh, what happens? Do you wait? Uh, one- one possibility is that if you have a synchronous send, then when I try to send a message until the receiver has received it, I will block. 01:18:08,680 --> 01:18:21,520
问题是，当你发送时，嗯，会发生什么？你等吗？呃，一种可能性是，如果你有一个同步发送，那么当我尝试发送一条消息直到接收者收到它时，我会阻塞。
--So let's assume we have that kind of send. 01:18:21,520 --> 01:18:24,400
所以让我们假设我们有那种发送。
--What's wrong with the code? Go back and look at the code. 01:18:24,400 --> 01:18:29,400
代码有什么问题？回去看看代码。
--It turns out this code will deadlock. 01:18:29,400 --> 01:18:32,360
事实证明这段代码会死锁。
--Why will it deadlock? Every thread is sending. 01:18:32,360 --> 01:18:38,680
为什么会死锁？每个线程都在发送。
--Right. Yeah. So every thread is saying, okay, we start off, we all send a row down. 01:18:38,680 --> 01:18:44,560
正确的。是的。所以每个线程都在说，好的，我们开始，我们都向下发送一行。
--Okay. And then we all send a row up. 01:18:44,560 --> 01:18:47,320
好的。然后我们都发送一行。
--And, uh, wait a minute. 01:18:47,320 --> 01:18:49,640
而且，呃，等一下。
--Nobody's doing a receive. 01:18:49,640 --> 01:18:50,920
没有人在做接收。
--Why isn't anybody doing a receive? Oh, right. Because we're all sending to somebody else, and they're all waiting for somebody else to receive. 01:18:50,920 --> 01:18:56,120
为什么没有人做接收？啊对。因为我们都在发送给其他人，而他们都在等待其他人接收。
--So. You could have even processors send first, and odd processors receive first. 01:18:56,120 --> 01:19:01,600
所以。您可以让偶数处理器先发送，奇数处理器先接收。
--Yeah. Exactly. 01:19:01,600 --> 01:19:02,960
是的。确切地。
--So, uh, and here's a picture of that. 01:19:02,960 --> 01:19:05,240
所以，呃，这是一张照片。
--So that's one way to solve the problem, is we can switch evens and odds. 01:19:05,240 --> 01:19:09,680
所以这是解决问题的一种方法，我们可以转换偶数和赔率。
--And then this is code that will not deadlock. 01:19:09,680 --> 01:19:11,680
然后这是不会死锁的代码。
--It's very similar, but it fixed that problem. 01:19:11,680 --> 01:19:13,960
它非常相似，但它解决了这个问题。
--Um, another thing that you can use, is use non-blocking sends and receive. 01:19:13,960 --> 01:19:17,440
嗯，您可以使用的另一件事是使用非阻塞发送和接收。
--Okay. So last slide here. 01:19:17,440 --> 01:19:19,680
好的。最后一张幻灯片在这里。
--Um, so we talked at a high level about the different steps in writing a parallel code, about, uh, decomposition and assignment. 01:19:19,680 --> 01:19:27,040
嗯，所以我们在较高层次上讨论了编写并行代码的不同步骤，关于分解和赋值。
--We looked at the different programming models. 01:19:27,040 --> 01:19:29,440
我们研究了不同的编程模型。
--Um, and in the next two lectures, we're going to dive into more detail about, uh, issues that affect performance. So, that's all. 01:19:29,440 --> 01:19:37,720
嗯，在接下来的两节课中，我们将深入探讨影响性能的问题的更多细节。所以，就是这样。
