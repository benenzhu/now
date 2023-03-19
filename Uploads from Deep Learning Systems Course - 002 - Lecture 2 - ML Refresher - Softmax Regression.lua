--Hi everyone, and welcome to the second lecture of 00:00:00,000 --> 00:00:03,880
大家好，欢迎收看第二讲
--Deep Learning Systems Algorithms and Implementation. 00:00:03,880 --> 00:00:06,920
深度学习系统算法和实现。
--This lecture is going to be a refresher on the basics of 00:00:06,920 --> 00:00:11,080
本讲座将复习基础知识
--machine learning as well as a walkthrough of 00:00:11,080 --> 00:00:14,360
机器学习以及演练
--softmax regression as an example 00:00:14,360 --> 00:00:17,600
以softmax回归为例
--illustration of all the ingredients 00:00:17,600 --> 00:00:19,920
所有成分的插图
--of a machine learning algorithm. 00:00:19,920 --> 00:00:21,720
的机器学习算法。
--Now, this lecture is going to be 00:00:21,720 --> 00:00:23,320
现在，这个讲座将是
--a fairly quick run-through of basic machine learning, 00:00:23,320 --> 00:00:26,560
基本机器学习的相当快速的运行，
--and the expectation here is that 00:00:26,560 --> 00:00:27,880
这里的期望是
--this should be a refresher for you. 00:00:27,920 --> 00:00:30,080
这应该让你重温一下。
--You should have seen this in some form or another beforehand. 00:00:30,080 --> 00:00:33,240
您应该事先以某种形式看到这一点。
--Now, if you haven't, 00:00:33,240 --> 00:00:34,080
现在，如果你还没有，
--if you've seen it in a slightly different form, 00:00:34,080 --> 00:00:36,480
如果你看到它的形式略有不同，
--that's okay, but if this is all brand new information to you, 00:00:36,480 --> 00:00:40,840
没关系，但如果这对你来说都是全新的信息，
--then you probably want to look at 00:00:40,840 --> 00:00:42,960
那么你可能想看看
--kind of a more basic machine learning course 00:00:42,960 --> 00:00:44,960
一种更基础的机器学习课程
--before taking this more systems-focused 00:00:44,960 --> 00:00:47,200
在采取这种更注重系统的方式之前
--and a little bit more advanced course. 00:00:47,200 --> 00:00:49,600
和更高级的课程。
--So let's jump right in, talking about two things today. 00:00:49,600 --> 00:00:53,160
那么让我们直接进入，今天谈论两件事。
--We're gonna talk about the basics of machine learning, 00:00:53,160 --> 00:00:55,760
我们将讨论机器学习的基础知识，
--and then as I said, using this example 00:00:55,760 --> 00:00:57,440
然后正如我所说，使用这个例子
--of softmax regression or multi-class logistic regression 00:00:58,000 --> 00:01:01,200
softmax 回归或多类逻辑回归
--as kind of an illustrative example of these ideas. 00:01:01,200 --> 00:01:04,600
作为这些想法的一个说明性例子。
--All right, so first of all, the basics of machine learning. 00:01:05,520 --> 00:01:08,520
好吧，首先，机器学习的基础知识。
--Let's suppose you have the following task, 00:01:10,160 --> 00:01:12,520
假设您有以下任务，
--which in fact you will have in your homework. 00:01:12,520 --> 00:01:15,600
实际上，您的作业中会有。
--Suppose you want to take images of digits 00:01:15,600 --> 00:01:18,880
假设你想拍摄数字图像
--like the one you see here on the right, 00:01:18,880 --> 00:01:21,440
就像你在右边看到的那个，
--and write a program that will classify these 00:01:21,440 --> 00:01:25,080
并编写一个程序来对这些进行分类
--into one of nine, 10 different categories, 00:01:25,080 --> 00:01:28,640
分为九个，十个不同的类别之一，
--the digits zero through nine. 00:01:28,640 --> 00:01:30,560
数字零到九。
--Now, there are a few ways you could do this, 00:01:32,000 --> 00:01:34,040
现在，有几种方法可以做到这一点，
--but kind of the traditional, I would say, 00:01:34,040 --> 00:01:36,640
但有点传统，我会说，
--basic programming way to deal with this problem 00:01:37,720 --> 00:01:40,720
处理这个问题的基本编程方法
--is you sort of think hard for a little while 00:01:40,720 --> 00:01:43,040
你是不是想了一会儿
--about the nature of digits, right? 00:01:43,040 --> 00:01:44,880
关于数字的性质，对吧？
--You think kind of what makes a zero a zero, 00:01:44,880 --> 00:01:47,520
你认为是什么使零成为零，
--at least as far as an image is concerned, 00:01:47,520 --> 00:01:49,280
至少就图像而言，
--what makes a one a one, et cetera, 00:01:49,280 --> 00:01:52,400
是什么让一个成为一个等等，
--and you try to encapsulate this logic 00:01:52,400 --> 00:01:55,080
然后你尝试封装这个逻辑
--in a computer program. 00:01:55,080 --> 00:01:56,280
在计算机程序中。
--This is how we sort of learn to code most things. 00:01:56,280 --> 00:01:59,400
这就是我们学习编写大多数东西的方式。
--And when this is something like 00:01:59,400 --> 00:02:02,520
当这是像
--writing a program as sort of a list, 00:02:02,520 --> 00:02:04,320
将程序编写为列表，
--this is actually a great way to do things, right? 00:02:04,320 --> 00:02:06,080
这实际上是一种很好的做事方式，对吧？
--Because we can kind of structure logically the steps 00:02:06,080 --> 00:02:08,960
因为我们可以在逻辑上构建步骤
--of what it takes to sort of list, right? 00:02:08,960 --> 00:02:10,520
排序列表需要什么，对吗？
--The preconditions, the post conditions of each step 00:02:10,520 --> 00:02:12,800
每一步的前置条件、后置条件
--and build the logic that way. 00:02:12,800 --> 00:02:15,840
并以这种方式构建逻辑。
--But for many tasks like this image task, for example, 00:02:15,840 --> 00:02:19,520
但是对于像这个图像任务这样的许多任务，例如，
--this ends up being a pretty hard problem. 00:02:19,520 --> 00:02:22,840
这最终成为一个非常困难的问题。
--So I consider myself a reasonable coder, 00:02:23,880 --> 00:02:26,200
所以我认为自己是一个合理的编码器，
--at least normalized to professor level, 00:02:27,200 --> 00:02:29,080
至少标准化到教授水平，
--and also, I guess, excluding some outliers 00:02:29,080 --> 00:02:31,160
而且，我想，排除一些异常值
--like the other instructor of this course, 00:02:31,160 --> 00:02:33,480
像本课程的其他讲师一样，
--but normalized across all professors, 00:02:33,480 --> 00:02:35,560
但在所有教授中标准化，
--I'm a pretty good coder. 00:02:35,560 --> 00:02:37,560
我是一个很好的编码员。
--And I would find this task very hard. 00:02:37,560 --> 00:02:40,200
我会发现这项任务非常艰巨。
--I don't think I could do it very well. 00:02:40,200 --> 00:02:41,640
我不认为我能做得很好。
--Because again, computers don't see images the way we do. 00:02:41,640 --> 00:02:44,600
因为再次强调，计算机看图像的方式与我们不同。
--We look at these digits, we immediately see their form, 00:02:44,600 --> 00:02:47,480
我们看着这些数字，我们立即看到它们的形式，
--their structure, all this kind of stuff, 00:02:47,480 --> 00:02:48,720
他们的结构，所有这些东西，
--but computers don't see that. 00:02:48,720 --> 00:02:50,360
但电脑看不到。
--And to build all the logic about how you create, 00:02:50,360 --> 00:02:54,680
并建立关于你如何创造的所有逻辑，
--what makes a three a three and things like this, 00:02:54,680 --> 00:02:57,560
是什么让 3 变成 3 之类的东西，
--where do the shapes involve, what pixel values, right? 00:02:57,560 --> 00:03:00,880
形状在哪里，像素值是多少，对吗？
--How do you turn a grid of pixel values 00:03:00,880 --> 00:03:02,880
如何转动像素值网格
--into an actual classification of a digit? 00:03:02,880 --> 00:03:06,160
变成数字的实际分类？
--That would be quite hard for me actually to program. 00:03:06,160 --> 00:03:08,720
这对我来说实际上很难编程。
--And so we need to look, or at least we would like to look 00:03:08,720 --> 00:03:13,080
所以我们需要看看，或者至少我们想看看
--at some other way of solving these kinds of problems. 00:03:13,080 --> 00:03:16,600
以其他方式解决这类问题。
--And this is exactly what machine learning gives us. 00:03:16,600 --> 00:03:19,720
而这正是机器学习给我们的。
--Now, the machine learning approach to this problem, 00:03:19,720 --> 00:03:23,200
现在，机器学习方法解决这个问题，
--and I should be clear, 00:03:23,200 --> 00:03:24,040
我应该清楚，
--this is really the supervised machine learning 00:03:24,040 --> 00:03:26,200
这真的是有监督的机器学习
--approach to this problem. 00:03:26,200 --> 00:03:27,600
解决这个问题的方法。
--Supervised learning is the majority 00:03:27,600 --> 00:03:29,360
监督学习占多数
--of what we'll cover in this class, 00:03:29,360 --> 00:03:30,840
我们将在本课程中介绍的内容，
--though we will cover a bit of unsupervised learning 00:03:30,840 --> 00:03:33,160
尽管我们将介绍一些无监督学习
--later on in the class. 00:03:33,160 --> 00:03:34,960
后来在课堂上。
--But the supervised learning paradigm for this problem 00:03:34,960 --> 00:03:37,520
但是这个问题的监督学习范式
--is to say, it's hard for us to write a program 00:03:37,520 --> 00:03:41,120
就是说，我们很难写一个程序
--that can classify those digits. 00:03:41,120 --> 00:03:42,920
可以对这些数字进行分类。
--But what's pretty easy for us to do, relatively speaking, 00:03:42,920 --> 00:03:46,160
但相对来说，我们很容易做到的事情，
--is collect a bunch of images of digits 00:03:46,720 --> 00:03:49,280
是收集一堆数字图像
--along with their known labels, 00:03:49,280 --> 00:03:51,480
连同他们已知的标签，
--or their known target that we want to predict. 00:03:51,480 --> 00:03:54,000
或者我们想要预测的已知目标。
--And then, so we take a collection of these things, 00:03:55,760 --> 00:03:58,640
然后，我们收集这些东西，
--which we call our training data, right? 00:03:58,640 --> 00:04:00,360
我们称之为训练数据，对吗？
--And our training data essentially consists of these images, 00:04:00,360 --> 00:04:03,480
我们的训练数据基本上由这些图像组成，
--so this thing on the left here 00:04:03,480 --> 00:04:04,800
所以左边这个东西
--is supposed to be an image of a four, 00:04:04,800 --> 00:04:06,800
应该是四的图像，
--along with its true label four. 00:04:06,800 --> 00:04:09,320
连同其真正的标签四。
--And precisely because we are good at this, as humans, 00:04:09,320 --> 00:04:14,080
正是因为我们擅长于此，作为人类，
--we can do a good job with this. 00:04:14,080 --> 00:04:16,080
我们可以在这方面做得很好。
--And so, it's fairly straightforward to do this, 00:04:16,920 --> 00:04:18,960
所以，这样做相当简单，
--but to collect a training set like this. 00:04:18,960 --> 00:04:20,960
但是要收集这样的训练集。
--Now, what we do then, we take this training data 00:04:22,280 --> 00:04:24,440
现在，我们接下来要做的，我们采用这些训练数据
--and we feed it into a machine learning algorithm. 00:04:24,440 --> 00:04:27,320
我们将其输入机器学习算法。
--And from what this algorithm produces then, 00:04:28,720 --> 00:04:32,000
然后根据这个算法产生的结果，
--is a model H, produces some model, 00:04:32,000 --> 00:04:34,960
是模型 H，产生一些模型，
--which we call H, or hypothesis, 00:04:34,960 --> 00:04:37,000
我们称之为 H，或假设，
--or really you can think of this as a mini program. 00:04:37,000 --> 00:04:40,600
或者你真的可以把它想象成一个小程序。
--And the way this program works 00:04:40,600 --> 00:04:42,560
这个程序的工作方式
--is that if you feed in examples like these images, 00:04:42,560 --> 00:04:46,600
是如果你输入像这些图像这样的例子，
--it will produce the output four, 00:04:46,600 --> 00:04:48,240
它将产生输出四，
--at least approximately speaking. 00:04:48,240 --> 00:04:49,840
至少大约来说。
--And so, if I feed in examples, 00:04:50,720 --> 00:04:52,600
所以，如果我提供示例，
--like we see in the training set, in the training data, 00:04:52,600 --> 00:04:55,000
就像我们在训练集中看到的那样，在训练数据中，
--this will produce the desired output. 00:04:55,000 --> 00:04:57,240
这将产生所需的输出。
--Now, of course, what's important about this, 00:04:57,240 --> 00:04:59,240
现在，当然，重要的是，
--if you do this well, 00:04:59,240 --> 00:05:01,320
如果你做得好，
--it will work not just for examples 00:05:01,320 --> 00:05:03,560
它不仅适用于示例
--that were in our training data, 00:05:03,560 --> 00:05:05,000
在我们的训练数据中，
--but it will also work for pictures in general of digits, 00:05:05,000 --> 00:05:09,800
但它也适用于一般数字图片，
--right? 00:05:09,800 --> 00:05:10,640
正确的？
--And we actually won't talk about 00:05:10,640 --> 00:05:11,600
我们实际上不会谈论
--the intricacies here of generalization 00:05:12,160 --> 00:05:14,480
泛化的复杂性
--and what makes a good and generalizable function, 00:05:14,480 --> 00:05:17,520
是什么造就了一个好的和可推广的功能，
--because what we're gonna cover really 00:05:18,400 --> 00:05:20,040
因为我们真正要讲的
--in the majority of this class and this course 00:05:20,040 --> 00:05:22,960
在这门课和这门课的大部分时间里
--is this box here. 00:05:22,960 --> 00:05:24,880
这个盒子在这里吗？
--And what I wanna run through today 00:05:26,240 --> 00:05:27,640
而我今天想经历的
--is basically what does this box contain? 00:05:27,640 --> 00:05:29,520
这个盒子基本上包含什么？
--What does it actually have inside of it? 00:05:29,520 --> 00:05:31,560
它里面究竟有什么？
--And so, what this box contains 00:05:33,080 --> 00:05:36,840
那么，这个盒子里装的是什么
--is really three things. 00:05:36,840 --> 00:05:39,760
真的是三件事。
--And in fact, every machine learning algorithm, 00:05:39,760 --> 00:05:42,240
事实上，每一个机器学习算法，
--more or less, 00:05:42,240 --> 00:05:43,080
或多或少，
--consists of just three different elements. 00:05:43,080 --> 00:05:46,680
仅由三个不同的元素组成。
--And the three different ingredients are the following. 00:05:47,600 --> 00:05:50,480
三种不同的成分如下。
--The first is the hypothesis class. 00:05:50,480 --> 00:05:53,320
第一个是假设类。
--So, this basically specifies 00:05:53,320 --> 00:05:54,880
所以，这基本上指定
--what is the structure of that model H 00:05:54,880 --> 00:05:58,480
那个模型H的结构是什么
--that we actually are going to create 00:05:58,480 --> 00:06:01,080
我们实际上要创建
--with our machine learning algorithm. 00:06:01,080 --> 00:06:03,240
使用我们的机器学习算法。
--Now, typically, we say that this model 00:06:03,240 --> 00:06:05,040
现在，通常，我们说这个模型
--is parameterized by a set of parameters. 00:06:05,040 --> 00:06:08,120
由一组参数参数化。
--And what these parameters do 00:06:08,120 --> 00:06:09,840
以及这些参数的作用
--is these parameters specify the exact nature of this mapping. 00:06:09,840 --> 00:06:13,200
这些参数是否指定了此映射的确切性质。
--They specify sort of how a particular instance of a model 00:06:13,200 --> 00:06:17,240
他们指定模型的特定实例如何
--will map from its inputs to its outputs. 00:06:17,240 --> 00:06:20,560
将从它的输入映射到它的输出。
--That's the first ingredient of machine learning. 00:06:20,560 --> 00:06:23,040
这是机器学习的第一个要素。
--The second ingredient is the loss function. 00:06:23,040 --> 00:06:25,280
第二个要素是损失函数。
--And the loss function specifies 00:06:25,280 --> 00:06:27,320
并且损失函数指定
--what makes a good hypothesis. 00:06:27,320 --> 00:06:29,520
什么是一个好的假设。
--Well, how do we characterize 00:06:29,520 --> 00:06:31,000
那么，我们如何表征
--when a hypothesis is performing well on this problem? 00:06:31,000 --> 00:06:34,040
什么时候假设在这个问题上表现良好？
--And the last element of machine learning 00:06:35,040 --> 00:06:38,160
机器学习的最后一个要素
--is an optimization procedure. 00:06:38,160 --> 00:06:40,360
是一个优化过程。
--And this is essentially the way 00:06:40,360 --> 00:06:41,840
这就是本质上的方式
--that we optimize over the parameters 00:06:41,840 --> 00:06:44,720
我们优化了参数
--to find a set of parameters 00:06:44,720 --> 00:06:46,360
找到一组参数
--that approximately minimize the sum of losses 00:06:46,360 --> 00:06:49,040
近似最小化损失总和
--on our training set. 00:06:49,040 --> 00:06:50,040
在我们的训练集上。
--And what's really amazing 00:06:51,480 --> 00:06:53,080
真正令人惊奇的是
--is that all machine learning algorithms, 00:06:53,080 --> 00:06:55,400
是所有的机器学习算法，
--whether they be deep learning algorithms 00:06:55,400 --> 00:06:56,960
是否是深度学习算法
--or simple sort of linear classifiers 00:06:56,960 --> 00:06:59,680
或简单的线性分类器
--or gradient boosting 00:06:59,680 --> 00:07:01,360
或梯度提升
--or really anything you can propose, 00:07:01,360 --> 00:07:03,840
或者任何你能提出的建议，
--all of them, at least supervised learning, 00:07:04,560 --> 00:07:05,400
所有这些，至少是监督学习，
--though unsupervised learning actually also fits this mold 00:07:05,400 --> 00:07:08,240
尽管无监督学习实际上也适合这种模式
--to a certain degree as well, 00:07:08,240 --> 00:07:10,520
也在一定程度上，
--all the algorithms that we have in machine learning 00:07:10,520 --> 00:07:12,560
我们在机器学习中拥有的所有算法
--fit this basic structure. 00:07:12,560 --> 00:07:14,280
适合这个基本结构。
--And so even though there seem to be hundreds, 00:07:15,360 --> 00:07:18,200
所以即使看起来有数百个，
--thousands of machine learning algorithms sometimes, 00:07:18,200 --> 00:07:19,800
有时有成千上万的机器学习算法，
--it's kind of hard to keep up with just how many there are, 00:07:19,800 --> 00:07:22,960
很难跟上到底有多少，
--one thing that's very helpful 00:07:22,960 --> 00:07:24,440
一件非常有帮助的事情
--is understanding how each of these algorithms 00:07:24,440 --> 00:07:27,640
正在了解这些算法中的每一个
--fits into this framework. 00:07:27,640 --> 00:07:29,200
适合这个框架。
--Because there aren't really 00:07:29,200 --> 00:07:31,840
因为真的没有
--thousands of machine learning algorithms, 00:07:31,840 --> 00:07:33,160
数以千计的机器学习算法，
--there's basically one. 00:07:33,480 --> 00:07:34,640
基本上有一个。
--There's one algorithm that sort of has to specify 00:07:34,640 --> 00:07:37,960
有一种算法必须指定
--these three different components, 00:07:37,960 --> 00:07:40,200
这三个不同的组成部分，
--and then you have your actual sort of instantiation 00:07:40,200 --> 00:07:43,200
然后你有你实际的实例化
--of a machine learning algorithm. 00:07:43,200 --> 00:07:44,800
的机器学习算法。
--All right, so what we're gonna do 00:07:46,640 --> 00:07:47,920
好吧，那我们要做什么
--with the rest of this class then 00:07:47,920 --> 00:07:50,520
然后和这个班级的其他人一起
--is look in some detail at softmax regression, 00:07:50,520 --> 00:07:55,520
详细了解 softmax 回归，
--also known, as I mentioned, 00:07:55,560 --> 00:07:56,800
正如我提到的，也众所周知，
--as multiclass logistic regression, 00:07:56,800 --> 00:07:59,880
作为多类逻辑回归，
--and illustrate these basic components 00:07:59,880 --> 00:08:03,960
并说明这些基本组件
--in the context of softmax regression. 00:08:03,960 --> 00:08:07,200
在 softmax 回归的背景下。
--Now, as I said, again, I'm going to repeat, 00:08:07,200 --> 00:08:09,400
现在，正如我所说的，我要重复一遍，
--we're gonna go through this quite quickly, 00:08:09,400 --> 00:08:12,120
我们会很快通过这个，
--and some of these topics, if you have not seen before, 00:08:12,120 --> 00:08:14,680
其中一些主题，如果你以前没见过，
--this would likely be too fast to go through. 00:08:14,680 --> 00:08:17,600
这可能太快而无法通过。
--But what I want to do is just highlight 00:08:18,680 --> 00:08:21,400
但我想做的只是突出显示
--how softmax regression exemplifies these different elements, 00:08:21,400 --> 00:08:26,320
softmax 回归如何举例说明这些不同的元素，
--and really you can do the same sort of thing 00:08:26,320 --> 00:08:28,280
你真的可以做同样的事情
--for any algorithm. 00:08:28,720 --> 00:08:30,600
对于任何算法。
--But we're gonna use softmax regression as an example 00:08:30,600 --> 00:08:33,120
但我们将以 softmax 回归为例
--before next class then moving to basic neural networks. 00:08:33,120 --> 00:08:36,960
在下一节课之前，然后转到基本的神经网络。
--All right, before I actually define 00:08:39,080 --> 00:08:40,760
好吧，在我真正定义之前
--these three ingredients, though, for softmax regression, 00:08:40,760 --> 00:08:43,600
不过，这三个要素对于 softmax 回归来说，
--I want to start off with our basic setting. 00:08:43,600 --> 00:08:45,720
我想从我们的基本设置开始。
--So our setting here that we're talking about 00:08:45,720 --> 00:08:47,840
所以我们在这里谈论的设置
--is multiclass classification. 00:08:47,840 --> 00:08:50,240
是多类分类。
--In particular, a K-class classification setting, 00:08:51,360 --> 00:08:53,520
特别地，K级分类设置，
--where I say there's K different classes. 00:08:53,520 --> 00:08:55,920
我说有 K 个不同的班级。
--And what we have in the settings, 00:08:55,960 --> 00:08:57,240
我们在设置中拥有的，
--we have training data, where the inputs to our system 00:08:57,240 --> 00:09:01,000
我们有训练数据，我们系统的输入
--are vectors XI, and the notation here, XI being in RN, 00:09:01,000 --> 00:09:06,000
是向量 XI，这里的符号，XI 在 RN 中，
--means that XI are N-dimensional vectors 00:09:06,280 --> 00:09:09,200
表示 XI 是 N 维向量
--with real value quantities. 00:09:09,200 --> 00:09:10,880
具有实际价值的数量。
--So essentially, each XI would look something like this. 00:09:10,880 --> 00:09:14,240
所以从本质上讲，每个 XI 看起来都像这样。
--It would look like a big vector 00:09:14,240 --> 00:09:16,440
它看起来像一个大向量
--specifying the different elements 00:09:16,440 --> 00:09:20,200
指定不同的元素
--from XI1 to XIN, 00:09:20,200 --> 00:09:23,600
从 XI1 到 XIN，
--specifying the different elements of XI. 00:09:23,600 --> 00:09:26,160
指定 XI 的不同元素。
--And in the case of, for example, these images, 00:09:28,120 --> 00:09:31,120
例如，在这些图像的情况下，
--these images of digits you just saw, 00:09:31,120 --> 00:09:32,960
你刚刚看到的这些数字图像，
--this could be the, these elements here 00:09:32,960 --> 00:09:34,720
这可能是这里的这些元素
--will be the different pixel value intensities in the image. 00:09:34,720 --> 00:09:38,280
将是图像中不同的像素值强度。
--The next thing we have is the outputs, 00:09:40,520 --> 00:09:43,280
接下来是输出，
--or desired sort of, the desired outputs of our algorithm, 00:09:43,280 --> 00:09:46,080
或期望的排序，我们算法的期望输出，
--all the, or the calls called the targets, 00:09:46,080 --> 00:09:47,640
所有的，或称为目标的电话，
--or outputs, or they're called several things like this. 00:09:47,640 --> 00:09:50,320
或输出，或者它们被称为这样的几个东西。
--And these outputs, YI, are scalar quantities, 00:09:50,360 --> 00:09:55,360
这些输出 YI 是标量，
--which really they're, 00:09:55,480 --> 00:09:56,320
他们真的是，
--because we're talking about a classification challenge, 00:09:56,320 --> 00:09:58,720
因为我们在谈论分类挑战，
--the, or classification problem, 00:09:58,720 --> 00:10:00,240
或分类问题，
--these are discrete values that range from one to K, 00:10:00,240 --> 00:10:04,480
这些是离散值，范围从 1 到 K，
--where K is our number of classes. 00:10:04,480 --> 00:10:06,320
其中 K 是我们的班级数量。
--And finally, I here, 00:10:07,880 --> 00:10:09,600
最后，我在这里，
--indexes over the examples in our training set. 00:10:09,600 --> 00:10:13,200
索引我们训练集中的示例。
--So I ranges from one to M, 00:10:13,200 --> 00:10:15,240
所以我的范围是从一到M，
--and indexes over the different samples, 00:10:15,240 --> 00:10:19,200
和索引不同的样本，
--or examples in our training set. 00:10:19,200 --> 00:10:21,000
或我们训练集中的例子。
--So this particular notation, 00:10:22,000 --> 00:10:23,360
所以这个特殊的符号，
--I'm gonna be consistent with it throughout the course here, 00:10:23,360 --> 00:10:25,160
我会在整个课程中始终如一，
--and it's important to sort of remember 00:10:25,160 --> 00:10:26,320
重要的是要记住
--the different things, 00:10:26,320 --> 00:10:27,160
不同的东西，
--because they will do things like affect the dimensionality 00:10:27,160 --> 00:10:29,760
因为他们会做一些影响维度的事情
--of the vectors we care about. 00:10:29,760 --> 00:10:31,560
我们关心的向量。
--But throughout this lecture, 00:10:31,560 --> 00:10:33,360
但在整个讲座中，
--and for the majority of this course, 00:10:33,360 --> 00:10:36,440
对于本课程的大部分内容，
--N is going to represent the dimensionality 00:10:36,440 --> 00:10:39,320
 N 代表维度
--of the input data. 00:10:39,320 --> 00:10:40,160
输入数据。
--So this is, you know, how big of a vector is our input. 00:10:40,160 --> 00:10:43,840
所以这是，你知道，我们的输入有多大的向量。
--K will be the number of classes, 00:10:43,840 --> 00:10:46,080
 K 将是类的数量，
--how many outputs we're trying to predict, 00:10:46,080 --> 00:10:48,200
我们试图预测多少输出，
--and, or how many different classes do the outputs take on. 00:10:48,200 --> 00:10:51,600
和，或者输出有多少个不同的类别。
--And M is going to be the number of points 00:10:51,600 --> 00:10:54,320
 M 将是点数
--in our training set, 00:10:54,320 --> 00:10:55,160
在我们的训练集中，
--the number of examples we have in our training data. 00:10:55,160 --> 00:10:57,880
我们在训练数据中拥有的示例数量。
--And so for example, 00:10:58,760 --> 00:11:00,120
例如，
--in the case of our M NIST digit classification problem, 00:11:00,120 --> 00:11:04,920
对于我们的 M NIST 数字分类问题，
--in that particular example, 00:11:04,920 --> 00:11:06,760
在那个特定的例子中，
--N is equal to 784, 00:11:06,760 --> 00:11:11,520
 N等于784，
--because our digits in that case 00:11:11,520 --> 00:11:13,400
因为在那种情况下我们的数字
--are actually represented as grids of 28 by 28 pixels, 00:11:13,400 --> 00:11:17,880
实际上表示为 28 x 28 像素的网格，
--and each position, 00:11:18,200 --> 00:11:19,040
而每一个位置，
--each pixel position has a grayscale scalar value, 00:11:19,040 --> 00:11:24,040
每个像素位置都有一个灰度标量值，
--actually ranges from zero to one, 00:11:24,520 --> 00:11:26,480
实际上范围从零到一，
--think of it as, 00:11:26,480 --> 00:11:27,720
把它想象成
--and this is how we represent our image. 00:11:27,720 --> 00:11:30,760
这就是我们展示我们形象的方式。
--So there are 784 dimensions of our image. 00:11:30,760 --> 00:11:33,600
所以我们的图像有 784 个维度。
--There are 10 classes in our example there, 00:11:34,440 --> 00:11:38,240
在我们的示例中有 10 个类，
--because we have 10 different categories 00:11:38,240 --> 00:11:40,320
因为我们有 10 个不同的类别
--we're trying to categorize each digit as, 00:11:40,320 --> 00:11:42,360
我们试图将每个数字归类为
--namely the numbers zero through nine. 00:11:42,360 --> 00:11:44,880
即数字零到九。
--And finally, in this case, 00:11:44,880 --> 00:11:46,080
最后，在这种情况下，
--there happened to be 60,000 examples in our training set. 00:11:46,080 --> 00:11:50,680
我们的训练集中恰好有 60,000 个示例。
--So K, N, K, and M take on these values 00:11:50,680 --> 00:11:55,520
所以 K、N、K 和 M 取这些值
--for the example of the M NIST data you will work with, 00:11:55,520 --> 00:11:58,800
对于您将使用的 M NIST 数据示例，
--but of course for other problems, 00:11:58,800 --> 00:12:00,480
但当然对于其他问题，
--they'll take on different values. 00:12:00,480 --> 00:12:02,120
他们将采用不同的价值观。
--All right, now let's talk about the hypothesis function 00:12:04,040 --> 00:12:08,360
好了，现在我们来谈谈假设函数
--that we think of 00:12:08,360 --> 00:12:09,520
我们想到的
--when we talk about K dimensional classification. 00:12:09,520 --> 00:12:13,080
当我们谈论K维分类时。
--And in particular, 00:12:13,080 --> 00:12:13,920
特别是，
--we'll also talk about the linear hypothesis class 00:12:13,920 --> 00:12:16,400
我们还将讨论线性假设类
--that softmax regression uses. 00:12:16,400 --> 00:12:18,000
softmax 回归使用的。
--But first, more generally speaking, 00:12:18,960 --> 00:12:21,120
但首先，更一般地说，
--a hypothesis function, 00:12:21,120 --> 00:12:22,520
一个假设函数，
--remember this is core of that first ingredient 00:12:22,520 --> 00:12:24,520
记住这是第一种成分的核心
--of our machine learning program, 00:12:24,520 --> 00:12:27,920
我们的机器学习计划，
--is a function that maps vectors in R N, 00:12:27,920 --> 00:12:32,160
是在 RN 中映射向量的函数，
--those are the inputs, 00:12:32,160 --> 00:12:33,200
这些是输入，
--that's the dimensionality of our input, 00:12:33,200 --> 00:12:35,080
那是我们输入的维度，
--to real valued vectors in R K. 00:12:35,080 --> 00:12:38,280
到 R K 中的实值向量。
--Now this is a bit confusing, 00:12:39,360 --> 00:12:41,360
现在这有点令人困惑，
--seem a bit counterintuitive at first, 00:12:41,840 --> 00:12:44,880
乍一看有点违反直觉，
--because we think of hypothesis 00:12:44,880 --> 00:12:46,000
因为我们想到假设
--as generating our outputs, right? 00:12:46,000 --> 00:12:47,600
作为生成我们的输出，对吧？
--Which are the numbers one through K. 00:12:47,600 --> 00:12:52,040
从 1 到 K 有哪些数字。
--But in this case, for various reasons, 00:12:53,200 --> 00:12:55,240
但在这种情况下，由于种种原因，
--which we'll cover in a second, 00:12:55,240 --> 00:12:56,240
我们将在一秒钟内介绍，
--we really want hypothesis classes 00:12:56,240 --> 00:12:57,800
我们真的想要假设类
--that output a bit more smooth indications 00:12:57,800 --> 00:13:01,600
输出更平滑的指示
--of how likely in some sense, 00:13:01,600 --> 00:13:03,520
在某种意义上有多大可能，
--in some very informal sense, 00:13:03,520 --> 00:13:04,960
在某种非常非正式的意义上，
--we think each output is. 00:13:04,960 --> 00:13:07,520
我们认为每个输出都是。
--And so in the classification setting, 00:13:07,520 --> 00:13:10,920
所以在分类设置中，
--we don't actually have outputs 00:13:10,920 --> 00:13:12,880
我们实际上没有输出
--that are just the discrete classes. 00:13:12,880 --> 00:13:15,080
那只是离散的类。
--We have the output of a hypothesis function, 00:13:15,080 --> 00:13:17,320
我们有一个假设函数的输出，
--again, being this K dimensional vector, 00:13:17,320 --> 00:13:19,360
同样，作为这个 K 维向量，
--where K here is the number of classes. 00:13:19,360 --> 00:13:23,120
这里的 K 是类的数量。
--And in particular, in this setting, 00:13:23,120 --> 00:13:25,440
特别是，在这种情况下，
--H sub I, so that would be the I element of our output, 00:13:25,440 --> 00:13:28,480
 H sub I，所以这将是我们输出的 I 元素，
--right? 00:13:28,480 --> 00:13:29,320
正确的？
--So our output, remember, is vector valued. 00:13:29,320 --> 00:13:30,600
所以我们的输出，记住，是向量值的。
--So we would write something like 00:13:30,600 --> 00:13:31,920
所以我们会写类似的东西
--H of X equals a vector, 00:13:31,920 --> 00:13:35,720
X的H等于向量，
--where the first component is H one of X, 00:13:35,720 --> 00:13:37,920
其中第一个分量是 X 中的 H，
--all the way down to H K of X. 00:13:37,920 --> 00:13:41,440
一直到 X 的 HK。
--And here, the I component indicates in some sense 00:13:41,440 --> 00:13:46,440
在这里，I 组件在某种意义上表示
--how likely the class is to be class I. 00:13:46,600 --> 00:13:51,200
该班级成为 I 班级的可能性有多大。
--So for example, this component here 00:13:52,240 --> 00:13:54,920
例如，这里的这个组件
--would give some indication of how likely 00:13:54,920 --> 00:13:57,280
会给出一些可能性的迹象
--the class was to be class one. 00:13:57,280 --> 00:14:00,040
该班级是一年级。
--Next one, class two, up down to class K. 00:14:00,040 --> 00:14:02,760
下一个，二班，一直到 K 班。
--And I'm using the term sort of likely 00:14:04,200 --> 00:14:06,560
我使用的术语有点可能
--or belief here in very big quotation marks, 00:14:06,560 --> 00:14:09,480
或者相信这里有非常大的引号，
--because these are not yet probabilities 00:14:09,480 --> 00:14:11,520
因为这些还不是概率
--or anything like that. 00:14:11,520 --> 00:14:12,360
或类似的东西。
--We're gonna actually talk about 00:14:12,360 --> 00:14:13,200
我们实际上要谈谈
--sort of a probabilistic interpretation in a moment. 00:14:13,200 --> 00:14:16,440
一会儿是一种概率解释。
--But for now, these are just to be thought 00:14:16,440 --> 00:14:17,840
但就目前而言，这些只是需要考虑的
--as some indication of the likelihood 00:14:17,840 --> 00:14:20,760
作为可能性的一些指示
--or the, shouldn't even use that word, 00:14:20,760 --> 00:14:22,480
或者，甚至不应该使用那个词，
--the belief that the output is in fact class I 00:14:22,480 --> 00:14:27,480
相信输出实际上是 I 类
--for this element H I. 00:14:28,520 --> 00:14:30,040
对于这个元素 H I。
--Now, in the case of a linear hypothesis class, 00:14:32,160 --> 00:14:35,360
现在，在线性假设类的情况下，
--there's a particular instantiation 00:14:35,360 --> 00:14:37,400
有一个特定的实例化
--of this general hypothesis function, 00:14:37,400 --> 00:14:40,520
这个一般假设函数，
--where H takes the following form. 00:14:40,520 --> 00:14:42,720
其中 H 采用以下形式。
--All right, we say that H sub theta, 00:14:43,880 --> 00:14:45,320
好吧，我们说 H sub theta，
--and we use this notation H sub theta here 00:14:45,320 --> 00:14:48,240
我们在这里使用这个符号 H sub theta
--to denote the fact that theta are our parameters. 00:14:48,240 --> 00:14:51,000
表示 theta 是我们的参数。
--And H is really a, 00:14:51,000 --> 00:14:53,120
 H真的是一个，
--even though we think of H as a function of inputs, outputs, 00:14:53,120 --> 00:14:56,160
尽管我们认为 H 是输入、输出的函数，
--H is really also a function of the parameters, 00:14:56,160 --> 00:14:58,480
 H 实际上也是参数的函数，
--depends on our parameters. 00:14:58,480 --> 00:14:59,600
取决于我们的参数。
--So we write H sub theta. 00:14:59,600 --> 00:15:00,960
所以我们写下 H sub theta。
--And in this case, we're gonna write 00:15:02,160 --> 00:15:04,080
在这种情况下，我们要写
--that H sub theta of X is equal to just 00:15:04,080 --> 00:15:07,160
X 的 H sub theta 等于
--theta transpose times X, 00:15:07,160 --> 00:15:09,640
θ 转置 X，
--where theta here is a matrix, 00:15:09,640 --> 00:15:13,880
这里的 theta 是一个矩阵，
--which has N rows and K columns. 00:15:13,880 --> 00:15:17,520
它有 N 行和 K 列。
--And just sort of to make sure these sizes make sense, 00:15:18,640 --> 00:15:21,880
只是为了确保这些尺寸有意义，
--right, let's make sure that in fact, 00:15:21,880 --> 00:15:23,400
是的，让我们确定事实上，
--this all is a legitimate operation. 00:15:23,400 --> 00:15:26,040
这一切都是合法的操作。
--Theta would be an N by K matrix. 00:15:26,040 --> 00:15:29,440
 Theta 将是一个 N × K 矩阵。
--So theta transpose, 00:15:29,440 --> 00:15:31,200
所以 theta 转置，
--and we just use the transpose actually kind of 00:15:31,200 --> 00:15:32,760
我们实际上只是使用转置
--for reasons of convention. 00:15:32,760 --> 00:15:35,440
出于约定的原因。
--In the one dimensional case, 00:15:35,440 --> 00:15:37,560
在一维情况下，
--there's sort of a, 00:15:37,560 --> 00:15:39,160
有一种，
--this makes a bit more sense. 00:15:39,160 --> 00:15:40,640
这更有意义。
--So we often use a transpose here. 00:15:40,640 --> 00:15:42,360
所以我们这里经常使用转置。
--You don't have to use it. 00:15:42,360 --> 00:15:43,200
你不必使用它。
--In fact, we'll give it up shortly 00:15:43,200 --> 00:15:44,360
事实上，我们很快就会放弃
--when we talk about the more standard notation 00:15:44,360 --> 00:15:46,160
当我们谈论更标准的符号时
--for deep learning. 00:15:46,160 --> 00:15:47,280
用于深度学习。
--But transpose just swaps the rows and columns of the matrix. 00:15:47,280 --> 00:15:50,160
但是转置只是交换矩阵的行和列。
--And so the theta transpose would be a K by N 00:15:50,160 --> 00:15:55,160
因此 theta 转置将是 N 乘以 K
--dimensional matrix 00:15:57,720 --> 00:16:00,960
维矩阵
--times, well, we think of vectors as being column vectors. 00:16:01,600 --> 00:16:05,240
好吧，我们有时会将向量视为列向量。
--This would be an N by one dimensional matrix. 00:16:05,240 --> 00:16:08,080
这将是一个 N 乘一维矩阵。
--So their product as desired 00:16:08,080 --> 00:16:10,080
所以他们的产品如愿
--would be a K by one dimensional matrix, 00:16:10,080 --> 00:16:13,640
将是一个 K 乘以一维矩阵，
--really, i.e. a K dimensional vector. 00:16:13,640 --> 00:16:15,560
真的，即K维向量。
--So we are in fact, 00:16:15,560 --> 00:16:16,400
所以我们实际上是
--correctly mapping from N dimensional inputs 00:16:16,400 --> 00:16:19,040
从 N 维输入正确映射
--to K dimensional outputs. 00:16:19,040 --> 00:16:20,720
到 K 维输出。
--And in fact, in some sense, 00:16:20,720 --> 00:16:21,760
事实上，从某种意义上说，
--this is a linear transform between those two dimensions. 00:16:21,760 --> 00:16:24,600
这是这两个维度之间的线性变换。
--It's in some sense, 00:16:24,600 --> 00:16:26,240
从某种意义上来说，
--one of the simplest possible mappings 00:16:26,240 --> 00:16:28,920
最简单的映射之一
--or hypothesis functions you could really have 00:16:28,920 --> 00:16:31,200
或者你真的可以拥有的假设函数
--that maps between these two quantities. 00:16:31,200 --> 00:16:33,200
在这两个量之间映射。
--Okay, so before we move on to the, 00:16:35,880 --> 00:16:39,440
好的，在我们继续之前，
--this is actually going to be the hypothesis function 00:16:39,440 --> 00:16:42,440
这实际上是假设函数
--for softmax regression. 00:16:42,440 --> 00:16:45,440
对于 softmax 回归。
--But before we move on to the second element, 00:16:45,440 --> 00:16:48,200
但在我们继续第二个元素之前，
--which is the loss function, 00:16:48,200 --> 00:16:50,000
这是损失函数，
--we want to take a brief detour 00:16:50,000 --> 00:16:51,760
我们想绕个弯
--and talk about matrix batch notation. 00:16:51,760 --> 00:16:55,040
并讨论矩阵批处理符号。
--So it's often more convenient. 00:16:56,040 --> 00:16:59,680
所以它通常更方便。
--We sort of, in the previous slide, 00:16:59,680 --> 00:17:01,520
我们在上一张幻灯片中，
--wrote out the hypothesis as a function of a single example. 00:17:01,520 --> 00:17:05,240
将假设写成单个示例的函数。
--So applied to this single example in our training set, 00:17:05,240 --> 00:17:08,120
所以应用于我们训练集中的这个单一例子，
--this is the form of the hypothesis function. 00:17:08,120 --> 00:17:11,040
这是假设函数的形式。
--But it turns out in many settings to be more convenient 00:17:11,040 --> 00:17:14,360
但事实证明在许多设置中更方便
--to write things, 00:17:14,360 --> 00:17:15,640
写东西，
--not in terms of sort of the application of the hypothesis 00:17:15,640 --> 00:17:19,040
不是在假设的应用方面
--to a single example, but to many examples at once. 00:17:19,040 --> 00:17:23,000
一个例子，但一次很多例子。
--And we're gonna do this 00:17:23,000 --> 00:17:24,880
我们要这样做
--with matrix notation for our operations. 00:17:24,880 --> 00:17:28,960
用矩阵符号表示我们的操作。
--Now, it turns out this is actually more than just 00:17:28,960 --> 00:17:31,760
现在，事实证明这实际上不仅仅是
--kind of a mathematical nice to be as well. 00:17:31,760 --> 00:17:35,080
一种数学也很好。
--This is also going to be really important 00:17:35,080 --> 00:17:37,480
这也将非常重要
--when we come to implementing these operations efficiently. 00:17:37,480 --> 00:17:41,640
当我们开始有效地实施这些操作时。
--Basically, because matrix operations are much more efficient 00:17:41,640 --> 00:17:46,280
基本上，因为矩阵运算效率更高
--than carrying out many vector operations. 00:17:46,280 --> 00:17:50,040
而不是执行许多矢量操作。
--And because of this, it winds up, 00:17:51,000 --> 00:17:53,760
正因为如此，它结束了，
--not just on GPUs, but also on CPUs, 00:17:53,760 --> 00:17:56,480
不仅在 GPU 上，而且在 CPU 上，
--being incredibly important to implement things 00:17:56,480 --> 00:17:59,160
对实施事情非常重要
--in matrix batch form for efficiency of execution. 00:17:59,160 --> 00:18:03,840
以矩阵批处理形式提高执行效率。
--And so this matrix batch notation, 00:18:03,840 --> 00:18:06,160
所以这个矩阵批处理符号，
--I'm sort of harping on a little bit here, 00:18:06,160 --> 00:18:09,480
我在这里有点唠叨，
--because I don't just want to emphasize, 00:18:09,480 --> 00:18:11,040
因为我不只是想强调，
--it's not just a notational nicety, though it is. 00:18:11,040 --> 00:18:14,200
尽管确实如此，但它不仅仅是符号上的精确性。
--Once you get used to it, it's very nice. 00:18:14,200 --> 00:18:16,960
一旦你习惯了，它就非常好。
--What it really is, is it's a way also 00:18:17,000 --> 00:18:19,600
究竟是什么，是不是也是一种方式
--of carrying out these operations more efficiently in code. 00:18:19,600 --> 00:18:23,280
在代码中更有效地执行这些操作。
--And so you want to be familiar, 00:18:23,280 --> 00:18:25,080
所以你想熟悉，
--not just with how to write these things 00:18:25,080 --> 00:18:26,600
不仅仅是如何写这些东西
--as a bunch of for loops, 00:18:26,600 --> 00:18:27,440
作为一堆 for 循环，
--but how to write them really as efficient matrix operations. 00:18:27,440 --> 00:18:31,480
但是如何将它们真正写成高效的矩阵运算。
--So we're going to define a batch matrix, big X, 00:18:32,600 --> 00:18:37,600
所以我们要定义一个批量矩阵，大X，
--which is going to be a matrix, which is M by N. 00:18:38,520 --> 00:18:42,520
这将是一个矩阵，即 M×N。
--Remember, M is the number of examples, 00:18:42,520 --> 00:18:45,480
请记住，M 是示例数，
--and N is the dimensionality of the input. 00:18:45,520 --> 00:18:47,960
 N是输入的维数。
--And what this matrix is, is this matrix 00:18:48,840 --> 00:18:50,640
这个矩阵是什么，这个矩阵
--is just a stacking of all of the examples 00:18:50,640 --> 00:18:55,640
只是所有示例的堆叠
--in our training set. 00:18:55,840 --> 00:18:57,520
在我们的训练集中。
--So in particular, the first element, 00:18:57,520 --> 00:18:59,720
所以特别是第一个元素，
--or the first row in this matrix, 00:18:59,720 --> 00:19:01,960
或者这个矩阵的第一行，
--is equal to the first example, X1. 00:19:03,080 --> 00:19:06,680
等于第一个例子，X1。
--But because X, our examples, 00:19:06,680 --> 00:19:08,960
但是因为 X，我们的例子，
--we typically think of vectors as column vectors, 00:19:08,960 --> 00:19:11,040
我们通常将向量视为列向量，
--to make it a row vector, we have to transpose it. 00:19:11,040 --> 00:19:13,720
为了使它成为一个行向量，我们必须转置它。
--So the first row is this transposed vector. 00:19:13,720 --> 00:19:17,240
所以第一行是这个转置向量。
--Second row would be the second example, transposed, 00:19:18,640 --> 00:19:21,920
第二行是第二个例子，转置，
--down to the Mth example, transposed. 00:19:21,920 --> 00:19:25,000
向下到第 M 个例子，转置。
--And that's going to be our design matrix 00:19:26,000 --> 00:19:29,560
这将是我们的设计矩阵
--containing all the examples in our training set. 00:19:29,560 --> 00:19:32,280
包含我们训练集中的所有示例。
--We're going to do a similar thing 00:19:34,400 --> 00:19:35,800
我们要做类似的事情
--for the outputs, the targets. 00:19:35,800 --> 00:19:39,320
对于输出，目标。
--We're going to form a M dimensional, 00:19:39,320 --> 00:19:41,760
我们要形成一个M维，
--now it's just a vector, in fact, 00:19:41,760 --> 00:19:43,000
现在它只是一个向量，事实上，
--because each output is scalar value. 00:19:43,040 --> 00:19:46,000
因为每个输出都是标量值。
--They're discrete, but they're still scalar value, 00:19:46,000 --> 00:19:47,800
它们是离散的，但它们仍然是标量值，
--between one and K. 00:19:47,800 --> 00:19:49,320
在一和 K 之间。
--And so we think of a stacking of all these things 00:19:49,320 --> 00:19:52,400
所以我们想到了所有这些东西的堆叠
--as just a vector, an M dimensional vector, 00:19:52,400 --> 00:19:57,240
作为一个向量，一个 M 维向量，
--which contains, as its first element, 00:19:57,240 --> 00:19:59,680
其中包含，作为它的第一个元素，
--Y1 and Y2, all the way down to Y now. 00:19:59,680 --> 00:20:02,400
 Y1 和 Y2，一直到现在的 Y。
--And the nice thing about this notation, 00:20:04,760 --> 00:20:06,360
这个符号的好处是，
--is that not only can we apply it 00:20:06,360 --> 00:20:07,920
是我们不仅可以应用它
--to the basic matrices X and Y, 00:20:07,920 --> 00:20:10,280
到基本矩阵 X 和 Y，
--we can also think of the hypothesis function 00:20:10,320 --> 00:20:13,720
我们也可以考虑假设函数
--as applying to an entire batch at a time. 00:20:13,720 --> 00:20:17,360
就像一次应用于整个批次一样。
--So for example, we can write H theta of X, 00:20:17,360 --> 00:20:19,800
例如，我们可以写出 X 的 H theta，
--overloading notation a little bit, 00:20:19,800 --> 00:20:21,000
稍微重载符号，
--we can write H theta of big X, 00:20:21,000 --> 00:20:23,800
我们可以写出大X的H theta，
--as being equal to the stacking of all the elements, 00:20:23,800 --> 00:20:28,240
等于所有元素的堆叠，
--H applied to each different element in our training set. 00:20:28,240 --> 00:20:32,720
 H 应用于我们训练集中的每个不同元素。
--So the first row of this quantity here, 00:20:32,720 --> 00:20:36,320
所以这个数量的第一行，
--is just equal to the hypothesis applied 00:20:36,320 --> 00:20:38,400
正好等于应用的假设
--to the first example. 00:20:38,400 --> 00:20:40,080
到第一个例子。
--Next row is the second example, 00:20:40,880 --> 00:20:41,720
下一行是第二个例子，
--all the way down to the M example. 00:20:41,720 --> 00:20:44,120
一直到 M 示例。
--But the really nice thing of course, 00:20:44,120 --> 00:20:45,120
但当然，真正好的事情是，
--is that we can write this in much more efficient, 00:20:45,120 --> 00:20:47,160
是我们可以更有效地写这个，
--much more compactly than even this. 00:20:47,160 --> 00:20:49,760
甚至比这更紧凑。
--If we look at what this actually is, 00:20:51,040 --> 00:20:53,480
如果我们看看这到底是什么，
--well, what is this? 00:20:53,480 --> 00:20:54,320
嗯，这是什么？
--This is just going to be, 00:20:54,320 --> 00:20:55,480
这将是，
--well, the first row of this thing, 00:20:55,480 --> 00:20:57,320
好吧，第一行这个东西，
--our hypothesis applied to X1 would be, 00:20:57,320 --> 00:21:02,160
我们应用于 X1 的假设是，
--that would be theta transpose X1, 00:21:02,160 --> 00:21:06,480
那将是 theta 转置 X1，
--but that whole thing transposed. 00:21:06,480 --> 00:21:08,840
但是整个事情都发生了变化。
--So let's just write that a little bit more briefly, 00:21:08,880 --> 00:21:12,120
所以让我们把它写得更简短一点，
--as X1, 00:21:12,120 --> 00:21:14,200
作为 X1，
--transpose times theta. 00:21:18,320 --> 00:21:20,280
转置时间 theta。
--That's the first row of this matrix. 00:21:22,120 --> 00:21:25,360
这是该矩阵的第一行。
--And similarly for all the other rows, right? 00:21:26,480 --> 00:21:27,880
其他所有行也类似，对吧？
--So the second row would be X2 transpose times theta, 00:21:27,880 --> 00:21:32,880
所以第二行是 X2 转置乘以 theta，
--times theta, 00:21:33,360 --> 00:21:34,320
次西塔，
--all the way down to XM transpose times theta. 00:21:35,440 --> 00:21:40,440
一直到 XM 转置次 theta。
--Extend these a bit. 00:21:43,200 --> 00:21:44,160
稍微扩展一下。
--Those lines there just mean that sort of, 00:21:47,480 --> 00:21:48,720
那里的那些线只是意味着那种，
--I'm emphasizing the fact that it's a row, 00:21:48,720 --> 00:21:50,520
我强调的事实是，这是一排，
--the whole row, they're not negative signs or anything. 00:21:50,520 --> 00:21:53,280
整行，它们不是负号或任何东西。
--But now if we look at this also, 00:21:55,480 --> 00:21:57,040
但现在如果我们也看看这个，
--we can see, well, this is just kind of the definition 00:21:57,040 --> 00:22:00,200
我们可以看到，嗯，这只是一种定义
--of a matrix multiplication. 00:22:00,200 --> 00:22:01,360
的矩阵乘法。
--So this thing here just equals, right? 00:22:01,360 --> 00:22:04,000
所以这里的这个东西等于，对吧？
--The first element is X1 times theta, 00:22:04,000 --> 00:22:07,320
第一个元素是 X1 乘以 theta，
--next is X2 times theta, et cetera. 00:22:07,320 --> 00:22:09,280
接下来是 X2 乘以 theta，等等。
--It's just, of course, 00:22:09,280 --> 00:22:10,120
当然，这只是
--equal to our big matrix X times theta. 00:22:10,120 --> 00:22:14,280
等于我们的大矩阵 X 乘以 theta。
--So the nicety of all of this 00:22:14,280 --> 00:22:15,760
所以这一切的好处
--is that we can find very efficient ways 00:22:15,760 --> 00:22:18,160
是我们可以找到非常有效的方法
--to write these seemingly complex expressions 00:22:18,160 --> 00:22:23,160
写下这些看似复杂的表达
--like our hypothesis applied 00:22:23,200 --> 00:22:24,920
就像我们的假设应用
--to every element of our dataset. 00:22:24,920 --> 00:22:26,520
到我们数据集的每个元素。
--All right, so let's now move to the second element 00:22:26,520 --> 00:22:31,520
好的，现在让我们转到第二个元素
--of the softmax regression algorithm, 00:22:34,160 --> 00:22:38,280
softmax回归算法，
--which is a loss function. 00:22:38,280 --> 00:22:39,720
这是一个损失函数。
--How are we going to evaluate the quality of our predictions? 00:22:40,560 --> 00:22:45,360
我们将如何评估预测的质量？
--Well, the most obvious thing we could do in some sense 00:22:46,360 --> 00:22:48,760
好吧，从某种意义上说，我们能做的最明显的事情
--is just this classification. 00:22:48,760 --> 00:22:52,160
就是这个分类。
--Let's just measure the prediction 00:22:52,160 --> 00:22:54,040
让我们来衡量一下预测
--by whether or not it's correct. 00:22:54,040 --> 00:22:56,000
通过它是否正确。
--This is something called 00:22:57,240 --> 00:22:58,080
这就是所谓的
--just the error of the classifier, right? 00:22:58,080 --> 00:22:59,840
只是分类器的错误，对吧？
--It's a very sort of simple, 00:22:59,840 --> 00:23:01,040
这是一种非常简单的，
--it's the most obvious loss function. 00:23:01,040 --> 00:23:02,960
这是最明显的损失函数。
--And so all it is, 00:23:04,360 --> 00:23:05,440
就是这样，
--so we can measure the sort of the error 00:23:05,440 --> 00:23:07,440
所以我们可以衡量错误的种类
--between our prediction here and the true label 00:23:07,440 --> 00:23:12,360
我们在这里的预测和真实标签之间
--via a loss function that we just call 00:23:13,640 --> 00:23:15,680
通过我们刚刚调用的损失函数
--sort of either the zero one loss or the error. 00:23:15,680 --> 00:23:18,640
某种零一损失或错误。
--We're going to call here, 00:23:18,640 --> 00:23:19,480
我们要在这里打电话，
--let's call it the error loss, right? 00:23:19,480 --> 00:23:22,440
让我们称之为错误损失，对吧？
--And this is sort of a very intuitive loss function, 00:23:22,440 --> 00:23:24,360
这是一种非常直观的损失函数，
--but we can write it formally too, right? 00:23:24,360 --> 00:23:25,680
但我们也可以正式地写出来，对吧？
--We can write it formally as this, the prediction, 00:23:25,680 --> 00:23:29,160
我们可以正式地把它写成这样，预测，
--the loss that we suffer on the prediction 00:23:29,160 --> 00:23:32,040
我们在预测中遭受的损失
--is going to be zero basically if our prediction is right. 00:23:32,040 --> 00:23:35,200
如果我们的预测是正确的，基本上将是零。
--But for a classification, 00:23:35,200 --> 00:23:36,520
但是对于分类，
--remember what it means to be right 00:23:36,520 --> 00:23:38,800
记住什么是正确的
--is that we should be most confident in some sense 00:23:38,800 --> 00:23:42,680
是我们应该在某种意义上最有信心
--about the correct class. 00:23:42,680 --> 00:23:44,800
关于正确的课程。
--And again, with our hypothesis function 00:23:44,800 --> 00:23:46,960
再一次，用我们的假设函数
--mapping from RN to RK, 00:23:46,960 --> 00:23:49,440
从 RN 映射到 RK，
--what this means is that this quantity HIX, 00:23:49,440 --> 00:23:54,320
这意味着这个数量 HIX，
--we want for our prediction to be correct, 00:23:54,400 --> 00:23:56,560
我们希望我们的预测是正确的，
--we want that quantity to be the largest 00:23:56,560 --> 00:23:58,640
我们希望那个数量是最大的
--at the true class Y. 00:23:58,640 --> 00:24:00,160
在真正的 Y 级。
--And the way we can write this formally 00:24:01,280 --> 00:24:02,440
以及我们可以正式写这个的方式
--is we say this loss is zero if the argmax, 00:24:02,440 --> 00:24:06,080
我们是说如果 argmax 这个损失是零，
--so if the maximum index, 00:24:06,080 --> 00:24:10,040
所以如果最大索引，
--the index corresponding to the maximum value of HI 00:24:10,040 --> 00:24:13,240
 HI最大值对应的索引
--is equal to Y. 00:24:14,120 --> 00:24:15,240
等于 Y。
--And this is very simple. 00:24:16,240 --> 00:24:17,200
这很简单。
--I mean, all this is saying 00:24:17,200 --> 00:24:18,360
我的意思是，这一切都在说
--is that if the biggest entry in our prediction 00:24:18,360 --> 00:24:23,000
是如果我们预测中最大的条目
--is equal to, corresponds to the correct class, 00:24:23,000 --> 00:24:26,040
等于，对应于正确的类，
--we suffer loss zero, otherwise we suffer loss one. 00:24:26,040 --> 00:24:29,080
我们遭受零损失，否则我们遭受损失一。
--And really actually this is very often 00:24:30,720 --> 00:24:33,000
实际上这很常见
--how we assess the quality of classifiers. 00:24:33,000 --> 00:24:34,680
我们如何评估分类器的质量。
--It almost goes without saying, 00:24:34,680 --> 00:24:35,600
几乎不言而喻，
--it's almost so obvious 00:24:35,600 --> 00:24:37,040
几乎是那么明显
--that we don't even bother saying this in some sense, 00:24:37,040 --> 00:24:40,440
在某种意义上我们甚至懒得说这个，
--but this is very frequently 00:24:40,440 --> 00:24:43,120
但这很常见
--how we actually assess the quality of classifiers. 00:24:43,120 --> 00:24:46,760
我们如何实际评估分类器的质量。
--If you ever, whenever you report error of your classifier 00:24:46,760 --> 00:24:50,080
如果你曾经，每当你报告你的分类器错误
--or accuracy of your classifier, this is how we do it. 00:24:50,080 --> 00:24:53,040
或分类器的准确性，我们就是这样做的。
--Of course, accuracy being one minus the error, right? 00:24:53,040 --> 00:24:55,680
当然，准确度是一减去误差，对吧？
--What the average error of a classifier is 00:24:56,600 --> 00:24:59,440
分类器的平均误差是多少
--is just the average loss, 00:24:59,440 --> 00:25:01,600
只是平均损失，
--this loss averaged over the whole data set. 00:25:01,600 --> 00:25:05,000
这种损失在整个数据集上平均。
--So this is a very intuitive loss function 00:25:06,520 --> 00:25:08,600
所以这是一个非常直观的损失函数
--to use for classification. 00:25:08,600 --> 00:25:10,680
用于分类。
--The problem is this loss function 00:25:10,680 --> 00:25:13,120
问题是这个损失函数
--is very bad for optimization. 00:25:13,120 --> 00:25:17,240
非常不利于优化。
--It's not very easy to find a set of parameters 00:25:17,240 --> 00:25:20,480
不是很容易找到一组参数
--that minimize this error loss. 00:25:20,480 --> 00:25:25,480
最小化这种错误损失。
--Actually winds up being for even a linear classifier, 00:25:26,200 --> 00:25:29,280
实际上甚至是线性分类器，
--an NP-hard problem to find a classifier 00:25:29,280 --> 00:25:32,200
寻找分类器的 NP 难问题
--that achieves the minimum number of errors. 00:25:32,200 --> 00:25:34,960
达到最少的错误数。
--But maybe more fundamentally, 00:25:36,320 --> 00:25:38,520
但也许更根本的是，
--another sort of very annoying thing about this loss 00:25:38,520 --> 00:25:40,840
关于这种损失的另一种非常烦人的事情
--is that it doesn't provide any information. 00:25:40,840 --> 00:25:44,000
是它不提供任何信息。
--It's not actually what we call differentiable. 00:25:44,000 --> 00:25:47,000
这实际上不是我们所说的可微分。
--And what this means is that 00:25:47,760 --> 00:25:49,840
这意味着
--if we vary our hypothesis a little bit, 00:25:49,840 --> 00:25:51,560
如果我们稍微改变我们的假设，
--this loss typically won't change, right? 00:25:51,560 --> 00:25:53,280
这种损失通常不会改变，对吧？
--It won't change locally around our current set of parameters 00:25:53,280 --> 00:25:56,200
它不会围绕我们当前的参数集在本地更改
--because you're probably not right on like a switching point 00:25:56,200 --> 00:25:59,320
因为你可能不喜欢切换点
--where one thing switches from one to the other. 00:25:59,320 --> 00:26:01,080
一件事从一件事切换到另一件事。
--And even if you are in a switching point, 00:26:01,080 --> 00:26:02,520
即使你处于一个转换点，
--that's sort of a point of also a non-differentiable point 00:26:02,520 --> 00:26:05,520
那也是一个不可微分的点
--because it sort of switches back and forth immediately 00:26:05,520 --> 00:26:07,840
因为它会立即来回切换
--between zero or one loss. 00:26:07,840 --> 00:26:10,000
在零或一损失之间。
--And this is very bad for actually optimizing parameters 00:26:10,000 --> 00:26:13,320
这对于实际优化参数非常不利
--because as we'll see in a second, 00:26:13,320 --> 00:26:15,760
因为我们马上就会看到，
--in really all, not all machine learning, 00:26:15,760 --> 00:26:18,640
实际上，不是所有的机器学习，
--but in probably all of deep learning, 00:26:18,640 --> 00:26:20,520
但可能在所有的深度学习中，
--the most common way of optimizing parameters 00:26:21,400 --> 00:26:25,360
最常用的参数优化方法
--or finding parameters that are good 00:26:25,360 --> 00:26:26,320
或找到好的参数
--are via gradient-based methods, 00:26:26,320 --> 00:26:28,000
是通过基于梯度的方法，
--via derivative-based methods. 00:26:28,000 --> 00:26:29,400
通过基于导数的方法。
--And so this loss function is very bad 00:26:29,400 --> 00:26:32,320
所以这个损失函数非常糟糕
--for actually optimizing over parameters, 00:26:32,320 --> 00:26:35,280
为了实际优化参数，
--even though it might be good 00:26:35,280 --> 00:26:36,360
即使它可能很好
--for quantifying the performance of classifiers. 00:26:36,360 --> 00:26:40,120
用于量化分类器的性能。
--And so what this leads us to 00:26:41,160 --> 00:26:43,240
那么这会导致我们做什么
--is another, a different loss function 00:26:43,240 --> 00:26:47,440
是另一个，不同的损失函数
--that we're going to use for softmax regression 00:26:47,440 --> 00:26:50,880
我们将用于 softmax 回归
--called either the softmax or the cross-entropy loss. 00:26:50,880 --> 00:26:53,720
称为 softmax 或交叉熵损失。
--This term cross-entropy loss has become kind of the standard 00:26:53,720 --> 00:26:56,520
这个术语交叉熵损失已经成为一种标准
--in most machine learning these days. 00:26:56,520 --> 00:26:58,840
在当今大多数机器学习中。
--And so we will define it in fact as the cross-entropy loss. 00:26:58,840 --> 00:27:02,640
所以我们实际上将其定义为交叉熵损失。
--And in order to define this loss, 00:27:04,120 --> 00:27:06,600
为了定义这种损失，
--we're gonna convert between our hypothesis output, right? 00:27:06,600 --> 00:27:11,400
我们要在我们的假设输出之间进行转换，对吧？
--In some sense, these predictions that correspond 00:27:12,400 --> 00:27:14,360
在某种意义上，这些预测对应
--to some kind of vague notion of belief, 00:27:14,360 --> 00:27:18,080
某种模糊的信仰概念，
--we wanna convert that 00:27:18,080 --> 00:27:19,240
我们想转换它
--into something that looks more like a normal probability. 00:27:19,240 --> 00:27:22,360
变成看起来更像正常概率的东西。
--All right, so we wanna take our hypothesis function, 00:27:22,360 --> 00:27:24,040
好吧，所以我们想采用我们的假设函数，
--this, these real value quantities, 00:27:24,040 --> 00:27:28,160
这个，这些真实的价值量，
--and we wanna convert that into a probability. 00:27:28,160 --> 00:27:31,720
我们想将其转换为概率。
--And the way we're gonna do this 00:27:32,600 --> 00:27:33,600
以及我们要做这件事的方式
--is we're gonna define the probability 00:27:33,600 --> 00:27:36,200
我们要定义概率吗
--that the label is equal to i. 00:27:36,200 --> 00:27:38,520
标签等于 i。
--And we're also gonna call this term sometimes just zi, 00:27:38,520 --> 00:27:40,760
我们有时也称这个词为 zi，
--just for convenience here. 00:27:40,760 --> 00:27:42,080
这里只是为了方便。
--Now, what do you need from a probability? 00:27:43,320 --> 00:27:45,720
现在，你需要从概率中得到什么？
--Well, a probability has to be positive 00:27:46,720 --> 00:27:49,640
好吧，概率必须是积极的
--and it has to sum to one, right? 00:27:49,640 --> 00:27:52,640
它总和必须为一，对吧？
--And our hypothesis output hi, that is not positive. 00:27:52,640 --> 00:27:57,200
而我们的假设输出 hi，那不是正数。
--It can be negative two and doesn't have to sum to one. 00:27:57,200 --> 00:28:00,440
它可以是负二且不必总和为一。
--So how do we make it sum to one and be positive? 00:28:00,440 --> 00:28:04,200
那么我们如何使它和为一并为正呢？
--Well, the first thing we can do 00:28:04,200 --> 00:28:06,000
那么，我们可以做的第一件事
--is we can just take our hypothesis hi, right? 00:28:06,000 --> 00:28:08,480
我们可以接受我们的假设吗？
--Take this term hi and just exponentiate it, right? 00:28:08,720 --> 00:28:13,200
把这个术语 hi 取幂，对吧？
--So now that will make it positive. 00:28:13,200 --> 00:28:15,120
所以现在这将使它变得积极。
--Okay, so we just exponentiate any number, 00:28:15,120 --> 00:28:17,840
好的，所以我们只是对任何数字取幂，
--positive or negative, 00:28:17,840 --> 00:28:18,960
正面或负面，
--their result will always be positive. 00:28:18,960 --> 00:28:20,760
他们的结果将永远是积极的。
--But they won't always sum to one, 00:28:21,640 --> 00:28:23,000
但他们总不会总和为一，
--so that sort of solves the first problem, 00:28:23,000 --> 00:28:24,240
这样就解决了第一个问题，
--the probability has to be positive. 00:28:24,240 --> 00:28:25,080
概率必须为正。
--But that doesn't solve the second problem 00:28:25,080 --> 00:28:26,280
但这并没有解决第二个问题
--where probability has to sum to one. 00:28:26,280 --> 00:28:28,520
其中概率总和为一。
--So the thing we can do next 00:28:28,520 --> 00:28:29,480
所以我们接下来可以做的事
--is just normalize this quantity 00:28:29,480 --> 00:28:32,560
只是标准化这个数量
--by the sum of all the outputs, right? 00:28:32,560 --> 00:28:36,360
通过所有输出的总和，对吧？
--So we're gonna take our hypothesis at index i, 00:28:36,360 --> 00:28:41,360
所以我们将在索引 i 处采用我们的假设，
--exponentiate it, 00:28:42,480 --> 00:28:43,720
取幂，
--and then we're gonna normalize it 00:28:45,560 --> 00:28:47,160
然后我们要把它正常化
--by the sum of all our exponentiated hypotheses. 00:28:47,160 --> 00:28:50,400
通过我们所有指数假设的总和。
--And now this quantity is in fact, 00:28:51,720 --> 00:28:54,720
现在这个数量实际上是
--at least obeys the basic principles of the probability. 00:28:54,720 --> 00:28:57,560
至少遵守概率的基本原则。
--It is positive and the sum 00:28:57,560 --> 00:29:00,360
它是积极的，总和
--over all the probabilities of all the labels 00:29:00,360 --> 00:29:02,160
在所有标签的所有概率上
--will always equal one. 00:29:02,160 --> 00:29:03,400
永远等于一。
--Another way of writing this is to say, 00:29:04,400 --> 00:29:07,200
另一种写法是说，
--and kind of in vector form, 00:29:07,200 --> 00:29:08,200
和某种矢量形式，
--is to say that z, the vector of all the probabilities, 00:29:08,200 --> 00:29:11,840
就是说 z，所有概率的向量，
--is the normalized function, 00:29:11,840 --> 00:29:13,800
是归一化函数，
--that just means we divide by their sum, 00:29:13,800 --> 00:29:15,760
那只是意味着我们除以他们的总和，
--applied to the exponential of the hypothesis function. 00:29:15,760 --> 00:29:19,760
应用于假设函数的指数。
--One thing that will come up a lot 00:29:20,880 --> 00:29:22,240
一件会经常出现的事情
--is that whenever we take kind of a scalar function here, 00:29:22,240 --> 00:29:26,840
是每当我们在这里使用某种标量函数时
--like the exponential, and apply it to a vector, 00:29:26,840 --> 00:29:29,920
像指数一样，并将其应用于向量，
--all this means, all this term here means 00:29:29,920 --> 00:29:32,440
 all this means, all this term 这里的意思
--is it just means the exponential applied 00:29:32,440 --> 00:29:34,400
它只是意味着应用指数
--to each element in that vector h of x, right? 00:29:34,400 --> 00:29:39,360
对于 x 的向量 h 中的每个元素，对吗？
--And so we're gonna frequently apply 00:29:39,360 --> 00:29:41,280
所以我们要经常申请
--kind of non or scalar functions to this, 00:29:41,280 --> 00:29:44,480
对此的一种非函数或标量函数，
--and you kind of have to infer what we mean 00:29:44,480 --> 00:29:45,960
你必须推断出我们的意思
--just by the context here. 00:29:45,960 --> 00:29:47,240
仅根据此处的上下文。
--So normalize actually is a little bit more complex 00:29:47,240 --> 00:29:49,440
所以规范化实际上有点复杂
--because it looks at the entire vector, 00:29:49,440 --> 00:29:50,920
因为它查看整个向量，
--but all this normalized function does is for a vector, 00:29:50,920 --> 00:29:53,720
但所有这些归一化函数所做的都是针对一个向量，
--it makes the vector normalized to sum to one. 00:29:53,720 --> 00:29:57,000
它使向量归一化为总和为 1。
--All right, so that's how we're going to, 00:29:59,840 --> 00:30:01,800
好吧，这就是我们要做的，
--and you may be familiar with this operator. 00:30:01,800 --> 00:30:03,600
你可能熟悉这个运算符。
--This is also called a softmax operator. 00:30:03,600 --> 00:30:05,560
这也称为 softmax 运算符。
--It's sort of a standard way of mapping 00:30:07,320 --> 00:30:09,160
这是一种标准的映射方式
--between arbitrary real value components 00:30:09,160 --> 00:30:10,960
任意实值分量之间
--and the output of, or in a probability distribution. 00:30:10,960 --> 00:30:15,760
和输出，或在概率分布中。
--Now, you may, looking forward a little bit here, 00:30:17,520 --> 00:30:21,240
现在，你可以在这里期待一点，
--if you are familiar with neural networks, 00:30:21,240 --> 00:30:23,080
如果你熟悉神经网络，
--you may have seen things like this 00:30:23,080 --> 00:30:24,840
你可能见过这样的事情
--where people often take this operation, 00:30:24,840 --> 00:30:26,600
人们经常采取这种行动的地方，
--which they also call, 00:30:26,600 --> 00:30:27,440
他们也称之为，
--so this is also called a softmax operation, I should say. 00:30:27,440 --> 00:30:29,680
所以我应该说这也称为 softmax 操作。
--This is also equivalent to the softmax called, 00:30:29,680 --> 00:30:34,200
这也相当于称为 softmax，
--of just h of x. 00:30:35,120 --> 00:30:36,960
只是 h 的 x。
--So softmax is just the combination of the exponential 00:30:36,960 --> 00:30:39,360
所以softmax只是指数的组合
--and then normalizing it. 00:30:39,360 --> 00:30:40,560
然后对其进行归一化。
--You may see sometimes in neural networks, 00:30:41,800 --> 00:30:43,400
有时你可能会在神经网络中看到，
--people define the output of a network 00:30:43,400 --> 00:30:45,840
人们定义网络的输出
--to be the softmax applied to something before that, 00:30:45,840 --> 00:30:49,080
成为之前应用于某物的 softmax，
--but that's actually, for various reasons, 00:30:49,080 --> 00:30:51,320
但实际上，出于各种原因，
--that's actually not the right way of doing things, 00:30:51,320 --> 00:30:53,280
这实际上不是正确的做事方式，
--in my opinion. 00:30:53,280 --> 00:30:54,160
在我看来。
--The output, and even in a setting like this, right, 00:30:55,520 --> 00:30:58,240
输出，甚至在这样的设置中，对吧，
--the output of a linear classifier 00:30:58,240 --> 00:31:01,680
线性分类器的输出
--is just the linear function, 00:31:01,680 --> 00:31:03,640
只是线性函数，
--not the softmax applied to linear function. 00:31:04,680 --> 00:31:07,080
不是应用于线性函数的 softmax。
--The softmax and these sort of things, 00:31:07,080 --> 00:31:08,200
 softmax 和这些东西，
--at least at the final level, 00:31:08,200 --> 00:31:10,200
至少在最后一级，
--final sort of loss function layer, 00:31:10,200 --> 00:31:13,080
最后一种损失函数层，
--becomes an operation that sort of is embedded 00:31:13,080 --> 00:31:16,560
成为一种嵌入的操作
--in the loss itself, 00:31:16,560 --> 00:31:17,520
在损失本身，
--not an operation you apply to the network. 00:31:17,520 --> 00:31:21,200
不是您应用于网络的操作。
--I'll come back to that in a second, though. 00:31:21,200 --> 00:31:23,320
不过，我会在一秒钟内回到这一点。
--All right, so now that we have a probability here 00:31:24,760 --> 00:31:27,040
好吧，现在我们有一个概率
--that we've sort of mapped 00:31:27,040 --> 00:31:28,200
我们已经映射
--from our arbitrary hypothesis output to a probability, 00:31:28,200 --> 00:31:32,640
从我们的任意假设输出到概率，
--we need some way of quantifying 00:31:32,640 --> 00:31:35,000
我们需要一些量化的方法
--whether our probabilities are good or not, 00:31:35,000 --> 00:31:36,880
我们的概率好不好，
--whether our vector of probabilities 00:31:36,880 --> 00:31:38,400
我们的概率向量是否
--is a good set of predictions or not. 00:31:38,400 --> 00:31:40,200
是否是一组好的预测。
--And this is now fairly obvious what we might do. 00:31:40,200 --> 00:31:43,440
现在我们可以做什么已经很明显了。
--A good measure of how good our prediction is 00:31:43,440 --> 00:31:46,120
衡量我们的预测有多好的一个很好的衡量标准
--is just is the probability of the true class high, right? 00:31:46,120 --> 00:31:51,120
只是真类的概率高吧？
--So what's the probability of 00:31:51,960 --> 00:31:54,760
那么概率是多少
--our, under this notation, 00:31:57,760 --> 00:31:59,480
我们的，在这个符号下，
--what's the probability of the label being the true target y? 00:31:59,480 --> 00:32:03,120
标签是真正目标 y 的概率是多少？
--And so we want to make that probability 00:32:05,280 --> 00:32:06,680
所以我们想让这个概率
--as large as possible. 00:32:06,680 --> 00:32:07,800
尽可能大。
--But for sort of reasons of convention, 00:32:09,160 --> 00:32:10,560
但出于某种约定俗成的原因，
--we typically think of loss functions 00:32:10,560 --> 00:32:12,160
我们通常会想到损失函数
--as being things that we minimize. 00:32:12,160 --> 00:32:13,840
作为我们最小化的事物。
--So we want to make something small, 00:32:13,840 --> 00:32:16,760
所以我们想做一些小的，
--something like error small, right? 00:32:16,760 --> 00:32:19,200
像错误小的东西，对吧？
--So we could minimize them, 00:32:19,200 --> 00:32:20,840
所以我们可以最小化它们，
--I guess, the negative probability, 00:32:20,840 --> 00:32:23,000
我想，负概率，
--but minimizing probabilities, actually, 00:32:23,000 --> 00:32:25,680
但实际上最小化概率，
--for various reasons, 00:32:25,680 --> 00:32:26,520
由于种种原因，
--is a bit not very well numerically conditioned. 00:32:26,520 --> 00:32:30,680
在数值条件下有点不太好。
--So what we typically do is we take the log of this thing. 00:32:30,680 --> 00:32:33,840
所以我们通常做的是记录这件事。
--And this is a very common thing. 00:32:33,840 --> 00:32:35,440
这是一件很常见的事情。
--This is called the negative log loss, 00:32:35,440 --> 00:32:37,720
这称为负对数损失，
--or this is sort of a very common way 00:32:37,720 --> 00:32:39,120
或者这是一种非常常见的方式
--of deriving loss functions, 00:32:39,120 --> 00:32:41,120
导出损失函数，
--where we define our loss function, 00:32:41,120 --> 00:32:42,880
我们定义损失函数的地方，
--and we, in fact, define the cross-entropy loss function 00:32:42,880 --> 00:32:46,520
事实上，我们定义了交叉熵损失函数
--as just the negative log probability 00:32:46,520 --> 00:32:49,320
作为负对数概率
--of the label being the true class 00:32:49,320 --> 00:32:52,960
标签是真正的类别
--under this distribution here. 00:32:52,960 --> 00:32:56,720
在此分配下。
--And we can write that out a bit more explicitly. 00:32:57,920 --> 00:32:59,760
我们可以更明确地写出来。
--We can just sort of write this out 00:32:59,760 --> 00:33:01,880
我们可以把它写出来
--a little bit more concretely here, 00:33:01,880 --> 00:33:04,240
在这里更具体一点，
--as also equal to, 00:33:04,240 --> 00:33:05,680
也等于，
--well, let's just sort of take the log of this thing. 00:33:05,680 --> 00:33:08,360
好吧，让我们记录一下这件事。
--So we have the negative log of the numerator first, 00:33:08,360 --> 00:33:11,120
所以我们首先有分子的负对数，
--which is the exponential, 00:33:11,120 --> 00:33:11,960
这是指数，
--so the log and the exponential cancel, 00:33:11,960 --> 00:33:13,560
所以对数和指数抵消，
--and we just have negative h y of x. 00:33:13,560 --> 00:33:17,960
我们只有 x 的负 hy。
--So it's a negative, the y component. 00:33:17,960 --> 00:33:20,600
所以它是一个负数，y 分量。
--Remember, y here is a discrete value between one and k, 00:33:20,600 --> 00:33:23,120
请记住，这里的 y 是一个介于 1 和 k 之间的离散值，
--so we take the yth component of our output. 00:33:23,120 --> 00:33:25,360
所以我们采用输出的第 y 个分量。
--Then minus the log of the denominator, 00:33:27,480 --> 00:33:29,800
然后减去分母的对数，
--but then we also subtract off, 00:33:29,800 --> 00:33:31,240
但我们也减去，
--because we're taking the log of the denominator, 00:33:31,240 --> 00:33:32,400
因为我们取分母的对数，
--we subtract that off, 00:33:32,400 --> 00:33:33,240
我们减去它，
--so we're, in fact, adding the log of the sum 00:33:33,240 --> 00:33:37,360
所以我们实际上是在添加总和的对数
--from j equals one to k of the exponential of h j x. 00:33:37,360 --> 00:33:42,360
from j 等于 hj x 的指数的一到 k。
--Right, and that is called the cross-entropy loss, 00:33:45,000 --> 00:33:48,920
对，这就是所谓的交叉熵损失，
--or sometimes the softmax loss, 00:33:49,400 --> 00:33:51,320
或者有时是 softmax 损失，
--or just the multi-class logistic loss, 00:33:51,320 --> 00:33:53,080
或者只是多类逻辑损失，
--sometimes it's called, 00:33:53,080 --> 00:33:53,920
有时它被称为
--but these are all really the same thing. 00:33:53,920 --> 00:33:55,320
但这些其实都是一回事。
--And the name cross-entropy loss 00:33:55,320 --> 00:33:56,600
以及名称交叉熵损失
--is the most common these days in machine learning. 00:33:56,600 --> 00:33:59,520
是当今机器学习中最常见的。
--And that's how we define the loss function 00:33:59,520 --> 00:34:02,000
这就是我们定义损失函数的方式
--we're gonna use in softmax regression. 00:34:02,000 --> 00:34:04,640
我们将在 softmax 回归中使用。
--Now, as I said before, 00:34:06,920 --> 00:34:09,120
现在，正如我之前所说，
--the right way to think about this 00:34:09,120 --> 00:34:10,840
正确的思考方式
--is as this loss function 00:34:10,840 --> 00:34:13,520
就是这个损失函数
--applied to a linear hypothesis class, 00:34:13,520 --> 00:34:16,360
应用于线性假设类，
--not sort of this negative log being the loss, 00:34:16,360 --> 00:34:20,720
这种负日志不是损失，
--or this negative log here being the loss, 00:34:20,720 --> 00:34:23,200
或者这个负对数是损失，
--applied to some softmax of this thing. 00:34:23,200 --> 00:34:25,320
应用于这个东西的一些softmax。
--And there are subtle reasons for that. 00:34:25,320 --> 00:34:27,680
这有一些微妙的原因。
--For example, if you look at the convexity properties 00:34:27,680 --> 00:34:30,040
例如，如果您查看凸性属性
--of this thing, 00:34:30,040 --> 00:34:30,880
这件事的，
--that this problem ends up being, 00:34:30,880 --> 00:34:32,080
这个问题最终是，
--well, for softmax regression, 00:34:32,080 --> 00:34:33,880
好吧，对于 softmax 回归，
--will end up being a convex problem, 00:34:33,880 --> 00:34:35,120
最终会成为一个凸问题，
--that's much easier to see here. 00:34:35,120 --> 00:34:37,320
在这里更容易看到。
--You also typically, unless you really have to, 00:34:37,320 --> 00:34:39,200
除非你真的必须，否则你通常也会，
--don't wanna actually form a softmax operation, 00:34:39,200 --> 00:34:41,560
不想真正形成一个 softmax 操作，
--because if the number becomes numerically zero, 00:34:41,560 --> 00:34:46,560
因为如果数字变成零，
--and you're taking the log of a zero, 00:34:47,160 --> 00:34:49,280
你正在记录一个零，
--then things can blow up. 00:34:49,280 --> 00:34:50,240
那么事情可能会爆炸。
--So it's much better to think of 00:34:50,240 --> 00:34:52,160
所以最好想想
--the output of a hypothesis class 00:34:52,160 --> 00:34:54,720
假设类的输出
--being a linear function. 00:34:54,720 --> 00:34:56,160
是一个线性函数。
--In this case, these things are, 00:34:56,160 --> 00:34:57,040
在这种情况下，这些东西是，
--for those that have heard this term before, 00:34:57,040 --> 00:34:57,880
对于那些以前听过这个词的人来说，
--these are also called, 00:34:57,880 --> 00:34:58,920
这些也被称为，
--the output of a hypothesis class 00:34:58,920 --> 00:35:00,000
假设类的输出
--will also be called the logits sometimes, 00:35:00,000 --> 00:35:02,160
有时也被称为 logits，
--and then fed, 00:35:02,160 --> 00:35:03,040
然后喂食，
--when they are then fed into this cross-entropy loss. 00:35:03,040 --> 00:35:07,200
然后将它们输入到这种交叉熵损失中。
--But this is the right way of doing things, 00:35:07,200 --> 00:35:09,440
但这是正确的做事方式，
--both, I think, conceptually, 00:35:09,440 --> 00:35:10,760
我认为，从概念上讲，
--but also numerically, 00:35:10,760 --> 00:35:12,120
而且在数字上，
--it ends up being much nicer, 00:35:12,120 --> 00:35:13,200
它最终变得更好，
--just sort of, 00:35:13,200 --> 00:35:14,440
只是有点，
--you don't wanna actually compute 00:35:14,440 --> 00:35:15,880
你不想真正计算
--this softmax operation here explicitly, 00:35:15,880 --> 00:35:18,000
这个 softmax 操作在这里明确地，
--you want to compute this loss function 00:35:18,000 --> 00:35:20,960
你想计算这个损失函数
--applied to a linear hypothesis class. 00:35:22,280 --> 00:35:25,040
应用于线性假设类。
--All right, so now with that, 00:35:28,400 --> 00:35:29,640
好吧，现在有了这个，
--let's talk about the final ingredient 00:35:29,640 --> 00:35:31,440
让我们谈谈最后的成分
--of softmax regression, 00:35:31,440 --> 00:35:32,560
softmax回归，
--which is actually gonna take the most time to cover, 00:35:32,560 --> 00:35:35,360
这实际上需要最多的时间来涵盖，
--because we have to sort of discuss a little bit 00:35:35,360 --> 00:35:37,000
因为我们得稍微讨论一下
--about how you optimize these things. 00:35:37,000 --> 00:35:38,800
关于你如何优化这些东西。
--But before we do so, 00:35:39,680 --> 00:35:41,080
但在我们这样做之前，
--let's, again, 00:35:41,080 --> 00:35:41,920
让我们再一次
--this is gonna be the third and final ingredient 00:35:41,920 --> 00:35:43,720
这将是第三种也是最后一种成分
--of softmax regression, 00:35:43,720 --> 00:35:44,880
softmax回归，
--which is gonna be the optimization problem, 00:35:44,880 --> 00:35:46,840
这将是优化问题，
--how do we find good values for those parameters theta? 00:35:46,840 --> 00:35:50,120
我们如何为这些参数 theta 找到合适的值？
--But before I do that, 00:35:51,400 --> 00:35:52,560
但在我这样做之前，
--I sort of wanna specify, 00:35:52,560 --> 00:35:53,800
我有点想说明，
--or just mention the fact, 00:35:53,800 --> 00:35:54,840
或者只是提一下事实，
--that what the third ingredient 00:35:54,840 --> 00:35:57,520
那第三种成分是什么
--of our machine learning algorithm really is doing 00:35:57,520 --> 00:36:00,440
我们的机器学习算法确实在做
--is solving the following optimization problem. 00:36:00,440 --> 00:36:04,360
正在解决以下优化问题。
--We are minimizing over theta. 00:36:04,360 --> 00:36:06,440
我们正在最小化 over theta。
--So what this notation means, 00:36:06,440 --> 00:36:07,400
那么这个符号意味着什么，
--this notation here is notation 00:36:07,840 --> 00:36:08,840
这个符号在这里是符号
--for an optimization problem. 00:36:08,840 --> 00:36:10,000
对于优化问题。
--That means we're searching over all possible values, 00:36:10,000 --> 00:36:12,400
这意味着我们正在搜索所有可能的值，
--or at least trying to search over all possible values, 00:36:12,400 --> 00:36:15,320
或者至少尝试搜索所有可能的值，
--to find some value of theta 00:36:15,320 --> 00:36:17,840
找到一些 theta 的值
--that minimizes the quantity here on the right. 00:36:17,840 --> 00:36:21,760
最小化右边的数量。
--And this quantity is just going to be the sum 00:36:22,720 --> 00:36:25,480
这个数量就是总和
--from i equals one to m, 00:36:25,480 --> 00:36:27,320
从 i 等于 1 到 m，
--I guess really the average, right? 00:36:27,320 --> 00:36:28,960
我想真的是平均水平，对吧？
--So the average from i equals one to m 00:36:28,960 --> 00:36:31,200
所以 i 的平均值等于 1 到 m
--of our loss function, 00:36:32,360 --> 00:36:34,000
我们的损失函数，
--so our loss here, 00:36:34,000 --> 00:36:35,800
所以我们在这里的损失，
--applied between our prediction on the i-th output 00:36:35,800 --> 00:36:40,560
在我们对第 i 个输出的预测之间应用
--and the actual i-th output. 00:36:40,560 --> 00:36:43,120
和实际的第 i 个输出。
--Right, so I wanna take a little bit of time 00:36:45,360 --> 00:36:48,400
好的，所以我想花点时间
--to emphasize this problem here, 00:36:48,400 --> 00:36:49,360
在这里强调这个问题，
--because this problem, 00:36:49,360 --> 00:36:50,840
因为这个问题，
--kind of stated as such, 00:36:52,320 --> 00:36:53,640
有点像这样说，
--I kind of think of this 00:36:54,760 --> 00:36:55,800
我有点想这个
--as the core machine learning optimization problem 00:36:55,800 --> 00:36:59,800
作为核心机器学习优化问题
--that describes all machine learning algorithms. 00:36:59,800 --> 00:37:02,400
描述了所有机器学习算法。
--Every machine learning algorithm, 00:37:03,400 --> 00:37:05,000
每一个机器学习算法，
--in one way or another, 00:37:05,000 --> 00:37:06,240
以这种或那种方式，
--is trying to find a set of parameters 00:37:06,240 --> 00:37:08,960
试图找到一组参数
--that minimize the sum of, 00:37:08,960 --> 00:37:11,360
最小化的总和，
--or the average loss 00:37:11,360 --> 00:37:13,400
或平均损失
--between some predictions 00:37:14,320 --> 00:37:16,440
在一些预测之间
--and the true labels on the training set. 00:37:16,440 --> 00:37:19,640
以及训练集上的真实标签。
--And in fact, this formulation here really includes, 00:37:19,640 --> 00:37:23,000
事实上，这里的表述确实包括，
--therefore, all the aspects 00:37:23,000 --> 00:37:24,800
因此，各方面
--of a machine learning algorithm, right? 00:37:24,800 --> 00:37:26,280
机器学习算法，对吧？
--It includes the hypothesis function, 00:37:26,280 --> 00:37:28,840
它包括假设函数，
--it includes the loss function, 00:37:28,840 --> 00:37:31,240
它包括损失函数，
--and it includes the optimization problem. 00:37:31,240 --> 00:37:33,320
它包括优化问题。
--So really this problem, 00:37:34,440 --> 00:37:36,040
所以真的这个问题，
--maybe with some slight changes 00:37:36,040 --> 00:37:37,280
也许有一些细微的变化
--like adding regularization, 00:37:37,280 --> 00:37:38,640
比如添加正则化，
--but typically you don't even do that 00:37:38,640 --> 00:37:40,440
但通常你甚至不这样做
--in deep learning that much, 00:37:40,440 --> 00:37:42,440
在深度学习中，
--but this problem really is 00:37:42,440 --> 00:37:45,280
但这个问题确实是
--the core machine learning problem. 00:37:45,280 --> 00:37:48,080
核心机器学习问题。
--And every algorithm, 00:37:48,080 --> 00:37:49,640
每一个算法，
--every machine learning algorithm there is, 00:37:49,640 --> 00:37:51,040
每一种机器学习算法，
--in one way or another, 00:37:51,040 --> 00:37:52,720
以这种或那种方式，
--solves a problem like this. 00:37:52,720 --> 00:37:55,120
解决了这样的问题。
--At least every supervised algorithm, 00:37:55,120 --> 00:37:57,560
至少每个监督算法，
--probably every unsupervised algorithm too, 00:37:57,560 --> 00:37:59,000
可能每个无监督算法也是如此，
--and arguably every reinforcement learning algorithm or not, 00:37:59,000 --> 00:38:01,440
并且可以说每个强化学习算法与否，
--that one's a little trickier, 00:38:01,440 --> 00:38:02,280
那个有点棘手，
--but certainly every supervised learning algorithm 00:38:02,280 --> 00:38:05,720
但肯定是每个监督学习算法
--is just a different take on solving this problem. 00:38:05,720 --> 00:38:08,200
只是解决这个问题的不同方式。
--And so we can even look sort of concretely, 00:38:09,320 --> 00:38:11,440
所以我们甚至可以具体地看，
--what does that look like then 00:38:11,440 --> 00:38:12,840
那看起来像什么
--for something like softmax regression? 00:38:12,840 --> 00:38:14,960
对于像 softmax 回归这样的东西？
--Well, in sort of the simplest way of writing it, 00:38:14,960 --> 00:38:19,920
好吧，用最简单的方式来写它，
--it's just pretty similar, right? 00:38:19,920 --> 00:38:21,320
它非常相似，对吧？
--We're minimizing over theta, 00:38:21,320 --> 00:38:22,440
我们正在最小化 over theta，
--that part's the same, 00:38:22,440 --> 00:38:23,280
那部分是一样的，
--we're trying to find good values of theta 00:38:23,280 --> 00:38:26,240
我们正试图找到好的 theta 值
--that minimize, 00:38:26,240 --> 00:38:28,280
最小化，
--all we're gonna do here 00:38:28,280 --> 00:38:29,680
我们要做的一切
--is plug in the specifics of the softmax regression. 00:38:29,680 --> 00:38:34,680
插入 softmax 回归的细节。
--So we're minimizing the cross entropy loss 00:38:36,960 --> 00:38:40,160
所以我们正在最小化交叉熵损失
--and our hypothesis class happens to be a linear one. 00:38:40,160 --> 00:38:42,600
而我们的假设类恰好是线性类。
--So it's gonna be theta transpose times xi and yi. 00:38:42,600 --> 00:38:47,600
所以这将是 theta 转置 xi 和 yi。
--And this is the optimization problem 00:38:49,080 --> 00:38:50,480
这是优化问题
--we want to solve for softmax regression. 00:38:50,480 --> 00:38:54,080
我们想解决 softmax 回归问题。
--Now, of course, the question is, 00:38:55,080 --> 00:38:56,800
现在，当然，问题是，
--well, how do we actually find that? 00:38:56,800 --> 00:38:58,880
好吧，我们实际上如何找到它？
--How do we find the value of theta 00:39:00,360 --> 00:39:02,800
我们如何找到 theta 的值
--that minimizes this, 00:39:02,800 --> 00:39:03,640
最小化这个，
--or at least the value of theta 00:39:03,640 --> 00:39:04,720
或者至少是 theta 的值
--that is this sort of matrix of parameters, remember? 00:39:04,720 --> 00:39:08,040
那就是这种参数矩阵，还记得吗？
--The way we define our hypothesis function, 00:39:08,040 --> 00:39:09,360
我们定义假设函数的方式，
--how do we find the values 00:39:09,360 --> 00:39:11,640
我们如何找到价值
--that provide a good mapping between the inputs and outputs? 00:39:11,640 --> 00:39:14,560
提供输入和输出之间的良好映射？
--And so the way we're gonna do this 00:39:15,520 --> 00:39:16,600
所以我们要这样做的方式
--is via a technique called gradient descent. 00:39:16,600 --> 00:39:20,040
是通过一种称为梯度下降的技术。
--But to cover gradient descent, 00:39:20,960 --> 00:39:23,280
但是为了涵盖梯度下降，
--I first want to go a little bit of a digression 00:39:23,320 --> 00:39:28,120
我首先想说一点题外话
--about a quantity called the gradient. 00:39:28,120 --> 00:39:31,840
关于一个叫做梯度的量。
--And so let's suppose that we have 00:39:31,840 --> 00:39:34,880
所以让我们假设我们有
--a matrix input scalar output function. 00:39:34,880 --> 00:39:38,480
矩阵输入标量输出函数。
--So a mapping from, 00:39:38,480 --> 00:39:40,040
所以一个映射，
--in this case, I'll just use our actual mapping, 00:39:40,040 --> 00:39:42,080
在这种情况下，我将只使用我们的实际映射，
--the theta, which is an m by k vector, 00:39:42,080 --> 00:39:44,280
 theta，它是一个 m x k 向量，
--to a real value vector. 00:39:44,280 --> 00:39:46,120
到一个实值向量。
--And actually going back to the previous slide for a second, 00:39:46,120 --> 00:39:48,320
实际上回到上一张幻灯片，
--the thing I wanna emphasize 00:39:48,320 --> 00:39:49,480
我想强调的事情
--is that this whole quantity here, 00:39:49,480 --> 00:39:52,400
是这里的全部数量，
--in fact, the thing that we're trying to minimize, 00:39:52,400 --> 00:39:55,760
事实上，我们试图最小化的东西，
--for the purposes of minimization, 00:39:55,760 --> 00:39:58,040
为了最小化的目的，
--we can think of this as just a function of theta. 00:39:58,040 --> 00:40:03,040
我们可以将其视为 theta 的函数。
--So the quantity that we're going to be taking 00:40:03,360 --> 00:40:05,600
所以我们要拿的数量
--the gradient of later on 00:40:05,600 --> 00:40:08,680
后来的梯度
--is exactly going to be this optimization objective. 00:40:08,680 --> 00:40:11,760
正是这个优化目标。
--But for such a function, 00:40:13,400 --> 00:40:14,680
但是对于这样的功能，
--so for some function f theta, 00:40:14,680 --> 00:40:17,440
所以对于某些函数 f theta，
--how do we actually start to minimize 00:40:18,320 --> 00:40:23,320
我们实际上如何开始最小化
--that function over theta? 00:40:23,640 --> 00:40:26,080
那个功能超过了theta？
--Well, one sort of very nice thing you can do 00:40:26,080 --> 00:40:29,600
好吧，你可以做一件非常好的事情
--is use this quantity called the gradient. 00:40:29,600 --> 00:40:32,840
就是使用这个称为梯度的量。
--And what the gradient is, 00:40:32,840 --> 00:40:33,960
梯度是什么，
--the gradient is a vector, 00:40:33,960 --> 00:40:35,800
梯度是一个向量，
--sorry, a matrix of partial derivatives of this function. 00:40:35,800 --> 00:40:40,520
抱歉，这个函数的偏导数矩阵。
--And in particular, if the function, 00:40:40,520 --> 00:40:43,360
特别是，如果功能，
--if theta itself, the input to the function 00:40:43,360 --> 00:40:45,480
如果 theta 本身，函数的输入
--is n by k dimensional, 00:40:45,520 --> 00:40:48,560
是 n x k 维的，
--then importantly here, the gradient, 00:40:48,560 --> 00:40:50,320
然后重要的是，梯度，
--which we write as this little upside down triangle, 00:40:50,320 --> 00:40:53,040
我们把它写成这个倒立的小三角形，
--gradient with respect to theta of f of theta, 00:40:53,040 --> 00:40:56,800
相对于 theta 的 f 的 theta 的梯度，
--that's how we sort of write this, 00:40:56,800 --> 00:40:58,400
我们就是这样写的，
--this is also going to be an n by k matrix. 00:40:58,400 --> 00:41:02,680
这也将是一个 n x k 矩阵。
--And it's going to just be a matrix 00:41:02,680 --> 00:41:04,120
它只是一个矩阵
--of all partial derivatives of this function. 00:41:04,120 --> 00:41:07,040
这个函数的所有偏导数。
--So the first element 00:41:08,000 --> 00:41:10,240
所以第一个元素
--would just be the partial derivative of f of theta 00:41:10,240 --> 00:41:13,480
只是 theta 的 f 的偏导数
--with respect to theta one, one. 00:41:13,480 --> 00:41:16,760
关于 theta 一，一。
--Going to the last, or the last element in the first row 00:41:18,960 --> 00:41:21,400
转到第一行中的最后一个或最后一个元素
--would be the partial derivative of f of theta 00:41:21,400 --> 00:41:25,000
将是 f 的 theta 的偏导数
--with respect to theta one, k. 00:41:25,000 --> 00:41:28,560
关于 theta one，k。
--Down here, partial derivative with respect to f theta, 00:41:31,240 --> 00:41:34,640
在这里，关于 f theta 的偏导数，
--theta n one, and finally, 00:41:36,080 --> 00:41:39,800
 theta n one，最后，
--all the way down to the partial derivative of 00:41:39,800 --> 00:41:42,000
一直到偏导数
--f of theta with respect to theta n k. 00:41:43,880 --> 00:41:48,880
f of theta 相对于 theta n k。
--And these partial derivative signs, 00:41:49,000 --> 00:41:51,080
而这些偏导数符号，
--what the partial derivative just means 00:41:51,080 --> 00:41:53,560
偏导数意味着什么
--is that for the purposes of that derivative, 00:41:53,560 --> 00:41:55,440
是为了该衍生品的目的，
--for the purposes, say, of this derivative here, 00:41:55,440 --> 00:41:57,760
就此衍生品而言，
--you are treating every other element of theta 00:41:57,760 --> 00:42:02,280
您正在处理 theta 的所有其他元素
--besides theta one, one as if it were a constant. 00:42:02,280 --> 00:42:05,520
除了 theta 一个，一个就好像它是一个常数。
--So every other element that you differentiate, 00:42:05,520 --> 00:42:08,520
所以你区分的每一个其他元素，
--you would just treat as if it were a constant term 00:42:08,520 --> 00:42:11,240
你会把它当作一个常数项
--that were not a function of theta one, one. 00:42:11,280 --> 00:42:14,240
那不是 theta one, one 的函数。
--That's what the partial derivative here means. 00:42:14,240 --> 00:42:16,480
这就是这里的偏导数的意思。
--Okay, so this is the definition of the gradient. 00:42:18,880 --> 00:42:23,400
好的，这就是渐变的定义。
--And now one thing I really should mention here 00:42:23,400 --> 00:42:25,160
现在我真的应该在这里提一件事
--is that this notation here is admittedly really bad, 00:42:25,160 --> 00:42:30,160
是这里的符号确实很糟糕，
--but it's the thing people use, 00:42:30,360 --> 00:42:31,880
但这是人们使用的东西，
--and so we're going to have to get used to it 00:42:31,880 --> 00:42:33,440
所以我们将不得不习惯它
--to a certain extent. 00:42:33,440 --> 00:42:34,280
在某种程度上。
--And the reason why it's so bad 00:42:34,280 --> 00:42:35,840
以及它如此糟糕的原因
--is that this first usage of theta here, 00:42:35,840 --> 00:42:39,360
是这里第一次使用 theta，
--this is actually saying what parameter 00:42:39,360 --> 00:42:42,280
这实际上是在说什么参数
--we're differentiating with respect to. 00:42:42,280 --> 00:42:44,480
我们在区分方面。
--So f, if f has one argument, 00:42:44,480 --> 00:42:46,320
所以 f，如果 f 有一个参数，
--you actually don't even need that subscript. 00:42:46,320 --> 00:42:47,920
你实际上什至不需要那个下标。
--You just, you're always taking the gradient 00:42:47,920 --> 00:42:49,320
你只是，你总是走梯度
--of the, of its argument. 00:42:49,320 --> 00:42:50,760
的，它的论点。
--But as we'll see later, 00:42:50,760 --> 00:42:53,000
但正如我们稍后会看到的，
--if a function of a lot of arguments, 00:42:53,000 --> 00:42:54,960
如果一个有很多参数的函数，
--you want some way of specifying which argument 00:42:54,960 --> 00:42:57,080
你想要某种方式来指定哪个参数
--you're differentiating with respect to. 00:42:57,080 --> 00:42:59,040
你在区分方面。
--And so this is sort of what this subscript is saying here. 00:42:59,040 --> 00:43:01,440
所以这就是这个下标在这里所说的。
--Right, it's just saying which argument 00:43:01,440 --> 00:43:02,960
对，就是说哪个参数
--we're differentiating with respect to. 00:43:02,960 --> 00:43:05,120
我们在区分方面。
--This argument here is an actual value of theta 00:43:05,120 --> 00:43:08,400
这里的参数是 theta 的实际值
--that we're differentiating at. 00:43:08,440 --> 00:43:09,800
我们与众不同之处。
--It's the point that we're differentiating at. 00:43:09,800 --> 00:43:12,120
这是我们与众不同的地方。
--And so it causes quite a bit of confusion, 00:43:12,120 --> 00:43:14,480
所以它引起了相当多的混乱，
--but the reality is you have to just get used to this. 00:43:14,480 --> 00:43:16,160
但现实是你必须习惯这一点。
--So sorry, the notation is bad. 00:43:16,160 --> 00:43:17,960
很抱歉，符号不好。
--We use a lot of bad notation in machine learning, 00:43:17,960 --> 00:43:20,000
我们在机器学习中使用了很多错误的符号，
--but I'm intentionally including bad notation 00:43:20,000 --> 00:43:22,720
但我故意包含错误的符号
--rather than introducing better notation. 00:43:22,720 --> 00:43:24,360
而不是引入更好的符号。
--Some people use like, like an index here. 00:43:24,360 --> 00:43:28,400
有些人在这里使用 like, like 索引。
--They'll use like one or zero or things like that. 00:43:28,400 --> 00:43:30,680
他们会使用 1 或 0 之类的东西。
--And that's objectively better notation, 00:43:30,680 --> 00:43:33,360
这是客观上更好的表示法，
--but it's not common. 00:43:33,360 --> 00:43:34,240
但这并不常见。
--So I'm going to use the common, but bad notation, 00:43:34,240 --> 00:43:36,880
所以我要使用常见但不好的表示法，
--and you'll have to just kind of, 00:43:36,880 --> 00:43:38,160
你将不得不，
--unfortunately, get a bit used to it. 00:43:38,160 --> 00:43:39,960
不幸的是，有点习惯了。
--Now, the nice thing about this gradient, 00:43:41,320 --> 00:43:43,680
现在，这个渐变的好处是，
--what this gradient does is it points. 00:43:43,680 --> 00:43:45,920
这个渐变的作用是指向。
--Remember from sort of 1D calculus, right, 00:43:45,920 --> 00:43:48,160
记得从某种一维微积分开始，对吧，
--that the gradient or the derivative of a function 00:43:48,160 --> 00:43:51,400
函数的梯度或导数
--was equal to the slope of that function. 00:43:51,400 --> 00:43:54,200
等于该函数的斜率。
--Well, that same intuition holds in higher dimensions too. 00:43:54,200 --> 00:43:57,880
好吧，同样的直觉也适用于更高的维度。
--And so if we have some function, 00:43:57,880 --> 00:43:59,200
所以如果我们有一些功能，
--so this function here is like a function 00:43:59,200 --> 00:44:00,600
所以这里的这个函数就像一个函数
--where, you know, this would be like the minimum, 00:44:00,600 --> 00:44:02,040
你知道，这是最低限度的，
--and these would be like, you know, 00:44:02,040 --> 00:44:02,880
这些就像，你知道的，
--points of the function getting bigger and bigger. 00:44:02,880 --> 00:44:05,640
功能点越来越大。
--What the gradient does, 00:44:06,240 --> 00:44:08,280
渐变的作用，
--remember the gradient is sort of itself a matrix 00:44:08,280 --> 00:44:12,160
记住梯度本身就是一个矩阵
--or for, you know, a vector case for the, 00:44:12,160 --> 00:44:14,360
或者，你知道，一个矢量案例，
--if the input function was vector value, it would be a vector. 00:44:14,360 --> 00:44:16,840
如果输入函数是向量值，它将是一个向量。
--It points in the direction of greatest increase of F, 00:44:16,840 --> 00:44:21,840
它指向 F 增加最大的方向，
--at least locally. 00:44:22,760 --> 00:44:23,600
至少在当地。
--So if we're, you know, we're right here, this is theta, 00:44:23,600 --> 00:44:26,880
所以如果我们，你知道，我们就在这里，这是 theta，
--the theta value we're evaluating the gradient at, 00:44:26,880 --> 00:44:28,640
我们正在评估梯度的 theta 值，
--then the gradient would point 00:44:28,640 --> 00:44:30,160
那么梯度会指向
--in the direction of maximal increase. 00:44:30,160 --> 00:44:33,000
向最大增加的方向。
--And that's a very, very powerful notion, right? 00:44:34,000 --> 00:44:38,040
这是一个非常非常强大的概念，对吧？
--We don't need to somehow search all possible values of F 00:44:38,040 --> 00:44:41,840
我们不需要以某种方式搜索 F 的所有可能值
--for the one that actually causes it to increase the most. 00:44:41,840 --> 00:44:45,720
对于实际导致它增加最多的那个。
--With a little bit of calculus, 00:44:45,720 --> 00:44:47,880
通过一点微积分，
--you at least in a local sense have the direction, 00:44:47,880 --> 00:44:52,520
你至少在局部意义上有方向，
--already immediately have the direction 00:44:52,520 --> 00:44:55,600
已经马上有了方向
--in this parameter space 00:44:55,600 --> 00:44:58,080
在这个参数空间
--that increases the function the most. 00:44:58,080 --> 00:45:00,000
这增加了最多的功能。
--And that's sort of amazing. 00:45:00,000 --> 00:45:01,360
这有点不可思议。
--You can get it basically, and as we'll see, you know, 00:45:01,360 --> 00:45:03,480
你基本上可以得到它，正如我们将看到的，你知道，
--there typically exists ways 00:45:03,480 --> 00:45:04,600
通常有一些方法
--of computing gradients very efficiently. 00:45:04,600 --> 00:45:06,400
非常有效地计算梯度。
--This is what the whole lectures 00:45:06,400 --> 00:45:08,960
这就是整个讲座的内容
--of automatic differentiation will cover, 00:45:08,960 --> 00:45:10,680
自动微分将涵盖，
--but we can compute it very efficiently. 00:45:10,680 --> 00:45:12,400
但我们可以非常有效地计算它。
--And in doing so, we can really easily figure out 00:45:12,400 --> 00:45:16,560
这样做，我们真的可以很容易地弄清楚
--how to change or how to optimize our parameters theta. 00:45:16,560 --> 00:45:20,280
如何改变或优化我们的参数 theta。
--So how do we do that? 00:45:21,320 --> 00:45:22,160
那我们该怎么做呢？
--Well, this leads us very immediately 00:45:22,160 --> 00:45:24,040
好吧，这会立即引导我们
--to what the kind of the core algorithm, I would argue, 00:45:24,040 --> 00:45:27,160
什么样的核心算法，我会争辩说，
--of almost all machine learning, right? 00:45:27,160 --> 00:45:29,400
几乎所有的机器学习，对吧？
--So how do we then use this fact to optimize our function? 00:45:29,720 --> 00:45:34,720
那么我们如何使用这个事实来优化我们的功能呢？
--Well, if the gradient points 00:45:35,280 --> 00:45:38,160
好吧，如果梯度点
--in the direction of maximal increase, 00:45:38,160 --> 00:45:41,880
在最大增加的方向上，
--then if we want to minimize our function, 00:45:41,880 --> 00:45:43,840
那么如果我们想最小化我们的功能，
--which is again the convention for sort of minimizing losses, 00:45:43,840 --> 00:45:47,200
这又是一种最小化损失的惯例，
--what we can do is we can set theta 00:45:47,200 --> 00:45:49,840
我们能做的就是设置 theta
--to be equal to theta minus some multiple of its gradient. 00:45:49,840 --> 00:45:54,840
等于 theta 减去它梯度的某个倍数。
--So here alpha is what's called a step size 00:45:56,120 --> 00:45:58,120
所以这里的 alpha 就是所谓的步长
--or a learning rate. 00:45:58,120 --> 00:45:59,880
或学习率。
--It's just some small positive quantity. 00:45:59,880 --> 00:46:02,440
这只是一些小的正数。
--So we subtract off some small positive multiple 00:46:02,440 --> 00:46:06,520
所以我们减去一些小的正倍数
--of the gradient. 00:46:06,520 --> 00:46:07,440
的渐变。
--And it should make sense 00:46:08,520 --> 00:46:09,360
它应该是有道理的
--that these are all the correct size here, right? 00:46:09,360 --> 00:46:11,080
这些都是正确的尺寸，对吧？
--Because theta here in our case is N by K 00:46:11,080 --> 00:46:14,280
因为这里的 theta 在我们的例子中是 N x K
--and the gradients also N by K. 00:46:14,280 --> 00:46:18,080
并且梯度也是 N×K。
--Multiply by scalar just scales the whole thing. 00:46:19,400 --> 00:46:21,280
乘以标量只是缩放整个事物。
--And so this is sort of a valid update we can do. 00:46:21,280 --> 00:46:24,560
所以这是我们可以做的有效更新。
--All the sides is check out. 00:46:24,560 --> 00:46:26,680
所有方面都检查出来。
--And the key idea though, 00:46:26,680 --> 00:46:28,280
关键的想法是，
--is because the gradient points 00:46:28,280 --> 00:46:29,520
是因为梯度点
--in the direction of greatest increase, 00:46:29,520 --> 00:46:32,120
朝着最大增长的方向，
--we want to minimize the function. 00:46:32,120 --> 00:46:33,520
我们想最小化函数。
--Then subtracting off a small amount of the gradient 00:46:33,520 --> 00:46:36,160
然后减去少量的梯度
--causes that function to decrease. 00:46:36,160 --> 00:46:37,800
导致该功能下降。
--Now, and this actually, 00:46:39,720 --> 00:46:42,000
现在，这实际上，
--before I go into the details of this, 00:46:42,000 --> 00:46:43,280
在详细介绍之前，
--I should just take a moment to say that, 00:46:43,280 --> 00:46:46,120
我应该花点时间说
--to sort of appreciate the power of this approach. 00:46:46,120 --> 00:46:50,560
有点欣赏这种方法的力量。
--So it is not an exaggeration 00:46:50,560 --> 00:46:53,680
所以并不夸张
--to say that this basic idea of gradient descent 00:46:53,680 --> 00:46:56,240
说梯度下降的这个基本思想
--powers all deep learning. 00:46:57,840 --> 00:47:00,440
为所有深度学习提供动力。
--Maybe not. 00:47:00,440 --> 00:47:01,280
也许不会。
--There's probably a few gradient free approaches 00:47:01,280 --> 00:47:03,920
可能有一些无梯度的方法
--that people occasionally use, 00:47:03,920 --> 00:47:05,520
人们偶尔使用，
--but 99% of all deep learning. 00:47:05,520 --> 00:47:09,520
但 99% 的深度学习。
--And because deep learning is so prevalent here, 00:47:09,520 --> 00:47:11,000
因为深度学习在这里如此普遍，
--you have 99% of all, 00:47:11,000 --> 00:47:12,280
你拥有99%的一切，
--90% say of all AI that you see, right? 00:47:13,160 --> 00:47:15,800
 90% 的人都说了你看到的所有 AI，对吗？
--So those images of dogs, 00:47:15,800 --> 00:47:18,440
所以那些狗的照片，
--dog professors you saw last lecture, 00:47:18,440 --> 00:47:22,120
你上次演讲看到的狗教授，
--the large language models, 00:47:22,120 --> 00:47:25,240
大型语言模型，
--these alpha fold, 00:47:25,240 --> 00:47:26,400
这些阿尔法折叠，
--they're all basically built 00:47:26,400 --> 00:47:30,080
他们基本上都建成了
--using this one line of math. 00:47:30,080 --> 00:47:33,200
使用这一行数学。
--That for some reason, 00:47:33,200 --> 00:47:34,160
出于某种原因，
--actually is also still not often taught 00:47:34,160 --> 00:47:36,240
其实也还不常教
--in like under basic, 00:47:36,240 --> 00:47:37,680
在基本情况下，
--their first undergraduate course, 00:47:37,680 --> 00:47:38,960
他们的第一个本科课程，
--which I think is crazy. 00:47:38,960 --> 00:47:40,880
我认为这很疯狂。
--This is such a fundamental algorithm 00:47:40,880 --> 00:47:43,720
这是一个如此基本的算法
--that it is really hard to overstate 00:47:43,720 --> 00:47:46,360
真的很难夸大
--just how impactful gradient descent 00:47:46,360 --> 00:47:49,640
梯度下降的影响力有多大
--has been on really the field of machine learning, 00:47:49,640 --> 00:47:53,600
一直在真正的机器学习领域，
--but arguably even the world as a whole right now, right? 00:47:53,600 --> 00:47:56,720
但现在甚至可以说整个世界都是如此，对吧？
--So it's really an amazing algorithm 00:47:56,720 --> 00:47:59,200
所以这真的是一个了不起的算法
--that is foundational at this point 00:47:59,200 --> 00:48:03,560
这是目前的基础
--to all deep learning. 00:48:03,560 --> 00:48:06,160
对所有深度学习。
--And of course, when I say gradient descent, 00:48:06,160 --> 00:48:07,400
当然，当我说梯度下降时，
--I mean gradient descent and its variants, 00:48:07,400 --> 00:48:09,120
我的意思是梯度下降及其变体，
--really any gradient based optimization technique, 00:48:09,120 --> 00:48:11,760
任何基于梯度的优化技术，
--but it is still amazing 00:48:11,760 --> 00:48:15,920
但它仍然很棒
--how prevalent these things really are. 00:48:15,920 --> 00:48:18,240
这些东西真的很普遍。
--Now, the one sort of big question you have here, 00:48:19,840 --> 00:48:23,680
现在，你在这里遇到的一个大问题，
--you may have looking at this 00:48:23,680 --> 00:48:24,760
你可能看过这个
--and you will continue to have it 00:48:24,760 --> 00:48:26,080
你会继续拥有它
--even as you get very experienced 00:48:26,080 --> 00:48:27,800
即使你变得非常有经验
--with machine learning probably, 00:48:27,800 --> 00:48:29,120
可能通过机器学习，
--is what value we should pick for this alpha here? 00:48:29,120 --> 00:48:32,240
在这里我们应该为这个 alpha 选择什么值？
--How big of a step do we take? 00:48:32,240 --> 00:48:33,920
我们迈出了多大的一步？
--And it turns out, 00:48:33,920 --> 00:48:35,360
事实证明，
--we'll actually have this a lot in the course, 00:48:35,360 --> 00:48:37,160
我们在课程中实际上会有很多，
--but the choice of alpha here 00:48:37,160 --> 00:48:39,880
但是在这里选择 alpha
--really very greatly affects 00:48:39,880 --> 00:48:42,240
真的非常影响
--kind of the behavior of this method. 00:48:42,240 --> 00:48:43,960
这种方法的行为。
--So if you take a small alpha, 00:48:43,960 --> 00:48:45,400
所以如果你拿一个小阿尔法，
--so I'm showing here just another simple function. 00:48:45,400 --> 00:48:47,720
所以我在这里展示的只是另一个简单的函数。
--So these blue lines here 00:48:47,720 --> 00:48:49,120
所以这里的这些蓝线
--correspond to level sets of the function. 00:48:49,120 --> 00:48:50,960
对应于函数的水平集。
--I'm just gonna bold out like this. 00:48:50,960 --> 00:48:52,920
我只是要像这样大胆。
--And if you take small gradient steps, 00:48:52,920 --> 00:48:55,960
如果你采取小的梯度步骤，
--you sort of make small, slow progress, right? 00:48:55,960 --> 00:48:58,200
你有点小，进展缓慢，对吧？
--You sort of go here and then here 00:48:58,200 --> 00:48:59,440
你有点去这里然后这里
--and you kind of make small, steady progress 00:48:59,440 --> 00:49:01,440
你有点小，稳定的进步
--toward the optimum. 00:49:01,440 --> 00:49:03,320
走向最优。
--If you take bigger steps, 00:49:03,320 --> 00:49:04,600
如果你迈出更大的步伐，
--you sort of make pretty good, fast, rapid progress, 00:49:04,600 --> 00:49:07,680
你取得了相当不错、快速、迅速的进步，
--much more rapid progress toward the optimum. 00:49:07,680 --> 00:49:10,120
朝着最佳方向更快地进步。
--But if you take too large step, 00:49:10,120 --> 00:49:12,760
但如果你迈出太大的一步，
--you start kind of bouncing around 00:49:12,760 --> 00:49:14,320
你开始蹦蹦跳跳
--and not being optimal anymore. 00:49:14,320 --> 00:49:16,480
并且不再是最优的。
--And in fact, if we take a much bigger step, 00:49:16,520 --> 00:49:18,520
事实上，如果我们迈出更大的一步，
--we can take such a big step 00:49:18,520 --> 00:49:19,800
我们可以迈出如此大的一步
--that we actually overshoot 00:49:19,800 --> 00:49:21,400
我们实际上超调了
--and increase our function each time 00:49:21,400 --> 00:49:23,440
每次都增加我们的功能
--and kind of diverge off to infinity. 00:49:23,440 --> 00:49:25,880
有点发散到无穷大。
--So it wouldn't quite follow that path. 00:49:25,880 --> 00:49:27,320
所以它不会完全遵循那条路。
--It would bounce around a bit differently. 00:49:27,320 --> 00:49:28,800
它会以不同的方式反弹。
--I guess it would go like here and here and whatever. 00:49:28,800 --> 00:49:31,520
我想它会像这里和这里一样进行。
--We'll do that last one, 00:49:31,520 --> 00:49:32,560
我们会做最后一个，
--but here and sort of shoot around this thing somehow. 00:49:32,560 --> 00:49:36,680
但是在这里，以某种方式围绕这件事进行射击。
--Wouldn't do that. 00:49:37,520 --> 00:49:38,360
不会那样做。
--I have a hard time drawing the paths, 00:49:38,360 --> 00:49:40,120
我很难画出路径，
--but basically you will start to diverge 00:49:40,120 --> 00:49:42,640
但基本上你会开始发散
--and not converge to anything. 00:49:42,640 --> 00:49:44,240
并且不收敛于任何东西。
--So the choice of step size here 00:49:44,240 --> 00:49:46,880
所以这里步长的选择
--is really, really important 00:49:46,880 --> 00:49:48,680
真的非常重要
--when it comes to choosing how we optimize this function. 00:49:48,680 --> 00:49:53,680
在选择我们如何优化此功能时。
--And in fact, as a quick preview for a few lectures from now, 00:49:56,400 --> 00:50:01,080
事实上，作为从现在开始的几节课的快速预习，
--if you've heard about optimization methods like Adam 00:50:01,080 --> 00:50:05,120
如果你听说过像 Adam 这样的优化方法
--or gradient descent with momentum, things like this, 00:50:05,120 --> 00:50:10,120
或动量梯度下降，像这样，
--what those essentially are, 00:50:10,120 --> 00:50:12,520
这些本质上是什么，
--those are ways to try to accelerate this process 00:50:12,680 --> 00:50:16,320
这些是试图加速这一进程的方法
--without having to worry quite as much about step size. 00:50:16,320 --> 00:50:19,640
不必担心步长。
--That is a huge simplification I know, 00:50:19,640 --> 00:50:21,520
我知道这是一个巨大的简化，
--but basically a lot of slightly more advanced 00:50:21,520 --> 00:50:25,440
但基本上稍微高级了很多
--optimization methods are just ways 00:50:25,440 --> 00:50:27,080
优化方法只是方法
--of trying to optimize this thing 00:50:27,080 --> 00:50:29,080
试图优化这件事
--with a little bit less effort in picking step sizes. 00:50:29,080 --> 00:50:32,440
在选择步长时花费更少的精力。
--All right. 00:50:35,000 --> 00:50:35,840
好的。
--And now finally, what I'll say is 00:50:35,840 --> 00:50:37,680
最后，我要说的是
--even the last algorithm we described 00:50:37,680 --> 00:50:40,600
甚至我们描述的最后一个算法
--is not quite the thing that we really do in deep learning 00:50:40,600 --> 00:50:43,840
并不是我们在深度学习中真正做的事情
--because if we look at our loss function, 00:50:45,000 --> 00:50:48,080
因为如果我们看一下我们的损失函数，
--what is the thing we're trying to optimize? 00:50:48,080 --> 00:50:50,240
我们要优化的是什么？
--Again, we're trying to minimize over theta. 00:50:50,240 --> 00:50:54,000
同样，我们试图最小化 over theta。
--This is now again for sort of general machine learning, 00:50:55,000 --> 00:50:57,520
这又是一种通用机器学习，
--not just soft mass regression. 00:50:57,520 --> 00:51:00,800
不仅仅是软质量回归。
--The average of the loss applied between the hypothesis, 00:51:00,800 --> 00:51:05,800
假设之间应用的平均损失，
--I'm sorry, not X, H of X, I, H of X, I, and Y, I. 00:51:06,360 --> 00:51:11,360
对不起，不是 X，X 的 H，我，X 的 H，我，和 Y，我。
--And if we were to take the gradient of this whole thing, 00:51:15,440 --> 00:51:18,600
如果我们采用这整件事的梯度，
--well, the gradient of this whole thing 00:51:19,600 --> 00:51:22,720
好吧，整个事情的梯度
--would just be equal to the sum of all the gradients of it. 00:51:22,720 --> 00:51:27,720
将等于它所有梯度的总和。
--So the gradient of this whole thing 00:51:27,760 --> 00:51:30,000
所以整个事情的梯度
--would be equal to the sum from I equals one to M 00:51:30,000 --> 00:51:33,560
将等于从 I 等于 1 到 M 的总和
--of the gradients with the theta of that thing. 00:51:33,560 --> 00:51:36,040
那个东西的theta的梯度。
--And the problem there is that if I get more data, 00:51:38,120 --> 00:51:43,120
问题是，如果我获得更多数据，
--this is to be clear, this is the sum from one to M. 00:51:44,320 --> 00:51:47,400
这是要清楚的，这是从1到M的总和。
--If I get more and more data to apply gradient descent 00:51:51,000 --> 00:51:54,840
如果我得到越来越多的数据来应用梯度下降
--to my kind of core optimization procedure, 00:51:54,840 --> 00:51:57,600
对于我的核心优化程序，
--I would have to do more and more work 00:51:57,600 --> 00:51:59,960
我将不得不做越来越多的工作
--for each gradient step, 00:51:59,960 --> 00:52:01,520
对于每个梯度步骤，
--which is really kind of wasteful. 00:52:02,520 --> 00:52:04,200
这真的有点浪费。
--It's sort of bizarre to think that if, you know, 00:52:04,200 --> 00:52:05,600
想想有点奇怪，如果，你知道，
--in the limit of having infinite data, 00:52:05,600 --> 00:52:07,600
在拥有无限数据的极限下，
--we will actually make no progress 00:52:07,600 --> 00:52:09,240
我们实际上不会取得任何进展
--because we will just forever be computing our gradient, 00:52:09,240 --> 00:52:12,160
因为我们将永远计算我们的梯度，
--which doesn't seem to be the right thing, right? 00:52:12,160 --> 00:52:14,160
这似乎不对，对吧？
--And there's also other issues too, right? 00:52:14,160 --> 00:52:15,960
还有其他问题，对吗？
--Like if in deep learning in particular, 00:52:15,960 --> 00:52:18,120
尤其是在深度学习中，
--if you try to compute the gradient over all your data, 00:52:18,120 --> 00:52:20,120
如果您尝试计算所有数据的梯度，
--you will run out of memory. 00:52:20,120 --> 00:52:21,080
你会耗尽内存。
--You can't fit all your data in memory, 00:52:21,080 --> 00:52:22,960
你不能把所有的数据都放在内存中，
--let alone the terms you need 00:52:22,960 --> 00:52:24,440
更不用说你需要的条款了
--to compute the gradients in memory. 00:52:24,440 --> 00:52:26,000
计算内存中的梯度。
--And so you will actually not be able to do this. 00:52:26,000 --> 00:52:28,880
所以你实际上无法做到这一点。
--So what deep learning really does 00:52:28,880 --> 00:52:32,800
那么深度学习到底做了什么
--is not running classical gradient descent, 00:52:32,800 --> 00:52:34,440
没有运行经典梯度下降，
--but it runs a variant called stochastic gradient descent, 00:52:34,440 --> 00:52:38,320
但它运行一个称为随机梯度下降的变体，
--or SGD. 00:52:38,320 --> 00:52:39,760
或新加坡元。
--Now, SGD kind of in theory can be formulated 00:52:39,760 --> 00:52:42,640
现在，SGD 理论上可以制定
--as kind of this stochastic minimization procedure 00:52:42,640 --> 00:52:46,680
作为这种随机最小化程序的一种
--where you have sort of sampling random variables, 00:52:46,680 --> 00:52:51,640
在那里你有一些抽样随机变量，
--which have the expectation of the true gradient, 00:52:51,640 --> 00:52:56,640
具有真实梯度的期望，
--but have some variants of them. 00:52:57,640 --> 00:53:00,040
但有一些变体。
--That's sort of a mathematical interpretation of SGD. 00:53:00,040 --> 00:53:04,880
这是对 SGD 的一种数学解释。
--What SGD in practice means 00:53:04,880 --> 00:53:07,760
 SGD 在实践中意味着什么
--is that you just split up your data set 00:53:07,760 --> 00:53:10,120
是你只是拆分了你的数据集
--into what we call mini batches. 00:53:10,120 --> 00:53:12,520
进入我们所说的小批量。
--So these are basically are, 00:53:12,520 --> 00:53:13,480
所以这些基本上是，
--what these are, are these are subsets of your data 00:53:13,480 --> 00:53:16,920
这些是什么，这些是你数据的子集吗
--of size B. 00:53:16,920 --> 00:53:18,560
尺寸 B。
--So B, big B here is what we call the batch size 00:53:18,560 --> 00:53:21,280
所以B，这里的大B就是我们所说的batch size
--or the mini batch size. 00:53:21,280 --> 00:53:23,320
或小批量。
--And what we do in stochastic gradient descent 00:53:23,320 --> 00:53:26,920
以及我们在随机梯度下降中所做的
--is we first sample a mini batch of data. 00:53:26,920 --> 00:53:29,480
我们首先对一小批数据进行采样。
--So we sampled B examples, 00:53:29,480 --> 00:53:30,880
所以我们采样了B个例子，
--or maybe more than even sampling them. 00:53:30,880 --> 00:53:32,320
甚至可能不仅仅是对它们进行采样。
--What we really typically do is divide the whole data set up 00:53:32,320 --> 00:53:35,200
我们真正通常做的是划分整个数据集
--into however many we need to have each one be size B, 00:53:35,200 --> 00:53:38,400
不管我们需要多少，每一个都是B号的，
--and then just cycle over all these subsets of size B. 00:53:38,400 --> 00:53:43,400
然后循环遍历所有这些大小为 B 的子集。
--So we take this up to the size B where we have both the, 00:53:43,520 --> 00:53:45,640
所以我们把它提高到 B 号，我们同时拥有，
--I guess we should emphasize, 00:53:45,640 --> 00:53:46,480
我想我们应该强调，
--we have both the input, 00:53:46,480 --> 00:53:48,440
我们都有输入，
--the input now matrix of the stacked form 00:53:48,440 --> 00:53:51,600
堆叠形式的输入现在矩阵
--of these B examples and the corresponding outputs. 00:53:51,640 --> 00:53:55,520
这些 B 示例和相应的输出。
--And we update the parameters by taking a gradient step 00:53:55,520 --> 00:53:59,240
我们通过采取梯度步骤来更新参数
--as if our loss was just those B examples. 00:53:59,240 --> 00:54:04,080
好像我们的损失只是那些 B 的例子。
--And so the way to think about this 00:54:05,360 --> 00:54:06,840
所以思考这个问题的方式
--is that each step we take here 00:54:06,840 --> 00:54:09,720
是我们在这里迈出的每一步
--is sort of a rough approximation to our true gradient, 00:54:09,720 --> 00:54:13,560
是我们真实梯度的粗略近似值，
--but one that we can take much more quickly. 00:54:13,560 --> 00:54:15,640
但我们可以更快地接受。
--And actually there are even sometimes an advantage of this 00:54:15,640 --> 00:54:17,880
实际上有时甚至有一个优势
--in the case of deep learning in particular, 00:54:17,880 --> 00:54:19,560
特别是在深度学习的情况下，
--because we often can, 00:54:19,560 --> 00:54:23,040
因为我们经常可以，
--having a little bit of noise 00:54:23,040 --> 00:54:23,880
有一点噪音
--actually can be helpful in some cases too. 00:54:23,880 --> 00:54:25,640
实际上在某些情况下也很有帮助。
--So it's sort of a noisy approximation 00:54:25,640 --> 00:54:27,800
所以这是一个嘈杂的近似值
--of the thing we think we would ideally like to optimize, 00:54:27,800 --> 00:54:31,520
我们认为我们最想优化的事情，
--but it's one that we can optimize much, much quicker. 00:54:31,520 --> 00:54:34,360
但我们可以更快地优化它。
--So basically rather than summing over, 00:54:34,360 --> 00:54:35,680
所以基本上而不是总结，
--just to emphasize this in our equation here, 00:54:35,680 --> 00:54:37,960
只是为了在我们的等式中强调这一点，
--rather than summing over all M, 00:54:37,960 --> 00:54:39,480
而不是对所有 M 求和，
--we could just sum over all B, 00:54:39,480 --> 00:54:41,240
我们可以对所有 B 求和，
--and that's much faster to compute, right? 00:54:41,240 --> 00:54:43,120
这样计算起来要快得多，对吧？
--Because there are only B of them, 00:54:43,120 --> 00:54:45,400
因为只有B，
--which is, you know, 00:54:45,400 --> 00:54:46,600
也就是说，你知道，
--hundreds say instead of millions potentially of examples. 00:54:46,600 --> 00:54:49,680
数百个例子而不是数百万个潜在的例子。
--And now I can sort of more formally say that in fact, 00:54:50,520 --> 00:54:54,200
现在我可以更正式地说 事实上
--this is the algorithm that drives all those advances 00:54:54,200 --> 00:54:56,800
这是推动所有这些进步的算法
--you've seen in deep learning over recent years. 00:54:56,800 --> 00:55:00,040
你在最近几年的深度学习中看到过。
--This and very minor variants are how for the most part, 00:55:00,040 --> 00:55:04,400
这个和非常小的变体在大多数情况下是如何的，
--we train every single deep learning algorithm. 00:55:04,400 --> 00:55:07,640
我们训练每一个深度学习算法。
--Though we will talk later about how we actually, 00:55:07,640 --> 00:55:12,640
虽然我们稍后会谈到我们实际上是如何，
--some of the more kind of common methods like momentum 00:55:12,640 --> 00:55:16,280
一些更常见的方法，如动量
--or like Adam and things like this. 00:55:16,960 --> 00:55:18,400
或者像亚当之类的。
--All right, so that's it. 00:55:19,360 --> 00:55:21,920
好吧，就这样吧。
--This is the optimization procedure. 00:55:21,920 --> 00:55:23,440
这是优化过程。
--It's the third ingredient 00:55:23,440 --> 00:55:24,600
这是第三种成分
--of our softmax regression algorithm. 00:55:24,600 --> 00:55:26,440
我们的 softmax 回归算法。
--But to finalize it, we have one last step, 00:55:26,440 --> 00:55:30,160
但要完成它，我们还有最后一步，
--which is how do we actually compute the gradient 00:55:30,160 --> 00:55:33,720
这就是我们实际如何计算梯度
--of our objective of the sum of losses 00:55:33,720 --> 00:55:37,360
我们的损失总和目标
--with respect to our parameters theta? 00:55:37,360 --> 00:55:40,280
关于我们的参数 theta？
--In other words, how do we compute the gradient 00:55:40,280 --> 00:55:42,800
换句话说，我们如何计算梯度
--with respect to theta of the thing we want to optimize, 00:55:42,800 --> 00:55:45,680
关于我们要优化的事物的 theta，
--which is the sum of a bunch of these terms. 00:55:46,080 --> 00:55:47,040
这是一堆这些术语的总和。
--But you know, we can take the, 00:55:47,040 --> 00:55:48,160
但是你知道，我们可以采取，
--if we can compute the gradient of one such term, 00:55:48,160 --> 00:55:52,120
如果我们可以计算其中一项的梯度，
--we can just sum them all together 00:55:52,120 --> 00:55:53,520
我们可以把它们加在一起
--to get the gradient of our entire objective. 00:55:53,520 --> 00:55:55,760
得到我们整个目标的梯度。
--So how do we do this? 00:55:58,200 --> 00:55:59,280
那么我们该怎么做呢？
--Well, it turns out it's actually not that hard, 00:56:00,400 --> 00:56:04,040
嗯，事实证明其实并没有那么难，
--but it's not that easy either. 00:56:04,040 --> 00:56:06,120
但这也不是那么容易。
--And in fact, when I learned machine learning, 00:56:06,120 --> 00:56:10,160
事实上，当我学习机器学习时，
--this is what you did, right? 00:56:10,160 --> 00:56:11,240
这是你做的，对吧？
--You devise a new objective and you go through by hand 00:56:11,240 --> 00:56:14,480
你设计了一个新的目标，然后你亲手完成了
--and derive all the gradients. 00:56:14,520 --> 00:56:16,280
并导出所有梯度。
--We live in better times now. 00:56:17,640 --> 00:56:19,320
我们现在生活在更好的时代。
--And the reality is most of the time when you develop models, 00:56:19,320 --> 00:56:23,160
而现实是大多数时候当你开发模型时，
--you will not have to do this. 00:56:23,160 --> 00:56:24,680
你不必这样做。
--In fact, the whole point of automatic differentiation, 00:56:24,680 --> 00:56:27,800
其实整点自动微分，
--which is what we're gonna cover in a few lectures 00:56:27,800 --> 00:56:29,720
这就是我们将在几节课中介绍的内容
--is an algorithmic way of defining 00:56:29,720 --> 00:56:33,480
是一种定义算法的方法
--just what the hypothesis and loss function look like. 00:56:33,480 --> 00:56:37,280
假设和损失函数是什么样的。
--And then basically letting the program 00:56:37,280 --> 00:56:41,400
然后基本上让程序
--automatically compute gradients for us. 00:56:41,400 --> 00:56:44,640
自动为我们计算梯度。
--Automatic differentiation is just a programmatic way 00:56:44,640 --> 00:56:48,000
自动微分只是一种程序化的方式
--to create gradients. 00:56:48,000 --> 00:56:49,960
创建渐变。
--But for this lecture and for the next lecture, actually, 00:56:51,040 --> 00:56:52,960
但是对于这一讲和下一讲，实际上，
--I'm gonna show you what you've maybe seen before. 00:56:52,960 --> 00:56:56,440
我要给你看你以前可能见过的东西。
--Before, we don't know that yet. 00:56:56,440 --> 00:56:58,520
之前，我们还不知道。
--I'm gonna show you kind of what you may have seen before 00:56:58,520 --> 00:57:00,200
我要给你看你以前可能见过的东西
--if you've taken a machine learning course. 00:57:00,200 --> 00:57:02,360
如果您参加过机器学习课程。
--Because to write an automatic differentiation tool, 00:57:02,360 --> 00:57:05,240
因为要写一个自动微分工具，
--you will have to at least take some gradients. 00:57:05,240 --> 00:57:07,840
你将不得不至少采取一些渐变。
--So you will have to compute some gradients here. 00:57:09,000 --> 00:57:10,800
所以你必须在这里计算一些梯度。
--And I'm gonna take you through kind of, 00:57:11,240 --> 00:57:12,680
我要带你经历，
--I guess, how we used to do machine learning, 00:57:12,680 --> 00:57:14,560
我想，我们过去是如何进行机器学习的，
--which is mainly deriving the gradients for all these things. 00:57:14,560 --> 00:57:18,160
这主要是推导所有这些东西的梯度。
--And yes, we really did do this back in the day, 00:57:18,160 --> 00:57:21,200
是的，我们确实在当天这样做过，
--the dark ages. 00:57:21,200 --> 00:57:22,040
黑暗时代。
--Even though automatic differentiation 00:57:22,040 --> 00:57:23,040
即使自动微分
--can go back to the 70s, 00:57:23,040 --> 00:57:24,400
可以回到70年代，
--it really did not take hold 00:57:24,400 --> 00:57:26,720
它真的没有抓住
--until deep learning really took off. 00:57:26,720 --> 00:57:28,760
直到深度学习真正起飞。
--This was sort of the genesis of these tools 00:57:28,760 --> 00:57:32,360
这是这些工具的起源
--being really widely popular. 00:57:32,360 --> 00:57:34,200
真的很受欢迎。
--All right, so how do we compute this gradient? 00:57:35,600 --> 00:57:38,040
好吧，那么我们如何计算这个梯度呢？
--Well, it turns out it's actually not that easy, 00:57:38,040 --> 00:57:41,800
嗯，事实证明其实没那么容易，
--but we can break it down step-by-step. 00:57:41,800 --> 00:57:43,960
但我们可以一步一步地分解它。
--It's not that hard either. 00:57:43,960 --> 00:57:45,440
这也不难。
--So let's first do the following. 00:57:45,440 --> 00:57:47,880
因此，让我们首先执行以下操作。
--So it's computing this whole thing, 00:57:47,880 --> 00:57:49,200
所以它正在计算这整个事情，
--actually, it is a bit tricky. 00:57:49,200 --> 00:57:51,280
实际上，这有点棘手。
--Doing it correctly is actually very cumbersome if I'm honest. 00:57:51,280 --> 00:57:54,960
老实说，正确地做实际上非常麻烦。
--But let's start off, 00:57:54,960 --> 00:57:55,800
但让我们开始吧，
--and we're gonna do it kind of incorrectly in a moment, 00:57:55,800 --> 00:57:57,880
一会儿我们会做错了，
--but let's start off with doing a simpler problem. 00:57:57,880 --> 00:58:01,360
但让我们从做一个更简单的问题开始。
--This term here is a matrix. 00:58:03,560 --> 00:58:05,360
这里的这个术语是一个矩阵。
--This here is terms of vectors. 00:58:05,360 --> 00:58:06,640
这是向量项。
--It gets a bit, you know, 00:58:06,720 --> 00:58:07,560
它变得有点，你知道，
--they're sort of, you have to play the chain rule 00:58:07,560 --> 00:58:09,720
他们有点像，你必须遵守链式法则
--kind of stuff. 00:58:09,720 --> 00:58:10,560
那种东西。
--Let's take a simpler problem. 00:58:10,560 --> 00:58:12,440
让我们来看一个更简单的问题。
--And first, just think about treating h, 00:58:12,440 --> 00:58:16,480
首先，想想治疗 h，
--not as the hypothesis class, 00:58:16,480 --> 00:58:17,680
不是作为假设类，
--but just as an arbitrary vector. 00:58:17,680 --> 00:58:19,120
但就像一个任意向量。
--It's actually gonna be one step of our derivation. 00:58:19,120 --> 00:58:21,800
这实际上将是我们推导的一个步骤。
--And let's see if we can differentiate just the gradient 00:58:21,800 --> 00:58:26,480
让我们看看我们是否可以仅区分梯度
--of our cross-entropy loss, 00:58:26,480 --> 00:58:29,120
我们的交叉熵损失，
--treating its argument h as a vector. 00:58:29,120 --> 00:58:31,800
将其参数 h 视为向量。
--So basically we wanna compute this thing here. 00:58:32,640 --> 00:58:35,200
所以基本上我们想在这里计算这个东西。
--But remember the elements of the gradient 00:58:35,200 --> 00:58:37,040
但是请记住渐变的元素
--are just equal to the partial derivatives, 00:58:37,040 --> 00:58:39,840
正好等于偏导数，
--this thing here. 00:58:39,840 --> 00:58:41,360
这东西在这里。
--So I'm just gonna first, to compute my gradient, 00:58:41,360 --> 00:58:45,480
所以我首先要计算我的梯度，
--I'm gonna first compute what the partial derivatives are. 00:58:45,480 --> 00:58:49,160
我要先计算偏导数是什么。
--So let's just do that. 00:58:49,160 --> 00:58:50,480
所以让我们这样做吧。
--So this is gonna be equal to the partial derivative 00:58:50,480 --> 00:58:52,480
所以这将等于偏导数
--with respect to h i of, well, what? 00:58:52,480 --> 00:58:55,920
关于喜的，嗯，什么？
--Well, I'm just gonna write our loss function again. 00:58:55,920 --> 00:58:58,560
好吧，我只是要再次编写我们的损失函数。
--So this would be negative h y, 00:58:58,560 --> 00:59:00,720
所以这将是负的 hy，
--because you can go back a few slides, 00:59:00,720 --> 00:59:02,840
因为你可以返回几张幻灯片，
--but just trust me, I'm just gonna be rewriting now 00:59:02,840 --> 00:59:05,020
但请相信我，我现在要重写
--what the cross-entropy loss actually is, 00:59:05,840 --> 00:59:08,300
交叉熵损失实际上是什么，
--plus the log sum from i equals one, 00:59:09,900 --> 00:59:14,900
加上 i 的对数和等于 1，
--or I'll actually use j, 00:59:15,620 --> 00:59:17,820
或者我实际上会使用 j，
--because I use i to index over examples. 00:59:17,820 --> 00:59:20,380
因为我用 i 来索引示例。
--So j equals one to m to k 00:59:20,380 --> 00:59:23,100
所以 j 等于 1 到 m 到 k
--of the exponential of h j. 00:59:24,220 --> 00:59:28,620
 h j 的指数。
--I'm just writing the definition of the cross-entropy loss 00:59:30,260 --> 00:59:32,940
我只是在写交叉熵损失的定义
--using h's now as arbitrary vectors. 00:59:32,940 --> 00:59:35,260
现在使用 h 作为任意向量。
--Okay, so what is this? 00:59:36,620 --> 00:59:38,260
好的，那这是什么？
--Well, this first term, let's just do this. 00:59:38,260 --> 00:59:40,540
好吧，这第一个学期，我们就这样做吧。
--What's this derivative of this first term here? 00:59:40,540 --> 00:59:43,480
这里第一个术语的派生词是什么？
--Well, that would be zero unless i equals y. 00:59:43,480 --> 00:59:48,480
好吧，那将是零，除非我等于 y。
--Otherwise it'll be one, 00:59:49,460 --> 00:59:50,700
否则它会是一个，
--or otherwise it'll be negative one actually, right? 00:59:50,700 --> 00:59:53,060
否则它实际上是负数，对吗？
--So if y equals i, 00:59:53,060 --> 00:59:55,460
所以如果 y 等于 i，
--this derivative of this term is negative one, 00:59:55,460 --> 00:59:58,920
这一项的这个导数是负的，
--otherwise it's zero. 00:59:58,920 --> 01:00:00,540
否则为零。
--The way we can write this is as a negative indicator, 01:00:00,540 --> 01:00:03,540
我们可以把它写成一个负面指标，
--so one indicator of i being equal to y. 01:00:03,540 --> 01:00:07,220
所以我等于 y 的一个指标。
--All right, what about this next term? 01:00:10,580 --> 01:00:11,800
好吧，那下学期呢？
--What is the derivative with respect to h i of this term? 01:00:11,800 --> 01:00:16,800
这一项关于 hi 的导数是什么？
--Well, now we have to just sort of do it. 01:00:19,180 --> 01:00:20,340
好吧，现在我们必须这样做。
--So let's play the basic chain rule. 01:00:20,340 --> 01:00:22,260
因此，让我们玩基本的链式法则。
--So the derivative of the log of something 01:00:22,260 --> 01:00:24,420
所以某物的对数的导数
--is the derivative of the thing inside 01:00:24,420 --> 01:00:27,660
是里面东西的导数
--divided by that thing, right? 01:00:27,660 --> 01:00:28,980
除以那个东西，对吧？
--So this is going to be equal to plus 01:00:28,980 --> 01:00:31,540
所以这将等于加上
--the derivative of this thing, the thing inside the log. 01:00:31,540 --> 01:00:36,540
这东西的衍生物，日志里面的东西。
--So that's gonna be the derivative with respect to h i 01:00:36,820 --> 01:00:41,140
所以这将是关于 hi 的导数
--of the sum from j equals one to k 01:00:41,140 --> 01:00:45,460
来自 j 的总和等于 1 到 k
--of the exponential of h j, 01:00:45,460 --> 01:00:48,780
 hj 的指数，
--all divided by the sum from j equals, 01:00:48,780 --> 01:00:53,340
全部除以 j 的总和等于，
--write it like this, 01:00:54,220 --> 01:00:55,180
这样写，
--j equals one to k of exponential of h j. 01:00:56,180 --> 01:01:01,180
 j 等于 h j 的指数的一到 k。
--But now, 01:01:08,740 --> 01:01:09,580
但现在，
--this numerator here, 01:01:12,460 --> 01:01:14,500
这个分子在这里，
--well, if I'm taking the derivative 01:01:14,500 --> 01:01:16,060
好吧，如果我采用导数
--of the sum of all these exponentials, 01:01:16,060 --> 01:01:18,820
所有这些指数的总和，
--again, I'm taking a partial derivative 01:01:18,820 --> 01:01:20,220
再次，我正在采取偏导数
--of the h i of this sum. 01:01:20,220 --> 01:01:22,540
这笔钱的喜。
--And because all the terms but h i 01:01:22,580 --> 01:01:25,660
因为所有的条款，但嗨
--are considered to be, 01:01:25,660 --> 01:01:27,080
被认为是，
--considered to be constants. 01:01:29,060 --> 01:01:33,060
被认为是常数。
--In fact, here, I'm actually, 01:01:33,060 --> 01:01:33,900
事实上，在这里，我实际上，
--I mean, the reason why I use j there, by the way, 01:01:33,900 --> 01:01:35,500
我的意思是，顺便说一句，我在那里使用 j 的原因，
--in this case, was because I'm differentiating 01:01:35,500 --> 01:01:37,540
在这种情况下，是因为我在区分
--with respect to h i, 01:01:37,540 --> 01:01:38,700
关于嗨，
--not actually because of the example. 01:01:38,700 --> 01:01:40,580
实际上不是因为这个例子。
--So this is just because I'm differentiating 01:01:40,580 --> 01:01:41,740
所以这只是因为我在区分
--with respect to h i here. 01:01:41,740 --> 01:01:43,220
关于嗨这里。
--So I had to use the sum over j. 01:01:43,220 --> 01:01:45,140
所以我不得不使用 j 上的总和。
--But taking the derivative of this inside thing here, 01:01:46,660 --> 01:01:48,900
但是在这里取这个内部事物的导数，
--well, that's gonna be zero for all j 01:01:48,900 --> 01:01:51,300
好吧，这对所有 j 来说都是零
--except j equals i. 01:01:51,300 --> 01:01:52,940
除了 j 等于 i。
--And for that one j equals i term, 01:01:53,860 --> 01:01:56,520
对于那个 j 等于 i 项，
--well, the exponential, 01:01:56,520 --> 01:01:57,780
嗯，指数，
--the derivative of the exponential 01:01:57,780 --> 01:01:58,700
指数的导数
--is just that same thing. 01:01:58,700 --> 01:01:59,820
就是同样的事情。
--So this whole thing here is going to be equal 01:01:59,820 --> 01:02:02,380
所以这里的整个事情都是平等的
--to the exponential of h, 01:02:02,380 --> 01:02:07,380
到 h 的指数，
--well, let me put parentheses there, 01:02:07,900 --> 01:02:09,820
好吧，让我把括号放在那里，
--of h i divided by, 01:02:09,820 --> 01:02:12,220
嗨除以，
--see if I can write this without getting in the way of it, 01:02:12,220 --> 01:02:14,540
看看我能不能在不妨碍它的情况下写这个，
--the sum from j equals one to k of exponential of h j. 01:02:14,540 --> 01:02:19,540
 j 的和等于 h j 的指数的一到 k。
--That'd be nicer. 01:02:22,260 --> 01:02:23,100
那会更好。
--H j. 01:02:24,620 --> 01:02:25,460
 Hj。
--But this thing here should look very familiar to you. 01:02:29,420 --> 01:02:34,420
不过这里的这个东西大家应该很眼熟吧。
--Right, it's just that same softmax operator 01:02:34,700 --> 01:02:37,860
对，就是同一个 softmax 算子
--we had before, right? 01:02:37,860 --> 01:02:38,700
我们以前有过，对吧？
--It's the exponential of the hypothesis 01:02:38,700 --> 01:02:41,700
这是假设的指数
--divided by the sum of the exponentials, 01:02:41,700 --> 01:02:43,620
除以指数之和，
--i.e. the softmax, 01:02:43,620 --> 01:02:44,460
即softmax，
--i.e. the normalization of the exponential of h. 01:02:44,460 --> 01:02:47,260
即h的指数的归一化。
--So we can write this whole thing much nicer 01:02:48,100 --> 01:02:51,100
所以我们可以把这整件事写得更好
--or the whole derivative now much nicer in vector form. 01:02:51,900 --> 01:02:54,620
或者整个导数现在以矢量形式更好。
--In particular, we can write this whole thing 01:02:54,620 --> 01:02:56,660
特别是，我们可以写这整件事
--as the gradient of the cross entropy loss 01:02:56,660 --> 01:03:01,580
作为交叉熵损失的梯度
--with respect to h, 01:03:01,580 --> 01:03:02,700
关于 h，
--just equal to z, 01:03:02,700 --> 01:03:05,500
刚好等于 z，
--which is gonna be here, 01:03:05,500 --> 01:03:06,740
会在这里，
--z equals normalizing the exponential, 01:03:06,740 --> 01:03:11,740
 z 等于归一化指数，
--weirdly, exponential of h 01:03:15,260 --> 01:03:18,260
奇怪的是，h 的指数
--or the softmax of h, 01:03:19,260 --> 01:03:21,180
或 h 的 softmax，
--minus a term that has a, 01:03:22,340 --> 01:03:24,940
减去一个术语，
--minus this term here, 01:03:24,940 --> 01:03:26,020
在这里减去这个词，
--which this term here is gonna have a zero everywhere 01:03:26,020 --> 01:03:28,540
这里的这个词到处都是零
--except the one in the y-th position. 01:03:28,540 --> 01:03:31,820
除了第 y 个位置的那个。
--And the very common way of writing that 01:03:31,820 --> 01:03:33,980
以及非常常见的写作方式
--is as z minus e sub y, 01:03:33,980 --> 01:03:38,980
是 z 减去 e 子 y，
--where e is called the unit basis, okay? 01:03:38,980 --> 01:03:43,060
其中 e 称为单位基础，好吗？
--So just to highlight everything in the end, 01:03:43,060 --> 01:03:45,820
所以最后只是为了强调一切，
--this term here is our final gradient 01:03:45,820 --> 01:03:50,820
这个术语是我们的最终梯度
--of the cross entropy loss 01:03:53,420 --> 01:03:55,260
交叉熵损失
--with respect to the input, 01:03:55,260 --> 01:04:00,060
关于输入，
--its input, treating its input as a vector. 01:04:00,060 --> 01:04:02,300
它的输入，将其输入视为一个向量。
--Okay. 01:04:05,860 --> 01:04:06,700
好的。
--So are we there yet? 01:04:10,500 --> 01:04:11,500
那我们到了吗？
--So close but so far in a way. 01:04:12,980 --> 01:04:15,220
如此接近，但在某种程度上如此遥远。
--Because how do we compute what we really want? 01:04:16,060 --> 01:04:18,020
因为我们如何计算我们真正想要的东西？
--We actually don't want the gradient 01:04:18,020 --> 01:04:19,380
我们实际上不想要渐变
--with respect to the input to the loss function, 01:04:19,380 --> 01:04:21,420
关于损失函数的输入，
--we want the gradient with respect to theta of this thing. 01:04:21,420 --> 01:04:23,940
我们想要关于这个东西的 theta 的梯度。
--How do we compute that? 01:04:23,940 --> 01:04:25,940
我们如何计算呢？
--And it's, I mean, the way you would do it, right, 01:04:25,940 --> 01:04:29,580
这就是，我的意思是，你会这样做的方式，对吧，
--is you use something like the chain rule, okay? 01:04:29,580 --> 01:04:31,820
你用的是链式法则之类的东西，好吗？
--Because we want the gradient 01:04:31,820 --> 01:04:32,660
因为我们想要渐变
--of with respect to something inside, 01:04:32,660 --> 01:04:34,780
关于里面的东西，
--you can use the chain rule. 01:04:34,780 --> 01:04:36,620
你可以使用链式法则。
--But the dimensions here are nasty. 01:04:36,620 --> 01:04:40,100
但是这里的尺寸很讨厌。
--I mean, and this is like the simplest possible, 01:04:40,100 --> 01:04:42,340
我的意思是，这是最简单的方法，
--you know, thing you can imagine, right? 01:04:42,340 --> 01:04:43,540
你知道，你可以想象的事情，对吧？
--It's a linear hypothesis function, 01:04:43,540 --> 01:04:45,460
这是一个线性假设函数，
--but this term here is a matrix. 01:04:46,100 --> 01:04:48,580
但是这里的这个术语是一个矩阵。
--This term here is a vector. 01:04:48,580 --> 01:04:50,340
这里的这个术语是一个向量。
--So we want like the derivative of a vector 01:04:50,340 --> 01:04:55,060
所以我们想要一个向量的导数
--with respect to a matrix. 01:04:55,060 --> 01:04:56,180
关于矩阵。
--It's like some odd tensor. 01:04:56,180 --> 01:04:58,420
这就像一些奇怪的张量。
--It turns out this gets really cumbersome really quickly. 01:04:58,420 --> 01:05:02,300
事实证明，这很快就会变得非常麻烦。
--And so we need some sort of more powerful 01:05:03,180 --> 01:05:08,260
所以我们需要某种更强大的
--or more kind of almost a rigorous 01:05:08,260 --> 01:05:12,300
或者更严格一点
--because we've got to see on the slide 01:05:12,300 --> 01:05:14,180
因为我们必须在幻灯片上看到
--sort of throws that out the window, 01:05:14,180 --> 01:05:15,460
有点把它扔出窗外，
--but we need some sort of more general 01:05:15,460 --> 01:05:17,700
但我们需要某种更通用的
--and generic way to take derivatives 01:05:17,700 --> 01:05:20,700
和采用导数的通用方法
--when we have multivariate, multidimensional matrix, 01:05:20,700 --> 01:05:24,980
当我们有多元、多维矩阵时，
--matrix quantities, et cetera, 01:05:24,980 --> 01:05:27,060
矩阵量等，
--eventually tensor quantities, stuff like that. 01:05:27,060 --> 01:05:29,660
最终张量，诸如此类。
--So how do we do this? 01:05:29,660 --> 01:05:30,660
那么我们该怎么做呢？
--Well, there's two things we can do. 01:05:30,660 --> 01:05:32,460
好吧，我们可以做两件事。
--We can first do the right thing. 01:05:33,620 --> 01:05:35,460
我们可以先做正确的事。
--And to be clear, the right thing is 01:05:35,460 --> 01:05:37,220
需要明确的是，正确的做法是
--you can define generalizations of gradients like Jacobians 01:05:38,300 --> 01:05:42,700
你可以定义梯度的泛化，比如雅可比矩阵
--that actually are the derivative of a vector output 01:05:42,700 --> 01:05:46,300
实际上是向量输出的导数
--with respect to a vector 01:05:46,300 --> 01:05:48,180
关于向量
--or the matrix of all partial derivatives there. 01:05:48,180 --> 01:05:51,700
或那里所有偏导数的矩阵。
--But when you have then matrices 01:05:51,700 --> 01:05:53,300
但是当你有矩阵时
--you differentiate with respect to, 01:05:53,300 --> 01:05:54,140
你区别于，
--you need to use things like Kronecker products 01:05:54,140 --> 01:05:55,940
你需要使用 Kronecker 产品之类的东西
--and vectorization, 01:05:55,940 --> 01:05:57,380
和矢量化，
--but you can formalize all of this 01:05:57,380 --> 01:06:00,100
但你可以将所有这些形式化
--using matrix differential calculus. 01:06:00,100 --> 01:06:01,740
使用矩阵微积分。
--So there really are ways to sort of go through formally 01:06:01,740 --> 01:06:05,300
所以确实有一些方法可以正式通过
--what every single derivative you want to compute here 01:06:05,300 --> 01:06:08,260
你想在这里计算的每一个导数是什么
--or every single sort of gradient 01:06:08,260 --> 01:06:09,900
或每一种渐变
--and partial derivative and Jacobian here is. 01:06:09,900 --> 01:06:12,620
而这里的偏导数和雅可比行列式是。
--You can also do this out term by term, 01:06:13,460 --> 01:06:14,300
你也可以一个学期一个学期地做，
--but that's even worse, 01:06:14,300 --> 01:06:15,140
但更糟糕的是，
--but you can do this all very formally 01:06:15,140 --> 01:06:17,580
但你可以非常正式地做这一切
--with matrix differential calculus. 01:06:17,580 --> 01:06:19,940
与矩阵微分学。
--We're not gonna do that though. 01:06:21,460 --> 01:06:22,500
不过我们不会那样做。
--What we're gonna do is the horrifying 01:06:22,500 --> 01:06:25,620
我们要做的是可怕的
--but thing that everyone actually does, 01:06:26,740 --> 01:06:30,100
但每个人实际上都在做的事情，
--which is the following. 01:06:30,100 --> 01:06:31,060
这是以下内容。
--And if you haven't seen this before, 01:06:31,060 --> 01:06:32,540
如果你以前没见过这个，
--this is gonna be like a revelation to you 01:06:32,540 --> 01:06:34,900
这对你来说就像是一个启示
--if you've done these derivations before 01:06:34,900 --> 01:06:36,300
如果你之前做过这些推导
--and never realized that what people actually do 01:06:36,300 --> 01:06:38,220
从来没有意识到人们实际上在做什么
--is this thing. 01:06:38,220 --> 01:06:39,060
是这个东西。
--So I'm like pulling the cover back here 01:06:39,060 --> 01:06:41,780
所以我想把封面拉回来
--on big secret, 01:06:41,780 --> 01:06:44,180
关于大秘密，
--but it's not even a useful secret 01:06:44,180 --> 01:06:45,300
但这甚至不是一个有用的秘密
--because it's how we used to do these things. 01:06:45,300 --> 01:06:46,500
因为这就是我们过去做这些事情的方式。
--So this is how we used to do them. 01:06:46,500 --> 01:06:47,740
这就是我们过去的做法。
--And now it's useless, 01:06:47,740 --> 01:06:48,900
现在没用了，
--but anyway, pulling back the big secret here. 01:06:48,900 --> 01:06:51,140
不过不管怎样，扳回这里的天大秘密。
--The thing you do, 01:06:52,780 --> 01:06:53,620
你做的事，
--compute multivariate Jacobians, gradients, 01:06:54,620 --> 01:06:58,900
计算多元雅可比矩阵，梯度，
--derivatives, whatever. 01:06:58,900 --> 01:07:00,380
衍生品，随便什么。
--So you just pretend everything's a scalar, 01:07:00,380 --> 01:07:02,900
所以你假装一切都是标量，
--apply the normal chain rule 01:07:02,900 --> 01:07:04,700
应用正常链规则
--and then rearrange or transpose your outputs 01:07:04,700 --> 01:07:08,700
然后重新排列或转置您的输出
--such that everything works in terms of the sizes. 01:07:08,700 --> 01:07:12,420
这样一切都可以根据尺寸进行工作。
--And I really wanna highlight 01:07:12,420 --> 01:07:13,820
我真的很想强调
--this sort of horror emoji here. 01:07:13,820 --> 01:07:15,860
这里有这种恐怖表情符号。
--It is suitably, should be suitably horrified by this. 01:07:15,860 --> 01:07:19,740
它适当地，应该适当地被这个吓坏。
--Okay. 01:07:21,460 --> 01:07:22,300
好的。
--So this is what actually is done in practice 01:07:24,020 --> 01:07:25,700
所以这就是实践中实际做的
--and it is a bit horrifying, 01:07:25,700 --> 01:07:27,540
这有点可怕，
--but this is what people really do. 01:07:27,540 --> 01:07:29,140
但这就是人们真正做的。
--And it actually gets you get sort of used to it quickly. 01:07:29,140 --> 01:07:33,580
它实际上让你很快就习惯了。
--The thing I will say though 01:07:33,580 --> 01:07:35,060
我要说的是
--is what's very important to do if you ever do this 01:07:35,060 --> 01:07:37,380
这是非常重要的事情，如果你这样做的话
--is to check your answer 01:07:37,420 --> 01:07:39,540
是检查你的答案
--and check your answer numerically. 01:07:39,540 --> 01:07:40,980
并用数字检查你的答案。
--So we'll show actually in the next lectures 01:07:40,980 --> 01:07:42,220
所以我们将在下一节课中实际展示
--how you go about checking derivatives numerically. 01:07:42,220 --> 01:07:44,420
你如何用数字来检查导数。
--You'll do it in the second homework. 01:07:44,420 --> 01:07:46,260
你会在第二个作业中完成。
--This is because so much can go wrong 01:07:47,940 --> 01:07:51,580
这是因为很多事情都可能出错
--with this first approach. 01:07:51,580 --> 01:07:53,060
用第一种方法。
--You can use it as a hack, 01:07:53,060 --> 01:07:54,300
您可以将其用作 hack，
--but then check your answers after the fact. 01:07:54,300 --> 01:07:56,140
但事后检查你的答案。
--But this is literally what we do 01:07:56,140 --> 01:07:58,780
但这就是我们所做的
--when we wanna compute nasty gradients 01:07:58,780 --> 01:08:00,980
当我们想计算讨厌的梯度时
--or nasty high dimensional derivatives, whatever. 01:08:00,980 --> 01:08:04,060
或讨厌的高维衍生物，无论如何。
--It doesn't always work, 01:08:04,060 --> 01:08:04,940
它并不总是有效，
--but it works a surprisingly large amount of the time. 01:08:04,940 --> 01:08:06,780
但它的工作时间出奇的多。
--Always at least try this first. 01:08:07,620 --> 01:08:09,180
总是至少先试试这个。
--Okay, so how does this actually work? 01:08:10,900 --> 01:08:13,220
好的，那么这实际上是如何工作的呢？
--So let's say, let's try to compute this quantity. 01:08:15,780 --> 01:08:19,980
因此，让我们尝试计算这个数量。
--Let's try to compute the derivative 01:08:19,980 --> 01:08:22,380
让我们尝试计算导数
--of the cross entropy loss of our hypothesis function. 01:08:22,380 --> 01:08:25,180
我们的假设函数的交叉熵损失。
--This is the thing we actually want 01:08:26,020 --> 01:08:27,220
这才是我们真正想要的
--to compute the gradient of, 01:08:27,220 --> 01:08:29,180
计算的梯度，
--but let's do it assuming everything is kind of a scalar. 01:08:29,180 --> 01:08:32,860
但让我们假设一切都是标量。
--And I'm still gonna use the partial derivative sign here, 01:08:32,860 --> 01:08:36,140
我仍然会在这里使用偏导数符号，
--even though I should probably use like a, 01:08:36,140 --> 01:08:37,900
即使我可能应该使用像一个，
--just the normal not scripted Ds at this point, 01:08:37,900 --> 01:08:40,100
此时只是正常的未编写脚本的 Ds，
--but I'm gonna use the partial derivative sign 01:08:40,100 --> 01:08:41,260
但我要用偏导数符号
--to kind of remind me that I'm horribly cheating here 01:08:41,260 --> 01:08:44,940
有点提醒我，我在这里作弊得很厉害
--and should never actually do this. 01:08:44,940 --> 01:08:47,340
并且永远不应该这样做。
--Let's just do it. 01:08:47,340 --> 01:08:48,180
让我们开始吧。
--Let's pretend all of this really is scalar valued 01:08:48,180 --> 01:08:51,780
让我们假装所有这些都是标量值
--and kind of go from there. 01:08:51,780 --> 01:08:53,100
从那里开始。
--All right, so what is this? 01:08:54,220 --> 01:08:56,340
好吧，那这是什么？
--Well, now we can apply the normal. 01:08:56,340 --> 01:08:58,540
好了，现在我们可以应用法线了。
--So if we're computing this derivative, 01:08:58,540 --> 01:09:00,140
所以如果我们计算这个导数，
--now we can apply kind of the normal chain rule. 01:09:00,140 --> 01:09:02,660
现在我们可以应用一种正常的链式法则。
--So this would be the derivative of the loss, 01:09:02,660 --> 01:09:05,740
所以这将是损失的导数，
--the cross entropy loss of theta transposed X, 01:09:06,380 --> 01:09:08,820
 theta 转置 X 的交叉熵损失，
--theta transposed X and Y with respect to theta transposed X, 01:09:10,100 --> 01:09:15,100
 theta 转置 X 和 Y 相对于 theta 转置 X，
--that argument to the cross entropy loss times, 01:09:15,700 --> 01:09:20,300
交叉熵损失时间的论点，
--and it doesn't matter what this matrix, 01:09:20,300 --> 01:09:21,940
这个矩阵是什么并不重要，
--what times means here, 01:09:21,940 --> 01:09:22,780
时间在这里意味着什么，
--because they're all scalars. 01:09:22,780 --> 01:09:23,620
因为它们都是标量。
--It just means scalar multiplied by 01:09:23,620 --> 01:09:25,620
它只是意味着标量乘以
--the derivative of theta transposed X. 01:09:25,620 --> 01:09:27,780
theta 转置 X 的导数。
--And obviously we don't need transposes. 01:09:27,780 --> 01:09:29,660
显然我们不需要转置。
--They're all scalars now, but we'll still just include it 01:09:29,660 --> 01:09:31,460
它们现在都是标量，但我们仍然只包含它
--because you can always transpose a scalar. 01:09:31,460 --> 01:09:32,740
因为你总是可以转置一个标量。
--That's fine. 01:09:32,740 --> 01:09:34,220
没关系。
--With respect to theta. 01:09:34,220 --> 01:09:35,340
关于θ。
--Okay, so that's what we do. 01:09:36,740 --> 01:09:39,700
好的，这就是我们所做的。
--So what are those things? 01:09:39,700 --> 01:09:41,980
那么那些东西是什么？
--Well, now, if they're all scalar, 01:09:41,980 --> 01:09:43,300
那么，现在，如果它们都是标量，
--we actually can write this out really easily, right? 01:09:43,300 --> 01:09:44,860
我们实际上可以很容易地把它写出来，对吧？
--So this first thing here, this first term, 01:09:44,860 --> 01:09:47,740
所以这里的第一件事，第一个学期，
--this is actually just the derivative 01:09:48,580 --> 01:09:50,380
这实际上只是导数
--of the cross entropy loss with respect to its argument. 01:09:50,380 --> 01:09:53,820
关于其参数的交叉熵损失。
--That's exactly what we had last time, right? 01:09:54,700 --> 01:09:58,900
这正是我们上次的情况，对吧？
--So this is actually gonna be equal to 01:09:58,900 --> 01:10:00,980
所以这实际上等于
--exactly what's on the two slides ago. 01:10:00,980 --> 01:10:03,780
两张幻灯片前的确切内容。
--That's gonna be Z minus EY, 01:10:03,780 --> 01:10:06,980
那就是 Z 减去 EY，
--where here Z, just like before, 01:10:06,980 --> 01:10:10,060
这里 Z，就像以前一样，
--is equal to normalizing the exponential. 01:10:10,060 --> 01:10:15,060
等于对指数进行归一化。
--In this case, the hypothesis is gonna be 01:10:16,180 --> 01:10:17,740
在这种情况下，假设将是
--theta transposed Y. 01:10:17,740 --> 01:10:18,740
theta 转置 Y。
--Times, well, this one here, 01:10:21,980 --> 01:10:24,020
时间，好吧，这里的这个，
--when they're all scalars, is really easy. 01:10:24,020 --> 01:10:25,100
当它们都是标量时，真的很容易。
--The derivative of theta times X with the theta is just X. 01:10:25,100 --> 01:10:29,780
 theta 乘以 X 对 theta 的导数就是 X。
--All right, now we're almost done. 01:10:29,780 --> 01:10:34,780
好吧，现在我们差不多完成了。
--All we have to do now is talk about 01:10:37,140 --> 01:10:39,060
我们现在要做的就是谈谈
--what size these things are. 01:10:39,060 --> 01:10:40,420
这些东西有多大。
--All right, so this thing here, Z and EY, 01:10:41,420 --> 01:10:45,780
好吧，所以这件事，Z 和 EY，
--those are both K-dimensional vectors. 01:10:45,780 --> 01:10:48,180
这些都是K维向量。
--So this is a K-dimensional vector, 01:10:48,180 --> 01:10:50,420
所以这是一个K维向量，
--really a K by one dimensional matrix. 01:10:50,420 --> 01:10:53,460
真的是一个 K 乘一维矩阵。
--And this term here is X. 01:10:55,220 --> 01:10:57,540
这里的这个词是 X。
--So that's just gonna be an N by one, 01:10:57,540 --> 01:10:59,540
所以这只是一个 N 乘一个，
--N by one dimensional vector, 01:11:01,740 --> 01:11:04,940
 N个一维向量，
--or again, N dimensional vector 01:11:04,940 --> 01:11:07,540
或者，N 维向量
--and N by one dimensional matrix. 01:11:07,540 --> 01:11:09,300
和 N 由一维矩阵。
--All right, so how do we compute this gradient here? 01:11:10,900 --> 01:11:15,900
好吧，那么我们如何在这里计算这个梯度呢？
--The gradient we want is N by K. 01:11:16,940 --> 01:11:20,460
我们想要的梯度是 N x K。
--So how do we arrange those two terms, 01:11:20,460 --> 01:11:23,580
那么我们如何安排这两个术语，
--this term and this term, 01:11:23,580 --> 01:11:25,900
这个学期和这个学期，
--to make an N by K dimensional output? 01:11:25,900 --> 01:11:29,540
生成 N × K 维输出？
--Well, the way we would have to do it, 01:11:29,540 --> 01:11:31,900
好吧，我们必须这样做的方式，
--and the only option we have, 01:11:31,900 --> 01:11:33,580
而我们唯一的选择，
--is to take this and say this is going to be 01:11:33,580 --> 01:11:35,380
就是接受这个并说这将是
--X times Z minus EY transpose. 01:11:35,380 --> 01:11:40,380
X 乘以 Z 减去 EY 转置。
--That makes an N by K dimensional matrix. 01:11:41,420 --> 01:11:44,900
这构成了一个 N × K 维矩阵。
--And that, in fact, is the correct gradient 01:11:44,900 --> 01:11:47,380
事实上，这才是正确的梯度
--that we are after. 01:11:47,380 --> 01:11:48,260
我们所追求的。
--So yes, this is very embarrassing 01:11:49,780 --> 01:11:52,780
所以是的，这很尴尬
--that we do it this way, 01:11:52,780 --> 01:11:53,620
我们这样做，
--but we do it this way. 01:11:53,620 --> 01:11:55,300
但我们是这样做的。
--And in fact, even in deriving some of the gradients 01:11:55,300 --> 01:11:58,540
事实上，即使在推导一些梯度
--for individual operations in automatic differentiation, 01:11:58,540 --> 01:12:01,540
对于自动微分中的个别操作，
--you will also do it this way. 01:12:01,540 --> 01:12:02,980
你也会这样做。
--Okay, so the funny thing about this 01:12:04,860 --> 01:12:07,220
好吧，这件事很有趣
--is that this even works for the batch case too. 01:12:07,220 --> 01:12:09,780
这是否也适用于批处理案例。
--So we can, again, kind of abusing notation a bit, 01:12:09,780 --> 01:12:12,940
所以我们可以，再一次，有点滥用符号，
--we can write the loss function we really want 01:12:12,940 --> 01:12:14,780
我们可以写出我们真正想要的损失函数
--for a whole mini-batch, right? 01:12:14,780 --> 01:12:16,580
对于整个小批量，对吧？
--Which is sort of the loss function applied 01:12:16,580 --> 01:12:17,940
哪种损失函数适用
--to the hypothesis of a whole mini-batch, 01:12:17,940 --> 01:12:20,660
对于整个小批量的假设，
--which is X times theta. 01:12:20,660 --> 01:12:21,620
这是 X 乘以 theta。
--And we can write this all in the exact same way. 01:12:21,660 --> 01:12:23,340
我们可以用完全相同的方式来写这一切。
--So things actually are exactly the same as before. 01:12:23,340 --> 01:12:25,980
所以事情实际上和以前一模一样。
--If I want the derivative of this with respect to theta 01:12:26,820 --> 01:12:31,060
如果我想要这个关于 theta 的导数
--of loss, cross-entropy loss of X theta and Y, 01:12:31,060 --> 01:12:36,060
损失，X theta 和 Y 的交叉熵损失，
--well, that just will equal the partial derivative 01:12:37,100 --> 01:12:39,780
好吧，这将等于偏导数
--of the cross-entropy loss of X theta and Y. 01:12:39,780 --> 01:12:44,780
X theta 和 Y 的交叉熵损失。
--This is now matrices. 01:12:45,420 --> 01:12:47,180
这是现在的矩阵。
--It's the only difference from before. 01:12:47,180 --> 01:12:49,020
这是与以前唯一的区别。
--So, partial derivative with respect to X times theta, 01:12:49,380 --> 01:12:54,380
所以，关于 X 次 theta 的偏导数，
--and then derivative of X theta with respect to theta. 01:12:55,180 --> 01:12:58,740
然后是 X theta 关于 theta 的导数。
--Okay, this thing here would equal, 01:12:59,980 --> 01:13:04,980
好的，这里的东西等于，
--well, I'll write it like big Z minus I subscript Y. 01:13:05,700 --> 01:13:10,700
好吧，我会写成大 Z 减去 I 下标 Y。
--What this is saying here is this is big Z here 01:13:15,260 --> 01:13:17,580
这里说的是这里是大 Z
--would be something like normalizing, 01:13:17,580 --> 01:13:20,580
就像规范化一样，
--taking the hypothesis applying it to all the elements 01:13:22,460 --> 01:13:26,060
将假设应用于所有元素
--in our matrix X, and then normalizing by rows. 01:13:26,060 --> 01:13:28,620
在我们的矩阵 X 中，然后按行归一化。
--So it would be like normalize, 01:13:28,620 --> 01:13:30,300
所以这就像正常化，
--and I mean normalize here by row, 01:13:33,220 --> 01:13:36,900
我的意思是这里按行归一化，
--and run out of space, reminds myself, 01:13:37,740 --> 01:13:39,660
空间用完了，提醒自己，
--of X of X theta. 01:13:39,660 --> 01:13:42,820
 X 的 X 的。
--Okay, that's what big Z is. 01:13:44,340 --> 01:13:46,020
好吧，这就是大Z。
--And IY, that's like a one-hot encoding, 01:13:46,060 --> 01:13:49,580
 IY，这就像一个一次性编码，
--like the EY in each row. 01:13:49,580 --> 01:13:52,260
就像每一行中的 EY。
--So it's like a one-hot encoding of the output classes, 01:13:52,260 --> 01:13:55,500
所以它就像输出类的一次性编码，
--but then times X as before. 01:13:56,780 --> 01:13:58,460
但是然后像以前一样乘以 X。
--All right, so this, and now we just do the same exact thing. 01:14:00,420 --> 01:14:04,380
好吧，就这样，现在我们做同样的事情。
--So this matrix here, 01:14:04,380 --> 01:14:06,100
所以这里的矩阵，
--kind of running out of space right below, 01:14:07,460 --> 01:14:08,660
下面有点空间不足，
--but like this matrix here would be M by K, 01:14:08,660 --> 01:14:13,660
但是就像这个矩阵一样，这里是 M×K，
--because we would have each row would be kind of these terms. 01:14:14,220 --> 01:14:18,980
因为我们每一行都是这些术语。
--And we already know that X here, X here is M by K, right? 01:14:18,980 --> 01:14:23,980
我们已经知道这里的 X，这里的 X 是 M乘以 K，对吧？
--So how do we get our final product? 01:14:25,260 --> 01:14:27,620
那么我们如何获得最终产品呢？
--Which again, our final product is still N by K. 01:14:27,620 --> 01:14:31,820
同样，我们的最终产品仍然是 N x K。
--Well, what we do is we take things 01:14:31,820 --> 01:14:36,780
好吧，我们所做的就是拿东西
--to transpose them properly. 01:14:39,140 --> 01:14:40,820
正确地转置它们。
--It would be X transpose, right? 01:14:40,820 --> 01:14:44,100
应该是 X 转置，对吧？
--So X is M by K, so we want K by M, 01:14:44,100 --> 01:14:47,060
所以 X 是 M 乘以 K，所以我们想要 K 乘以 M，
--and then times this thing here, 01:14:48,060 --> 01:14:51,300
然后在这里对这件事进行计时，
--times Z minus IY. 01:14:53,180 --> 01:14:55,060
乘以 Z 减去 IY。
--And that, oops, let me just highlight it. 01:14:56,540 --> 01:14:59,820
而且，哎呀，让我强调一下。
--This here is the actual gradient we want. 01:14:59,820 --> 01:15:03,380
这是我们想要的实际梯度。
--So, you know, like five, how many characters this is? 01:15:03,380 --> 01:15:05,260
所以，你知道，就像五个，这是多少个字符？
--You know, 10 or so characters. 01:15:05,260 --> 01:15:07,380
你知道的，大约 10 个字符。
--That's the actual gradient we want. 01:15:07,380 --> 01:15:09,140
这就是我们想要的实际梯度。
--And now you might be sort of curious, 01:15:10,100 --> 01:15:11,020
现在你可能有点好奇，
--like why is this transpose, 01:15:11,020 --> 01:15:13,460
比如为什么这个转置，
--like why are these transposes here 01:15:13,460 --> 01:15:15,100
比如为什么这些转置在这里
--kind of reversed from this one? 01:15:15,100 --> 01:15:16,620
有点与这个相反？
--Remember that our big matrix X here, 01:15:16,620 --> 01:15:19,500
记住我们这里的大矩阵 X，
--we had the rows are already kind of the transpose versions 01:15:19,500 --> 01:15:23,020
我们的行已经是某种转置版本
--of the individual entries. 01:15:23,020 --> 01:15:25,700
个人条目。
--And so to compute this sort of properly, 01:15:25,700 --> 01:15:28,100
所以为了正确地计算这种类型，
--you have to transpose them 01:15:28,100 --> 01:15:29,900
你必须转置它们
--depending on how you set up these matrices, 01:15:29,900 --> 01:15:31,220
取决于你如何设置这些矩阵，
--but this thing here is the final expression we're after. 01:15:31,220 --> 01:15:35,740
但这里的这个东西是我们追求的最终表达。
--And that's actually somewhat confusing. 01:15:37,140 --> 01:15:37,980
这实际上有点令人困惑。
--I mean, you know, this is now a matrix. 01:15:38,180 --> 01:15:40,500
我的意思是，你知道，这现在是一个矩阵。
--This is another matrix here. 01:15:40,500 --> 01:15:42,180
这是这里的另一个矩阵。
--It's quite cumbersome to do this properly 01:15:42,180 --> 01:15:44,340
正确执行此操作非常麻烦
--with Konecker products and tensorization 01:15:44,340 --> 01:15:47,100
使用 Konecker 产品和张量化
--or vectorization, all that kind of stuff. 01:15:47,100 --> 01:15:49,580
或矢量化，所有这些东西。
--But again, once you've derived it, 01:15:49,580 --> 01:15:53,540
但同样，一旦你推导出它，
--you can in fact check numerically, 01:15:53,540 --> 01:15:55,380
你实际上可以检查数字，
--this is the correct thing, 01:15:55,380 --> 01:15:56,220
这是正确的事情，
--and it is in fact the correct gradient. 01:15:56,220 --> 01:15:58,740
它实际上是正确的梯度。
--So I just want to call you out 01:15:58,740 --> 01:16:00,740
所以我只想叫你出来
--to the title of this slide again. 01:16:00,740 --> 01:16:03,060
再次回到这张幻灯片的标题。
--It is rather embarrassing that we do things this way. 01:16:03,060 --> 01:16:06,100
我们这样做是相当尴尬的。
--You will eventually not do this at all in this course, 01:16:06,100 --> 01:16:09,580
在本课程中，您最终根本不会这样做，
--because of course this course is going to be about 01:16:09,580 --> 01:16:10,820
因为这当然是关于
--how you build automatic differentiation tools 01:16:10,820 --> 01:16:12,580
如何构建自动微分工具
--that let you avoid this, 01:16:12,580 --> 01:16:13,820
让你避免这种情况，
--but this is how we used to do machine learning. 01:16:13,820 --> 01:16:15,540
但这就是我们过去进行机器学习的方式。
--This used to be the trick 01:16:15,540 --> 01:16:16,380
这曾经是诀窍
--that everyone sort of did in machine learning 01:16:16,380 --> 01:16:18,060
每个人都在机器学习中做过
--and maybe no one really talked about, 01:16:18,060 --> 01:16:19,700
也许没有人真正谈论过，
--but now you know the secret too 01:16:19,700 --> 01:16:21,180
但现在你也知道了这个秘密
--if you want to do kind of old style machine learning. 01:16:21,180 --> 01:16:23,820
如果你想做那种老式的机器学习。
--One thing I will mention here before I go on, 01:16:25,180 --> 01:16:26,980
在我继续之前，我会在这里提到一件事，
--and we're pretty much done now, 01:16:26,980 --> 01:16:28,660
我们现在差不多完成了，
--but the one thing I will mention here 01:16:28,660 --> 01:16:30,380
但我要在这里提到的一件事
--is that it's really easy to screw this up. 01:16:30,380 --> 01:16:32,340
是真的很容易搞砸。
--So like these sizes are really important. 01:16:32,340 --> 01:16:35,900
所以像这些尺寸真的很重要。
--If you for example choose k equal to n, 01:16:36,660 --> 01:16:39,340
例如，如果您选择 k 等于 n，
--then it's really easy to mess up the dimensions here, 01:16:39,340 --> 01:16:41,300
那么这里的尺寸真的很容易搞乱，
--so you have to choose the dimensions 01:16:41,300 --> 01:16:42,460
所以你必须选择尺寸
--as different as possible as you could be 01:16:42,460 --> 01:16:45,140
尽可能不同
--to make this all work. 01:16:45,140 --> 01:16:46,260
使这一切工作。
--All right, but now we are done. 01:16:48,620 --> 01:16:51,380
好吧，但现在我们完成了。
--So despite what I admit is a fairly complex derivation, 01:16:52,860 --> 01:16:57,860
所以尽管我承认这是一个相当复杂的推导，
--what we are left with for softmax regression 01:16:59,500 --> 01:17:03,380
我们剩下的是 softmax 回归
--is something incredibly simple, 01:17:03,380 --> 01:17:05,540
是非常简单的东西，
--and I really want to emphasize this simplicity. 01:17:06,180 --> 01:17:08,580
我真的很想强调这种简单性。
--Okay, what does the final softmax regression algorithm 01:17:08,580 --> 01:17:11,500
好的，最后的softmax回归算法是什么
--look like? 01:17:11,500 --> 01:17:12,780
看起来像？
--Well, you split up your data, 01:17:12,780 --> 01:17:14,180
好吧，你拆分了你的数据，
--your training set into batches, 01:17:14,180 --> 01:17:15,900
你的训练集成批，
--you iterate over these batches of size b, 01:17:15,900 --> 01:17:18,980
你迭代这些大小为 b 的批次，
--so you iterate over your training batches of size b, 01:17:18,980 --> 01:17:22,340
所以你迭代大小为 b 的训练批次，
--and for each batch, you just update the parameters 01:17:24,100 --> 01:17:28,580
对于每个批次，您只需更新参数
--according to this gradient rule. 01:17:28,580 --> 01:17:30,740
按照这个梯度法则。
--I guess there's sort of one, 01:17:30,740 --> 01:17:32,020
我想有一种，
--I mean obviously you have to compute what z is 01:17:32,020 --> 01:17:34,100
我的意思是很明显你必须计算 z 是什么
--to really do this, 01:17:34,100 --> 01:17:35,500
要真正做到这一点，
--but this is five, six lines of Python code. 01:17:35,500 --> 01:17:39,940
但这是五六行 Python 代码。
--All those derivations you saw 01:17:41,500 --> 01:17:43,740
你看到的所有这些推导
--ultimately translate to an incredibly straightforward, 01:17:43,740 --> 01:17:47,020
最终转化为令人难以置信的直截了当，
--simple algorithm to implement, 01:17:47,020 --> 01:17:49,420
实现简单的算法，
--which you will actually implement on the first homework, 01:17:49,420 --> 01:17:53,460
你将在第一个家庭作业中实际实施，
--and that is the entirety 01:17:53,460 --> 01:17:54,660
这就是全部
--of the softmax regression algorithm. 01:17:54,660 --> 01:17:55,980
softmax回归算法。
--So despite some non-trivial math to get there, 01:17:55,980 --> 01:17:59,020
因此，尽管需要一些不平凡的数学才能到达那里，
--and you should acknowledge the fact 01:17:59,020 --> 01:18:02,980
你应该承认这个事实
--that this is not completely trivial, 01:18:02,980 --> 01:18:04,860
这不是完全微不足道的，
--these derivations here, 01:18:04,860 --> 01:18:06,740
这里的这些推导，
--even though we kind of cheated our way 01:18:06,740 --> 01:18:08,300
即使我们有点欺骗我们的方式
--into the hard part of the derivation, 01:18:08,300 --> 01:18:11,020
进入推导的困难部分，
--this is ultimately kind of a one-line description 01:18:11,020 --> 01:18:14,820
这最终是一种单行描述
--of the actual resulting algorithm, 01:18:14,820 --> 01:18:16,540
实际产生的算法，
--which you can implement, again, 01:18:16,540 --> 01:18:17,860
你可以再次实施，
--in a few lines of Python code. 01:18:17,860 --> 01:18:20,180
在几行 Python 代码中。
--And if you do it and implement this on the MNIST data, 01:18:22,340 --> 01:18:25,220
如果你这样做并在 MNIST 数据上实现它，
--you'll find you get about a little bit less than 8% error. 01:18:25,220 --> 01:18:28,540
你会发现你得到的错误率略低于 8%。
--So that is probably better, 01:18:28,540 --> 01:18:30,420
所以这可能更好，
--again, 10-way classification in one of 10 classes. 01:18:30,420 --> 01:18:33,500
同样，在 10 个类别中的一个类别中进行 10 向分类。
--With a linear hypothesis class, 01:18:33,500 --> 01:18:34,540
对于线性假设类，
--you're able to get 8% error. 01:18:34,540 --> 01:18:35,980
你能够得到 8% 的错误。
--That is probably better. 01:18:35,980 --> 01:18:37,780
那可能更好。
--Maybe, I'm not quite sure, 01:18:37,780 --> 01:18:38,780
也许，我不太确定，
--but that's probably better than what I could do by hand. 01:18:38,780 --> 01:18:42,060
但这可能比我手工做的要好。
--So that's really, really impressive. 01:18:44,740 --> 01:18:47,140
所以这真的非常令人印象深刻。
--And what we're gonna do next lecture 01:18:48,980 --> 01:18:51,140
下节课我们要做什么
--is we're gonna do the same thing, 01:18:51,140 --> 01:18:53,180
我们会做同样的事情吗
--basically in the exact same way. 01:18:53,180 --> 01:18:55,580
基本上以完全相同的方式。
--The only difference is we're gonna use neural networks, 01:18:55,580 --> 01:18:57,540
唯一的区别是我们要使用神经网络，
--but what that means is just a fancier hypothesis class. 01:18:57,540 --> 01:19:01,740
但这意味着只是一个更奇特的假设类。
--We're gonna use the same basic loss function, 01:19:02,700 --> 01:19:06,180
我们将使用相同的基本损失函数，
--cross-entropy loss. 01:19:06,180 --> 01:19:07,820
交叉熵损失。
--We're gonna use the same optimization procedure, 01:19:07,820 --> 01:19:10,820
我们将使用相同的优化程序，
--gradient descent or stochastic gradient descent. 01:19:10,820 --> 01:19:12,620
梯度下降或随机梯度下降。
--Naturally, computing gradients is a bit trickier, 01:19:12,620 --> 01:19:14,380
自然地，计算梯度有点棘手，
--but the procedure is the same. 01:19:14,380 --> 01:19:16,380
但程序是一样的。
--And the only difference for deep learning, 01:19:17,220 --> 01:19:19,540
深度学习的唯一区别是，
--in some sense, or for neural networks, 01:19:19,540 --> 01:19:21,060
在某种意义上，或者对于神经网络，
--is that we use a fancier nonlinear hypothesis class 01:19:21,060 --> 01:19:25,220
是我们使用了一个更高级的非线性假设类
--instead of the linear hypothesis class 01:19:25,220 --> 01:19:26,980
而不是线性假设类
--of softmax regression. 01:19:27,380 --> 01:19:28,500
softmax回归。
--That's gonna be next time. 01:19:30,740 --> 01:19:32,460
下次还会这样
--And for one more lecture next time, 01:19:32,460 --> 01:19:34,420
下次再讲一堂课，
--we are gonna go through this the old tedious way. 01:19:34,420 --> 01:19:38,980
我们将以陈旧乏味的方式进行。
--And after that, we'll go through it the nice way, 01:19:40,180 --> 01:19:43,140
在那之后，我们将通过它很好的方式，
--where you can now, after next lecture, 01:19:43,140 --> 01:19:45,500
你现在可以在哪里，在下节课之后，
--and I guess after you've implemented automatic deprecation 2, 01:19:45,500 --> 01:19:47,500
我想在你实施自动弃用 2 之后，
--you can forget about gradients 01:19:47,500 --> 01:19:49,820
你可以忘记渐变
--and let the automatic deprecation tool that you write 01:19:49,820 --> 01:19:52,740
并让您编写的自动弃用工具
--actually do all this math for you, 01:19:52,740 --> 01:19:55,380
实际上为你做所有这些数学，
--in the proper way I should mention to. 01:19:55,380 --> 01:19:57,860
我应该以正确的方式提及。
--All right, see you next time. 01:19:57,860 --> 01:19:59,300
好的，下次见。
