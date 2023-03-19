--Hi everyone, and welcome to the first lecture of our online course on deep learning systems, 00:00:00,000 --> 00:00:10,160
大家好，欢迎来到我们的深度学习系统在线课程第一讲，
--algorithms, and implementation. 00:00:10,160 --> 00:00:13,240
算法和实现。
--I'm Zico Coulter, I'm going to be giving this lecture, but I'm teaching this course with 00:00:13,240 --> 00:00:17,880
我是 Zico Coulter，我将主持这次讲座，但我正在教这门课程
--my co-instructor Tianqi Chen, who will be giving some of the later lectures. 00:00:17,880 --> 00:00:24,840
我的合作讲师陈天琪，他将在后面讲一些课。
--We're both faculty at Carnegie Mellon University, and we're also offering this course this 00:00:24,840 --> 00:00:29,880
我们都是卡内基梅隆大学的教员，我们也在这个时间开设这门课程
--fall at CMU, but we're making all the material public as part of this online course. 00:00:29,880 --> 00:00:40,120
属于 CMU，但作为此在线课程的一部分，我们将公开所有材料。
--This lecture is going to be a basic introduction to the topics of this course, as well as cover 00:00:40,120 --> 00:00:46,880
本讲座将是对本课程主题的基本介绍，以及涵盖
--some of the logistics of the course. 00:00:46,880 --> 00:00:50,800
课程的一些后勤工作。
--As such, it's going to be a bit different from other lectures, where we're actually going 00:00:50,800 --> 00:00:54,400
因此，它与我们实际要去的其他讲座有点不同
--to detail about the methods, the math, the code, etc. 00:00:54,400 --> 00:01:00,440
详细介绍方法、数学、代码等。
--This is really just a lecture with slides in it, but we're going to cover a bit about 00:01:00,440 --> 00:01:06,080
这实际上只是一个包含幻灯片的讲座，但我们将介绍一些关于
--why this course might be of interest to you, why we think these are important topics to 00:01:06,080 --> 00:01:12,520
为什么您可能会对本课程感兴趣，为什么我们认为这些是重要的主题
--know about, and also cover a bit of background on the logistics and setup of this course. 00:01:12,520 --> 00:01:22,080
了解并介绍本课程的后勤和设置的一些背景知识。
--Alright, so as I said, this lecture really has two parts. 00:01:22,760 --> 00:01:27,800
好吧，就像我说的，这个讲座真的有两个部分。
--The first part is about why you should study deep learning systems at all, why you might 00:01:27,800 --> 00:01:31,840
第一部分是关于为什么你应该研究深度学习系统，为什么你可能
--want to take this course, and the second will be more about the course info and logistics. 00:01:31,840 --> 00:01:38,320
想参加这门课程，第二个将更多关于课程信息和后勤。
--So let's jump right in and get started talking about why you might want to study deep learning 00:01:38,320 --> 00:01:44,240
那么让我们直接开始讨论为什么你可能想要学习深度学习
--systems. 00:01:44,240 --> 00:01:46,840
系统。
--Now the aim of this course is to provide you with an introduction to the functioning of 00:01:46,840 --> 00:01:53,120
现在本课程的目的是向您介绍
--modern deep learning systems. 00:01:53,120 --> 00:01:56,240
现代深度学习系统。
--And what that means is, you're going to learn about how these things work internally. 00:01:56,240 --> 00:02:04,200
这意味着，你将了解这些东西在内部是如何运作的。
--You're going to learn about methods like automatic differentiation, a number of basic neural 00:02:04,200 --> 00:02:10,160
你将学习自动微分之类的方法，一些基本的神经网络
--network architectures, optimization, as well as methods for efficient operations on systems 00:02:10,160 --> 00:02:18,760
网络架构、优化以及系统高效操作的方法
--like GPUs. 00:02:18,760 --> 00:02:19,760
像 GPU。
--This is how these modern deep learning systems actually are run efficiently on modern hardware. 00:02:19,760 --> 00:02:29,040
这就是这些现代深度学习系统实际上是如何在现代硬件上高效运行的。
--To solidify your understanding, the main effort that you'll put in throughout this course 00:02:29,040 --> 00:02:35,520
为了巩固您的理解，您将在整个课程中付出的主要努力
--is that through the homeworks, you will develop the NEEDLE library. 00:02:35,680 --> 00:02:42,120
就是通过作业，你将开发 NEEDLE 库。
--NEEDLE stands for the Necessary Elements of Deep Learning, and it's a deep learning library 00:02:42,120 --> 00:02:48,440
 NEEDLE代表深度学习的必要元素，它是一个深度学习库
--loosely similar to PyTorch. 00:02:48,440 --> 00:02:52,240
与 PyTorch 大致相似。
--You're going to incrementally throughout your assignments, implement many common architectures 00:02:52,240 --> 00:03:00,200
你将在整个任务中逐步实现许多常见的架构
--and many of the aspects of this library, really from scratch. 00:03:00,400 --> 00:03:07,560
这个图书馆的许多方面，真的是从头开始。
--So why should you do this? 00:03:07,560 --> 00:03:09,600
那你为什么要这样做呢？
--Why might you want to study deep learning, and why might you want to study deep learning 00:03:09,600 --> 00:03:14,680
你为什么要学习深度学习，为什么你要学习深度学习
--systems? 00:03:14,680 --> 00:03:15,680
系统？
--Well to start off with, let's answer the easier question first. 00:03:15,680 --> 00:03:19,800
那么首先，让我们先回答更简单的问题。
--Why do you want to study, or why might you want to study deep learning? 00:03:19,800 --> 00:03:24,520
为什么要学习，或者为什么要学习深度学习？
--Now chances are, if you're taking this course, you probably already like deep learning, or 00:03:24,520 --> 00:03:30,320
现在很有可能，如果你正在学习这门课程，你可能已经喜欢上了深度学习，或者
--at least know about deep learning, and probably have a pretty good idea about why you might 00:03:30,320 --> 00:03:35,160
至少了解深度学习，并且可能对为什么你可能有一个很好的想法
--want to study deep learning. 00:03:35,160 --> 00:03:37,440
想研究深度学习。
--But we'll give a few quick examples anyway, many of which you've probably already seen, 00:03:37,440 --> 00:03:42,800
但我们还是会给出一些简单的例子，其中很多你可能已经看过了，
--but it wouldn't really be a deep learning course if we didn't start off the first lecture 00:03:42,800 --> 00:03:47,200
但如果我们不从第一堂课开始，它就不是一门真正的深度学习课程
--with some cool pictures about the things that deep learning can currently do. 00:03:47,200 --> 00:03:52,840
有一些关于深度学习目前可以做的事情的很酷的图片。
--So maybe you heard about the famous AlexNet architecture, which was developed in 2012, 00:03:52,840 --> 00:04:02,040
所以也许你听说过 2012 年开发的著名的 AlexNet 架构，
--which performed very, very well on the ImageNet image classification challenge. 00:04:02,040 --> 00:04:08,520
在 ImageNet 图像分类挑战中表现非常非常好。
--I need to highlight right off the bat, this is not a history of deep learning, nor is 00:04:08,520 --> 00:04:13,600
我需要立即强调，这不是深度学习的历史，也不是
--it assigning credit to any sort of first elements, first architectures of deep learning. 00:04:13,600 --> 00:04:20,680
它将信用分配给任何类型的第一元素，深度学习的第一架构。
--That's an argument I do not want to get into. 00:04:20,680 --> 00:04:22,920
这是一个我不想参与的争论。
--But this was a very, very famous architecture that really, at least as a field and as a 00:04:22,920 --> 00:04:30,360
但这是一个非常非常有名的建筑，至少作为一个领域和一个
--technique in the public view, really did turn a corner on availability and power of deep 00:04:30,360 --> 00:04:40,320
在公众看来，这项技术确实扭转了深度的可用性和力量
--learning by essentially building an architecture that could classify images into one of a thousand 00:04:40,320 --> 00:04:46,000
通过本质上构建一个架构来学习，该架构可以将图像分类为一千个中的一个
--classes much better than standard computer vision techniques at the time. 00:04:46,000 --> 00:04:53,880
类比当时的标准计算机视觉技术好得多。
--You probably also heard about the AlphaGo system, which was developed in 2016 and defeated 00:04:53,880 --> 00:05:02,760
你可能也听说过 AlphaGo 系统，它于 2016 年开发并被击败
--not quite the world champion, I guess, or number one, but a very, very highly ranked, 00:05:02,760 --> 00:05:06,840
不完全是世界冠军，我猜，或者排名第一，但排名非常非常高，
--essentially one of the world's best players at the Game of Go. 00:05:06,840 --> 00:05:12,360
本质上是世界上最好的围棋棋手之一。
--Now the Game of Go, for a long time, was viewed as a grand challenge for computer play 00:05:12,360 --> 00:05:21,000
现在，围棋在很长一段时间内被视为对计算机游戏的重大挑战
--of games because the number of possible moves at each location is very, very large and standard 00:05:21,000 --> 00:05:27,440
游戏的数量，因为每个位置的可能移动数量非常非常大且标准
--techniques like those used in chess just weren't very applicable here. 00:05:27,440 --> 00:05:32,480
像国际象棋中使用的技术在这里不太适用。
--But using techniques from deep learning, this team at DeepMind was able to build a system 00:05:32,480 --> 00:05:39,440
但是使用深度学习技术，DeepMind 的这个团队能够构建一个系统
--that could defeat, essentially at the time, one of the best players in the world and soon 00:05:39,560 --> 00:05:45,000
这可能会击败，基本上在当时，世界上最好的球员之一，很快
--after all the best human players in the world. 00:05:45,000 --> 00:05:48,920
毕竟是世界上最好的人类球员。
--Much, much faster than I think anyone in the field really expected it to happen. 00:05:48,920 --> 00:05:56,520
比我认为该领域的任何人真正预期的要快得多。
--Maybe you've also heard or seen about images like these. 00:05:56,520 --> 00:06:01,000
也许您也听说过或看到过这样的图像。
--These are images of faces generated by the StyleGAN system. 00:06:01,000 --> 00:06:05,800
这些是由 StyleGAN 系统生成的人脸图像。
--And I know we're all used to seeing these things now. 00:06:05,800 --> 00:06:08,320
我知道我们现在都已经习惯了看到这些东西。
--We're actually quite used to seeing faces that are not real. 00:06:08,320 --> 00:06:10,720
我们实际上已经习惯于看到不真实的面孔。
--We see them everywhere now. 00:06:10,720 --> 00:06:12,640
我们现在到处都能看到它们。
--But I remember when this post was first made on Twitter, people were advertising this paper 00:06:12,640 --> 00:06:18,440
但我记得当这篇文章第一次在 Twitter 上发布时，人们正在为这篇论文做广告
--on Twitter, and I thought people were joking. 00:06:18,440 --> 00:06:20,800
在推特上，我以为人们在开玩笑。
--I thought actually this was just a set of pictures from the training set that people 00:06:20,800 --> 00:06:25,120
我以为实际上这只是一组来自人们训练集的图片
--were joking about and saying they were generated by the GAN, by the adversarial network. 00:06:25,120 --> 00:06:31,120
我们开玩笑说它们是由对抗网络生成的 GAN。
--But no, they really were, right? 00:06:31,120 --> 00:06:32,440
但不，他们真的是，对吧？
--These are actually fake images generated by this network. 00:06:32,440 --> 00:06:35,520
这些实际上是该网络生成的假图像。
--And I think that we almost take it for granted now just how easy it is to generate pictures 00:06:35,800 --> 00:06:42,560
而且我认为我们现在几乎认为生成图片是多么容易是理所当然的
--of fake people, which was a capability we did not have four or five years ago. 00:06:42,560 --> 00:06:49,200
假人，这是我们四五年前没有的能力。
--A little bit more recent history now. 00:06:49,200 --> 00:06:51,560
现在有点最近的历史。
--You've likely heard about the GPT-3 system. 00:06:51,560 --> 00:06:54,480
您可能听说过 GPT-3 系统。
--This is a system built by OpenAI that can generate text. 00:06:54,480 --> 00:06:59,600
这是一个由 OpenAI 构建的可以生成文本的系统。
--And the way it generates text is essentially writes text one word or one token at a time. 00:06:59,600 --> 00:07:04,240
它生成文本的方式本质上是一次写入一个单词或一个标记。
--So given all the previous tokens in a sentence, it predicts the next one. 00:07:04,280 --> 00:07:09,000
因此，给定一个句子中所有先前的标记，它会预测下一个标记。
--And then it appends that to the text and predicts the next one. 00:07:09,000 --> 00:07:12,960
然后它将其附加到文本并预测下一个。
--And from this very simple-seeming process, we are nonetheless able to generate amazingly 00:07:12,960 --> 00:07:19,320
从这个看似非常简单的过程中，我们仍然能够产生惊人的
--complex and coherent pieces of text just from essentially a deep learning system that's 00:07:19,320 --> 00:07:25,040
本质上来自深度学习系统的复杂而连贯的文本片段
--meant to predict really a distribution over next possible tokens in text. 00:07:25,040 --> 00:07:32,000
意味着真正预测文本中下一个可能标记的分布。
--And in fact here, hopefully it's legible in the video here, but I actually asked GPT-3 00:07:32,000 --> 00:07:37,160
事实上在这里，希望它在视频中清晰可见，但我实际上问过 GPT-3
--to write a summary of this course. 00:07:37,160 --> 00:07:41,440
写本课程的总结。
--And it spit out a very reasonable summary of a deep learning course. 00:07:41,440 --> 00:07:46,080
并且吐出了一个非常合理的深度学习课程总结。
--In fact, it's actually a very bad summary of this course because it says we're going 00:07:46,080 --> 00:07:49,760
事实上，它实际上是对这门课程的一个非常糟糕的总结，因为它说我们要
--to talk about the theory and the math, and then we're going to cover unsupervised learning 00:07:49,760 --> 00:07:53,440
谈论理论和数学，然后我们将介绍无监督学习
--and reinforcement learning. 00:07:53,440 --> 00:07:54,560
和强化学习。
--But it would be a very good summary of a kind of generic deep learning course that is offered 00:07:54,560 --> 00:08:01,080
但这将是对所提供的一种通用深度学习课程的一个很好的总结
--in fact here and will be offered at many, many universities. 00:08:01,080 --> 00:08:06,680
事实上，很多很多大学都会提供这些课程。
--You've also probably seen AlphaFold and the AlphaFold2 system. 00:08:06,680 --> 00:08:09,880
您可能还见过 AlphaFold 和 AlphaFold2 系统。
--This is a system that predicts the 3D structure of proteins from their DNA sequence. 00:08:09,880 --> 00:08:18,880
这是一个根据蛋白质的 DNA 序列预测其 3D 结构的系统。
--This for a very, very long time has been a grand challenge in biology, understanding 00:08:18,880 --> 00:08:25,400
在非常非常长的时间里，这一直是生物学中的一个巨大挑战，理解
--how DNA sequences form the 3D structure of proteins that actually carry out tasks in 00:08:25,480 --> 00:08:31,800
DNA 序列如何形成实际执行任务的蛋白质的 3D 结构
--the body. 00:08:31,800 --> 00:08:33,400
身体。
--And for a very, very long time, this is a chart here of the progress and accuracy of 00:08:33,400 --> 00:08:39,200
在非常非常长的时间里，这是一张图表，显示了
--these systems over many years at sort of a well-known competition on this task of protein 00:08:39,200 --> 00:08:46,200
多年来，这些系统在蛋白质这项任务的知名竞赛中
--folding prediction. 00:08:46,200 --> 00:08:47,920
折叠预测。
--And over the course of four years, this system, AlphaFold, built by DeepMind, again was able 00:08:47,920 --> 00:08:54,920
在四年的时间里，这个由 DeepMind 构建的系统 AlphaFold 再次能够
--to really produce an amazing scientific breakthrough in the quality and accuracy of this prediction 00:08:55,200 --> 00:09:02,200
真正在预测的质量和准确性方面取得惊人的科学突破
--to the point where effectively, you could argue that at least in some restricted cases, 00:09:06,520 --> 00:09:11,160
到有效的地步，你可以争辩说至少在一些受限的情况下，
--this problem is in fact effectively solved. 00:09:11,160 --> 00:09:16,000
这个问题实际上得到了有效解决。
--And finally, it wouldn't be 2022 if I didn't include a picture of an image generated by 00:09:16,000 --> 00:09:23,000
最后，如果我不包括一张由
--a deep learning system. 00:09:24,000 --> 00:09:26,000
一个深度学习系统。
--This is a picture generated by the Stable Diffusion System, which actually was released 00:09:26,000 --> 00:09:33,000
这是稳定扩散系统生成的图片，实际发布的
--like a week and a half ago. 00:09:33,000 --> 00:09:34,000
就像一个半星期前。
--In fact, it was released on the same day we also posted the video announcing this public 00:09:34,000 --> 00:09:39,000
事实上，它是在同一天发布的，我们还发布了公开宣布的视频
--course. 00:09:39,000 --> 00:09:40,000
课程。
--So they really stole our thunder here. 00:09:40,000 --> 00:09:42,000
所以他们真的在这里抢了我们的风头。
--Of course, this also relates to the work done by the DALI2 system and going back for the 00:09:42,000 --> 00:09:47,000
当然，这也关系到DALI2系统所做的工作，回过头来
--DALI system and many papers before then. 00:09:47,000 --> 00:09:50,000
DALI系统和之前的很多论文。
--But these systems are amazing in that they can take a text prompt and generate that probably 00:09:51,000 --> 00:09:58,000
但是这些系统的惊人之处在于它们可以接受文本提示并生成可能
--no one has ever really thought of before and generate a very realistic painting in many 00:09:58,000 --> 00:10:03,000
以前没有人真正想到并在许多方面生成一幅非常逼真的画作
--cases or image in many cases that corresponds to that text. 00:10:03,000 --> 00:10:08,000
在许多情况下与该文本相对应的案例或图像。
--So here I wrote the text prompt of a dog dressed as a university professor nervously preparing 00:10:08,000 --> 00:10:15,000
所以我在这里写了一只打扮成大学教授的狗紧张准备的文字提示
--his first lecture of the semester 10 minutes before the start of class. 00:10:15,000 --> 00:10:19,000
他在上课前 10 分钟的学期第一堂课。
--I don't know why I would have thought of that thing. 00:10:19,000 --> 00:10:21,000
我不知道为什么我会想到那件事。
--You can imagine it yourself. 00:10:21,000 --> 00:10:23,000
你可以自己想象。
--And it was an oil painting on canvas. 00:10:23,000 --> 00:10:25,000
这是一幅布面油画。
--And you see what the system generated was, well, it looks like a dog dressed as a university 00:10:25,000 --> 00:10:30,000
你看系统生成的是什么，好吧，它看起来像一只打扮成大学的狗
--professor preparing a lecture. 00:10:30,000 --> 00:10:33,000
准备演讲的教授。
--I guess 10 minutes before class, that part maybe is evident in his expression. 00:10:33,000 --> 00:10:37,000
我想在上课前 10 分钟，那部分可能在他的表情中很明显。
--And it looks kind of like an oil painting. 00:10:37,000 --> 00:10:40,000
它看起来有点像油画。
--And this is just so amazing, the capabilities that we have in these systems. 00:10:40,000 --> 00:10:46,000
我们在这些系统中拥有的功能真是太神奇了。
--Now, one thing you may notice about all these examples I've given, except the very first 00:10:46,000 --> 00:10:51,000
现在，关于我给出的所有这些示例，您可能会注意到一件事，除了第一个
--one, is that they are all done essentially at companies, not actually the last one. 00:10:51,000 --> 00:10:56,000
一是它们基本上都是在公司完成的，实际上并不是最后一个。
--So stable diffusion actually is done at a relatively small company, but they still have 00:10:56,000 --> 00:10:59,000
所以稳定的传播实际上是在一家相对较小的公司完成的，但他们仍然有
--a fair amount of resources that were behind this effort. 00:10:59,000 --> 00:11:04,000
这项努力背后有相当多的资源。
--And the other point I want to make, though, is in case you're a little bit concerned saying, 00:11:04,000 --> 00:11:08,000
不过，我想说的另一点是，以防万一你有点担心说，
--oh, you know, all this stuff is just happening at big companies, what can one person or a 00:11:08,000 --> 00:11:13,000
哦，你知道，所有这些事情都发生在大公司，一个人或一个人能做什么
--small group of people really do to influence this? 00:11:13,000 --> 00:11:16,000
一小撮人真的能影响到这个吗？
--I would first of all point to that first paper and the stable diffusion paper actually as 00:11:16,000 --> 00:11:20,000
我首先要指出的是第一篇论文和稳定的扩散论文实际上是
--bookend examples of what a few people can do with the right methods and the right cleverness. 00:11:20,000 --> 00:11:25,000
一些人可以用正确的方法和正确的聪明才智做些什么的书挡例子。
--But I want to highlight a few examples, too, of smaller efforts that I think have still 00:11:25,000 --> 00:11:31,000
但我也想强调一些我认为仍然存在的较小努力的例子
--been amazingly impressive at shaping the field of deep learning. 00:11:31,000 --> 00:11:37,000
在塑造深度学习领域方面令人印象深刻。
--So the de-oldify work, essentially done by two people, is more or less, or was, I believe 00:11:37,000 --> 00:11:44,000
所以去旧化工作，基本上是由两个人完成的，或多或少，或者，我相信
--still is more or less, a state-of-the-art technique for taking old pictures, old photographs 00:11:44,000 --> 00:11:49,000
still 或多或少是一种拍摄老照片、老照片的最先进技术
--in black and white, and creating color versions of these. 00:11:49,000 --> 00:11:54,000
黑白，并创建这些的彩色版本。
--Now, image colorization has been researched as a topic for a long time, but this system 00:11:54,000 --> 00:11:59,000
现在，图像着色作为一个课题已经研究了很长时间，但是这个系统
--really is an effort of a few people that ultimately achieves, I think, the visually 00:11:59,000 --> 00:12:06,000
真的是少数人的努力最终实现了，我认为，视觉
--best version of this sort of task that I have seen from this, done essentially by two people 00:12:06,000 --> 00:12:12,000
我从中看到的此类任务的最佳版本，基本上由两个人完成
--with very limited resources, at least in the initial versions. 00:12:12,000 --> 00:12:16,000
资源非常有限，至少在初始版本中是这样。
--If you work in computer vision these days, you've probably heard of the PyTorch image 00:12:16,000 --> 00:12:21,000
如果你现在从事计算机视觉工作，你可能听说过 PyTorch 图像
--models or TIM library. 00:12:21,000 --> 00:12:24,000
模型或 TIM 库。
--This is essentially work by one person that wanted to implement a whole bunch of, with 00:12:24,000 --> 00:12:29,000
这基本上是一个人的工作，他想实现一大堆，
--some help now, but at least starting out one person, Ross Whiteman, who wanted to implement 00:12:29,000 --> 00:12:33,000
现在有些帮助，但至少开始一个人，罗斯怀特曼，他想实施
--a whole lot of deep learning image classification models from many, many papers and test them 00:12:33,000 --> 00:12:42,000
来自许多论文的大量深度学习图像分类模型并对其进行测试
--all out on benchmark data, and in many cases using pre-trained weights from those papers 00:12:42,000 --> 00:12:48,000
全部基于基准数据，并且在许多情况下使用这些论文中的预训练权重
--or in many cases training them from scratch. 00:12:48,000 --> 00:12:50,000
或者在许多情况下从头开始培训他们。
--And this has been, this started at least as a relatively small effort by one person 00:12:50,000 --> 00:12:56,000
这一直是，这至少是作为一个人相对较小的努力开始的
--and has become really the dominant image classification library that we all use academically when 00:12:56,000 --> 00:13:04,000
并且已经真正成为我们在学术上使用的主要图像分类库
--we are building these vision systems. 00:13:04,000 --> 00:13:09,000
我们正在构建这些视觉系统。
--And finally, I won't highlight these other ones, actually, because these in fact are 00:13:09,000 --> 00:13:13,000
最后，我不会强调这些其他的，实际上，因为这些实际上是
--community efforts, but there's been many other examples of libraries, systems, big, 00:13:13,000 --> 00:13:21,000
社区的努力，但还有许多其他图书馆、系统、大的例子，
--big sort of code endeavors that are essentially community driven and that they are both libraries 00:13:21,000 --> 00:13:27,000
本质上是由社区驱动的大型代码工作，它们都是库
--and frameworks that have been community driven that have really driven the field forward. 00:13:27,000 --> 00:13:31,000
以及真正推动该领域向前发展的社区驱动框架。
--And I'll actually mention some of these again when I introduce briefly my co-teacher in 00:13:31,000 --> 00:13:38,000
当我简要介绍我的合作老师时，我会再次提到其中的一些
--this course, Tianqi. 00:13:38,000 --> 00:13:42,000
这当然，田七。
--So all of this that I've talked about so far probably is not news to you. 00:13:42,000 --> 00:13:48,000
所以到目前为止我所谈论的所有这些对你来说可能不是新闻。
--If you're watching this, you probably say, yes, I get it. 00:13:48,000 --> 00:13:52,000
如果你正在看这个，你可能会说，是的，我明白了。
--Deep learning is great. 00:13:52,000 --> 00:13:53,000
深度学习很棒。
--That's why I'm taking this course. 00:13:53,000 --> 00:13:55,000
这就是我参加这门课程的原因。
--That's why I'm listening to this video so far, if you haven't skipped forward already. 00:13:55,000 --> 00:14:00,000
这就是为什么到目前为止我一直在听这个视频，如果你还没有跳过的话。
--But why should you learn about deep learning systems? 00:14:00,000 --> 00:14:04,000
但是为什么要学习深度学习系统呢？
--Why do you actually want to study deep learning systems? 00:14:04,000 --> 00:14:07,000
为什么你真的想研究深度学习系统？
--Not just deep learning, but the actual architectures behind and enable these systems. 00:14:07,000 --> 00:14:14,000
不仅仅是深度学习，还有背后的实际架构和启用这些系统。
--And the way I'm going to motivate this is I'm going to show a chart here of a Google 00:14:14,000 --> 00:14:23,000
我要推动这一点的方式是我要在这里展示一个谷歌的图表
--Trends chart of the interest measured somehow in deep learning, the term deep learning, 00:14:23,000 --> 00:14:30,000
在深度学习中以某种方式衡量的兴趣趋势图，术语深度学习，
--over the past 15 years or so, 14 years. 00:14:30,000 --> 00:14:36,000
在过去的15年左右，14年。
--And I'm going to annotate this chart with a few events of note. 00:14:36,000 --> 00:14:42,000
我将用一些值得注意的事件来注释这张图表。
--So in the late 2000s, this is actually when the field of deep learning, in some sense, 00:14:42,000 --> 00:14:51,000
所以在 2000 年代后期，这实际上是深度学习领域，从某种意义上说，
--took off academically. 00:14:51,000 --> 00:14:53,000
在学术上起飞。
--So I was going to conferences at this time, and I remember at conferences like NeurIPS, 00:14:53,000 --> 00:14:58,000
所以我当时正要去参加会议，我记得在像 NeurIPS 这样的会议上，
--this deep learning became a thing, a field where there was lots of papers in it every 00:14:59,000 --> 00:15:06,000
这个深度学习成为了一个东西，一个每个都有很多论文的领域
--year in the late 2000s. 00:15:06,000 --> 00:15:09,000
2000 年代后期的一年。
--But still, I mean, maybe this is always how academic work happens. 00:15:09,000 --> 00:15:13,000
但是，我的意思是，也许学术工作总是这样发生的。
--Still, there wasn't much, as measured by Google Trends relative to the current day, 00:15:13,000 --> 00:15:17,000
尽管如此，根据谷歌趋势相对于当天的衡量，并没有太多，
--there wasn't a whole lot of interest in deep learning. 00:15:17,000 --> 00:15:20,000
人们对深度学习没有太多兴趣。
--It was just sort of an academic trend like many others that you've probably not heard 00:15:20,000 --> 00:15:25,000
就像您可能没有听说过的许多其他学术趋势一样，这只是一种学术趋势
--of because they were 15 years old, and no one's using them anymore. 00:15:25,000 --> 00:15:31,000
因为它们已经 15 岁了，没有人再使用它们了。
--Then in 2012, as I mentioned, the AlexNet network was released, which, again, this is 00:15:31,000 --> 00:15:39,000
然后在 2012 年，正如我提到的，AlexNet 网络发布了，这又是
--not a history of the field of deep learning. 00:15:39,000 --> 00:15:42,000
不是深度学习领域的历史。
--And I, of course, should also mention, I mean, though I should, of course, mention that the 00:15:42,000 --> 00:15:47,000
当然，我还应该提到，我的意思是，虽然我当然应该提到
--actual mathematics of deep learning and neural networks goes back well into the 80s, and 00:15:47,000 --> 00:15:53,000
深度学习和神经网络的实际数学可以追溯到 80 年代，并且
--probably before then to the 70s. 00:15:53,000 --> 00:15:56,000
可能在那之前到 70 年代。
--This is just a sort of recent history, of course. 00:15:56,000 --> 00:15:59,000
当然，这只是一种最近的历史。
--And again, I'm only annotating a few events, not trying to make claims about who was first 00:15:59,000 --> 00:16:04,000
再一次，我只是在注释一些事件，而不是试图宣称谁是第一个
--to do what, et cetera. 00:16:04,000 --> 00:16:05,000
做什么，等等。
--It's a game I don't want to play in. 00:16:05,000 --> 00:16:08,000
这是一个我不想玩的游戏。
--But the AlexNet was a very popular architecture, yet still, had a little, sort of a little 00:16:08,000 --> 00:16:13,000
但是 AlexNet 是一个非常流行的架构，但仍然有一点，有点
--bit of uptick in interest in deep learning. 00:16:13,000 --> 00:16:16,000
对深度学习的兴趣有所上升。
--And, you know, not, but still not too much happened. 00:16:16,000 --> 00:16:20,000
而且，你知道，没有，但仍然没有发生太多事情。
--You know, state-of-the-art performance on image classification, and still not too much 00:16:20,000 --> 00:16:24,000
你知道，在图像分类方面的最先进性能，而且还不算太多
--happened. 00:16:24,000 --> 00:16:26,000
发生了。
--So then what happened? 00:16:26,000 --> 00:16:29,000
那么后来发生了什么？
--When did this start to really take off? 00:16:29,000 --> 00:16:31,000
这什么时候开始真正起飞的？
--Well, a few other things happened in the later years. 00:16:31,000 --> 00:16:34,000
好吧，在后来的几年里发生了一些其他的事情。
--So in 2015 and 2016, some libraries like Keras and TensorFlow and PyTorch were released. 00:16:34,000 --> 00:16:44,000
所以在 2015 年和 2016 年，发布了一些库，如 Keras 和 TensorFlow 以及 PyTorch。
--And if you actually look at the timing of when deep learning became truly popular, it 00:16:44,000 --> 00:16:50,000
如果你真的看看深度学习真正流行的时间，它
--coincides much more with the release of these libraries than the actual sort of what we 00:16:50,000 --> 00:16:57,000
与这些库的发布相吻合，而不是我们实际使用的那种
--think of as some of the big notable papers or events in the field. 00:16:57,000 --> 00:17:03,000
将其视为该领域的一些重要论文或事件。
--And so I kind of want to make the controversial, but maybe not that controversial claim, that 00:17:03,000 --> 00:17:08,000
所以我有点想提出有争议的，但也许不是那个有争议的说法，即
--the single largest driver of the widespread adoption of deep learning has been the creation 00:17:08,000 --> 00:17:16,000
广泛采用深度学习的最大推动力是创造
--of what essentially amounts to easy-to-use automatic differentiation libraries. 00:17:16,000 --> 00:17:22,000
本质上相当于易于使用的自动微分库。
--That's a little bit too simplified, of course. 00:17:22,000 --> 00:17:25,000
当然，这有点过于简化了。
--The actual deep learning systems, which we're going to talk about in this course, involve 00:17:25,000 --> 00:17:29,000
我们将在本课程中讨论的实际深度学习系统涉及
--much more than automatic differentiation. 00:17:29,000 --> 00:17:31,000
远远超过自动微分。
--But this core technology, which again goes back to the 70s, not a new technology, but 00:17:31,000 --> 00:17:38,000
但这项核心技术，再次追溯到 70 年代，不是一项新技术，而是
--the widespread availability. 00:17:38,000 --> 00:17:39,000
广泛的可用性。
--And there were frameworks before that. 00:17:39,000 --> 00:17:41,000
在此之前有框架。
--So before PyTorch, there was Torch, just not many people used it because you had to learn 00:17:41,000 --> 00:17:45,000
所以在 PyTorch 之前，有 Torch，只是没有多少人使用它，因为你必须学习
--a whole new language called Lua to implement your models there. 00:17:45,000 --> 00:17:49,000
一种名为 Lua 的全新语言可以在那里实现您的模型。
--So the availability of Python-based frameworks that let you quickly prototype new 00:17:49,000 --> 00:17:57,000
因此，基于 Python 的框架的可用性可以让您快速制作新的原型
--architectures, new models. 00:17:57,000 --> 00:17:59,000
架构，新模型。
--This, I think, was the single biggest driver of the explosion of interest in deep learning. 00:17:59,000 --> 00:18:09,000
我认为，这是深度学习兴趣激增的最大驱动力。
--Now one thing you may also see from this chart is maybe we're in bad territory recently, 00:18:09,000 --> 00:18:14,000
现在您还可以从这张图表中看到一件事，也许我们最近处在糟糕的境地，
--maybe something's happening recently. 00:18:14,000 --> 00:18:15,000
也许最近发生了什么事。
--I don't think it is. 00:18:15,000 --> 00:18:16,000
我不认为是。
--I think there's often issues with the latest data in Google Trends. 00:18:16,000 --> 00:18:22,000
我认为 Google 趋势中的最新数据经常存在问题。
--But more than that, I think probably what's also happening is that a lot of these things 00:18:22,000 --> 00:18:26,000
但更重要的是，我认为可能还会发生的事情是很多这样的事情
--are just now falling under the umbrella of AI, which I will try to avoid that term. 00:18:26,000 --> 00:18:30,000
刚刚落入 AI 的保护伞下，我将尽量避免使用该术语。
--I'll try to be specific about deep learning as much as possible. 00:18:30,000 --> 00:18:33,000
我将尽可能具体地介绍深度学习。
--But probably a lot of what's happening is people are just using the term AI to talk 00:18:33,000 --> 00:18:36,000
但可能很多正在发生的事情是人们只是用人工智能这个词来说话
--about a lot of these things and not the term deep learning always. 00:18:36,000 --> 00:18:40,000
关于很多这些事情，而不是深度学习这个术语。
--So another way of sort of emphasizing this exact same point, I'm actually going to 00:18:40,000 --> 00:18:45,000
所以用另一种方式来强调这个完全相同的观点，我实际上要
--reference a story from Tianqi's work. 00:18:45,000 --> 00:18:49,000
引用田七作品中的一个故事。
--And he, I actually was quite, I admit, I was quite late to the game when it came to deep 00:18:49,000 --> 00:18:54,000
而他，我承认，我真的很晚才开始玩游戏
--learning. 00:18:54,000 --> 00:18:55,000
学习。
--Despite being around people that were using it, some of the pioneers in the field, I actually 00:18:55,000 --> 00:18:59,000
尽管周围的人都在使用它，但实际上我是该领域的一些先驱
--didn't start working in deep learning until about 2015. 00:18:59,000 --> 00:19:02,000
直到 2015 年左右才开始从事深度学习方面的工作。
--Maybe, you know, maybe not surprisingly, about when I could easily prototype stuff. 00:19:02,000 --> 00:19:08,000
也许，你知道，也许并不奇怪，关于什么时候我可以轻松地制作原型。
--But Tianqi, he was actually working on deep learning back in the day, back in 2012 when 00:19:08,000 --> 00:19:16,000
但是田七，他其实是在做深度学习的，早在2012年的时候
--a lot of these were first being developed. 00:19:16,000 --> 00:19:18,000
其中很多都是首先开发的。
--And in fact, one of his first projects as a PhD student was to write code for ConvNets 00:19:19,000 --> 00:19:26,000
事实上，他作为博士生的第一个项目是为 ConvNets 编写代码
--that would accelerate their development on GPUs. 00:19:26,000 --> 00:19:29,000
这将加速他们在 GPU 上的开发。
--This is around the same time that AlexNet and such was being developed. 00:19:29,000 --> 00:19:33,000
这与 AlexNet 等的开发时间大致相同。
--And so he was doing similar things at the time. 00:19:33,000 --> 00:19:37,000
所以他当时也在做类似的事情。
--And the figures he gives is that to implement really a capable convolutional architecture 00:19:37,000 --> 00:19:46,000
他给出的数字是真正实现一个有能力的卷积架构
--for image classification on a dataset like ImageNet at the time. 00:19:46,000 --> 00:19:51,000
当时用于像 ImageNet 这样的数据集上的图像分类。
--It took him about 44,000 lines of code and about six months of coding to do so. 00:19:51,000 --> 00:19:57,000
这样做他花了大约 44,000 行代码和大约六个月的编码时间。
--And I'll make this point later, but Tianqi's a really good coder. 00:19:57,000 --> 00:20:02,000
我稍后会提出这一点，但田七是一个非常好的编码员。
--And it still took him this long to write a working deep learning architecture. 00:20:02,000 --> 00:20:08,000
他仍然花了这么长时间来编写一个有效的深度学习架构。
--Contrast that with today. 00:20:10,000 --> 00:20:12,000
对比一下今天。
--Today, if you wanted to do the same thing, you would probably have to write 00:20:12,000 --> 00:20:16,000
今天，如果你想做同样的事情，你可能不得不写
--about 100 lines of code, and you could probably do it in a few hours. 00:20:16,000 --> 00:20:21,000
大约 100 行代码，您可能会在几个小时内完成。
--And the reason why is because of deep learning systems like PyTorch, 00:20:21,000 --> 00:20:27,000
原因是因为像 PyTorch 这样的深度学习系统，
--like TensorFlow, and now like JAX. 00:20:27,000 --> 00:20:30,000
像 TensorFlow，现在像 JAX。
--And I think we often don't fully appreciate just how much of an enabling factor it is 00:20:32,000 --> 00:20:40,000
而且我认为我们常常没有完全意识到它是一个多大的促成因素
--to be able to iterate this quickly. 00:20:40,000 --> 00:20:42,000
能够快速迭代。
--We think of deep learning models as being slow to train and slow to develop, 00:20:42,000 --> 00:20:46,000
我们认为深度学习模型训练缓慢，开发缓慢，
--especially large ones, but this is amazingly fast. 00:20:46,000 --> 00:20:51,000
特别是大的，但这速度快得惊人。
--We have an amazingly fast current iteration time enabled by these deep learning systems. 00:20:51,000 --> 00:20:58,000
这些深度学习系统使我们的当前迭代时间快得惊人。
--But this still doesn't answer the question that I set out to answer, 00:21:01,000 --> 00:21:05,000
但这仍然没有回答我打算回答的问题，
--which is why should you take this course? 00:21:05,000 --> 00:21:08,000
这就是为什么你应该参加这门课程？
--So maybe you agree now that deep learning systems are great. 00:21:08,000 --> 00:21:11,000
所以也许你现在同意深度学习系统很棒。
--Why don't you just use them, right? 00:21:11,000 --> 00:21:13,000
你为什么不直接使用它们，对吧？
--You can just use, I'm sure you already do, right? 00:21:13,000 --> 00:21:15,000
你可以直接使用，我相信你已经这样做了，对吧？
--You probably use PyTorch and TensorFlow and JAX. 00:21:15,000 --> 00:21:18,000
您可能使用 PyTorch、TensorFlow 和 JAX。
--Why should you take a course about how these systems actually work? 00:21:19,000 --> 00:21:25,000
为什么要学习有关这些系统实际工作原理的课程？
--And there I actually think there are three reasons I'm going to give 00:21:26,000 --> 00:21:31,000
我实际上认为我要给出三个理由
--for why this course might be right for you to take 00:21:31,000 --> 00:21:37,000
为什么这门课程适合你
--if you're interested in deep learning. 00:21:37,000 --> 00:21:39,000
如果你对深度学习感兴趣。
--The first reason, of course, is maybe obviously, 00:21:40,000 --> 00:21:44,000
当然，第一个原因可能很明显，
--if you want to build deep learning systems, you better understand them. 00:21:44,000 --> 00:21:49,000
如果你想构建深度学习系统，你最好理解它们。
--So despite the current state of deep learning libraries, 00:21:51,000 --> 00:21:56,000
所以尽管深度学习库的现状，
--where you may say that, okay, libraries like TensorFlow and PyTorch 00:21:56,000 --> 00:21:59,000
你可能会说，好的，像 TensorFlow 和 PyTorch 这样的库
--are kind of one, they're the standards everyone uses, 00:21:59,000 --> 00:22:01,000
是一种，它们是每个人都使用的标准，
--it's actually not really true. 00:22:01,000 --> 00:22:04,000
这实际上不是真的。
--I think actually the field of deep learning systems is remarkably fluid 00:22:04,000 --> 00:22:09,000
我认为实际上深度学习系统领域非常不稳定
--as evidenced by the relatively recent emergence of JAX 00:22:09,000 --> 00:22:14,000
正如最近出现的 JAX 所证明的那样
--as a dominant framework for a lot of research in deep learning. 00:22:14,000 --> 00:22:19,000
作为许多深度学习研究的主导框架。
--It's a relatively new thing. 00:22:19,000 --> 00:22:20,000
这是一个相对较新的事物。
--This has happened in the last couple of years. 00:22:20,000 --> 00:22:22,000
这是最近几年发生的事情。
--But I don't think we're done yet in some way. 00:22:23,000 --> 00:22:27,000
但我认为我们在某种程度上还没有完成。
--I think there's actually a lot of work to be done in developing new systems, 00:22:27,000 --> 00:22:30,000
我认为在开发新系统方面实际上有很多工作要做，
--maybe more specialized systems, 00:22:30,000 --> 00:22:31,000
也许更专业的系统，
--maybe systems that specialize in some different area 00:22:31,000 --> 00:22:34,000
也许专门从事某些不同领域的系统
--or different paradigm for deep learning. 00:22:34,000 --> 00:22:37,000
或深度学习的不同范式。
--But I don't think we're finished with what the final state 00:22:37,000 --> 00:22:40,000
但我不认为我们已经完成了最终状态
--of deep learning systems is going to look like. 00:22:40,000 --> 00:22:42,000
深度学习系统将看起来像。
--And if you want to develop your own frameworks 00:22:42,000 --> 00:22:45,000
如果你想开发自己的框架
--or build upon existing frameworks, 00:22:45,000 --> 00:22:49,000
或建立在现有框架之上，
--and by the way, all the frameworks out there essentially are open source, 00:22:49,000 --> 00:22:52,000
顺便说一下，所有的框架基本上都是开源的，
--so you could definitely just download the source currently 00:22:52,000 --> 00:22:57,000
所以你绝对可以只下载当前的源代码
--and start contributing to it if you understand them. 00:22:57,000 --> 00:22:59,000
如果你理解它们，就开始为它做贡献。
--If you want to do all that, 00:22:59,000 --> 00:23:01,000
如果你想做这一切，
--then this course and some practice will prepare you to do this. 00:23:01,000 --> 00:23:06,000
那么本课程和一些练习将使您做好准备。
--This is maybe the most obvious reason why you might want to take this course 00:23:06,000 --> 00:23:10,000
这可能是您想要参加本课程的最明显原因
--if you want to build and contribute to these libraries as well. 00:23:10,000 --> 00:23:14,000
如果你也想构建这些库并为之做出贡献。
--But that's not the only reason. 00:23:16,000 --> 00:23:19,000
但这不是唯一的原因。
--And the second reason for taking this course is actually the one 00:23:19,000 --> 00:23:22,000
参加这门课程的第二个原因实际上是
--that I would emphasize most heavily for practitioners in the field. 00:23:22,000 --> 00:23:27,000
我最想强调的是该领域的从业者。
--And that reason is understanding how the internals 00:23:28,000 --> 00:23:35,000
而这个原因是了解内部结构
--of deep learning systems work lets you use them more efficiently 00:23:35,000 --> 00:23:41,000
深度学习系统的工作让您更有效地使用它们
--and more effectively. 00:23:41,000 --> 00:23:43,000
更有效。
--And I really do mean that, right? 00:23:43,000 --> 00:23:46,000
我真的是这个意思，对吧？
--So if you want to build scalable models, efficient models, 00:23:46,000 --> 00:23:50,000
所以如果你想建立可扩展的模型，高效的模型，
--models that will execute quickly or that make full utilization of a GPU, 00:23:50,000 --> 00:23:56,000
将快速执行或充分利用 GPU 的模型，
--you really do want to understand how these systems are working 00:23:56,000 --> 00:24:02,000
你真的很想了解这些系统是如何工作的
--underneath the hood. 00:24:02,000 --> 00:24:03,000
在引擎盖下面。
--What is really being executed? 00:24:03,000 --> 00:24:04,000
真正被执行的是什么？
--How are they translating your high-level description 00:24:04,000 --> 00:24:07,000
他们如何翻译您的高级描述
--of a network architecture to something that really executes on hardware 00:24:07,000 --> 00:24:13,000
网络架构到真正在硬件上执行的东西
--and then trains and differentiates that system 00:24:13,000 --> 00:24:19,000
然后训练和区分该系统
--and adjust parameters and all that? 00:24:19,000 --> 00:24:22,000
并调整参数等等？
--How does that work? 00:24:22,000 --> 00:24:23,000
这是如何运作的？
--And understanding how that works will actually enable you 00:24:24,000 --> 00:24:27,000
了解它是如何工作的实际上会让你
--to write more efficient and more effective code. 00:24:27,000 --> 00:24:31,000
编写更高效和更有效的代码。
--And this is especially true if you're doing research in deep learning. 00:24:31,000 --> 00:24:34,000
如果您正在研究深度学习，则尤其如此。
--So especially if you are doing things like developing new kinds of layers, 00:24:34,000 --> 00:24:38,000
所以特别是如果你正在做一些事情，比如开发新的图层，
--new architectures, new structures in deep learning, 00:24:38,000 --> 00:24:41,000
新架构，深度学习的新结构，
--this will be vastly improved if you understand the logic 00:24:41,000 --> 00:24:47,000
如果您理解逻辑，这将得到极大改善
--and the mechanisms behind these systems. 00:24:47,000 --> 00:24:50,000
以及这些系统背后的机制。
--I've always kind of referred to understanding deep learning systems 00:24:50,000 --> 00:24:53,000
我总是提到理解深度学习系统
--as a kind of superpower that can let you accomplish your research aims 00:24:53,000 --> 00:24:57,000
作为一种可以让你完成研究目标的超能力
--even if your research aims are not about system building, 00:24:57,000 --> 00:25:01,000
即使你的研究目标不是关于系统构建，
--can enable you to accomplish them much more efficiently. 00:25:01,000 --> 00:25:05,000
可以使您更有效地完成它们。
--This is probably the main reason why most of you, I think, 00:25:05,000 --> 00:25:12,000
这可能是你们大多数人的主要原因，我想，
--can and should take this course. 00:25:12,000 --> 00:25:14,000
可以而且应该参加这门课程。
--But I would be remiss if I didn't add one more reason to this pile, 00:25:15,000 --> 00:25:20,000
但是，如果我不在这一堆中再添加一个理由，那我就是失职了，
--which is that deep learning systems are really, really cool. 00:25:20,000 --> 00:25:25,000
这就是深度学习系统真的非常酷。
--And the reason why these systems are so much fun is actually very simple. 00:25:25,000 --> 00:25:32,000
这些系统如此有趣的原因其实很简单。
--And that is that despite the seeming complexity of these things, 00:25:32,000 --> 00:25:39,000
那就是尽管这些事情看起来很复杂，
--PyTorch and TensorFlow at this point are millions of lines of code. 00:25:39,000 --> 00:25:43,000
此时的 PyTorch 和 TensorFlow 是数百万行代码。
--But despite the seeming complexity of these libraries, 00:25:43,000 --> 00:25:48,000
但是尽管这些库看起来很复杂，
--the core underlying algorithms behind deep learning systems, 00:25:48,000 --> 00:25:53,000
深度学习系统背后的核心底层算法，
--behind quite capable deep learning systems, to be honest, 00:25:53,000 --> 00:25:57,000
在功能强大的深度学习系统背后，老实说，
--are extremely, extremely simple. 00:25:57,000 --> 00:26:01,000
非常非常简单。
--Really, the core algorithms behind every single deep learning architecture, 00:26:02,000 --> 00:26:09,000
真的，每个深度学习架构背后的核心算法，
--all those advances in machine learning models that you saw 00:26:09,000 --> 00:26:14,000
您看到的机器学习模型的所有这些进步
--that I put up on the previous screens, at least algorithmically, 00:26:14,000 --> 00:26:18,000
我放在前面的屏幕上，至少在算法上，
--they're all essentially based upon automatic differentiation 00:26:18,000 --> 00:26:22,000
它们本质上都是基于自动微分
--and gradient-based optimization, at least from a mathematical standpoint. 00:26:22,000 --> 00:26:26,000
和基于梯度的优化，至少从数学的角度来看是这样。
--Those are the two or handful of algorithms that actually underlie all of this. 00:26:26,000 --> 00:26:31,000
这些是实际上构成所有这些的两个或少数算法。
--And then on the implementation side, 00:26:31,000 --> 00:26:35,000
然后在实施方面，
--essentially they are built upon efficient linear algebra, 00:26:35,000 --> 00:26:41,000
本质上，它们建立在高效的线性代数之上，
--especially efficient matrix multiplies on GPU systems. 00:26:41,000 --> 00:26:46,000
在 GPU 系统上特别有效的矩阵乘法。
--Unlike, say, an operating system, 00:26:48,000 --> 00:26:51,000
与操作系统不同的是，
--where if you want to build an operating system, 00:26:51,000 --> 00:26:53,000
如果你想构建一个操作系统，
--you really have to build quite a bit of code. 00:26:53,000 --> 00:26:55,000
你真的必须构建相当多的代码。
--You have to write a lot of code. 00:26:55,000 --> 00:26:57,000
你必须写很多代码。
--And so courses on operating systems that take you through operating systems 00:26:59,000 --> 00:27:02,000
以及带您了解操作系统的操作系统课程
--usually build a very, very basic one. 00:27:02,000 --> 00:27:04,000
通常构建一个非常非常基础的。
--And you have to write, even for that, 00:27:04,000 --> 00:27:07,000
你必须写，即使是这样，
--you have to write a lot of code to do anything at all reasonable. 00:27:07,000 --> 00:27:10,000
您必须编写大量代码才能做任何合理的事情。
--But you actually can write, and you will write, 00:27:10,000 --> 00:27:13,000
但你真的可以写，而且你会写，
--a reasonable deep learning library. 00:27:13,000 --> 00:27:15,000
一个合理的深度学习库。
--If you want to be really compact with your code, 00:27:15,000 --> 00:27:17,000
如果你想让你的代码非常紧凑，
--you could probably do it in less than 2,000 lines of code. 00:27:17,000 --> 00:27:20,000
您可能只需不到 2,000 行代码即可完成。
--Something that will run on a GPU, 00:27:20,000 --> 00:27:23,000
将在 GPU 上运行的东西，
--that will do automatic differentiation, 00:27:23,000 --> 00:27:25,000
这将进行自动微分，
--that will have operations like convolutions 00:27:25,000 --> 00:27:27,000
会有像卷积这样的操作
--and convolutional networks, recurrent networks, 00:27:27,000 --> 00:27:29,000
和卷积网络，循环网络，
--transformers, all this kind of thing, right? 00:27:29,000 --> 00:27:31,000
变形金刚，所有这些东西，对吧？
--You can do it in almost no code 00:27:31,000 --> 00:27:33,000
您几乎无需代码即可完成
--because the actual ideas underlying these systems are simple. 00:27:33,000 --> 00:27:38,000
因为这些系统背后的实际想法很简单。
--And they're also, and I say this, you know, 00:27:40,000 --> 00:27:44,000
他们也是，我这么说，你知道的，
--a little bit tongue-in-cheek, 00:27:44,000 --> 00:27:46,000
有点开玩笑，
--but they're also kind of magical. 00:27:46,000 --> 00:27:48,000
但它们也有点神奇。
--Before I worked in deep learning, 00:27:49,000 --> 00:27:53,000
在从事深度学习工作之前，
--I sort of was brought up in traditional machine learning 00:27:53,000 --> 00:27:56,000
我是在传统机器学习中长大的
--when we derived all our gradients by hand. 00:27:56,000 --> 00:27:59,000
当我们手动导出所有梯度时。
--And that was the big effort you went through 00:27:59,000 --> 00:28:01,000
那是你付出的巨大努力
--when you derived some new model 00:28:01,000 --> 00:28:03,000
当你推导出一些新模型时
--as you wrote out a bunch of gradients by hand. 00:28:03,000 --> 00:28:05,000
因为你手写了一堆渐变。
--I remember the first time I built an automatic differentiation library 00:28:05,000 --> 00:28:10,000
记得第一次建自动微分库的时候
--and I realized that I could take, form some complex expression, 00:28:10,000 --> 00:28:15,000
我意识到我可以采取，形成一些复杂的表达，
--take its gradient, 00:28:16,000 --> 00:28:18,000
取它的梯度，
--and then form an even more complex expression of its gradient 00:28:18,000 --> 00:28:24,000
然后形成更复杂的梯度表达式
--and differentiate through that thing. 00:28:24,000 --> 00:28:27,000
并通过那件事来区分。
--And do all that despite the fact 00:28:27,000 --> 00:28:29,000
并且不顾事实去做这一切
--that I actually would really struggle to even derive that by hand. 00:28:29,000 --> 00:28:34,000
我实际上什至很难用手推导出它。
--I mean, I probably could do it, 00:28:34,000 --> 00:28:36,000
我的意思是，我可能可以做到，
--but it would take me quite a while to derive this manually. 00:28:36,000 --> 00:28:39,000
但是我需要很长时间才能手动推导它。
--Yet, I could write some code that did it. 00:28:39,000 --> 00:28:42,000
然而，我可以编写一些代码来完成它。
--This is really, really cool. 00:28:43,000 --> 00:28:46,000
这真的非常酷。
--And it's experience I think everyone working in deep learning should have. 00:28:46,000 --> 00:28:50,000
这是我认为每个从事深度学习工作的人都应该有的经验。
--All right. 00:28:52,000 --> 00:28:53,000
好的。
--So with all that being said, 00:28:53,000 --> 00:28:55,000
综上所述，
--let me give a little bit more now boring information 00:28:55,000 --> 00:28:59,000
现在让我多说一点无聊的信息
--about this course and the logistics of this course. 00:28:59,000 --> 00:29:03,000
关于这门课程和这门课程的后勤工作。
--First up, to introduce myself and my co-instructor Tianqi. 00:29:04,000 --> 00:29:12,000
首先，介绍一下我自己和我的搭档田七。
--I am a faculty member at Carnegie Mellon. 00:29:12,000 --> 00:29:17,000
我是卡内基梅隆大学的教员。
--I've been there since 2012. 00:29:17,000 --> 00:29:19,000
我自 2012 年以来一直在那里。
--But in addition to working in industry or at CMU, 00:29:19,000 --> 00:29:24,000
但除了在工业界或 CMU 工作之外，
--I've also done a fair amount of work in industry. 00:29:24,000 --> 00:29:26,000
我还在工业界做了很多工作。
--So I was previously at a company called C3AI. 00:29:26,000 --> 00:29:29,000
所以我之前在一家叫做 C3AI 的公司工作。
--Now I work, I'm a chief scientist in AI research at Bosch. 00:29:29,000 --> 00:29:32,000
现在我工作，我是博世人工智能研究的首席科学家。
--And the Bosch Center for AI. 00:29:33,000 --> 00:29:35,000
还有博世人工智能中心。
--And my research in academics focuses on a lot of techniques 00:29:35,000 --> 00:29:44,000
我在学术上的研究集中在很多技术上
--for new algorithms and new methods now in deep learning. 00:29:44,000 --> 00:29:48,000
用于深度学习中的新算法和新方法。
--So I've done a lot of work on adversarial robustness. 00:29:48,000 --> 00:29:52,000
所以我在对抗鲁棒性方面做了很多工作。
--I've done a lot of work, especially certified and provable defenses 00:29:52,000 --> 00:29:57,000
我做了很多工作，尤其是经过认证和可证明的防御
--against adversarial attacks. 00:29:57,000 --> 00:29:59,000
对抗敌对攻击。
--I've also done a lot of work in what we call implicit layers. 00:29:59,000 --> 00:30:02,000
我还在我们所谓的隐式层中做了很多工作。
--These are layers that instead of just being formed 00:30:02,000 --> 00:30:06,000
这些层不只是形成
--by some sort of stacking of traditional operations, 00:30:06,000 --> 00:30:09,000
通过某种传统操作的堆叠，
--you form them by actually solving a more complex operator 00:30:09,000 --> 00:30:14,000
你通过实际解决一个更复杂的运算符来形成它们
--like an optimization problem or like a fixed point equation. 00:30:14,000 --> 00:30:18,000
就像优化问题或不动点方程一样。
--And you actually differentiate those analytically. 00:30:18,000 --> 00:30:21,000
你实际上在分析上区分了那些。
--In fact, we'll, according to the current schedule at least, 00:30:21,000 --> 00:30:24,000
事实上，至少根据目前的时间表，我们会，
--if there is time, we will have a lecture on implicit layers 00:30:24,000 --> 00:30:26,000
如果有时间，我们将有一个关于隐层的讲座
--at the very end of this course. 00:30:26,000 --> 00:30:28,000
在本课程的最后。
--Implemented, of course, in our own framework. 00:30:28,000 --> 00:30:31,000
当然，在我们自己的框架中实现。
--I was also an early PyTorch adopter. 00:30:31,000 --> 00:30:34,000
我也是 PyTorch 的早期采用者。
--And one of my marks of pride, I don't, I'm going to quickly 00:30:34,000 --> 00:30:39,000
我骄傲的标志之一，我不，我会很快
--sort of not hold a candle to the systems work Tianqi has done 00:30:39,000 --> 00:30:45,000
有点看不起天齐所做的系统工作
--that I'm about to show in a second. 00:30:45,000 --> 00:30:47,000
我将在一秒钟内展示。
--But myself and my group, we were early PyTorch adopters. 00:30:47,000 --> 00:30:49,000
但是我和我的团队，我们是 PyTorch 的早期采用者。
--We were actually mentioned as the first group releasing 00:30:49,000 --> 00:30:54,000
我们实际上被提到是第一批发布的
--third-party libraries for PyTorch. 00:30:54,000 --> 00:30:57,000
PyTorch 的第三方库。
--And one of my claims to fame there is that as part of our efforts 00:30:57,000 --> 00:31:02,000
我声名鹊起的原因之一是，作为我们努力的一部分
--to release an optimization layer, so this was a layer, 00:31:02,000 --> 00:31:05,000
释放一个优化层，所以这是一个层，
--a third-party library that would solve optimization problems 00:31:05,000 --> 00:31:10,000
可以解决优化问题的第三方库
--as a layer in a deep network, like quadratic programs, 00:31:10,000 --> 00:31:14,000
作为深度网络中的一层，如二次程序，
--if you know what those are. 00:31:14,000 --> 00:31:16,000
如果你知道那些是什么。
--And to do so, I wrote a CUDA kernel as part of PyTorch 00:31:17,000 --> 00:31:24,000
为此，我编写了一个 CUDA 内核作为 PyTorch 的一部分
--that could do batch parallel solving of multiple linear systems 00:31:24,000 --> 00:31:28,000
可以对多个线性系统进行批量并行求解
--as part of our, as one step of our optimization solver. 00:31:28,000 --> 00:31:32,000
作为我们的一部分，作为我们优化求解器的一个步骤。
--And the real claim to fame there, of course, is that in doing so, 00:31:32,000 --> 00:31:37,000
当然，真正声名鹊起的是这样做的时候，
--I messed up, or rather I didn't, I wouldn't standardize somehow 00:31:37,000 --> 00:31:41,000
我搞砸了，或者更确切地说我没有，我不会以某种方式标准化
--the matrix striding that PyTorch assumes coming out of its CUDA kernels. 00:31:41,000 --> 00:31:47,000
PyTorch 假设来自其 CUDA 内核的矩阵步幅。
--And I introduced a bug in PyTorch's linear solver 00:31:47,000 --> 00:31:52,000
我在 PyTorch 的线性求解器中引入了一个错误
--that I think persisted for like a year after that. 00:31:52,000 --> 00:31:55,000
我认为在那之后持续了大约一年。
--Everyone was so confused about why this linear solver 00:31:55,000 --> 00:31:57,000
每个人都很困惑为什么这个线性求解器
--would just randomly crash at times. 00:31:57,000 --> 00:31:59,000
有时会随机崩溃。
--So that's my claim to fame, I guess, sadly, about deep learning systems. 00:31:59,000 --> 00:32:03,000
所以这就是我声名鹊起的原因，我想，遗憾的是，关于深度学习系统。
--Now, the other instructor is a bit different. 00:32:03,000 --> 00:32:07,000
现在，另一位导师有点不同。
--So Tianqi Chen is also a faculty member at CMU, 00:32:07,000 --> 00:32:12,000
所以陈天琪也是CMU的教员，
--and also, in addition to this, has a foot in industry. 00:32:12,000 --> 00:32:15,000
此外，除此之外，它还涉足行业。
--So he was the co-founder of the OctoML company, 00:32:15,000 --> 00:32:19,000
所以他是OctoML公司的联合创始人，
--which is a company that does a lot of support and development 00:32:19,000 --> 00:32:21,000
这是一家提供大量支持和开发的公司
--for the TVM library. 00:32:21,000 --> 00:32:23,000
对于 TVM 库。
--But the real claim to fame is the following. 00:32:23,000 --> 00:32:26,000
但真正声名鹊起的是以下内容。
--I'm giving this lecture so I can suitably embarrass Tianqi 00:32:28,000 --> 00:32:31,000
我讲课是为了给田七适当的丢脸
--a little bit in our introduction here. 00:32:31,000 --> 00:32:34,000
在我们这里的介绍中有一点。
--For a long time, the standard story I will give about him 00:32:34,000 --> 00:32:39,000
很长一段时间，我会给出关于他的标准故事
--is that in deep learning systems or machine learning systems as a whole, 00:32:39,000 --> 00:32:43,000
是在深度学习系统或整个机器学习系统中，
--there really are three big players in this field. 00:32:43,000 --> 00:32:46,000
这个领域真的有三个大玩家。
--There is Google, of course, releasing TensorFlow, JAX, 00:32:46,000 --> 00:32:50,000
当然还有 Google，发布了 TensorFlow、JAX，
--and many other libraries. 00:32:50,000 --> 00:32:51,000
和许多其他图书馆。
--There's Facebook, of course, from PyTorch, 00:32:51,000 --> 00:32:53,000
当然还有来自 PyTorch 的 Facebook，
--but also things like Profit, a time series library. 00:32:53,000 --> 00:32:57,000
还有时间序列库 Profit 之类的东西。
--And then there's Tianqi. 00:32:57,000 --> 00:32:59,000
然后是田七。
--So Tianqi, he was the original developer of XGBoost, 00:32:59,000 --> 00:33:03,000
所以天启，他是XGBoost的最初开发者，
--one of the most frequently used libraries for gradient boosting, 00:33:03,000 --> 00:33:08,000
最常用的梯度提升库之一，
--and still one of the most widely used libraries for tabular data. 00:33:08,000 --> 00:33:13,000
并且仍然是使用最广泛的表格数据库之一。
--He was a lead developer for the MXNet library, 00:33:13,000 --> 00:33:15,000
他是 MXNet 库的首席开发人员，
--which was another deep learning framework like PyTorch and TensorFlow. 00:33:15,000 --> 00:33:19,000
这是另一个深度学习框架，如 PyTorch 和 TensorFlow。
--And then most recently, one of the founding developers 00:33:19,000 --> 00:33:21,000
最近，创始开发者之一
--and core developers of the Apache TVM library. 00:33:21,000 --> 00:33:25,000
和 Apache TVM 库的核心开发人员。
--And so he has done kind of an amazing number of things 00:33:25,000 --> 00:33:29,000
所以他做了很多惊人的事情
--in machine learning systems as a whole, 00:33:29,000 --> 00:33:31,000
在整个机器学习系统中，
--and actually quite excited to be able to teach this course with him. 00:33:31,000 --> 00:33:37,000
能和他一起教这门课，我真的很兴奋。
--So before now I jump into the details of this course and these lectures, 00:33:37,000 --> 00:33:41,000
因此，在此之前，我会深入了解本课程和这些讲座的细节，
--I want to offer a big disclaimer, 00:33:41,000 --> 00:33:45,000
我想提供一个很大的免责声明，
--which I think needs to be said here. 00:33:45,000 --> 00:33:48,000
我认为需要在这里说一下。
--And what I'm saying here is that we are offering this course online 00:33:48,000 --> 00:33:51,000
我在这里要说的是我们在线提供这门课程
--for the first time. 00:33:51,000 --> 00:33:53,000
首次。
--We have not done this before. 00:33:53,000 --> 00:33:55,000
我们以前没有这样做过。
--And a lot of the material, especially the assignments, 00:33:55,000 --> 00:33:59,000
还有很多材料，尤其是作业，
--which is the most complex part of this course, 00:33:59,000 --> 00:34:02,000
这是本课程中最复杂的部分，
--is being revamped from the previous version. 00:34:02,000 --> 00:34:05,000
正在对以前的版本进行改进。
--It's actually being revamped even for the CMU version, 00:34:05,000 --> 00:34:07,000
它实际上正在为 CMU 版本进行改进，
--and then that will be their kind of beta testing this, 00:34:07,000 --> 00:34:10,000
然后这将是他们的测试版，
--and then you'll be given the assignments soon after that. 00:34:10,000 --> 00:34:13,000
之后很快就会给你分配作业。
--But as par for the course here, there are going to part, 00:34:13,000 --> 00:34:19,000
但作为这里课程的标准杆，会有一部分，
--no pun intended, but as par for the course, 00:34:19,000 --> 00:34:22,000
没有双关语的意思，但作为课程的标准，
--there are going to be bugs in the content and the assignments, 00:34:22,000 --> 00:34:26,000
内容和作业中会有错误，
--or just in the logistics of how we run things. 00:34:27,000 --> 00:34:30,000
或者只是在我们如何运作事物的后勤方面。
--This is the first time we're offering this as an online course. 00:34:30,000 --> 00:34:32,000
这是我们第一次将此作为在线课程提供。
--There are going to be bugs. 00:34:32,000 --> 00:34:34,000
会有错误。
--There are going to be hiccups. 00:34:34,000 --> 00:34:36,000
会有打嗝。
--Please bear with us. 00:34:36,000 --> 00:34:37,000
请多多包涵。
--There's a saying that you get what you pay for, right? 00:34:37,000 --> 00:34:39,000
有句话叫一分钱一分货，对吧？
--And this course is free. 00:34:39,000 --> 00:34:42,000
而且这个课程是免费的。
--It's free because we want people to be taking it 00:34:42,000 --> 00:34:45,000
它是免费的，因为我们希望人们接受它
--and we want this material to be out there. 00:34:45,000 --> 00:34:47,000
我们希望这种材料在那里。
--But we are doing this ourselves, and we are putting it together ourselves, 00:34:47,000 --> 00:34:51,000
但我们自己在做这件事，我们自己把它放在一起，
--and there will be bugs in it. 00:34:51,000 --> 00:34:53,000
并且其中会有错误。
--So we apologize kind of ahead of time for this. 00:34:53,000 --> 00:34:56,000
因此，我们为此提前表示歉意。
--Please bear with us. 00:34:56,000 --> 00:34:57,000
请多多包涵。
--We will do our best to fix these things 00:34:57,000 --> 00:34:59,000
我们会尽力解决这些问题
--and extend deadlines as needed to account for these bugs, 00:34:59,000 --> 00:35:02,000
并根据需要延长截止日期以解决这些错误，
--but they will be there, and we appreciate you. 00:35:02,000 --> 00:35:06,000
但他们会在那里，我们感谢你。
--You are all beta testers for this course as we create it. 00:35:06,000 --> 00:35:09,000
在我们创建这门课程时，你们都是 Beta 版测试员。
--So part of the fun of taking an online course for the first time 00:35:09,000 --> 00:35:13,000
这是第一次参加在线课程的乐趣之一
--is that you become a beta tester for the course. 00:35:13,000 --> 00:35:17,000
是您成为该课程的 Beta 测试员。
--All right. 00:35:17,000 --> 00:35:19,000
好的。
--Now, learning objectives. 00:35:19,000 --> 00:35:21,000
现在，学习目标。
--What are you going to learn in this course? 00:35:21,000 --> 00:35:23,000
你将在这门课程中学到什么？
--I probably made this clear from past slides, 00:35:23,000 --> 00:35:25,000
我可能已经从过去的幻灯片中清楚地说明了这一点，
--but let me lay it out just in very hopefully clear terms here. 00:35:25,000 --> 00:35:32,000
但让我在这里以非常希望清晰的方式进行说明。
--If you stay through this whole course, 00:35:32,000 --> 00:35:34,000
如果你坚持完成整个课程，
--do all the assignments, and do a final project, 00:35:34,000 --> 00:35:36,000
做所有的作业，做一个期末项目，
--then by the end of this course, 00:35:36,000 --> 00:35:38,000
然后在本课程结束时，
--you will understand the basic functioning of modern deep learning libraries, 00:35:38,000 --> 00:35:42,000
您将了解现代深度学习库的基本功能，
--including concepts like automatic differentiation 00:35:42,000 --> 00:35:45,000
包括自动微分之类的概念
--and grade-based optimization from an algorithmic standpoint. 00:35:45,000 --> 00:35:49,000
从算法的角度来看基于等级的优化。
--You will be able to implement really from scratch, right, 00:35:50,000 --> 00:35:54,000
您将能够真正从头开始实施，对吧，
--because we're talking about implementing these, you know, 00:35:54,000 --> 00:35:56,000
因为我们正在谈论实施这些，你知道，
--without PyTorch or without TensorFlow behind you, 00:35:56,000 --> 00:35:59,000
在没有 PyTorch 或没有 TensorFlow 的情况下，
--but just really just from raw Python. 00:35:59,000 --> 00:36:03,000
但实际上只是来自原始 Python。
--You'll be able to implement several standard deep learning architectures, 00:36:03,000 --> 00:36:06,000
你将能够实现几个标准的深度学习架构，
--things like MLPs, ConvNets, RNNs, or LSTMs, 00:36:06,000 --> 00:36:10,000
诸如 MLP、ConvNet、RNN 或 LSTM 之类的东西，
--various kinds of RNNs, and the transformers, 00:36:10,000 --> 00:36:13,000
各种 RNN 和变压器，
--and do it truly from scratch. 00:36:13,000 --> 00:36:16,000
并真正从头开始。
--You will also understand and implement 00:36:16,000 --> 00:36:19,000
您还将了解并实施
--how hardware acceleration works under the hood 00:36:19,000 --> 00:36:22,000
硬件加速是如何工作的
--and be able to develop your own highly efficient code. 00:36:22,000 --> 00:36:29,000
并能够开发自己的高效代码。
--Now, it's not going to be, I should emphasize, 00:36:29,000 --> 00:36:31,000
现在，它不会是，我应该强调，
--it's not going to be nearly as efficient as libraries like PyTorch or TensorFlow. 00:36:31,000 --> 00:36:37,000
它不会像 PyTorch 或 TensorFlow 这样的库那么高效。
--There's still a big gap between the very best that optimization can do 00:36:37,000 --> 00:36:42,000
优化所能达到的最佳效果之间仍有很大差距
--and that code optimization can do, I should actually emphasize, 00:36:42,000 --> 00:36:45,000
代码优化可以做到，我实际上应该强调，
--and what you can do to test lines of code. 00:36:45,000 --> 00:36:48,000
以及您可以做什么来测试代码行。
--No question. 00:36:48,000 --> 00:36:50,000
没有问题。
--So we're not going to break any speed records here, 00:36:50,000 --> 00:36:52,000
所以我们不会在这里打破任何速度记录，
--but you will be able to create libraries 00:36:52,000 --> 00:36:54,000
但你将能够创建库
--that work on reasonable medium-sized data, 00:36:54,000 --> 00:36:57,000
适用于合理的中型数据，
--data like CIFAR, right, reasonably sized networks and architectures. 00:36:57,000 --> 00:37:02,000
像 CIFAR 这样的数据，正确的，合理规模的网络和架构。
--You'll be able to develop them, right, 00:37:02,000 --> 00:37:04,000
你将能够开发它们，对吧，
--medium-sized architectures that actually work for these systems 00:37:04,000 --> 00:37:07,000
实际适用于这些系统的中型架构
--and do it entirely from scratch on GPU 00:37:07,000 --> 00:37:10,000
并在 GPU 上完全从头开始
--with automatic differentiation, with nice optimizers, all that. 00:37:10,000 --> 00:37:14,000
具有自动微分功能，具有出色的优化器，所有这些。
--Now, the course website, which is dlsyscourse.org, 00:37:15,000 --> 00:37:21,000
现在，课程网站 dlsyscourse.org，
--has all this information 00:37:21,000 --> 00:37:24,000
有所有这些信息
--and will have a listing and also posting of all the lectures for the course. 00:37:24,000 --> 00:37:29,000
并将列出并发布该课程的所有讲座。
--And you can look at the schedule of topics 00:37:29,000 --> 00:37:32,000
你可以看看主题的时间表
--to see what you'll be learning there. 00:37:32,000 --> 00:37:34,000
看看你会在那里学到什么。
--Now, one thing to emphasize is that that schedule, 00:37:34,000 --> 00:37:36,000
现在，要强调的一件事是那个时间表，
--at least the schedule here that I'm listing, 00:37:36,000 --> 00:37:39,000
至少我在这里列出的时间表，
--is the schedule for the CMU version, 00:37:39,000 --> 00:37:41,000
是 CMU 版本的时间表，
--which is about two weeks ahead of the online version. 00:37:41,000 --> 00:37:44,000
这比在线版本提前了大约两周。
--But we will also post the dates and the videos 00:37:44,000 --> 00:37:48,000
但我们也会发布日期和视频
--for all the online lectures as they become available, 00:37:48,000 --> 00:37:51,000
对于所有可用的在线讲座，
--and it will follow the same structure as the main CMU course. 00:37:51,000 --> 00:37:55,000
它将遵循与 CMU 主要课程相同的结构。
--Actually, only this lecture has slightly different slides 00:37:55,000 --> 00:37:58,000
实际上，只有本次讲座的幻灯片略有不同
--because there's different logistics for the online course versus the CMU course. 00:37:58,000 --> 00:38:03,000
因为在线课程与 CMU 课程的物流不同。
--But the rest of the schedule will follow the same schedule 00:38:03,000 --> 00:38:06,000
但其余的时间表将遵循相同的时间表
--between the CMU version of the course and the online course, 00:38:06,000 --> 00:38:10,000
CMU版本的课程和在线课程之间，
--and the schedule is up on the website. 00:38:10,000 --> 00:38:13,000
时间表在网站上。
--It talks about things like covering an ML refresher and background, 00:38:13,000 --> 00:38:18,000
它谈论诸如覆盖 ML 复习和背景之类的事情，
--automatic differentiation, different types of architectures, etc. 00:38:18,000 --> 00:38:23,000
自动微分，不同类型的架构等。
--Now, one thing you will see is that a lot of the lectures 00:38:23,000 --> 00:38:26,000
现在，你会看到的一件事是很多讲座
--are broken down between algorithm lectures, 00:38:26,000 --> 00:38:29,000
在算法讲座之间被分解，
--so lectures covering kind of the methodological algorithms 00:38:29,000 --> 00:38:35,000
所以讲座涵盖了一种方法算法
--or techniques used to accomplish some task in deep learning, 00:38:36,000 --> 00:38:42,000
或用于完成深度学习中某些任务的技术，
--and then implementation lectures, 00:38:42,000 --> 00:38:44,000
然后是实施讲座，
--where we will actually implement some portions of this 00:38:44,000 --> 00:38:48,000
我们将实际实现其中的某些部分
--or walk you through some simple live coding 00:38:48,000 --> 00:38:52,000
或者带你完成一些简单的实时编码
--of how these things actually are done in practice. 00:38:52,000 --> 00:38:58,000
这些事情实际上是如何在实践中完成的。
--Now, in order to take this course, 00:38:58,000 --> 00:39:02,000
现在，为了学习这门课程，
--what should you know ahead of time? 00:39:02,000 --> 00:39:05,000
你应该提前知道什么？
--And to be honest about this, 00:39:05,000 --> 00:39:09,000
老实说，
--there is some reasonable prerequisites you should have here 00:39:09,000 --> 00:39:12,000
这里有一些合理的先决条件
--in order to get the most out of this course. 00:39:12,000 --> 00:39:14,000
为了充分利用本课程。
--That's not to say that if you don't have all these things, 00:39:14,000 --> 00:39:17,000
这并不是说如果你没有所有这些东西，
--the course is impossible. 00:39:17,000 --> 00:39:19,000
当然是不可能的。
--If you're really excited about it and want to learn some of these things, 00:39:19,000 --> 00:39:23,000
如果你真的对此很感兴趣并且想学习其中的一些东西，
--concurrently as you go through the course, you're welcome to. 00:39:23,000 --> 00:39:26,000
在您完成课程的同时，欢迎您。
--Just know that it will be more effort to do so. 00:39:26,000 --> 00:39:29,000
只知道这样做会更加努力。
--But to take this course, you should have some background 00:39:29,000 --> 00:39:32,000
但是要学习这门课程，你应该有一些背景知识
--in systems programming. 00:39:32,000 --> 00:39:33,000
在系统编程中。
--That means basically C++ coding, how to compile things, 00:39:33,000 --> 00:39:39,000
这基本上意味着 C++ 编码，如何编译东西，
--how to compile things like not just run Python scripts 00:39:39,000 --> 00:39:44,000
如何编译诸如不只是运行 Python 脚本之类的东西
--but actually compile executable code that sort of runs natively on hardware. 00:39:44,000 --> 00:39:51,000
但实际上编译在硬件上本地运行的可执行代码。
--Linear algebra. 00:39:51,000 --> 00:39:54,000
线性代数。
--So you should be familiar with vector and matrix notation. 00:39:54,000 --> 00:40:00,000
所以你应该熟悉矢量和矩阵符号。
--There's no math I mentioned in this lecture, 00:40:00,000 --> 00:40:02,000
我在这个讲座中没有提到数学，
--but later lectures will actually require... 00:40:02,000 --> 00:40:06,000
但后面的讲座实际上需要...
--I will write things like a bunch of matrices and vectors 00:40:06,000 --> 00:40:09,000
我会写一堆矩阵和向量之类的东西
--multiplied against each other. 00:40:09,000 --> 00:40:10,000
相乘。
--I will do things like take gradients or derivatives of these things. 00:40:10,000 --> 00:40:14,000
我会做一些事情，比如采用这些东西的梯度或导数。
--And you should know what that means. 00:40:14,000 --> 00:40:18,000
你应该知道那是什么意思。
--That means also... 00:40:18,000 --> 00:40:20,000
这也意味着...
--Probably the biggest requirement really is linear algebra. 00:40:21,000 --> 00:40:25,000
可能最大的要求真的是线性代数。
--But there's other things too like calculus. 00:40:25,000 --> 00:40:27,000
但是还有其他东西，比如微积分。
--Really, to be clear, just taking derivatives, 00:40:27,000 --> 00:40:29,000
真的，要清楚，只是采取衍生品，
--we don't really do any integrals. 00:40:29,000 --> 00:40:32,000
我们真的不做任何积分。
--There's some integrals in probability, I guess, 00:40:32,000 --> 00:40:34,000
我猜概率中有一些积分，
--but we don't do many integrals in deep learning. 00:40:34,000 --> 00:40:38,000
但是我们在深度学习中并没有做很多积分。
--But you should know when I write things like gradient symbols 00:40:38,000 --> 00:40:41,000
但是你应该知道我什么时候写渐变符号之类的东西
--and stuff like that, you should know what these things mean 00:40:41,000 --> 00:40:43,000
诸如此类，你应该知道这些是什么意思
--or have some understanding of it. 00:40:43,000 --> 00:40:45,000
或者对它有一定的了解。
--We can provide some links to refreshers or background material on this, 00:40:45,000 --> 00:40:48,000
我们可以提供一些关于此的复习或背景材料的链接，
--but if this is really brand new to you, 00:40:48,000 --> 00:40:51,000
但如果这对你来说真的是全新的，
--this could be somewhat challenging to become familiar with. 00:40:51,000 --> 00:40:55,000
这可能有点难以熟悉。
--As well as basic proofs. 00:40:55,000 --> 00:40:57,000
以及基本证明。
--Now, we're not going to do many proofs in this course, to be very clear. 00:40:57,000 --> 00:41:00,000
现在，为了清楚起见，我们不会在本课程中做很多证明。
--This is really a systems course, 00:41:00,000 --> 00:41:01,000
这真是一门系统课程，
--but you should be familiar with the basic constructs 00:41:01,000 --> 00:41:04,000
但你应该熟悉基本结构
--of how you go about deriving things mathematically. 00:41:04,000 --> 00:41:07,000
你如何着手从数学上推导事物。
--How do you derive a gradient, stuff like this. 00:41:07,000 --> 00:41:11,000
你如何推导梯度，诸如此类。
--You need some Python and C++ development background. 00:41:11,000 --> 00:41:16,000
您需要一些 Python 和 C++ 开发背景。
--A common question that's asked is, 00:41:17,000 --> 00:41:19,000
一个常见的问题是，
--how much C++ background do you need? 00:41:19,000 --> 00:41:22,000
您需要多少 C++ 背景？
--The answer is, I don't think that much. 00:41:22,000 --> 00:41:26,000
答案是，我没有想那么多。
--We're not using any advanced features of C++ or anything. 00:41:26,000 --> 00:41:29,000
我们没有使用 C++ 的任何高级功能或任何东西。
--We're not even using C++, 00:41:29,000 --> 00:41:33,000
我们甚至没有使用 C++，
--certainly not C++20 and not even C++11 or anything like that. 00:41:33,000 --> 00:41:36,000
当然不是 C++20，甚至不是 C++11 或类似的东西。
--I don't even know if that's the right year, to be honest. 00:41:36,000 --> 00:41:39,000
老实说，我什至不知道那一年是否合适。
--I don't know those things very well. 00:41:39,000 --> 00:41:40,000
我不是很了解那些东西。
--We're not using any unique pointers or anything like that. 00:41:40,000 --> 00:41:43,000
我们没有使用任何独特的指针或类似的东西。
--It's really just C with a few classes in addition. 00:41:43,000 --> 00:41:46,000
它实际上只是 C，另外还有一些类。
--I see this as a very minimal C or C++ experience, 00:41:46,000 --> 00:41:50,000
我认为这是一种非常简单的 C 或 C++ 体验，
--but what you should know how to do is, 00:41:50,000 --> 00:41:53,000
但你应该知道该怎么做，
--if we give you a template for writing a matrix multiplication call in C++, 00:41:53,000 --> 00:42:00,000
如果我们给你一个用 C++ 编写矩阵乘法调用的模板，
--so this template would take in a bunch of float pointers 00:42:00,000 --> 00:42:04,000
所以这个模板会接受一堆浮点指针
--and const float pointers and stuff like that, 00:42:04,000 --> 00:42:06,000
和 const float 指针之类的东西，
--the sizes of these matrices, things like this, 00:42:06,000 --> 00:42:10,000
这些矩阵的大小，像这样的东西，
--where those pointers point to the raw underlying data in the matrices, 00:42:10,000 --> 00:42:16,000
这些指针指向矩阵中的原始底层数据，
--you should know how to write quickly a matrix multiplication routine 00:42:16,000 --> 00:42:21,000
你应该知道如何快速编写矩阵乘法例程
--that would multiply these two matrices together. 00:42:21,000 --> 00:42:24,000
这会将这两个矩阵相乘。
--Then, most importantly, because this will happen, 00:42:24,000 --> 00:42:27,000
然后，最重要的是，因为这会发生，
--when you mess up your indexing in C++ 00:42:27,000 --> 00:42:30,000
当你在 C++ 中搞乱你的索引时
--because there's no safe indexing there 00:42:30,000 --> 00:42:32,000
因为那里没有安全索引
--and you have a segfault of your program, 00:42:32,000 --> 00:42:34,000
你的程序有段错误，
--you should know how to debug it, 00:42:34,000 --> 00:42:36,000
你应该知道如何调试它，
--either through a debugger or, if you're like me, 00:42:36,000 --> 00:42:39,000
通过调试器，或者，如果你像我一样，
--at the very least through printf statements. 00:42:39,000 --> 00:42:42,000
至少通过 printf 语句。
--This is how I debug, honestly, C++ code. 00:42:42,000 --> 00:42:45,000
老实说，这就是我调试 C++ 代码的方式。
--You should know how to fix things when your code segfaults. 00:42:45,000 --> 00:42:49,000
当您的代码出现段错误时，您应该知道如何解决问题。
--That's the level of C++ background you need. 00:42:49,000 --> 00:42:53,000
这就是您需要的 C++ 背景水平。
--Python, you should probably be familiar with classes and such in Python too 00:42:53,000 --> 00:42:58,000
 Python，您可能也应该熟悉 Python 中的类等
--because you will be implementing most of the structure of this library in Python 00:42:58,000 --> 00:43:03,000
因为您将在 Python 中实现该库的大部分结构
--and that you have to be familiar with. 00:43:03,000 --> 00:43:05,000
而且你必须熟悉。
--C, C++ is really for the low-level background. 00:43:05,000 --> 00:43:07,000
 C、C++真的是给底层出身的。
--You don't need to know CUDA programming ahead of time. 00:43:07,000 --> 00:43:09,000
您无需提前了解 CUDA 编程。
--We will cover what you need to know for the course, 00:43:09,000 --> 00:43:12,000
我们将涵盖您需要了解的课程内容，
--but you need to understand basic C++ programming. 00:43:12,000 --> 00:43:15,000
但您需要了解基本的 C++ 编程。
--And then finally, you do need to have prior experience with machine learning. 00:43:15,000 --> 00:43:19,000
最后，您确实需要有机器学习方面的经验。
--If machine learning is really new to you, 00:43:19,000 --> 00:43:22,000
如果机器学习对你来说真的很陌生，
--you're much better off taking a machine learning course first 00:43:22,000 --> 00:43:25,000
你最好先参加机器学习课程
--and then taking this course afterwards. 00:43:25,000 --> 00:43:27,000
之后再学习这门课程。
--You will get much, much more out of this 00:43:27,000 --> 00:43:29,000
你会从中得到很多很多
--if you're already familiar with machine learning 00:43:29,000 --> 00:43:32,000
如果您已经熟悉机器学习
--and probably already familiar with deep learning to a large degree 00:43:32,000 --> 00:43:35,000
并且可能已经在很大程度上熟悉深度学习
--and then take this course to understand more how these things actually work. 00:43:35,000 --> 00:43:40,000
然后参加本课程以更多地了解这些东西实际上是如何工作的。
--So if you are unsure about your background, 00:43:40,000 --> 00:43:43,000
因此，如果您不确定自己的背景，
--then what I would say is take a look at the first three lectures, 00:43:43,000 --> 00:43:48,000
那么我要说的是看一下前三讲，
--I guess not including this one, the next three, 00:43:48,000 --> 00:43:51,000
我想不包括这个，接下来的三个，
--and look at Homework 0, 00:43:51,000 --> 00:43:53,000
并查看作业 0，
--which is going to be released two days after we officially start the class. 00:43:53,000 --> 00:43:58,000
正式开课两天后发布。
--This Homework 0 is essentially meant to be a refresher 00:43:58,000 --> 00:44:03,000
这个家庭作业 0 本质上是为了复习
--on some basic ideas of traditional ways of writing things. 00:44:03,000 --> 00:44:07,000
关于传统写作方式的一些基本思想。
--Basically, you will implement softmax regression 00:44:07,000 --> 00:44:10,000
基本上，您将实现 softmax 回归
--and a simple two-layer neural network. 00:44:10,000 --> 00:44:12,000
和一个简单的两层神经网络。
--And you should be familiar with a two-layer neural network 00:44:12,000 --> 00:44:16,000
你应该熟悉两层神经网络
--using manual backprop. 00:44:16,000 --> 00:44:19,000
使用手动反向传播。
--And you should be familiar with that. 00:44:19,000 --> 00:44:21,000
你应该对此很熟悉。
--You should have seen this before. 00:44:21,000 --> 00:44:23,000
你应该以前看过这个。
--And maybe with a bit of refresher, 00:44:23,000 --> 00:44:25,000
也许稍微提神一下，
--be able to do that relatively quickly to know this course is right for you. 00:44:25,000 --> 00:44:30,000
能够相对较快地做到这一点，以了解本课程适合您。
--And one of these lectures we'll also write in C with the C++ backend. 00:44:31,000 --> 00:44:36,000
其中一堂课我们还将使用 C++ 后端用 C 语言编写。
--But if that is very challenging for you, 00:44:36,000 --> 00:44:38,000
但如果这对你来说非常具有挑战性，
--then probably you should take some other material before you take this course. 00:44:38,000 --> 00:44:42,000
那么在学习本课程之前，您可能应该学习一些其他材料。
--But if all those things are pretty straightforward 00:44:42,000 --> 00:44:45,000
但如果所有这些事情都非常简单
--or really can be made more straightforward again 00:44:45,000 --> 00:44:48,000
或者真的可以再次变得更直接
--if you brush up a little bit, 00:44:48,000 --> 00:44:50,000
如果你稍微刷一下，
--then this course is likely the right level for you. 00:44:50,000 --> 00:44:54,000
那么本课程可能适合您。
--Now, there are four main elements to this course. 00:44:54,000 --> 00:44:56,000
现在，本课程有四个主要元素。
--The video lectures of which you are watching the first one, 00:44:57,000 --> 00:45:00,000
您正在观看的第一个视频讲座，
--programming-based homeworks, 00:45:00,000 --> 00:45:03,000
基于编程的家庭作业，
--a final project done in groups, 00:45:03,000 --> 00:45:05,000
小组完成的最终项目，
--and interaction in the course forum. 00:45:05,000 --> 00:45:08,000
以及课程论坛中的互动。
--And it's important to take part in all of these 00:45:08,000 --> 00:45:11,000
参与所有这些活动很重要
--in order to get the full value of the course. 00:45:11,000 --> 00:45:13,000
为了获得课程的全部价值。
--I really think that each of these components 00:45:13,000 --> 00:45:16,000
我真的认为这些组件中的每一个
--plays a crucial, crucial role in really understanding the material. 00:45:16,000 --> 00:45:20,000
在真正理解材料方面起着至关重要的作用。
--Even if, for example, lectures are not directly using the homework, 00:45:20,000 --> 00:45:23,000
即使，例如，讲座不直接使用作业，
--they're still very important to know. 00:45:23,000 --> 00:45:25,000
知道它们仍然很重要。
--And even if the forum is, you know, in some sense optional, 00:45:25,000 --> 00:45:30,000
即使论坛在某种意义上是可选的，
--it's very valuable to sort of get interaction 00:45:30,000 --> 00:45:33,000
获得互动是非常有价值的
--with other students taking the course 00:45:33,000 --> 00:45:35,000
与其他参加课程的学生一起
--in order to get the most out of it possible. 00:45:35,000 --> 00:45:37,000
为了尽可能地利用它。
--I do want to emphasize that this online public course 00:45:39,000 --> 00:45:42,000
我想强调的是，这个在线公共课程
--is offered really independently of the CMU version. 00:45:42,000 --> 00:45:45,000
真正独立于 CMU 版本提供。
--So we can't offer CMU credit or things like this 00:45:45,000 --> 00:45:49,000
所以我们不能提供 CMU 学分或类似的东西
--for taking this course even if you pass and do well on the course. 00:45:49,000 --> 00:45:53,000
即使您通过并在课程中表现出色，也可以参加这门课程。
--But what we will do is for everyone in the course 00:45:53,000 --> 00:45:56,000
但我们要做的是为课程中的每个人
--who completes the assignments, gets an average of 80% or higher, 00:45:56,000 --> 00:46:00,000
谁完成了作业，获得平均 80% 或更高的分数，
--and submits a final project, 00:46:00,000 --> 00:46:02,000
并提交最终项目，
--you'll receive a Certificate of Completion for the course 00:46:02,000 --> 00:46:05,000
您将收到该课程的结业证书
--to sort of indicate you've completed it. 00:46:05,000 --> 00:46:07,000
某种程度上表明你已经完成了它。
--We'll somehow make it official, 00:46:07,000 --> 00:46:09,000
我们会以某种方式使其正式化，
--probably post it on the website or something 00:46:09,000 --> 00:46:11,000
可能会张贴在网站或其他东西上
--so you can have an official link to it and things like that. 00:46:11,000 --> 00:46:13,000
所以你可以有一个官方链接和类似的东西。
--But you will receive a Certificate of Completion for personalized to you 00:46:13,000 --> 00:46:17,000
但是您将收到一份为您量身定制的结业证书
--that in some sense certifies you've taken and completed this course, 00:46:17,000 --> 00:46:21,000
在某种意义上证明你已经学习并完成了这门课程，
--even just in some sense, in the online public version. 00:46:21,000 --> 00:46:26,000
甚至只是在某种意义上，在网络公开版中。
--Because it is a lot of effort, 00:46:26,000 --> 00:46:28,000
因为付出了很多努力，
--and we do want to ensure that you have something to show 00:46:28,000 --> 00:46:31,000
我们确实想确保你有东西可以展示
--and some sort of record that you've completed this 00:46:31,000 --> 00:46:33,000
以及你已经完成的某种记录
--and done it successfully. 00:46:33,000 --> 00:46:35,000
并成功完成。
--Now I'll end by just describing each of these a little bit, 00:46:37,000 --> 00:46:40,000
现在我将通过稍微描述其中的每一个来结束，
--each of these four elements in a bit more detail here. 00:46:40,000 --> 00:46:44,000
这四个元素中的每一个都在这里更详细一点。
--So the video lectures themselves are going to be 00:46:44,000 --> 00:46:47,000
所以视频讲座本身将是
--essentially in the format you're watching right now. 00:46:47,000 --> 00:46:49,000
本质上是您现在正在观看的格式。
--So they will be live recordings of the lecture. 00:46:49,000 --> 00:46:54,000
因此，它们将是讲座的现场录音。
--They will consist of slide presentations like this one. 00:46:54,000 --> 00:46:58,000
它们将由像这样的幻灯片演示组成。
--But most won't just be this. 00:46:58,000 --> 00:47:00,000
但大多数不会只是这个。
--I think this is the only lecture that is just nothing but slides. 00:47:00,000 --> 00:47:03,000
我认为这是唯一一次除了幻灯片之外什么都没有的讲座。
--The rest will also have things like mathematical notes to them, 00:47:03,000 --> 00:47:06,000
其余的也会有数学笔记之类的东西，
--derivations, and in many cases live coding to illustrate some ideas. 00:47:06,000 --> 00:47:11,000
推导，并且在许多情况下实时编码来说明一些想法。
--Videos for all the lectures will be posted to YouTube 00:47:12,000 --> 00:47:15,000
所有讲座的视频都将发布到 YouTube
--or other video sites. 00:47:15,000 --> 00:47:16,000
或其他视频网站。
--We're going to try to make them available on a few different video sites 00:47:16,000 --> 00:47:18,000
我们将尝试在几个不同的视频网站上提供它们
--so that they can be accessed globally according to the course schedule. 00:47:18,000 --> 00:47:22,000
以便可以根据课程安排在全球范围内访问它们。
--And videos will be available to everyone. 00:47:22,000 --> 00:47:25,000
每个人都可以看到视频。
--So because they're on YouTube, anyone can watch them. 00:47:25,000 --> 00:47:28,000
因为它们在 YouTube 上，所以任何人都可以观看它们。
--So you can actually watch without officially enrolling in the course. 00:47:28,000 --> 00:47:31,000
所以你可以在没有正式注册课程的情况下实际观看。
--Many of you probably are watching without officially enrolling in the course. 00:47:31,000 --> 00:47:34,000
你们中的许多人可能在没有正式注册课程的情况下观看。
--They don't require registering for the course. 00:47:35,000 --> 00:47:37,000
他们不需要注册课程。
--One thing I will mention, which you can probably tell from this 00:47:37,000 --> 00:47:40,000
我会提到一件事，您可能可以从中看出这一点
--if you've made it this far through the lecture so far, 00:47:40,000 --> 00:47:43,000
如果到目前为止你已经通过讲座做到了这一点，
--is that these lectures are taken in one take. 00:47:43,000 --> 00:47:46,000
是这些讲座是一次性完成的。
--So we're not doing a lot of editing here. 00:47:46,000 --> 00:47:48,000
所以我们没有在这里做很多编辑。
--Essentially, we are recording these live, 00:47:48,000 --> 00:47:50,000
本质上，我们正在现场录制这些，
--and we will, with minimal, be cutting at the beginning, at the end, 00:47:50,000 --> 00:47:53,000
我们将以最少的方式在开始和结束时进行切割，
--or if something really goes bad, cropping in the middle. 00:47:53,000 --> 00:47:55,000
或者如果事情真的变坏了，在中间裁剪。
--We're mostly going to do these in one take 00:47:55,000 --> 00:47:57,000
我们主要是一次完成这些
--and with all the hiccups and such that happen in a real lecture. 00:47:57,000 --> 00:48:01,000
以及在真实讲座中发生的所有问题。
--So this is sort of an online version but still kind of live stream. 00:48:01,000 --> 00:48:07,000
所以这是一种在线版本，但仍然是一种直播。
--Think of them as live streams of lectures. 00:48:07,000 --> 00:48:09,000
将它们视为现场直播的讲座。
--The second component that I mentioned was programming assignments. 00:48:11,000 --> 00:48:14,000
我提到的第二个组成部分是编程作业。
--And this is actually, if I were to say, 00:48:14,000 --> 00:48:16,000
这实际上是，如果我要说，
--this is probably the most important component of the class. 00:48:16,000 --> 00:48:19,000
这可能是该课程中最重要的组成部分。
--So it isn't a homework zero, 00:48:19,000 --> 00:48:21,000
所以这不是零作业，
--which is kind of a separate thing in and of itself. 00:48:21,000 --> 00:48:24,000
这本身就是一种独立的事物。
--There are four homeworks, homeworks one through four. 00:48:24,000 --> 00:48:27,000
有四门作业，作业一到四。
--And these four homeworks take you through the process 00:48:27,000 --> 00:48:33,000
而这四个作业带你走完流程
--of building different aspects of this needle library, 00:48:33,000 --> 00:48:39,000
建立这个针库的不同方面，
--this minimal Python deep learning framework. 00:48:39,000 --> 00:48:43,000
这个最小的 Python 深度学习框架。
--And in particular, you're going to first develop 00:48:44,000 --> 00:48:47,000
特别是，您将首先开发
--an automatic differentiation framework for needle. 00:48:47,000 --> 00:48:50,000
needle 的自动微分框架。
--Then you will use this to build a simple neural network library 00:48:50,000 --> 00:48:54,000
然后你将使用它来构建一个简单的神经网络库
--with things like modules for neural networks, 00:48:54,000 --> 00:48:58,000
诸如神经网络模块之类的东西，
--optimization techniques, data loading, that kind of stuff. 00:48:58,000 --> 00:49:01,000
优化技术、数据加载之类的东西。
--You will then implement linear algebra backends 00:49:01,000 --> 00:49:06,000
然后你将实现线性代数后端
--on both CPUs and GPU systems. 00:49:06,000 --> 00:49:09,000
在 CPU 和 GPU 系统上。
--And finally, you'll use these things to implement a number of, 00:49:09,000 --> 00:49:12,000
最后，你将使用这些东西来实现一些，
--in the fourth assignment, a number of common architectures 00:49:12,000 --> 00:49:16,000
在第四个作业中，一些常见的架构
--like convolutional networks, recurrent networks, 00:49:16,000 --> 00:49:18,000
像卷积网络，循环网络，
--and possibly transformers. 00:49:18,000 --> 00:49:21,000
和可能的变压器。
--Each of these assignments builds on previous ones, 00:49:21,000 --> 00:49:25,000
这些作业中的每一个都建立在以前的作业之上，
--and you actually have to complete them in order. 00:49:25,000 --> 00:49:27,000
你实际上必须按顺序完成它们。
--You have to complete the first assignment 00:49:27,000 --> 00:49:29,000
你必须完成第一个任务
--before you can do later ones because they build on each other. 00:49:29,000 --> 00:49:33,000
在你可以做以后的事情之前，因为它们是相互建立的。
--And this process of building this library 00:49:33,000 --> 00:49:37,000
而这个建立这个图书馆的过程
--really is the key component of the course. 00:49:37,000 --> 00:49:41,000
确实是课程的关键组成部分。
--And it is how you will learn the most through it. 00:49:41,000 --> 00:49:44,000
这就是您将如何通过它学到最多的东西。
--So anyone can watch the lecture videos, 00:49:44,000 --> 00:49:51,000
所以任何人都可以观看讲座视频，
--but in order to submit the assignments, 00:49:51,000 --> 00:49:54,000
但为了提交作业，
--you do need to officially sign up for the course. 00:49:54,000 --> 00:49:58,000
您确实需要正式注册该课程。
--So you have to actually register for the course. 00:49:58,000 --> 00:50:00,000
所以你必须实际注册课程。
--So if you're watching this video just on YouTube 00:50:00,000 --> 00:50:01,000
因此，如果您只是在 YouTube 上观看此视频
--and have not signed up for the course yet, 00:50:01,000 --> 00:50:03,000
还没有报名参加课程，
--if you want to submit the assignments, 00:50:03,000 --> 00:50:05,000
如果你想提交作业，
--which is really the way you learn this material, 00:50:05,000 --> 00:50:08,000
这就是你学习这些材料的真正方式，
--then you sign up for the course, 00:50:08,000 --> 00:50:10,000
然后你报名参加课程，
--and you will get an account to submit assignments 00:50:10,000 --> 00:50:12,000
你会得到一个帐户来提交作业
--to our autograding setup. 00:50:12,000 --> 00:50:15,000
到我们的自动分级设置。
--Now, one thing I want to mention is that 00:50:15,000 --> 00:50:17,000
现在，我想提的一件事是
--the homeworks are entirely coding-based. 00:50:17,000 --> 00:50:21,000
家庭作业完全基于编码。
--There's no derivations, nothing like this in the homeworks, 00:50:21,000 --> 00:50:24,000
没有推导，作业中没有这样的东西，
--or whatever derivation we have, it's sort of implicit 00:50:24,000 --> 00:50:26,000
或者我们有什么推导，它有点隐含
--because then you have to code it up afterwards 00:50:26,000 --> 00:50:28,000
因为你必须在之后对其进行编码
--to know if it actually works or not. 00:50:28,000 --> 00:50:30,000
知道它是否真的有效。
--The homeworks are entirely coding-based, 00:50:30,000 --> 00:50:32,000
家庭作业完全基于编码，
--and they're all autograded. 00:50:32,000 --> 00:50:34,000
他们都是自动评分的。
--This is actually true for the CMU version, too. 00:50:34,000 --> 00:50:35,000
这实际上也适用于 CMU 版本。
--This is the exact same in the CMU version of the course. 00:50:35,000 --> 00:50:37,000
这与课程的 CMU 版本完全相同。
--Everything, there's no theory questions in the homework. 00:50:37,000 --> 00:50:41,000
一切，作业中没有理论题。
--It is just program assignments, all code-based. 00:50:41,000 --> 00:50:44,000
这只是程序作业，都是基于代码的。
--And it's graded through our own autograding system 00:50:44,000 --> 00:50:48,000
它是通过我们自己的自动评分系统评分的
--that I've actually been developing for a few years. 00:50:48,000 --> 00:50:52,000
我实际上已经开发了几年。
--And this autograding system works a bit differently 00:50:52,000 --> 00:50:55,000
这个自动评分系统的工作方式有点不同
--from others you might have seen. 00:50:55,000 --> 00:50:57,000
从你可能见过的其他人那里。
--I'll document this a lot in a future lecture, 00:50:57,000 --> 00:51:02,000
我会在以后的讲座中记录很多，
--actually a separate video about the autograding system 00:51:02,000 --> 00:51:05,000
实际上是关于自动评分系统的单独视频
--I'll post soon after this one. 00:51:05,000 --> 00:51:08,000
我会在这个之后很快发布。
--I'll run through the process of submitting code 00:51:08,000 --> 00:51:11,000
我将运行提交代码的过程
--to this autograder. 00:51:11,000 --> 00:51:12,000
给这个自动分级机。
--But the big difference that I'll just highlight right now 00:51:12,000 --> 00:51:14,000
但我现在要强调的最大区别
--is that in this autograder, you actually run 00:51:14,000 --> 00:51:16,000
是在这个自动分级器中，你实际上运行
--all your code locally, rather than submitting your code 00:51:16,000 --> 00:51:19,000
您所有的代码都在本地，而不是提交您的代码
--and having it run on the autograder, 00:51:19,000 --> 00:51:21,000
让它在自动分级机上运行，
--which causes all sorts of problems 00:51:21,000 --> 00:51:23,000
这会导致各种问题
--because the environment in the autograder 00:51:23,000 --> 00:51:25,000
因为自动分级机中的环境
--is never the same as the one you've coded on locally. 00:51:25,000 --> 00:51:28,000
永远不会与您在本地编写的代码相同。
--So you actually run all your execution locally, 00:51:28,000 --> 00:51:31,000
所以你实际上在本地运行所有的执行，
--and you only submit answers, 00:51:31,000 --> 00:51:32,000
而你只提交答案，
--so the answers and check against reference solutions 00:51:32,000 --> 00:51:35,000
所以答案并对照参考解决方案进行检查
--in the autograding system, 00:51:35,000 --> 00:51:36,000
在自动评分系统中，
--which makes it much more efficient, much faster to run, 00:51:36,000 --> 00:51:39,000
这使得它更有效率，运行速度更快，
--as well as makes it a little bit less painful 00:51:39,000 --> 00:51:42,000
以及让它不那么痛苦
--in terms of debugging environment setups. 00:51:42,000 --> 00:51:44,000
在调试环境设置方面。
--So I'll go through all that in a later lecture. 00:51:44,000 --> 00:51:49,000
因此，我将在稍后的讲座中详细介绍所有这些内容。
--It also means that essentially running in codelab environments, 00:51:49,000 --> 00:51:52,000
这也意味着本质上是在代码实验室环境中运行，
--at least currently, I know codelab's changing monthly, 00:51:52,000 --> 00:51:55,000
至少目前，我知道 codelab 每月都在变化，
--so we may run into some issues, hiccups with codelab, 00:51:55,000 --> 00:51:57,000
所以我们可能会遇到一些问题，代码实验室的小问题，
--but at least currently you can do all the assignments in codelab. 00:51:57,000 --> 00:52:01,000
但至少目前您可以在 Codelab 中完成所有作业。
--And submit them, execute them all in codelab, 00:52:01,000 --> 00:52:04,000
并提交它们，在 codelab 中执行它们，
--and do all the autograding and use that. 00:52:04,000 --> 00:52:06,000
并进行所有自动分级并使用它。
--And as I said, I will go through that, 00:52:06,000 --> 00:52:08,000
正如我所说，我会经历这些，
--the setup and at least the desired workflow 00:52:08,000 --> 00:52:12,000
设置和至少所需的工作流程
--for how you should do assignments. 00:52:12,000 --> 00:52:14,000
你应该如何做作业。
--I'll go through that in a separate video in a few, 00:52:14,000 --> 00:52:18,000
我将在几个单独的视频中进行介绍，
--probably post it actually concurrently with this one, 00:52:18,000 --> 00:52:20,000
可能实际上与这个同时发布，
--but in a few more, in a few days. 00:52:20,000 --> 00:52:25,000
但再过几天，再过几天。
--All right, the second to last component is the final project. 00:52:25,000 --> 00:52:28,000
好吧，倒数第二个组件是最终项目。
--So in addition to homeworks, there will be a final project. 00:52:28,000 --> 00:52:32,000
所以除了家庭作业，还会有期末作业。
--And unlike the homeworks, which are to be done individually, 00:52:32,000 --> 00:52:35,000
与需要单独完成的家庭作业不同，
--the final project should be done in groups. 00:52:35,000 --> 00:52:39,000
最终项目应分组完成。
--So you will form groups, 00:52:39,000 --> 00:52:40,000
所以你们会组队，
--there will be posting on the forums to form groups as the time comes. 00:52:40,000 --> 00:52:42,000
届时将在论坛上发帖以组成群组。
--Then in groups of three, especially for the online course, 00:52:42,000 --> 00:52:45,000
然后三人一组，尤其是在线课程，
--if you want to find a group of one, 00:52:45,000 --> 00:52:47,000
如果你想找到一组，
--or if you find bigger groups, it's certainly fine. 00:52:47,000 --> 00:52:50,000
或者，如果您找到更大的团体，那当然没问题。
--The point is to form a group and do a final project. 00:52:50,000 --> 00:52:54,000
重点是组成一个小组并做一个最终项目。
--And the idea here is the final project involves 00:52:54,000 --> 00:52:56,000
这里的想法是最终项目涉及
--developing some new piece of functionality for Needle. 00:52:56,000 --> 00:53:00,000
为 Needle 开发一些新功能。
--So it's like kind of Homework 5, designing Homework 5, right? 00:53:00,000 --> 00:53:04,000
所以这有点像家庭作业 5，设计家庭作业 5，对吧？
--Well, to be clear, it's Homework 0 and Homework 4 are the homeworks, 00:53:04,000 --> 00:53:06,000
好吧，要明确一点，作业 0 和作业 4 是作业，
--so your final project is like Homework 5. 00:53:06,000 --> 00:53:09,000
所以你的最终项目就像家庭作业 5。
--You develop some new functionality capability to the Needle framework. 00:53:09,000 --> 00:53:16,000
您为 Needle 框架开发了一些新的功能。
--It's really important though that this final project involves 00:53:16,000 --> 00:53:18,000
这真的很重要，尽管这个最终项目涉及
--some kind of extension to Needle, 00:53:18,000 --> 00:53:20,000
对 Needle 的某种扩展，
--not just implementing some architecture, 00:53:20,000 --> 00:53:23,000
不只是实现一些架构，
--and certainly not just implementing an architecture in PyTorch TensorFlow. 00:53:23,000 --> 00:53:26,000
当然不仅仅是在 PyTorch TensorFlow 中实现一个架构。
--You can't just do that as a final project. 00:53:26,000 --> 00:53:28,000
你不能把它作为一个最终项目来做。
--It really has to be an extension of the Needle library. 00:53:28,000 --> 00:53:32,000
它确实必须是 Needle 库的扩展。
--Add a different kind of hardware acceleration to the backend. 00:53:32,000 --> 00:53:37,000
向后端添加不同类型的硬件加速。
--Our GPU work is going to work on CUDA using CUDA libraries, 00:53:37,000 --> 00:53:42,000
我们的 GPU 工作将使用 CUDA 库在 CUDA 上工作，
--so you could do one that uses OpenCL 00:53:42,000 --> 00:53:44,000
所以你可以做一个使用 OpenCL 的
--or maybe optimizes for the M1 Apple chip, stuff like this, right? 00:53:44,000 --> 00:53:49,000
或者可能针对 M1 Apple 芯片进行优化，诸如此类，对吧？
--All of these things are possible, 00:53:49,000 --> 00:53:51,000
所有这些都是可能的，
--or maybe you do sort of hardware fused optimization for fused operators 00:53:51,000 --> 00:53:57,000
或者也许您对融合运算符进行了某种硬件融合优化
--and things like this. 00:53:57,000 --> 00:53:58,000
和这样的事情。
--These are all potential projects. 00:53:58,000 --> 00:53:59,000
这些都是有潜力的项目。
--We'll also post a few more possibilities, 00:53:59,000 --> 00:54:01,000
我们还将发布更多可能性，
--but the idea is that you want to do some extension of Needle 00:54:01,000 --> 00:54:04,000
但想法是你想对 Needle 做一些扩展
--as your final project. 00:54:04,000 --> 00:54:07,000
作为你的最终项目。
--And finally, the last thing is the course forum. 00:54:07,000 --> 00:54:11,000
最后，最后一件事是课程论坛。
--So for those that signed up for the course, 00:54:11,000 --> 00:54:14,000
所以对于那些报名参加课程的人来说，
--and actually, again, this part requires you to actually enroll in the course. 00:54:14,000 --> 00:54:17,000
实际上，这部分再次要求您实际注册该课程。
--When you enroll in the course, you will soon thereafter 00:54:17,000 --> 00:54:20,000
当您注册课程后，您很快就会
--get an invitation to join the class forum, 00:54:20,000 --> 00:54:24,000
获得加入班级论坛的邀请，
--where you can log in after this class, 00:54:24,000 --> 00:54:26,000
在这节课后你可以在哪里登录，
--after watching this lecture, if you haven't done so yet. 00:54:26,000 --> 00:54:30,000
看完这个讲座后，如果你还没有这样做的话。
--And you should use this course forum essentially as a resource 00:54:30,000 --> 00:54:34,000
你应该把这个课程论坛作为一种资源来使用
--to discuss and talk about the aspects of the course. 00:54:34,000 --> 00:54:39,000
讨论和谈论课程的各个方面。
--You can and should ask for help, for example, 00:54:39,000 --> 00:54:41,000
您可以而且应该寻求帮助，例如，
--with assignments in the forum. 00:54:41,000 --> 00:54:43,000
在论坛中分配任务。
--We won't be able to answer all questions. 00:54:43,000 --> 00:54:47,000
我们无法回答所有问题。
--We, the instructors, and the TAs won't be able to answer all of them 00:54:47,000 --> 00:54:50,000
我们、导师和助教无法一一回答
--just due to sort of availability, 00:54:50,000 --> 00:54:52,000
只是由于某种可用性，
--but please do upvote questions that you find important and relevant 00:54:52,000 --> 00:54:57,000
但请对您认为重要且相关的问题进行投票
--that you are struggling with maybe, 00:54:57,000 --> 00:54:58,000
你正在挣扎的也许，
--and we will try to answer the most upvoted or the most liked questions 00:54:58,000 --> 00:55:02,000
我们将尝试回答投票最多或最喜欢的问题
--to be sure that they're not sort of widespread issues 00:55:02,000 --> 00:55:04,000
确保它们不是普遍存在的问题
--that everyone's encountering. 00:55:04,000 --> 00:55:06,000
每个人都会遇到的。
--But then also, please do help by answering questions 00:55:06,000 --> 00:55:10,000
但也请通过回答问题来提供帮助
--from other students, right? 00:55:10,000 --> 00:55:12,000
来自其他学生，对吧？
--We want to form somewhat of a community around this course here, 00:55:12,000 --> 00:55:15,000
我们想在这里围绕这门课程形成一个社区，
--so please do not just post questions, 00:55:15,000 --> 00:55:18,000
所以请不要只是发布问题，
--but also see if you can answer questions from other students. 00:55:18,000 --> 00:55:20,000
还要看看你能不能回答其他同学的问题。
--The more you're able to do that, the more everyone kind of benefits. 00:55:20,000 --> 00:55:25,000
你能做到的越多，每个人的好处就越多。
--You can ask for help, and that does include, 00:55:25,000 --> 00:55:28,000
你可以寻求帮助，这包括，
--in some cases, posting code. 00:55:28,000 --> 00:55:30,000
在某些情况下，发布代码。
--But please, we have further, 00:55:30,000 --> 00:55:33,000
但是请，我们还有进一步的，
--let's just say further instructions are posted 00:55:33,000 --> 00:55:35,000
我们只是说发布了进一步的说明
--in the main welcome message in the forum, 00:55:35,000 --> 00:55:37,000
在论坛的主要欢迎信息中，
--but we do have some sort of formal rules, 00:55:37,000 --> 00:55:44,000
但我们确实有一些正式的规则，
--but the reality is you can do things like post code and stuff, 00:55:44,000 --> 00:55:47,000
但现实是你可以做邮政编码之类的事情，
--and you can even share small amounts of code, 00:55:47,000 --> 00:55:49,000
你甚至可以共享少量代码，
--but please be reasonable. 00:55:49,000 --> 00:55:50,000
但请保持理性。
--Don't just verbatim share entire solutions on the course forum. 00:55:50,000 --> 00:55:55,000
不要在课程论坛上逐字逐句地分享整个解决方案。
--You get the most out of this course 00:55:55,000 --> 00:55:57,000
您将从本课程中获得最大收益
--by implementing the assignments yourselves, 00:55:57,000 --> 00:56:00,000
通过自己完成任务，
--and if you post your code, 00:56:00,000 --> 00:56:02,000
如果你发布你的代码，
--then that makes other people not able to have that experience 00:56:02,000 --> 00:56:05,000
那么这会让其他人无法拥有那种体验
--or they just then end up copying the code 00:56:05,000 --> 00:56:07,000
或者他们只是最终复制了代码
--and not writing it themselves, 00:56:07,000 --> 00:56:09,000
而不是自己写的，
--and so be reasonable when it comes to what you post in the forums. 00:56:09,000 --> 00:56:12,000
因此，当涉及到您在论坛中发布的内容时，请保持合理。
--You can absolutely share code 00:56:12,000 --> 00:56:13,000
您绝对可以共享代码
--and share at least snippets of code and things like this. 00:56:13,000 --> 00:56:16,000
并至少分享代码片段和类似的东西。
--Again, it's an online course, 00:56:16,000 --> 00:56:17,000
同样，这是一个在线课程，
--so you could in some sense do whatever you want, 00:56:17,000 --> 00:56:21,000
所以你可以在某种意义上做任何你想做的事，
--but at least in the public forum, 00:56:21,000 --> 00:56:23,000
但至少在公共论坛上，
--please do be sort of reasonable 00:56:23,000 --> 00:56:27,000
请讲道理
--in terms of not trying to give away content 00:56:27,000 --> 00:56:30,000
在不试图放弃内容方面
--for people that would rather not sort of see the full, 00:56:30,000 --> 00:56:33,000
对于那些不想看到完整内容的人来说，
--see full solutions posted for the assignments. 00:56:33,000 --> 00:56:37,000
查看为作业发布的完整解决方案。
--All right. 00:56:38,000 --> 00:56:40,000
好的。
--With that, I'm ending the first lecture here 00:56:40,000 --> 00:56:44,000
至此，我的第一堂课到此结束
--with a few parting words. 00:56:44,000 --> 00:56:46,000
几句离别的话。
--So we're really excited to be able to offer this course publicly, 00:56:46,000 --> 00:56:50,000
所以我们真的很高兴能够公开提供这门课程，
--and we really look forward to having you in the course, 00:56:50,000 --> 00:56:54,000
我们真的很期待你能参加这门课程，
--and if you do have feedback or comments from us, for us, 00:56:54,000 --> 00:57:00,000
如果您确实有我们的反馈或意见，对我们来说，
--please let us know. 00:57:00,000 --> 00:57:01,000
请告诉我们。
--Now, it may not be possible to make changes to this offering, 00:57:01,000 --> 00:57:04,000
现在，可能无法更改此产品，
--but we're making this course public 00:57:05,000 --> 00:57:08,000
但我们正在公开这门课程
--because we want it to be a resource 00:57:08,000 --> 00:57:10,000
因为我们希望它成为一种资源
--for those that are interested in deep learning systems 00:57:10,000 --> 00:57:14,000
对于那些对深度学习系统感兴趣的人
--or just interested in deep learning as a whole, 00:57:14,000 --> 00:57:16,000
或者只是对整个深度学习感兴趣，
--and if you can give us feedback 00:57:16,000 --> 00:57:19,000
如果你能给我们反馈
--that can help us improve at that mission, 00:57:19,000 --> 00:57:22,000
可以帮助我们改进那个任务，
--we appreciate it. 00:57:22,000 --> 00:57:24,000
我们很感激。
--So we look forward to having you in the course. 00:57:24,000 --> 00:57:27,000
因此，我们期待您的加入。
--As I said, I promise the next lecture is much more contentful, 00:57:27,000 --> 00:57:32,000
就像我说的，我保证下一节课内容更丰富，
--so if you got through this and said, 00:57:32,000 --> 00:57:34,000
所以如果你通过这个并说，
--hey, I haven't learned anything yet. 00:57:34,000 --> 00:57:36,000
嘿，我还没有学到任何东西。
--Where's all the content? 00:57:36,000 --> 00:57:38,000
所有的内容在哪里？
--Look at the next lecture next. 00:57:38,000 --> 00:57:39,000
接下来看下一讲。
--It will cover some of the basics of machine learning, 00:57:39,000 --> 00:57:42,000
它将涵盖机器学习的一些基础知识，
--and then soon we'll get into automatic differentiation after that. 00:57:42,000 --> 00:57:45,000
之后我们很快就会进入自动微分。
--But we really look forward to having you, 00:57:45,000 --> 00:57:47,000
但我们真的很期待你，
--and we hope you enjoy this course 00:57:47,000 --> 00:57:50,000
我们希望你喜欢这门课程
--as much as we're enjoying putting it together. 00:57:50,000 --> 00:57:53,000
就像我们喜欢把它放在一起一样。
