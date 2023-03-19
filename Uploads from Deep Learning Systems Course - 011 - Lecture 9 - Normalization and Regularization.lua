--Hi everyone. Today we're going to talk about two topics, 00:00:00,000 --> 00:00:04,380
大家好。今天我们要聊两个话题，
--normalization and regularization. 00:00:04,380 --> 00:00:07,760
规范化和正则化。
--So in the past few lectures, 00:00:07,760 --> 00:00:09,480
所以在过去的几节课中，
--we've talked about how to build the internals of a neural network library. 00:00:09,480 --> 00:00:14,440
我们已经讨论了如何构建神经网络库的内部结构。
--Now we're going to start talking a little bit about some of 00:00:14,440 --> 00:00:16,520
现在我们要开始谈论一些
--the tricks and architectures you can use to help you train these things 00:00:16,520 --> 00:00:21,960
你可以用来帮助你训练这些东西的技巧和架构
--more efficiently and build better and easier to train architectures. 00:00:21,960 --> 00:00:28,960
更有效地构建更好、更容易训练的架构。
--Normalization and regularization are two somewhat different aspects to modern deep networks. 00:00:28,960 --> 00:00:39,200
归一化和正则化是现代深度网络的两个有些不同的方面。
--We're going to talk about both of these because they're somewhat related, 00:00:39,200 --> 00:00:42,320
我们将讨论这两者，因为它们有些相关，
--and as we'll see later in the last section, 00:00:42,320 --> 00:00:44,600
正如我们稍后将在上一节中看到的，
--these things all do have some degree of interaction, 00:00:44,600 --> 00:00:47,320
这些东西都有一定程度的相互作用，
--as well as also interact with things like initialization and optimization. 00:00:47,320 --> 00:00:51,360
以及与初始化和优化等交互。
--So to start off with, 00:00:51,360 --> 00:00:53,640
所以首先，
--we're going to talk about normalization, 00:00:53,640 --> 00:00:55,400
我们将讨论规范化，
--then we're going to talk about regularization, 00:00:55,400 --> 00:00:57,000
然后我们要谈谈正则化，
--and then we're going to talk about the interaction of all these things, 00:00:57,000 --> 00:00:59,520
然后我们将讨论所有这些东西的相互作用，
--including optimization, initialization, etc. 00:00:59,520 --> 00:01:02,080
包括优化、初始化等。
--All right, so let's jump right in and start with normalization. 00:01:02,080 --> 00:01:06,560
好吧，让我们直接进入并从规范化开始。
--If you remember from a few lectures ago, 00:01:06,800 --> 00:01:10,320
如果你还记得之前的几节课，
--the initial weights that we chose for a deep network were very important. 00:01:10,320 --> 00:01:16,520
我们为深度网络选择的初始权重非常重要。
--So for example, you may have remembered that we initialize our weights with Gaussian random variables. 00:01:16,520 --> 00:01:24,720
因此，例如，您可能还记得我们使用高斯随机变量初始化权重。
--So often it was, you know, we initialize our weights to be random, 00:01:24,760 --> 00:01:27,480
通常情况下，你知道，我们将权重初始化为随机的，
--maybe sometimes uniform, or maybe sometimes Gaussian random variables. 00:01:27,480 --> 00:01:30,600
有时可能是统一的，或者有时可能是高斯随机变量。
--But the variance of these Gaussian random variables mattered a lot. 00:01:30,600 --> 00:01:35,080
但是这些高斯随机变量的方差很重要。
--So this momentation here just says that we're initializing our weights randomly, 00:01:35,080 --> 00:01:38,400
所以这个时刻只是说我们正在随机初始化我们的权重，
--we're initializing them with random samples from a Gaussian distribution with mean zero 00:01:38,400 --> 00:01:43,280
我们用均值为零的高斯分布中的随机样本对它们进行初始化
--and variance of c over n, 00:01:43,280 --> 00:01:46,080
和 c 在 n 上的方差，
--where n is the number of the dimensionality of the input to this layer. 00:01:46,080 --> 00:01:50,800
其中 n 是该层输入的维数。
--And remember that for a ReLU network, 00:01:50,800 --> 00:01:53,840
请记住，对于 ReLU 网络，
--well, first of all, remember two things, 00:01:53,840 --> 00:01:54,920
嗯，首先，记住两件事，
--that the choice here of c is very important. 00:01:54,920 --> 00:01:59,240
在这里选择 c 非常重要。
--And it turns out that for a ReLU network, 00:01:59,240 --> 00:02:01,200
事实证明，对于 ReLU 网络，
--the choice of c equals 2 is sort of the right choice 00:02:01,200 --> 00:02:04,880
选择 c 等于 2 是一种正确的选择
--because it maintains the variance of the activations as you go deeper and deeper in a network. 00:02:04,880 --> 00:02:12,280
因为当你在网络中越来越深时，它会保持激活的方差。
--And we'll actually see that in this figure here. 00:02:12,280 --> 00:02:14,680
我们实际上会在这个图中看到这一点。
--When you choose the variance here to be 2 over n, 00:02:14,680 --> 00:02:18,480
当你在这里选择方差为 2 over n 时，
--then this corresponds to this line here, 00:02:18,480 --> 00:02:22,480
那么这对应于这里的这一行，
--and it maintains variance of the layers. 00:02:22,480 --> 00:02:25,200
并且它保持层的差异。
--I'll discuss what this figure is showing in a second, though. 00:02:25,200 --> 00:02:28,000
不过，我稍后会讨论这个数字显示的内容。
--But what I also want to show here is that we can also initialize with other variances too. 00:02:28,000 --> 00:02:33,160
但我还想在这里展示的是，我们也可以用其他方差进行初始化。
--So we can initialize the variance of, say, 3 over n or 1 over n, etc. 00:02:33,160 --> 00:02:37,040
所以我们可以初始化方差，比方说，3 over n 或 1 over n，等等。
--And these are actually pretty close, right? 00:02:37,040 --> 00:02:38,720
这些实际上非常接近，对吧？
--These are sort of within the same factor of the same rough order of magnitude as 2 over n, 00:02:38,720 --> 00:02:49,720
这些在与 2 over n 相同的粗略数量级的相同因子内排序，
--but they lead to very different behavior. 00:02:49,720 --> 00:02:52,480
但它们会导致非常不同的行为。
--And so to show that, I'm actually going to show these plots below here. 00:02:52,480 --> 00:02:55,960
因此，为了表明这一点，我实际上将在下面展示这些图。
--So what these plots show here is I'm initializing a 50-layer deep network 00:02:55,960 --> 00:03:01,000
所以这些图在这里显示的是我正在初始化一个 50 层的深度网络
--and applying it to, in this case, MNIST. 00:03:01,000 --> 00:03:03,080
并将其应用于 MNIST，在本例中。
--It doesn't really matter what I'm applying it to here, 00:03:03,080 --> 00:03:05,920
我在这里应用它并不重要，
--but it will matter when I'm training these networks a little bit. 00:03:05,920 --> 00:03:09,240
但当我稍微训练这些网络时，这很重要。
--So what I'm showing in these plots here is the layer of the network. 00:03:09,240 --> 00:03:13,360
所以我在这些图中展示的是网络层。
--So this x-axis here shows the layer of the network. 00:03:13,360 --> 00:03:15,560
所以这里的 x 轴显示了网络层。
--This network is 50 layers deep. 00:03:15,560 --> 00:03:17,840
这个网络有 50 层深。
--And on the y-axis, at least in this plot, I'm showing the activation norm. 00:03:17,840 --> 00:03:22,160
在 y 轴上，至少在这个图中，我显示了激活范数。
--So what's the norm of the Zi term? 00:03:22,160 --> 00:03:25,080
那么子项的规范是什么？
--So this term here basically would be like the norm of the different Zi terms as you go through the network. 00:03:25,080 --> 00:03:32,200
所以这里的这个词基本上就像你通过网络时不同子词的规范。
--And what I'm showing here on this next plot is the gradient norm. 00:03:32,200 --> 00:03:36,920
我在下一个图中展示的是梯度范数。
--So that would be the norm of the gradient values as you go through the network, right? 00:03:36,920 --> 00:03:42,120
所以这就是你通过网络时梯度值的标准，对吧？
--So something like the norm of the gradient with respect to Wi of our loss. 00:03:42,160 --> 00:03:48,400
所以类似于我们损失的 Wi 的梯度范数。
--Just abbreviate it like that. 00:03:48,400 --> 00:03:50,480
就这样缩写吧。
--Okay, so these are the two things that I'm showing here. 00:03:50,480 --> 00:03:52,440
好的，这就是我在这里展示的两件事。
--And these are both actually sort of L2 norms in this case. 00:03:52,440 --> 00:03:58,000
在这种情况下，这些实际上都是 L2 规范。
--All right, so what we see here is sort of two interesting things. 00:03:58,000 --> 00:04:02,680
好吧，所以我们在这里看到的是两件有趣的事情。
--The first is that in the case, as we kind of expect it actually, 00:04:02,680 --> 00:04:07,320
首先是在这种情况下，正如我们实际上所期望的那样，
--in the case where we pick the right activations for the ReLU network, 00:04:07,320 --> 00:04:12,800
在我们为 ReLU 网络选择正确激活的情况下，
--our norms stay roughly the same throughout optimization, 00:04:12,800 --> 00:04:17,040
我们的规范在整个优化过程中大致保持不变，
--or sorry, throughout the layers of the network, I mean. 00:04:17,040 --> 00:04:21,800
或者抱歉，我的意思是在整个网络层中。
--The norm hovers around, you know, the activations themselves kind of hover around 00:04:21,800 --> 00:04:27,560
常态徘徊，你知道，激活本身有点徘徊
--kind of a similar value throughout the whole layer, the whole depth of the network. 00:04:27,560 --> 00:04:32,840
整个层，网络的整个深度都有类似的值。
--But if we pick other values, if I pick 1 over n, 00:04:32,840 --> 00:04:37,080
但是如果我们选择其他值，如果我选择 1 而不是 n，
--then this is in some sense too small a weight. 00:04:37,080 --> 00:04:40,440
那么这在某种意义上太小了。
--And so what this means is that the activations decrease in norm a lot 00:04:40,440 --> 00:04:45,880
所以这意味着激活在规范中减少了很多
--throughout the depth of the network. 00:04:45,880 --> 00:04:48,880
贯穿整个网络的深度。
--And similarly, if I pick a larger initialization, 00:04:48,880 --> 00:04:53,400
同样，如果我选择更大的初始化，
--the values increase over the depth of the network. 00:04:53,400 --> 00:04:57,720
这些值随着网络的深度而增加。
--That's sort of the first thing to notice. 00:04:57,720 --> 00:04:58,760
这是首先要注意的事情。
--The second thing to notice is that the gradients, 00:04:58,760 --> 00:05:02,600
要注意的第二件事是梯度，
--those actually are roughly static because just the, 00:05:02,600 --> 00:05:06,440
这些实际上是大致静态的，因为只是，
--you can kind of look at this if you want, 00:05:06,440 --> 00:05:08,000
如果你愿意，你可以看看这个，
--but the formula for the gradient, 00:05:08,000 --> 00:05:12,040
但是梯度的公式，
--remember, you sort of use both the backward pass and the forward pass 00:05:12,040 --> 00:05:15,520
记住，你有点同时使用后向传球和前向传球
--to compute the gradient with respect to the weights, 00:05:15,520 --> 00:05:17,400
计算关于权重的梯度，
--and terms cancel such that these things actually remain constant 00:05:17,400 --> 00:05:20,680
并且条款取消使得这些事情实际上保持不变
--throughout the whole network. 00:05:20,680 --> 00:05:22,120
遍及整个网络。
--But the big difference, of course, here is that if you initialize 00:05:22,120 --> 00:05:27,360
但是最大的区别当然是如果你初始化
--with sort of the right, or 2 over n, 00:05:27,360 --> 00:05:31,680
有某种权利，或 2 超过 n，
--I'll let the right or the wrong, depending on your perspective. 00:05:31,680 --> 00:05:34,760
我会让对或错，取决于你的观点。
--But with the right, sort of the correct initialization 00:05:34,760 --> 00:05:38,520
但是正确的，有点正确的初始化
--to maintain the norm of the activations across depth, 00:05:38,520 --> 00:05:42,880
保持跨深度激活的常态，
--you get kind of a reasonable scaling to your gradients. 00:05:42,880 --> 00:05:46,200
您可以合理地缩放渐变。
--Whereas for larger values, you get sort of much larger values 00:05:46,200 --> 00:05:49,600
而对于更大的值，你会得到更大的值
--of your gradients here. 00:05:49,600 --> 00:05:50,360
你的梯度在这里。
--So gradients of 10 to the 4 for the 3 over n case, 00:05:50,360 --> 00:05:54,720
所以对于 3 over n 的情况，梯度从 10 到 4，
--or 10 to the minus 8 for the 1 over n case. 00:05:54,720 --> 00:05:58,840
或 1 over n 情况下的 10 到负 8。
--And what this corresponds to, and this is sort of the punchline here, 00:05:58,840 --> 00:06:02,400
这对应的是什么，这是这里的妙语，
--is that you may think that sort of the initialization, it matters, 00:06:02,400 --> 00:06:09,720
你可能认为那种初始化很重要，
--but it doesn't matter that much because after all, 00:06:09,720 --> 00:06:11,920
但这并不重要 因为毕竟
--you actually are optimizing these things. 00:06:11,920 --> 00:06:13,480
你实际上是在优化这些东西。
--So maybe after a few iterations, these weights will be kind of fixed 00:06:13,480 --> 00:06:16,960
所以也许在几次迭代之后，这些权重会有点固定
--and it doesn't really matter how you initialize them, 00:06:16,960 --> 00:06:18,680
你如何初始化它们并不重要，
--they'll all end up the same. 00:06:18,680 --> 00:06:20,280
他们最终都会一样。
--But this is definitely not true in deep networks. 00:06:20,280 --> 00:06:23,640
但这在深度网络中绝对不是这样。
--So for example, if I pick 3 over n as my variance initialize width, 00:06:23,640 --> 00:06:28,200
因此，例如，如果我选择 3 over n 作为我的方差初始化宽度，
--I have a very big norm for my gradients here. 00:06:28,200 --> 00:06:34,400
我在这里的渐变有一个非常大的标准。
--And what ends up happening is that my loss just goes to non-number. 00:06:34,400 --> 00:06:37,920
最终发生的是我的损失只是非数字。
--I think if you've ever tried to optimize deep networks, 00:06:37,920 --> 00:06:42,600
我想如果你曾经尝试过优化深度网络，
--I'm sure you've in some sense or in some cases 00:06:42,600 --> 00:06:46,800
我确定你在某种意义上或在某些情况下
--had the experience of training a network and all of a sudden 00:06:46,800 --> 00:06:49,360
有训练网络的经验，突然之间
--the loss becomes nan or your weights become nan values. 00:06:49,360 --> 00:06:52,480
损失变成 nan 或者你的权重变成 nan 值。
--Basically, you have numerical overflow. 00:06:52,520 --> 00:06:54,040
基本上，你有数字溢出。
--Sometimes everything blows up and things just go wrong. 00:06:54,040 --> 00:06:56,600
有时一切都会爆炸，事情就会出错。
--And what's happening here is that the norm of the gradient is just too large. 00:06:56,600 --> 00:06:59,560
这里发生的事情是梯度的范数太大了。
--And so as I optimize these things, my weights just sort of start to go unstable 00:06:59,560 --> 00:07:05,000
所以当我优化这些东西时，我的体重开始变得不稳定
--and things diverge and you get nans. 00:07:05,000 --> 00:07:08,200
事情发生了分歧，你得到了 nans。
--And no one likes this. 00:07:08,200 --> 00:07:10,080
没有人喜欢这个。
--On the flip side, if you try to optimize starting at the 1 over n point, 00:07:10,080 --> 00:07:16,240
另一方面，如果您尝试从 1 over n 点开始优化，
--nothing ever happens. 00:07:16,240 --> 00:07:17,080
什么都没有发生。
--You make no progress. 00:07:17,080 --> 00:07:18,720
你没有进步。
--So you just sort of stall out for a while. 00:07:18,720 --> 00:07:20,840
所以你只是有点拖延了一段时间。
--And whereas, of course, if you use 2 over n, in this case, it does work 00:07:20,840 --> 00:07:25,160
当然，如果你使用 2 而不是 n，在这种情况下，它确实有效
--and you are able to optimize even this 50-layer deep network. 00:07:25,160 --> 00:07:28,000
你甚至可以优化这个 50 层的深度网络。
--It's not actually, I should emphasize, you don't get a huge benefit 00:07:28,000 --> 00:07:31,280
这实际上不是，我应该强调，你不会得到巨大的好处
--from training a 50-layer network on MNIST, but it does in fact work. 00:07:31,280 --> 00:07:35,040
来自在 MNIST 上训练 50 层网络，但它确实有效。
--It's not a fully connected 50-layer network, but it does in fact work. 00:07:35,040 --> 00:07:38,920
它不是一个完全连接的 50 层网络，但它确实有效。
--And so the big intuition I want to emphasize here 00:07:38,920 --> 00:07:43,720
所以我想在这里强调的大直觉
--is that I, for a long time, had this notion 00:07:43,720 --> 00:07:48,240
是我，很长一段时间，有这个观念
--that the incorrect initialization would be quickly, in some sense, 00:07:48,240 --> 00:07:53,480
从某种意义上说，不正确的初始化会很快，
--fixed by optimization, right? 00:07:53,480 --> 00:07:55,600
通过优化修复，对吧？
--Because who cares how we initialize things? 00:07:55,600 --> 00:07:57,560
因为谁在乎我们如何初始化东西？
--In convex optimization, for example, it doesn't really 00:07:57,560 --> 00:07:59,440
例如，在凸优化中，它实际上并不
--matter how you initialize things because your weights kind of go 00:07:59,440 --> 00:08:02,440
不管你如何初始化东西，因为你的权重有点走
--to the correct point no matter what, as long as you're not sort of too far out 00:08:02,440 --> 00:08:05,760
无论如何都要到正确的点，只要你不是离得太远
--of bounds. 00:08:05,760 --> 00:08:06,760
的界限。
--But deep learning is very different. 00:08:06,760 --> 00:08:08,400
但是深度学习是非常不同的。
--And when you're optimizing deep networks, 00:08:08,400 --> 00:08:10,360
当你优化深度网络时，
--we often find that the initial values for our weights matter a whole lot 00:08:10,360 --> 00:08:16,320
我们经常发现权重的初始值非常重要
--because otherwise things will just never train. 00:08:16,320 --> 00:08:20,320
因为否则事情永远不会训练。
--Doesn't matter how long you train, how many gradient steps you take, 00:08:20,320 --> 00:08:24,600
不管你训练多长时间，采取多少梯度步骤，
--or how many SGD iterations you take. 00:08:24,600 --> 00:08:26,440
或者你进行了多少次 SGD 迭代。
--They just never train or they diverge. 00:08:26,440 --> 00:08:29,400
他们只是从不训练或者他们分歧。
--And I want to emphasize this problem actually 00:08:29,400 --> 00:08:31,680
我实际上想强调这个问题
--goes much deeper than just this example of sort of these failure cases 00:08:31,680 --> 00:08:36,080
比这些失败案例的例子更深入
--of either not making progress at all or of blowing up and becoming NAND values. 00:08:36,080 --> 00:08:43,840
要么根本没有取得进展，要么爆炸并成为 NAND 价值。
--Because actually, it turns out that if I even initialize things 00:08:43,840 --> 00:08:47,240
因为事实上，事实证明如果我什至初始化东西
--to a more narrow scale, we actually get similar effects here. 00:08:47,240 --> 00:08:51,760
在更窄的范围内，我们实际上在这里得到了类似的效果。
--So in this case, I am showing three more examples 00:08:51,760 --> 00:08:54,960
所以在这种情况下，我再展示三个例子
--with the initialization chosen such that you still have sort of a, 00:08:54,960 --> 00:09:00,000
选择初始化，这样你仍然有一种，
--this is initialization of 1.7 over N for the variance, which 00:09:00,000 --> 00:09:04,000
这是方差在 N 上 1.7 的初始化，它
--is a little bit less than 2. 00:09:04,000 --> 00:09:05,920
略小于 2。
--Then you have 2 as before, and then you have 2.3. 00:09:05,920 --> 00:09:09,440
然后你有 2 和以前一样，然后你有 2.3。
--And these networks actually all will train. 00:09:09,440 --> 00:09:11,200
而这些网络实际上都会训练。
--They will train to some degree of loss. 00:09:11,200 --> 00:09:13,760
他们会训练到某种程度的损失。
--You can get the loss down from this. 00:09:13,760 --> 00:09:15,880
你可以从中减少损失。
--But the point I want to make here is that the behavior or the effects 00:09:15,880 --> 00:09:21,440
但我想在这里强调的是行为或效果
--you have at initialization, they persist throughout the whole network. 00:09:21,440 --> 00:09:26,280
你在初始化时，它们在整个网络中持续存在。
--So I'm going to train this network. 00:09:26,280 --> 00:09:27,800
所以我要训练这个网络。
--I'm going to train all three of these networks 00:09:27,800 --> 00:09:29,680
我要训练这三个网络
--actually to 5% error on MNIST. 00:09:29,680 --> 00:09:32,240
在 MNIST 上实际上有 5% 的错误。
--And what you see here is that there's a lot of interesting effects 00:09:32,240 --> 00:09:36,560
你在这里看到的是有很多有趣的效果
--to this plot actually. 00:09:36,560 --> 00:09:39,360
实际上到这个情节。
--One thing you'll see is that the activation norms actually 00:09:39,360 --> 00:09:42,000
你会看到的一件事是激活规范实际上
--do change from the initial version. 00:09:42,000 --> 00:09:45,400
从初始版本做更改。
--So you have activations that, no matter what your initialization is, 00:09:45,400 --> 00:09:48,400
所以你有激活，不管你的初始化是什么，
--you have activations that actually in the later stages of the network 00:09:48,400 --> 00:09:51,880
你有实际上在网络后期阶段的激活
--are a bit more. 00:09:51,880 --> 00:09:54,640
多一点。
--They're a bit higher here than they are in the initial layers. 00:09:54,640 --> 00:09:57,960
它们在这里比初始层高一点。
--And there is some difference in the different ones. 00:09:57,960 --> 00:10:00,040
而且不同的有一些区别。
--So the activations of the blue initialization 00:10:00,040 --> 00:10:03,200
所以蓝色初始化的激活
--do remain a bit lower than the other ones. 00:10:03,200 --> 00:10:05,480
确实比其他的低一点。
--But those actually do kind of, in some sense, 00:10:05,480 --> 00:10:07,960
但从某种意义上说，那些实际上确实有点，
--become at least fairly similar. 00:10:07,960 --> 00:10:10,120
至少变得相当相似。
--The gradients also change by the layers. 00:10:10,120 --> 00:10:13,520
梯度也随着层而变化。
--And some effects persist from the initialization. 00:10:13,520 --> 00:10:16,000
一些影响从初始化中持续存在。
--But they also kind of stay similar. 00:10:16,000 --> 00:10:17,920
但它们也有点相似。
--The point I actually want to highlight here is an interesting point. 00:10:17,920 --> 00:10:20,600
我实际上想在这里强调的一点是一个有趣的观点。
--And I've always found this very, very surprising. 00:10:20,600 --> 00:10:23,320
我一直觉得这非常非常令人惊讶。
--And it's not really having an effect here on error. 00:10:23,320 --> 00:10:25,720
它并没有真正对错误产生影响。
--But the point that I want to emphasize here 00:10:25,720 --> 00:10:27,480
但是我想在这里强调的一点
--is that if you look at the actual weights after training, 00:10:27,480 --> 00:10:32,720
如果你看一下训练后的实际重量，
--you cannot differentiate between these two figures. 00:10:32,720 --> 00:10:35,240
你无法区分这两个数字。
--And I actually had to check this several times 00:10:35,240 --> 00:10:37,600
我实际上不得不检查几次
--to make sure I wasn't making a mistake here. 00:10:37,640 --> 00:10:40,080
以确保我没有在这里犯错。
--Because I've always found this very surprising, 00:10:40,080 --> 00:10:42,400
因为我一直觉得这很令人惊讶，
--is that when you train a deep network, 00:10:42,400 --> 00:10:45,120
就是当你训练一个深度网络时，
--it turns out that your weights change very little 00:10:45,120 --> 00:10:50,880
原来你的体重变化很小
--compared to their initial values. 00:10:50,880 --> 00:10:53,320
与它们的初始值相比。
--Or rather, the way I'll put it, obviously the weights are changing. 00:10:53,320 --> 00:10:56,560
或者更确切地说，按照我的说法，权重显然在变化。
--I mean, these values are different. 00:10:56,560 --> 00:10:59,640
我的意思是，这些值是不同的。
--I'm just plotting the norm of the weights here for the layers. 00:10:59,640 --> 00:11:02,360
我只是在这里为图层绘制权重的范数。
--But this line here is actually essentially indistinguishable from this one. 00:11:02,360 --> 00:11:08,200
但是这里的这条线其实和这一条在本质上是没有区别的。
--And the point is that the weights don't change. 00:11:08,200 --> 00:11:10,320
关键是权重不会改变。
--The weights, of course, do change. 00:11:10,320 --> 00:11:11,960
当然，权重确实会发生变化。
--But in some sense, they change in a relatively small degree 00:11:11,960 --> 00:11:15,600
但在某种意义上，它们的变化相对较小
--relative to their initialization, at least for these very deep networks, 00:11:15,600 --> 00:11:19,120
相对于它们的初始化，至少对于这些非常深的网络来说，
--trained in this case with SGD. 00:11:19,120 --> 00:11:20,960
在这种情况下使用 SGD 进行训练。
--Now, this doesn't always happen. 00:11:20,960 --> 00:11:22,320
现在，这并不总是发生。
--There are some cases where you get potentially more. 00:11:22,320 --> 00:11:24,480
在某些情况下，您可能会获得更多。
--And if you look at certain dimensions, and this is just plotting their norm, 00:11:24,480 --> 00:11:27,320
如果你观察某些维度，这只是绘制它们的标准，
--so the direction of the weights can still change 00:11:27,320 --> 00:11:29,280
所以权重的方向仍然可以改变
--while sort of keeping a similar norm. 00:11:29,280 --> 00:11:31,400
同时保持类似的规范。
--But this is a really interesting effect of deep networks, 00:11:31,400 --> 00:11:34,320
但这是深度网络的一个非常有趣的效果，
--is that it challenges our normal ideas of optimization 00:11:34,320 --> 00:11:38,560
是它挑战了我们正常的优化观念
--and what the weights do in optimization. 00:11:38,560 --> 00:11:42,920
以及权重在优化中的作用。
--And so these things have to be taken into account 00:11:42,920 --> 00:11:46,400
所以必须考虑这些事情
--when you think about these networks. 00:11:46,400 --> 00:11:50,280
当你想到这些网络时。
--OK, but moving on from this, the main point I want to emphasize here 00:11:50,280 --> 00:11:54,320
好的，但是从这里开始，我想在这里强调的要点
--is that initialization matters. 00:11:54,320 --> 00:11:58,160
是初始化很重要。
--And initialization matters insofar as it affects 00:11:58,160 --> 00:12:02,000
初始化很重要，因为它会影响
--the relative norms of the activations and their gradients over time, right? 00:12:02,000 --> 00:12:08,000
激活的相对规范及其随时间的梯度，对吗？
--That's sort of the high-level takeaway I want 00:12:08,000 --> 00:12:10,360
这就是我想要的高级外卖
--to make from these three sets of slides here. 00:12:10,360 --> 00:12:13,640
从这里的这三组幻灯片制作。
--So this one here, and then this figure here, two sets of slides here. 00:12:13,640 --> 00:12:18,440
所以这里是这张，然后是这张图，还有两套幻灯片。
--OK, so what can we do about this? 00:12:18,440 --> 00:12:22,120
好的，那么我们能做些什么呢？
--Well, one obvious idea is that initialization does matter. 00:12:22,120 --> 00:12:29,040
好吧，一个显而易见的想法是初始化确实很重要。
--And it matters amongst other reasons, because when you initialize differently, 00:12:29,040 --> 00:12:35,160
这在其他原因中很重要，因为当你以不同的方式初始化时，
--the norms of your activations may no longer be the same across training. 00:12:35,160 --> 00:12:42,320
您的激活规范在整个培训中可能不再相同。
--But the high-level thing to remember here, 00:12:42,320 --> 00:12:45,040
但这里要记住的高级事情是，
--and now as you probably have experienced a lot in the last couple lectures, 00:12:45,040 --> 00:12:51,280
现在你可能在上几节课中经历了很多，
--a layer in deep networks can really do anything at all, right? 00:12:51,280 --> 00:12:55,440
深度网络中的一层真的可以做任何事情，对吧？
--So we can have a layer that, of course, computes a linear function, 00:12:55,440 --> 00:13:01,800
所以我们可以有一个层，当然，它可以计算一个线性函数，
--a matrix times the activations. 00:13:01,800 --> 00:13:03,640
矩阵乘以激活。
--We can have a layer that computes a nonlinear activation. 00:13:03,640 --> 00:13:06,680
我们可以有一个计算非线性激活的层。
--But we can do whatever we want in layers, right? 00:13:06,680 --> 00:13:09,160
但是我们可以分层做任何我们想做的事情，对吧？
--Layers are just differentiable functions 00:13:09,160 --> 00:13:10,920
层只是可微函数
--that we plug in and use in our deep network library. 00:13:10,920 --> 00:13:16,200
我们插入并在我们的深度网络库中使用。
--And so the key idea is that these problems 00:13:16,200 --> 00:13:19,600
所以关键的想法是这些问题
--of sort of the weights of activations varying 00:13:19,600 --> 00:13:22,760
不同的激活权重
--over the course of the depth of a network, 00:13:22,760 --> 00:13:25,440
在网络深度的过程中，
--we could add a layer in some sense that just kind of fixes this, right? 00:13:25,440 --> 00:13:32,440
我们可以在某种意义上添加一个层来解决这个问题，对吧？
--There's nothing preventing us from building a layer. 00:13:32,440 --> 00:13:34,600
没有什么能阻止我们构建一个层。
--If we believe that the norm of the layers kind of changing over time 00:13:34,600 --> 00:13:39,960
如果我们相信层的规范会随着时间而改变
--due to bad initialization is a problem, 00:13:39,960 --> 00:13:43,240
由于初始化错误是一个问题，
--let's just go ahead and add a layer that kind of fixes this. 00:13:43,240 --> 00:13:46,000
让我们继续添加一个层来解决这个问题。
--And this is the key idea of normalization layers. 00:13:46,000 --> 00:13:50,640
这就是规范化层的关键思想。
--So what we're going to do in the first instance of a normalization layer, 00:13:50,640 --> 00:13:55,280
所以我们要在规范化层的第一个实例中做的，
--this is a technique called layer normalization or just layer norm, 00:13:55,280 --> 00:14:00,040
这是一种称为层规范化或层规范的技术，
--is kind of to do the obvious thing. 00:14:00,040 --> 00:14:02,440
是一种做显而易见的事情。
--Let's just take our activations at each layer 00:14:02,440 --> 00:14:06,640
让我们在每一层进行激活
--and let's just normalize them to have some standardized mean 00:14:06,640 --> 00:14:10,480
让我们将它们归一化以获得一些标准化的平均值
--and some standardized variance. 00:14:10,480 --> 00:14:12,640
和一些标准化方差。
--It's a very natural idea 00:14:12,720 --> 00:14:16,040
这是一个很自然的想法
--because this will then prevent them from having this bad effects 00:14:16,040 --> 00:14:22,200
因为这会阻止他们产生这种不良影响
--kind of as we go through the later layers of a network. 00:14:22,200 --> 00:14:27,480
有点像我们通过网络的后几层。
--So the way I'm going to write this is I'm going to write this 00:14:27,480 --> 00:14:29,400
所以我要写这个的方式是我要写这个
--as we have sort of our initial potential activation here. 00:14:29,400 --> 00:14:34,960
因为我们在这里有一些最初的潜在激活。
--I'm going to write Z hat here as sort of just for convention, 00:14:34,960 --> 00:14:39,280
我打算在这里写 Z 帽子只是为了约定俗成，
--I'm going to write Z hat here as kind of our tentative layer before normalization. 00:14:39,280 --> 00:14:44,680
我将在这里写下 Z 帽子作为规范化之前的暂定层。
--So that's going to be just equal to our nonlinearity in this case 00:14:44,680 --> 00:14:47,520
所以在这种情况下，这将等于我们的非线性
--times a linear function of our previous layer plus a bias term. 00:14:47,520 --> 00:14:54,880
乘以我们前一层的线性函数加上偏置项。
--So this is just our simple sort of fully connected layer here. 00:14:54,880 --> 00:14:59,720
所以这只是我们这里简单的全连接层。
--We could, of course, also have some more structure in this layer, 00:14:59,720 --> 00:15:03,200
当然，我们也可以在这一层有更多的结构，
--but we won't worry about that. 00:15:03,200 --> 00:15:04,760
但我们不会为此担心。
--Similar things apply, of course, no matter what the structure of the network is. 00:15:04,760 --> 00:15:08,600
当然，无论网络结构如何，类似的事情都适用。
--So the simplest thing we can do in some case is just take this layer 00:15:08,600 --> 00:15:13,600
所以在某些情况下我们能做的最简单的事情就是把这一层
--and ensure that it has some standardized mean and variance. 00:15:13,600 --> 00:15:17,480
并确保它具有一些标准化的均值和方差。
--And so let's just choose to, you know, 00:15:17,480 --> 00:15:19,920
所以让我们选择，你知道的，
--in our argument before we wanted to choose our initialization 00:15:19,920 --> 00:15:23,880
在我们想要选择初始化之前的争论中
--such that the activations had mean zero and variance one. 00:15:23,880 --> 00:15:27,440
这样激活的均值为零，方差为一。
--So rather than worrying too much about initialization, 00:15:27,440 --> 00:15:29,720
所以与其过分担心初始化，
--let's just actually enforce our layer to have mean zero and variance one. 00:15:29,720 --> 00:15:35,200
让我们实际强制我们的层具有均值零和方差一。
--And the way we're going to do that 00:15:35,200 --> 00:15:36,280
以及我们将要这样做的方式
--is we're going to set our next actual layer 00:15:36,280 --> 00:15:39,720
我们要设置下一个实际图层吗
--just be equal to Z hat i plus one minus its expectation. 00:15:39,720 --> 00:15:46,120
等于 Z hat i 加一减去它的期望值。
--So minus the expectation, sorry, the expected value of Z i plus one. 00:15:46,120 --> 00:15:51,960
所以减去期望，抱歉，Z i 的期望值加一。
--We're here, the expected value, and also the variance. 00:15:51,960 --> 00:15:54,320
我们在这里，期望值，还有方差。
--This is just an empirical expected value. 00:15:54,320 --> 00:15:56,760
这只是一个经验预期值。
--Remember, this is a vector here. 00:15:56,760 --> 00:15:59,680
请记住，这是一个向量。
--So this would just be equal to, say, there are n elements in this vector. 00:15:59,680 --> 00:16:04,400
所以这就等于，比方说，这个向量中有 n 个元素。
--This would be equal to one over n times the sum from i. 00:16:04,400 --> 00:16:08,120
这将等于 i 的总和的 n 分之一。
--Well, I shouldn't use i there because I have the other i index. 00:16:08,120 --> 00:16:10,760
好吧，我不应该在那里使用 i 因为我有另一个 i 索引。
--The sum from j equals one to n of Z hat i plus one. 00:16:10,760 --> 00:16:19,040
 j 的总和等于 Z 的 n 加一。
--And I'm going to use this notation here to say like the jth element of this vector. 00:16:19,040 --> 00:16:24,880
我将在这里使用这个符号来表示这个向量的第 j 个元素。
--Remember, Z i plus one is itself a vector. 00:16:24,880 --> 00:16:29,920
请记住，Z i 加一本身就是一个向量。
--So we have this kind of a bit odd notation of having two subscripts, right? 00:16:29,920 --> 00:16:35,800
所以我们有这种有两个下标的有点奇怪的符号，对吧？
--i plus one indicates the layer it is, which I'm doing just for convention. 00:16:35,800 --> 00:16:39,160
 i 加一表示它所在的层，我这样做只是为了约定。
--We usually use these i's to refer to layers. 00:16:39,160 --> 00:16:42,040
我们通常使用这些 i 来指代层。
--So if I wanted to refer to the jth element of that vector, 00:16:42,040 --> 00:16:44,360
因此，如果我想引用该向量的第 j 个元素，
--I'm going to use this notation here of putting parentheses around it 00:16:44,360 --> 00:16:49,200
我将在这里使用这个符号来在它周围加上括号
--and then also using a separate subscript there. 00:16:49,200 --> 00:16:51,000
然后还在那里使用单独的下标。
--So this is just going to be the empirical expected value. 00:16:51,120 --> 00:17:00,440
所以这只是经验预期值。
--Then my layer norm term would take this whole thing 00:17:00,440 --> 00:17:04,240
然后我的层范数项将把这整个事情
--and divide it by the standard deviation of this vector. 00:17:04,240 --> 00:17:09,080
并将其除以该向量的标准偏差。
--So I'm going to write that actually as the square root of the variance of Z hat i, 00:17:09,080 --> 00:17:17,160
所以我要把它写成 Z hat i 的方差的平方根，
--where again, this is just the empirical variance. 00:17:17,160 --> 00:17:18,840
同样，这只是经验方差。
--This would just be equal to the variance of Z hat i plus one, 00:17:18,840 --> 00:17:25,200
这将等于 Z 帽子 i 加一的方差，
--which would just be equal to one over n of the sum from j equals one to n 00:17:25,200 --> 00:17:31,360
这将等于 j 等于 1 到 n 的总和的 n 分之一
--of Z hat i plus one j minus the value of Z hat i plus one. 00:17:31,360 --> 00:17:43,480
Z hat i 加 1 j 减去 Z hat i 加 1 的值。
--We're not going to worry this is a biased or unbiased estimate or things like that 00:17:43,480 --> 00:17:46,960
我们不会担心这是一个有偏见或无偏见的估计或类似的事情
--if it's value of this thing is squared. 00:17:47,040 --> 00:17:48,560
如果这个东西的价值是平方的。
--Okay, so then to normalize a vector, 00:17:49,840 --> 00:17:53,080
好的，那么要规范化一个向量，
--you normalize it by the square root of its variance to make it equal to one. 00:17:53,080 --> 00:17:57,880
您通过方差的平方根对其进行归一化，使其等于 1。
--And so we're just going to do that. 00:17:57,880 --> 00:17:58,760
因此，我们将这样做。
--Now, one last thing that I'll mention is that there is a chance that, say, 00:17:58,760 --> 00:18:06,760
现在，我要提到的最后一件事是，有可能，比如说，
--if you happen to be in this unlucky situation where you've applied a relu, say, to your vector, 00:18:06,760 --> 00:18:13,480
如果你碰巧遇到这种不幸的情况，比如你对你的向量应用了 relu，
--what if all the values of this term here are zero, right? 00:18:13,480 --> 00:18:18,760
如果这一项的所有值都为零怎么办，对吗？
--What if all the values of the inner term just happen, for some example, 00:18:18,760 --> 00:18:21,320
如果内项的所有值都发生了，例如，
--for some example to be negative? 00:18:21,320 --> 00:18:23,720
举个例子是否定的？
--And so if these things are all zero, you would actually be dividing by zero. 00:18:23,720 --> 00:18:27,160
所以如果这些东西都是零，你实际上会被零除。
--So a very common thing to do then is just to add a little small epsilon, 00:18:27,160 --> 00:18:31,160
所以一个很常见的事情就是添加一个小的 epsilon，
--where epsilon is something like, you know, say, it's something like 00:18:31,160 --> 00:18:35,400
其中 epsilon 类似于，你知道，比如说，它类似于
--ten to negative five or something. 00:18:40,200 --> 00:18:41,480
十到负五之类的。
--All that matters is that you make it some small constant 00:18:42,120 --> 00:18:44,760
重要的是你让它成为一个小常数
--such that you don't get numerical underflow. 00:18:44,760 --> 00:18:47,080
这样你就不会得到数字下溢。
--And you divide actually by the variance plus epsilon square root, 00:18:47,880 --> 00:18:52,120
你实际上除以方差加上 epsilon 平方根，
--and you divide by that thing, because that thing will now always be positive. 00:18:52,120 --> 00:18:54,280
然后除以那个东西，因为那个东西现在总是正的。
--Okay, and that's the idea. 00:18:55,640 --> 00:18:57,240
好的，就是这个主意。
--That's it. 00:18:57,240 --> 00:18:57,640
就是这样。
--We've just forced our layers to be equal to, 00:18:58,440 --> 00:19:03,240
我们只是强制我们的图层等于，
--essentially, have the same norm at each layer. 00:19:04,680 --> 00:19:08,840
本质上，每一层都有相同的范数。
--And this does, in fact, fix the problem we had in the previous slide. 00:19:09,640 --> 00:19:14,840
事实上，这确实解决了我们在上一张幻灯片中遇到的问题。
--So what I'm doing again here is showing you a similar initialization 00:19:15,400 --> 00:19:18,920
所以我在这里再次做的是向您展示类似的初始化
--where we initialize with variance 1 over n, 2 over n, and 3 over n. 00:19:18,920 --> 00:19:23,800
其中我们用 n 上的方差 1、n 上的 2 和 n 上的 3 进行初始化。
--And what we see here is that you get roughly the same 00:19:24,360 --> 00:19:27,400
我们在这里看到的是你得到的大致相同
--weight at each layer of this network. 00:19:29,160 --> 00:19:31,880
该网络每一层的权重。
--There's some slight variation here. 00:19:31,880 --> 00:19:33,400
这里有一些细微的变化。
--Don't worry about that too much. 00:19:33,400 --> 00:19:34,360
别太担心了。
--That's just because you're applying things like relu's also. 00:19:34,360 --> 00:19:37,160
那只是因为你也在应用像 relu 这样的东西。
--And also the first layer here is a larger size for MNIST, 00:19:37,160 --> 00:19:40,520
而且这里的第一层对于 MNIST 来说是一个更大的尺寸，
--so it has a bit of a difference there in its activation norm. 00:19:40,520 --> 00:19:43,960
所以它的激活规范有点不同。
--But this is essentially what you're doing here. 00:19:44,840 --> 00:19:47,080
但这基本上就是您在这里所做的。
--You are just normalizing each layer, 00:19:47,720 --> 00:19:50,360
你只是规范化每一层，
--and that problem of exploding or going to zero kind of activations is solved. 00:19:50,360 --> 00:19:55,880
并且解决了爆炸或趋向于零类型激活的问题。
--These activations stay all around kind of the same rough value here. 00:19:55,880 --> 00:19:59,800
这些激活在这里保持大致相同的粗略值。
--The gradients are also very similar across different initializations. 00:20:01,160 --> 00:20:05,240
不同初始化的梯度也非常相似。
--So we fix the problem of having a gradient that depends on the initialization a lot. 00:20:05,240 --> 00:20:10,520
所以我们解决了梯度很大程度上依赖于初始化的问题。
--Kind of oddly enough, there's more variability to the gradients. 00:20:10,520 --> 00:20:14,520
有点奇怪的是，梯度有更多的可变性。
--If you remember a few slides back, 00:20:14,520 --> 00:20:15,640
如果你还记得几张幻灯片，
--we had very similar gradients all the way through. 00:20:17,080 --> 00:20:19,160
我们一直都有非常相似的梯度。
--Because you're introducing additional terms into the gradient here, 00:20:20,520 --> 00:20:26,280
因为你在这里向渐变中引入了额外的项，
--into the backward pass, 00:20:26,280 --> 00:20:27,080
进入后传，
--you actually have to give up that property a little bit. 00:20:27,080 --> 00:20:30,280
您实际上必须稍微放弃该属性。
--But the gradients aren't blowing up here, right? 00:20:30,920 --> 00:20:32,920
但是梯度并没有在这里爆炸，对吧？
--This is not that large a difference, arguably. 00:20:33,240 --> 00:20:35,960
可以说，这并没有那么大的区别。
--And under some inches, it's not that large a difference. 00:20:35,960 --> 00:20:38,520
在几英寸以下，差别并不大。
--And they're all the same, roughly the same, regardless of the initialization. 00:20:39,720 --> 00:20:44,200
而且它们都是一样的，大致相同，不管初始化如何。
--Okay, so that's just an illustration of layer norm here. 00:20:45,560 --> 00:20:49,080
好的，这只是层范数的说明。
--But there is a problem. 00:20:49,080 --> 00:20:49,960
但有一个问题。
--And actually, well, before I go into some of the potential problems, 00:20:50,520 --> 00:20:54,840
实际上，嗯，在我讨论一些潜在问题之前，
--I should say the layer norm is very widely used. 00:20:54,840 --> 00:20:56,760
我应该说层规范使用非常广泛。
--So for example, transformer architectures, which we'll cover in later classes, 00:20:56,760 --> 00:21:00,440
例如，我们将在后面的课程中介绍的转换器架构，
--which are in some sense the dominant architecture 00:21:00,440 --> 00:21:02,360
从某种意义上说，它们是主导架构
--in a lot of deep learning these days, 00:21:02,360 --> 00:21:03,880
这些天在很多深度学习中，
--they widely use layer norm as their normalization technique. 00:21:03,880 --> 00:21:07,320
他们广泛使用层规范作为规范化技术。
--And so the simple approach is extremely common in modern deep learning. 00:21:08,040 --> 00:21:15,160
因此，简单的方法在现代深度学习中极为普遍。
--And it does, in fact, prevent these big blowups in activations happening. 00:21:15,160 --> 00:21:20,440
事实上，它确实可以防止这些大的激活事件发生。
--And in some sense, it's sort of the easy fix, right? 00:21:20,440 --> 00:21:22,920
从某种意义上说，这很容易解决，对吧？
--You have to worry much less about initialization 00:21:22,920 --> 00:21:25,160
您不必担心初始化
--if you do things like this. 00:21:25,160 --> 00:21:27,480
如果你这样做。
--Now, at the same time, I should also mention that 00:21:27,480 --> 00:21:29,240
现在，与此同时，我还应该提到
--for standard fully connected networks, 00:21:29,240 --> 00:21:31,160
对于标准的全连接网络，
--it is often harder to train networks to low loss when you add layer norm. 00:21:31,160 --> 00:21:37,240
当你添加层范数时，通常更难将网络训练到低损失。
--And there's a few reasons for this. 00:21:38,040 --> 00:21:41,000
这有几个原因。
--One of the reasons, it's hard to say exactly the reasons, 00:21:42,120 --> 00:21:45,560
其中一个原因，很难说到底是什么原因，
--a lot of these things are, and I'll get to this later in this lecture, 00:21:45,560 --> 00:21:48,600
很多这样的事情，我将在本次讲座的稍后部分谈到这一点，
--are not fully understood. 00:21:48,600 --> 00:21:49,880
没有被完全理解。
--But one of the reasons here is that 00:21:49,880 --> 00:21:51,480
但这里的原因之一是
--layer norm is taking each individual example 00:21:53,400 --> 00:21:56,120
层规范正在以每个单独的例子为例
--and forcing its norm of the activations, 00:21:56,120 --> 00:21:59,400
并强制执行其激活规范，
--including, say, the last layer, 00:21:59,400 --> 00:22:01,000
包括，比方说，最后一层，
--to be equal to zero, 00:22:01,000 --> 00:22:03,000
等于零，
--or the mean of that activation is equal to zero 00:22:03,000 --> 00:22:07,560
或者该激活的均值等于零
--and the standard deviation of activation is equal to one, right? 00:22:07,560 --> 00:22:10,440
激活的标准差等于一，对吧？
--And it might be that, in fact, 00:22:10,440 --> 00:22:13,400
事实上，这可能是
--the relative norms of the different examples, 00:22:13,400 --> 00:22:16,520
不同例子的相对规范，
--say, you know, a digit of a one versus a digit of a zero, 00:22:16,520 --> 00:22:19,480
比方说，你知道，1 的数字与 0 的数字，
--maybe the relative norms and their variances 00:22:20,200 --> 00:22:23,640
也许是相对规范及其方差
--are actually a pretty good feature to classify things, right? 00:22:23,640 --> 00:22:26,920
实际上是一个很好的分类功能，对吧？
--It's very possible that the relative sizes 00:22:26,920 --> 00:22:29,720
相对大小很有可能
--may include some information 00:22:30,600 --> 00:22:31,880
可能包含一些信息
--that we want to actually keep and preserve. 00:22:31,880 --> 00:22:33,720
我们想要实际保留和保存。
--And that's just honestly one reason 00:22:33,720 --> 00:22:36,360
老实说，这只是一个原因
--why these networks can be hard to train. 00:22:36,360 --> 00:22:38,840
为什么这些网络很难训练。
--There are many reasons why they might be hard to train. 00:22:39,480 --> 00:22:41,800
他们可能难以训练的原因有很多。
--But what's been found in practice, 00:22:41,800 --> 00:22:44,520
但在实践中发现，
--at least for just a fully connected MLP, 00:22:44,520 --> 00:22:48,600
至少对于一个完全连接的 MLP，
--it's often harder to train these networks 00:22:49,160 --> 00:22:52,920
训练这些网络通常更难
--when you introduce layer norm in them 00:22:53,000 --> 00:22:55,080
当你在其中引入层范数时
--than it is without layer norm. 00:22:55,080 --> 00:22:57,080
比没有层规范。
--So we're sort of, you know, 00:22:57,080 --> 00:22:58,680
所以我们有点，你知道，
--maybe not quite getting everything that we want out of this. 00:22:58,680 --> 00:23:02,680
也许没有得到我们想要的一切。
--And so because of this, 00:23:04,600 --> 00:23:07,880
正因为如此，
--we're actually going to introduce 00:23:07,880 --> 00:23:08,840
我们实际上要介绍
--a different kind of normalization, 00:23:08,840 --> 00:23:10,440
一种不同的规范化，
--which is also useful in many scenarios here, 00:23:10,440 --> 00:23:13,000
这在这里的许多场景中也很有用，
--which seems like an odd idea. 00:23:13,880 --> 00:23:15,720
这似乎是一个奇怪的想法。
--And so I want to emphasize before I start here 00:23:15,720 --> 00:23:18,760
所以我想在开始之前强调一下
--that this seems like a very odd thing to do. 00:23:18,760 --> 00:23:21,160
这似乎是一件非常奇怪的事情。
--But hopefully it will sort of make some amount of sense 00:23:22,120 --> 00:23:25,560
但希望它会有点意义
--the way I'm describing it here. 00:23:25,560 --> 00:23:26,600
我在这里描述的方式。
--So let's consider, 00:23:27,640 --> 00:23:29,480
所以让我们考虑一下，
--so before we were considering, 00:23:29,480 --> 00:23:30,920
所以在我们考虑之前
--when I defined the equation for layer norm, 00:23:30,920 --> 00:23:32,520
当我定义层范数的方程式时，
--I was considering kind of a independent mean 00:23:32,520 --> 00:23:36,760
我正在考虑一种独立的方式
--or an independent normalization 00:23:36,760 --> 00:23:38,280
或独立归一化
--that I would apply to each layer of a single, 00:23:38,280 --> 00:23:43,880
我将应用于单个图层的每一层，
--of a single sort of, 00:23:43,880 --> 00:23:45,000
属于一种，
--of the network applied to a single example, right? 00:23:46,280 --> 00:23:48,520
网络应用于单个示例，对吗？
--So I would take, you know, a single input example, 00:23:48,520 --> 00:23:51,000
所以我会举一个单一输入的例子，
--look at its activations throughout the network, 00:23:51,000 --> 00:23:53,000
查看它在整个网络中的激活情况，
--and I would normalize each of these activations. 00:23:53,000 --> 00:23:55,240
我会规范化这些激活中的每一个。
--But let's consider now the matrix form of our updates. 00:23:56,040 --> 00:23:58,920
但是现在让我们考虑更新的矩阵形式。
--So remember, we wrote it like this, 00:23:58,920 --> 00:24:00,360
所以请记住，我们是这样写的，
--where we have a whole matrix now, 00:24:00,360 --> 00:24:02,360
我们现在有一个完整的矩阵，
--or say, in this case, 00:24:02,360 --> 00:24:05,800
或者说，在这种情况下，
--probably all the examples in a mini-batch, right? 00:24:05,800 --> 00:24:07,880
可能是小批量中的所有示例，对吗？
--So Z, the capital Z in its rows 00:24:07,880 --> 00:24:11,800
所以 Z，其行中的大写字母 Z
--contains the examples of each, 00:24:11,800 --> 00:24:13,800
包含每个示例，
--many examples corresponding to all the examples 00:24:15,240 --> 00:24:17,880
许多示例对应于所有示例
--in that mini-batch. 00:24:17,880 --> 00:24:18,600
在那个小批量中。
--And so in this setting, 00:24:19,400 --> 00:24:21,400
所以在这种情况下，
--so if we sort of define Z in matrix form, 00:24:21,400 --> 00:24:24,600
所以如果我们以矩阵形式定义 Z，
--like we do anyway when we run these things, 00:24:25,240 --> 00:24:27,480
就像我们在运行这些东西时所做的那样，
--then layer norm corresponds to taking a single example, 00:24:28,200 --> 00:24:32,200
那么layer norm对应于取一个例子，
--which are the rows of this matrix, 00:24:32,200 --> 00:24:34,440
这是这个矩阵的行，
--and normalizing the rows, right? 00:24:34,440 --> 00:24:37,400
并规范化行，对吧？
--But viewed as a matrix, 00:24:39,160 --> 00:24:40,840
但作为一个矩阵来看，
--there are many different ways 00:24:41,640 --> 00:24:43,160
有很多不同的方法
--that we could actually kind of get standardization 00:24:43,160 --> 00:24:46,120
我们实际上可以得到标准化
--across these features. 00:24:46,120 --> 00:24:49,240
跨这些功能。
--And in fact, if you kind of do think about 00:24:49,240 --> 00:24:53,800
事实上，如果你确实想过
--sort of standard normalization of features 00:24:53,800 --> 00:24:57,160
某种标准的特征标准化
--for a lot of kind of 00:24:57,160 --> 00:24:59,880
对于很多种类
--standard machine learning algorithms, 00:24:59,880 --> 00:25:01,160
标准机器学习算法，
--an equally common thing to do is to normalize 00:25:02,440 --> 00:25:04,680
同样常见的事情是规范化
--not just the sort of the each row of an entry, 00:25:04,680 --> 00:25:10,120
不仅仅是条目每一行的排序，
--but it's also very common to actually normalize 00:25:10,120 --> 00:25:12,440
但实际上规范化也很常见
--the columns of these things too. 00:25:12,440 --> 00:25:14,760
列的这些东西太多了。
--So what if instead of normalizing the rows, 00:25:15,320 --> 00:25:19,720
那么，如果不是规范化行，
--we normalize the columns instead? 00:25:20,280 --> 00:25:22,120
我们改为规范化列？
--So we actually do something that seems kind of odd, 00:25:22,760 --> 00:25:24,600
所以我们实际上做了一些看起来有点奇怪的事情，
--but we normalize kind of, 00:25:24,600 --> 00:25:25,800
但我们标准化了，
--think of the each sort of column of this vector 00:25:26,360 --> 00:25:30,040
想想这个向量的每一列
--as sort of a single activation, 00:25:30,040 --> 00:25:31,640
作为一种单一的激活，
--kind of like a single feature. 00:25:31,640 --> 00:25:33,080
有点像一个单一的功能。
--What if we just normalize those values 00:25:33,080 --> 00:25:35,800
如果我们只是将这些值标准化怎么办
--across the whole mini-batch? 00:25:35,800 --> 00:25:37,160
在整个小批量？
--This is a technique called batch normalization. 00:25:39,000 --> 00:25:41,880
这是一种称为批量归一化的技术。
--And it is also extremely common 00:25:42,520 --> 00:25:46,120
而且也很常见
--to use in practice in deep networks 00:25:46,120 --> 00:25:48,120
在深度网络中实际使用
--and also provides in many cases a huge benefit 00:25:48,120 --> 00:25:51,560
并且在许多情况下还提供了巨大的好处
--for the trainability of these networks. 00:25:51,560 --> 00:25:53,320
为了这些网络的可训练性。
--And again, I want to emphasize here 00:25:55,480 --> 00:25:58,280
再一次，我想在这里强调
--that there's sort of a lot of ways 00:25:58,280 --> 00:25:59,640
有很多方法
--of motivating what we're doing here. 00:25:59,640 --> 00:26:01,000
激励我们在这里所做的事情。
--But in some level, all we are doing 00:26:01,800 --> 00:26:04,040
但在某种程度上，我们所做的一切
--is we are just trying to ensure 00:26:04,040 --> 00:26:05,800
我们只是想确保
--that the activations of our network 00:26:05,800 --> 00:26:08,760
我们网络的激活
--don't blow up as we go deeper and deeper into the network. 00:26:08,760 --> 00:26:11,400
当我们越来越深入网络时，不要爆炸。
--That we've maintained some kind of control over them. 00:26:12,120 --> 00:26:14,200
我们对它们保持某种控制。
--And we can just as easily normalize over the row, 00:26:14,200 --> 00:26:16,920
我们可以很容易地对行进行归一化，
--the rows to do this as normalize the columns over this. 00:26:16,920 --> 00:26:19,720
执行此操作的行将其上的列标准化。
--But this form normalizing over the columns here, 00:26:19,720 --> 00:26:23,000
但是这种形式对这里的列进行归一化，
--you know, maintains the fact that different rows, 00:26:23,000 --> 00:26:25,960
你知道，保持不同行的事实，
--different examples could have different norms 00:26:25,960 --> 00:26:28,440
不同的例子可能有不同的规范
--and different sort of values, 00:26:28,440 --> 00:26:31,400
和不同类型的价值观，
--sizes of their activations as you go deeper network. 00:26:31,400 --> 00:26:33,560
当你进入更深的网络时，它们的激活大小。
--That might be a useful discriminative feature. 00:26:33,560 --> 00:26:35,320
这可能是一个有用的判别特征。
--And so this preserves that 00:26:35,320 --> 00:26:36,440
所以这保留了
--while still preserving some degree of normalization 00:26:36,440 --> 00:26:38,360
同时仍保留一定程度的标准化
--of your layers. 00:26:38,840 --> 00:26:41,320
你的层次。
--And as I said, there's a sort of an obvious analog here 00:26:42,840 --> 00:26:45,880
正如我所说，这里有一种明显的类比
--to what we often do to prepare data 00:26:45,880 --> 00:26:49,640
我们经常做的准备数据
--for use in kind of classical machine learning methods. 00:26:49,640 --> 00:26:52,440
用于经典机器学习方法。
--Oftentimes we will normalize the features, 00:26:52,440 --> 00:26:54,520
通常我们会将特征归一化，
--normalize the columns of our data matrix. 00:26:54,520 --> 00:26:57,480
规范化我们的数据矩阵的列。
--And this sort of takes that to the extreme 00:26:57,480 --> 00:26:59,480
而这种将其发挥到极致
--where we're doing that for each layer in our network 00:26:59,480 --> 00:27:03,320
我们对网络中的每一层都这样做
--for each mini batch of our example. 00:27:03,320 --> 00:27:05,720
对于我们示例的每个小批量。
--And this is a technique called batch norm. 00:27:05,720 --> 00:27:07,080
这是一种称为批量归一化的技术。
--And so this people, this is very, very common. 00:27:08,760 --> 00:27:10,520
所以这个人，这是非常非常普遍的。
--People often do this. 00:27:10,520 --> 00:27:12,120
人们经常这样做。
--And if you've played with the networks at all, 00:27:12,120 --> 00:27:14,520
如果你玩过网络，
--you've likely seen networks 00:27:14,520 --> 00:27:15,560
你可能见过网络
--that use batch norm of some kind. 00:27:15,560 --> 00:27:16,920
使用某种批规范。
--But I will add, and this fixes the problem too. 00:27:18,680 --> 00:27:21,560
但我会补充，这也解决了问题。
--I won't show too many plots here, 00:27:21,560 --> 00:27:23,320
我不会在这里展示太多情节，
--but it does fix the problem 00:27:23,320 --> 00:27:24,440
但它确实解决了问题
--just like layer norm does of course, 00:27:24,440 --> 00:27:25,960
当然，就像层规范一样，
--by definition, it fixes the problem. 00:27:25,960 --> 00:27:27,320
根据定义，它解决了问题。
--But what I actually want to focus on here 00:27:28,360 --> 00:27:30,040
但我真正想在这里关注的是
--is an additional aspect to batch norm 00:27:30,040 --> 00:27:34,520
是批量规范的一个附加方面
--that is very common 00:27:34,520 --> 00:27:35,640
那很常见
--to fix an odd problem in batch norm. 00:27:36,440 --> 00:27:40,040
修复批量规范中的一个奇怪问题。
--So one thing that is kind of strange 00:27:40,040 --> 00:27:42,680
所以有一件事有点奇怪
--when you normalize like we did here by column, 00:27:42,680 --> 00:27:47,880
当你像我们在这里做的那样按列归一化时，
--you are making the total predictions of your network 00:27:50,040 --> 00:27:54,920
您正在对您的网络进行总体预测
--in some sense depend on the mini batch, right? 00:27:55,640 --> 00:27:58,440
在某种意义上取决于小批量，对吗？
--So with layer norm, you're applying your functions 00:27:59,400 --> 00:28:03,000
所以使用层规范，你正在应用你的功能
--just to each example in your batch. 00:28:03,000 --> 00:28:06,440
仅针对您批次中的每个示例。
--And so, or sorry, 00:28:06,440 --> 00:28:07,320
所以，或者抱歉，
--you're applying to each example period, right? 00:28:07,320 --> 00:28:09,720
您正在申请每个示例期，对吗？
--So you can apply this function to one example, 00:28:09,720 --> 00:28:12,520
所以你可以将这个函数应用到一个例子中，
--the next example in your batch. 00:28:12,520 --> 00:28:13,400
您批次中的下一个示例。
--And it's the same regardless of what examples 00:28:13,400 --> 00:28:15,880
不管是什么例子都是一样的
--you pick in your batch. 00:28:15,880 --> 00:28:18,040
你在你的批次中挑选。
--But the oddity about batch norm 00:28:18,040 --> 00:28:20,600
但是批规范的奇怪之处
--is that normalizing your activations by the batch 00:28:20,600 --> 00:28:25,720
是按批标准化你的激活
--actually introduces a dependency. 00:28:25,720 --> 00:28:27,240
实际上引入了依赖关系。
--And you can just think of this 00:28:27,240 --> 00:28:27,880
你可以想到这个
--in terms of computational graph, right? 00:28:27,880 --> 00:28:29,720
在计算图方面，对吧？
--It introduces a dependency 00:28:29,720 --> 00:28:31,080
它引入了一个依赖
--between all the examples in the batch. 00:28:31,720 --> 00:28:35,880
在批次中的所有示例之间。
--In other words, my predictions on this example here, 00:28:37,080 --> 00:28:40,840
换句话说，我在这里对这个例子的预测，
--sort of the example number one, 00:28:40,840 --> 00:28:43,320
第一个例子，
--whatever I output in that example 00:28:43,320 --> 00:28:45,480
无论我在那个例子中输出什么
--will actually through this mechanism 00:28:46,360 --> 00:28:48,440
实际上会通过这个机制
--depend on my predictions 00:28:48,440 --> 00:28:50,680
取决于我的预测
--or what the example was in the second row, right? 00:28:50,680 --> 00:28:54,200
或者第二行的例子是什么，对吧？
--So this example here depends on this example here. 00:28:54,200 --> 00:28:57,720
所以这里的这个例子依赖于这里的这个例子。
--And that's very strange, right? 00:28:57,720 --> 00:28:58,840
这很奇怪，对吧？
--You don't want a network 00:28:59,640 --> 00:29:00,680
你不需要网络
--where the output of the network 00:29:00,680 --> 00:29:02,600
网络的输出在哪里
--depends on other examples 00:29:03,240 --> 00:29:05,800
取决于其他例子
--besides the one you're actually classifying, right? 00:29:05,800 --> 00:29:07,960
除了你实际分类的那个，对吧？
--That would be very odd. 00:29:07,960 --> 00:29:09,400
那将是非常奇怪的。
--Maybe it's not that odd, to be honest. 00:29:09,400 --> 00:29:11,320
老实说，也许这并不奇怪。
--Maybe we actually want to adopt that, 00:29:11,320 --> 00:29:13,080
也许我们真的想采用它，
--but at least naively speaking, 00:29:13,080 --> 00:29:13,960
但至少天真地说，
--this is a very odd effect. 00:29:13,960 --> 00:29:15,400
这是一个非常奇怪的效果。
--And so what's commonly done in batch norm 00:29:15,400 --> 00:29:17,160
那么批量规范中通常会做什么
--is when you apply batch norm at test time, 00:29:17,160 --> 00:29:23,880
是当您在测试时应用批量规范时，
--you train normalizing by these batches here. 00:29:24,520 --> 00:29:27,800
你在这里训练这些批次的归一化。
--But when you actually apply batch norm at test time, 00:29:27,800 --> 00:29:29,960
但是当你在测试时实际应用 batch norm 时，
--you don't use the actual norm of the batch. 00:29:30,520 --> 00:29:35,560
您不使用批次的实际标准。
--You don't use the batch statistics 00:29:35,560 --> 00:29:37,000
您不使用批处理统计信息
--to normalize your example. 00:29:37,000 --> 00:29:38,360
规范化你的例子。
--You use computed averages 00:29:38,360 --> 00:29:41,960
您使用计算平均值
--of the mean and variance you've seen 00:29:41,960 --> 00:29:43,960
你见过的均值和方差
--over kind of all your examples so far 00:29:43,960 --> 00:29:46,200
到目前为止你所有的例子
--to actually compute that. 00:29:47,080 --> 00:29:48,600
实际计算。
--And so what happens here 00:29:49,560 --> 00:29:51,160
所以这里发生了什么
--is you sort of form these empirical, 00:29:51,160 --> 00:29:55,080
你是不是形成了这些经验，
--what we call kind of empirical running means 00:29:55,080 --> 00:29:57,480
我们所说的那种经验运行方式
--or running averages. 00:29:57,800 --> 00:29:58,840
或运行平均值。
--I shouldn't use the word mean 00:29:58,840 --> 00:29:59,720
我不应该用卑鄙这个词
--because mean implies kind of, 00:29:59,720 --> 00:30:00,840
因为意思意味着某种，
--it's the mean term here, 00:30:00,840 --> 00:30:01,960
这里的意思是
--but running averages of these mean and variance terms, right? 00:30:01,960 --> 00:30:07,400
但是这些均值和方差项的运行平均值，对吗？
--And so what I mean by that is 00:30:07,400 --> 00:30:08,840
所以我的意思是
--you'll form sort of one of these mu hat terms. 00:30:08,840 --> 00:30:13,000
你会形成这些 mu hat 术语之一。
--And here mu hat, for example, 00:30:13,000 --> 00:30:14,600
以这里的 mu hat 为例，
--could be just something like as I'm going, 00:30:14,600 --> 00:30:17,400
可能就像我要去的那样，
--my mu hat i plus one variable 00:30:18,280 --> 00:30:21,160
我的 mu hat i 加一个变量
--would equal some sort of term beta times my old. 00:30:21,160 --> 00:30:25,800
等于某种术语 beta 乘以我的旧数。
--It's like this notation of like setting it equal to 00:30:26,680 --> 00:30:28,840
就像把它设置为等于这样的表示法
--as I'm running my network here. 00:30:28,840 --> 00:30:32,760
因为我在这里运行我的网络。
--It'd be equal to sort of the old estimate of my mean 00:30:32,760 --> 00:30:35,960
它等于我的平均值的旧估计
--plus something like one minus beta 00:30:35,960 --> 00:30:37,960
再加上一减贝塔之类的东西
--times my actual expectation 00:30:38,520 --> 00:30:41,400
乘以我的实际期望
--of say the z hat i plus one, right? 00:30:41,400 --> 00:30:43,240
说 z 帽子我加一，对吗？
--So this is sort of like momentum kind of running. 00:30:43,240 --> 00:30:45,800
所以这有点像动量跑步。
--What they actually technically are 00:30:46,840 --> 00:30:47,960
他们在技术上实际上是什么
--is exponential moving average estimates, 00:30:47,960 --> 00:30:49,720
是指数移动平均估计，
--but they are kind of running estimates 00:30:49,720 --> 00:30:51,640
但它们是一种运行估计
--of what the mean of these parameters looks like. 00:30:51,640 --> 00:30:55,480
这些参数的意思是什么。
--And similarly for the variance, 00:30:56,280 --> 00:30:57,720
同样对于方差，
--just averaging the variance over time. 00:30:57,720 --> 00:30:59,720
只是随时间平均方差。
--And so what we do then in our update 00:31:01,800 --> 00:31:03,960
那么我们在更新中所做的
--is instead of producing our update 00:31:03,960 --> 00:31:08,280
不是生成我们的更新
--just based upon at test time, 00:31:08,280 --> 00:31:10,440
仅基于测试时间，
--at least based upon the actual mean 00:31:10,440 --> 00:31:12,600
至少基于实际平均值
--and variance of our batch, 00:31:12,600 --> 00:31:16,040
和我们批次的差异，
--we subtract off this running estimate 00:31:16,040 --> 00:31:20,040
我们减去这个运行估计
--of the mean and the variance. 00:31:20,040 --> 00:31:21,560
的均值和方差。
--So what we do is we say, 00:31:21,560 --> 00:31:23,240
所以我们所做的就是说，
--again, remember our jth index here. 00:31:23,240 --> 00:31:25,960
再次记住我们这里的第 j 个索引。
--So this is the jth column. 00:31:25,960 --> 00:31:31,400
所以这是第 j 列。
--Sorry, the jth column for an example in our batch 00:31:31,400 --> 00:31:38,600
抱歉，我们批次中的示例的第 j 列
--that would be equal to in this case, 00:31:39,240 --> 00:31:41,480
在这种情况下等于
--z hat i plus one j 00:31:42,680 --> 00:31:45,480
z 帽子 i 加 1 j
--minus not the empirical expectation of that batch, 00:31:46,680 --> 00:31:50,600
减去该批次的经验期望，
--but minus this running mean. 00:31:50,600 --> 00:31:51,880
但减去这个运行平均值。
--Minus mu hat i plus one, 00:31:53,880 --> 00:31:57,800
减 mu hat i 加 1，
--the jth column, 00:32:01,080 --> 00:32:01,960
第 j 列，
--and then divided by the square root of a similar term. 00:32:02,520 --> 00:32:07,400
然后除以相似项的平方根。
--I won't write what's out, it's very similar, 00:32:07,400 --> 00:32:10,280
我不会写出什么，它非常相似，
--but the empirical estimate of our variance 00:32:10,280 --> 00:32:13,480
但是我们方差的经验估计
--for that feature j, 00:32:14,680 --> 00:32:16,760
对于那个特征 j，
--and then plus an epsilon term again. 00:32:17,400 --> 00:32:19,000
然后再加上一个 epsilon 项。
--And that is the standard update you do at test time. 00:32:19,800 --> 00:32:22,440
这是您在测试时所做的标准更新。
--So to be clear with batch norm, 00:32:22,440 --> 00:32:24,680
所以要清楚批规范，
--at training time, 00:32:24,680 --> 00:32:25,880
在训练时间，
--the update looks very similar to the layer norm update, 00:32:25,880 --> 00:32:28,440
更新看起来与层规范更新非常相似，
--but just what it means is different, right? 00:32:28,440 --> 00:32:30,680
但它的意思是不同的，对吧？
--So this would be the actual expectation over the batch. 00:32:30,680 --> 00:32:35,560
所以这将是对批次的实际期望。
--This would be the variance over the batch, 00:32:35,560 --> 00:32:37,320
这将是批次的差异，
--but then at test time, 00:32:37,320 --> 00:32:39,560
但在测试时，
--you run it with these moving averages instead. 00:32:39,560 --> 00:32:41,560
您改为使用这些移动平均线运行它。
--And in fact, when you implement your, 00:32:43,240 --> 00:32:45,400
事实上，当你实施你的，
--you will implement in your neural network library 00:32:46,200 --> 00:32:48,360
你将在你的神经网络库中实现
--the batch norm layer, 00:32:48,360 --> 00:32:49,720
批量规范层，
--and you will have to sort of track these things as you go. 00:32:49,720 --> 00:32:52,200
并且您将不得不在进行时跟踪这些事情。
--And there are all sorts, by the way, 00:32:52,680 --> 00:32:54,200
顺便说一句，有各种各样的，
--of very weird oddities that come up when you do this. 00:32:54,200 --> 00:32:57,880
当你这样做时会出现非常奇怪的怪事。
--Like I've seen all sorts of bugs 00:32:57,880 --> 00:32:59,080
就像我见过各种各样的错误
--where people run their network in training mode 00:32:59,080 --> 00:33:03,800
人们以训练模式运行他们的网络
--and sort of, even though they're not training the network, 00:33:03,800 --> 00:33:06,200
有点，即使他们没有训练网络，
--not taking gradient steps, 00:33:06,200 --> 00:33:07,320
不采取梯度步骤，
--for example, PyTorch will actually update 00:33:07,880 --> 00:33:09,560
例如，PyTorch 实际上会更新
--the running means and variances 00:33:09,560 --> 00:33:11,560
运行均值和方差
--when you're running in training mode. 00:33:11,560 --> 00:33:13,000
当你在训练模式下跑步时。
--So batch norm causes a lot of problems too, 00:33:13,000 --> 00:33:16,680
所以batch norm也会导致很多问题，
--but it also sort of solves a lot of problems. 00:33:16,680 --> 00:33:18,440
但它也解决了很多问题。
--So there's lots of pluses and minuses 00:33:18,440 --> 00:33:21,320
所以有很多优点和缺点
--to things like batch norm. 00:33:21,320 --> 00:33:22,360
诸如批量规范之类的东西。
--And you'll have to kind of just kind of 00:33:22,920 --> 00:33:24,680
你必须有点
--get used to these things in practice, 00:33:24,680 --> 00:33:26,040
在实践中习惯这些东西，
--but you will implement this in your homework 00:33:26,040 --> 00:33:29,320
但你会在你的家庭作业中实现这一点
--when you implement the neural network library. 00:33:29,320 --> 00:33:30,760
当你实现神经网络库时。
--All right, let's move on to the next topic now, 00:33:32,200 --> 00:33:33,960
好了，我们现在进入下一个话题，
--which is regularization. 00:33:33,960 --> 00:33:35,000
这是正则化。
--And again, this might seem a bit odd 00:33:36,040 --> 00:33:38,440
再一次，这看起来有点奇怪
--because, or odd to put together, 00:33:38,440 --> 00:33:40,200
因为，或者放在一起很奇怪，
--because this is sometimes a different topic, 00:33:40,200 --> 00:33:42,840
因为这有时是一个不同的话题，
--but regularization and normalization 00:33:42,840 --> 00:33:44,760
但是正则化和规范化
--are in some sense similar, 00:33:44,760 --> 00:33:47,400
在某种意义上是相似的，
--and they are kind of features that we add to the networks, 00:33:47,400 --> 00:33:50,360
它们是我们添加到网络中的一种功能，
--either make it perform better 00:33:50,440 --> 00:33:51,800
要么让它表现得更好
--or to optimize better and things like this. 00:33:51,800 --> 00:33:54,440
或者更好地优化等等。
--And they end up having weird interactions 00:33:55,640 --> 00:33:58,200
他们最终会有奇怪的互动
--that make a lot of sense 00:33:58,200 --> 00:33:59,880
这很有意义
--to talk about these things together. 00:33:59,880 --> 00:34:01,240
一起谈论这些事情。
--All right, so to motivate regularization, 00:34:02,760 --> 00:34:06,280
好吧，为了激励正则化，
--I'm going to use the fact that typically deep networks, 00:34:07,080 --> 00:34:09,880
我将使用通常深度网络的事实，
--and this is true even for sort of simple 00:34:09,880 --> 00:34:11,560
即使对于某种简单的情况也是如此
--two-layer networks for the cases 00:34:11,560 --> 00:34:12,920
案例的双层网络
--you've used in the homework so far, 00:34:12,920 --> 00:34:14,120
到目前为止，你已经在作业中使用过，
--they are typically what are called 00:34:15,240 --> 00:34:16,680
他们通常被称为
--over-parameterized models. 00:34:16,680 --> 00:34:18,120
过度参数化模型。
--And this means the networks have more parameters, 00:34:18,920 --> 00:34:21,640
这意味着网络有更多的参数，
--more weights, more individual weight values 00:34:21,640 --> 00:34:24,600
更多的权重，更多的个体权重值
--than the number of training examples in a dataset. 00:34:25,880 --> 00:34:28,680
比数据集中训练示例的数量。
--And this means, and we can even formalize, 00:34:29,640 --> 00:34:31,720
这意味着，我们甚至可以形式化，
--I won't formalize this, 00:34:31,720 --> 00:34:33,000
我不会正式化这个，
--but it can be made formal under certain assumptions, 00:34:33,000 --> 00:34:35,640
但它可以在某些假设下变得正式，
--is that they are capable 00:34:36,840 --> 00:34:38,440
是他们有能力
--of fitting the training data exactly. 00:34:38,440 --> 00:34:41,080
准确拟合训练数据。
--That means that when you optimize one of these networks, 00:34:41,960 --> 00:34:45,480
这意味着当你优化其中一个网络时，
--they are capable of achieving 00:34:45,480 --> 00:34:47,240
他们有能力实现
--essentially zero training error 00:34:47,240 --> 00:34:49,560
基本上零训练误差
--or something at least very, very close 00:34:49,560 --> 00:34:50,920
或者至少非常非常接近的东西
--to zero training error in practice. 00:34:50,920 --> 00:34:52,280
在实践中实现零训练错误。
--And in the traditional way of thinking 00:34:53,480 --> 00:34:56,280
而在传统的思维方式中
--about machine learning and statistics, 00:34:56,280 --> 00:34:57,720
关于机器学习和统计，
--again, with a few big caveats here, 00:34:58,600 --> 00:35:00,280
再次，这里有一些重要的警告，
--I don't want to make two blanket statements, 00:35:00,280 --> 00:35:01,720
我不想做两个笼统的声明，
--but to go ahead and still make a blanket statement, 00:35:01,720 --> 00:35:05,160
但继续做一个笼统的声明，
--traditional kind of machine learning or statistics 00:35:06,920 --> 00:35:10,040
传统的机器学习或统计
--would imply that the, 00:35:10,840 --> 00:35:12,200
将意味着，
--should imply in some sense 00:35:12,200 --> 00:35:14,360
应该在某种意义上暗示
--that these models overfit the training set. 00:35:14,360 --> 00:35:18,120
这些模型过度拟合训练集。
--And what that means is that 00:35:18,120 --> 00:35:19,080
这意味着
--they will perform well on the training set, 00:35:19,800 --> 00:35:23,640
他们将在训练集上表现良好，
--but they will not generalize well. 00:35:24,200 --> 00:35:26,440
但他们不会很好地概括。
--So essentially in, when you give it a new test set, 00:35:26,440 --> 00:35:29,960
所以基本上，当你给它一个新的测试集时，
--they will not perform well on this new test set, right? 00:35:29,960 --> 00:35:33,160
他们在这个新的测试集上表现不佳，对吧？
--And this is sort of the classical 00:35:33,160 --> 00:35:35,160
这是一种经典的
--kind of model of thinking. 00:35:35,160 --> 00:35:38,120
一种思维模式。
--Now, of course, 00:35:38,120 --> 00:35:41,880
现在，当然，
--sort of we know from a fact 00:35:42,520 --> 00:35:44,760
我们从事实中知道
--that these models sometimes do work well, 00:35:44,760 --> 00:35:48,040
这些模型有时确实运作良好，
--despite this seeming kind of oddity 00:35:48,040 --> 00:35:50,840
尽管这看起来很奇怪
--about being over-parameterized and still working well. 00:35:50,840 --> 00:35:53,000
关于被过度参数化并且仍然运行良好。
--And to be clear, there are statistical, 00:35:53,000 --> 00:35:56,360
需要明确的是，有统计数据，
--very formal models for why this can work. 00:35:56,360 --> 00:35:58,440
为什么这可以工作的非常正式的模型。
--So I'm not trying to imply here, 00:35:58,440 --> 00:35:59,800
所以我不是想在这里暗示，
--this is some big mystery, 00:35:59,800 --> 00:36:01,240
这是一个很大的谜团，
--but I also do want to say 00:36:01,240 --> 00:36:02,200
但我也确实想说
--that there actually is some mystery about this still. 00:36:02,200 --> 00:36:04,760
这实际上仍然有些神秘。
--We don't quite understand everything still about this. 00:36:05,880 --> 00:36:08,360
我们还不太了解这一切。
--But from this classical perspective, 00:36:08,920 --> 00:36:13,560
但从这个经典的角度来看，
--it does seem like our models 00:36:14,200 --> 00:36:17,640
看起来确实像我们的模特
--that we have for deep networks, 00:36:17,640 --> 00:36:19,400
我们拥有的深度网络，
--they're just too complex. 00:36:19,400 --> 00:36:21,000
它们太复杂了。
--And what's likely is that they're going to fit 00:36:21,000 --> 00:36:23,960
很可能他们会合身
--the training data exactly and not fit, 00:36:23,960 --> 00:36:27,080
训练数据完全不适合，
--not be able to give us good predictions on new examples, 00:36:27,080 --> 00:36:29,800
不能给我们对新例子的良好预测，
--which is of course what we really want. 00:36:29,800 --> 00:36:31,080
这当然是我们真正想要的。
--And so to counteract this problem, 00:36:32,440 --> 00:36:35,560
所以为了解决这个问题，
--the traditional way of dealing with this challenge 00:36:35,560 --> 00:36:40,520
应对这一挑战的传统方式
--in statistics or in classical machine learning 00:36:40,520 --> 00:36:42,520
在统计学或经典机器学习中
--is to apply some form of regularization to our problem. 00:36:43,480 --> 00:36:47,640
是对我们的问题应用某种形式的正则化。
--And speaking very informally here, 00:36:48,360 --> 00:36:50,920
在这里非常非正式地说，
--regularization is in some way the process 00:36:50,920 --> 00:36:53,640
正则化在某种程度上是过程
--of limiting the complexity of our function class 00:36:53,640 --> 00:36:56,920
限制我们函数类的复杂性
--in order to ensure that our models generalize better. 00:36:57,480 --> 00:36:59,800
为了确保我们的模型更好地泛化。
--And so this is sort of my informal definition 00:37:00,360 --> 00:37:04,200
所以这是我的非正式定义
--of regularization is about 00:37:04,200 --> 00:37:08,040
正则化是关于
--limiting the complexity of the function class. 00:37:08,040 --> 00:37:09,160
限制功能类的复杂性。
--So our functions are very complex. 00:37:09,160 --> 00:37:10,760
所以我们的功能非常复杂。
--They have more parameters than they have examples. 00:37:11,320 --> 00:37:13,640
他们的参数多于示例。
--They can overfit very easily. 00:37:13,640 --> 00:37:15,560
他们很容易过拟合。
--And regularization essentially is the process 00:37:15,560 --> 00:37:19,800
正则化本质上是这个过程
--of controlling that complexity 00:37:19,800 --> 00:37:22,680
控制这种复杂性
--so that our networks generalize better. 00:37:22,680 --> 00:37:24,680
以便我们的网络更好地泛化。
--Now, there are two forms of regularization 00:37:25,480 --> 00:37:28,760
现在，有两种形式的正则化
--that are very commonly talked about in deep learning. 00:37:28,760 --> 00:37:31,880
这在深度学习中很常见。
--And the first of these is what's called 00:37:32,440 --> 00:37:34,920
其中第一个就是所谓的
--implicit regularization. 00:37:34,920 --> 00:37:36,360
隐式正则化。
--So this refers to regularization 00:37:37,160 --> 00:37:40,920
所以这是指正则化
--that kind of comes about not through any explicit means, 00:37:40,920 --> 00:37:45,880
那种不是通过任何明确的方式发生的，
--but through kind of just the nature of the architectures 00:37:46,600 --> 00:37:50,040
但通过某种架构的性质
--or algorithms already considered, right? 00:37:50,040 --> 00:37:53,560
或已经考虑过的算法，对吗？
--And by the way, this term is vastly overused, 00:37:53,560 --> 00:37:56,360
顺便说一下，这个词被过度使用了，
--I think in deep learning, 00:37:56,360 --> 00:37:58,520
我认为在深度学习中，
--sometimes for things that are not really regularization, 00:37:58,520 --> 00:38:00,760
有时对于不是真正正则化的事情，
--but you see it everywhere. 00:38:00,760 --> 00:38:02,440
但你到处都能看到它。
--But there is a real value in thinking about 00:38:04,440 --> 00:38:06,360
但是思考是有实际价值的
--some of the processes that we use in deep learning 00:38:06,360 --> 00:38:09,400
我们在深度学习中使用的一些过程
--as being a form of regularization, 00:38:09,400 --> 00:38:12,040
作为一种正规化形式，
--even though they are not explicitly trying to control 00:38:12,040 --> 00:38:14,360
即使他们没有明确试图控制
--the complexity of our function. 00:38:14,360 --> 00:38:16,040
我们功能的复杂性。
--And the best example, I think, 00:38:16,600 --> 00:38:18,040
我认为最好的例子是
--is actually stochastic gradient descent itself 00:38:18,600 --> 00:38:21,240
实际上是随机梯度下降本身
--and just the way we optimize these networks. 00:38:22,120 --> 00:38:24,040
以及我们优化这些网络的方式。
--Maybe even more formally, SGD with a given weight initialization. 00:38:24,920 --> 00:38:30,520
也许更正式地说，SGD 具有给定的权重初始化。
--Because when we say that deep networks are overparameterized, 00:38:31,720 --> 00:38:35,560
因为当我们说深度网络被过度参数化时，
--what we really mean is that function class, 00:38:35,560 --> 00:38:37,480
我们真正的意思是那个函数类，
--the class of all deep networks can easily overfit. 00:38:37,480 --> 00:38:41,880
所有深度网络的类很容易过拟合。
--There are many possible values of the weights 00:38:41,880 --> 00:38:43,960
权重有很多可能的值
--that can easily exactly fit a set of examples, 00:38:43,960 --> 00:38:47,400
可以很容易地完全适合一组例子，
--but which won't generalize at all. 00:38:47,400 --> 00:38:49,000
但根本不会一概而论。
--But the reality is when we train a network, 00:38:51,080 --> 00:38:53,640
但现实是当我们训练一个网络时，
--we're not optimizing over the space 00:38:53,640 --> 00:38:56,760
我们没有优化空间
--of all neural networks, right? 00:38:56,760 --> 00:38:59,480
所有的神经网络，对吧？
--We're not actually optimizing over all neural networks. 00:38:59,480 --> 00:39:02,600
我们实际上并没有优化所有的神经网络。
--We're actually optimizing over the class of neural networks 00:39:02,600 --> 00:39:06,360
我们实际上是在优化神经网络类
--that in some sense is attainable or considered via SGD, right? 00:39:06,360 --> 00:39:11,720
从某种意义上说，这是可以通过 SGD 实现或考虑的，对吗？
--Reachable via this one optimization procedure 00:39:11,720 --> 00:39:15,240
可通过这一优化程序实现
--with a given weight initialization. 00:39:15,240 --> 00:39:16,920
具有给定的权重初始化。
--You remember in our previous example, 00:39:17,720 --> 00:39:19,480
你记得在我们之前的例子中，
--when we initialize with different weights, 00:39:19,480 --> 00:39:20,680
当我们用不同的权重初始化时，
--the weights didn't actually change all that much. 00:39:20,680 --> 00:39:22,600
权重实际上并没有太大变化。
--So clearly we're not kind of searching 00:39:22,600 --> 00:39:24,200
很明显我们不是在寻找
--over all possible weight settings. 00:39:24,200 --> 00:39:26,280
在所有可能的重量设置上。
--We're actually thinking about a very limited class 00:39:26,280 --> 00:39:30,680
我们实际上在考虑一个非常有限的类
--of kind of deviations from our initial values. 00:39:30,680 --> 00:39:33,720
有点偏离我们的初始值。
--And that is a form of implicit regularization. 00:39:33,720 --> 00:39:36,440
这是隐式正则化的一种形式。
--Okay. 00:39:37,720 --> 00:39:38,360
好的。
--But the kind I'm actually gonna talk about here, 00:39:38,360 --> 00:39:40,520
但我实际上要在这里谈论的那种，
--the kind of, and to be clear, 00:39:40,520 --> 00:39:41,880
需要明确的是，
--this happens, everything that we do, 00:39:41,880 --> 00:39:44,840
这发生了，我们所做的一切，
--that's a big exaggeration, 00:39:45,800 --> 00:39:47,080
这是一个很大的夸张，
--but a whole lot of what we do 00:39:47,080 --> 00:39:49,160
但我们所做的很多事情
--in designing architectures for deep networks 00:39:49,160 --> 00:39:52,040
为深度网络设计架构
--or designing optimizers 00:39:52,040 --> 00:39:53,560
或设计优化器
--is about implicitly regularizing 00:39:53,560 --> 00:39:56,840
是关于隐式正则化
--the complexity of these functions 00:39:56,840 --> 00:39:59,480
这些功能的复杂性
--such that we can generalize better. 00:39:59,480 --> 00:40:01,000
这样我们就可以更好地概括。
--What we're gonna talk about here though in this section 00:40:02,760 --> 00:40:04,520
我们将在本节中讨论的内容
--is actually going to be explicit regularization though, 00:40:04,520 --> 00:40:07,480
虽然实际上将是显式正则化，
--which refers to modifications we make 00:40:07,480 --> 00:40:10,840
这是指我们所做的修改
--to either the network or to training 00:40:10,840 --> 00:40:13,000
网络或培训
--that are explicitly intended to regularize the network, 00:40:14,040 --> 00:40:17,640
明确旨在规范网络，
--to control the complexity of the network function class. 00:40:17,640 --> 00:40:20,760
控制网络功能类的复杂度。
--I'm not sure what we're gonna talk about here, 00:40:20,760 --> 00:40:22,040
我不确定我们要在这里谈什么，
--but I do need to emphasize 00:40:22,040 --> 00:40:23,000
但我确实需要强调
--these are both very common in deep networks. 00:40:23,000 --> 00:40:25,640
这些在深度网络中都很常见。
--So the most common form of explicit regularization 00:40:27,160 --> 00:40:31,960
所以最常见的显式正则化形式
--you will see, well, I guess I should take that back 00:40:31,960 --> 00:40:33,640
你会看到，好吧，我想我应该收回它
--because both the two types 00:40:33,640 --> 00:40:34,520
因为这两种类型
--I'm gonna talk about here are common, 00:40:34,520 --> 00:40:35,800
我要说的是这里常见的，
--but the most type of regularization, 00:40:35,800 --> 00:40:37,400
但大多数类型的正则化，
--the most common form of regularization you see 00:40:37,400 --> 00:40:40,200
您看到的最常见的正则化形式
--applied to the weights of a network at least 00:40:40,200 --> 00:40:42,440
至少应用于网络的权重
--is something called L2 regularization, 00:40:43,560 --> 00:40:46,440
是一种叫做 L2 正则化的东西，
--or in deep networks is often also called weight decay. 00:40:46,440 --> 00:40:49,320
或者在深度网络中通常也称为权重衰减。
--And I'll talk about why it's called this in a second. 00:40:49,320 --> 00:40:51,960
稍后我将讨论为什么将其称为此名称。
--So to define L2 regularization, 00:40:53,320 --> 00:40:57,080
所以要定义 L2 正则化，
--I'm going to sort of bring us back 00:40:57,080 --> 00:40:59,160
我要把我们带回来
--to our classical machine learning optimization problem, right? 00:40:59,160 --> 00:41:02,760
到我们经典的机器学习优化问题，对吧？
--So our problem we had before was to minimize 00:41:02,760 --> 00:41:05,560
所以我们之前遇到的问题是最小化
--over our, in this case, 00:41:07,320 --> 00:41:09,800
在我们的，在这种情况下，
--I'll make our parameters maybe explicit, 00:41:09,800 --> 00:41:11,480
我会让我们的参数可能是明确的，
--say our parameters are weights one through L 00:41:11,480 --> 00:41:16,840
假设我们的参数是权重 1 到 L
--or my weights, I believe. 00:41:16,840 --> 00:41:17,880
或者我的体重，我相信。
--And I wanna minimize the average value 00:41:20,040 --> 00:41:26,760
我想最小化平均值
--of say over all my examples 00:41:26,760 --> 00:41:31,080
说我所有的例子
--of the loss between my prediction 00:41:31,080 --> 00:41:33,080
我的预测之间的损失
--and I'm gonna write my class 00:41:33,080 --> 00:41:34,280
我要写我的课
--of the function of one through L 00:41:34,280 --> 00:41:36,440
一到L的函数
--applied to XI and YI, right? 00:41:37,320 --> 00:41:41,880
适用于 XI 和 YI，对吗？
--That's my classical, again, 00:41:41,880 --> 00:41:43,560
又是我的经典
--everything machine learning optimization problem. 00:41:44,840 --> 00:41:47,320
一切机器学习优化问题。
--The idea behind regularization, L2 regularization 00:41:50,040 --> 00:41:56,360
正则化背后的思想，L2正则化
--is that classically speaking, 00:41:57,240 --> 00:41:59,560
是说经典的话，
--a key way of assessing the complexity 00:42:00,760 --> 00:42:05,480
评估复杂性的关键方法
--of a hypothesis class is via the size, 00:42:06,040 --> 00:42:10,840
假设类的大小是通过大小，
--say just the norm of these parameters. 00:42:11,880 --> 00:42:15,160
只说这些参数的范数。
--And the reason why, 00:42:16,120 --> 00:42:17,000
而原因，
--and I won't get into this too much 00:42:17,720 --> 00:42:19,800
我不会深入这个
--because this intuition admittedly does break down a bit 00:42:19,800 --> 00:42:24,520
因为这种直觉确实有点崩溃
--when it comes to deep networks. 00:42:24,520 --> 00:42:26,040
当谈到深度网络时。
--But one way of thinking about this 00:42:26,840 --> 00:42:28,440
但是思考这个问题的一种方式
--is imagine your weights were all zero, right? 00:42:28,440 --> 00:42:32,440
想象一下你的体重都是零，对吧？
--Then you basically, by the forms we had before, 00:42:32,440 --> 00:42:35,400
然后你基本上，通过我们之前的表格，
--you're essentially predicting with no bias term, 00:42:35,400 --> 00:42:37,720
你基本上是在没有偏差项的情况下进行预测，
--say you're gonna predict zero everywhere. 00:42:37,720 --> 00:42:39,720
说你会到处预测零。
--If your weights are small, 00:42:40,920 --> 00:42:42,680
如果你的体重很小，
--your functions have to be very smooth, right? 00:42:42,760 --> 00:42:45,720
你的功能一定很流畅吧？
--They can't change very much 00:42:45,720 --> 00:42:46,920
他们不能改变太多
--because you're not applying very large factors 00:42:46,920 --> 00:42:49,320
因为你没有应用非常大的因素
--to your inputs. 00:42:49,320 --> 00:42:50,360
到您的输入。
--So your function will be very slowly varying 00:42:50,360 --> 00:42:53,640
所以你的功能会非常缓慢地变化
--over different inputs, right? 00:42:53,640 --> 00:42:55,240
在不同的输入上，对吧？
--With small weights. 00:42:55,240 --> 00:42:56,200
重量小。
--And so the smaller your weights are 00:42:56,920 --> 00:42:59,400
所以你的重量越小
--in some very real sense, 00:42:59,400 --> 00:43:00,600
在某种非常真实的意义上，
--the smoother your function has to be. 00:43:00,600 --> 00:43:02,840
您的功能必须越流畅。
--A bit more formally, 00:43:03,640 --> 00:43:04,600
正式一点，
--this actually the size of the weights 00:43:05,480 --> 00:43:07,400
这实际上是权重的大小
--imposes restrictions on the smoothness 00:43:07,400 --> 00:43:09,960
对平滑度施加限制
--or the Lipschitz constant of the function 00:43:09,960 --> 00:43:12,440
或函数的 Lipschitz 常数
--that you're actually using to represent your data. 00:43:12,440 --> 00:43:14,520
你实际用来表示你的数据。
--And what this means is, 00:43:15,640 --> 00:43:16,760
这意味着，
--because smoother functions in some sense 00:43:17,960 --> 00:43:20,360
因为在某种意义上更平滑的功能
--are less complex, right? 00:43:20,360 --> 00:43:21,480
不那么复杂，对吧？
--They can't change as fast 00:43:21,480 --> 00:43:22,600
他们不能改变得那么快
--unless that they're less kind of highly varying. 00:43:22,600 --> 00:43:24,600
除非它们的变化不大。
--One way to control the complexity of a function 00:43:25,960 --> 00:43:28,760
一种控制函数复杂度的方法
--is to ensure that the value of the weights themselves 00:43:28,760 --> 00:43:32,440
是为了确保权重本身的价值
--are small. 00:43:32,440 --> 00:43:33,080
很小。
--So we want to make the parameters small. 00:43:33,640 --> 00:43:37,400
所以我们想让参数变小。
--Okay, that's one way of making our, 00:43:37,480 --> 00:43:39,800
好的，这是让我们的一种方式，
--keep controlling the complexity of our function class. 00:43:41,080 --> 00:43:43,320
继续控制我们函数类的复杂性。
--And a very common way to do that 00:43:44,120 --> 00:43:45,640
一种非常常见的方法
--is to do this by adding in our loss function, 00:43:46,200 --> 00:43:49,240
就是通过添加我们的损失函数来做到这一点，
--by augmenting our optimization problem 00:43:49,240 --> 00:43:52,120
通过增加我们的优化问题
--to add what's called a regularization term. 00:43:52,120 --> 00:43:55,000
添加所谓的正则化项。
--And the most common way of writing, 00:43:55,560 --> 00:43:57,080
而最常见的写法，
--the most sort of, 00:43:57,080 --> 00:43:57,880
最多的，
--well, the form of this term 00:43:57,880 --> 00:43:59,720
嗯，这个词的形式
--in the case of L2 regularization 00:43:59,720 --> 00:44:01,480
在 L2 正则化的情况下
--is that we're going to add a term 00:44:02,120 --> 00:44:03,880
是我们要添加一个术语
--plus lambda over two times the sum from, 00:44:03,880 --> 00:44:10,760
加上 lambda 的总和的两倍，
--let's see, a little more space here. 00:44:10,760 --> 00:44:13,320
让我们看看，这里多一点空间。
--The sum from, in this case, 00:44:13,320 --> 00:44:15,560
在这种情况下，总和来自
--I'll write, use J 00:44:16,200 --> 00:44:17,560
我会写，用J
--because I'm indexing here over the, 00:44:17,560 --> 00:44:19,080
因为我在这里索引，
--and actually I'll still use I here 00:44:19,080 --> 00:44:20,440
实际上我仍然会在这里使用 I
--because I'm not using two sums. 00:44:20,440 --> 00:44:22,440
因为我没有使用两个总和。
--But the sum from I equals, 00:44:22,440 --> 00:44:23,880
但是 I 等于的总和，
--here's indexing over the layer. 00:44:23,880 --> 00:44:25,000
这是图层的索引。
--So the sum from I equals one else 00:44:25,000 --> 00:44:26,760
所以我的总和等于另一个
--indexing over the layers of my network 00:44:26,760 --> 00:44:28,520
在我的网络层上建立索引
--indexing over the layers of my network 00:44:28,680 --> 00:44:30,120
在我的网络层上建立索引
--of the norm of my Ith layer. 00:44:30,680 --> 00:44:36,440
我的第 I 层的范数。
--And I guess this is actually a matrix. 00:44:36,440 --> 00:44:38,120
我想这实际上是一个矩阵。
--So technically speaking, 00:44:38,120 --> 00:44:39,000
所以从技术上讲，
--I should use what's called 00:44:39,000 --> 00:44:39,880
我应该使用所谓的
--the Frobenius norm squared here. 00:44:39,880 --> 00:44:42,120
Frobenius 范数在这里平方。
--This is just the sum of the squared elements 00:44:42,120 --> 00:44:44,200
这只是平方元素的总和
--of this vector, 00:44:44,200 --> 00:44:45,000
这个向量，
--so of this matrix. 00:44:45,560 --> 00:44:47,000
所以这个矩阵。
--So as a vector, 00:44:47,000 --> 00:44:47,640
所以作为一个向量，
--the L2 norm, 00:44:49,400 --> 00:44:50,200
 L2范数，
--it's called the Frobenius norm 00:44:51,000 --> 00:44:52,040
它被称为 Frobenius 范数
--when you apply it to matrices 00:44:52,040 --> 00:44:53,720
当你将它应用于矩阵时
--because you don't want to confuse it 00:44:53,720 --> 00:44:55,640
因为你不想混淆它
--with the spectral norm and things like this. 00:44:55,640 --> 00:44:57,720
与光谱范数和类似的东西。
--Okay, so that's the form of regularization 00:44:59,080 --> 00:45:01,720
好的，这就是正则化的形式
--that we often use in, 00:45:01,720 --> 00:45:03,080
我们经常使用的，
--or that's sort of most common 00:45:04,600 --> 00:45:06,600
或者这是最常见的
--called L2 regularization. 00:45:06,600 --> 00:45:08,120
称为 L2 正则化。
--And I should actually be kind of, 00:45:09,080 --> 00:45:10,840
我实际上应该是，
--if I'm being fully honest here, 00:45:10,840 --> 00:45:13,960
如果我在这里完全诚实的话
--I previously referred to this thing here 00:45:14,840 --> 00:45:18,120
我以前在这里提到过这个东西
--as like the optimization problem 00:45:18,120 --> 00:45:20,520
就像优化问题一样
--of all machine learning, right? 00:45:20,520 --> 00:45:22,200
所有机器学习，对吧？
--I said, minimizing over your dataset, 00:45:22,200 --> 00:45:25,000
我说，最小化你的数据集，
--the sum of losses, 00:45:25,000 --> 00:45:26,040
损失总和，
--minimizing over your parameters, 00:45:26,120 --> 00:45:27,160
最小化你的参数，
--the sum of losses in your dataset. 00:45:27,160 --> 00:45:28,680
数据集中的损失总和。
--And really though, 00:45:29,400 --> 00:45:31,400
但实际上，
--probably more fairly, 00:45:31,960 --> 00:45:33,240
可能更公平，
--this thing is the actual true 00:45:34,040 --> 00:45:37,720
这件事是真实的
--machine learning optimization problem 00:45:37,720 --> 00:45:39,800
机器学习优化问题
--because very often 00:45:39,800 --> 00:45:41,000
因为很多时候
--there is a form of regularization 00:45:41,000 --> 00:45:42,600
有一种正则化形式
--either built in or explicitly considered 00:45:42,600 --> 00:45:45,000
内置或明确考虑
--in deep, in machine learning methods. 00:45:45,000 --> 00:45:48,120
在深度，在机器学习方法中。
--And so really regularize minimization 00:45:48,120 --> 00:45:52,360
所以真正正则化最小化
--of the losses in the training set 00:45:52,360 --> 00:45:53,480
训练集中的损失
--is an even more important way 00:45:53,480 --> 00:45:55,000
是一个更重要的方式
--is an even more apt description 00:45:55,400 --> 00:45:57,320
是一个更贴切的描述
--of kind of the single optimization problem 00:45:57,320 --> 00:46:00,200
一种单一的优化问题
--that all machine learning uses 00:46:00,200 --> 00:46:02,440
所有机器学习都使用
--with of course the possibility 00:46:02,440 --> 00:46:03,640
当然有可能
--of other measures of complexity 00:46:03,640 --> 00:46:05,880
其他复杂性措施
--rather than just the norm of the weights. 00:46:05,880 --> 00:46:08,280
而不仅仅是权重的规范。
--You could have other 00:46:08,280 --> 00:46:09,400
你可以有其他
--more generic regularizers too, 00:46:09,400 --> 00:46:11,560
还有更通用的正则化器，
--but really this is kind of the, 00:46:11,560 --> 00:46:12,840
但实际上这是一种，
--in some sense, an even more, 00:46:13,640 --> 00:46:15,240
在某种意义上，甚至更多，
--an even better description 00:46:15,240 --> 00:46:16,600
更好的描述
--of the core optimization problem 00:46:16,600 --> 00:46:18,280
核心优化问题
--of all machine learning. 00:46:18,280 --> 00:46:19,320
所有机器学习。
--Okay, so what happens 00:46:20,680 --> 00:46:23,240
好的，那会发生什么
--when we actually use this update, 00:46:23,240 --> 00:46:27,960
当我们实际使用这个更新时，
--this form of the update here? 00:46:27,960 --> 00:46:29,240
这种形式的更新在这里？
--So if we define our new optimization problem 00:46:30,040 --> 00:46:33,640
所以如果我们定义新的优化问题
--as this new objective, 00:46:33,640 --> 00:46:35,400
作为这个新目标，
--what we get for our gradient descent update 00:46:36,360 --> 00:46:39,240
我们从梯度下降更新中得到了什么
--is well, most of it is like before. 00:46:39,240 --> 00:46:41,160
还好，大部分还是以前的样子。
--So before, you know, 00:46:41,160 --> 00:46:42,280
所以之前，你知道，
--our gradient descent update 00:46:42,280 --> 00:46:43,240
我们的梯度下降更新
--takes our old parameters 00:46:43,240 --> 00:46:45,080
采用我们的旧参数
--and subtracts off alpha 00:46:45,080 --> 00:46:47,160
并减去 alpha
--times the gradient of this whole term here, 00:46:47,160 --> 00:46:50,440
在这里乘以整个术语的梯度，
--right? 00:46:51,160 --> 00:46:51,400
正确的？
--So it would be the gradient of the loss. 00:46:51,400 --> 00:46:56,440
所以这将是损失的梯度。
--Maybe I'll even write it just for, 00:46:56,440 --> 00:46:57,560
也许我什至会写它只是为了，
--well, I'll write it out 00:46:58,520 --> 00:47:00,120
好吧，我会写出来
--with the sum and everything too, 00:47:00,120 --> 00:47:01,320
加上总和和一切，
--but of course, this could apply 00:47:01,320 --> 00:47:03,000
但当然，这可能适用
--to many batches and anything else too. 00:47:03,000 --> 00:47:04,440
许多批次和其他任何东西。
--So it'd be the gradient with respect to wi 00:47:05,000 --> 00:47:07,800
所以它是关于 wi 的梯度
--of the sum of our losses, 00:47:08,440 --> 00:47:10,120
我们损失的总和，
--which I'll actually maybe just write as the, 00:47:10,120 --> 00:47:12,040
我实际上可能只是写成，
--no, I'll write it like that. 00:47:12,040 --> 00:47:13,240
不，我会这样写。
--Of course, you could write it 00:47:13,240 --> 00:47:13,800
当然，你可以这样写
--as the sum of the gradients too, 00:47:13,800 --> 00:47:14,840
作为梯度的总和，
--but it doesn't really matter. 00:47:14,840 --> 00:47:15,800
但这并不重要。
--The loss between our hypothesis 00:47:17,080 --> 00:47:19,240
我们的假设之间的损失
--w1 through L x i i i. 00:47:21,640 --> 00:47:28,600
w1 到 L xii i。
--So that is the exact same thing 00:47:28,600 --> 00:47:30,120
所以这是完全一样的事情
--as we had before in our gradient descent update. 00:47:30,120 --> 00:47:34,280
正如我们之前在梯度下降更新中所做的那样。
--But then you would also subtract off 00:47:35,080 --> 00:47:37,960
但是你也会减去
--alpha times the gradient of this thing. 00:47:38,840 --> 00:47:42,440
alpha 乘以这个东西的梯度。
--But the gradient of the norm of a vector squared, 00:47:44,440 --> 00:47:47,640
但是向量平方范数的梯度，
--this is like one of the standard gradients 00:47:47,640 --> 00:47:49,240
这就像标准渐变之一
--you probably know, 00:47:49,240 --> 00:47:50,680
你可能知道，
--or I would say what it is. 00:47:51,480 --> 00:47:54,440
或者我会说它是什么。
--The gradient of the normal vector squared 00:47:54,440 --> 00:47:56,120
法向量平方的梯度
--is just that vector or that matrix, right? 00:47:56,120 --> 00:47:58,760
只是那个向量或那个矩阵，对吧？
--So the gradient, 00:47:58,760 --> 00:47:59,640
所以梯度，
--so what this is, of course, 00:47:59,640 --> 00:48:00,680
所以这是什么，当然，
--is this is the gradient of this term here. 00:48:00,680 --> 00:48:06,360
这是这里这个术语的梯度吗？
--But the gradient of wi 00:48:07,400 --> 00:48:08,760
但是 wi 的梯度
--with respect to that whole thing 00:48:08,760 --> 00:48:10,840
关于那整件事
--is just equal to lambda times wi. 00:48:10,840 --> 00:48:18,680
正好等于 lambda 乘以 wi。
--And that's not hard to, 00:48:21,640 --> 00:48:22,840
而这并不难，
--that's not very hard to show. 00:48:22,840 --> 00:48:24,040
这并不难证明。
--That just is, obviously, 00:48:24,040 --> 00:48:26,520
那就是，显然，
--the terms in the sum, 00:48:26,520 --> 00:48:27,720
总和中的条款，
--because I'm taking the gradient set for wi, 00:48:27,720 --> 00:48:30,040
因为我正在为wi设置渐变，
--the terms in that sum other than wi 00:48:30,040 --> 00:48:31,720
该总和中除 wi 以外的项
--don't matter, they fall out. 00:48:32,360 --> 00:48:33,960
没关系，它们会掉下来。
--And then the gradient with the wi, 00:48:33,960 --> 00:48:36,680
然后是wi的梯度，
--for the norm of wi, 00:48:36,680 --> 00:48:37,880
对于 wi 的范数，
--or for a vector, 00:48:37,880 --> 00:48:38,920
或者对于一个向量，
--just the squared norm 00:48:38,920 --> 00:48:39,640
只是平方范数
--is just that vector or that matrix, okay? 00:48:39,640 --> 00:48:42,600
只是那个向量或那个矩阵，好吗？
--So this is what our gradient descent update becomes. 00:48:42,600 --> 00:48:46,280
这就是我们的梯度下降更新的结果。
--And if we just refactor terms here, 00:48:47,240 --> 00:48:49,160
如果我们在这里重构术语，
--you know, we have a wi here, 00:48:49,160 --> 00:48:50,920
你知道，我们这里有无线网络，
--and wi here, 00:48:51,400 --> 00:48:52,360
在这里，
--so this whole thing can also be written as 00:48:52,920 --> 00:48:55,160
所以这整个事情也可以写成
--one minus alpha lambda times wi 00:48:56,840 --> 00:49:00,840
一减 alpha lambda 乘以 wi
--minus alpha times our old gradient, right? 00:49:03,080 --> 00:49:05,720
减去 alpha 乘以我们的旧梯度，对吧？
--The gradient with the wi 00:49:05,720 --> 00:49:07,000
 wi 的梯度
--of the sum from i equals one to m. 00:49:07,640 --> 00:49:11,880
i 的总和等于 1 到 m。
--I guess I should have an average here. 00:49:11,880 --> 00:49:13,320
我想我应该在这里取一个平均值。
--I should have a one over m in both places. 00:49:13,320 --> 00:49:15,160
我应该在两个地方都有一个超过米。
--Doesn't really matter. 00:49:15,720 --> 00:49:16,520
没关系。
--Of our loss, w1 through l, xi, 00:49:17,240 --> 00:49:23,480
我们的损失，w1 到 l，xi，
--gonna run out of space here, yi. 00:49:24,040 --> 00:49:26,920
这里的空间会用完，yi。
--Okay, barely, didn't quite make it. 00:49:28,440 --> 00:49:31,800
好吧，勉强，没有完全成功。
--Move things over just a little bit here. 00:49:33,560 --> 00:49:35,000
把事情移到这里。
--Okay, hopefully you can see that whole thing. 00:49:38,120 --> 00:49:39,880
好的，希望你能看到整个事情。
--Okay, so that's our update. 00:49:39,880 --> 00:49:41,880
好的，这就是我们的更新。
--And the key point that I want to make of this update 00:49:42,520 --> 00:49:45,400
我想对这次更新提出的要点
--is that what this update does when you combine terms 00:49:45,400 --> 00:49:48,920
是当您组合术语时此更新的作用
--is that it takes, 00:49:48,920 --> 00:49:50,120
是需要，
--instead of just taking our wi 00:49:50,120 --> 00:49:52,040
而不是仅仅使用我们的无线网络
--and updating it with our previous wi, 00:49:52,040 --> 00:49:53,880
并用我们之前的 wi 更新它，
--we take, we set wi equal to 00:49:53,880 --> 00:49:56,760
我们取，我们设置 wi 等于
--some factor times the old wi. 00:49:59,320 --> 00:50:02,680
一些因素乘以旧无线网络。
--And this factor, because alpha is, 00:50:02,680 --> 00:50:04,520
这个因素，因为 alpha 是，
--you know, the step size is considered a small number, 00:50:04,520 --> 00:50:06,200
你知道，步长被认为是一个小数字，
--and because lambda is also 00:50:06,200 --> 00:50:07,560
因为 lambda 也是
--what's called a regularization parameter here, 00:50:07,560 --> 00:50:09,400
这里所谓的正则化参数，
--it's just some factor that trades off 00:50:09,400 --> 00:50:11,000
这只是一些权衡因素
--between our loss function 00:50:11,000 --> 00:50:14,120
在我们的损失函数之间
--and the regularization. 00:50:14,920 --> 00:50:15,800
和正则化。
--This is, these are both positive, 00:50:17,400 --> 00:50:19,240
这是，这些都是积极的，
--and so this thing here subtracts, 00:50:19,240 --> 00:50:23,000
所以这里的东西减去，
--you know, a positive number of one minus a positive number. 00:50:23,000 --> 00:50:26,200
你知道，一个正数减去一个正数。
--And so this whole update will essentially shrink wi, 00:50:26,840 --> 00:50:31,960
所以整个更新基本上会缩小 wi，
--will be a, you know, a shrunken version of wi, right? 00:50:33,400 --> 00:50:38,280
将是一个缩小版的 wi，对吗？
--In other words, we shrink the weights by this factor, 00:50:39,000 --> 00:50:41,720
换句话说，我们通过这个因子缩小权重，
--one minus alpha times lambda, 00:50:41,720 --> 00:50:43,720
一减去 alpha 乘以 lambda，
--where again lambda is our regularization parameter here, 00:50:43,880 --> 00:50:46,600
这里 lambda 又是我们的正则化参数，
--before taking each gradient step. 00:50:47,400 --> 00:50:48,760
在采取每个梯度步骤之前。
--And because of this, 00:50:49,320 --> 00:50:50,120
也正因为如此，
--because of this sort of, you know, 00:50:50,120 --> 00:50:51,160
因为这种，你知道，
--shrinkage of the weights here, 00:50:51,160 --> 00:50:52,920
这里权重的收缩，
--this is often called weight decay. 00:50:52,920 --> 00:50:54,920
这通常称为权重衰减。
--But it's important to know what this is really doing 00:50:55,880 --> 00:50:58,280
但重要的是要知道这到底在做什么
--is that this is taking the gradient 00:50:58,280 --> 00:51:01,320
是这是在取梯度
--not just of our loss, 00:51:01,320 --> 00:51:02,760
不仅仅是我们的损失，
--but of our, 00:51:02,760 --> 00:51:03,800
但是我们的，
--but also of this regularization term 00:51:05,400 --> 00:51:07,240
还有这个正则化项
--that involves our weights, right? 00:51:07,800 --> 00:51:10,520
这涉及到我们的体重，对吧？
--And that's how you derive this L2 regularization updates. 00:51:10,520 --> 00:51:15,000
这就是您得出此 L2 正则化更新的方式。
--Oftentimes for convention, 00:51:15,960 --> 00:51:17,400
经常为了会议，
--and I'm not quite sure why it evolved this way, 00:51:17,400 --> 00:51:19,000
我不太确定为什么会这样发展，
--but oftentimes for convention, 00:51:19,000 --> 00:51:20,440
但通常是为了约定，
--we write, we sort of implement L2 regularization 00:51:20,440 --> 00:51:24,760
我们写，我们有点实现 L2 正则化
--as a feature of the optimizer, 00:51:24,760 --> 00:51:27,320
作为优化器的一个特性，
--not as a feature of the loss. 00:51:27,320 --> 00:51:28,920
不作为损失的特征。
--I think this is actually a bit wrong. 00:51:29,480 --> 00:51:32,040
我觉得这其实有点不对。
--I personally think that we should kind of define 00:51:32,040 --> 00:51:35,320
我个人认为我们应该定义
--this regularizer as part of our loss function 00:51:35,320 --> 00:51:37,960
这个正则化器是我们损失函数的一部分
--and do things that way. 00:51:37,960 --> 00:51:39,080
并以这种方式做事。
--But that's not the decision 00:51:39,080 --> 00:51:40,200
但这不是决定
--that the community made of deep learning. 00:51:40,200 --> 00:51:42,680
社区由深度学习组成。
--So what you'll really see frequently is optimizers, 00:51:42,680 --> 00:51:46,360
所以你真正经常看到的是优化器，
--SGD or Adam, these things have a term 00:51:47,160 --> 00:51:49,800
 SGD 或 Adam，这些东西有一个术语
--that is called the weight decay term. 00:51:50,840 --> 00:51:52,360
这称为权重衰减项。
--And that is exactly just this parameter lambda here, 00:51:52,360 --> 00:51:56,120
这就是这里的参数 lambda，
--which affects how much you trade off 00:51:56,120 --> 00:51:58,280
这会影响你的权衡
--between your weights and your loss function. 00:51:58,280 --> 00:52:03,400
在你的权重和你的损失函数之间。
--And it's often incorporated in the optimizer itself. 00:52:04,520 --> 00:52:07,480
它通常包含在优化器本身中。
--But if you're uncertain 00:52:07,480 --> 00:52:08,760
但如果你不确定
--how to incorporate this as an optimizer, 00:52:08,760 --> 00:52:10,440
如何将其合并为优化器，
--it's really important to know how it's derived this way. 00:52:10,440 --> 00:52:13,160
了解它是如何以这种方式得出的非常重要。
--Because if you need to implement like weight decay in Adam, 00:52:13,160 --> 00:52:16,520
因为如果你需要在 Adam 中实现权重衰减，
--what you should not do is try to figure out 00:52:17,240 --> 00:52:19,560
你不应该做的是试图弄清楚
--like a different kind of weight decay 00:52:19,560 --> 00:52:21,720
就像一种不同的体重衰减
--that is correct for Adam. 00:52:21,720 --> 00:52:23,160
这对亚当来说是正确的。
--What you should just do is take your gradient. 00:52:23,160 --> 00:52:25,000
你应该做的就是采用梯度。
--So whenever you have a gradient of your normal system, 00:52:25,000 --> 00:52:27,960
所以每当你有正常系统的梯度时，
--this whole thing here, 00:52:29,160 --> 00:52:30,520
这整件事在这里，
--you just replace it with, 00:52:30,520 --> 00:52:32,520
你只需将它替换为
--the way you actually implement weight decay 00:52:32,520 --> 00:52:33,960
你实际实现权重衰减的方式
--is you replace it with the gradient of the whole thing, 00:52:33,960 --> 00:52:37,480
你是不是用整个东西的梯度来代替它，
--including the regularization term. 00:52:37,480 --> 00:52:39,240
包括正则化项。
--And for whatever momentum terms or anything else you have, 00:52:39,240 --> 00:52:42,600
对于任何动量项或你拥有的任何其他东西，
--you would just use that whole combination as your gradient. 00:52:42,600 --> 00:52:45,800
您只需使用整个组合作为渐变。
--So that's how you implement weight decay correctly 00:52:45,800 --> 00:52:49,080
这就是正确实施权重衰减的方式
--with momentum or with Adam or these other things. 00:52:49,080 --> 00:52:52,040
动量或亚当或其他这些东西。
--And so it's important to know how you come up, 00:52:52,040 --> 00:52:54,920
所以重要的是要知道你是怎么来的，
--even though the resulting formula 00:52:55,640 --> 00:52:57,880
即使得到的公式
--is that you just sort of multiply your weights 00:52:57,880 --> 00:53:00,520
是你只是将你的权重相乘
--by a constant less than one before the update. 00:53:00,520 --> 00:53:03,880
比更新前的一个常数小。
--It's important to implement that kind of 00:53:06,120 --> 00:53:07,880
实施这种方式很重要
--in terms of this regularized optimization problem 00:53:07,880 --> 00:53:09,960
就这个正则化优化问题而言
--when you actually do it, 00:53:09,960 --> 00:53:11,080
当你真正去做的时候，
--so that you know how to implement this properly 00:53:11,080 --> 00:53:13,720
这样您就知道如何正确实施
--for other optimizers as well. 00:53:13,720 --> 00:53:15,320
对于其他优化器也是如此。
--All right. 00:53:17,320 --> 00:53:17,640
好的。
--So L2 regularization is kind of the, 00:53:17,640 --> 00:53:20,040
所以 L2 正则化是一种，
--I would argue kind of most common form 00:53:22,440 --> 00:53:24,760
我会争论一种最常见的形式
--of weight regularization people use in deep networks. 00:53:24,760 --> 00:53:28,200
人们在深度网络中使用的权重正则化。
--But there is a big caveat here, 00:53:28,200 --> 00:53:29,880
但这里有一个很大的警告，
--which is that even though it is very common, 00:53:29,960 --> 00:53:32,120
也就是说，尽管它很常见，
--it's unclear how much it really makes sense, right? 00:53:32,680 --> 00:53:36,200
目前还不清楚它到底有多少意义，对吧？
--Because in practice, it's unclear how much 00:53:37,000 --> 00:53:39,800
因为在实践中，不清楚有多少
--the norm of the weights really affects the complexity 00:53:40,440 --> 00:53:46,360
权重的范数确实影响了复杂性
--of the resulting underlying function. 00:53:46,360 --> 00:53:48,600
所产生的基础功能。
--I mean, I gave this example where if the weights were all zero, 00:53:48,600 --> 00:53:51,160
我的意思是，我举了这个例子，如果权重全为零，
--yes, the function is not very complex. 00:53:51,160 --> 00:53:53,160
是的，功能不是很复杂。
--But in terms of the variances you get 00:53:53,160 --> 00:53:55,240
但是就你得到的差异而言
--when it comes to real networks, 00:53:55,240 --> 00:53:58,120
当谈到真实的网络时，
--it's much less clear, right? 00:53:58,120 --> 00:53:59,800
不太清楚，对吧？
--Remember this example I gave before 00:54:00,280 --> 00:54:01,800
记住我之前给出的这个例子
--of networks initialized with three different weights 00:54:01,800 --> 00:54:04,120
用三个不同的权重初始化的网络
--that all got... 00:54:04,840 --> 00:54:05,800
这一切都得到了...
--So this one, I think I didn't actually include it here, 00:54:06,680 --> 00:54:08,760
所以这个，我想我实际上并没有把它包括在这里，
--but this one was a variance of the initialization weights 00:54:08,760 --> 00:54:11,720
但这一个是初始化权重的变化
--of 2.3 over n, I think. 00:54:11,720 --> 00:54:16,440
2.3 超过 n，我认为。
--This one was 2 over n. 00:54:16,440 --> 00:54:19,000
这是 2 比 n。
--This blue one here was 1.7 over n. 00:54:19,960 --> 00:54:25,720
这个蓝色的比 n 高 1.7。
--Okay, so we had the different initializations. 00:54:26,440 --> 00:54:28,520
好的，所以我们有不同的初始化。
--And these are very different weights, right? 00:54:28,520 --> 00:54:31,880
这些是非常不同的重量，对吧？
--When it comes down, I mean, maybe not very different, 00:54:31,880 --> 00:54:33,560
当它下来时，我的意思是，也许没有太大的不同，
--but they are somewhat different weights. 00:54:33,560 --> 00:54:35,240
但它们的重量有些不同。
--But these networks all get the same loss 00:54:35,240 --> 00:54:38,440
但是这些网络都得到相同的损失
--and the same actually generalization loss 00:54:38,440 --> 00:54:40,200
和相同的实际泛化损失
--on MNIST in this case. 00:54:40,200 --> 00:54:41,560
在这种情况下，在 MNIST 上。
--And so is it really that important to shrink weights? 00:54:42,200 --> 00:54:46,840
那么减肥真的那么重要吗？
--It's sort of unclear, right? 00:54:46,840 --> 00:54:48,040
有点不清楚，对吧？
--And personally, weight decay is very common. 00:54:48,920 --> 00:54:51,800
就个人而言，体重下降非常普遍。
--So when people run gradient descent, 00:54:51,800 --> 00:54:53,400
所以当人们运行梯度下降时，
--you will often see some amount of weight decay. 00:54:53,400 --> 00:54:55,800
你会经常看到一些重量衰减。
--People have just tuned it over time 00:54:55,800 --> 00:54:57,560
人们只是随着时间的推移调整它
--and found that a small value of 1e-4 00:54:57,560 --> 00:55:01,720
并发现 1e-4 的小值
--is like maybe a good, 00:55:01,720 --> 00:55:03,640
就像一个好的，
--works slightly better than no weight decay at all. 00:55:03,640 --> 00:55:05,480
效果比完全没有重量衰减稍微好一点。
--But I often ignore it entirely 00:55:07,560 --> 00:55:10,680
但我经常完全忽略它
--when I train deep networks. 00:55:10,680 --> 00:55:11,720
当我训练深度网络时。
--I often don't bother with weight decay 00:55:11,720 --> 00:55:13,480
我通常不会为体重下降而烦恼
--because parameter magnitude, 00:55:13,480 --> 00:55:15,720
因为参数量级，
--the sort of the absolute magnitude of parameters, 00:55:15,720 --> 00:55:18,200
参数绝对大小的种类，
--especially when you include normalization layers 00:55:18,200 --> 00:55:19,880
特别是当你包含规范化层时
--and this kind of stuff, 00:55:19,880 --> 00:55:21,080
而这种东西，
--it's often a very bad proxy 00:55:21,080 --> 00:55:22,600
它通常是一个非常糟糕的代理
--for complexity in deep networks. 00:55:22,600 --> 00:55:24,600
对于深度网络中的复杂性。
--And so while this is very common 00:55:24,600 --> 00:55:26,200
所以虽然这很常见
--and you should know about it, 00:55:26,200 --> 00:55:27,080
你应该知道，
--and it is in wide use, 00:55:27,080 --> 00:55:28,760
并且被广泛使用，
--you will very, very often see it used in practice. 00:55:28,760 --> 00:55:30,840
你会非常非常经常地看到它在实践中使用。
--I often find that I don't tend to use it 00:55:31,640 --> 00:55:34,280
我经常发现我不倾向于使用它
--that often in deep networks. 00:55:34,280 --> 00:55:36,360
通常在深层网络中。
--The other form of regularization 00:55:38,600 --> 00:55:40,520
另一种形式的正则化
--that I want to mention here 00:55:40,520 --> 00:55:41,240
我想在这里提到
--because it's very common, 00:55:41,240 --> 00:55:42,520
因为很常见，
--and I do consider this to be a form of regularization, 00:55:42,520 --> 00:55:45,480
我确实认为这是一种正规化形式，
--is something called, a strategy called dropout. 00:55:45,480 --> 00:55:47,160
是一种叫做 dropout 的策略。
--So if you can think of L2 regularization 00:55:48,200 --> 00:55:51,160
所以如果你能想到 L2 正则化
--as a regularizer that we, 00:55:51,160 --> 00:55:52,760
作为我们的正则化者，
--an explicit regularizer we apply 00:55:52,760 --> 00:55:54,600
我们应用的显式正则化器
--to the weights of a network, 00:55:54,600 --> 00:55:56,680
网络的权重，
--the parameters of a network, 00:55:56,680 --> 00:55:57,880
网络参数，
--another common strategy 00:55:59,160 --> 00:56:00,920
另一种常见策略
--is to apply a kind of regularization 00:56:00,920 --> 00:56:03,560
是应用一种正则化
--to the activations of the network. 00:56:03,560 --> 00:56:06,120
到网络的激活。
--And the essential idea here, 00:56:06,920 --> 00:56:08,360
这里的基本思想，
--and this also maybe seems odd at first, 00:56:08,360 --> 00:56:10,360
这也可能一开始看起来很奇怪，
--not unlike other things, 00:56:11,320 --> 00:56:12,440
与其他事物一样，
--like say, bash norm we considered, 00:56:12,440 --> 00:56:14,360
比如说，我们考虑过的 bash 规范，
--is to, as we are training our network, 00:56:16,920 --> 00:56:19,400
是为了，当我们训练我们的网络时，
--the idea of dropout 00:56:19,400 --> 00:56:21,000
辍学的想法
--is you randomly set some fraction of the activations 00:56:21,000 --> 00:56:24,760
你是随机设置激活的一部分吗
--in each layer to zero. 00:56:24,760 --> 00:56:25,960
在每一层中归零。
--Okay, so formally speaking, 00:56:26,840 --> 00:56:29,720
好吧，正式地说，
--what I mean by that is, 00:56:29,720 --> 00:56:30,520
我的意思是，
--you know, similarly, 00:56:30,520 --> 00:56:31,720
你知道，同样地，
--let my z hat i plus one here 00:56:31,720 --> 00:56:34,600
让我的 z 帽子在这里加一
--be kind of a tentative value 00:56:34,600 --> 00:56:38,600
是一种暂定值
--for the next layer. 00:56:38,600 --> 00:56:39,400
为下一层。
--But my actual value for the next layer 00:56:40,040 --> 00:56:42,280
但我对下一层的实际价值
--would be equal to the jth element here, 00:56:42,280 --> 00:56:46,760
等于这里的第 j 个元素，
--so that the element j in my next layer 00:56:46,760 --> 00:56:49,960
这样我下一层的元素j
--would be equal to z hat i plus one j. 00:56:49,960 --> 00:56:55,080
等于 z hat i 加 1 j。
--It's just equal to that layer. 00:56:55,080 --> 00:56:56,200
正好等于那一层。
--With probability one minus p, 00:56:57,000 --> 00:57:04,360
概率为 1 减去 p，
--and with probability p, 00:57:04,360 --> 00:57:05,480
并以概率 p，
--I set it to be equal to zero. 00:57:06,120 --> 00:57:07,480
我将它设置为等于零。
--This is with probability p. 00:57:08,280 --> 00:57:11,160
这是概率 p。
--And that's the idea of dropout. 00:57:11,960 --> 00:57:15,240
这就是辍学的想法。
--But it's actually not quite complete yet, 00:57:15,240 --> 00:57:17,320
但实际上还不是很完整，
--because if I do this 00:57:17,320 --> 00:57:19,160
因为如果我这样做
--and kind of randomly set it to zero, 00:57:19,160 --> 00:57:20,680
并随机将其设置为零，
--I am going to be changing 00:57:20,680 --> 00:57:23,640
我要改变
--the overall weight of these activations, right? 00:57:24,120 --> 00:57:27,560
这些激活的总权重，对吗？
--I'm going to be, you know, 00:57:27,560 --> 00:57:29,240
我会，你知道，
--with the same initialization, 00:57:29,960 --> 00:57:31,000
具有相同的初始化，
--I will no longer have weights that remain, 00:57:31,000 --> 00:57:35,000
我将不再有剩余的重量，
--or variances of the weights that remain steady 00:57:35,000 --> 00:57:36,760
或保持稳定的权重方差
--over throughout the network. 00:57:36,760 --> 00:57:38,280
在整个网络中。
--So I have to actually also scale these weights 00:57:38,280 --> 00:57:41,240
所以我实际上也必须缩放这些权重
--by the probability that I keep them. 00:57:41,240 --> 00:57:44,920
我保留它们的可能性。
--And so actually, 00:57:44,920 --> 00:57:45,480
所以实际上，
--the correct scaling for these things 00:57:45,480 --> 00:57:47,080
这些东西的正确缩放比例
--to maintain the variance properly 00:57:47,080 --> 00:57:48,360
适当地保持方差
--is just to divide this by one minus p. 00:57:48,360 --> 00:57:51,320
只是将其除以 1 减去 p。
--So if I keep, if I set half to zero, 00:57:52,200 --> 00:57:57,320
所以如果我保留，如果我将一半设置为零，
--then I'll divide the rest by half 00:57:57,320 --> 00:57:59,720
然后我把剩下的分成两半
--to make them twice as large. 00:57:59,720 --> 00:58:01,000
使它们变大两倍。
--If I set 0.1 to zero, 00:58:01,000 --> 00:58:02,600
如果我将 0.1 设置为零，
--I'll divide the rest by 0.9 00:58:02,600 --> 00:58:04,440
我将其余部分除以 0.9
--to make them a little bit larger. 00:58:04,440 --> 00:58:05,720
让它们变大一点。
--And that's the idea of dropout. 00:58:07,240 --> 00:58:08,360
这就是辍学的想法。
--Now, again, like batch norm, 00:58:10,360 --> 00:58:13,080
现在，再一次，像批量规范一样，
--dropout has different performance 00:58:13,080 --> 00:58:15,000
辍学有不同的表现
--at training time at test time 00:58:16,200 --> 00:58:18,280
在训练时间 在测试时间
--and then at test time. 00:58:18,280 --> 00:58:19,640
然后在测试时。
--So dropout is simply only applied at, 00:58:19,720 --> 00:58:22,200
所以辍学只适用于，
--not typically, though not always, 00:58:22,200 --> 00:58:24,440
不通常，虽然不总是，
--applied at training. 00:58:24,440 --> 00:58:25,960
应用于培训。
--So you're trying to sort of regularize 00:58:25,960 --> 00:58:28,440
所以你试图规范化
--your network at training time, 00:58:28,440 --> 00:58:29,800
您在训练时的网络，
--but it typically is not applied at test time. 00:58:30,920 --> 00:58:34,360
但它通常不会在测试时应用。
--So at test time, 00:58:34,360 --> 00:58:35,080
所以在测试的时候，
--you just leave all your activations in there. 00:58:35,080 --> 00:58:37,160
您只需将所有激活都留在那里。
--Now, this does seem very odd, right? 00:58:38,600 --> 00:58:41,720
现在，这看起来确实很奇怪，对吧？
--Because it seems like in doing this, 00:58:41,720 --> 00:58:43,480
因为看起来这样做，
--we must be massively changing the function 00:58:43,480 --> 00:58:46,760
我们必须大规模改变功能
--that we're actually approximating here, right? 00:58:46,760 --> 00:58:48,440
我们实际上在这里近似，对吧？
--Aren't we kind of completely destroying the function 00:58:48,440 --> 00:58:50,520
我们不是在彻底破坏这个功能吗
--if we just randomly set some of our features 00:58:50,520 --> 00:58:52,920
如果我们只是随机设置一些功能
--to be equal to zero? 00:58:52,920 --> 00:58:53,800
等于零？
--And batch, or sorry, 00:58:54,520 --> 00:58:57,160
和批处理，或者抱歉，
--dropout is often cast 00:58:57,160 --> 00:58:59,640
辍学经常投
--as kind of a way of making the networks robust 00:59:00,200 --> 00:59:04,120
作为一种使网络健壮的方法
--to missing activations, 00:59:04,920 --> 00:59:06,600
缺少激活，
--is one way it's kind of framed. 00:59:06,600 --> 00:59:07,800
是它被陷害的一种方式。
--But I always didn't, 00:59:07,800 --> 00:59:09,240
但我一直没有，
--I never really liked this characterization 00:59:09,240 --> 00:59:11,000
我从来都不喜欢这个角色
--because why should it be robust 00:59:11,000 --> 00:59:12,840
因为为什么它应该是健壮的
--to missing activations? 00:59:12,840 --> 00:59:13,640
缺少激活？
--I mean, after all, 00:59:13,640 --> 00:59:14,280
我的意思是，毕竟，
--you don't have these missing activations 00:59:14,280 --> 00:59:17,000
你没有这些缺失的激活
--at test time. 00:59:17,000 --> 00:59:17,720
在测试时。
--And why does this, 00:59:19,160 --> 00:59:20,040
为什么会这样，
--why should this be thought of as like regularization? 00:59:20,920 --> 00:59:22,680
为什么要将其视为正则化？
--So I think the best way to think about dropout 00:59:23,320 --> 00:59:25,720
所以我认为考虑辍学的最佳方式
--is actually to think of it 00:59:25,720 --> 00:59:27,160
其实是想起来
--as a stochastic approximation. 00:59:27,160 --> 00:59:29,080
作为随机近似。
--And just like we did SGD 00:59:29,080 --> 00:59:32,360
就像我们做 SGD 一样
--to approximate gradient descent 00:59:32,920 --> 00:59:35,000
近似梯度下降
--over our entire objective, 00:59:35,000 --> 00:59:36,280
在我们的整个目标上，
--batch norm can be, 00:59:37,000 --> 00:59:38,040
批量规范可以是
--oh, I keep saying batch norm, 00:59:38,040 --> 00:59:39,320
哦，我一直在说批量规范，
--dropout can be thought as a very similar thing 00:59:39,320 --> 00:59:42,360
 dropout 可以认为是一个非常相似的东西
--applied to the individual activations of a network. 00:59:42,360 --> 00:59:45,960
适用于网络的单个激活。
--So here's what I mean by this. 00:59:45,960 --> 00:59:47,240
这就是我的意思。
--Um, when we did our sort of SGD approximation, 00:59:48,680 --> 00:59:53,000
嗯，当我们进行 SGD 近似时，
--we used the fact, 00:59:53,720 --> 00:59:54,840
我们使用了事实，
--we kind of relied on the fact, 00:59:54,840 --> 00:59:56,120
我们有点依赖这个事实，
--and to be clear, 00:59:56,120 --> 00:59:57,000
需要明确的是，
--stochastic gradient descent is itself 00:59:57,800 --> 00:59:59,320
随机梯度下降本身
--kind of I mentioned 00:59:59,320 --> 00:59:59,960
我提到过
--this sort of implicit form of regularization, right? 00:59:59,960 --> 01:00:01,960
这种隐含的正则化形式，对吧？
--It adds kind of noise to our gradients, 01:00:01,960 --> 01:00:03,560
它给我们的渐变增加了一些噪音，
--which actually does provide 01:00:03,560 --> 01:00:05,240
实际上确实提供了
--the kind of regularization to our function. 01:00:05,240 --> 01:00:06,920
对我们的函数进行正则化的那种。
--And so what we did in, 01:00:07,960 --> 01:00:09,560
所以我们所做的，
--when we approximated things with SGD 01:00:09,560 --> 01:00:13,320
当我们用 SGD 来近似事物时
--is we said that, you know, 01:00:13,320 --> 01:00:14,360
我们是不是说过，你知道，
--my kind of overall objective here 01:00:15,320 --> 01:00:20,120
我的总体目标
--was kind of equal to some sort of 01:00:20,120 --> 01:00:23,000
有点等于某种
--similar loss computed only over a mini-batch. 01:00:25,000 --> 01:00:29,160
仅在小批量上计算类似的损失。
--So say all i in the batch or something like this 01:00:29,160 --> 01:00:32,360
所以说我在批次或类似的东西
--of the loss between h, x i, and y i, right? 01:00:33,000 --> 01:00:39,320
h、xi 和 yi 之间的损失，对吗？
--This was the stochastic gradient descent approximation 01:00:39,320 --> 01:00:41,880
这是随机梯度下降近似
--that we used. 01:00:41,880 --> 01:00:42,440
我们用过的。
--And in some sense, 01:00:43,080 --> 01:00:45,080
而在某种意义上，
--this is very similar to what's being done with dropout. 01:00:47,400 --> 01:00:52,680
这与 dropout 所做的非常相似。
--So in dropout, you can think of, 01:00:53,800 --> 01:00:56,520
所以在dropout中，你可以想到，
--or really sort of, you know, 01:00:56,520 --> 01:00:58,040
或者真的有点，你知道的，
--zooming in a bit more on kind of 01:00:58,040 --> 01:00:59,880
放大一点
--what's really being computed in a layer. 01:00:59,880 --> 01:01:02,600
层中真正计算的是什么。
--The way we sort of compute, you know, 01:01:03,640 --> 01:01:05,640
我们计算的方式，你知道，
--each activation prior to its non-linearity 01:01:05,640 --> 01:01:09,080
非线性之前的每次激活
--is we take, you know, 01:01:09,080 --> 01:01:10,680
是我们采取，你知道，
--the corresponding elements in a column of w 01:01:10,680 --> 01:01:13,720
 w的一列对应的元素
--and multiply it by the activations of this vector here. 01:01:14,360 --> 01:01:24,120
并在此处乘以该向量的激活值。
--And this is, so this notation here means 01:01:24,120 --> 01:01:26,520
这是，所以这里的符号意味着
--that the jth kind of, the jth row here 01:01:26,520 --> 01:01:30,200
第 j 种，这里的第 j 行
--times all aspects of this, all, 01:01:30,200 --> 01:01:35,400
时代的方方面面，所有，
--so this would be the jth, 01:01:35,400 --> 01:01:38,360
所以这将是第 j 个，
--the jth row here, right? 01:01:39,080 --> 01:01:42,680
这里第 j 行，对吧？
--Because we're just multiplying it 01:01:42,680 --> 01:01:43,800
因为我们只是将它相乘
--times the activations of this vector here. 01:01:43,800 --> 01:01:45,880
在这里乘以这个向量的激活。
--And so that's just sort of the broken down version 01:01:46,680 --> 01:01:51,240
所以这只是一种分解版本
--of this matrix multiplication that we do. 01:01:51,240 --> 01:01:53,320
我们做的这个矩阵乘法。
--And so one way to think about this, about dropout, 01:01:54,280 --> 01:01:58,840
所以有一种思考方式，关于辍学，
--is that we are just basically doing 01:01:58,840 --> 01:02:00,440
是我们基本上只是在做
--a stochastic approximation 01:02:00,440 --> 01:02:02,280
随机近似
--of this individual kind of activation. 01:02:03,240 --> 01:02:08,360
这种个别的激活。
--We are approximating this thing 01:02:09,000 --> 01:02:10,680
我们正在逼近这件事
--as similarly equal to, you know, 01:02:11,400 --> 01:02:14,360
同样等于，你知道，
--z i plus one times, or sorry, 01:02:14,360 --> 01:02:17,800
 zi 加一倍，或者对不起，
--z i plus one equals our same non-linearity 01:02:17,800 --> 01:02:20,200
 zi 加一等于我们相同的非线性
--applied to the sum, 01:02:20,840 --> 01:02:25,560
应用于总和，
--not over all the different weights, 01:02:25,560 --> 01:02:29,480
不是所有不同的重量，
--but just over the sum in some j in some subset, 01:02:29,480 --> 01:02:32,600
但刚好超过某些子集中某些 j 的总和，
--say p here, where we're going to multiply w j, 01:02:32,600 --> 01:02:35,640
在这里说 p，我们要乘以 wj，
--all the elements here times z i j. 01:02:37,800 --> 01:02:43,240
这里的所有元素乘以 zi j。
--And then we need to normalize this 01:02:43,800 --> 01:02:45,240
然后我们需要规范化这个
--to properly have kind of the correct scale, 01:02:45,240 --> 01:02:48,280
适当地有一种正确的规模，
--just like we normalized by one over b here 01:02:48,280 --> 01:02:51,080
就像我们在这里用 one over b 归一化一样
--instead of one over n. 01:02:51,080 --> 01:02:51,960
而不是一比一。
--We would sort of divide by the size of our set here. 01:02:53,400 --> 01:02:56,600
我们会按这里的集合大小进行划分。
--But of course, you know, 01:02:56,600 --> 01:02:57,400
但是，当然，你知道，
--we didn't normalize this one. 01:02:57,960 --> 01:02:59,720
我们没有规范化这个。
--You know, this one was not written as an average, 01:02:59,720 --> 01:03:02,360
你知道，这个不是平均写的，
--it was written as a sum. 01:03:02,360 --> 01:03:03,480
它被写成一个总和。
--And so we need to multiply on the top here by n. 01:03:03,480 --> 01:03:06,440
所以我们需要在顶部乘以 n。
--And this factor is exactly kind of 01:03:06,440 --> 01:03:08,840
而这个因素恰恰是
--the average factor you get of one over one. 01:03:08,840 --> 01:03:14,280
你得到的平均因子是一对一。
--This thing here would just be, of course, 01:03:15,080 --> 01:03:16,600
当然，这里的东西只是，
--equal to one over one minus p. 01:03:16,600 --> 01:03:21,960
等于一比一减去 p。
--So this is the factor that we multiply our weights by. 01:03:21,960 --> 01:03:25,880
所以这是我们乘以权重的因素。
--And so I think this is the right way to think about dropout. 01:03:26,840 --> 01:03:29,880
所以我认为这是考虑辍学的正确方法。
--It is dropout is a stochastic, 01:03:29,880 --> 01:03:31,800
它是随机的，
--it basically takes the idea of stochastic approximation 01:03:31,800 --> 01:03:34,200
它基本上采用了随机近似的思想
--into the activations of the network itself, 01:03:35,160 --> 01:03:38,120
进入网络本身的激活，
--the individual layers of a network, 01:03:38,120 --> 01:03:40,360
网络的各个层，
--and in doing so provides a similar degree of regularization 01:03:40,360 --> 01:03:45,320
这样做提供了相似程度的正则化
--as stochastic gradient descent provides 01:03:45,320 --> 01:03:47,640
正如随机梯度下降提供的
--for the traditional training objective. 01:03:47,640 --> 01:03:51,880
为传统的培训目标。
--And that's what I like to think about dropout. 01:03:52,680 --> 01:03:55,080
这就是我喜欢考虑的辍学问题。
--Okay, so that actually covers the majority of the techniques 01:03:56,840 --> 01:04:03,160
好的，这实际上涵盖了大部分技术
--that I want to highlight today. 01:04:03,160 --> 01:04:05,000
我今天想强调这一点。
--So we covered normalization and regularization, 01:04:05,000 --> 01:04:08,280
所以我们涵盖了规范化和正则化，
--both as techniques as ways of sort of 01:04:08,280 --> 01:04:10,680
既是技术也是某种方式
--making optimization better 01:04:11,960 --> 01:04:13,320
使优化更好
--or making sure that we don't overfit as much 01:04:13,320 --> 01:04:15,080
或者确保我们不会过拟合
--to our data and things like this. 01:04:15,080 --> 01:04:16,520
到我们的数据和类似的东西。
--But I want to end this with a bit of a more 01:04:17,160 --> 01:04:20,040
但我想用更多的东西来结束这一切
--kind of higher level picture here, 01:04:20,040 --> 01:04:23,560
这里有一种更高层次的图片，
--talking about kind of the interaction 01:04:24,440 --> 01:04:27,240
谈论某种互动
--of all these things we've been talking about 01:04:27,240 --> 01:04:29,560
我们一直在谈论的所有这些事情
--over the past several lectures, right? 01:04:29,560 --> 01:04:31,080
过去的几个讲座，对吗？
--So we talked about optimization, initialization, 01:04:31,080 --> 01:04:33,240
所以我们谈到了优化，初始化，
--normalization, regularization. 01:04:33,240 --> 01:04:34,360
规范化，正则化。
--And the reality is there are many design choices 01:04:35,000 --> 01:04:39,240
而现实是有很多设计选择
--we can make to ease the optimization of deep networks 01:04:39,240 --> 01:04:43,320
我们可以简化深度网络的优化
--or to make them perform better, et cetera, right? 01:04:43,320 --> 01:04:46,600
或者让他们表现得更好，等等，对吧？
--We have the choice of the optimizer, 01:04:46,600 --> 01:04:48,680
我们可以选择优化器，
--the learning rate of the optimizer, 01:04:48,680 --> 01:04:49,960
优化器的学习率，
--the parameters that's much the momentum term, 01:04:49,960 --> 01:04:51,560
动量项的参数，
--which optimizer we use. 01:04:51,560 --> 01:04:52,600
我们使用哪个优化器。
--We have the choice of weight initialization. 01:04:53,480 --> 01:04:55,000
我们可以选择权重初始化。
--What's our variance we use there? 01:04:55,800 --> 01:04:57,560
我们在那里使用的方差是多少？
--Maybe we should use a uniform versus normal distribution, 01:04:57,560 --> 01:05:00,600
也许我们应该使用均匀分布与正态分布，
--all these sorts of things. 01:05:00,600 --> 01:05:01,480
所有这些事情。
--Do we add normalization? 01:05:02,360 --> 01:05:03,480
我们是否添加规范化？
--Do we add layer norm? 01:05:03,480 --> 01:05:04,360
我们添加层范数吗？
--Do we add batch norm? 01:05:04,360 --> 01:05:05,560
我们添加批量规范吗？
--Do we regularize? 01:05:05,560 --> 01:05:06,440
我们规范化了吗？
--Do we use weight decay or do we use dropout, right? 01:05:06,440 --> 01:05:10,360
我们是使用权重衰减还是使用 dropout，对吧？
--And these don't even include the other tricks 01:05:11,240 --> 01:05:13,080
这些甚至不包括其他技巧
--that we might cover in later lectures, 01:05:13,080 --> 01:05:14,360
我们可能会在以后的讲座中介绍，
--like residual connections or learning rate schedules 01:05:14,360 --> 01:05:17,960
比如残差连接或学习率表
--or many others that I'm probably forgetting. 01:05:17,960 --> 01:05:20,040
或许多我可能忘记的其他内容。
--And so if when you sort of are first approaching 01:05:21,560 --> 01:05:26,120
所以如果当你第一次接近
--the practice of deep learning, 01:05:27,320 --> 01:05:28,840
深度学习的实践，
--it is very common to sort of feel like, 01:05:29,560 --> 01:05:33,960
有种很常见的感觉，
--okay, I don't know what I should choose here. 01:05:33,960 --> 01:05:35,960
好吧，我不知道我应该在这里选择什么。
--So let me do a grid search over all possible things here. 01:05:35,960 --> 01:05:39,560
所以让我在这里对所有可能的事情进行网格搜索。
--And that's how I'm going to find the right parameters 01:05:39,560 --> 01:05:41,160
这就是我要找到正确参数的方式
--to optimize my network. 01:05:41,160 --> 01:05:42,120
优化我的网络。
--And this is, first of all, 01:05:42,680 --> 01:05:44,600
这是，首先，
--this is exactly the wrong thing to do. 01:05:44,600 --> 01:05:46,840
这完全是错误的做法。
--Definitely don't do that. 01:05:46,840 --> 01:05:48,200
绝对不要那样做。
--There are way too many choices here to do a grid search 01:05:48,200 --> 01:05:50,280
这里有太多选择无法进行网格搜索
--and training one network can take long enough, 01:05:50,280 --> 01:05:53,160
训练一个网络可能需要足够长的时间，
--let alone training 10 to the eight networks 01:05:53,160 --> 01:05:56,920
更不用说训练10到8个网络了
--or something like that, right? 01:05:56,920 --> 01:05:57,800
或者类似的东西，对吧？
--To sort of grid cover your whole choice of parameters here. 01:05:57,800 --> 01:06:00,760
要对网格进行排序，请在此处覆盖您对参数的全部选择。
--But you would be forgiven, 01:06:01,640 --> 01:06:03,320
但你会被原谅的，
--especially when you see kind of people's recipes 01:06:03,320 --> 01:06:05,800
尤其是当你看到人们的食谱时
--for training where they have some random values 01:06:05,800 --> 01:06:08,280
用于训练他们有一些随机值
--of these things, 01:06:08,280 --> 01:06:08,920
这些东西中，
--you would be forgiven for thinking that 01:06:10,360 --> 01:06:12,520
你会这样想是可以原谅的
--people must have just flailed around randomly on GPUs 01:06:14,280 --> 01:06:18,200
人们一定是在 GPU 上随意挥舞着
--for many thousands of GPU or millions of GPU hours. 01:06:18,600 --> 01:06:22,040
数以千计的 GPU 或数百万个 GPU 小时。
--And that's what deep learning is all about. 01:06:22,040 --> 01:06:23,320
这就是深度学习的意义所在。
--I'm actually going to push back on that a little bit. 01:06:25,480 --> 01:06:26,920
我实际上要推迟一点。
--I don't think that's actually quite right. 01:06:26,920 --> 01:06:28,200
我不认为这实际上是完全正确的。
--But to give even a bigger impression 01:06:28,200 --> 01:06:33,560
但是为了给人留下更大的印象
--about sort of one of these things, 01:06:33,560 --> 01:06:35,480
关于这些事情之一，
--I want to actually go through an example case 01:06:35,480 --> 01:06:38,600
我实际上想通过一个示例案例
--that has been confusing to the field, to be honest. 01:06:38,600 --> 01:06:42,680
老实说，这一直让该领域感到困惑。
--And that is exactly this case of BashStorm 01:06:42,680 --> 01:06:44,840
这正是 BashStorm 的情况
--that I talked about. 01:06:44,840 --> 01:06:45,560
我谈到的。
--So BashStorm was proposed in this paper 01:06:45,960 --> 01:06:48,680
所以本文提出了BashStorm
--that you see here called 01:06:49,320 --> 01:06:50,920
你在这里看到的叫做
--Bash Normalization Accelerating Deep Network Training 01:06:50,920 --> 01:06:52,760
Bash 规范化加速深度网络训练
--by Reducing Internal Covariate Shift. 01:06:52,760 --> 01:06:54,360
通过减少内部协变量偏移。
--And the abstract, I think actually aptly describes 01:06:55,640 --> 01:06:59,400
而摘要，我认为实际上恰当地描述了
--exactly what BashStorm is doing. 01:06:59,400 --> 01:07:00,520
正是 BashStorm 在做什么。
--It says, training deep networks is complicated by the fact 01:07:00,520 --> 01:07:03,640
它说，训练深度网络实际上很复杂
--that the distribution of each layer's input 01:07:03,640 --> 01:07:05,000
每层输入的分布
--changes during training 01:07:05,000 --> 01:07:06,200
训练期间的变化
--as the parameters of the previous layers change. 01:07:06,200 --> 01:07:08,600
随着前面层的参数变化。
--This slows down the training by requiring 01:07:08,600 --> 01:07:11,080
这通过要求减慢训练
--lower learning rates 01:07:11,080 --> 01:07:12,600
降低学习率
--and a careful parameter initialization. 01:07:12,600 --> 01:07:15,320
和仔细的参数初始化。
--It makes it notoriously hard to train models 01:07:15,320 --> 01:07:17,320
这使得训练模型变得非常困难
--with saturated nonlinearities. 01:07:17,320 --> 01:07:19,080
具有饱和非线性。
--We refer to this problem as internal covariate shift 01:07:19,080 --> 01:07:21,560
我们将这个问题称为内部协变量偏移
--and address the problem by normalizing layer inputs. 01:07:21,560 --> 01:07:24,440
并通过规范化层输入来解决问题。
--Our method draws strength 01:07:24,440 --> 01:07:25,560
我们的方法汲取力量
--from making normalization a part of the model architecture 01:07:25,560 --> 01:07:28,200
从使规范化成为模型架构的一部分
--and performing normalization for each training mini-batch. 01:07:28,200 --> 01:07:31,160
并对每个训练小批量进行归一化。
--It also, by the way, they mentioned 01:07:32,120 --> 01:07:33,800
顺便说一下，他们还提到
--that it eliminates the need for dropout. 01:07:33,800 --> 01:07:35,560
它消除了辍学的需要。
--So already they're talking about the interaction 01:07:35,560 --> 01:07:38,280
所以他们已经在谈论互动了
--in some sense between normalization 01:07:38,280 --> 01:07:40,760
在某种意义上归一化之间
--and regularization and these sorts of things. 01:07:40,760 --> 01:07:42,680
和正则化以及诸如此类的事情。
--And BashStorm is a great example 01:07:43,640 --> 01:07:44,920
 BashStorm 就是一个很好的例子
--because BashNorm undeniably was a good idea, right? 01:07:44,920 --> 01:07:50,760
因为 BashNorm 无疑是个好主意，对吧？
--This has been extremely useful in practice 01:07:50,760 --> 01:07:54,200
这在实践中非常有用
--and very oftentimes there are networks 01:07:54,200 --> 01:07:56,200
并且经常有网络
--that just will not train if you do not use BashNorm. 01:07:56,200 --> 01:07:59,880
如果你不使用 BashNorm，那将不会训练。
--And when you put BashNorm in there, 01:07:59,880 --> 01:08:01,400
当你把 BashNorm 放在那里时，
--all of a sudden they just start training 01:08:01,400 --> 01:08:02,760
突然间他们才开始训练
--and performance is much, much improved. 01:08:02,760 --> 01:08:04,680
性能大大提高。
--But there has been admittedly 01:08:06,920 --> 01:08:09,160
但不可否认的是
--a lot of discussion and confusion in the community 01:08:09,160 --> 01:08:13,400
社区中有很多讨论和困惑
--about what BashNorm is actually doing, 01:08:13,400 --> 01:08:16,520
关于 BashNorm 实际上在做什么，
--why this is a good idea, 01:08:16,520 --> 01:08:18,120
为什么这是个好主意，
--why this might be a good thing to really do in practice. 01:08:18,120 --> 01:08:22,360
为什么这在实践中可能是一件好事。
--And this was sort of made famous by, 01:08:23,080 --> 01:08:24,680
这有点出名了，
--I mean, amongst many other things. 01:08:25,640 --> 01:08:27,000
我的意思是，除此之外还有很多其他事情。
--Alde Rahimi actually gave a kind of a controversial 01:08:28,360 --> 01:08:32,280
 Alde Rahimi实际上给出了一种有争议的
--test of time award at the NeurIPS 2017 conference. 01:08:33,400 --> 01:08:37,800
在 NeurIPS 2017 会议上获得 test of time 奖。
--And he also used BashNorm as an example 01:08:39,400 --> 01:08:41,960
而且他还以 BashNorm 为例
--in some sense of what's wrong with deep learning 01:08:41,960 --> 01:08:44,760
从某种意义上说深度学习出了什么问题
--or the fact his analogy was that deep learning 01:08:44,760 --> 01:08:47,320
或者他的类比是深度学习
--is seemingly like alchemy in a lot of ways 01:08:47,960 --> 01:08:49,960
在很多方面看起来就像炼金术
--and people sort of just try and cook up interesting things. 01:08:49,960 --> 01:08:52,680
人们只是尝试和烹制有趣的东西。
--And I actually don't fully agree with this assessment, 01:08:52,680 --> 01:08:54,920
我其实并不完全同意这个评估，
--but it's sort of a worthy thing to mention here 01:08:54,920 --> 01:08:58,280
但在这里值得一提
--as a perspective. 01:08:58,280 --> 01:08:59,080
作为一个观点。
--And so part of his talk said the following. 01:09:00,200 --> 01:09:01,800
因此，他的部分谈话内容如下。
--It says, here's what we know about BashNorm as a field. 01:09:01,800 --> 01:09:04,120
它说，这就是我们对 BashNorm 作为一个领域的了解。
--It works because it reduces internal covariate shift. 01:09:04,680 --> 01:09:07,720
它之所以有效，是因为它减少了内部协变量偏移。
--Wouldn't you like to know why 01:09:07,720 --> 01:09:09,480
你不想知道为什么吗
--reducing internal covariate shift speeds up gradient descent? 01:09:09,560 --> 01:09:12,440
减少内部协变量偏移加速梯度下降？
--Wouldn't you like to see a theorem or an experiment? 01:09:12,440 --> 01:09:14,760
您不想看定理或实验吗？
--Wouldn't you like to know, 01:09:14,760 --> 01:09:15,800
你不想知道，
--wouldn't you like to see evidence 01:09:15,800 --> 01:09:17,320
你不想看看证据吗
--that BashNorm reduces internal covariate shift? 01:09:17,320 --> 01:09:19,960
BashNorm 减少了内部协变量偏移？
--Wouldn't you like to know what internal covariate shift is? 01:09:20,600 --> 01:09:23,000
您不想知道什么是内部协变量偏移吗？
--Wouldn't you like to see a definition of it? 01:09:23,000 --> 01:09:24,520
你不想看看它的定义吗？
--I think that's actually, 01:09:25,400 --> 01:09:26,200
我认为这实际上是
--but by the end he was maybe being a bit tongue in cheek there. 01:09:26,760 --> 01:09:28,920
但到最后他可能在那里有点开玩笑。
--It's a bit unfair. 01:09:28,920 --> 01:09:30,520
这有点不公平。
--I mean, literally in the abstract, 01:09:30,520 --> 01:09:34,200
我的意思是，从字面上抽象地说，
--they say, they define this, right? 01:09:34,840 --> 01:09:37,800
他们说，他们定义了这个，对吗？
--We refer to this phenomenon. 01:09:37,800 --> 01:09:39,240
我们指的是这种现象。
--They just described as internal covariate shift there. 01:09:39,240 --> 01:09:41,240
他们只是在那里描述为内部协变量偏移。
--So maybe that last statement was a bit, 01:09:41,240 --> 01:09:42,920
所以也许最后的陈述有点，
--I think a bit unwarranted, but it's true. 01:09:43,480 --> 01:09:46,280
我觉得有点不靠谱，但确实如此。
--Does it speed up optimization? 01:09:47,240 --> 01:09:49,320
它会加速优化吗？
--Does it reduce this internal covariate shift that they have here? 01:09:49,320 --> 01:09:52,440
它会减少他们在这里的这种内部协变量变化吗？
--Is there a reason why it does? 01:09:53,560 --> 01:09:54,600
这是有原因的吗？
--It's sort of unclear. 01:09:54,600 --> 01:09:55,720
有点不清楚。
--And in fact, there have been many papers arguing that, 01:09:55,720 --> 01:10:01,800
事实上，有很多论文认为，
--no, this reduction of internal covariate shift 01:10:02,360 --> 01:10:04,600
不，这种内部协变量偏移的减少
--is actually not what BashNorm is really doing. 01:10:04,600 --> 01:10:06,840
实际上并不是 BashNorm 真正在做的。
--One famous example actually being a paper in, 01:10:07,640 --> 01:10:09,960
一个著名的例子实际上是一篇论文，
--I believe, near 2018, 01:10:09,960 --> 01:10:12,280
我相信，临近2018年，
--arguing that instead, 01:10:13,720 --> 01:10:15,080
相反，争辩说，
--rather than the sort of original view of BashNorm, 01:10:15,080 --> 01:10:17,560
而不是 BashNorm 的那种原始观点，
--the actual benefit of BashNorm was in the fact 01:10:18,200 --> 01:10:21,080
 BashNorm 的实际好处在于
--that it makes the landscape optimization smoother. 01:10:21,080 --> 01:10:23,720
它使景观优化更加顺畅。
--So the relevant part of this paper says that 01:10:23,720 --> 01:10:25,640
所以这篇论文的相关部分说
--the popular belief is that the effectiveness, 01:10:25,640 --> 01:10:27,720
普遍的看法是，有效性，
--this effectiveness of BashNorm stems from 01:10:27,720 --> 01:10:29,800
 BashNorm 的这种有效性源于
--controlling the change of layers input distributions 01:10:29,800 --> 01:10:31,880
控制层输入分布的变化
--during training to reduce so-called internal covariate shift. 01:10:31,880 --> 01:10:34,520
在训练期间减少所谓的内部协变量偏移。
--In this work, we demonstrate that 01:10:34,520 --> 01:10:35,720
在这项工作中，我们证明了
--such distributional stability of layer inputs 01:10:35,720 --> 01:10:37,960
层输入的这种分布稳定性
--has little to do with the success of BashNorm. 01:10:37,960 --> 01:10:40,600
与 BashNorm 的成功关系不大。
--And instead, we uncover a more fundamental impact 01:10:40,600 --> 01:10:43,080
相反，我们发现了一个更根本的影响
--of BashNorm on the training process. 01:10:43,080 --> 01:10:44,920
BashNorm 的训练过程。
--It makes the optimization landscape significantly smoother. 01:10:44,920 --> 01:10:47,160
它使优化环境变得更加平滑。
--And so now this is an argument that 01:10:47,800 --> 01:10:49,240
所以现在这是一个论点
--BashNorm is really not about this sort of 01:10:49,240 --> 01:10:52,360
BashNorm 真的不是关于这种
--making features on, putting features on even level, 01:10:54,680 --> 01:10:58,440
制作功能，将功能放在同一水平面上，
--but it's actually about interacting with optimization 01:10:58,440 --> 01:11:01,240
但它实际上是关于与优化的交互
--and speeding up the optimization process. 01:11:01,240 --> 01:11:03,160
并加快优化过程。
--But then, and this one, I should admit, I'm biased here. 01:11:03,640 --> 01:11:08,200
但是，我应该承认，我在这里有偏见。
--I'm an author on this paper. 01:11:08,200 --> 01:11:09,240
我是这篇论文的作者。
--So I take this all with a grain of salt. 01:11:09,240 --> 01:11:12,920
所以我对这一切持保留态度。
--But a few years after this, 01:11:14,120 --> 01:11:15,720
但在这之后的几年，
--actually, a student of mine had a paper on 01:11:15,720 --> 01:11:17,880
实际上，我的一个学生有一篇关于
--the dynamics of optimization of deep networks 01:11:18,760 --> 01:11:22,440
深度网络优化的动力学
--under gradient descent, 01:11:22,440 --> 01:11:23,560
在梯度下降下，
--and rather buried in the paper, to be honest, 01:11:23,560 --> 01:11:26,040
宁愿埋在报纸里，老实说，
--it's in appendix K1, it's where this fact is mentioned. 01:11:26,040 --> 01:11:29,080
它在附录 K1 中，其中提到了这个事实。
--But after a lot of discussion, 01:11:29,880 --> 01:11:31,800
但经过多次讨论，
--and this paper essentially shows that 01:11:31,800 --> 01:11:33,400
这篇论文基本上表明
--actually the smoothness of optimization in deep networks 01:11:33,400 --> 01:11:36,120
实际上是深度网络中优化的平滑度
--does not behave like we are used to 01:11:36,120 --> 01:11:39,320
不像我们习惯的那样
--when it comes to traditional optimization. 01:11:39,320 --> 01:11:42,040
当涉及到传统优化时。
--And a key sentence here is that we conclude 01:11:43,640 --> 01:11:47,160
这里的关键句子是我们得出结论
--that there's no evidence that use of BashNorm improves 01:11:47,160 --> 01:11:49,560
没有证据表明使用 BashNorm 会有所改善
--either the smoothness or the effective smoothness 01:11:49,560 --> 01:11:52,360
平滑度或有效平滑度
--along the optimization trajectory. 01:11:52,360 --> 01:11:53,800
沿着优化轨迹。
--So maybe the statement that BashNorm helps 01:11:53,800 --> 01:11:57,000
所以也许 BashNorm 帮助的声明
--the statement that BashNorm helps smoothness 01:11:57,080 --> 01:11:59,720
BashNorm帮助平滑的说法
--is not the case. 01:11:59,720 --> 01:12:00,920
事实并非如此。
--So this is now several years, 01:12:04,600 --> 01:12:07,160
所以现在已经好几年了，
--and it's almost like you almost can't write a paper 01:12:07,160 --> 01:12:09,800
就像你几乎不能写论文一样
--on BashNorm anymore, 01:12:09,800 --> 01:12:10,680
不再使用 BashNorm，
--because people just sort of roll their eyes 01:12:10,680 --> 01:12:11,880
因为人们只是翻白眼
--as like, oh, another BashNorm paper, 01:12:11,880 --> 01:12:13,320
就像，哦，另一篇 BashNorm 论文，
--another paper trying to explain BashNorm. 01:12:13,320 --> 01:12:14,840
另一篇试图解释 BashNorm 的论文。
--Haven't we seen a lot of these? 01:12:16,040 --> 01:12:17,400
我们不是见过很多这样的吗？
--And this just goes to show that these things 01:12:17,400 --> 01:12:21,480
这只是表明这些事情
--that are very, very standard, 01:12:21,480 --> 01:12:23,560
非常非常标准，
--there's still a lot of unclarity 01:12:23,560 --> 01:12:28,600
还有很多不明之处
--about what they're actually doing, 01:12:28,600 --> 01:12:30,200
关于他们实际在做什么，
--despite the fact that they are very widely used 01:12:30,200 --> 01:12:32,360
尽管它们被广泛使用
--throughout all deep learning. 01:12:32,360 --> 01:12:34,680
贯穿所有深度学习。
--And as a very last point, 01:12:36,120 --> 01:12:38,200
最后一点，
--I just want to make another point, 01:12:39,080 --> 01:12:41,480
我只想再说明一点，
--which is that in recent years, 01:12:41,480 --> 01:12:43,240
也就是近年来，
--actually BashNorm has seen another kind of life 01:12:43,240 --> 01:12:46,120
其实 BashNorm 看到了另一种生活
--as a technique for adapting to shifting distributions. 01:12:46,760 --> 01:12:51,720
作为一种适应变化分布的技术。
--So I don't want to get too much into this, 01:12:51,720 --> 01:12:52,840
所以我不想过多地涉及这个，
--because it's actually a whole nother topic 01:12:52,840 --> 01:12:54,840
因为这实际上是另一个话题
--in machine learning. 01:12:54,840 --> 01:12:55,640
在机器学习中。
--But one sort of very common, 01:12:56,520 --> 01:12:58,520
但是一种很常见的，
--one kind of growing realization, 01:13:00,920 --> 01:13:02,920
一种成长的觉悟，
--I think, amongst deep learning 01:13:02,920 --> 01:13:04,120
我认为，在深度学习中
--is that it's very important to understand 01:13:04,120 --> 01:13:06,360
是理解这一点非常重要
--how methods will do, 01:13:06,360 --> 01:13:08,200
方法将如何做，
--not just when they're evaluated 01:13:08,200 --> 01:13:09,320
不仅仅是在他们被评估的时候
--on the same distribution as they are trained upon, 01:13:09,320 --> 01:13:11,400
在与他们接受训练相同的分布上，
--but when they're evaluated 01:13:11,400 --> 01:13:12,600
但是当他们被评估时
--on somehow a different distribution. 01:13:12,600 --> 01:13:14,280
在某种程度上不同的分布。
--This is a setting called distribution shift. 01:13:14,280 --> 01:13:15,800
这是一个称为分配转移的设置。
--And what people have found is that if you, 01:13:16,440 --> 01:13:20,840
人们发现如果你，
--this is a paper, 01:13:21,000 --> 01:13:21,960
这是一张纸，
--it's from a paper called Tent, 01:13:21,960 --> 01:13:23,400
它来自一篇名为 Tent 的论文，
--based upon actually a different approach, 01:13:23,400 --> 01:13:24,600
实际上是基于一种不同的方法，
--but they use BashNorm as a baseline in this paper here. 01:13:24,600 --> 01:13:30,440
但他们在本文中使用 BashNorm 作为基准。
--So I'm going to use it. 01:13:30,440 --> 01:13:31,560
所以我要用它。
--There are other papers that are showing 01:13:31,560 --> 01:13:32,520
还有其他论文正在展示
--that it actually works as a baseline. 01:13:32,520 --> 01:13:33,720
它实际上可以作为基线。
--And so the point I want to make here 01:13:35,480 --> 01:13:38,280
所以我想在这里强调的一点
--is that this plot here 01:13:38,280 --> 01:13:41,080
是这里的情节吗
--shows a bunch of performances of different classifiers, 01:13:41,080 --> 01:13:45,080
展示了一堆不同分类器的表现，
--such as showing their error 01:13:45,080 --> 01:13:46,520
比如显示他们的错误
--when you give corrupt data in different ways. 01:13:46,520 --> 01:13:49,400
当您以不同方式提供损坏的数据时。
--So this sort of shows the error on the original data. 01:13:49,400 --> 01:13:51,640
所以这种显示原始数据的错误。
--And then you can corrupt the data 01:13:51,640 --> 01:13:53,720
然后你可以破坏数据
--with like Gaussian noise 01:13:53,720 --> 01:13:55,080
具有类似高斯噪声
--or different like motion blur, 01:13:55,080 --> 01:13:57,640
或不同的运动模糊，
--stuff like this, 01:13:57,640 --> 01:13:58,280
像这样的东西，
--or zooming and stuff like this. 01:13:58,280 --> 01:14:00,120
或缩放之类的东西。
--So when you corrupt the images, 01:14:00,120 --> 01:14:01,800
所以当你破坏图像时，
--in some sense, 01:14:01,800 --> 01:14:02,680
在某种意义上，
--the performance of the classifiers drops a lot. 01:14:02,680 --> 01:14:04,760
分类器的性能下降了很多。
--So the original classifier, 01:14:04,760 --> 01:14:06,920
所以原始分类器，
--before it got a little less than 25% accuracy, 01:14:06,920 --> 01:14:09,320
在它的准确率略低于 25% 之前，
--and now I think this is on ImageNet. 01:14:09,320 --> 01:14:10,520
现在我认为这是在 ImageNet 上。
--And so when you corrupt it, 01:14:10,520 --> 01:14:12,440
所以当你破坏它时，
--it goes down to like 60% error. 01:14:12,440 --> 01:14:15,320
它下降到大约 60% 的错误。
--So before it was 25% error, 01:14:15,320 --> 01:14:18,680
所以在出现 25% 错误之前，
--now it's 60% error. 01:14:18,680 --> 01:14:19,720
现在是 60% 的错误。
--What people have found 01:14:21,160 --> 01:14:22,120
人们发现了什么
--is that if you just run batch norm at test time, 01:14:22,680 --> 01:14:27,560
是如果你只是在测试时运行批量归一化，
--so the thing we were trying to avoid doing 01:14:27,560 --> 01:14:30,120
所以我们试图避免做的事情
--by computing those running means, 01:14:30,120 --> 01:14:31,960
通过计算那些运行方式，
--but if you ignore that 01:14:31,960 --> 01:14:32,920
但如果你忽略它
--and just embrace the kind of chaos 01:14:32,920 --> 01:14:35,320
拥抱那种混乱
--of having batch dependency at test time, 01:14:35,320 --> 01:14:39,480
在测试时具有批处理依赖性，
--this substantially improves the performance, 01:14:40,600 --> 01:14:45,960
这大大提高了性能，
--not to the level of the original dataset, 01:14:45,960 --> 01:14:47,800
没有达到原始数据集的水平，
--but it substantially improves performance 01:14:47,960 --> 01:14:49,560
但它大大提高了性能
--on distribution shift of your classifiers. 01:14:50,120 --> 01:14:51,960
关于分类器的分布转移。
--And so batch norm, 01:14:52,520 --> 01:14:54,040
所以批量规范，
--all I will say here, 01:14:54,040 --> 01:14:55,480
我要在这里说的，
--this is probably all I, 01:14:55,480 --> 01:14:56,520
这可能是我的全部，
--yeah, that's enough detail on this for now. 01:14:56,520 --> 01:14:59,240
是的，现在已经足够详细了。
--But what I will say here 01:14:59,240 --> 01:15:00,280
但是我要在这里说的
--is that batch norm is getting 01:15:00,280 --> 01:15:01,480
是批量规范正在得到
--this kind of second life as a method 01:15:01,480 --> 01:15:03,800
这种作为方法的第二人生
--for improving the performance of classifiers 01:15:04,920 --> 01:15:07,960
用于提高分类器的性能
--and distribution shifts. 01:15:07,960 --> 01:15:08,760
和分布转移。
--So this technique developed 01:15:08,760 --> 01:15:11,400
于是开发了这项技术
--to help optimization or avoid dropout, 01:15:11,400 --> 01:15:14,440
帮助优化或避免丢失，
--which then got viewed instead 01:15:15,400 --> 01:15:17,480
然后被查看了
--as a sort of technique 01:15:17,720 --> 01:15:18,440
作为一种技术
--for improving optimization, 01:15:18,440 --> 01:15:19,560
为了改进优化，
--but maybe not, 01:15:20,680 --> 01:15:21,400
但也许不是，
--is now also getting a second life 01:15:22,280 --> 01:15:23,960
现在也得到了第二次生命
--as that or a third life or whatever 01:15:23,960 --> 01:15:26,360
作为那个或第三人生或其他
--as a technique for helping networks 01:15:26,360 --> 01:15:29,160
作为一种帮助网络的技术
--be more robust to distributional shift. 01:15:29,160 --> 01:15:31,000
对分配转移更稳健。
--So it's just crazy. 01:15:31,000 --> 01:15:32,600
所以这太疯狂了。
--I mean, this is a simple one line formula, right? 01:15:32,600 --> 01:15:35,320
我的意思是，这是一个简单的单行公式，对吧？
--It's crazy how much life this idea has gotten 01:15:35,320 --> 01:15:38,760
这个想法得到了多少生命真是太疯狂了
--over the course of machine learning 01:15:38,760 --> 01:15:41,240
在机器学习的过程中
--or the course of the last five years 01:15:41,240 --> 01:15:43,480
或过去五年的历程
--of deep learning. 01:15:43,480 --> 01:15:44,200
的深度学习。
--So that's actually all I'm going to say 01:15:44,600 --> 01:15:47,640
这就是我要说的
--on this for now. 01:15:47,640 --> 01:15:48,440
暂时就此而言。
--But the last sort of point 01:15:49,720 --> 01:15:53,640
但最后一点
--I want to make on this 01:15:53,640 --> 01:15:54,680
我想做这个
--before we end for today 01:15:54,680 --> 01:15:56,280
在我们结束今天之前
--is that this whole discussion, 01:15:56,280 --> 01:15:59,240
是整个讨论，
--and this was just one example, right? 01:16:00,040 --> 01:16:01,240
这只是一个例子，对吧？
--I covered a whole set of techniques here, 01:16:01,240 --> 01:16:03,400
我在这里介绍了一整套技术，
--different optimizers, 01:16:03,400 --> 01:16:04,360
不同的优化器，
--different initializations, 01:16:04,360 --> 01:16:05,960
不同的初始化，
--different normalization techniques, 01:16:05,960 --> 01:16:07,320
不同的归一化技术，
--different regularization techniques. 01:16:07,320 --> 01:16:09,240
不同的正则化技术。
--This discussion, 01:16:09,880 --> 01:16:10,760
这个讨论，
--just in the case of batch norm, 01:16:11,560 --> 01:16:13,400
就批量规范而言，
--and there are similar discussions, 01:16:14,200 --> 01:16:15,160
并且有类似的讨论，
--by the way, for dropout 01:16:15,160 --> 01:16:16,600
顺便说一句，对于辍学
--and for weight decay and such, 01:16:16,600 --> 01:16:19,800
对于重量衰减等，
--it may give the impression 01:16:23,320 --> 01:16:25,320
它可能给人的印象
--that these things are just random hacks 01:16:25,320 --> 01:16:28,360
这些东西只是随机的黑客攻击
--for which we have no real principled understanding 01:16:28,360 --> 01:16:31,160
对此我们没有真正的原则性理解
--and deep learning 01:16:31,160 --> 01:16:31,880
和深度学习
--and sometimes it's all about random hacks, right? 01:16:31,880 --> 01:16:34,840
有时这完全是关于随机黑客，对吧？
--You just try out different things 01:16:34,840 --> 01:16:35,960
你只是尝试不同的东西
--and sometimes they work 01:16:35,960 --> 01:16:36,840
有时他们工作
--and how on earth could you figure out 01:16:36,840 --> 01:16:38,120
你到底是怎么知道的
--what's actually going to work? 01:16:38,120 --> 01:16:38,840
什么才是真正有效的？
--And I don't want to give that impression, 01:16:39,800 --> 01:16:43,800
我不想给人这样的印象，
--I think there's been a lot of really excellent 01:16:44,200 --> 01:16:47,000
我认为有很多非常优秀的
--scientific experimentation 01:16:47,000 --> 01:16:48,600
科学实验
--with all of the above. 01:16:48,600 --> 01:16:49,880
以上所有。
--So even if you can't quite analyze it theoretically, 01:16:49,880 --> 01:16:52,040
所以即使你不能完全从理论上分析它，
--you can often analyze these things empirically 01:16:52,040 --> 01:16:53,960
你通常可以凭经验分析这些东西
--in a very scientific principled manner 01:16:53,960 --> 01:16:56,360
以非常科学的原则方式
--and there's been a lot of excellent work that does this. 01:16:56,360 --> 01:16:58,600
已经有很多出色的工作可以做到这一点。
--However, it is also true 01:16:59,560 --> 01:17:02,600
然而，这也是事实
--that we do not have yet a complete picture 01:17:02,600 --> 01:17:05,640
我们还没有完整的图片
--of how all the different empirical tricks 01:17:06,200 --> 01:17:08,760
所有不同的经验技巧如何
--and techniques that I've introduced there 01:17:08,760 --> 01:17:10,680
和我在那里介绍的技术
--really are really work 01:17:10,680 --> 01:17:12,360
真的很努力
--and how they interact in the real world. 01:17:12,440 --> 01:17:14,440
以及他们在现实世界中如何互动。
--And so this again might give you the impression 01:17:16,280 --> 01:17:19,720
所以这又会给你这样的印象
--that in order to get deep learning systems to work, 01:17:19,720 --> 01:17:21,960
为了让深度学习系统工作，
--you have to sort of try out 01:17:21,960 --> 01:17:23,400
你必须尝试一下
--all possible combinations to find the one that works. 01:17:23,400 --> 01:17:26,040
所有可能的组合以找到有效的组合。
--But I also want to push back against this 01:17:27,160 --> 01:17:29,000
但我也想反对这个
--because the good news in many cases 01:17:29,800 --> 01:17:32,520
因为在很多情况下是好消息
--is that while these things are all useful tools 01:17:32,520 --> 01:17:36,760
是虽然这些东西都是有用的工具
--and you should have all these different, 01:17:37,560 --> 01:17:39,800
你应该有所有这些不同的，
--you should get some empirical experience with them, 01:17:39,800 --> 01:17:41,720
你应该从中获得一些经验，
--you need the empirical experience to understand 01:17:41,720 --> 01:17:43,960
你需要经验来理解
--when they may be useful 01:17:44,760 --> 01:17:45,960
什么时候有用
--and when they might be coming to play here. 01:17:45,960 --> 01:17:47,880
以及他们什么时候可能会来这里玩。
--The good news is that in many cases, 01:17:48,920 --> 01:17:51,720
好消息是，在许多情况下，
--it is actually possible to get similarly good results 01:17:51,720 --> 01:17:54,840
实际上可以获得类似的好结果
--with very different architectural 01:17:54,840 --> 01:17:56,680
具有非常不同的建筑
--and methodological choices. 01:17:56,680 --> 01:17:57,800
和方法论的选择。
--So you could have one architecture 01:17:58,360 --> 01:17:59,880
所以你可以有一个架构
--that uses dropout, one that doesn't, 01:17:59,880 --> 01:18:01,560
一个使用 dropout，一个不使用，
--one that uses normalization, 01:18:01,560 --> 01:18:02,920
一个使用归一化，
--one that uses batch norm, one that uses layer norm. 01:18:02,920 --> 01:18:04,520
一种使用批量规范，一种使用层规范。
--If you understand how to tune your architecture 01:18:05,080 --> 01:18:07,720
如果您了解如何调整架构
--and kind of take greedy steps 01:18:07,720 --> 01:18:09,160
采取贪婪的步骤
--along its route, 01:18:09,880 --> 01:18:11,960
沿着它的路线，
--there's a very good chance you will end up 01:18:13,320 --> 01:18:14,600
你很有可能会结束
--with very similar performance 01:18:14,600 --> 01:18:16,040
性能非常相似
--as potentially a very different method. 01:18:16,040 --> 01:18:18,440
可能是一种非常不同的方法。
--And in some sense, I think that one of the lessons 01:18:18,440 --> 01:18:20,360
在某种意义上，我认为其中一个教训
--of deep learning over the past several years 01:18:20,360 --> 01:18:21,880
过去几年的深度学习
--is that, yes, there are advantages 01:18:21,880 --> 01:18:23,800
是的，是的，有优势
--for methodologies here, 01:18:23,800 --> 01:18:25,080
对于这里的方法，
--but also it's sort of shocking 01:18:25,080 --> 01:18:28,040
但也有点令人震惊
--how similar a lot, in many cases, 01:18:28,040 --> 01:18:30,440
在很多情况下，多么相似，
--a lot of very different architectures 01:18:30,440 --> 01:18:32,360
许多非常不同的架构
--and methods really work. 01:18:32,360 --> 01:18:33,880
方法确实有效。
--So these techniques are ones 01:18:34,520 --> 01:18:36,200
所以这些技术是
--you should all be familiar with. 01:18:36,200 --> 01:18:37,400
大家应该都不陌生。
--We're actually going to sort of stop here 01:18:37,400 --> 01:18:39,080
我们实际上要在这里停下来
--when it comes to these sort of different tips 01:18:39,080 --> 01:18:42,280
当涉及到这些不同的技巧时
--and training techniques and different variants. 01:18:42,280 --> 01:18:44,360
和培训技术和不同的变体。
--This is, I think, a sufficient knowledge 01:18:44,920 --> 01:18:46,520
我认为这是足够的知识
--to proceed now to different architectures 01:18:46,520 --> 01:18:49,400
现在继续不同的架构
--and stuff like that. 01:18:49,400 --> 01:18:50,040
之类的东西。
--But you should know these tricks and these tips, 01:18:50,600 --> 01:18:57,080
但是你应该知道这些技巧和这些技巧，
--but you should also know 01:18:57,080 --> 01:18:57,960
但你也应该知道
--that you can get good performance 01:18:57,960 --> 01:18:59,240
你可以获得良好的性能
--with a variety of different methods. 01:18:59,960 --> 01:19:01,800
用各种不同的方法。
--And in fact, next lecture, 01:19:02,600 --> 01:19:03,720
事实上，下一节课，
--we're going to start diving into some of these, 01:19:03,720 --> 01:19:05,880
我们将开始深入研究其中的一些，
--not just sort of more kind of generic, 01:19:06,520 --> 01:19:12,680
不仅仅是一种更通用的，
--but sort of methodological tricks you can use, 01:19:12,680 --> 01:19:15,560
但是你可以使用一些方法上的技巧，
--but we're going to instead start talking about 01:19:15,560 --> 01:19:17,720
但我们要开始谈论
--kind of standard, 01:19:17,720 --> 01:19:18,680
一种标准，
--more structured architectural choices 01:19:18,680 --> 01:19:20,920
更结构化的架构选择
--using the example of convolutional networks 01:19:20,920 --> 01:19:22,920
使用卷积网络的例子
--in the next lecture. 01:19:22,920 --> 01:19:23,640
在下一讲中。
--So that's it for these sorts of tricks, 01:19:24,680 --> 01:19:27,400
这就是这些技巧，
--and we'll see everyone next time. 01:19:27,400 --> 01:19:29,160
我们下次再见。
