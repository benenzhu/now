--So, today we're going to start talking about GPUs. 00:00:00,000 --> 00:00:07,440
所以，今天我们要开始谈论 GPU。
--And I'd say GPUs are sort of one of the most exciting things to come along in high-performance 00:00:07,440 --> 00:00:12,440
我想说 GPU 是高性能领域最令人兴奋的事物之一
--computing in the past several decades, because they really shifted the whole space of what's 00:00:12,440 --> 00:00:19,760
计算在过去的几十年里，因为他们真的改变了整个空间
--possible performance-wise. 00:00:19,760 --> 00:00:24,280
可能的性能方面。
--And now if you look at – could we turn down the volume on this? 00:00:24,280 --> 00:00:28,160
现在，如果你看一下——我们可以调低音量吗？
--So they really shifted the performance possibilities, and now if you look at pretty much all major 00:00:28,160 --> 00:00:34,360
所以他们真的改变了性能的可能性，现在如果你看看几乎所有主要的
--supercomputers, what they are, they've stuffed a bunch of GPUs together, and that's really 00:00:34,360 --> 00:00:39,600
超级计算机，它们是什么，它们把一堆 GPU 塞在一起，这真的
--the way, because the sort of raw compute power you can get out of them is amazing. 00:00:39,600 --> 00:00:44,160
顺便说一句，因为您可以从中获得的那种原始计算能力是惊人的。
--And the trick is to have both the appropriate applications and write your programs in the 00:00:44,160 --> 00:00:49,600
诀窍是同时拥有适当的应用程序并在
--right way for it to work. 00:00:49,600 --> 00:00:51,440
它工作的正确方法。
--So that will be the topic of this lecture, and of course in this current assignment you're 00:00:51,440 --> 00:00:56,920
所以这将是本次讲座的主题，当然在当前的作业中你是
--working on. 00:00:56,920 --> 00:01:01,560
工作。
--So we'll talk a little about how these came about, and then we'll talk more about – it's 00:01:01,560 --> 00:01:08,160
所以我们会稍微谈谈这些是如何产生的，然后我们会更多地谈论——它是
--an interesting thing, because at some level of abstraction you don't even need to understand 00:01:08,160 --> 00:01:13,000
一件有趣的事情，因为在某种抽象层次上你甚至不需要理解
--the hardware to make use of these. 00:01:13,000 --> 00:01:15,760
使用这些的硬件。
--But if you actually want to get real performance out of it, you do. 00:01:15,760 --> 00:01:18,400
但是，如果您真的想从中获得真正的性能，您就可以做到。
--So you have to kind of know enough about what's really going on underneath it when it executes 00:01:18,400 --> 00:01:23,320
所以当它执行时，你必须足够了解它下面到底发生了什么
--programs to have a sense of how especially you can exploit some of the features that 00:01:23,320 --> 00:01:28,760
了解如何特别利用某些功能的程序
--let you drop down to a little bit lower level and get much greater performance. 00:01:28,760 --> 00:01:38,560
让您降低到更低的水平并获得更高的性能。
--So you recall we've shown this picture before. 00:01:38,560 --> 00:01:44,000
所以你记得我们之前展示过这张照片。
--The idea of it is that on one chip, a pretty big chip, you have a bunch of processors, 00:01:44,000 --> 00:01:51,120
它的想法是在一个芯片上，一个相当大的芯片上，你有一堆处理器，
--each of which at some very vague level looks like a fairly conventional modern CPU, meaning 00:01:51,120 --> 00:01:57,200
每一个在某个非常模糊的层面上看起来都像是一个相当传统的现代 CPU，这意味着
--it has the ability to support multiple ALUs through SIMD instructions, and it's able to 00:01:57,200 --> 00:02:03,560
它有能力通过 SIMD 指令支持多个 ALU，并且它能够
--support multiple threads in what Intel calls hyper-threading, or more appropriately, simultaneously 00:02:03,560 --> 00:02:10,360
支持英特尔称之为超线程的多线程，或者更恰当地说，同时支持
--multi-threading. 00:02:10,360 --> 00:02:12,560
多线程。
--These GPUs also exploit that kind of idea, but in a much more way that sort of actually 00:02:12,560 --> 00:02:21,680
这些 GPU 也利用了这种想法，但实际上以更多的方式
--gives you a fairly different model of computing overall than a conventional processor does. 00:02:21,680 --> 00:02:27,760
为您提供与传统处理器完全不同的整体计算模型。
--So it has a lot of these. 00:02:27,760 --> 00:02:29,600
所以它有很多这样的。
--These are called SMs in the NVIDIA world, and this shows 16. 00:02:29,600 --> 00:02:35,980
这些在 NVIDIA 世界中被称为 SM，这显示了 16 个。
--This is based on a slightly older model. 00:02:35,980 --> 00:02:37,960
这是基于一个稍旧的模型。
--The ones you've got in the GHC machines have 20 of these. 00:02:37,960 --> 00:02:41,220
你在 GHC 机器中得到的那些有 20 个。
--The idea is you have some number of execution units, each of which can support some number 00:02:41,780 --> 00:02:46,940
这个想法是你有一些执行单元，每个执行单元都可以支持一些
--of arithmetic operations and a multiple execution context, and then connected to a memory that 00:02:46,940 --> 00:02:54,660
算术运算和多重执行上下文，然后连接到内存
--in the world of memory is relatively small, but the bandwidth to it is extremely high. 00:02:54,660 --> 00:03:05,340
在内存的世界里，内存相对较小，但带宽却非常高。
--So let's just go through a little. 00:03:05,340 --> 00:03:07,860
因此，让我们看一下。
--They're called graphics processing units, and that's for a reason. 00:03:07,860 --> 00:03:10,500
它们被称为图形处理单元，这是有原因的。
--That's the context in which they rose. 00:03:10,500 --> 00:03:13,100
这就是他们崛起的背景。
--In the very first versions of these, that's all they did. 00:03:13,100 --> 00:03:16,600
在这些的最初版本中，这就是他们所做的一切。
--All they were good for was computer graphics. 00:03:16,600 --> 00:03:19,100
他们所擅长的只是计算机图形学。
--So let's understand enough about computer graphics to appreciate why this computational 00:03:19,100 --> 00:03:24,860
因此，让我们对计算机图形学有足够的了解，以了解为什么这种计算
--model is particularly well-suited. 00:03:24,860 --> 00:03:27,220
模型特别适合。
--And the point is that in modern computer graphics, you have many small objects that you want 00:03:27,220 --> 00:03:34,380
关键是在现代计算机图形学中，你有许多你想要的小物体
--to do some operation on, so a sort of data parallel model of computing is a very natural 00:03:34,380 --> 00:03:39,220
做一些操作，所以一种数据并行计算模型是很自然的
--part of it. 00:03:39,220 --> 00:03:40,580
一部分。
--And so this shows an example of if you want to render something like a three-dimensional 00:03:40,580 --> 00:03:45,180
所以这显示了一个例子，如果你想渲染像三维的东西
--shape, you'll typically create a set of triangular patches that describe the shape of it in a 00:03:45,180 --> 00:03:54,020
形状，你通常会创建一组三角形的补丁来描述它的形状
--set of finite elements, and then you want to add different features to each patch, what 00:03:54,020 --> 00:04:00,180
一组有限元，然后你想为每个补丁添加不同的功能，什么
--color it should be and other things, and then map those from a three-dimensional plane, 00:04:00,180 --> 00:04:08,660
它应该是颜色和其他东西，然后从三维平面映射它们，
--the actual object space, onto a two-dimensional viewing space, such as a screen, and that's 00:04:08,660 --> 00:04:14,820
实际的物体空间，到一个二维的观察空间，比如屏幕，那就是
--what's involved in rendering. 00:04:14,820 --> 00:04:17,660
渲染涉及什么。
--So the idea is that we want to be able to do this, and especially a lot of the market 00:04:17,660 --> 00:04:27,300
所以我们的想法是我们希望能够做到这一点，尤其是很多市场
--for this came in computer games. 00:04:27,300 --> 00:04:29,080
为此出现在电脑游戏中。
--So it shifted from something like making a movie by Pixar where they could have a rendering 00:04:29,080 --> 00:04:34,940
所以它从像皮克斯制作电影这样他们可以有渲染的东西转变了
--farm of 5,000 processors running for days to just render each frame of a movie to wanting 00:04:34,940 --> 00:04:44,100
由 5,000 个处理器组成的农场运行数天，只为将电影的每一帧渲染到想要的程度
--something that people could plug into their, have a game box, so something that fits in 00:04:44,100 --> 00:04:50,340
人们可以插入他们的东西，有一个游戏盒，所以适合的东西
--a small box and does real time, because as people travel through these games, you want 00:04:50,340 --> 00:04:55,780
一个小盒子并且实时进行，因为当人们在这些游戏中旅行时，你想要
--to be able to render. 00:04:55,780 --> 00:04:57,500
能够渲染。
--And of course, the original early games were very primitive in terms of the graphics, but 00:04:57,500 --> 00:05:01,340
当然，最初的早期游戏在图形方面非常原始，但是
--there's been a drive to be more and more realistic in it. 00:05:01,340 --> 00:05:05,260
有一种动力让它变得越来越现实。
--And it turns out that getting more and more realistic in graphics is one where it gets 00:05:05,260 --> 00:05:09,220
事实证明，在图形中变得越来越逼真是它获得的一个途径
--sort of exponentially more difficult the more realistic you want. 00:05:09,220 --> 00:05:13,240
您想要的越现实，难度就会成倍增加。
--So even this scene, you'll see a lot of stuff going on. 00:05:13,240 --> 00:05:16,420
所以即使是这个场景，你也会看到很多事情在发生。
--For example, you'll notice that the parts in the distance are slightly fuzzier than 00:05:16,420 --> 00:05:24,380
例如，您会注意到远处的部分比
--the things in the near, and that's, of course, to show the idea of the atmospheric effects 00:05:24,380 --> 00:05:31,140
附近的东西，当然，这是为了展示大气效应的概念
--that the things further away, there's sort of more rendering, more diffusion that you 00:05:31,140 --> 00:05:40,740
更远的东西，有更多的渲染，更多的扩散
--want to add to it. 00:05:40,740 --> 00:05:42,100
想添加到它。
--And you see, for example, up in those mountains, those sort of wispy clouds, those are instances 00:05:42,100 --> 00:05:46,980
你看，例如，在那些山上，那些稀疏的云，那些是实例
--of where you want to run a sort of diffusion model through of what the distant images look 00:05:46,980 --> 00:05:53,900
你想在哪里运行一种扩散模型通过远处的图像看起来是什么
--like before you render it. 00:05:53,900 --> 00:05:56,460
就像你渲染它之前一样。
--So lighting, modeling where the light sources are coming from, how they reflect off of scenes, 00:05:56,460 --> 00:06:03,380
所以照明，建模光源来自哪里，它们如何反射场景，
--all of those things are, as you want to add more and more realism to it, you want to make 00:06:03,380 --> 00:06:07,940
所有这些都是，因为你想给它添加越来越多的真实感，你想要
--it look good. 00:06:07,940 --> 00:06:09,260
它看起来不错。
--And also, if you add something like this boy running through the grass, you want to render 00:06:09,260 --> 00:06:16,380
而且，如果你添加像这个男孩跑过草地这样的东西，你想要渲染
--the physical motion of him as he moves that looks somewhat like a real human being would 00:06:16,380 --> 00:06:23,100
他移动时的身体动作看起来有点像真人
--be. 00:06:23,100 --> 00:06:24,100
是。
--And you can also imagine adding features, like if you wanted to have a wind blowing 00:06:24,100 --> 00:06:28,860
你也可以想象添加功能，比如你想要吹风
--or a breeze blowing, that you'd want these blades of grass to be waving. 00:06:28,860 --> 00:06:34,020
或一阵微风吹过，你会希望这些草叶随风飘扬。
--And that becomes, obviously, a huge amount of computation just to create scenes like 00:06:34,020 --> 00:06:40,060
很明显，仅仅为了创建像这样的场景就需要大量的计算
--that. 00:06:40,060 --> 00:06:41,060
那。
--So the more features you add, so the more physics you want to add, the more lifelike 00:06:41,060 --> 00:06:45,100
所以你添加的功能越多，你想要添加的物理越多，就越逼真
--you want it to be. 00:06:45,100 --> 00:06:46,740
你想要它是。
--You have to just keep adding more and more to your computational models. 00:06:46,740 --> 00:06:55,340
你必须不断地向你的计算模型中添加越来越多的东西。
--And again, there's this huge market, not just video games, but some architect wanting to 00:06:55,340 --> 00:07:00,100
再一次，有一个巨大的市场，不仅仅是视频游戏，还有一些建筑师想要
--be able to show clients what the building would look like, the ability to do this and 00:07:00,100 --> 00:07:05,820
能够向客户展示建筑物的外观、执行此操作的能力以及
--have the client be able to sort of move around and view this at different angles. 00:07:05,820 --> 00:07:11,700
让客户能够四处走动并从不同角度查看。
--And again, realism in terms of the effect of clouds in the sky and what that will reflect 00:07:11,700 --> 00:07:18,780
再一次，关于天空中云层的影响及其反映的现实主义
--off the glassy windows and different effects of lighting sources and things just keeps 00:07:18,780 --> 00:07:26,100
关闭玻璃窗和不同的光源效果和东西只是保持
--adding more and more complexity to it. 00:07:26,100 --> 00:07:31,920
给它增加越来越多的复杂性。
--So let's sort of step back a bit and think about, well, what is it that builds up the 00:07:31,920 --> 00:07:39,140
因此，让我们退后一步，思考一下，是什么构建了
--set of steps you need in order to do this graphics display? 00:07:39,140 --> 00:07:44,020
您需要一组步骤才能显示此图形？
--So we'll talk about the entity. 00:07:44,020 --> 00:07:45,380
因此，我们将讨论实体。
--What are the objects that we want to work with or the nouns? 00:07:45,380 --> 00:07:50,260
我们想要使用的对象或名词是什么？
--And so this goes from starting with some object in physical space. 00:07:50,260 --> 00:07:57,620
因此，这是从物理空间中的某个物体开始的。
--And then we'll pick out, we'll assign points to create this triangulation of it. 00:07:57,620 --> 00:08:03,660
然后我们会挑选出来，我们会分配点来创建它的三角剖分。
--We'll create the vertices of that. 00:08:03,660 --> 00:08:06,300
我们将创建它的顶点。
--And then those vertices are connected to form the triangle. 00:08:06,300 --> 00:08:10,020
然后将这些顶点连接起来形成三角形。
--So we have to start with something, in this case, a purely synthetic thing in 3D real 00:08:10,020 --> 00:08:17,340
所以我们必须从一些东西开始，在这种情况下，是 3D 真实中的纯合成事物
--space and then start creating pieces that we can manipulate as geometry. 00:08:17,340 --> 00:08:27,660
空间，然后开始创建我们可以作为几何体操作的片段。
--And then when we look at something, we see the projection of that triangles, which exist 00:08:27,660 --> 00:08:33,620
然后当我们看某样东西时，我们会看到存在的三角形的投影
--in three-dimensional space, onto the three-dimensional space of the viewer. 00:08:33,620 --> 00:08:38,860
在三维空间中，到观看者的三维空间中。
--And in particular, since our screens are composed of discrete pixels, we want to, for each pixel, 00:08:38,860 --> 00:08:45,260
特别是，由于我们的屏幕由离散像素组成，我们希望对于每个像素，
--assign a color value, an RGB value to that pixel. 00:08:45,260 --> 00:08:48,220
为该像素分配一个颜色值，一个 RGB 值。
--So somehow we have to go from this object in three-dimensional space, project it to 00:08:48,220 --> 00:08:55,700
所以我们必须以某种方式从三维空间中的这个对象，将它投影到
--a two-dimensional viewing space, and at times actually combine the values of multiple objects. 00:08:55,700 --> 00:09:03,940
一个二维的观察空间，有时实际上结合了多个对象的值。
--In this case, in this teapot, we could assume that it's an opaque object. 00:09:03,940 --> 00:09:09,100
在这种情况下，在这个茶壶中，我们可以假设它是一个不透明的物体。
--And so we just have to render the triangle that represents the thing closest to the viewer. 00:09:09,100 --> 00:09:14,180
所以我们只需要渲染代表最接近观察者的东西的三角形。
--But as you saw with that example of rendering mist or clouds, you're actually composing 00:09:14,180 --> 00:09:21,660
但是正如您在渲染薄雾或云彩的示例中看到的那样，您实际上是在作曲
--the values of multiple parts in the distance to combine to form what's at any given pixel. 00:09:21,660 --> 00:09:33,100
距离中多个部分的值组合起来形成任何给定像素的值。
--So what operations do we want to perform on these entities then? 00:09:33,100 --> 00:09:37,580
那么我们要对这些实体进行哪些操作呢？
--So imagine that we have a, we're setting up on the right what's called the graphics pipeline, 00:09:37,580 --> 00:09:44,300
所以想象一下，我们有一个，我们在右边设置所谓的图形管道，
--the sort of sequence of processing steps that you go from some notion of a physical object 00:09:44,300 --> 00:09:50,140
从某种物理对象的概念出发的一系列处理步骤
--to a rendered image. 00:09:50,140 --> 00:09:52,620
到渲染图像。
--And so we'll start, in this case, already pretty well along, we're not actually worrying 00:09:52,620 --> 00:09:57,860
所以我们将开始，在这种情况下，已经很顺利了，我们实际上并不担心
--too much about the physics of the modeling of things. 00:09:57,860 --> 00:10:01,860
太多关于事物建模的物理学。
--We're jumping right into, we've got something where we've created a triangular mesh, and 00:10:01,860 --> 00:10:07,780
我们直接进入，我们已经创建了一个三角形网格，并且
--now we're ready to render that. 00:10:07,780 --> 00:10:10,320
现在我们准备渲染它了。
--So imagine that for each point vertex, we have its three coordinates in x, y, and z, 00:10:10,320 --> 00:10:18,140
所以想象一下，对于每个点顶点，我们有它在 x、y 和 z 中的三个坐标，
--and those define then a series of triangles that will represent a list of vertices and 00:10:18,140 --> 00:10:23,920
然后那些定义了一系列三角形，这些三角形将代表顶点列表和
--say every three, group of three of these is a triangle. 00:10:23,920 --> 00:10:32,460
说每三个，其中三个一组是一个三角形。
--And again, those triangles exist in the physical real world, and we want to project them onto 00:10:32,460 --> 00:10:39,660
再一次，那些三角形存在于物理现实世界中，我们想将它们投影到
--a two-dimensional screen as if from the perspective of the viewer or a camera. 00:10:39,660 --> 00:10:45,300
一个二维屏幕，就好像从观众或相机的角度来看。
--So there's sort of a mapping from three-dimensional space projecting onto two-dimensional space. 00:10:45,300 --> 00:10:51,500
所以有一种从三维空间投影到二维空间的映射。
--It depends on the angle and position of the viewer. 00:10:51,500 --> 00:10:58,500
这取决于观察者的角度和位置。
--And then that will generate a series of primitives, in this case, sort of, whoops, I don't know 00:10:58,500 --> 00:11:13,140
然后这将生成一系列基元，在这种情况下，有点，哎呀，我不知道
--why it does this. 00:11:13,140 --> 00:11:15,280
为什么这样做。
--So we'll project our triangles now are sort of gotten flattened into the triangles that 00:11:15,280 --> 00:11:22,720
所以我们将投影我们的三角形现在有点变平成三角形
--will compose the picture itself. 00:11:22,720 --> 00:11:30,340
将自己构图。
--And then within each triangle, since we're turning it into these discrete pixels, that 00:11:30,340 --> 00:11:35,120
然后在每个三角形内，因为我们把它变成这些离散的像素，
--will represent a series of small squares that we have to assign color values to. 00:11:35,120 --> 00:11:44,260
将代表一系列我们必须为其分配颜色值的小方块。
--And then finally, we assign colors. 00:11:44,260 --> 00:11:46,500
最后，我们分配颜色。
--So you notice on the right, we've created this pipeline where each step, we have many 00:11:46,500 --> 00:11:51,700
所以你注意到右边，我们创建了这个管道，每一步，我们都有很多
--objects that we're trying to do some operation on, but you see a natural parallelism in there, 00:11:51,700 --> 00:11:59,260
我们试图对其进行一些操作的对象，但你会在其中看到自然的并行性，
--that each object can be operated on independently. 00:11:59,260 --> 00:12:01,820
每个对象都可以独立操作。
--We start with a bunch of vertices that we do this projective mapping onto. 00:12:01,820 --> 00:12:07,340
我们从一堆顶点开始，在这些顶点上进行投影映射。
--Those are all, for each vertex, it's independent of the other vertices. 00:12:07,340 --> 00:12:11,540
这些都是，对于每个顶点，它独立于其他顶点。
--And one of the things we'll end up doing is figuring out which triangles occlude, what's 00:12:11,540 --> 00:12:21,620
我们最终要做的其中一件事就是弄清楚哪些三角形被遮挡，什么是
--the relative to position in the z dimension, and figure out what gets occluded as a result 00:12:21,620 --> 00:12:29,780
相对于 z 维度中的位置，并找出结果被遮挡的内容
--of that. 00:12:29,780 --> 00:12:31,100
那个。
--And then that drops down. 00:12:31,100 --> 00:12:32,780
然后下降。
--So at first, we're working with vertices, then we're working with triangles, and then 00:12:32,780 --> 00:12:37,460
所以一开始，我们处理顶点，然后我们处理三角形，然后
--we're working with individual squares, which we assemble into pixels. 00:12:37,460 --> 00:12:43,140
我们正在处理单独的正方形，我们将它们组装成像素。
--So our objects keep shifting, and the operations we want to do keep shifting, but this idea 00:12:43,140 --> 00:12:48,900
所以我们的对象一直在移动，我们想要做的操作也在不断移动，但是这个想法
--of we have a bunch of stuff that has this very natural parallelism comes out. 00:12:48,900 --> 00:12:56,620
我们有一堆具有这种非常自然的并行性的东西出来了。
--And so you can imagine then, if we can just make this go fast, then that will at least 00:12:56,620 --> 00:13:03,300
所以你可以想象，如果我们能让这一切进展得更快，那么至少
--get us a long ways to this goal of being able to render graphics at this very high 00:13:03,300 --> 00:13:07,940
使我们能够以如此高的速度渲染图形这一目标还有很长的路要走
--speed. 00:13:07,940 --> 00:13:16,780
速度。
--And so that gives us this pipeline. 00:13:16,780 --> 00:13:19,860
这给了我们这条管道。
--And as I mentioned, you can just keep adding to the kind of features you'd like to build 00:13:19,860 --> 00:13:24,420
正如我提到的，您可以继续添加您想要构建的功能类型
--into this, and you basically add more stages to this pipeline that you might like to do. 00:13:24,420 --> 00:13:30,480
进入这个，你基本上可以向这个管道添加更多你可能想做的阶段。
--So for example, if you just look at the simple issue of light reflecting off of a surface, 00:13:30,480 --> 00:13:36,600
因此，例如，如果您只看光从表面反射的简单问题，
--it's actually an incredibly difficult thing. 00:13:36,600 --> 00:13:39,440
这实际上是一件非常困难的事情。
--You see these different balls here, and for example, this one in the upper left is a very 00:13:39,440 --> 00:13:44,560
你在这里看到这些不同的球，例如，左上角的这个球是非常
--diffuse image. 00:13:44,560 --> 00:13:47,400
漫反射图像。
--It's a very matte finish to that ball, and so there's not much reflection. 00:13:47,400 --> 00:13:51,680
那个球是非常无光泽的，所以没有太多反射。
--It's fairly straightforward. 00:13:51,680 --> 00:13:53,680
这相当简单。
--But even then, you'll see that the curvature of it affects what color you get on different 00:13:53,680 --> 00:13:58,720
但即使那样，你也会看到它的曲率会影响你在不同的地方得到的颜色
--parts of that ball. 00:13:58,720 --> 00:14:00,460
那个球的一部分。
--And then you go to one like this, where it's highly reflective, and you'll actually see 00:14:00,460 --> 00:14:06,380
然后你去一个像这样的地方，它是高度反光的，你会真正看到
--back, if you look closely at that, you'll see the camera that was taking the picture 00:14:06,380 --> 00:14:11,780
回来，如果你仔细看，你会看到正在拍照的相机
--being reflected back, but then also warped appropriately. 00:14:11,780 --> 00:14:17,780
被反射回来，但随后也会适当地扭曲。
--Or something like this, where it's just a simple shape, but still you'll see that reflection, 00:14:17,780 --> 00:14:24,580
或者类似这样的东西，它只是一个简单的形状，但你仍然会看到那个倒影，
--and you'll see the reflection of the, like a mirror image of the viewer, but also at 00:14:24,580 --> 00:14:31,700
你会看到的反射，就像观察者的镜像，但也在
--the top, that little square is the specular reflection of the light source bouncing off. 00:14:31,700 --> 00:14:38,420
顶部，那个小方块是光源反弹的镜面反射。
--So you can appreciate that this is just a series of balls. 00:14:38,420 --> 00:14:45,100
所以你可以理解这只是一系列的球。
--You can imagine more and more involved in what is it we're trying to show. 00:14:45,100 --> 00:14:52,100
你可以想象越来越多的人参与我们试图展示的内容。
--And so there's sort of standard software packages, OpenGL, that let you apply operations, and 00:14:55,180 --> 00:15:07,180
所以有一些标准的软件包，OpenGL，可以让你应用操作，并且
--they're sort of also described in this sense, that you can add parameters to your system. 00:15:07,180 --> 00:15:12,940
它们在某种意义上也被描述为您可以向系统添加参数。
--What is your lighting sources? 00:15:12,940 --> 00:15:15,260
你的光源是什么？
--What are the material properties of these objects that you're trying to add? 00:15:15,260 --> 00:15:19,360
您要添加的这些对象的材料属性是什么？
--And so you keep adding more and more information, and it's the job of the graphics system to 00:15:19,360 --> 00:15:23,540
所以你不断地添加越来越多的信息，这是图形系统的工作
--then use that information appropriately. 00:15:23,540 --> 00:15:27,160
然后适当地使用该信息。
--And as I mentioned, if you look at, and it's kind of interesting, I'm not a graphics expert 00:15:27,160 --> 00:15:33,000
正如我提到的，如果你看，这很有趣，我不是图形专家
--at all, but when you start to look at things, and you start to look at detail, it makes 00:15:33,000 --> 00:15:37,480
一点都不 但当你开始审视事物，开始审视细节时，
--you really appreciate the sort of subtlety of things. 00:15:37,480 --> 00:15:40,520
你真的很欣赏事物的微妙之处。
--So for example, the statue in the middle of something like marble, the light doesn't reflect 00:15:40,520 --> 00:15:49,160
因此，例如，在大理石之类的东西中间的雕像，光线不会反射
--just off the surface of it, it goes partway into the surface and then reflects back. 00:15:49,260 --> 00:15:53,980
就在它的表面之外，它部分进入表面然后反射回来。
--And it also is partially translucent, so you get light shining through the object as well, 00:15:53,980 --> 00:15:59,820
而且它也是部分半透明的，所以你也可以通过物体照射光线，
--the thinner parts of it. 00:15:59,820 --> 00:16:02,100
它的较薄部分。
--Something that's highly reflective, you know, metal, has this mirror effect that then you 00:16:02,100 --> 00:16:07,780
高度反光的东西，你知道，金属，有这种镜面效果，然后你
--have to, in principle, sort of figure out to render that properly, you have to then 00:16:07,780 --> 00:16:14,860
原则上必须弄清楚如何正确渲染它，然后你必须
--sort of go backwards and find all the information that was caught in that reflection. 00:16:15,040 --> 00:16:22,040
有点倒退并找到该反射中捕获的所有信息。
--Natural things like skin is even more difficult, and materials such as leather adds a lot more 00:16:25,600 --> 00:16:32,600
皮肤这种天然的东西就更难了，皮革这样的材料就加分不少
--complexity to it too. 00:16:34,240 --> 00:16:36,920
它也很复杂。
--But there's certain tricks that we can play. 00:16:36,920 --> 00:16:38,920
但是我们可以玩一些技巧。
--For example, this tablecloth, there's a sort of uniform pattern, and so there's something 00:16:38,920 --> 00:16:44,640
比如这个桌布，有一种统一的图案，所以有一些东西
--called texture mapping, where at relatively low cost effort, you can sort of take some 00:16:44,660 --> 00:16:51,380
称为纹理映射，在这种情况下，您可以以相对较低的成本进行一些
--uniform pattern and project it onto a surface of an object like this. 00:16:51,380 --> 00:16:58,380
均匀的图案并将其投影到这样的物体表面上。
--And so that's something that's very commonly done, and it's kind of a cheap way to create 00:16:58,580 --> 00:17:04,420
所以这是很常见的事情，这是一种廉价的创造方式
--the illusion of complex patterns, even though it's done in a not very fancy way. 00:17:04,420 --> 00:17:11,420
复杂模式的错觉，即使它是以一种不太花哨的方式完成的。
--And so this kind of demonstrates that you don't want to just lock all this pipeline 00:17:14,980 --> 00:17:21,980
所以这表明你不想只锁定所有这些管道
--into hardware, because every time you add features or consider new features, you might 00:17:24,620 --> 00:17:29,420
进入硬件，因为每次添加功能或考虑新功能时，您可能
--want to add some sort of software functionality that describes what steps you want to take. 00:17:29,420 --> 00:17:36,420
想要添加某种描述您要采取的步骤的软件功能。
--Did that just happen? 00:17:37,020 --> 00:17:44,020
那是刚刚发生的吗？
--Pug and unpug. 00:17:44,640 --> 00:17:51,640
哈巴狗和 unpug。
--Good. 00:18:07,980 --> 00:18:09,340
好的。
--So you can see by these pictures that we keep wanting to add little pieces of code, 00:18:09,340 --> 00:18:16,340
所以你可以从这些图片中看出我们一直想添加一些小代码，
--like a shader, is something that after you've created these fragments, something like I 00:18:17,000 --> 00:18:23,520
就像一个着色器，是在你创建了这些片段之后，就像我
--mentioned, the diffusion effect of those clouds, you don't have to actually model the physics 00:18:23,520 --> 00:18:30,360
提到，那些云的扩散效应，你不必实际模拟物理
--of light, you can kind of just cheat. 00:18:30,360 --> 00:18:32,080
的光，你可以有点作弊。
--You can say, well, any pixel in the distance, I just want to now change its color so that 00:18:32,080 --> 00:18:39,080
你可以说，好吧，远处的任何像素，我现在只想改变它的颜色，这样
--or adjust its color a little bit to reflect the fact of it coming through. 00:18:39,360 --> 00:18:46,360
或者稍微调整它的颜色以反映它通过的事实。
--Or it's a relatively local processing of that particular pixel. 00:18:46,480 --> 00:18:52,280
或者它是对该特定像素的相对局部处理。
--Other things require much more, like I said, to do reflection properly, you have to actually 00:18:52,280 --> 00:18:56,600
其他事情需要更多，就像我说的，要正确地进行反思，你实际上必须
--do what's called ray tracing, which is you keep bouncing, you sort of work your way backward 00:18:56,600 --> 00:19:01,600
做所谓的光线追踪，就是你不断弹跳，你有点向后工作
--what a beam of light would be doing as it goes back and forth between objects back to 00:19:01,600 --> 00:19:07,320
当一束光在物体之间来回返回时会做什么
--its original light source. 00:19:07,340 --> 00:19:10,580
它的原始光源。
--That's a much more involved thing. 00:19:10,580 --> 00:19:13,060
这是一个更复杂的事情。
--But the point being that graphics is just a great example of a place where you want 00:19:13,060 --> 00:19:17,820
但关键是图形只是你想要的地方的一个很好的例子
--it, you have natural parallelism, you want it to run fast, but you want to have some 00:19:17,820 --> 00:19:22,620
它，你有自然的并行性，你希望它运行得快，但你想要一些
--programmability to it as well. 00:19:22,620 --> 00:19:29,620
对它的可编程性。
--So, something like a shader, and we won't look too much about the code, but the point 00:19:38,320 --> 00:19:45,320
所以，像着色器这样的东西，我们不会过多地关注代码，但要点
--is you want to be able to write these little pieces of code that will modify the pixel 00:19:45,340 --> 00:19:51,700
你想写这些修改像素的小代码吗
--values according to some algorithm that reflects what particular property you're trying to 00:19:51,700 --> 00:19:57,700
根据某种算法的值，该算法反映了您要尝试的特定属性
--impart on it. 00:19:57,700 --> 00:20:03,020
传授给它。
--And you'll notice it looks not unlike ISPC, there's uniform, varying, so things that are 00:20:03,020 --> 00:20:08,820
你会注意到它看起来与 ISPC 没有什么不同，有统一的，变化的，所以东西
--global, others that vary with particular points in the image. 00:20:08,820 --> 00:20:15,400
全局的，其他的随图像中的特定点而变化。
--And code that looks vaguely like C that's performing some operation on how do I want 00:20:15,400 --> 00:20:20,320
代码看起来有点像 C，它正在对我想要的方式执行一些操作
--to modify this particular local value to implement some particular feature. 00:20:20,320 --> 00:20:27,320
修改这个特定的本地值以实现某些特定功能。
--And this is an example of the idea of what I said, texture mapping, that you take some 00:20:28,320 --> 00:20:32,980
这是我所说的想法的一个例子，纹理映射，你需要一些
--regular pattern and you map it onto the surface of some object like this creature or the ground 00:20:32,980 --> 00:20:39,980
规则图案，然后将其映射到某些物体的表面，例如这个生物或地面
--that he or she is on to create this sort of more complex images, but done in a very, it's 00:20:41,820 --> 00:20:48,820
他或她正在创造这种更复杂的图像，但以非常、它的方式完成
--a relatively straightforward operation compared to sort of real physical modeling. 00:20:49,680 --> 00:20:56,680
与某种真实的物理建模相比，这是一种相对简单的操作。
--So you know, of course, from before that historically this kind of work was done just with regular 00:20:58,600 --> 00:21:04,360
所以你当然知道，从历史上看，这种工作只是定期完成的
--CPUs, and somehow we ran out of steam in 2004 to make a single CPU go faster, but still 00:21:04,360 --> 00:21:11,360
CPU，不知何故，我们在 2004 年失去了动力，无法让单个 CPU 运行得更快，但仍然
--maintained the ability to have a lot of transistors on a chip. 00:21:12,360 --> 00:21:17,660
保持了在芯片上拥有大量晶体管的能力。
--So the GPU sort of arose out of that recognition that we can make a lot of processing elements, 00:21:17,660 --> 00:21:23,900
所以 GPU 的产生源于我们可以制造很多处理元素的认识，
--it's just we can't have one monolithic processor that just executes a single conventional instruction 00:21:23,900 --> 00:21:30,900
只是我们不能拥有一个只执行一条常规指令的单片处理器
--stream and keep making that go faster. 00:21:30,940 --> 00:21:37,940
流式传输并继续加快速度。
--So, people, their early GPUs were designed really just purely to implement that graphic 00:21:38,940 --> 00:21:45,360
所以，人们，他们早期的 GPU 的设计真的只是为了实现该图形
--pipeline, and they were programmable but only in a very constrained way that had direct 00:21:45,360 --> 00:21:50,880
流水线，它们是可编程的，但只能以一种非常受限的方式直接
--relation to operations one would do in graphics, so they were programmable but specialized 00:21:50,880 --> 00:21:57,360
与人们在图形中所做的操作有关，因此它们是可编程的但专门
--pieces of hardware. 00:21:57,360 --> 00:22:00,280
五金件。
--And so some clever people recognized that, hey, this thing seems to be able to do a lot 00:22:00,280 --> 00:22:06,080
所以一些聪明的人意识到，嘿，这东西似乎能做很多事情
--and if I can sort of stand on my head, I can cast a lot of classic computational problems 00:22:06,100 --> 00:22:12,420
如果我能倒立，我就能解决很多经典的计算问题
--into things that would be called graphics operations. 00:22:12,420 --> 00:22:15,660
进入被称为图形操作的东西。
--So the first thing they do is say, okay, I can only work with triangles, well I can cover 00:22:15,660 --> 00:22:20,180
所以他们做的第一件事就是说，好吧，我只能处理三角形，我可以覆盖
--any square with two triangles, so now I've got that taken care of. 00:22:20,180 --> 00:22:26,700
任何带有两个三角形的正方形，所以现在我已经处理好了。
--And I can sort of create arrays of certain sizes and pretend that the values on that 00:22:26,700 --> 00:22:33,700
我可以创建特定大小的数组并假装上面的值
--are actually numbers, because they are, that I want to perform certain operations on. 00:22:34,700 --> 00:22:41,700
实际上是数字，因为它们是我要对其执行某些操作的数字。
--And so there was quite a bit of work, and this is now over 15 years ago, but taking 00:22:43,360 --> 00:22:50,360
所以有相当多的工作，现在已经是 15 多年前的事了，但是采取
--these GPUs, these new, very specialized computational devices, and showing that they could solve 00:22:51,040 --> 00:22:57,000
这些 GPU，这些新的、非常专业的计算设备，并表明它们可以解决
--interesting scientific problems, they could do sort of scientific simulation operations, 00:22:57,000 --> 00:23:03,460
有趣的科学问题，他们可以做一些科学模拟操作，
--you could implement the ray tracing, which is what I mentioned, was this one of sort 00:23:03,460 --> 00:23:08,280
你可以实现光线追踪，这就是我提到的，这是一种
--of working backward to the light source, that was not supported directly in the early GPUs, 00:23:08,280 --> 00:23:14,540
逆向处理光源，这在早期的 GPU 中是不直接支持的，
--but they figured out how to sort of fake it and turn it into other types of graphic operations 00:23:14,540 --> 00:23:19,360
但他们想出了如何伪造它并将其变成其他类型的图形操作
--and do ray tracing. 00:23:19,360 --> 00:23:26,360
并进行光线追踪。
--And then there was a project at Stanford, a graduate student, who sort of created a, 00:23:26,580 --> 00:23:33,580
然后在斯坦福大学有一个项目，一个研究生，他创建了一个，
--sort of started this transition of a language where the idea of it is what they refer to 00:23:35,420 --> 00:23:41,060
某种程度上开始了一种语言的转变，其中它的概念就是他们所指的
--as a kernel. So the idea of a kernel is some computation you perform at every point in 00:23:41,060 --> 00:23:46,500
作为内核。所以内核的概念是你在每个点执行的一些计算
--space, whether that point is like on a grid or it's a point like all the vertices you're 00:23:46,500 --> 00:23:52,540
空间，无论那个点是像在网格上还是像你所有的顶点一样
--operating on, or some set of objects that operate in parallel. And this idea is well 00:23:52,540 --> 00:23:58,740
操作，或一组并行操作的对象。这个想法很好
--known and understood in the world of computer graphics and image processing for a long time, 00:23:58,740 --> 00:24:04,820
长期以来在计算机图形学和图像处理领域广为人知，
--but to sort of step that up and make that a whole programming model. 00:24:04,820 --> 00:24:10,100
但是要加强它并使它成为一个完整的编程模型。
--And this particular work had this language, which then was converted to OpenGL, which 00:24:10,100 --> 00:24:14,820
这个特殊的作品有这种语言，然后被转换成 OpenGL，
--is the standard library for graphics, but that sort of became the basis of this language 00:24:14,820 --> 00:24:21,580
是图形的标准库，但那种成为了这种语言的基础
--CUDA, which is the one that we'll be using in our assignment. 00:24:21,580 --> 00:24:26,860
CUDA，这是我们将在作业中使用的工具。
--So let's talk a little about this idea that imagine that we can express a program in terms 00:24:26,860 --> 00:24:32,880
所以让我们谈谈这个想法，想象一下我们可以用术语来表达一个程序
--of a set of very data parallel style, an operation we perform on many elements of, say, a vector 00:24:32,880 --> 00:24:39,320
一组非常数据并行的风格，我们对许多元素执行的操作，比如说，一个向量
--or matrix. And let's imagine now, if we had that kind of code, how we would run it fast 00:24:39,320 --> 00:24:46,320
或矩阵。现在让我们想象一下，如果我们有那种代码，我们将如何快速运行它
--on hardware of the style we described. 00:24:46,320 --> 00:24:51,320
在我们描述的样式的硬件上。
--So if you go back now to a conventional multi-core CPU, you see that there's just a lot of the 00:24:51,320 --> 00:25:03,200
所以如果你现在回到传统的多核 CPU，你会发现有很多
--operating system, which is software, of course, is very much in control over how this thing 00:25:03,200 --> 00:25:09,880
操作系统，也就是软件，当然，在很大程度上控制着这个东西
--sequences. And that will limit how fast you can do it. If you have software doing the 00:25:09,880 --> 00:25:14,080
序列。这将限制您的速度。如果你有软件做
--scheduling, you can't do things very fast. 00:25:14,080 --> 00:25:18,960
日程安排，你不能很快地做事。
--But if you think about, then, how a conventional operating system maps code onto a multi-core 00:25:18,960 --> 00:25:24,800
但是如果你想一想，传统的操作系统是如何将代码映射到多核的
--CPU, it's in control of the scheduling. So it has to schedule to load the program into 00:25:24,800 --> 00:25:32,200
CPU，它控制着调度。所以它必须安排将程序加载到
--memory. It has to select which of the multi-core processors will actually execute this, because 00:25:32,200 --> 00:25:43,080
记忆。它必须选择哪个多核处理器将实际执行它，因为
--they all share the memory. So the first step is independent. 00:25:43,080 --> 00:25:46,880
他们都共享记忆。所以第一步是独立的。
--It will usually use some interrupt mechanism so that it can keep changing what process 00:25:46,880 --> 00:25:53,960
它通常会使用一些中断机制，以便它可以不断改变什么进程
--is running on any given processor, both as a way to kind of let it do multiple things 00:25:53,960 --> 00:26:01,560
在任何给定的处理器上运行，既是一种让它做多种事情的方式
--and also to support operations like I.O. or memory, virtual memory operations, where there 00:26:01,560 --> 00:26:10,560
并且还支持诸如 IO 或内存、虚拟内存操作之类的操作，其中
--might be a long pause in the program execution. 00:26:10,560 --> 00:26:14,380
可能是程序执行中的长时间停顿。
--So anyways, there's a lot of operating system. It's a relatively heavyweight process. Even 00:26:14,380 --> 00:26:20,600
所以无论如何，有很多操作系统。这是一个相对重量级的过程。甚至
--switching the context of a P-thread, you're talking tens of thousands of clock cycles 00:26:20,600 --> 00:26:25,700
切换 P 线程的上下文，你说的是数万个时钟周期
--to do it. Well, not tens of thousands, but 10 to 20,000 is a typical number. 00:26:25,700 --> 00:26:30,840
去做吧。好吧，不是数万，而是 10 到 20,000 是一个典型的数字。
--So that can be done fast. I mean, we're talking maybe a few nanoseconds, but still not a few 00:26:30,840 --> 00:26:39,720
这样可以快速完成。我的意思是，我们说的可能是几纳秒，但仍然不少
--microseconds. But that's still way too much overhead to do highly efficient use of these 00:26:39,720 --> 00:26:47,120
微秒。但这仍然是太多的开销来高效地使用这些
--in a single program. 00:26:47,120 --> 00:26:57,640
在一个程序中。
--So as I mentioned, there were these GPU chips that directly supported this graphic pipeline. 00:26:57,640 --> 00:27:05,660
所以正如我提到的，有这些 GPU 芯片直接支持这个图形管道。
--And so you'd basically load up this GPU with all the configuration information necessary 00:27:05,660 --> 00:27:11,700
所以你基本上会用所有必要的配置信息加载这个 GPU
--to describe what each stage should be. And then you said, go, and it would start the 00:27:11,700 --> 00:27:17,660
描述每个阶段应该是什么。然后你说，去吧，它会开始
--pipeline going. But it was not viewed as something that you'd do very often. You'd pretty much 00:27:17,660 --> 00:27:25,500
管道进行。但它不被视为您经常做的事情。你差不多
--get the system configured, and then you'd let it run. 00:27:25,500 --> 00:27:36,500
配置系统，然后让它运行。
--So now, the newer versions of it then took this idea of the GPU. There was a few demonstrations 00:27:36,500 --> 00:27:45,700
所以现在，它的新版本采用了 GPU 的理念。有几次示威
--that this was a more general purpose computational model than pure graphics, and started adapting 00:27:45,700 --> 00:27:51,740
这是一个比纯图形更通用的计算模型，并开始适应
--the hardware and the language so that it could support non-graphics applications. 00:27:51,740 --> 00:28:01,180
硬件和语言，以便它可以支持非图形应用程序。
--But the thing we have to see is somehow this has to be done in a way that the OS doesn't 00:28:01,180 --> 00:28:06,660
但我们必须看到的是，这必须以某种操作系统无法做到的方式来完成
--get involved in the low-level scheduling decisions, because it's just not going to run fast enough. 00:28:06,660 --> 00:28:11,780
参与低级调度决策，因为它的运行速度不够快。
--So we have a lot of raw hardware capability, but somehow we have to do it in a way that 00:28:11,780 --> 00:28:17,140
所以我们有很多原始硬件功能，但我们必须以某种方式做到这一点
--the hardware is actually in control of how things operate and how things get scheduled. 00:28:17,140 --> 00:28:24,780
硬件实际上控制着事物的运行方式和调度方式。
--But the overall model is not unlike what we said before, that the GPU is called the device, 00:28:24,780 --> 00:28:36,380
但是整体的模型和我们之前说的没有什么不同，就是GPU叫做device，
--and it's connected to a CPU, which is called the host. And so even now in programs, you 00:28:36,380 --> 00:28:46,260
它连接到一个称为主机的 CPU。所以即使现在在程序中，你
--are actually writing code, some of which runs on the device GPU, some of which runs 00:28:46,260 --> 00:28:51,460
实际上是在编写代码，其中一些代码运行在设备 GPU 上，一些代码运行
--on the host. And you're setting up an exchange between them, where typically the host will 00:28:51,460 --> 00:28:58,260
在主机上。你正在他们之间建立一个交换，通常主机会
--copy some data into the memory of the GPU. It will then load some code for the GPU that 00:28:58,260 --> 00:29:09,820
将一些数据复制到 GPU 的内存中。然后它将为 GPU 加载一些代码
--it's going to execute, and then it will send a signal that says, go. And the GPU will go, 00:29:09,820 --> 00:29:15,620
它会执行，然后它会发送一个信号，说，走。 GPU 会去，
--and after it's done, it will come back and say, OK, I'm done. So there's still this going 00:29:15,620 --> 00:29:20,120
完成后，它会回来说，好的，我完成了。所以还有这件事
--back and forth between the CPU and GPU model, but it's a more general capability than just 00:29:20,120 --> 00:29:27,220
在 CPU 和 GPU 模型之间来回切换，但它是一种更通用的功能，而不仅仅是
--a single graphics pipeline. 00:29:27,220 --> 00:29:32,740
单个图形管道。
--So this language called CUDA was introduced now about 10 years ago by NVIDIA. And it looks, 00:29:32,740 --> 00:29:42,140
所以这种叫做 CUDA 的语言是大约 10 年前由 NVIDIA 推出的。而且看起来，
--when you program in it, you sort of vaguely think that you're programming in C or C++, 00:29:42,140 --> 00:29:48,020
当你在其中编程时，你会模糊地认为你是在用 C 或 C++ 编程，
--but you're not, because you're describing this very data parallel computation to be 00:29:48,020 --> 00:29:54,820
但你不是，因为你将这种数据并行计算描述为
--done. And one thing that CUDA does, it does a nice job of giving you this sort of fairly 00:29:54,820 --> 00:30:01,460
完毕。 CUDA 所做的一件事是，它很好地为您提供了这种公平的
--high-level abstract model that you can start with, and then giving you enough hooks into 00:30:01,460 --> 00:30:07,580
您可以从高级抽象模型开始，然后为您提供足够的钩子
--some of the inner workings of the GPU that you can adapt it and do performance optimizations, 00:30:07,580 --> 00:30:15,220
GPU 的一些内部工作原理，您可以对其进行调整并进行性能优化，
--which you have to do to get decent performance. But you can kind of do that incrementally. 00:30:15,220 --> 00:30:19,540
您必须这样做才能获得不错的性能。但你可以逐步做到这一点。
--You can see, where am I spending my time? How do I need to do it? And always going back, 00:30:19,540 --> 00:30:25,100
你可以看到，我把时间花在哪里了？我需要怎么做？总是回去，
--I always like to say it's useful in software development to have sort of the golden functional 00:30:25,100 --> 00:30:31,220
我总是喜欢说在软件开发中拥有某种黄金功能是很有用的
--model that might be slow, but it captures what you're certain is a functionality. And 00:30:31,220 --> 00:30:36,180
模型可能很慢，但它捕获了您确定的功能。和
--then you keep refining that and tuning it, but you can always do comparisons between 00:30:36,180 --> 00:30:42,220
然后你不断完善和调整它，但你总是可以在两者之间进行比较
--the two to make sure you're still getting the correct values. So CUDA has these features, 00:30:42,220 --> 00:30:51,940
两者以确保您仍然获得正确的值。所以CUDA有这些特点，
--and CUDA keeps changing, by the way, as they keep changing some of the architectural features 00:30:51,940 --> 00:30:56,780
顺便说一下，CUDA 不断变化，因为它们不断改变一些架构特性
--of these GPUs. So that's one frustrating thing about it. There's not very good compatibility 00:30:56,780 --> 00:31:01,780
这些 GPU。所以这是一件令人沮丧的事情。兼容性不是很好
--from year to year on this. There's an open-source version, they call it OpenCL, that looks a 00:31:01,780 --> 00:31:09,700
年复一年。有一个开源版本，他们称之为 OpenCL，看起来像
--lot like CUDA. And in general, if you look across all the courses we teach at CMU, we 00:31:09,700 --> 00:31:17,460
很像CUDA。一般来说，如果你看看我们在 CMU 教授的所有课程，我们
--tend to favor things that are more open-source, open-standard, non-proprietary, because, well, 00:31:17,460 --> 00:31:25,060
倾向于支持更开源、开放标准、非专有的东西，因为，好吧，
--we don't want to be sort of the lapdog for any particular company. But this is one case, 00:31:25,060 --> 00:31:31,300
我们不想成为任何特定公司的哈巴狗。但这是一个案例，
--one instance where the proprietary version really is significantly better than the open-source 00:31:31,860 --> 00:31:36,660
一个专有版本确实比开源版本好得多的例子
--version, and in some ways more widely used. So we stick with this proprietary version. 00:31:36,660 --> 00:31:50,140
版本，并在某些方面得到更广泛的应用。所以我们坚持使用这个专有版本。
--So what I'll talk about today, then, is a little what CUDA looks like, how it's actually 00:31:50,140 --> 00:31:55,820
所以我今天要谈的是 CUDA 的一些外观，它实际上是怎样的
--mapped onto GPUs, and go into enough details about the GPU architecture that you appreciate 00:31:55,820 --> 00:32:01,500
映射到 GPU 上，并详细介绍您喜欢的 GPU 架构
--some of the features you start using. So one thing you could think in your mind, and we'll 00:32:01,500 --> 00:32:08,220
您开始使用的一些功能。所以你可以在脑海中想到一件事，我们会
--come back at the end, is it a data parallel programming model? I won't give my answers 00:32:08,220 --> 00:32:14,860
最后回来，是数据并行编程模型吗？我不会给出我的答案
--to this, but we'll come back to it. Is it based on a shared address space or a message 00:32:14,860 --> 00:32:20,260
到这个，但我们会回到它。它是基于共享地址空间还是消息
--passing model? You know, the two main ways we've said of looking at parallel programming. 00:32:20,260 --> 00:32:26,420
通过模型？您知道，我们所说的两种主要方式来看待并行编程。
--And how do you relate what some of the primitives you saw in ISPC, both instances and tasks, 00:32:26,420 --> 00:32:34,180
你如何关联你在 ISPC 中看到的一些原语，包括实例和任务，
--to how CUDA works? And what about a more conventional CPU thread model? 00:32:34,180 --> 00:32:46,720
 CUDA 是如何工作的？那么更传统的 CPU 线程模型呢？
--So one thing that's really frustrating, and this is just generally true, you'll see a 00:32:46,720 --> 00:32:52,000
所以有一件事真的很令人沮丧，这通常是真的，你会看到
--lot of terms that get used in one context that mean something fairly different than 00:32:52,000 --> 00:32:57,160
在一种上下文中使用的许多术语的含义与
--another. And one of them in particular is the notion of thread. So you've got an image 00:32:57,160 --> 00:33:02,800
其他。其中一个特别是线程的概念。所以你有一个图像
--and thread of P threads, which are, each is a very independent thread of execution of 00:33:02,800 --> 00:33:09,880
和 P 个线程的线程，每个线程都是一个非常独立的执行线程
--a program. So it has its own control. It can have its own data associated with it. It runs 00:33:09,880 --> 00:33:15,740
一个程序。所以它有自己的控制权。它可以有自己的关联数据。它运行
--very independently of the other threads. There's ways for those threads to synchronize 00:33:15,740 --> 00:33:20,380
非常独立于其他线程。这些线程有办法同步
--with each other, but in general, there's no particular linkage of one to another. A CUDA 00:33:20,380 --> 00:33:29,420
彼此之间，但总的来说，彼此之间没有特定的联系。一个CUDA
--thread is much different than that. It looks more like a, well, it doesn't look like anything 00:33:29,420 --> 00:33:35,820
线程与此有很大不同。它看起来更像是一个，好吧，它看起来不像任何东西
--like it. It is a thread of execution of a program on data, but the multiple threads 00:33:35,820 --> 00:33:43,180
喜欢它。它是对数据执行程序的一个线程，但是多个线程
--that are executed by CUDA are much more strongly coupled together and much more limited in 00:33:43,180 --> 00:33:48,820
由 CUDA 执行的程序更紧密地耦合在一起，并且在
--what forms of interactions are possible. So that said, for most of the rest of today, 00:33:48,820 --> 00:34:00,140
什么形式的互动是可能的。也就是说，在今天剩下的大部分时间里，
--when we use thread, I mean CUDA threads, not P threads. So just keep that in mind. So in 00:34:00,140 --> 00:34:07,700
当我们使用线程时，我指的是 CUDA 线程，而不是 P 线程。所以请记住这一点。所以在
--particular, this is a, at the high level, it is a data parallel model. So a thread is 00:34:07,700 --> 00:34:12,460
特别是，在高层，这是一个数据并行模型。所以一个线程是
--just the execution of a program on some particular element of a larger set of data. And so in 00:34:12,460 --> 00:34:22,380
只是在更大数据集的某个特定元素上执行程序。所以在
--CUDA terminology, they actually support a sort of up to three dimensional vector matrix 00:34:22,380 --> 00:34:30,740
CUDA 术语，它们实际上支持一种高达三维的向量矩阵
--represent, array representation of the data and give you fairly direct support for that. 00:34:30,740 --> 00:34:37,020
表示，数据的数组表示，并为您提供相当直接的支持。
--And that's actually more of an illusion than anything built into hardware. So if you look 00:34:37,020 --> 00:34:42,380
这实际上比硬件内置的任何东西更像是一种幻觉。所以如果你看
--at this code, for example, imagine I have a matrix with 12 columns and six rows. So, 00:34:42,380 --> 00:34:53,980
例如，在这段代码中，假设我有一个包含 12 列和 6 行的矩阵。所以，
--and I want to do operations on it. So what I can do is partition that into blocks where 00:34:53,980 --> 00:35:04,420
我想对其进行操作。所以我能做的就是把它分成块
--each block is four columns wide and three rows high. So my 12 by six matrix, I'll divide 00:35:04,420 --> 00:35:15,980
每个块有四列宽和三行高。所以我的 12 x 6 矩阵，我将除以
--into six of these blocks. And so there is a, in CUDA terminology, when you, you'll see 00:35:15,980 --> 00:35:27,580
分成六个这样的块。所以有一个，在 CUDA 术语中，当你，你会看到
--what we do is what we want to do is add two matrices A and B of this particular size and 00:35:27,580 --> 00:35:36,780
我们所做的就是我们想要做的是将两个具有这种特定大小的矩阵 A 和 B 相加，并且
--store the results in C. And so you'll see that the way we do it is we sort of set up 00:35:36,780 --> 00:35:43,420
将结果存储在 C 中。所以你会看到我们这样做的方式是我们设置
--some control parameters here and then we do what's called a thread launch. And that's 00:35:43,420 --> 00:35:49,340
一些控制参数，然后我们执行所谓的线程启动。那就是
--when you see these triple angle brackets here, that's what's going on, that we're, this is 00:35:49,340 --> 00:35:56,300
当你在这里看到这些三重尖括号时，这就是发生的事情，我们是，这是
--host code, so it's running on the CPU. But we're going to do a launch, which is basically 00:35:56,300 --> 00:36:02,260
主机代码，所以它在 CPU 上运行。但我们要做一次发射，基本上是
--telling the device, okay, go start executing something. And there's a particular program, 00:36:02,260 --> 00:36:12,860
告诉设备，好的，开始执行一些事情。还有一个特定的程序，
--which you'll see is extremely simple, that is used to add A and B. But at the high level, 00:36:12,860 --> 00:36:19,900
您会看到它非常简单，用于添加 A 和 B。但是在较高级别，
--all this stuff up ahead is just configuring this block structure. It's saying for each 00:36:19,900 --> 00:36:29,740
所有这些前面的东西只是配置这个块结构。它说的是每个
--block will be four wide and three high, and those are called threads. But it's each element 00:36:29,740 --> 00:36:37,660
块将是四宽三高，这些被称为线程。但它是每个元素
--of this matrix addition will be done by a separate CUDA thread. And then we will need 00:36:37,660 --> 00:36:43,300
此矩阵加法的一部分将由单独的 CUDA 线程完成。然后我们需要
--enough blocks so that we have N divided by the X dimension of threads per block, which 00:36:43,300 --> 00:36:52,540
足够的块，以便我们将 N 除以每个块的线程的 X 维度，这
--is four, and Y divided by the number of threads in the Y direction. So there's sort of a already 00:36:52,540 --> 00:37:01,140
为四，并且 Y 除以 Y 方向上的线程数。所以已经有点
--built in notion of multidimensional array based on the same idea you've seen in 213, 00:37:01,140 --> 00:37:08,980
基于您在 213 中看到的相同想法内置多维数组的概念，
--a row major order. So anyways, the point is that at some level we've given this operation 00:37:08,980 --> 00:37:20,140
一排大订单。所以无论如何，关键是在某种程度上我们已经给出了这个操作
--that says go, but we've imposed this sort of hierarchical block structure on it from 00:37:20,140 --> 00:37:26,940
那说去吧，但我们从
--the outset. And let's just look at this code here that is what's called the kernel code. 00:37:26,940 --> 00:37:41,540
一开始。让我们看看这里的代码，也就是所谓的内核代码。
--So the kernel code is what the GPU executes, and it's based on this model that we saw from 00:37:41,540 --> 00:37:48,420
所以内核代码是 GPU 执行的，它基于我们从中看到的这个模型
--graphics of saying I just imagine I'm one element, you know, element I comma J of a 00:37:48,420 --> 00:37:54,980
说我只是想象我是一个元素的图形，你知道，元素 I 逗号 J of a
--matrix, and I just want to add A sub IJ with B sub IJ and store that in C, except that I've 00:37:55,060 --> 00:38:02,860
矩阵，我只想将 A sub IJ 与 B sub IJ 相加并将其存储在 C 中，除了我已经
--got my I's and J's flipped. So the kernel you see is extremely simple. It just says, 00:38:02,860 --> 00:38:09,220
我的 I 和 J 翻转了。所以你看到的内核极其简单。它只是说，
--okay, in this case especially for element J comma I, just do the pointwise addition. 00:38:09,220 --> 00:38:17,260
好的，在这种情况下，特别是对于元素 J 逗号 I，只需进行逐点加法即可。
--And you see that this part here of where I get I and J, why I do it by decoding this sort of 00:38:17,260 --> 00:38:29,100
你看到我得到 I 和 J 的这一部分，为什么我通过解码这种
--standard notation here that again is supported directly by CUDA. It has for every, in each 00:38:29,100 --> 00:38:41,340
这里的标准符号再次由 CUDA 直接支持。它有每个，在每个
--dimension, in this case the X and Y dimension, it says there's some block dimension. How, 00:38:41,340 --> 00:38:46,700
维度，在本例中是 X 和 Y 维度，它表示存在一些块维度。如何，
--wide is a block in this case, which is four, times that's a block dimension. And then the 00:38:47,380 --> 00:38:54,980
 wide 在这种情况下是一个块，它是块尺寸的四倍。然后是
--block index is assigned by CUDA for each of these, each of these blocks. You see the numbering scheme 00:38:54,980 --> 00:39:07,460
块索引由 CUDA 为每个块分配。您会看到编号方案
--there. Block is a pair, an X dimension, a value, and a Y dimension value. So those are, when the, 00:39:07,460 --> 00:39:17,420
那里。块是一对，一个 X 维度，一个值，一个 Y 维度值。所以那些是，当，
--when the kernel starts, it's referring to its particular, this is one thread out of many for 00:39:17,420 --> 00:39:29,940
当内核启动时，它指的是它的特殊性，这是许多线程中的一个
--the block, and this block is one block of many blocks. So you can recover, the program can 00:39:29,940 --> 00:39:36,140
块，这个块是许多块中的一个块。所以你可以恢复，程序可以
--recover this information and pass to it what is the actual array elements that are being operated 00:39:36,140 --> 00:39:43,300
恢复此信息并将正在操作的实际数组元素传递给它
--on. One thing you'll see is this keyword underscore, underscore, global underscore, 00:39:43,300 --> 00:39:49,540
在。你会看到的一件事是这个关键字 underscore, underscore, global underscore,
--underscore. In one file, you'll have code that runs on both the host and the device. And the 00:39:49,540 --> 00:39:55,180
下划线。在一个文件中，您将拥有在主机和设备上运行的代码。和
--way you distinguish it is the kernels are the ones with these prefixed with its global 00:39:55,180 --> 00:40:00,580
你区分它的方式是内核是那些以其全局为前缀的内核
--declaration. So this is a complete program, almost, that would run this matrix addition. And you see 00:40:00,580 --> 00:40:10,740
宣言。所以这是一个完整的程序，几乎可以运行这个矩阵加法。你看
--for something like that, it's of course a very simple program. Anyone have any questions or 00:40:10,740 --> 00:40:16,020
对于类似的东西，它当然是一个非常简单的程序。任何人有任何问题或
--observations about this? Yeah. Yes, down here. Right. So we'll see it, but the basic idea is a 00:40:16,020 --> 00:40:40,340
对此的观察？是的。是的，在下面。正确的。所以我们会看到它，但基本的想法是
--block can't be too big in terms of the total number of elements. I think the max is 1024. 00:40:40,380 --> 00:40:45,740
就元素总数而言，块不能太大。我认为最大值是 1024。
--And we'll see that each block gets mapped onto one of those execution units and executed. So 00:40:45,740 --> 00:40:51,620
我们将看到每个块都映射到这些执行单元之一并执行。所以
--there are limits on that, but it's more of an organization of your computation, breaking it 00:40:51,620 --> 00:40:57,780
对此有限制，但它更多的是你的计算组织，打破它
--into chunks rather than a specific piece of hardware. Okay. So think of it as, I took my 00:40:57,780 --> 00:41:05,980
成块而不是特定的硬件。好的。所以把它想象成，我把我的
--original, so there's this sort of hierarchy. I took my original computational problem and broke 00:41:06,100 --> 00:41:11,380
原始的，所以有这种层次结构。我把我原来的计算问题解决了
--it into smaller chunks that I'm calling blocks. And then with each block, there can be some way 00:41:11,380 --> 00:41:18,340
它分成更小的块，我称之为块。然后对于每个块，可以有一些方法
--some smaller pieces that need to be done. And this is again, a reflection of CUDA having a partial 00:41:18,340 --> 00:41:28,300
一些需要完成的小部分。这又一次反映了 CUDA 具有部分
--view of the hardware that in the perfect data parallel world, you wouldn't have to do this 00:41:28,300 --> 00:41:33,460
从硬件的角度来看，在完美的数据并行世界中，您不必这样做
--kind of stuff. But CUDA is giving you some view into the real hardware that's saying, hey, by the 00:41:33,460 --> 00:41:39,540
那种东西。但是 CUDA 让您了解真正的硬件，嘿，
--way, I'm really going to break this into these blocks that I map each block onto a separate 00:41:39,540 --> 00:41:44,780
方式，我真的要把它分解成这些块，我将每个块映射到一个单独的
--processor or what they call an SM. And you might as well know that because that actually will be 00:41:44,780 --> 00:41:52,540
处理器或他们所说的 SM。你可能也知道，因为那实际上是
--useful when you do more performance tuning down the road. But it's a good question. Other questions? 00:41:52,540 --> 00:41:59,500
当你在路上做更多的性能调整时很有用。但这是个好问题。其他问题？
--Yes. 00:41:59,500 --> 00:42:01,180
是的。
--Thank you. I'm from the part before this, but how come the GPUs don't have a higher percentage power compared to CPUs? Then how come they haven't hit the thermal wall? 00:42:01,180 --> 00:42:12,900
谢谢。我来自这之前的部分，但是与 CPU 相比，GPU 的功率百分比为什么不高？那他们怎么还没碰到热壁呢？
--Well, they do. We had to get more air conditioning in the GHC clusters when we put all those GPUs in 00:42:12,900 --> 00:42:21,180
嗯，他们有。当我们将所有这些 GPU 放入其中时，我们必须在 GHC 集群中安装更多空调
--them. So they do. They have like 180 watts. So the reason why they get you, so they're actually pretty high power. They're big chips too. Costs, I think, you know, somewhere between $500,000 for a high-end GPU. So they're pretty serious pieces of hardware. But the reason why they still have this 00:42:21,180 --> 00:42:48,780
他们。所以他们这样做。他们有 180 瓦。所以他们得到你的原因，所以他们实际上是非常强大的。他们也是大筹码。我认为，高端 GPU 的成本在 500,000 美元之间。所以它们是非常重要的硬件。但他们之所以还有这个
--fundamental advantage that they can cast out this ton of control logic that's been added to processors over the years to try and scrape more parallelism out of sequential programs. Tremendous, you know, branch prediction, out of order execution, speculative execution, so on and so forth that we've kept adding to hardware to try and get it to go faster. And a lot of caches. 00:42:48,820 --> 00:43:18,260
他们的根本优势在于，他们可以摒弃多年来添加到处理器中的大量控制逻辑，以尝试从顺序程序中获取更多的并行性。巨大的，你知道的，分支预测、乱序执行、推测执行等等，我们一直在不断地添加到硬件中，试图让它运行得更快。还有很多缓存。
--If you can just throw all that out, then all of a sudden you have a lot more real estate available for doing addition and multiplication and other operations you might want to do. 00:43:18,260 --> 00:43:26,780
如果你能把所有这些都扔掉，那么突然之间你就有了更多的可用空间来进行加法和乘法以及其他你可能想做的操作。
--So as I mentioned, this code distinguishes between what's executing on the CPU and what's executing on the GPU. And one of these so-called kernels, which are prefixed with the global, and that model of the kernel is it's this sort of data parallel function that it's summed up by the data parallel function. 00:43:26,780 --> 00:43:56,300
因此，正如我提到的，这段代码区分了在 CPU 上执行的内容和在 GPU 上执行的内容。其中一个所谓的内核，以全局为前缀，内核的模型就是这种数据并行功能，它是由数据并行功能总结的。
--That it's some operation where you have some way of extracting an i and j, you know, various indexes over the data that you're doing because you're passing in a reference to a particular block in the larger data that you're working on. 00:43:56,300 --> 00:44:14,700
这是一些操作，你可以通过某种方式提取 i 和 j，你知道，你正在做的数据的各种索引，因为你正在传递对你正在处理的更大数据中特定块的引用在。
--And you can also write a standard function that's designed to be compiled and executed by the device, and that's prefixed by device, and that just looks like a regular old function. 00:44:15,700 --> 00:44:27,700
您还可以编写一个标准函数，该函数旨在由设备编译和执行，并以设备为前缀，看起来就像一个普通的旧函数。
--And then up in the host code, you see it can execute arbitrary C, C++, but it does these things called a thread launch, which is what these triple symbols mean is sort of, okay, this is a very special type of operation. 00:44:27,700 --> 00:44:47,700
然后在主机代码中，您会看到它可以执行任意 C、C++，但它执行这些称为线程启动的事情，这就是这些三重符号的意思，好吧，这是一种非常特殊的操作类型。
--So as we said, the idea of this is that the sort of block structure, the partitioning of data into smaller units, and as I mentioned, the sort of upper bound of a total of 1,024 threads within a single block is a hardware limit. 00:44:47,700 --> 00:45:11,700
正如我们所说，这种想法是块结构的排序，将数据划分为更小的单元，正如我提到的，单个块内总共 1,024 个线程的上限是硬件限制。
--But one interesting thing is you often will write code that's designed to execute where the thing doesn't work out to be a multiple of your block size. 00:45:12,700 --> 00:45:22,700
但一件有趣的事情是，您经常会编写旨在执行的代码，但结果不是您的块大小的倍数。
--So here's an example of correct code, even if my larger matrix were 11 by 5, even though my primitive blocks are 4 by 3. 00:45:23,700 --> 00:45:32,700
所以这是一个正确代码的示例，即使我的大矩阵是 11 x 5，即使我的原始块是 4 x 3。
--And you'll see that the change is inside the kernel code, you're supposed to do a test here and say if the data indices are out of the bounds, then, well, if they're within bounds, I go ahead and do the operation, otherwise I don't. 00:45:32,700 --> 00:45:52,700
你会看到变化在内核代码中，你应该在这里做一个测试，看看数据索引是否超出范围，然后，如果它们在范围内，我继续做手术，否则我不做。
--And you can see, actually, ultimately this is going to map down to SIMD operations, and so this gets implemented in the standard SIMD style that it will lock all these together, but the one, the particular threads execution context for which this doesn't satisfy will just be disabled from updating. 00:45:52,700 --> 00:46:16,700
你可以看到，实际上，最终这将映射到 SIMD 操作，因此它以标准 SIMD 样式实现，它将所有这些锁定在一起，但是一个，它不针对的特定线程执行上下文t满足将被禁止更新。
--Yes. 00:46:18,700 --> 00:46:19,700
是的。
--Yes. 00:46:20,700 --> 00:46:21,700
是的。
--Yeah, so wouldn't it be faster to get rid of the comparison and just allocate a block that's of the correct size in the first place? 00:46:21,700 --> 00:46:30,700
是的，那么摆脱比较并首先分配一个正确大小的块不是更快吗？
--Well, you could do it here, because it's pretty small, but imagine a much bigger example. 00:46:31,700 --> 00:46:36,700
好吧，你可以在这里做，因为它很小，但想象一个更大的例子。
--Also, we'll see there's some preference for certain numbers like 32 and other block dimensions, because of, again, the hardware. 00:46:37,700 --> 00:46:46,700
此外，我们还会看到对某些数字（例如 32 和其他块尺寸）有一些偏好，这也是因为硬件。
--So this is a pretty standard, you'll end up seeing this in CUDA code quite a bit, is some bounds testing and disabling. 00:46:47,700 --> 00:46:54,700
所以这是一个非常标准的，你最终会在 CUDA 代码中看到很多，是一些边界测试和禁用。
--And it doesn't really, if you just sort of, it's a relatively low cost. 00:46:55,700 --> 00:47:01,700
它不是真的，如果你只是有点，它是一个相对较低的成本。
--The test itself you consider is essentially zero cost. 00:47:02,700 --> 00:47:05,700
您考虑的测试本身基本上是零成本。
--The only penalty is that you're not making use of all the possible functional units you could. 00:47:06,700 --> 00:47:11,700
唯一的缺点是您没有使用所有可能的功能单元。
--But it's not like in a CPU-based code where every conditional test is a potential mispredicted branch, which is a potential source of huge slowdown. 00:47:12,700 --> 00:47:21,700
但它不像在基于 CPU 的代码中那样，每个条件测试都是一个潜在的错误预测分支，这是一个潜在的巨大减速源。
--It's not that way here. 00:47:22,700 --> 00:47:23,700
这里不是这样的。
--And part of what we're going to exploit is the fact that we have way more things to do than we have hardware to do it on. 00:47:24,700 --> 00:47:31,700
我们要利用的一部分是这样一个事实，即我们要做的事情比我们拥有的硬件要多得多。
--So we can be fairly sloppy about scheduling and still get a lot of, maximize our use of the performance. 00:47:32,700 --> 00:47:40,700
所以我们可以在调度方面相当马虎，但仍然可以获得很多，最大限度地利用性能。
--So it's exploiting this very highly, highly parallel world. 00:47:41,700 --> 00:47:45,700
所以它正在利用这个非常高度、高度平行的世界。
--And doing what we discussed is, it's often easier to improve throughput, get high throughput computing, rather than very short delay computing. 00:47:46,700 --> 00:47:58,700
而做我们讨论的是，提高吞吐量，获得高吞吐量计算，而不是非常短的延迟计算，往往更容易。
--Question? 00:47:58,700 --> 00:48:12,700
问题？
--Other questions? 00:48:13,700 --> 00:48:14,700
其他问题？
--Is there a perfectly reasonable question? 00:48:15,700 --> 00:48:16,700
有一个完全合理的问题吗？
--Yes. 00:48:17,700 --> 00:48:18,700
是的。
--I've been thinking that if we were to treat this array as one-dimensional and have threads that contain 1,024 elements in linear order, then it would have a higher throughput than this one. 00:48:18,700 --> 00:48:29,700
我一直在想，如果我们把这个数组当作一维的，并且有包含 1,024 个线性顺序元素的线程，那么它的吞吐量会比这个更高。
--No, it would be the exact same. 00:48:30,700 --> 00:48:31,700
不，它会完全一样。
--So this business of the multi-dimensions is directly supported by CUDA, but in reality it maps into, just flattens out using row-major ordering. 00:48:32,700 --> 00:48:45,700
所以 CUDA 直接支持这种多维业务，但实际上它映射到，只是使用行优先顺序展平。
--Now what you're asking is, would we get better utilization? 00:48:45,700 --> 00:48:48,700
现在您要问的是，我们会得到更好的利用率吗？
--I think don't get too wrapped up in that. 00:48:49,700 --> 00:48:51,700
我认为不要太拘泥于此。
--This is a relatively low cost. 00:48:52,700 --> 00:48:53,700
这是一个相对较低的成本。
--All that it will mean is we'll disable a few of the threads from executing, but we've got a lot of threads to use. 00:48:54,700 --> 00:49:01,700
这意味着我们将禁用一些线程执行，但我们有很多线程要使用。
--So it's not really a problem, except at sort of some extreme edge of optimization. 00:49:02,700 --> 00:49:08,700
所以这不是真正的问题，除了某种极端的优化。
--But my point is that there's sort of this trade-off that we're making the code take into account something about this block structure, and it shows up even in application code, but it's done in a way that it's not a terrible thing. 00:49:09,700 --> 00:49:31,700
但我的观点是，我们正在让代码考虑一些关于这个块结构的东西，这是一种权衡，它甚至出现在应用程序代码中，但它是以一种并不可怕的方式完成的。
--So you understand pretty well how a conventional processor executes. 00:49:31,700 --> 00:49:46,700
因此，您非常了解传统处理器的执行方式。
--CUDA is what they call SPMD, so not SIMD, SPMD, Single Program Multiple Data, meaning that same kernel code is being executed by multiple threads simultaneously. 00:49:47,700 --> 00:50:01,700
 CUDA 就是他们所说的 SPMD，所以不是 SIMD、SPMD、单程序多数据，这意味着相同的内核代码正在由多个线程同时执行。
--One final thing I wanted to point out is, one of the good things sort of is, and we'll find that CUDA has to sort of break this into blocks and schedule blocks onto these different SMs and make sure they all get executed and synchronized and stuff. 00:50:02,700 --> 00:50:19,700
我想指出的最后一件事是，其中一件好事是，我们会发现 CUDA 必须将其分解成块并将块调度到这些不同的 SM 上，并确保它们都得到执行和同步和东西。
--But it does that all in hardware. 00:50:20,700 --> 00:50:21,700
但它在硬件中做到了这一点。
--We as CUDA programmers just can make N sub X and N sub Y essentially as big as we want to, and it will deal with how do we do the partitioning and scheduling. 00:50:22,700 --> 00:50:35,700
作为 CUDA 程序员，我们可以让 N sub X 和 N sub Y 基本上和我们想要的一样大，它会处理我们如何进行分区和调度。
--So we don't have to be down at this low level sort of creating a scheduler. 00:50:36,700 --> 00:50:40,700
所以我们不必在创建调度程序的这种低级别上陷入困境。
--We can write this reasonably high-level code, and it will handle it in hardware. 00:50:41,700 --> 00:50:45,700
我们可以编写这个相当高级的代码，它会在硬件中处理它。
--And that's what I mean by this SPMD model. 00:50:46,700 --> 00:50:50,700
这就是我所说的 SPMD 模型的意思。
--It gives you this illusion of a very pure data parallel execution, but that's not how the hardware actually works, because it has limited processing power. 00:50:51,700 --> 00:51:00,700
它给你一种非常纯数据并行执行的错觉，但这并不是硬件实际工作的方式，因为它的处理能力有限。
--But there are some features of it, like there's a memory. 00:51:01,700 --> 00:51:05,700
但是它有一些特点，比如有记忆。
--The device has a memory, which is typically on the scale of a few gigabytes, so not huge but not bad. 00:51:06,700 --> 00:51:14,700
该设备有一个内存，通常在几千兆字节的规模上，所以不是很大但也不错。
--And you can do sort of shared memory operations, but it has a very different concurrency model from, say, P threads. 00:51:15,700 --> 00:51:22,700
您可以执行某种共享内存操作，但它具有与 P 线程等非常不同的并发模型。
--You have to be very careful of what you assume about the coherence of memory operations. 00:51:23,700 --> 00:51:28,700
你必须非常小心你对内存操作一致性的假设。
--So one of the things you have to do, though, explicitly is sort of prepping, getting the interaction between the host and the device. 00:51:29,700 --> 00:51:43,700
因此，尽管如此，您必须做的一件事明确地是准备，让主机和设备之间进行交互。
--They have separate memories, and so you actually have to explicitly in your code say, I want to copy data from one memory space to the other. 00:51:44,700 --> 00:51:53,700
它们有独立的内存，所以你实际上必须在你的代码中明确地说，我想将数据从一个内存空间复制到另一个内存空间。
--And this will show up. 00:51:54,700 --> 00:51:55,700
这会出现。
--And similarly, there's an operation called CUDA malloc, which is the way you allocate memory on the device. 00:51:56,700 --> 00:52:02,700
同样，有一个称为 CUDA malloc 的操作，这是您在设备上分配内存的方式。
--So you kind of have to do this low-level memory allocation, transfer back and forth type of things as well. 00:52:03,700 --> 00:52:10,700
所以你必须做这种低级内存分配，来回传输类型的东西。
--Yes? 00:52:14,700 --> 00:52:15,700
是的？
--Excuse me, what did you say? 00:52:21,700 --> 00:52:22,700
打扰一下，你说什么？
--How does CUDA malloc accept a pointer to a pointer? 00:52:23,700 --> 00:52:27,700
 CUDA malloc 如何接受指向指针的指针？
--Oh, so pretty much all of the CUDA API returns some error code, just like a system call. 00:52:28,700 --> 00:52:38,700
哦，几乎所有的 CUDA API 都会返回一些错误代码，就像系统调用一样。
--So whereas malloc returns a pointer to something, conventional malloc, CUDA malloc returns some code which indicates whether it succeeded or failed. 00:52:39,700 --> 00:52:48,700
因此，尽管 malloc 返回指向某物的指针，传统的 malloc，CUDA malloc 返回一些指示它是成功还是失败的代码。
--And so you end up passing arguments, pointer arguments, to it to essentially create what you really want, to return the result that you really want to get out. 00:52:49,700 --> 00:53:02,700
因此，您最终将参数、指针参数传递给它，以实质上创建您真正想要的东西，返回您真正想要得到的结果。
--It's been a change in the C coding convention over the years. 00:53:03,700 --> 00:53:05,700
多年来，它一直是 C 编码约定的变化。
--The early C libraries and functions generally returned whatever they were returning, but then didn't know what should happen. 00:53:06,700 --> 00:53:11,700
早期的 C 库和函数通常会返回它们返回的任何内容，但不知道会发生什么。
--So most of your newer C libraries don't do what malloc does. 00:53:12,700 --> 00:53:15,700
所以大多数较新的 C 库都不会执行 malloc 所做的事情。
--Right, they return an error code. 00:53:16,700 --> 00:53:17,700
是的，他们返回一个错误代码。
--Right. 00:53:19,700 --> 00:53:20,700
正确的。
--So there's also, just like there's a memory hierarchy on a CPU, but it's somewhat hidden from you that the caches are all totally hardware controlled. 00:53:26,700 --> 00:53:40,700
所以还有，就像 CPU 上有一个内存层次结构一样，但它对你来说有点隐藏，缓存都是完全由硬件控制的。
--And basically the closer in caches are a conceptual image of the larger address space. 00:53:40,700 --> 00:53:50,700
基本上越近的缓存是更大地址空间的概念图像。
--In CUDA, in GPU, they also have a hierarchy of memories. 00:53:51,700 --> 00:53:55,700
在 CUDA 中，在 GPU 中，它们也有一个内存层次结构。
--The memories are much smaller, but also they're more under software control. 00:53:56,700 --> 00:53:59,700
内存要小得多，但也更受软件控制。
--As far as instead of just caching serving as pure caches, they serve as what's sometimes called a software cache. 00:54:00,700 --> 00:54:07,700
就不仅仅是缓存作为纯缓存而言，它们还充当有时称为软件缓存的功能。
--Where you and your code get to manage what's loaded into those or not. 00:54:07,700 --> 00:54:11,700
您和您的代码在哪里可以管理加载或不加载的内容。
--So in particular, each block has a shared memory that cover all the threads in that block get to share this memory. 00:54:12,700 --> 00:54:23,700
因此，特别是，每个块都有一个共享内存，覆盖该块中的所有线程都可以共享该内存。
--And we'll see that it can be very useful. 00:54:24,700 --> 00:54:25,700
我们会看到它非常有用。
--And even each thread has a very small amount of memory it can operate on. 00:54:26,700 --> 00:54:30,700
甚至每个线程也只有非常少量的内存可以操作。
--And then, but also they can reference the more global memory. 00:54:31,700 --> 00:54:35,700
然后，还可以引用更多的全局内存。
--So I've never written any code that did, or I don't know if there are primitives that let you do the per thread memory. 00:54:36,700 --> 00:54:42,700
所以我从来没有写过任何代码，或者我不知道是否有原语可以让你做每线程内存。
--But we'll see instances here of where you can make use of the shared memory. 00:54:43,700 --> 00:54:46,700
但是我们将在这里看到可以使用共享内存的实例。
--And you can do, since you have more control over it, you can sort of think about programmatically what you want to put there. 00:54:47,700 --> 00:54:55,700
你可以做到，因为你对它有更多的控制，你可以通过编程来考虑你想放在那里的东西。
--Yes. 00:54:56,700 --> 00:54:57,700
是的。
--Yes. 00:54:58,700 --> 00:54:59,700
是的。
--Yes, except the per block shared memory is under software control. 00:55:11,700 --> 00:55:15,700
是的，除了每块共享内存受软件控制。
--So you get to define what it's going to have. 00:55:16,700 --> 00:55:18,700
所以你要定义它会拥有什么。
--As opposed to it just demanding, loading in whatever. 00:55:19,700 --> 00:55:21,700
而不是仅仅要求，加载任何东西。
--If you read from global memory, it won't necessarily show up in the shared memory, in the block memory. 00:55:22,700 --> 00:55:28,700
如果你从全局内存中读取，它不一定会出现在共享内存中，在块内存中。
--So let's do a really simple example to carry this through. 00:55:30,700 --> 00:55:33,700
所以让我们做一个非常简单的例子来完成这个。
--It's a fairly simplified version of an operation you might want to do in graphics, which is a convolution. 00:55:34,700 --> 00:55:40,700
这是您可能想要在图形中执行的操作的相当简化的版本，这是一个卷积。
--So typically with a convolution, you're sort of combining the value at each given pixel with the values of surrounding pixels. 00:55:41,700 --> 00:55:48,700
因此，通常使用卷积，您可以将每个给定像素的值与周围像素的值组合起来。
--We're going to do this just in a single dimension. 00:55:49,700 --> 00:55:51,700
我们将仅在一个维度中执行此操作。
--So we're going to say that we want to somehow combine, actually just compute the average of this pixel and its two neighbors and assign that value to our output pixel. 00:55:52,700 --> 00:56:07,700
所以我们要说我们想以某种方式组合，实际上只是计算这个像素及其两个邻居的平均值，并将该值分配给我们的输出像素。
--So we want to do this. 00:56:08,700 --> 00:56:09,700
所以我们想这样做。
--So typically then we'll have an input vector that has two elements more than our output vector. 00:56:10,700 --> 00:56:15,700
所以通常我们会有一个输入向量，它比我们的输出向量多两个元素。
--And so that's the sort of kernel operation we want to perform. 00:56:19,700 --> 00:56:22,700
这就是我们想要执行的那种内核操作。
--So we can write this very simple code then of a kernel that just says, as you see in the red, it's just going to do adding together. 00:56:23,700 --> 00:56:38,700
所以我们可以编写这个非常简单的内核代码，就像你在红色部分看到的那样，它只是将加在一起。
--So we'll access the global memory. 00:56:39,700 --> 00:56:41,700
所以我们将访问全局内存。
--Let's just work our way backward here. 00:56:42,700 --> 00:56:44,700
让我们在这里向后工作。
--The input arguments are arrays. 00:56:44,700 --> 00:56:49,700
输入参数是数组。
--These will have to be in device memory. 00:56:50,700 --> 00:56:52,700
这些必须在设备内存中。
--So these represent the global memory of the GPU. 00:56:53,700 --> 00:56:55,700
所以这些代表了GPU的全局内存。
--And I will read them and write to them just like I would any array in C. 00:56:56,700 --> 00:57:02,700
我会像 C 中的任何数组一样阅读和写入它们。
--And then within it I just have this loop over the three elements that I want to sum together to get my new pixel and then I'll write it to the output. 00:57:03,700 --> 00:57:18,700
然后在其中我只对三个元素进行循环，我想将它们加在一起以获得我的新像素，然后我将它写入输出。
--So you can imagine our goal here is to have this just be done for all values of i across the entire output vector to assemble the values for it. 00:57:19,700 --> 00:57:30,700
因此，您可以想象我们的目标是对整个输出向量中 i 的所有值执行此操作，以组装它的值。
--And so you'll see a few things. 00:57:30,700 --> 00:57:32,700
所以你会看到一些东西。
--We're making use of a shared address space model, the global memory. 00:57:33,700 --> 00:57:37,700
我们正在使用共享地址空间模型，即全局内存。
--But it would be a bad thing if you had a memory collision here that you're trying to assign multiple values for a given value of the output array. 00:57:38,700 --> 00:57:53,700
但是，如果您试图为输出数组的给定值分配多个值，那么如果您在这里发生内存冲突，那将是一件坏事。
--That result will just be undefined. 00:57:54,700 --> 00:57:55,700
结果将是不确定的。
--It's not tested and it won't fail, but it's not a supported operation. 00:57:55,700 --> 00:58:04,700
它没有经过测试，也不会失败，但它不是受支持的操作。
--There's no semantics for that. 00:58:05,700 --> 00:58:06,700
没有语义。
--But the point is we want this thing to just somehow magically take however big n is to do this operation over the n elements of the output, the n plus 2 elements of the input. 00:58:07,700 --> 00:58:21,700
但关键是我们希望这个东西以某种方式神奇地采用无论 n 大是对输出的 n 个元素（即输入的 n 加 2 个元素）执行此操作。
--So we'll write this by just picking out some somewhat arbitrary constant, 128, which is called threads per block. 00:58:22,700 --> 00:58:35,700
因此，我们将通过挑选一些有点随意的常量 128 来编写它，这称为每块线程数。
--That will be the size of our declared block size and it's only a one-dimensional. 00:58:36,700 --> 00:58:40,700
那将是我们声明的块大小的大小，并且它只是一维的。
--We're not going to do multi-dimensional here. 00:58:41,700 --> 00:58:43,700
我们不打算在这里做多维。
--So below you'll see the code that does this all. 00:58:44,700 --> 00:58:47,700
所以在下面你会看到完成这一切的代码。
--It runs CUDA malloc to allocate the input and the output memories. 00:58:48,700 --> 00:58:53,700
它运行 CUDA malloc 来分配输入和输出内存。
--As shown, there's a comment here. 00:58:54,700 --> 00:58:56,700
如图，这里有评论。
--This is the code we don't show. 00:58:57,700 --> 00:58:58,700
这是我们不显示的代码。
--Somehow we're setting up what the input should look like, typically a copy from the host to the device. 00:58:59,700 --> 00:59:06,700
我们以某种方式设置输入的外观，通常是从主机到设备的副本。
--Then we're going to do a thread launch where we're going to say... 00:59:07,700 --> 00:59:11,700
然后我们将进行线程启动，我们要说...
--I showed you using something called a DIMM3, which is a CUDA data type for three-dimensional indexing. 00:59:17,700 --> 00:59:25,700
我向您展示了使用称为 DIMM3 的东西，这是一种用于三维索引的 CUDA 数据类型。
--But you can also just pass two ints. 00:59:26,700 --> 00:59:28,700
但是你也可以只传递两个整数。
--One being how many blocks there are and the other being what the block size is. 00:59:29,700 --> 00:59:39,700
一个是有多少块，另一个是块大小。
--But the point here, the host code is... 00:59:42,700 --> 00:59:44,700
但这里的要点是，主机代码是……
--At some level I'm just saying just perform this operation across it and you hardware figure out how to make this happen. 00:59:45,700 --> 00:59:51,700
在某种程度上，我只是说只要在它上面执行这个操作，你的硬件就会知道如何实现它。
--But what we're actually going to do then is take this code and break it into these blocks of size 128 each. 00:59:52,700 --> 01:00:01,700
但是我们实际上要做的是将这段代码分解成这些块，每个块大小为 128。
--And then each block will be responsible for doing the appropriate set of computations and updates. 01:00:02,700 --> 01:00:08,700
然后每个块将负责执行一组适当的计算和更新。
--So that's sort of the straightforward version of it. 01:00:09,700 --> 01:00:12,700
这就是它的简单版本。
--And it works. 01:00:13,700 --> 01:00:14,700
它有效。
--But it's not very fast. 01:00:15,700 --> 01:00:19,700
但它不是很快。
--Can you see some parts of this? 01:00:20,700 --> 01:00:22,700
你能看到其中的某些部分吗？
--For each input, for each value, for each value of the input, 01:00:23,700 --> 01:00:30,700
对于每个输入，对于每个值，对于输入的每个值，
--Can you see some parts of this? 01:00:30,700 --> 01:00:32,700
你能看到其中的某些部分吗？
--For each input, how many reads to global memory is this code going to do approximately? 01:00:33,700 --> 01:00:43,700
对于每个输入，这段代码大约要对全局内存进行多少次读取？
--Remember, don't assume caching. 01:00:46,700 --> 01:00:49,700
请记住，不要假设缓存。
--It's 3N, right? 01:00:52,700 --> 01:00:53,700
是3N吧？
--In other words, each thread is going to do three reads. 01:00:54,700 --> 01:00:57,700
换句话说，每个线程将进行 3 次读取。
--And they won't share that because... 01:00:58,700 --> 01:01:00,700
他们不会分享，因为...
--Get away from your idea of caching. 01:01:03,700 --> 01:01:05,700
远离缓存的想法。
--There is no caching. 01:01:06,700 --> 01:01:07,700
没有缓存。
--So when you say read, it will really read. 01:01:08,700 --> 01:01:09,700
因此，当您说阅读时，它会真正阅读。
--And if it takes a while to read, it will take that long. 01:01:10,700 --> 01:01:12,700
如果需要一段时间来阅读，那就需要那么长时间。
--So this code already has a sort of inefficiency in that even though I have three threads that are all going to be reading a given input value, 01:01:13,700 --> 01:01:24,700
所以这段代码已经存在某种低效率，即使我有三个线程都将读取给定的输入值，
--they're not collaborating at all on that. 01:01:24,700 --> 01:01:26,700
他们在这方面根本没有合作。
--And so those reads will be totally independent. 01:01:27,700 --> 01:01:30,700
因此这些读取将是完全独立的。
--But this leads you to this idea of, oh, but you told me within the block is this little shared memory that I can use like a cache. 01:01:31,700 --> 01:01:41,700
但这会让你产生这样的想法，哦，但是你告诉我块内是这个小的共享内存，我可以像缓存一样使用它。
--But if I want to use it, I have to be explicit. 01:01:42,700 --> 01:01:44,700
但如果我想使用它，我必须明确。
--So next what we'll show is, yes, indeed, and that's the kind of code you're going to end up writing for these little efficiencies like that. 01:01:45,700 --> 01:01:53,700
所以接下来我们要展示的是，是的，确实如此，这就是您最终要为这些小效率编写的代码。
--And that's what it looks like here. 01:01:54,700 --> 01:01:56,700
这就是这里的样子。
--And it's a little bit... 01:01:57,700 --> 01:01:58,700
而且有点...
--A little bit crufty looking. 01:02:01,700 --> 01:02:02,700
有点粗糙的样子。
--So you'll see that this is a new version of a kernel. 01:02:03,700 --> 01:02:08,700
所以你会看到这是一个新版本的内核。
--And what we've done is we've declared some amount of memory, a local array called support. 01:02:09,700 --> 01:02:16,700
我们所做的是声明了一定量的内存，一个称为支持的本地数组。
--But it's declared as an underscore shared declaration. 01:02:17,700 --> 01:02:21,700
但它被声明为下划线共享声明。
--And what that means is this array gets allocated within the shared memory of the processor. 01:02:21,700 --> 01:02:27,700
这意味着这个数组在处理器的共享内存中分配。
--And so what these two red blocks show is the first part, this first line here... 01:02:28,700 --> 01:02:35,700
所以这两个红色块显示的是第一部分，这里的第一行......
--Whoops, I'm sorry. 01:02:39,700 --> 01:02:40,700
哎呀，对不起。
--Here does a read into this array. 01:02:40,700 --> 01:02:46,700
这里读取这个数组。
--And you'll see that it's reading from this value index, which is an index into the global array using the appropriately scaled position in the global array. 01:02:47,700 --> 01:03:00,700
你会看到它是从这个值索引中读取的，它是使用全局数组中适当缩放的位置对全局数组的索引。
--But it's storing it according to a local offset, which is just the idea of this thread within the block. 01:03:01,700 --> 01:03:08,700
但它是根据本地偏移量存储它的，这正是该线程在块中的想法。
--So right away we've got 128 of these. 01:03:09,700 --> 01:03:12,700
所以马上我们就得到了其中的 128 个。
--So this little line of code is issuing 128 reads that will all be done simultaneously. 01:03:13,700 --> 01:03:19,700
所以这一行代码发出了 128 次读取，所有这些读取都将同时完成。
--And then this next line you see is saying... 01:03:20,700 --> 01:03:27,700
然后你看到的下一行是说......
--And now for the first two threads in the block, we'll read the remaining two elements of this array. 01:03:27,700 --> 01:03:34,700
现在对于块中的前两个线程，我们将读取该数组的其余两个元素。
--Because remember to get... 01:03:34,700 --> 01:03:36,700
因为记得拿...
--130 input values. 01:03:38,700 --> 01:03:40,700
 130 个输入值。
--So this is, again, making use of this trick of enabling or disabling certain operations. 01:03:41,700 --> 01:03:51,700
因此，这再次利用了启用或禁用某些操作的技巧。
--And now you can see that what I've done is I've gotten all my threads within my block to work together collaboratively to read in the data from the global memory that I need. 01:03:52,700 --> 01:04:07,700
现在你可以看到我所做的是让我的块中的所有线程协同工作，从我需要的全局内存中读取数据。
--But the memory model is still... 01:04:08,700 --> 01:04:11,700
但是内存模型仍然是......
--These threads are not totally locked together necessarily. 01:04:11,700 --> 01:04:15,700
这些线程不一定完全锁定在一起。
--And so then there's an operation called sync threads, which is a barrier sync. 01:04:15,700 --> 01:04:21,700
然后有一个称为同步线程的操作，这是一个屏障同步。
--And in general, a barrier sync, and we'll get into these more later, means no thread is allowed to go past this until they all reach it and agree to move on. 01:04:22,700 --> 01:04:32,700
一般来说，障碍同步，我们稍后会详细介绍，这意味着在所有线程都到达并同意继续前进之前，不允许任何线程通过它。
--So when I hit this sync threads, what it will guarantee is all the threads that are executing simultaneously will all have completed their reads from global memory. 01:04:33,700 --> 01:04:46,700
所以当我点击这个同步线程时，它会保证所有同时执行的线程都已完成从全局内存中的读取。
--So that data will all be available now to all threads. 01:04:46,700 --> 01:04:50,700
因此，所有线程现在都可以使用这些数据。
--In general, if you don't put sync threads in, you can have some race ahead of others and get out of it. 01:04:51,700 --> 01:04:56,700
一般来说，如果您不放入同步线程，您可能会领先于其他人并退出比赛。
--And part of this is... 01:04:57,700 --> 01:04:59,700
其中一部分是...
--We'll get to this in a minute with the execution. 01:04:59,700 --> 01:05:02,700
我们将在一分钟内完成执行。
--So I said it's sort of like SIMD, but it isn't because there's actually... 01:05:02,700 --> 01:05:09,700
所以我说它有点像 SIMD，但不是因为实际上...
--We'll see that the SIMD part of this is on units of size 32. 01:05:09,700 --> 01:05:15,700
我们将看到它的 SIMD 部分在大小为 32 的单元上。
--And so the actual execution of the block will involve multiple executions of 32-wide SIMD. 01:05:16,700 --> 01:05:25,700
因此块的实际执行将涉及 32 位 SIMD 的多次执行。
--So anyways, the point being that the sync threads is necessary to kind of get all the threads within the block caught up to this particular point in the program. 01:05:25,700 --> 01:05:35,700
所以无论如何，关键是同步线程对于让块中的所有线程赶上程序中的这个特定点是必要的。
--And if you don't do it, then subsequently reads might not see the correct value. 01:05:35,700 --> 01:05:40,700
如果你不这样做，那么随后的读取可能看不到正确的值。
--And now you'll see that this remaining part of the code looks just like before, except that rather than reading from the global array, I'm reading from this local array. 01:05:42,700 --> 01:05:52,700
现在你会看到代码的剩余部分看起来和以前一样，除了我不是从全局数组中读取，而是从这个本地数组中读取。
--And so what I've done is I've turned this 3n reads into n reads. 01:05:53,700 --> 01:05:58,700
所以我所做的就是将这 3n 次读取变成 n 次读取。
--Well, n plus a little extra because on these overlapping twos, each two different blocks will end up reading those. 01:05:58,700 --> 01:06:07,700
好吧，n 加上一点额外的，因为在这些重叠的两个上，每两个不同的块最终都会读取它们。
--But still, relatively speaking, I've reduced my total reads by about a factor of two. 01:06:07,700 --> 01:06:14,700
但是，相对而言，我的总阅读量减少了大约两倍。
--But that gives you... Now all of a sudden we say, oh wait, this was this nice clean data parallel language. 01:06:23,700 --> 01:06:30,700
但这给了你......现在我们突然说，哦等等，这是一种非常干净的数据并行语言。
--And now you're starting to talk about blocks and synchronizing within blocks and things like that. 01:06:30,700 --> 01:06:36,700
现在你开始谈论块和块内的同步等等。
--So we're getting a bit of a mixed model of computation. 01:06:36,700 --> 01:06:39,700
所以我们得到了一些混合的计算模型。
--And I think that's sort of the reality of programming. 01:06:39,700 --> 01:06:44,700
我认为这就是编程的现实。
--That we could have this perfect ideal of what the greatest programming language would be, but it would run really slow. 01:06:44,700 --> 01:06:50,700
我们可以拥有最伟大的编程语言的完美理想，但它运行起来真的很慢。
--And so the art is to add just enough information about what the real hardware needs to know to be efficient, 01:06:51,700 --> 01:06:59,700
因此，艺术就是添加足够的信息来说明真正的硬件需要知道什么才能高效，
--that we can kind of tune it up without having to destroy all notions of abstraction in the program. 01:06:59,700 --> 01:07:06,700
我们可以在某种程度上对其进行调整，而不必破坏程序中的所有抽象概念。
--And so I think CUDA strikes a reasonable balance in that. 01:07:06,700 --> 01:07:09,700
所以我认为 CUDA 在这方面取得了合理的平衡。
--So we saw then this idea of sync threads, barrier threads, gives you some notion of how things execute within a block. 01:07:10,700 --> 01:07:21,700
所以我们看到了同步线程、屏障线程的想法，让你对块内的事情如何执行有了一些概念。
--There's also operations like atomic add, where you are guaranteed that your increment will happen atomically. 01:07:21,700 --> 01:07:33,700
还有像原子添加这样的操作，你可以保证你的增量将以原子方式发生。
--Meaning that value will be incremented by that amount, even if multiple threads are trying to do the same thing. 01:07:34,700 --> 01:07:45,700
这意味着该值将增加该数量，即使多个线程正在尝试做同样的事情。
--Otherwise, all bets are off. 01:07:45,700 --> 01:07:48,700
否则，所有赌注都将取消。
--And by the way, I believe atomic add is a relatively expensive operation, so you only use this if you don't have much other choice. 01:07:48,700 --> 01:07:55,700
顺便说一句，我相信原子添加是一个相对昂贵的操作，所以只有在没有太多其他选择的情况下才使用它。
--And then the other part of this that gives you some sort of synchronization is, every thread launch I do, it will complete before I begin another thread launch. 01:07:55,700 --> 01:08:09,700
然后另一部分为您提供某种同步的是，我启动的每个线程都会在我开始另一个线程启动之前完成。
--So anytime the host gets involved in something, it will force the whole thing to come to a common point. 01:08:09,700 --> 01:08:16,700
所以只要宿主介入某件事，它就会迫使整个事情走到一个共同点。
--So a few things we've seen here, that is this notion of a thread hierarchy, in other words, blocks within a block. 01:08:16,700 --> 01:08:35,700
所以我们在这里看到的一些东西，就是线程层次结构的概念，换句话说，块中的块。
--And then this distributed address space, the idea that there's a host address space and a device. 01:08:35,700 --> 01:08:41,700
然后是这个分布式地址空间，即有一个主机地址空间和一个设备的想法。
--And a little bit also this synchronization, that control-wise, we keep passing control to the GPU, it does something, and then it returns. 01:08:42,700 --> 01:08:51,700
还有一点这种同步，在控制方面，我们不断将控制传递给 GPU，它做一些事情，然后返回。
--These are all, by the way, in more modern versions of this, they've sort of tweaked it up so you can get other types of concurrency in the GPU, but we're not really going to cover that. 01:08:51,700 --> 01:09:02,700
顺便说一句，在更现代的版本中，这些都是这些，他们对其进行了某种程度的调整，以便您可以在 GPU 中获得其他类型的并发性，但我们不会真正涵盖这些。
--But again, it's worth reflecting back at how different this is from, say, a pthreads model. 01:09:12,700 --> 01:09:19,700
但同样，值得反思一下这与 pthreads 模型有何不同。
--They call it, it looks like we're executing a program, but it's nothing like a pthread where if we tried to fire off a million instances of pthreads, we'd end up with a big mess on our hands. 01:09:19,700 --> 01:09:32,700
他们称之为，看起来我们正在执行一个程序，但它完全不像一个 pthread，如果我们试图启动一百万个 pthreads 实例，我们最终会搞得一团糟。
--It actually, the program would crash. You can't allocate that much. 01:09:32,700 --> 01:09:38,700
实际上，程序会崩溃。你不能分配那么多。
--So this is a much more constrained model. 01:09:42,700 --> 01:09:46,700
所以这是一个更加受限的模型。
--A thread block, you can easily, you can have lots of thread blocks. 01:09:48,700 --> 01:09:52,700
一个线程块，你可以很容易，你可以有很多线程块。
--So let's talk now a little about how this gets mapped onto the GPU hardware. 01:09:54,700 --> 01:09:59,700
那么现在让我们谈谈如何将其映射到 GPU 硬件上。
--And as this picture shows, a sort of high-end GPU has 16, or the ones we have, which are called 1080s, have 20 cores, so 20 of what they call SMs. 01:10:00,700 --> 01:10:14,700
正如这张图片所示，一种高端 GPU 有 16 个，或者我们拥有的 GPU，称为 1080s，有 20 个内核，所以他们称之为 SM 的 20 个。
--And you can buy, one cool thing about NVIDIA is they can sell a 2 processor version you can get for relatively cheap, or they even have single core versions that are used, for example, in automobiles for doing a lot of stuff nowadays. 01:10:15,700 --> 01:10:37,700
你可以购买，关于 NVIDIA 的一件很酷的事情是他们可以出售你可以以相对便宜的价格获得的 2 处理器版本，或者他们甚至可以使用单核版本，例如，在如今的汽车中做很多事情。
--So they can kind of break this and sell you this sort of super model or the lesser model in various different configurations. 01:10:38,700 --> 01:10:45,700
所以他们可以打破这一点，向您出售这种超级型号或各种不同配置的较小型号。
--And you as a programmer don't really need to know that, because it will sort of handle these multiple cores automatically as part of the assigning work to cores. 01:10:47,700 --> 01:10:57,700
作为程序员，您实际上不需要知道这一点，因为它会自动处理这些多核，作为将工作分配给核的一部分。
--So we won't look in detail about, and I actually don't know it myself, is what the compiled CUDA code looks like. 01:10:57,700 --> 01:11:09,700
所以我们不会详细看，实际上我自己也不知道，编译后的 CUDA 代码是什么样子的。
--But there's a machine code for these GPUs that's generated by the CUDA compiler. 01:11:10,700 --> 01:11:15,700
但是有一个由 CUDA 编译器生成的用于这些 GPU 的机器码。
--And it will tell you, it will describe both what it's supposed to be doing, what the actual low-level code is for this kernel, as well as things like how many threads are there per block, how much local data it needs per thread, and what's the maximum amount of space it will use in the shared memory. 01:11:16,700 --> 01:11:39,700
它会告诉你，它会描述它应该做什么，这个内核的实际低级代码是什么，以及每个块有多少线程，每个线程需要多少本地数据，以及它将在共享内存中使用的最大空间量是多少。
--So now let's look at what happens when I do a kernel launch set. 01:11:39,700 --> 01:11:50,700
那么现在让我们看看当我执行内核启动设置时会发生什么。
--So think about it that I've got this one big computation I want to perform translates into many blocks of computation, each of which involves multiple threads. 01:11:51,700 --> 01:12:09,700
所以想一想，我要执行的这个大计算转化为许多计算块，每个计算块都涉及多个线程。
--And so now what I want to do, but the rule is basically that each of these blocks has to be independent of each other. 01:12:09,700 --> 01:12:18,700
所以现在我想做什么，但规则基本上是这些块中的每一个都必须彼此独立。
--At least it's assumed they are. 01:12:19,700 --> 01:12:20,700
至少假设他们是。
--That they can execute in any order and it won't matter. 01:12:21,700 --> 01:12:24,700
他们可以按任何顺序执行，这无关紧要。
--You'll get the same output as a result. 01:12:25,700 --> 01:12:26,700
结果你会得到相同的输出。
--So this is the perfect use of throughput-oriented computing. 01:12:27,700 --> 01:12:30,700
所以这就是面向吞吐量计算的完美运用。
--I've got a lot of work to do. 01:12:31,700 --> 01:12:32,700
我有很多工作要做。
--I can do it in any order I choose, depending on resource constraints. 01:12:33,700 --> 01:12:37,700
我可以按照我选择的任何顺序执行此操作，具体取决于资源限制。
--So that makes it, from a scheduling perspective, way easier than a more complex scheduling problem. 01:12:38,700 --> 01:12:44,700
因此，从调度的角度来看，这比更复杂的调度问题更容易。
--And so this can be done in hardware. 01:12:45,700 --> 01:12:47,700
所以这可以在硬件中完成。
--So there's a hardware scheduler built in that's mapping these blocks onto the actual processors. 01:12:48,700 --> 01:12:55,700
所以有一个内置的硬件调度程序，它将这些块映射到实际的处理器上。
--And then within the processor, it can support multiple block computations as well. 01:12:56,700 --> 01:13:00,700
然后在处理器内部，它也可以支持多块计算。
--And so, again, that's part of the secret of performance is that we've made the whole issue of scheduling really simple here. 01:13:00,700 --> 01:13:13,700
因此，这也是性能秘密的一部分，我们在这里使整个调度问题变得非常简单。
--And so this slide gets back to, we saw in ISPC the tasks. 01:13:21,700 --> 01:13:27,700
所以这张幻灯片回到我们在 ISPC 中看到的任务。
--I'm going to just move on because that's a useful thing, but not too critical. 01:13:28,700 --> 01:13:34,700
我将继续前进，因为这是一件有用的事情，但不是太关键。
--But this is roughly, this is a picture of what it looks like inside. 01:13:37,700 --> 01:13:41,700
但这是粗略的，这是一张它里面的样子的照片。
--I realize I'm running out of time. 01:13:42,700 --> 01:13:43,700
我意识到我的时间不多了。
--But each of these pieces to the left indicate it can maintain a state of up to 64 warps. 01:13:44,700 --> 01:13:56,700
但是左边的每一块都表明它可以保持最多 64 个扭曲的状态。
--So a warp is just a 32 element chunk of a thread block. 01:13:57,700 --> 01:14:02,700
所以 warp 只是线程块的 32 个元素块。
--And a warp is actually executed using a SIMD processing technique. 01:14:03,700 --> 01:14:08,700
并且 warp 实际上是使用 SIMD 处理技术执行的。
--But conceptually, it's just a 32 element chunk out of this larger computation you're trying to perform. 01:14:09,700 --> 01:14:17,700
但从概念上讲，它只是您尝试执行的更大计算中的一个 32 元素块。
--So it will schedule those dynamically. 01:14:18,700 --> 01:14:21,700
所以它会动态地安排那些。
--And then it will have a series of ALUs, a SIMD ALU capability that it can pull out to execute these. 01:14:21,700 --> 01:14:30,700
然后它将有一系列的 ALU，一个 SIMD ALU 能力，它可以拉出来执行这些。
--And the basic rule is at every given step, I've got some, I can execute one step. 01:14:31,700 --> 01:14:45,700
基本规则是在每个给定步骤，我有一些，我可以执行一个步骤。
--Each of these block SIMD ALUs can execute one step of one warp's computation. 01:14:46,700 --> 01:14:54,700
这些块 SIMD ALU 中的每一个都可以执行一个 warp 计算的一个步骤。
--And it will pick up which warps are available and run that. 01:14:55,700 --> 01:14:58,700
它将选择可用的 warp 并运行它。
--But it can do this by sort of a hyper-threading version of it. 01:14:59,700 --> 01:15:04,700
但它可以通过它的超线程版本来做到这一点。
--Time multiplexing these executions on these ALUs. 01:15:05,700 --> 01:15:08,700
在这些 ALU 上对这些执行进行时间复用。
--Because all of these thread blocks are independent of each other. 01:15:09,700 --> 01:15:12,700
因为所有这些线程块都是相互独立的。
--So they can be executed in any order scheduled purely according to resources. 01:15:12,700 --> 01:15:17,700
因此，它们可以按照纯粹根据资源安排的任何顺序执行。
--So for example, if one's doing a memory read, it's going to take a while. 01:15:18,700 --> 01:15:22,700
因此，例如，如果一个人正在读取内存，则需要一段时间。
--It can just go and start executing other ones as well. 01:15:23,700 --> 01:15:25,700
它也可以开始执行其他的。
--So this is a sort of ideal case of multi-threading within a processor. 01:15:26,700 --> 01:15:31,700
所以这是处理器内多线程的一种理想情况。
--And then there's shared memory is shared across all these threads. 01:15:32,700 --> 01:15:35,700
然后所有这些线程共享共享内存。
--But that's part of the reason why at the programming model you have this block model. 01:15:36,700 --> 01:15:40,700
但这就是为什么在编程模型中你有这个块模型的部分原因。
--And you're guaranteed certain things within a block. 01:15:40,700 --> 01:15:43,700
而且您可以保证块内的某些东西。
--You can have shared memory access. 01:15:44,700 --> 01:15:45,700
您可以共享内存访问。
--But you can't have shared memory access across blocks. 01:15:46,700 --> 01:15:48,700
但是你不能跨块共享内存访问。
--So within a block, the semantics are a little different than across blocks. 01:15:49,700 --> 01:15:52,700
因此，在一个块内，语义与跨块略有不同。
--I think we've kind of covered these ideas. 01:15:52,700 --> 01:16:10,700
我想我们已经涵盖了这些想法。
--And this just shows some of the hardware performance characteristics. 01:16:11,700 --> 01:16:15,700
而这只是展示了一些硬件性能特征。
--This is based on a slightly older model than the one we have. 01:16:16,700 --> 01:16:19,700
这是基于比我们拥有的模型稍旧的模型。
--The ones we have, all the numbers are a little bit better. 01:16:19,700 --> 01:16:22,700
我们拥有的那些，所有的数字都好一点。
--But not fundamentally different. 01:16:23,700 --> 01:16:24,700
但没有本质区别。
--The main point, and let me just finish off by saying this. 01:16:38,700 --> 01:16:41,700
要点，让我就这样结束吧。
--The main thing to understand is, if you can understand this model at all, 01:16:42,700 --> 01:16:46,700
主要要理解的是，如果你能完全理解这个模型，
--you'll have a better sense of what's really going on. 01:16:46,700 --> 01:16:48,700
您将更好地了解实际情况。
--So the real sense is that I've got a block of computation. 01:16:49,700 --> 01:16:53,700
所以真正的意义是我有一个计算块。
--I'm partitioning it into 32 elements at a time. 01:16:54,700 --> 01:16:57,700
我一次将它分成 32 个元素。
--That's called a warp. 01:16:58,700 --> 01:16:59,700
这就是所谓的扭曲。
--And each warp is a SIMD execution. 01:17:00,700 --> 01:17:02,700
每个 warp 都是一次 SIMD 执行。
--But I can run that across all the warps within a block. 01:17:03,700 --> 01:17:11,700
但我可以在一个块内的所有扭曲上运行它。
--I'll have the same things to do. 01:17:12,700 --> 01:17:14,700
我也会有同样的事情要做。
--If there's some conditional, just like in standard SIMD, 01:17:15,700 --> 01:17:18,700
如果有一些条件，就像在标准 SIMD 中一样，
--if it applies, I'll use sort of selective execution to decide which ones to do or not. 01:17:19,700 --> 01:17:27,700
如果适用，我将使用某种选择性执行来决定执行哪些操作或不执行哪些操作。
--And if a whole warp's worth have the same value of some conditional test, 01:17:28,700 --> 01:17:34,700
如果整个扭曲的价值与某些条件测试的价值相同，
--then it doesn't have to do it. 01:17:35,700 --> 01:17:36,700
那么它不必这样做。
--So it's not a pure SIMD model across the whole block. 01:17:37,700 --> 01:17:40,700
所以它不是整个街区的纯 SIMD 模型。
--But the rule has to be that I can execute blocks in any order. 01:17:41,700 --> 01:17:47,700
但规则必须是我可以按任何顺序执行块。
--So you'll see, for example, if you can't do a conventional picture of a, 01:17:48,700 --> 01:17:55,700
所以你会看到，例如，如果你不能做一个传统的图片，
--you know, wait for some, there's not like a semaphore type of operation within a block. 01:17:56,700 --> 01:18:02,700
你知道，等等，块中没有信号量类型的操作。
--There's atomic operations, like atomic add. 01:18:03,700 --> 01:18:06,700
有原子操作，比如原子添加。
--And the rule is simply that the addition will take place, 01:18:06,700 --> 01:18:10,700
规则很简单，加法会发生，
--but you're not guaranteed what the order is. 01:18:11,700 --> 01:18:12,700
但你不能保证订单是什么。
--So you can do atomic add of 1 here and 2 there. 01:18:13,700 --> 01:18:16,700
所以你可以在这里做 1 和 2 的原子加法。
--The final value will be incremented by 3. 01:18:17,700 --> 01:18:19,700
最终值将增加 3。
--But in whatever that takes place in, there's no guarantee. 01:18:20,700 --> 01:18:22,700
但无论发生什么，都无法保证。
--And you can see that's a fairly natural model on this execution, 01:18:23,700 --> 01:18:25,700
你可以看到在这次执行中这是一个相当自然的模型，
--that I'm just dynamically scheduling these warps in whatever order is convenient to execute. 01:18:26,700 --> 01:18:32,700
我只是按照方便执行的顺序动态安排这些扭曲。
--And so whether I do one increment before the other is just purely a chance ordering in the thread scheduler. 01:18:33,700 --> 01:18:39,700
因此，我是否在另一个增量之前执行一个增量纯粹是线程调度程序中的一次偶然排序。
--And so you have to write your programs in a way that that would affect the outcome. 01:18:40,700 --> 01:18:43,700
因此，您必须以影响结果的方式编写程序。
--So that's a very quick finish, but we have time for a few more questions if there are. 01:18:44,700 --> 01:18:49,700
所以这是一个非常快速的结束，但如果有的话，我们还有时间再问几个问题。
--Yes? 01:18:50,700 --> 01:18:51,700
是的？
--So these execution units, are they all, do they all mostly do the same operations? 01:18:51,700 --> 01:18:57,700
那么这些执行单元，他们都是，他们大部分都是做同样的操作吗？
--Can you in practice usually get a full, get all this compute power per cycle? 01:18:58,700 --> 01:19:07,700
在实践中，您通常可以在每个周期获得完整的、所有这些计算能力吗？
--It's, actually you'll find, like this thing, these things, 01:19:08,700 --> 01:19:12,700
事实上，你会发现，像这样的东西，这些东西，
--their peak execution capability is 8 teraflops. 01:19:13,700 --> 01:19:15,700
他们的峰值执行能力是 8 teraflops。
--And I will challenge you to make it go at 8 teraflops. 01:19:16,700 --> 01:19:20,700
我会挑战你让它以 8 teraflops 的速度运行。
--Your answer is no. 01:19:21,700 --> 01:19:22,700
你的答案是否定的。
--For the most part, you are way underutilizing this. 01:19:23,700 --> 01:19:26,700
在大多数情况下，您没有充分利用它。
--But they have so much horsepower that even if you're operating at 10% efficiency, 01:19:27,700 --> 01:19:32,700
但它们的马力如此之大，即使你以 10% 的效率运行，
--you're going really fast. 01:19:33,700 --> 01:19:35,700
你真快。
--So they're sort of, and then the performance tuners really do crank it up to there. 01:19:36,700 --> 01:19:41,700
所以他们有点，然后性能调谐器真的把它调到那里。
--But you'll find you're not. 01:19:42,700 --> 01:19:43,700
但你会发现你不是。
--But as long as your computation is sort of expressed in this way, 01:19:44,700 --> 01:19:47,700
但只要你的计算是以这种方式表达的，
--and you have various same operations performed over independent data, 01:19:47,700 --> 01:19:51,700
并且您对独立数据执行了各种相同的操作，
--you can really make things sing in this. 01:19:52,700 --> 01:19:53,700
你真的可以让事情在这里唱歌。
--And you'll find in this assignment that things that you wouldn't think would be independent, 01:19:54,700 --> 01:19:58,700
你会在这个作业中发现你认为不会独立的东西，
--you can do by various primitive operations. 01:19:59,700 --> 01:20:02,700
您可以通过各种原始操作来完成。
--So these are really quite remarkable pieces of hardware. 01:20:03,700 --> 01:20:06,700
所以这些都是非常了不起的硬件。
--Okay, thank you very much. 01:20:07,700 --> 01:20:08,700
好的，非常感谢。
