--All right. Hello, everyone, and welcome to today's lecture on convolutional networks. 00:00:00,000 --> 00:00:07,600
好的。大家好，欢迎来到今天的卷积网络讲座。
--Convolutional networks are a structured form of network that is commonly used in images 00:00:07,600 --> 00:00:13,360
卷积网络是一种结构化的网络形式，常用于图像中
--but also used in things like sequences or audio or other similar domains. And it's not 00:00:13,360 --> 00:00:19,440
但也用于序列或音频或其他类似领域。它不是
--too much of an exaggeration to say that convolutional networks are in some sense historically the 00:00:19,440 --> 00:00:24,880
说卷积网络在某种意义上在历史上是
--most important structured deep network, at least in the history of deep learning so far. 00:00:24,880 --> 00:00:30,320
最重要的结构化深度网络，至少在迄今为止的深度学习史上。
--So I know that things like transformers are getting a bit more popular these days, but 00:00:30,320 --> 00:00:34,400
所以我知道像变形金刚这样的东西现在越来越流行了，但是
--if you look back at kind of the influence that networks have had, it's hard to overstate 00:00:34,400 --> 00:00:40,240
如果你回顾一下网络所产生的影响，怎么强调都不为过
--the impact of convolutional networks on the field of deep learning. So we're going to 00:00:40,240 --> 00:00:43,600
卷积网络对深度学习领域的影响。所以我们要
--talk about these today. Now, today is going to be a bit of kind of a look ahead to a certain 00:00:43,600 --> 00:00:47,480
今天说说这些。现在，今天将是对某个特定事物的展望
--extent. Much of our later course is going to focus on different structures of networks, 00:00:47,480 --> 00:00:51,920
程度。我们后面的大部分课程将关注不同的网络结构，
--so convolutional networks. We'll also talk about recurrent networks and transformers. 00:00:52,160 --> 00:00:56,480
所以卷积网络。我们还将讨论循环网络和变压器。
--But today it's going to be a bit of a look ahead. And after this lecture, we're going 00:00:57,200 --> 00:01:00,400
但今天它会有点向前看。听完这节课，我们要去
--to come back to more concrete issues of implementation of linear algebra. But in 00:01:00,400 --> 00:01:08,800
回到线性代数实现的更具体问题。但在
--order to implement convolutions, we'll actually need that. And so to motivate, in some sense, 00:01:08,800 --> 00:01:13,120
为了实现卷积，我们实际上需要它。因此，在某种意义上，为了激励，
--some of the later work that we're going to be doing in efficient linear algebra, 00:01:13,120 --> 00:01:17,520
我们将在高效线性代数中进行的一些后期工作，
--we're going to first talk about this structured form of network called convolutional networks. 00:01:17,520 --> 00:01:22,160
我们将首先讨论这种称为卷积网络的结构化网络形式。
--All right, so let's jump in. The outline for today is we're first going to talk about 00:01:23,120 --> 00:01:27,360
好吧，让我们开始吧。今天的大纲是我们首先要讨论的
--convolutional operators. What is a convolutional operator? How do you incorporate it in a deep 00:01:27,360 --> 00:01:31,120
卷积运算符。什么是卷积运算符？你如何将它融入深层次的
--network? Then we'll talk about some practical elements of convolutions. And finally, we'll end 00:01:31,120 --> 00:01:36,320
网络？然后我们将讨论卷积的一些实际元素。最后，我们将结束
--talking about how we differentiate convolutions. In other words, how do we incorporate these things 00:01:36,320 --> 00:01:41,680
谈论我们如何区分卷积。换句话说，我们如何整合这些东西
--into automatic differentiation tools? All right, so let's first talk about 00:01:41,760 --> 00:01:46,320
进入自动微分工具？好吧，那么让我们先谈谈
--convolutional operators in deep networks. So far in this class, we've been considering 00:01:46,320 --> 00:01:53,760
深度网络中的卷积运算符。到目前为止，在这门课上，我们一直在考虑
--networks that essentially treat entire image inputs as vectors. So when you implemented, 00:01:53,760 --> 00:01:59,680
本质上将整个图像输入视为向量的网络。所以当你实施时，
--if you have yet implemented homework one, or homework two, rather, the first thing you did 00:01:59,680 --> 00:02:06,000
如果你还没有完成家庭作业一，或者家庭作业二，而是你做的第一件事
--was when you applied a network to the MNIST dataset is you first flattened the images. So 00:02:06,000 --> 00:02:12,000
当您将网络应用于 MNIST 数据集时，您首先将图像展平。所以
--you took all the structure of an image. It's a 2D shape, and it only has one channel in MNIST. 00:02:12,000 --> 00:02:17,920
您采用了图像的所有结构。它是一个二维形状，在 MNIST 中只有一个通道。
--But you took this whole 2D shape, and you just flattened it into one long vector with 784 00:02:17,920 --> 00:02:23,200
但是你采用了整个 2D 形状，然后用 784 将它展平为一个长向量
--elements. And this works okay for MNIST-sized digits that are 28 by 28. And therefore, 00:02:23,200 --> 00:02:29,840
元素。这适用于 28 x 28 的 MNIST 大小的数字。因此，
--the vector representation only has 784 different components. It's quite a different thing if you 00:02:29,840 --> 00:02:35,440
矢量表示只有 784 个不同的组件。如果你
--have larger images. This does not scale as an approach, right? Because if you had something like 00:02:35,440 --> 00:02:41,200
有更大的图像。这不是一种方法，对吧？因为如果你有类似的东西
--a 256 by 256 RGB image, that would result in about 200,000. So three channels times 256 times 256, 00:02:41,200 --> 00:02:53,760
一个 256 x 256 RGB 图像，这将导致大约 200,000。所以三个通道乘以 256 乘以 256，
--that's about 200,000 dimensional inputs. And if you wanted to just map that to a single 00:02:53,760 --> 00:03:00,080
那是大约 200,000 个维度输入。如果你只想把它映射到一个
--hidden layer that was, say, 1,000 dimensional, that would require 200 million parameters. Now, 00:03:00,080 --> 00:03:08,160
例如，1,000 维的隐藏层需要 2 亿个参数。现在，
--this slide used to be more impressive when no one would ever think about a model that big. 00:03:08,160 --> 00:03:11,520
当没有人想到这么大的模型时，这张幻灯片曾经更令人印象深刻。
--Of course, now it seems a bit less extensive as a network size, because people, of course, 00:03:12,640 --> 00:03:17,520
当然，现在它作为一个网络规模似乎有点不那么广泛了，因为人们，当然，
--train these kind of networks all the time. But for a fully connected layer, that is far, far too 00:03:17,520 --> 00:03:23,120
一直训练这些网络。但是对于一个全连接层来说，那是太远了
--much. There's way too many parameters for a single hidden layer in a network that processes an image. 00:03:23,120 --> 00:03:29,360
很多。在处理图像的网络中，单个隐藏层的参数太多了。
--And the reality is, this would just not capture nearly enough structure in the image to actually 00:03:30,160 --> 00:03:34,000
而现实情况是，这并不能捕捉到足够多的图像结构
--capture it very well. So it's a whole lot of parameters for any practical method. But the 00:03:34,000 --> 00:03:39,840
很好地捕捉它。所以它是任何实用方法的一大堆参数。但是
--second thing is it just wouldn't work that well. And the reason why it doesn't work that well, 00:03:39,840 --> 00:03:43,760
第二件事是它不会那么好用。以及为什么效果不佳的原因，
--besides just involving too many parameters that are going to overfit to your data, is that it 00:03:43,760 --> 00:03:48,000
除了涉及太多会过度拟合您的数据的参数之外，是不是
--doesn't capture the intuitive invariances that we could expect to have in an image. So we kind of 00:03:48,000 --> 00:03:54,320
没有捕捉到我们期望在图像中具有的直观不变性。所以我们有点
--know that if you take an image and you shift it over by one pixel, it's the same image, right? 00:03:54,320 --> 00:03:57,840
知道如果你拍摄一张照片并将它移动一个像素，它就是同一张照片，对吧？
--The image itself doesn't change. But if you think about what we're doing here, we're sort of taking 00:03:57,840 --> 00:04:02,240
图像本身不会改变。但如果你想想我们在这里做的事情，我们有点
--this whole, to create a single hidden unit, we're taking this whole image, multiplying it by the, 00:04:02,240 --> 00:04:08,720
整个，为了创建一个隐藏单元，我们将整个图像乘以，
--flattening it, multiplying it by a single row or column in a matrix, and we're sort of forming, 00:04:08,720 --> 00:04:14,080
将其展平，将其乘以矩阵中的单行或单列，然后我们就形成了，
--that's all to form this one single entry in our hidden unit, right? And then the next hidden unit 00:04:14,080 --> 00:04:18,960
这就是在我们的隐藏单元中形成这个单一条目的全部，对吧？然后是下一个隐藏单元
--here would have a whole new set of weights multiplied by this, right? And we multiply 00:04:18,960 --> 00:04:22,880
这里会有一组全新的权重乘以这个，对吧？我们乘以
--every single element in the input by a whole other set of weights for this. And this just 00:04:22,880 --> 00:04:27,040
输入中的每个元素都为此设置了另一组权重。而这只是
--doesn't seem to sort of capture the actual structure we know that there is in images. 00:04:27,040 --> 00:04:32,080
似乎并没有捕捉到我们知道图像中存在的实际结构。
--And to be clear, this notion of trying to embed structure into the architectures of deep networks 00:04:32,080 --> 00:04:39,840
需要明确的是，这种试图将结构嵌入到深度网络架构中的概念
--that is in some sense matched well with the input, that is in some sense the key idea that will 00:04:39,840 --> 00:04:48,160
从某种意义上说，它与输入匹配得很好，从某种意义上说，这是关键思想
--dominate the design of deep learning architectures in practice, right? We want some sort of design 00:04:48,160 --> 00:04:53,920
在实践中主导深度学习架构的设计，对吧？我们想要某种设计
--for the architecture that preserves the kind of structure that we want, that we have in the image. 00:04:54,000 --> 00:04:58,960
对于保留我们想要的结构类型的架构，我们在图像中拥有。
--And so what convolutions are, our convolutions are in some sense a simplification of this idea 00:05:00,320 --> 00:05:06,400
那么卷积是什么，我们的卷积在某种意义上是这个想法的简化
--by two basic premises. And the first premise is that instead of, well, I should say the, 00:05:08,320 --> 00:05:15,760
由两个基本前提。第一个前提是，我应该说，而不是，
--sort of the zeroth premise, is that instead of representing our hidden units just as a, 00:05:15,760 --> 00:05:20,800
第零个前提是，不是将我们的隐藏单元表示为，
--itself an unstructured vector like our input, we're actually going to represent our hidden 00:05:20,880 --> 00:05:24,400
本身是一个非结构化向量，就像我们的输入一样，我们实际上将代表我们隐藏的
--units also in some sense as an image, as, I shouldn't really say images because images 00:05:24,400 --> 00:05:29,440
单位在某种意义上也作为图像，因为，我不应该说图像因为图像
--usually mean sort of channels we can see, but as a 2D, really 3D tensor that have kind of spatial 00:05:29,440 --> 00:05:36,000
通常意味着我们可以看到的某种通道，但作为一个 2D，真正的 3D 张量，具有某种空间
--locations and then multiple channels eventually. Here I'm just showing multiple spatial locations. 00:05:36,000 --> 00:05:41,040
位置，然后最终是多个渠道。这里我只是展示多个空间位置。
--We'll later add multiple channels in a second. But in this case, we're going to think of our 00:05:41,040 --> 00:05:45,600
我们稍后会在一秒钟内添加多个频道。但在这种情况下，我们要考虑我们的
--hidden vectors here as also 2D objects representing kind of locations in an image. 00:05:45,600 --> 00:05:52,480
这里的隐藏向量也是表示图像中某种位置的 2D 对象。
--And convolutions have two properties. The first is that these interactions happen in some sense 00:05:53,280 --> 00:06:01,600
卷积有两个属性。首先是这些相互作用在某种意义上发生
--in a local manner. So this hidden unit there is influenced primarily, or maybe solely, by the 00:06:01,600 --> 00:06:10,560
以当地的方式。所以这个隐藏单元主要或可能完全受
--the inputs in the previous layer that are in some sense near that spatial location, right? 00:06:11,360 --> 00:06:18,000
前一层的输入在某种意义上靠近那个空间位置，对吧？
--So we treat the, this is sort of point zero and one, I suppose, we treat the images, we treat 00:06:18,000 --> 00:06:22,800
所以我们对待，这是零点和一点，我想，我们对待图像，我们对待
--the hidden layers as spatial images, and we have the weights only apply locally to images in the 00:06:22,800 --> 00:06:30,800
隐藏层作为空间图像，我们的权重只应用于局部图像
--input to produce the hidden layers. And so the sort of vision of what that looks like here is 00:06:30,800 --> 00:06:33,920
输入以产生隐藏层。所以这里看起来像的那种愿景是
--that it's only these set of pixels multiplied by our weight that results in the next, in this 00:06:33,920 --> 00:06:41,520
只有这些像素集乘以我们的权重才能得出下一个，在这个
--single location in the next layer, right? So that's the first premise, this local interaction. 00:06:41,520 --> 00:06:46,000
单个位置在下一层，对吧？这就是第一个前提，即本地交互。
--The second premise is that weights are shared across locations. So rather than have sort of 00:06:46,720 --> 00:06:51,120
第二个前提是权重是跨位置共享的。所以而不是有点
--one set of weights for this hidden unit and a whole nother set of weights for this hidden unit, 00:06:51,120 --> 00:06:55,360
这个隐藏单元的一组权重和这个隐藏单元的另一组权重，
--we take the same weight and we use that same weight kind of slid across the whole image 00:06:55,360 --> 00:07:02,560
我们采用相同的权重，并使用相同的权重在整个图像上滑动
--to produce our next layer. And this structure is exactly what is known as a convolution. 00:07:02,560 --> 00:07:09,440
产生我们的下一层。而这种结构正是所谓的卷积。
--So what we're doing here essentially, the sort of slightly more kind of formal look of this, 00:07:09,440 --> 00:07:15,040
所以我们在这里所做的本质上是一种稍微正式一点的外观，
--is that we are able, actually before I do that, let me let me talk about the advantages of 00:07:15,040 --> 00:07:19,520
是我们能够，实际上在我这样做之前，让我先谈谈优势
--convolutions first, then I'll look at it a little bit more formally. So what are the advantages of 00:07:19,520 --> 00:07:24,480
首先是卷积，然后我会更正式地看一下它。那么它的优点是什么
--doing this? Why might we want to, might we want to sort of build in this structure here? 00:07:24,480 --> 00:07:29,680
做这个？为什么我们想要，我们可能想要在这里构建这种结构？
--Well, there's a lot of advantages to it. The first obvious one is parameter count, right? So the 00:07:30,640 --> 00:07:36,160
好吧，它有很多优点。第一个明显的是参数计数，对吧？所以
--first kind of obvious thing that we gain from this is we gain a whole lot of parameter efficiency, 00:07:36,160 --> 00:07:41,520
我们从中获得的第一个显而易见的事情是我们获得了大量的参数效率，
--right? Rather than having this network with 200 million parameters, in the simple case here, 00:07:41,520 --> 00:07:47,280
正确的？而不是让这个网络有 2 亿个参数，在这个简单的例子中，
--where we're sort of mapping a one channel input to a one channel output via this sort of three 00:07:47,280 --> 00:07:53,200
我们通过这种三通道将单通道输入映射到单通道输出
--by three block of weights here, we actually only need nine parameters, right? So that's going from, 00:07:53,200 --> 00:08:00,240
通过这里的三块权重，我们实际上只需要九个参数，对吧？所以这是从
--you know, from, I guess actually if we had even more network, so if we went mapped from a 00:08:00,240 --> 00:08:06,080
你知道，从，我想实际上如果我们有更多的网络，那么如果我们从
--256 by 256 grayscale image to a actual hidden unit of the same size, that would require four 00:08:06,960 --> 00:08:13,200
256 x 256 灰度图像到相同大小的实际隐藏单元，这将需要四个
--billion parameters for sort of a single layer. And that is definitely too much. On the flip side, 00:08:13,200 --> 00:08:19,440
单层排序的十亿个参数。这绝对太多了。另一方面，
--if you do it with this convolutional structure, you need nine parameters, right? Because you just 00:08:19,440 --> 00:08:22,640
如果你用这个卷积结构来做，你需要九个参数，对吧？因为你只是
--have the same weight that you slide across the whole image. And of course, this is sort of, 00:08:22,640 --> 00:08:26,720
具有与您在整个图像上滑动相同的权重。当然，这有点像，
--with that, you have much less, fewer functions you can represent. Of course, your function 00:08:28,400 --> 00:08:32,240
这样一来，您可以表示的功能就会少得多。当然，你的功能
--classes is vastly less than you could, than you could represent over, you know, a fully connected 00:08:32,240 --> 00:08:36,080
类远远少于你所能代表的，你知道的，一个完全连接的
--network here. But because we're capturing this, this structure that you actually want to capture, 00:08:36,080 --> 00:08:42,160
网络在这里。但是因为我们正在捕捉这个，这个你真正想要捕捉的结构，
--it's very beneficial to do so, right? So it's very beneficial to actually capture the structure, 00:08:42,800 --> 00:08:48,560
这样做很有好处，对吧？所以实际捕捉结构是非常有益的，
--and kind of a side effect is that you have many, you have many fewer parameters you can 00:08:48,560 --> 00:08:52,240
一种副作用是你有很多，你可以有更少的参数
--represent your network much more efficiently. The other advantage is that this captures some of the 00:08:52,240 --> 00:08:57,760
更有效地代表您的网络。另一个优点是，这捕获了一些
--actual invariances we want anyway, right? So fewer parameters, and it actually captures these 00:08:57,760 --> 00:09:02,320
无论如何，我们想要的实际不变性，对吧？参数更少，它实际上捕获了这些
--advantages because convolutions, at least to a certain degree, capture the natural invariances 00:09:02,320 --> 00:09:08,640
优点是因为卷积至少在一定程度上捕获了自然不变性
--that we kind of think about in images. So for example, I talked about before that an image 00:09:08,640 --> 00:09:13,680
我们在图像中思考。例如，我之前谈到过一张图片
--shifted over by one pixel is the same image. But if we had a different set of weights for each 00:09:13,680 --> 00:09:18,960
移动一个像素是相同的图像。但是如果我们为每个人设置不同的权重
--location, right? Each location there, location there, etc. This wouldn't actually, or each hidden 00:09:18,960 --> 00:09:24,480
位置对吧？那里的每个位置，那里的位置等等。这实际上不是，或者每个隐藏的
--unit, now this is one set of weights, it's another set of weights here. This would not capture those 00:09:24,480 --> 00:09:29,440
单位，现在这是一组权重，这里是另一组权重。这不会捕获那些
--invariances, right? You could have a very, if you shifted your image over by one pixel, now you have 00:09:29,440 --> 00:09:34,560
不变性，对吧？你可以有一个非常，如果你将你的图像移动一个像素，现在你有
--a different set of weights applying to each location. You might have a very sort of, a very 00:09:34,560 --> 00:09:41,440
一组不同的权重应用于每个位置。你可能有一种非常
--different set of hidden units, right? And so this really does, this, with this, we're really able to 00:09:41,440 --> 00:09:47,840
不同的隐藏单元集，对吧？所以这确实如此，有了这个，我们真的能够
--capture the true structure of kind of what we want to have in images anyway, and convolutions 00:09:47,840 --> 00:09:54,960
无论如何捕捉我们想要在图像中拥有的那种真实结构，以及卷积
--bring us this benefit. Okay, so now let me describe what is the, a little bit more formal detail, what 00:09:54,960 --> 00:10:01,040
给我们带来这个好处。好的，现在让我描述一下，更正式一点的细节，什么
--is the actual structure of a convolution. And the idea of a convolution, now written a bit more 00:10:01,040 --> 00:10:07,120
是卷积的实际结构。还有一个卷积的思路，现在写的有点多
--formally, is we have our set of weights here, and we're going to take these weights, and we're going 00:10:07,120 --> 00:10:12,640
正式地，我们这里有我们的权重集吗，我们将采用这些权重，然后我们将
--to, in some sense, slide them across our image. All right, so this is a 3 by 3 set of weights, 00:10:12,640 --> 00:10:18,000
在某种意义上，将它们滑过我们的图像。好吧，这是一组 3 x 3 的权重，
--and we're going to kind of slide them across all possible positions are in our image to produce 00:10:18,000 --> 00:10:22,960
我们将把它们滑过我们图像中所有可能的位置来产生
--the output. So for example, for the first output y11, we would take this block of weights here, 00:10:22,960 --> 00:10:30,800
输出。因此，例如，对于第一个输出 y11，我们将在此处采用此权重块，
--sorry, of inputs here, multiply it by these weights to get this output. All right, so a little bit 00:10:30,800 --> 00:10:38,640
抱歉，这里的输入，乘以这些权重得到这个输出。好吧，就那么一点点
--more formally here, if we want to produce the output y11 here, so here actually the input 00:10:38,640 --> 00:10:46,640
在这里更正式地说，如果我们想在这里产生输出 y11，那么这里实际上是输入
--is a vector z, the weights are a filter w, and, or I should say really a tensor or matrix z, 00:10:47,280 --> 00:10:55,600
是一个向量 z，权重是一个过滤器 w，或者我应该说真的是一个张量或矩阵 z，
--the weights are a tensor or matrix w. We'll talk about sizes in a second, and the output is a 00:10:56,080 --> 00:11:01,120
权重是张量或矩阵 w。我们稍后会讨论大小，输出是
--similar sort of image y. Well, in this case, y11 here would be equal to the product of corresponding 00:11:01,760 --> 00:11:10,480
类似的图像 y。那么，在这种情况下，这里的 y11 将等于相应的乘积
--entries in our filter and our input. So we'd multiply this term by this term, so it's going 00:11:10,480 --> 00:11:17,920
我们过滤器中的条目和我们的输入。所以我们将这个项乘以这个项，所以它会
--to be equal to z11 times w11, plus this term times this term, right, so plus z12 times w12, 00:11:18,000 --> 00:11:33,280
等于 z11 乘以 w11，加上这一项乘以这一项，对，所以加上 z12 乘以 w12，
--plus z13 times w13, etc. All right, so that's the equation. We just take essentially the, 00:11:34,080 --> 00:11:42,160
加上 z13 乘以 w13，等等。好吧，这就是等式。我们基本上只是采取，
--what it really is, of course, is it's just the inner product of this set of inputs treated as 00:11:42,160 --> 00:11:49,040
当然，它实际上只是这组输入的内积，被视为
--a vector, and then the set of weights also, in this case, sort of locally here treated as a vector. 00:11:49,040 --> 00:11:53,440
一个向量，然后是一组权重，在这种情况下，在这里被局部地视为一个向量。
--All right, and then, you know, next we just slide it across to the next location in the image, 00:11:54,320 --> 00:11:58,080
好吧，然后，你知道，接下来我们将它滑到图像中的下一个位置，
--right, so now we would have that y12 equals, well, it would be this position times this position, 00:11:58,080 --> 00:12:05,280
是的，所以现在我们让 y12 等于，嗯，就是这个位置乘以这个位置，
--so it would be z12 times w11, plus z13 times w12, plus etc. So that would be, you know, 00:12:05,280 --> 00:12:17,040
所以它会是 z12 乘以 w11，加上 z13 乘以 w12，再加上等等。你知道，
--this location times this location, plus this location times this location, etc. 00:12:17,040 --> 00:12:20,960
这个位置乘以这个位置，再加上这个位置乘以这个位置，等等。
--Right, and then we just keep doing this. I have it written out here now, so next we slide our 00:12:20,960 --> 00:12:25,760
对，然后我们就继续这样做。我现在已经把它写在这里了，所以接下来我们滑动我们的
--filter across the next location, then the next location, etc. Okay, and that is the op, that's 00:12:25,760 --> 00:12:32,080
过滤下一个位置，然后是下一个位置，等等。好的，这就是操作，就是
--the formal definition of the convolutional operator. Now, one thing I should highlight 00:12:32,080 --> 00:12:37,040
卷积运算符的正式定义。现在，我应该强调一件事
--here is that if any of you have a background in signal processing, you'll notice that this is not 00:12:37,040 --> 00:12:42,000
这是如果你们中有人有信号处理的背景，你会注意到这不是
--actually what you have called a convolution. What you have called a convolution involves flipping 00:12:42,000 --> 00:12:47,200
实际上就是你所说的卷积。你所说的卷积涉及翻转
--the weights left to right and upside down. That's actually the signal processing definition of a 00:12:47,200 --> 00:12:52,080
重量从左到右和颠倒。这实际上是a的信号处理定义
--convolution, but we'll get to those actually flipping in a second, but what we're doing here 00:12:52,080 --> 00:13:01,440
卷积，但我们会在一秒钟内了解那些实际翻转的，但我们在这里做的
--in signal processing is actually called a correlation, but the problem is the correlation 00:13:01,520 --> 00:13:05,120
在信号处理中实际上称为相关性，但问题是相关性
--already means something in statistics and machine learning, so that was a very bad term to use, 00:13:05,120 --> 00:13:09,040
已经在统计和机器学习中意味着一些东西，所以这是一个非常糟糕的术语，
--and convolution just sounds so cool. So, you know, we're going to steal the term convolution 00:13:09,040 --> 00:13:14,400
卷积听起来很酷。所以，你知道，我们要窃取术语卷积
--and just define it to mean the convolution without the flipped filter, and I think at this point, 00:13:14,400 --> 00:13:19,840
并将其定义为没有翻转过滤器的卷积，我认为在这一点上，
--I hate to say it, but I think, like, machine learning is kind of one. Like, it's probably 00:13:20,480 --> 00:13:23,360
我不想这么说，但我认为，机器学习就是其中之一。就像，这可能是
--the dominant use of convolution in some sense in convolutional networks. I'm being somewhat 00:13:23,360 --> 00:13:27,440
在某种意义上卷积网络中卷积的主要使用。我有点
--tongue-in-cheek there, but this is how we define convolutional networks, and so whenever 00:13:27,440 --> 00:13:31,600
开玩笑，但这就是我们定义卷积网络的方式，所以无论何时
--anyone from machine learning talks to you about convolutions, they mean this. They do not mean 00:13:31,600 --> 00:13:35,760
机器学习领域的任何人与您谈论卷积时，他们都是这个意思。他们并不意味着
--the flipped filters or the reverse filter. They mean this, which you may have called a correlation 00:13:35,760 --> 00:13:40,880
翻转过滤器或反向过滤器。他们的意思是，你可能称之为相关性
--before, but just know that this is a convolution, okay? Now, convolutions have actually a long 00:13:40,880 --> 00:13:47,440
之前，但只知道这是一个卷积，好吗？现在，卷积实际上有很长的
--history because they've been used prior to their use in machine learning. They were used in signal 00:13:47,440 --> 00:13:52,800
历史，因为它们在用于机器学习之前就已被使用过。它们被用于信号
--processing for a very long time, so they were used to just do sort of both, I guess, classical 00:13:52,800 --> 00:13:58,640
处理了很长时间，所以他们习惯于同时做两件事，我想，经典的
--signal processing, but also in kind of computer vision and image processing as well, and in 00:13:58,640 --> 00:14:05,120
信号处理，也包括计算机视觉和图像处理，以及
--particular, in image processing for a very long time, convolutions not with learned filters, so 00:14:05,120 --> 00:14:12,960
特别是，在很长一段时间的图像处理中，卷积不使用学习过的过滤器，所以
--in deep networks, we're of course going to treat the weights of the filter as our parameters, 00:14:12,960 --> 00:14:18,480
在深度网络中，我们当然会将过滤器的权重作为我们的参数，
--but in image processing, it's been common for a very long time to use 00:14:18,480 --> 00:14:24,560
但在图像处理中，很长一段时间以来使用
--convolutions kind of with known pre-specified filters as a core operation for sort of 00:14:24,560 --> 00:14:32,000
卷积类型与已知的预先指定的过滤器作为某种核心操作
--doing image processing and image manipulation. So, for example, a common, so if we have this 00:14:32,000 --> 00:14:37,920
做图像处理和图像处理。所以，例如，一个普通的，所以如果我们有这个
--sort of this image here, you see on the left, and suppose we convolve it with this set of 00:14:37,920 --> 00:14:45,760
有点像这里的图像，你在左边看到，假设我们将它与这组
--weights here, so this set of weights is actually a 2D representation of a Gaussian function, just 00:14:45,760 --> 00:14:51,440
这里的权重，所以这组权重实际上是高斯函数的二维表示，只是
--sort of the exponential of the sort of xy position squared here, so it's centered at this 00:14:51,440 --> 00:14:57,600
有点像这里平方的 xy 位置的指数，所以它以这个为中心
--location, and then just divided by some number to sort of make it all, this is actually, this number 00:14:57,600 --> 00:15:02,480
位置，然后除以一些数字来计算全部，这实际上就是这个数字
--here is the sum of all the entries there to make this sort of an averaging operator, but this filter 00:15:02,480 --> 00:15:08,800
这是构成这种平均运算符的所有条目的总和，但是这个过滤器
--sort of does a weighted average of pixels, right? So, you know, this, it's kind of hard to draw too 00:15:08,800 --> 00:15:13,520
有点像像素的加权平均值，对吧？所以，你知道，这个，也很难画
--much, but you know, this pixel here would be an average of this pixel, and this pixel, and this 00:15:13,520 --> 00:15:19,440
很多，但是你知道，这里的这个像素是这个像素、这个像素和这个像素的平均值
--pixel, etc. It would be an average of all the sort of 25 pixels around that location, and if you do 00:15:19,440 --> 00:15:27,120
像素等。这将是该位置周围所有 25 个像素的平均值，如果您这样做
--that, what you get is you get a blurred image, right? So, you get an image that is more blurry 00:15:27,120 --> 00:15:32,480
那，你得到的是一个模糊的图像，对吧？所以，你会得到一个更模糊的图像
--because each pixel in this image is a combination of sort of pixels around that location in the 00:15:32,480 --> 00:15:38,320
因为此图像中的每个像素都是该位置周围像素的组合
--previous image, and that's what sort of this blur, Gaussian blur operation does, and it's 00:15:38,320 --> 00:15:44,480
以前的图像，这就是这种模糊，高斯模糊操作所做的，它是
--accomplished via convolution. That's sort of how you can, how you can implement these things. 00:15:44,480 --> 00:15:48,320
通过卷积实现。这就是您可以如何实现这些事情的方式。
--That's a bit sort of a simple example in some cases, or in some sense, but a more complex one 00:15:50,560 --> 00:15:57,120
在某些情况下，或者在某种意义上，这是一个有点简单的例子，但却是一个更复杂的例子
--is using convolutions along with some, I should emphasize, some sort of non-linear operations here 00:15:57,680 --> 00:16:02,880
正在使用卷积以及一些，我应该强调的，这里的某种非线性运算
--to represent things like edges, or to detect things like edges in the image, or to look at 00:16:02,880 --> 00:16:08,000
表示边缘之类的东西，或者检测图像中的边缘之类的东西，或者看
--the image gradient, and things like this. So, if I convolve, if I take my original image z, 00:16:08,000 --> 00:16:12,800
图像梯度，以及类似的东西。所以，如果我进行卷积，如果我使用原始图像 z，
--and I convolve it with this filter here, this filter sort of, you know, has positive entries 00:16:13,440 --> 00:16:19,760
我在这里将它与这个过滤器进行卷积，这个过滤器有点，你知道，有积极的条目
--here, and negative entries here, so that will, this could be something known as the image gradient. It 00:16:19,760 --> 00:16:24,640
在这里，和这里的负面条目，所以这可能是所谓的图像梯度。它
--sort of looks at how much the image is changing in the x direction, and outputs sort of an amount 00:16:24,640 --> 00:16:32,240
某种程度上看图像在 x 方向上的变化程度，并输出某种数量
--that is large if the image is sort of increasing, and small if it's decreasing, and zero if the 00:16:32,240 --> 00:16:37,040
如果图像有点增加，则它很大，如果它正在减少，则它很小，如果
--image sort of stays constant in the x direction. And similarly, this one here does it for the y 00:16:37,040 --> 00:16:41,600
图像在 x 方向上保持不变。同样，这里的这个是为 y
--direction. And so, if we take those two filters, and look at their, look at the, their squared sum, 00:16:41,600 --> 00:16:48,800
方向。因此，如果我们采用这两个过滤器，并查看它们的平方和，
--and the square root of this is essentially the magnitude of this, of this, of these two things, 00:16:48,800 --> 00:16:53,600
这个的平方根本质上就是这两个东西的大小，
--what you get is you get this image on the right here, which is essentially highlighting those 00:16:53,600 --> 00:16:58,400
你得到的是你在这里得到这张图片，它基本上突出了那些
--portions of the image that, where the image changes a lot. So, this portion here, right, 00:16:58,400 --> 00:17:05,680
图像的一部分，其中图像变化很大。所以，这部分在这里，对，
--the image is changing from kind of a light color to a darker color, 00:17:05,680 --> 00:17:09,680
图像从浅色变为深色，
--and, and this is therefore going to have, you know, high magnitude of the image gradient, 00:17:11,280 --> 00:17:16,240
因此，这将具有很高的图像梯度幅度，
--whereas, you know, this region here isn't changing very much, it's kind of a static, 00:17:17,040 --> 00:17:20,720
然而，你知道，这里的这个区域变化不大，它是一种静态的，
--a static thing, and so the, the image gradient is relatively small, right? And, and this sort of 00:17:20,720 --> 00:17:25,280
一个静态的东西等等，图像梯度比较小吧？而且，还有这种
--thing is often the first step, say, in, in classical, like, edge detection algorithms, 00:17:25,280 --> 00:17:29,840
事情通常是第一步，比如说，在经典的边缘检测算法中，
--often the first step is to compute exactly this image gradient. So, these operations have been, 00:17:29,840 --> 00:17:34,320
通常第一步是准确计算这个图像梯度。所以，这些操作是，
--have been used for a very long time, kind of in classical statistical signal processing, 00:17:34,320 --> 00:17:38,880
已经使用了很长时间，有点像经典的统计信号处理，
--and classical image processing. But in deep networks, we often use, A, sort of the innovation 00:17:38,880 --> 00:17:44,800
和经典图像处理。但在深度网络中，我们经常使用，A，某种创新
--is that we're going to do the same thing, just use learned filters, instead of pre-specified 00:17:44,800 --> 00:17:51,760
是我们要做同样的事情，只是使用学习过滤器，而不是预先指定的
--filters to accomplish some task, right? So, instead of trying to sort of say, okay, I want 00:17:51,760 --> 00:17:55,600
过滤器来完成一些任务，对吧？所以，与其试图说，好吧，我想要
--a filter that will blur the image, or I want filter that will compute gradients, we'll say, 00:17:55,600 --> 00:17:59,440
一个会模糊图像的过滤器，或者我想要一个会计算梯度的过滤器，我们会说，
--look, I just want to have a filter, I'm going to let the algorithm figure out, kind of, what filters 00:17:59,440 --> 00:18:03,760
听着，我只想有一个过滤器，我要让算法找出什么过滤器
--to learn, what operations to apply to my images. And that's the, that's the, sometimes the 00:18:03,760 --> 00:18:08,160
学习，什么操作适用于我的图像。那是，那是，有时
--fundamental idea of convolutional networks. Now, I should mention one thing about convolutional 00:18:08,160 --> 00:18:12,480
卷积网络的基本思想。现在，我应该提一下关于卷积的一件事
--networks, which is that they are never applied in, despite the fact that you often see convolutions, 00:18:12,480 --> 00:18:17,680
网络，即它们从未被应用，尽管你经常看到卷积，
--kind of, drawn in that one descent that I showed you a few slides back, right? So, they're, 00:18:17,680 --> 00:18:22,720
有点，在我向你展示了几张幻灯片的那种血统中，对吧？所以，他们是，
--they're often drawn, kind of, like, you know, a filter sliding across an image. In practice, 00:18:22,720 --> 00:18:28,880
它们通常被绘制，有点像，你知道，一个在图像上滑动的过滤器。在实践中，
--they are actually not done, or very rarely there's any operations in deep learning that 00:18:28,880 --> 00:18:34,320
它们实际上还没有完成，或者很少有深度学习中的任何操作
--apply, kind of, to 1D inputs and to 1D outputs, right? We typically, in deep networks, have many, 00:18:34,320 --> 00:18:42,400
适用于一维输入和一维输出，对吗？在深度网络中，我们通常有很多，
--many different, sort of, we want to have multiple different, sort of, layer, multiple different 00:18:42,400 --> 00:18:49,280
许多不同的，某种，我们想要有多个不同的，某种，层，多个不同
--dimensions of the hidden layers. And the way we accomplish this in deep networks is that we have 00:18:49,280 --> 00:18:54,000
隐藏层的维度。我们在深层网络中实现这一点的方式是我们有
--what are called multiple channels. So, it's, it's, sort of, natural to think of the input x 00:18:54,000 --> 00:18:59,360
什么叫多渠道。所以，很自然地想到输入 x
--as having multiple channels, right? Because, for example, a color image will have three channels, 00:18:59,360 --> 00:19:03,040
有多个渠道，对吧？因为，例如，彩色图像将具有三个通道，
--the red channel, the green channel, and the blue channel. What we're going to do in deep networks 00:19:03,040 --> 00:19:07,840
红色通道、绿色通道和蓝色通道。我们将在深度网络中做什么
--is we're actually going to represent the hidden units also as having multiple channels, okay? 00:19:07,840 --> 00:19:14,480
我们是否真的要将隐藏单元也表示为具有多个通道，好吗？
--And the, the difference here is that these channels in a hidden layer, they don't correspond 00:19:14,480 --> 00:19:20,720
而且，这里的区别在于隐藏层中的这些通道，它们不对应
--to, like, a red, green, or blue. Often, we're going to have 64 or 100. We often like to use 00:19:20,720 --> 00:19:25,280
像红色、绿色或蓝色。通常，我们会有 64 或 100。我们经常喜欢使用
--powers of two for some reason. That's not really necessary, but 64 channels, or 128 channels, or 00:19:25,280 --> 00:19:30,320
出于某种原因的二的权力。这不是真的有必要，但是 64 个通道，或者 128 个通道，或者
--maybe a thousand and twenty-four channels, right? We use a lot of channels to represent, kind of, 00:19:30,320 --> 00:19:37,440
也许一千二十四个频道，对吧？我们使用很多渠道来代表，
--more complex and, you know, more elements in the hidden layer. So, each, each channel is still this 00:19:37,440 --> 00:19:43,280
更复杂，你知道，隐藏层中的元素更多。所以，每个，每个频道还是这个
--2D spatial array, but we're going to use many of them. So, you know, one channel there, one channel 00:19:43,280 --> 00:19:47,600
二维空间阵列，但我们将使用其中的许多。所以，你知道，那里有一个频道，一个频道
--there, etc. to represent our hidden units, okay? So, in general, we sort of think of our inputs, 00:19:47,600 --> 00:19:54,000
那里等等来代表我们的隐藏单位，好吗？所以，总的来说，我们会考虑我们的输入，
--and this could correspond to our input image, but also could correspond to intermediate layers in 00:19:54,000 --> 00:19:57,600
这可能对应于我们的输入图像，但也可能对应于
--the network, as being a rank three tensor with a height and a width, but also a number of channel 00:19:57,600 --> 00:20:04,960
网络，作为具有高度和宽度的三阶张量，还有许多通道
--inputs, okay? We also think of our output as being a height, and a width, and a number of outputs. 00:20:04,960 --> 00:20:12,560
输入，好吗？我们还认为我们的输出是高度、宽度和一些输出。
--And so, the question is, how do we map, sort of, multiple channel inputs with a convolution 00:20:12,560 --> 00:20:16,960
所以，问题是，我们如何用卷积映射多通道输入
--to multiple channel outputs? And the way we're going to do it, is we're actually going to have 00:20:16,960 --> 00:20:21,840
到多通道输出？而我们要做的方式，实际上是
--a separate filter, separate set of weights w, for each possible input-output channel pair, 00:20:21,840 --> 00:20:29,120
一个单独的过滤器，单独的一组权重 w，用于每个可能的输入输出通道对，
--all right? And then we're going to add them up. So, if we want to, sort of, take, we want to compute 00:20:30,160 --> 00:20:35,200
好的？然后我们要把它们加起来。所以，如果我们想要，某种程度上，我们想要计算
--this element here, of the first channel, okay? This would correspond to, this would correspond to 00:20:35,200 --> 00:20:42,720
这个元素在这里，第一个频道，好吗？这将对应于，这将对应于
--the, this first channel here, convolve with some filter, plus this second channel here, 00:20:43,600 --> 00:20:50,240
这里的第一个通道与一些过滤器进行卷积，再加上这里的第二个通道，
--convolve with some filter, plus this third channel here, convolve with another filter, right? And 00:20:50,240 --> 00:20:53,600
与一些过滤器进行卷积，再加上这里的第三个通道，与另一个过滤器进行卷积，对吗？和
--that's how you get this first input. If I want this next input in the next channel, I would have a 00:20:53,600 --> 00:21:01,200
这就是您获得第一个输入的方式。如果我想在下一个通道中输入下一个输入，我会有一个
--same operation applied to all my input channels, but a whole other set of weights, okay? And the 00:21:01,200 --> 00:21:06,320
相同的操作适用于我所有的输入通道，但是另一组权重，好吗？和
--formal way of thinking about this, though I'll describe a better way of thinking about it later, 00:21:06,320 --> 00:21:11,440
正式的思考方式，虽然我稍后会描述一种更好的思考方式，
--is that if we want to take, for example, in our output, if we want to compute the s output channel, 00:21:11,440 --> 00:21:17,360
例如，如果我们想在我们的输出中计算 s 输出通道，
--that would be the sum over all my input channels, so from r equals one to cn, of my, 00:21:18,000 --> 00:21:24,400
那将是我所有输入通道的总和，所以从 r 等于 1 到 cn，我的，
--the rth input channel, times, sort of, the rs convolution, okay? So, that's the, that's, sort of, 00:21:25,040 --> 00:21:32,400
第 r 个输入通道，时间，某种 rs 卷积，好吗？所以，那是，那是，有点，
--the mechanisms of this, but I'm actually not going to write this, because there's a much better, I 00:21:32,400 --> 00:21:39,760
这个的机制，但我实际上不打算写这个，因为有一个更好的，我
--didn't want to write that one out, and have everyone, sort of, write it down too, because 00:21:39,760 --> 00:21:43,200
不想把那个写出来，让每个人，有点，也把它写下来，因为
--there actually is a much better way to think about multi-channel convolutions, and that is by thinking 00:21:43,200 --> 00:21:49,280
实际上有一个更好的方法来思考多通道卷积，那就是通过思考
--about the operations of these things, and the channels themselves, and all their operations, as 00:21:49,280 --> 00:21:54,960
关于这些东西的操作，以及渠道本身，以及它们的所有操作，如
--matrix vector operations, okay? So, the way to think about the, a, a multi-channel convolution, kind 00:21:54,960 --> 00:22:02,880
矩阵向量运算，好吗？所以，想一想，多通道卷积，那种
--of, in the right way, is that in our input image, so in this input that we have to our convolutional 00:22:02,880 --> 00:22:09,280
的，以正确的方式，是在我们的输入图像中，所以在这个输入中，我们必须对我们的卷积
--filter, you shouldn't think of these things as individual, sort of, scalar values, like you 00:22:09,280 --> 00:22:15,680
过滤器，你不应该像你一样将这些东西视为独立的、某种标量值
--normally would in a grayscale image. You should think about all of these things here as, really, 00:22:15,680 --> 00:22:21,040
通常会在灰度图像中。你应该把这里的所有这些事情都想成，真的，
--vectors, each, each component, I should say, so let me, sort of, write this like this, like each one of 00:22:21,040 --> 00:22:27,520
向量，每个，每个组件，我应该说，所以让我，有点，像这样写，就像每个
--these, so say x 2 2, so x 2 2, etc. These are vectors in R to the c in, okay? So, where c in is our number of 00:22:27,520 --> 00:22:41,920
这些，比如说 x 2 2，所以 x 2 2，等等。这些是 R 中到 c 中的向量，好吗？所以，其中 c in 是我们的数量
--channel inputs, okay? So, that, that's pretty natural, right? Because you think of these things, you know, you 00:22:41,920 --> 00:22:45,840
频道输入，好吗？所以，这很自然，对吧？因为你想到这些事情，你知道，你
--think of each of these things as having, like, a whole bunch of channels, and that's, like, thinking 00:22:45,840 --> 00:22:53,040
把这些东西中的每一个都想象成有一大堆频道，就像，思考
--of each of these inputs as, kind of, itself a big vector. Okay, and similarly for the output, the output's 00:22:53,040 --> 00:23:00,000
这些输入中的每一个本身都是一个大向量。好的，同样对于输出，输出的
--also going to be vectors, not actually in, in this one here, for example. These are going to be vectors 00:23:00,000 --> 00:23:07,280
也将是向量，实际上不是 in，例如，在这里。这些将成为载体
--not in the input channel size, but actually in the output channel size. It's going to be vectors 00:23:08,480 --> 00:23:14,320
不是输入通道大小，而是输出通道大小。它将成为载体
--in R to the c out. 00:23:15,120 --> 00:23:17,600
在 R 到 c 出来。
--And now, here's the key point. The way you should think about the filters you are convolving with is 00:23:20,160 --> 00:23:27,360
现在，关键点来了。你应该考虑你正在使用的过滤器的方式是
--that each element of your filter is actually a matrix, okay? So, these terms here, say w 1 1, etc. 00:23:27,360 --> 00:23:37,520
你过滤器的每个元素实际上都是一个矩阵，好吗？所以，这里的这些术语，比如说 w 1 1，等等。
--These are going to be matrices which map, and I guess in this, in this notation I'm using here, in R to the c out by c in. 00:23:37,760 --> 00:23:53,360
这些将是映射的矩阵，我想在这个，在我在这里使用的这个符号中，在 R 中通过 c in 到 c out。
--Okay, and then what we do, we have our same operation as before, it's just that, you know, z 2 2 here is equal to, 00:23:55,360 --> 00:24:04,480
好的，然后我们做什么，我们有和以前一样的操作，只是，你知道，这里的 z 2 2 等于，
--sort of, the same way w 1 times x, in this case 2 2, but this product here is now a matrix vector product, 00:24:04,960 --> 00:24:13,840
有点类似 w 1 乘以 x，在本例中为 2 2，但这里的乘积现在是矩阵向量乘积，
--right? So, in some sense, the, the way you should think about 2D convolutions, I would argue, is not 00:24:14,720 --> 00:24:20,560
正确的？所以，在某种意义上，你应该考虑二维卷积的方式，我认为，不是
--like this. I mean, to be clear, your, your sizes are also the same here, right? So, your, your input is a rank 00:24:20,560 --> 00:24:26,240
像这样。我的意思是，要清楚，你的，你的尺码在这里也一样，对吧？所以，你的输入是一个等级
--3 tensor. If you add a batch dimension, it'll be rank 4 then, but, but sort of a single input is a 00:24:26,240 --> 00:24:30,960
3张量。如果你添加一个批处理维度，那么它将是第 4 位，但是，但是，单个输入的排序是
--rank 3 tensor. A, the output's also a rank 3 tensor, height by width by either channel input or channel 00:24:30,960 --> 00:24:36,160
阶 3 张量。 A，输出也是一个 3 阶张量，由通道输入或通道的高度乘宽
--outputs, and then your weights here are rank 4 tensor, because you have a, sort of, this k by k filter 00:24:36,160 --> 00:24:41,120
输出，然后你这里的权重是 4 阶张量，因为你有一个 k x k 过滤器
--for every pair of inputs and outputs, but the way to think about that is actually not by thinking 00:24:41,120 --> 00:24:47,040
对于每一对输入和输出，但思考的方式实际上不是通过思考
--about this as a rank 4 tensor. Think of it as a, sort of, k by k set of filters. k here is, I should 00:24:47,040 --> 00:24:53,520
关于这个作为 4 阶张量。将其视为 k x k 组过滤器。 k 这是，我应该
--have mentioned before, k here is called the, the kernel size. It's sort of, in this case, in the next case, 00:24:53,520 --> 00:24:57,360
之前有提到，这里的k叫做kernel size。在这种情况下，在下一种情况下，
--3 by 3, but it's, it can be, sort of, any, any, sort of, size you want. 3 by 3 is very common in deep, 00:24:57,360 --> 00:25:03,520
 3 x 3，但它可以是任何一种你想要的大小。 3乘3在深水很常见，
--in deep networks, and each element of this 3 by 3 filter, though, is, instead of being a single 00:25:03,520 --> 00:25:09,520
但是，在深度网络中，这个 3 x 3 过滤器的每个元素都不是单个元素
--element that's a, sort of, scalar value, it is, in fact, a, a matrix, and this is going to be really 00:25:09,520 --> 00:25:14,080
元素是一个标量值，实际上是一个矩阵，这将是真正的
--valuable to think about it this way, not just for the purposes of, sort of, simplifying the equations, 00:25:14,080 --> 00:25:18,960
以这种方式思考它很有价值，不仅仅是为了，某种程度上，简化方程式，
--but also for the purposes of really implementing these things. You want to implement these things 00:25:18,960 --> 00:25:23,360
但也是为了真正实施这些事情。你想实现这些东西
--as matrix operations, and so doing it in this form is going to be how we actually, how we actually 00:25:23,360 --> 00:25:27,600
作为矩阵运算，所以以这种形式进行操作将成为我们实际的方式，我们实际上的方式
--implement these things. Okay, so with that all being said, let me now talk about a few more 00:25:27,600 --> 00:25:33,520
实施这些事情。好了，说了那么多，现在让我再说几个
--elements of practical convolutions, because the convolutions I described there have some, have some 00:25:33,520 --> 00:25:39,760
实际卷积的元素，因为我在那里描述的卷积有一些，有一些
--issues that need to be addressed, or rather, some, some things that need to be added 00:25:40,960 --> 00:25:45,120
需要解决的问题，或者更确切地说，一些，一些需要添加的东西
--in order to make them, kind of, fully usable within deep networks. 00:25:45,120 --> 00:25:49,280
为了使它们在某种程度上在深度网络中完全可用。
--So, we're actually going to talk about a few different aspects of convolutions that you, 00:25:49,440 --> 00:25:53,440
所以，我们实际上要谈谈卷积的几个不同方面，
--that you may have seen before if you've ever used a convolutional library, or convolutions in a 00:25:53,440 --> 00:25:58,640
如果您曾经使用过卷积库或在
--library like PyTorch or TensorFlow. The first of these is padding. So, one thing you may notice 00:25:58,640 --> 00:26:05,760
PyTorch 或 TensorFlow 之类的库。其中第一个是填充。所以，你可能会注意到一件事
--about the, the convolutions I described before is that these convolutions, let me just go back one 00:26:05,760 --> 00:26:11,920
about, the convolutions I before described these convolutions, let me just back one
--slide, right? These, in these convolutions, the, the size of the input is different than the size 00:26:12,240 --> 00:26:18,240
幻灯片，对吧？这些，在这些卷积中，输入的大小不同于
--of the output, because we only, you know, in a 5x5, I guess, 5x5 by however many channels, but 00:26:18,240 --> 00:26:25,520
的输出，因为我们只是，你知道，在一个 5x5 中，我猜，5x5 有多少通道，但是
--think again about these as 1D things. In a 5x5 input image, there are only, sort of, nine locations 00:26:25,520 --> 00:26:34,480
再想想这些是一维的东西。在 5x5 输入图像中，只有九个位置
--that you can place this filter here without, kind of, going off the edges, right? So, in a 5x5 00:26:34,480 --> 00:26:40,720
你可以把这个过滤器放在这里而不会偏离边缘，对吧？所以，在 5x5
--image, there are only nine locations that you can place this filter here without, kind of, going off 00:26:40,720 --> 00:26:44,880
图片，只有九个位置可以放置这个过滤器，而不会，有点，消失
--the edges, right? So, you can place it here, here, I mean, I showed this before, here, etc. But then 00:26:44,880 --> 00:26:52,080
边缘，对吧？所以，你可以把它放在这里，这里，我的意思是，我之前展示过这个，这里等等。但是然后
--you run out of space, right? So, you can only form a 3x3 output. And this is a bit annoying if we do 00:26:52,080 --> 00:26:59,280
你的空间用完了，对吧？所以，你只能形成一个 3x3 的输出。如果我们这样做，这有点烦人
--this in deep networks. I mean, to be clear, we actually could do this. It would probably work 00:26:59,280 --> 00:27:03,040
这在深层网络中。我的意思是，要清楚，我们实际上可以做到这一点。它可能会工作
--fine. But when you have really big networks, it more just gets to be a pain to, kind of, keep 00:27:03,040 --> 00:27:07,520
美好的。但是当你拥有非常大的网络时，就更像是一种痛苦，有点，保持
--averaging things together. Well, what's the size that I'm averaging? All these things are, kind of, 00:27:07,600 --> 00:27:11,200
把事情平均在一起。那么，我平均的尺寸是多少？所有这些东西，有点，
--annoying to keep track of. And so, what's very common to do, and to be honest, I don't know why 00:27:12,400 --> 00:27:17,440
烦人的跟踪。所以，这是很常见的事情，老实说，我不知道为什么
--this is not the default setting in every single library, because this is what everyone 00:27:17,440 --> 00:27:22,320
这不是每个库的默认设置，因为这是每个人都
--does in every single architecture you will see. What was simply done in practice is that you 00:27:22,320 --> 00:27:27,520
在你将看到的每一个架构中。在实践中简单地做的是你
--pad the input with zeros, such that your output is the same size as your original input, okay? So, 00:27:28,240 --> 00:27:35,680
用零填充输入，这样您的输出与原始输入的大小相同，好吗？所以，
--if I have a 4x4, sort of, input here, and I want to run a 3x3 convolution, I don't just run it on, 00:27:35,680 --> 00:27:41,600
如果我有一个 4x4 的输入，我想运行一个 3x3 的卷积，我不只是运行它，
--you know, the four locations I can, resulting in a 2x2 output. What I do is I pad the image 00:27:41,600 --> 00:27:48,240
你知道，我可以的四个位置，导致 2x2 输出。我所做的是填充图像
--with these gray cells here, which represent just zero values. And now, when I convolve the image 00:27:48,240 --> 00:27:54,960
这里有这些灰色单元格，它们仅代表零值。现在，当我对图像进行卷积时
--with this, I get the output that's the same size as my input. And in fact, the precise formula here 00:27:54,960 --> 00:28:00,320
有了这个，我得到的输出与我的输入大小相同。事实上，这里的精确公式
--is if my filter, if my convolutional filter here, is k by k, then I need to pad the image with k 00:28:00,400 --> 00:28:09,440
如果我的过滤器，如果我的卷积过滤器是 k x k，那么我需要用 k 填充图像
--minus 1 divided by two zeros on all sides. This actually works only for odd kernel sizes, okay? 00:28:09,440 --> 00:28:16,480
负 1 除以所有边上的两个零。这实际上只适用于奇数内核大小，好吗？
--We typically don't deal with even kernel sizes, because they're precisely because they're a bit 00:28:16,480 --> 00:28:22,320
我们通常不处理内核大小，因为它们恰恰是因为它们有点
--more of a pain. They have to have a different case for padding on one side than the other side. 00:28:22,320 --> 00:28:25,680
更痛苦。他们必须在一侧与另一侧有不同的填充情况。
--So, for this reason, we actually typically deal with odd size kernels. 00:28:26,640 --> 00:28:29,200
因此，出于这个原因，我们实际上通常处理奇数大小的内核。
--But this is extremely standard. So, essentially, everyone uses odd size kernels and uses zero 00:28:30,480 --> 00:28:37,120
但这是非常标准的。所以，基本上，每个人都使用奇数大小的内核并使用零
--padding, such that the output's image size is the same as the input image size. All right, 00:28:37,120 --> 00:28:43,680
填充，这样输出的图像大小与输入图像的大小相同。好的，
--so that's sort of practical property one. Another practical property deals with pooling operations 00:28:43,680 --> 00:28:49,840
所以这是一种实用的财产。另一个实用属性涉及池化操作
--or strided convolutions. And these are actually two ways of solving kind of the same problem. 00:28:49,840 --> 00:28:54,400
或跨步卷积。这些实际上是解决同一类问题的两种方法。
--So, one thing you may have noticed, especially with this past zero padding version of convolutions, 00:28:55,360 --> 00:29:02,000
所以，你可能已经注意到一件事，尤其是过去的零填充卷积版本，
--is that we keep, when we apply convolution, we keep the same resolution in our subsequent layer 00:29:02,000 --> 00:29:10,000
是我们保持，当我们应用卷积时，我们在后续层中保持相同的分辨率
--as we had in our original layer. And this is not always the best thing, right? So, 00:29:10,000 --> 00:29:15,440
正如我们在原始层中所做的那样。这并不总是最好的，对吧？所以，
--to be honest, it's maybe not a horrible idea. But in many cases in convolutional networks, 00:29:16,000 --> 00:29:23,920
老实说，这也许不是一个可怕的想法。但在很多情况下，在卷积网络中，
--as we go through the network progressively, we actually want to create lower and lower 00:29:24,400 --> 00:29:27,760
当我们逐步通过网络时，我们实际上想要创造越来越低的
--resolutions, kind of more summarized versions, in some sense, of our input. And that kind of 00:29:27,760 --> 00:29:35,600
决议，从某种意义上说，是我们输入的更概括的版本。而那种
--represents features in some very abstract sense. You might think it sort of represents features 00:29:35,600 --> 00:29:40,080
在某种非常抽象的意义上表示特征。你可能认为它有点代表特征
--at different levels of abstraction or different levels of sort of hierarchical representation. 00:29:40,080 --> 00:29:46,400
在不同的抽象层次或不同层次的层次表示。
--Though that's kind of debatable, maybe, whether it's really doing that or whether you do that, 00:29:47,120 --> 00:29:50,480
虽然这有点值得商榷，也许，无论是真的在做那个还是你是否在做那个，
--or whether it's just about computation. But certainly, computationally, right, 00:29:50,480 --> 00:29:53,520
或者它是否只是关于计算。但可以肯定的是，从计算上来说，对的，
--you don't want to be dealing with 256 by 256 images the whole way through. It just would be 00:29:54,320 --> 00:29:59,840
您不想一直处理 256 x 256 的图像。它只是会
--actually quite hard to deal with. And so, because of that, we often want to downsample these images 00:29:59,840 --> 00:30:06,960
其实挺难对付的。因此，正因为如此，我们经常想要对这些图像进行下采样
--at internal layers of the network, especially when we have lots of channels, right? Because if you 00:30:06,960 --> 00:30:10,880
在网络的内部层，尤其是当我们有很多通道时，对吗？因为如果你
--have a thousand channels, it's getting pretty, actually, memory intensive to represent all 00:30:10,880 --> 00:30:16,960
有一千个频道，它变得漂亮，实际上，内存密集来代表所有
--thousand channels for a large image. So, we want to downsample the image and essentially represent 00:30:16,960 --> 00:30:22,320
大图像的数千个通道。所以，我们想要对图像进行下采样并本质上代表
--the image at different resolutions in our network. Now, there are two ways this commonly is done. 00:30:22,320 --> 00:30:27,280
我们网络中不同分辨率的图像。现在，通常有两种方法可以做到这一点。
--One is by some sort of pooling operation, okay? So, what we can do, and this is showing max 00:30:28,400 --> 00:30:33,280
一种是通过某种池化操作，好吗？所以，我们能做什么，这显示了最大
--pooling here, but really you can apply this to average pooling or things like this as well. 00:30:33,280 --> 00:30:37,680
在这里汇集，但实际上你也可以将其应用于平均汇集或类似的东西。
--You take some block, and commonly it's a four by four block in your image to produce a 00:30:37,680 --> 00:30:42,080
你拿一些块，通常它是你图像中的四乘四块来产生一个
--downsampling by an image that's half the size in both spatial dimensions. 00:30:42,880 --> 00:30:47,200
通过在两个空间维度上都减半的图像进行下采样。
--You take some sort of block in your input, often two by two by two block, and you somehow combine 00:30:47,840 --> 00:30:54,640
您在输入中采用某种块，通常是两两两块，然后以某种方式组合
--these quantities here to produce a single quantity in your output, in your next channel. 00:30:54,640 --> 00:31:00,640
这些数量在你的输出中产生一个单一的数量，在你的下一个渠道。
--And the max pooling operation, for example, would say which of these four values, 00:31:01,440 --> 00:31:07,200
例如，最大池操作会说出这四个值中的哪一个，
--you typically do it individually for each channel now, so which of these four values in this one 00:31:08,640 --> 00:31:12,000
您通常现在为每个频道单独执行此操作，所以这四个值中的哪一个
--channel has the maximum value? And you just set this thing here to be equal to that maximum value. 00:31:12,000 --> 00:31:19,120
通道有最大值？你只需将这里的东西设置为等于那个最大值。
--That's called the max pooling operation. You can also do average pooling. So, average pooling would 00:31:19,920 --> 00:31:23,520
这就是所谓的最大池化操作。您也可以进行平均池化。所以，平均汇集将
--just be you take the average of those four things, and that becomes your next layer, okay? So, both 00:31:23,520 --> 00:31:28,560
只是你取这四件事的平均值，这就成为你的下一层，好吗？所以，两者
--of these are valid operations. And they're both actually pretty commonly used in practice. Both 00:31:28,560 --> 00:31:34,000
其中是有效操作。它们实际上在实践中都非常常用。两个都
--max pooling and average pooling are very common operations that people use in practice. 00:31:34,000 --> 00:31:37,920
最大池化和平均池化是人们在实践中使用的非常常见的操作。
--The second possibility are things called strided convolutions. So, the idea here is that if normally 00:31:38,880 --> 00:31:45,520
第二种可能性是所谓的跨步卷积。所以，这里的想法是，如果通常
--we take our filter and we sort of apply it to every possible location in the image, that's the 00:31:45,520 --> 00:31:50,160
我们使用我们的过滤器，然后将它应用到图像中的每个可能位置，这就是
--typical way of applying a convolutional filter. But if instead of doing that, what if instead we 00:31:50,160 --> 00:31:55,360
应用卷积滤波器的典型方法。但如果不是那样做，如果我们改为
--sort of take our image, our filter, and we move it over by more than one location at a time, 00:31:55,360 --> 00:32:01,360
有点像我们的图像，我们的过滤器，我们一次将它移动不止一个位置，
--right? We could also do this, and this would also result in a downsampling of our input image, 00:32:01,360 --> 00:32:06,160
正确的？我们也可以这样做，这也会导致我们输入图像的下采样，
--right? Because we're sort of, you know, have only this position, and then not this one, 00:32:06,720 --> 00:32:11,200
正确的？因为我们有点，你知道，只有这个位置，然后没有这个，
--but then just this one, right? So, not, you know, I'll draw this here. So, 00:32:11,920 --> 00:32:15,440
但只有这一个，对吧？所以，不，你知道，我会在这里画这个。所以，
--don't take this one in red here. We only take the ones in blue. 00:32:16,480 --> 00:32:19,840
不要把这个红色的。我们只拿蓝色的。
--Oops, messed that up. Here, that's the one. Okay, and that obviously will also produce a 00:32:23,200 --> 00:32:31,440
哎呀，搞砸了。在这里，就是那个。好的，这显然也会产生一个
--downsampled image, right? Because we're going to produce an image that's half the resolution 00:32:31,440 --> 00:32:35,440
下采样图像，对吧？因为我们要生成分辨率为一半的图像
--of our original image. And so, both of these two operations, in fact, either pooling in this sense 00:32:35,440 --> 00:32:40,880
我们的原始图像。所以，这两个操作，事实上，要么在这个意义上池化
--or strided convolutions, produce outputs that are, in this case, half the size, half the resolution 00:32:40,880 --> 00:32:47,920
或跨步卷积，产生的输出在这种情况下是大小的一半，分辨率的一半
--of our input in both spatial dimensions. So, a quarter of the number of pixels, basically. 00:32:47,920 --> 00:32:54,000
我们在两个空间维度上的输入。所以，基本上是像素数的四分之一。
--And you can use larger strides, too, or larger sort of regions for max pooling or average pooling, 00:32:55,360 --> 00:33:02,160
你也可以使用更大的步幅，或者更大种类的区域来进行最大池化或平均池化，
--but these sort of things, in general, are very common. It's also common, for example, in maybe 00:33:03,120 --> 00:33:07,200
但总的来说，这类事情非常普遍。这也很常见，例如，在 maybe
--the last layer to do a single, you know, whatever filters you have left, you do like a single average 00:33:07,200 --> 00:33:11,840
最后一层做一个，你知道，无论你剩下什么过滤器，你都喜欢一个单一的平均值
--pooling to collapses to a single vector, and things like this. So, these are all very sort 00:33:11,840 --> 00:33:16,640
池化为单个向量，诸如此类。所以，这些都很好
--of common operations, and they really play a large role in most networks. One of these two types, 00:33:16,640 --> 00:33:21,680
常见操作，它们在大多数网络中确实发挥着重要作用。这两种类型之一，
--because most networks, for both computational and kind of representational regions, want to 00:33:21,680 --> 00:33:26,080
因为大多数网络，对于计算区域和代表性区域，都希望
--downsample the image in later layers in the network. All right, the next feature that you 00:33:26,080 --> 00:33:32,240
在网络的后面的层中对图像进行下采样。好吧，你的下一个功能
--may see in convolutions are groupings. So, the challenge here is that even with the sort of 00:33:32,240 --> 00:33:40,080
可能在卷积中看到的是分组。所以，这里的挑战是，即使有那种
--simplifications of convolutions we talked about, for large numbers of inputs and output channels, 00:33:40,080 --> 00:33:47,920
我们谈到的卷积的简化，对于大量的输入和输出通道，
--if you have very, very large input output channel combinations, filters can still have a large 00:33:47,920 --> 00:33:52,640
如果你有非常非常大的输入输出通道组合，过滤器仍然可以有很大的
--number of weights. And the way to think about this, remember, is that each location in the filter 00:33:52,640 --> 00:33:56,480
重量的数量。记住，思考这个问题的方法是过滤器中的每个位置
--is a, each location, so each sort of individual filter, you should think of as a matrix that is 00:33:56,480 --> 00:34:03,760
是一个，每个位置，所以每一种单独的过滤器，你应该认为是一个矩阵
--in R c in by c out. And so, for many practical reasons, if you have 10,000 inputs channels, 00:34:03,760 --> 00:34:13,040
在 R c 中由 c 出。因此，出于许多实际原因，如果您有 10,000 个输入通道，
--for example, or 10,000 output channels, this is going to just start to be a very big, 00:34:13,040 --> 00:34:18,720
例如，或 10,000 个输出通道，这将开始变得非常大，
--even with all the simplifications of convolutional networks, forming a matrix that big, let alone 00:34:18,720 --> 00:34:23,680
即使对卷积网络进行了所有简化，形成一个如此大的矩阵，更不用说了
--sort of, you know, k by k of them for your whole filter, might just be too big. It might just be 00:34:23,680 --> 00:34:29,440
有点，你知道，对于你的整个过滤器来说，k x k 个，可能太大了。可能只是
--too many parameters for your network. And so, what people often do in these situations is they use 00:34:29,440 --> 00:34:36,800
您的网络参数太多。所以，人们在这些情况下经常做的是他们使用
--something called group convolutions. And the idea of group convolutions is that instead of sort of 00:34:36,800 --> 00:34:41,520
一种叫做组卷积的东西。组卷积的想法是
--all the input channels here, leading to all the output channels, we have only some collection of 00:34:41,520 --> 00:34:47,600
这里所有的输入通道，通向所有的输出通道，我们只有一些集合
--input channels leading to some similar collection of output channels. So, say you have maybe four 00:34:47,680 --> 00:34:51,840
输入通道导致一些类似的输出通道集合。所以，假设你有四个
--channels and four input channels and four output channels, maybe only the first two input channels 00:34:51,840 --> 00:34:56,320
通道和四个输入通道和四个输出通道，可能只有前两个输入通道
--lead to the first two output channels, and things like that. And this can actually be brought all 00:34:56,320 --> 00:35:01,200
导致前两个输出通道，诸如此类。而这个其实可以全部带
--the way down to the case where maybe you just do the convolutions kind of channel by channel. So, 00:35:01,200 --> 00:35:06,000
一直到你可能只是一个通道一个通道地做卷积的情况。所以，
--maybe this channel here only depends on this one input channel, and things like this too. This is 00:35:06,000 --> 00:35:12,160
也许这里的这个通道只依赖于这个输入通道，诸如此类。这是
--actually done, these are called, this extreme version of the group size being equal to the 00:35:12,160 --> 00:35:17,120
实际上完成了，这些被称为，这个极端版本的组大小等于
--number of channels. Sorry, the number of groups being equal to the number of channels. This is, 00:35:17,120 --> 00:35:24,320
通道数。抱歉，组数等于频道数。这是，
--this is sometimes called depth-wise convolutions, and they actually are becoming, you know, we have 00:35:24,320 --> 00:35:28,000
这有时被称为深度卷积，它们实际上正在变成，你知道，我们有
--some work, in fact, even on some, my group has some work on sort of using these to great use. So, 00:35:28,000 --> 00:35:33,120
一些工作，事实上，甚至在一些工作上，我的团队也有一些工作在某种程度上使用它们来发挥更大的作用。所以，
--these sorts of things are very common as ways to reduce the parameter count of convolutions, 00:35:33,680 --> 00:35:39,760
这类事情作为减少卷积参数数量的方法非常普遍，
--when even a normal convolution, and maybe if you want to use a larger filter size, stuff like that, 00:35:39,760 --> 00:35:43,680
即使是普通的卷积，也许如果你想使用更大的过滤器尺寸，类似的东西，
--would still be too many parameters to sort of practically use in a network. 00:35:43,680 --> 00:35:47,120
仍然会有太多参数无法在网络中实际使用。
--All right, and the last one I'll talk about is dilations. And dilations are addressed, 00:35:48,640 --> 00:35:57,280
好吧，我要谈的最后一个是膨胀。并解决了膨胀问题，
--the sort of, the final problem I'll mention about convolutions, though I would say that these, 00:35:57,280 --> 00:36:03,520
我要提到的关于卷积的最后一个问题，尽管我会说这些，
--these were very popular for a while. I see them a little bit less, they're used slightly less 00:36:03,520 --> 00:36:08,720
这些在一段时间内非常流行。我看得少了一点，用得少了一点
--these days. I think people tend to use more sort of just concatenation to patches and things like 00:36:08,720 --> 00:36:12,720
这些日子。我认为人们倾向于对补丁和类似的东西使用更多类型的连接
--this these days. We'll talk about that a bit more when we talk about transformers, but the problem 00:36:12,720 --> 00:36:19,040
这几天。当我们谈论变压器时，我们会多谈一点，但问题
--that convolutions have, or one problem that they have, is that especially if you have small kernel 00:36:19,040 --> 00:36:23,920
卷积有一个问题，或者它们有一个问题，特别是如果你有小内核
--sizes, so if you have like a three by three filter here, right, convolutions have a relatively 00:36:23,920 --> 00:36:30,800
大小，所以如果你在这里有一个三乘三的过滤器，对吧，卷积有一个相对
--limited, what's called a receptive field by, at each layer. What I mean by that is, you know, 00:36:30,800 --> 00:36:36,960
有限的，所谓的感受野，在每一层。我的意思是，你知道，
--this location here, it only depends on these three locations in the input image. And I know 00:36:36,960 --> 00:36:43,600
这个位置在这里，它只取决于输入图像中的这三个位置。而且我知道
--I sort of sold this as an advantage originally, right, so that convolutions capture local effects. 00:36:43,600 --> 00:36:49,120
我最初将其作为一种优势出售，对吧，这样卷积就可以捕获局部效应。
--But the reality is, there are also downsides to this. You might not want this to always be the 00:36:49,920 --> 00:36:55,200
但现实是，这也有不利之处。您可能不希望它始终是
--case. You might want your convolutions to have a larger receptive field, such that even a single 00:36:55,200 --> 00:37:00,880
案件。您可能希望您的卷积具有更大的感受野，这样即使是单个
--layer can capture more properties of the input, right, of the previous layer, or capture larger 00:37:00,880 --> 00:37:07,520
层可以捕获更多输入的属性，对，上一层的，或者捕获更大的
--spatial properties of the input. And you could do this in a lot of ways, right, you could sort of, 00:37:07,520 --> 00:37:11,040
输入的空间属性。你可以通过很多方式做到这一点，对吧，你可以，
--you know, maybe, I don't know, do some combination of average pooling and sort of larger average 00:37:11,040 --> 00:37:16,400
你知道，也许，我不知道，做一些平均汇集和某种更大的平均的组合
--convolutions. That could all be done. But a very common thing which works really well is even 00:37:16,400 --> 00:37:21,040
卷积。这一切都可以做到。但是一个非常普遍而且效果很好的东西甚至是
--simpler, which is that you add a dilation factor to basically take your same filter size as before, 00:37:21,040 --> 00:37:27,520
更简单，就是你添加一个膨胀因子来基本上采用与以前相同的过滤器大小，
--but instead of applying it to sort of a single group, you apply it to kind of a spread out. So 00:37:27,520 --> 00:37:32,400
但不是将它应用于某种单一的群体，而是将它应用于某种分散的群体。所以
--you sort of spread out this filter, kind of, or the points that you multiply this filter by, 00:37:32,400 --> 00:37:38,480
你有点展开这个过滤器，有点，或者你乘以这个过滤器的点，
--by some dilation factor. So this is a dilation one convolution, or maybe dilation two. I forget 00:37:38,480 --> 00:37:43,520
通过一些扩张因子。所以这是一个扩张一卷积，或者可能是扩张二。我忘了
--that there's sometimes zero conventions or one conventions. If, well, we'll certainly have 00:37:43,520 --> 00:37:49,840
有时会有零个约定或一个约定。如果，好吧，我们肯定会有
--habits, very clear if and when you implement it. But the idea here is that we sort of spread out 00:37:49,840 --> 00:37:55,840
习惯，非常清楚你是否以及何时实施它。但这里的想法是我们有点分散
--the influence of this across multiple points, such that our three by three filter produces a, 00:37:55,840 --> 00:38:04,160
这对多个点的影响，这样我们的三乘三过滤器就会产生一个，
--is able to sort of capture more spatial properties of the input. One thing you will notice though, 00:38:05,520 --> 00:38:11,760
能够捕获输入的更多空间属性。不过你会注意到一件事，
--at least naively, if you just do this, then you have a similar problem with padding as you had 00:38:11,760 --> 00:38:16,720
至少天真地，如果你只是这样做，那么你会遇到与填充类似的问题
--before. So this, so for example, using the same zero padding as this one here, you would produce 00:38:16,720 --> 00:38:22,080
前。因此，例如，使用与此处相同的零填充，您将产生
--a two by two image because you can only slide this sort of convolution, you know, in a two by 00:38:22,080 --> 00:38:26,240
一个二乘二的图像，因为你只能滑动这种卷积，你知道，在一个二乘
--two location, in four locations total. So in order to make a similarly sized output with dilations, 00:38:26,240 --> 00:38:31,600
两个位置，总共四个位置。因此，为了通过扩张生成类似大小的输出，
--you have to add more zero padding. So just, just be aware of that, that you do have to, in fact, 00:38:31,600 --> 00:38:35,840
你必须添加更多的零填充。所以，请注意，事实上，你必须，
--add more padding to do this. Okay. So that actually are the extent of the sort of practical 00:38:35,840 --> 00:38:42,800
添加更多填充来执行此操作。好的。所以实际上都是那种实用的程度
--aspects of convolutions that we're going to talk about. And finally, what we're going to end this 00:38:42,800 --> 00:38:47,920
我们将要讨论的卷积的各个方面。最后，我们要结束的是什么
--lecture with is discussions on differentiating convolutions. How do we go about actually 00:38:47,920 --> 00:38:53,280
lecture with 是关于微分卷积的讨论。我们实际上如何进行
--finding, how do we go about integrating these sorts of things, these sorts of operations, 00:38:53,840 --> 00:38:58,960
发现，我们如何着手整合这些东西，这些操作，
--into automatic differentiation tools? And the first thing I should say before all of this is 00:38:58,960 --> 00:39:04,880
进入自动微分工具？在这一切之前我要说的第一件事是
--that you could, just knowing what you know now, already implement convolutions. In fact, it 00:39:04,880 --> 00:39:11,360
你可以，只要知道你现在所知道的，就已经实现了卷积。事实上，它
--wouldn't even be that bad if you do it in the most efficient way possible, where you sort of, 00:39:11,360 --> 00:39:14,320
如果你以最有效的方式做到这一点，甚至不会那么糟糕，你有点，
--you know, multiply each, each input by sort of one filter at a time, and then shift these 00:39:14,320 --> 00:39:21,360
你知道，每次将每个输入乘以一个过滤器，然后移动这些
--properly. This is actually not that bad a way of implementing convolutions. But there's a big 00:39:21,360 --> 00:39:27,440
适当地。这实际上是一种不错的实现卷积的方法。但是有一个大
--disadvantage because, because they have an automatic differentiation toolkit, right? And 00:39:27,440 --> 00:39:31,040
劣势是因为，因为他们有一个自动微分工具包，对吧？和
--because ultimately convolutions are just, you know, matrix vector multiplies, or really, of course, 00:39:31,040 --> 00:39:36,800
因为最终卷积只是，你知道，矩阵向量相乘，或者实际上，当然，
--you know, everything boils down to just multiplication and addition, but convolutions, 00:39:36,800 --> 00:39:40,320
你知道，一切都归结为乘法和加法，但是卷积，
--so you could do it by, you know, on a, on a scalar level, even. But even sort of with, with 00:39:40,320 --> 00:39:44,720
所以你甚至可以在一个标量级别上做到这一点。但甚至有点与，与
--the math I showed you, you could reduce convolutions to a bunch of matrix vector products, or really 00:39:44,720 --> 00:39:50,240
我向您展示的数学，您可以将卷积减少到一堆矩阵向量乘积，或者实际上
--matrix, matrix products, do it in kind of a more, in a more, kind of do it in a more batch set, 00:39:50,240 --> 00:39:55,680
矩阵，矩阵乘积，以更多的方式，以更多的方式，以更多的方式进行，
--setting. So everything we do here in convolutions, we could do just as matrix vector products. 00:39:55,680 --> 00:40:03,840
环境。所以我们在卷积中所做的一切，我们都可以像矩阵向量乘积一样做。
--But this is not something we want to do. Because if you do that, you wind up computing kind of a 00:40:04,480 --> 00:40:10,800
但这不是我们想要做的事情。因为如果你这样做，你最终会计算出一种
--lot of, you wind up retaining a lot of sort of duplicated work in your compute graph, right? 00:40:10,800 --> 00:40:18,480
很多，你最终在你的计算图中保留了很多重复的工作，对吧？
--Sort of store all the intermediate products of the convolution then before you add them up. 00:40:18,480 --> 00:40:22,800
在将它们相加之前先存储卷积的所有中间产品。
--And that creates a sort of way too much memory consumption in your compute graph. So it's 00:40:23,440 --> 00:40:29,280
这会在您的计算图中产生一种过多的内存消耗。所以就是
--important instead to implement convolutions as atomic operations within your automatic 00:40:29,360 --> 00:40:37,280
重要的是将卷积实现为自动操作中的原子操作
--differentiation toolkit. And that means we need to be able to differentiate them. We need to have 00:40:37,280 --> 00:40:41,680
差异化工具包。这意味着我们需要能够区分它们。我们需要有
--sort of the, we need to find them basically as ops in needle, not as modules in needle. That was, 00:40:41,680 --> 00:40:48,880
某种程度上，我们需要基本上将它们作为 ops in needle 来找到，而不是作为 needle 中的模块。那是，
--it's another way of putting all this, right? So if we're going to implement convolutions as an op, 00:40:48,880 --> 00:40:53,760
这是所有这些的另一种方式，对吧？所以如果我们要将卷积实现为一个操作，
--as an operator, we need to know both how to compute them, which we've kind of covered so 00:40:53,760 --> 00:40:58,320
作为操作员，我们需要知道如何计算它们，我们已经介绍过了
--far, but we also need to know, well, we've covered so far, but we haven't gotten details of how you 00:40:58,320 --> 00:41:02,160
到目前为止，但我们还需要知道，好吧，到目前为止我们已经介绍过了，但我们还没有得到关于你如何做的细节
--actually compute these in practice. We need to know how to compute them and we need to know how 00:41:02,160 --> 00:41:06,320
实际上在实践中计算这些。我们需要知道如何计算它们，我们需要知道如何
--to compute their gradient. Or in other words, sort of multiply by the adjoint, compute all the 00:41:06,320 --> 00:41:11,600
计算它们的梯度。或者换句话说，有点乘以伴随，计算所有
--adjoints that we need. All right. So the basic problem here is exactly what I sort of laid out 00:41:11,600 --> 00:41:18,960
我们需要的陪伴。好的。所以这里的基本问题正是我提出的
--just now, is that if we define our operator, because we want to have kind of an atomic 00:41:18,960 --> 00:41:22,720
刚才，如果我们定义我们的运算符，因为我们想要一种原子的
--operator, if we define our operator as z equals some convolution between our input x and our 00:41:22,720 --> 00:41:29,120
运算符，如果我们将运算符定义为 z 等于我们的输入 x 和我们的
--filters w, where again, z here would be sort of a rank three tensor, order three tensor, x would be 00:41:29,120 --> 00:41:36,080
过滤 w，这里的 z 将是一种三阶张量，三阶张量，x 将是
--a order, also an order three tensor, height by width channels, and w would be an order four 00:41:36,080 --> 00:41:41,520
一个阶数，也是一个三阶张量，高度乘以宽度通道，w 将是一个四阶
--tensor for, you know, all the, all the filter locations plus all the channel inputs by channel 00:41:41,520 --> 00:41:48,720
张量，你知道，所有的，所有的过滤器位置加上所有通道输入的通道
--outputs. But let's, you know, let's not worry too much about sizes here of tensors and stuff, 00:41:48,720 --> 00:41:54,800
输出。但是，你知道，我们不要太担心张量和其他东西的大小，
--because it's actually very, if you break these all down into sort of individual tensors, these, 00:41:54,800 --> 00:41:59,120
因为它实际上非常，如果你把这些都分解成某种单独的张量，这些，
--these, these, I mean, this is a, you know, the derivative of a rank three operation with respect 00:41:59,120 --> 00:42:05,840
这些，这些，我的意思是，这是一个，你知道的，三阶运算的导数
--to a rank three tensor with respect to a rank four tensor. I mean, it gets, it gets pretty 00:42:05,840 --> 00:42:10,560
相对于四阶张量的三阶张量。我的意思是，它变得，它变得漂亮
--complicated, right? But let's just think sort of, sort of an intuitive level, how we might go about 00:42:10,560 --> 00:42:16,560
复杂吧？但是让我们想一想，从直觉的角度来看，我们可能会怎么做
--multiplying these two adjoints. Because remember, in automatic differentiation, when we want to do 00:42:16,560 --> 00:42:22,800
乘以这两个伴随物。因为请记住，在自动微分中，当我们想做的时候
--this, we want to be able to multiply some adjoint here with these two partial derivatives, or really 00:42:22,800 --> 00:42:30,480
这个，我们希望能够在这里将一些伴随与这两个偏导数相乘，或者实际上
--Jacobians more generally, right? The derivative with respect to our weights, and the derivative 00:42:30,480 --> 00:42:36,080
雅可比更普遍，对吧？关于我们的权重的导数，以及导数
--with respect to the input, right? So this, this operator has two inputs here, and one output, 00:42:36,080 --> 00:42:41,520
关于输入，对吧？所以这个，这个运算符在这里有两个输入和一个输出，
--and so we need to be able to differentiate with respect to either of its two inputs, 00:42:41,520 --> 00:42:45,920
所以我们需要能够区分它的两个输入中的任何一个，
--either with respect to the weights, or with respect to its input. Okay, so how do we go about 00:42:45,920 --> 00:42:53,840
要么关于权重，要么关于它的输入。好的，那我们该怎么做
--doing this? How do we go about sort of computing these derivatives? Because again, on first glance, 00:42:53,840 --> 00:43:00,960
做这个？我们如何着手计算这些导数？因为，乍一看，
--these seem quite complicated, right? They seem like, well, that's, you know, geez, these are, 00:43:00,960 --> 00:43:04,800
这些看起来很复杂吧？他们看起来，嗯，那是，你知道的，天哪，这些是，
--these are rank, these are the derivative of, you know, a three, a rank three tensor with respect 00:43:04,800 --> 00:43:12,160
这些是秩，这些是三阶张量的导数
--to a rank four tensor, or another rank three tensor. These, these get pretty complicated, right? 00:43:12,160 --> 00:43:16,640
到四阶张量，或另一个三阶张量。这些，这些变得相当复杂，对吧？
--And so, and so it's, it's important to emphasize that this is, you don't want to do this out 00:43:16,640 --> 00:43:24,080
所以，所以，重要的是要强调这是，你不想这样做
--term by term. You want to think kind of conceptually about what these things are really doing, 00:43:24,080 --> 00:43:29,600
一个学期一个学期。你想从概念上思考这些东西到底在做什么，
--and use, and use that as your, as your way of actually computing these, these, these properties. 00:43:29,600 --> 00:43:35,040
并使用，并将其用作您实际计算这些、这些、这些属性的方式。
--Okay, so to motivate this, I'm going to consider the case of matrix-vector products, okay? And so 00:43:35,280 --> 00:43:42,400
好的，为了激发这一点，我将考虑矩阵向量乘积的情况，好吗？所以
--remember that in the matrix-vector product, let's, let's simplify things a bit as kind of 00:43:42,400 --> 00:43:47,360
请记住，在矩阵向量乘积中，让我们将事情简化为
--a motivation, because what we're going to do in a second is we're going to recast, 00:43:47,360 --> 00:43:50,560
一种动机，因为我们马上要做的是重铸，
--we're going to recast convolutions actually as really big, kind of blown-up matrix-vector 00:43:52,000 --> 00:43:58,720
我们将重铸卷积实际上是非常大的，一种放大的矩阵向量
--products, and that's how we're going to kind of use this analog. But to be clear, we're not 00:43:58,720 --> 00:44:02,000
产品，这就是我们将如何使用这个模拟。但需要明确的是，我们不是
--actually going to form those things, we're just going to sort of think about them conceptually 00:44:02,000 --> 00:44:04,240
实际上要形成那些东西，我们只是要从概念上考虑它们
--like that. Okay, so let's think about sort of a simpler operation here, where x is the vector, 00:44:04,240 --> 00:44:10,560
像那样。好的，让我们在这里考虑一种更简单的操作，其中 x 是向量，
--z is another vector, and w is a scalar. So let's, yeah, let's, I guess I could just, you can write 00:44:10,560 --> 00:44:15,040
 z 是另一个向量，w 是标量。所以让我们，是的，让我们，我想我可以，你可以写
--these out. So let's think about x being a vector that's in Rn, z a vector in Rm, and so w would be 00:44:15,040 --> 00:44:24,080
这些出来。所以让我们考虑 x 是 Rn 中的向量，za 是 Rm 中的向量，所以 w 将是
--a vector, or be a matrix in Rm by n, right? Let's think about that as our, as our starting point. 00:44:24,880 --> 00:44:34,960
一个向量，或者是 Rm 乘以 n 的矩阵，对吧？让我们将其视为我们的出发点。
--Now we know from sort of our basic differentiation rules, and maybe with our cheating ones or our 00:44:34,960 --> 00:44:40,720
现在我们从某种基本的区分规则中知道了，也许还有我们的作弊规则或我们的
--non-cheating ones, that the derivative of z with respect to x for this operation here is just equal 00:44:40,720 --> 00:44:45,360
非作弊的，对于这里的操作，z 相对于 x 的导数恰好相等
--to w, right? So that's sort of our, our, our, the, the nature of the operation here. And hopefully 00:44:45,360 --> 00:44:52,880
对吧？所以这就是我们的，我们的，我们的，这里的操作的性质。希望
--actually what I'm about to say here makes total sense once you've implemented your, your homework 00:44:52,880 --> 00:44:56,720
实际上，一旦你完成了你的作业，我在这里要说的就完全有意义了
--one here. But when we want to compute this, the product of our, you know, incoming adjoint, and 00:44:56,720 --> 00:45:02,560
一个在这里。但是当我们想要计算这个时，我们的产品，你知道，传入伴随，和
--we have to in fact transpose it to make this a sort of valid matrix operation, we want to multiply 00:45:02,560 --> 00:45:07,520
我们实际上必须转置它以使其成为一种有效的矩阵运算，我们想乘以
--this by our matrix w. To compute this sort of, compute the adjoints we need for automatic 00:45:07,520 --> 00:45:15,280
这是我们的矩阵 w。要计算这种类型，请计算我们需要的伴随
--differentiation, we have to compute this product here, right? We have to compute our, our, our 00:45:15,280 --> 00:45:19,600
差异化，我们必须在这里计算这个产品，对吧？我们必须计算我们的，我们的，我们的
--incoming adjoint transposed times our, our vector of, of our matrix of weights here, right? But that 00:45:19,600 --> 00:45:29,200
输入伴随转置乘以我们的，我们的向量，我们的权重矩阵，对吧？但是那个
--of course really is equivalent to just taking our matrix transpose times this vector v, right? So 00:45:29,200 --> 00:45:38,800
当然真的等同于将我们的矩阵转置乘以这个向量 v，对吧？所以
--thinking of it in terms of, you know, multiplying a vector on, on the right, this is multiplying the, 00:45:38,800 --> 00:45:44,960
考虑一下，你知道，在右边乘以一个向量，这是乘以，
--by the transpose of w. And so the only point I want to make from this is that when our forward 00:45:45,360 --> 00:45:52,400
通过 w 的转置。因此，我想从中得出的唯一一点是，当我们的前进
--pass involves computing w times the forward variable, our backward pass involves multiplying 00:45:52,400 --> 00:46:01,280
pass 涉及计算 w 乘以前向变量，我们的 backward pass 涉及乘以
--by the transpose of w. In fact, the transpose is sometimes called the adjoint in, in some 00:46:01,280 --> 00:46:07,600
通过 w 的转置。事实上，转置有时被称为伴随，在一些
--linear algebra, right? So these things are all very related, of course. And so again that's, 00:46:07,600 --> 00:46:14,320
线性代数，对吧？所以这些事情当然都是非常相关的。又是这样，
--that's the key point. Multiplying a input by a matrix, or really any linear operation in fact, 00:46:14,320 --> 00:46:22,080
这是关键点。将输入乘以矩阵，或者实际上是任何线性运算，
--which is what we're going to exploit here, if our forward pass multiplies by that operator, 00:46:22,080 --> 00:46:27,280
这就是我们在这里要利用的，如果我们的前向传递乘以那个运算符，
--our backward pass has to multiply by its transpose. That's the only point I'm trying 00:46:28,000 --> 00:46:32,560
我们的反向传递必须乘以它的转置。这是我唯一要尝试的一点
--to make here. So the question is, what is the transpose of a convolution, right? What's, 00:46:32,560 --> 00:46:40,800
在这里制作。那么问题来了，什么是卷积的转置，对吧？什么是，
--what's the equivalent of transposing a convolution? All right, so for this I'm going to now 00:46:40,800 --> 00:46:47,200
转置卷积的等价物是什么？好吧，为此我现在要
--get a bit, get, get a bit in some detail. And what we're going to do is we're going to actually 00:46:48,560 --> 00:46:54,800
得到一点，得到，得到一些细节。我们要做的是
--write out a convolution in terms of a matrix operation. All right, so let's, let me, let me 00:46:54,800 --> 00:47:03,120
根据矩阵运算写出卷积。好吧，让我们，让我，让我
--now actually use the, use sort of a bunch of possible, a bunch of possible sort of inputs here. 00:47:03,120 --> 00:47:09,520
现在实际使用，使用一堆可能的，一堆可能的输入。
--Let me take our output, all these different colors in fact, I'm going to, I'm going to consider a 00:47:09,520 --> 00:47:15,280
让我看看我们的输出，事实上所有这些不同的颜色，我要，我要考虑一个
--simplified case where I only have a, a 1D convolution. So I'm going to take a 1D signal 00:47:15,280 --> 00:47:22,240
我只有一个一维卷积的简化情况。所以我要接收一维信号
--and convolve it with a 1D set of filters. It's easier, easier to view that way. But the, hopefully 00:47:22,240 --> 00:47:28,000
并将其与一组一维过滤器进行卷积。这样看更容易，更容易。但是，希望
--it's obvious how this will extend to the, to the 2D case. In fact, we will show how to implement 00:47:28,000 --> 00:47:33,440
很明显这将如何扩展到 2D 情况。事实上，我们将展示如何实现
--this in the 2D case when we talk about, in a few lectures from now, the, the implementation of 00:47:33,440 --> 00:47:39,040
在 2D 案例中，当我们从现在开始的几节课中讨论时，实现
--convolutions. So let's, let's consider a case where we want to create a, an output which is a, 00:47:39,040 --> 00:47:44,320
卷积。那么，让我们考虑一个案例，我们想要创建一个输出，它是一个，
--a 5D vector here. So it will be z1, z2, z3, z4, and z5. And this is going to be equal to 00:47:45,840 --> 00:47:58,560
此处为 5D 矢量。所以它将是 z1、z2、z3、z4 和 z5。这将等于
--our input x. So I'm actually going to zero pad it. So this would be, hopefully I'm getting the 00:47:59,360 --> 00:48:04,080
我们的输入 x。所以我实际上要把它补零。所以这将是，希望我能得到
--sizes okay here. So I'm going to have zeros there. Then I'm going to have x1, then x2, x3, 00:48:04,080 --> 00:48:11,200
这里的尺寸还可以。所以我要在那里有零。然后我要 x1，然后 x2，x3，
--and zero. So let me just make sure I get all the entries here. x3, x4, x5, and zero. Okay. 00:48:12,800 --> 00:48:20,880
和零。所以让我确保我得到了这里的所有条目。 x3、x4、x5 和零。好的。
--And then I'm going to be convolving this 00:48:21,600 --> 00:48:23,440
然后我要将这个进行卷积
--with, in this case, a three-dimensional weight matrix. All right. So it'll be 00:48:26,160 --> 00:48:31,040
在这种情况下，具有三维权重矩阵。好的。所以会是
--w1, w2, and w3. Okay. So that's my operation I want to apply there. 00:48:35,200 --> 00:48:42,960
w1、w2 和 w3。好的。这就是我想在那里申请的手术。
--All right. So the thing I'm going to do here is I'm going to write this operation out in terms of 00:48:44,000 --> 00:48:50,480
好的。所以我要做的是我将把这个操作写成
--a matrix equivalent operation. So I'm going to think here of x as a vector, not a zero-padded 00:48:51,040 --> 00:49:00,560
矩阵等效运算。所以我在这里将 x 视为向量，而不是零填充
--vector, just a vector itself, just the actual elements of x as a vector. And I'm going to 00:49:00,560 --> 00:49:05,120
向量，只是一个向量本身，只是 x 作为向量的实际元素。我要去
--create a matrix such that my vector of z, so treating z as a vector here, 00:49:05,120 --> 00:49:10,480
创建一个矩阵，使我的 z 向量，因此在这里将 z 视为向量，
--is equal to this matrix times the vector representation of x. All right. So maybe, 00:49:12,160 --> 00:49:17,840
等于此矩阵乘以 x 的向量表示。好的。所以也许，
--maybe a little bit more formally. What I mean by that is, you know, z here can be itself a vector, 00:49:17,920 --> 00:49:22,720
也许更正式一点。我的意思是，你知道，这里的 z 本身可以是一个向量，
--right? z1, z2, z3, z4, and z5. A bit nicer brackets on that. All right. So that's going 00:49:22,720 --> 00:49:37,680
正确的？ z1、z2、z3、z4 和 z5。更好的括号。好的。就是这样
--to be equal to something. I don't quite know what yet. Times, maybe I should make that something in 00:49:37,680 --> 00:49:46,720
等于某物。我还不太清楚是什么。时代，也许我应该把它做成
--blue to be consistent here. Something in blue times my vector of x's. So x1, x2, x3, x4, and x5. 00:49:46,720 --> 00:50:00,160
蓝色在这里保持一致。蓝色的东西乘以我的 x 向量。所以 x1、x2、x3、x4 和 x5。
--All right. So the question is, what is that something? What is this something here 00:50:02,560 --> 00:50:06,320
好的。所以问题是，那是什么东西？这是什么东西
--that we actually would, would need? And I'm going to call this, this thing here, 00:50:07,520 --> 00:50:10,800
我们实际上会，会需要？我要称这个，这里的东西，
--I'm going to call this w hat. But what is this, what is this matrix? 00:50:10,800 --> 00:50:15,600
我要把这个叫做什么。但是这是什么，这个矩阵是什么？
--Right. So what this is, well, well, and of course this is going to have to be equivalent to, 00:50:18,000 --> 00:50:23,520
正确的。那么这是什么，嗯，当然，这必须等同于，
--on some level, you know, in the end, this should be equivalent to our vector x convolved with w. 00:50:23,520 --> 00:50:31,360
在某种程度上，你知道，最终这应该等同于我们的向量 x 与 w 的卷积。
--So what do we need to fill in there? I mean, obviously this shouldn't, you know, this, 00:50:33,680 --> 00:50:36,880
那么我们需要在那里填写什么呢？我的意思是，显然这不应该，你知道，这个，
--this thing here should involve entries of w, but what should we fill in to make this, 00:50:36,880 --> 00:50:41,600
这里的这个东西应该涉及w的条目，但是我们应该填写什么才能使这个，
--to make this kind of valid? Well, let's think about it. Let's think about what do we multiply, 00:50:41,600 --> 00:50:47,200
使这种有效？好吧，让我们考虑一下。让我们想想我们乘以什么，
--what, you know, what do we multiply by our vector here of x's to produce z1? 00:50:47,200 --> 00:50:52,000
什么，你知道，我们用 x 的矢量乘以什么来产生 z1？
--Well, what we do for that vector, I'm going to try to sort of make best use of the 00:50:53,840 --> 00:50:57,840
好吧，我们为那个向量做了什么，我将尝试最好地利用
--medium here, is we sort of take our filter and we kind of slide it across different values here, 00:50:58,400 --> 00:51:03,680
媒介在这里，我们是不是有点像我们的过滤器，我们在这里滑过不同的值，
--right, as much as my little drawing here lines up with these things, okay? So for the first element, 00:51:03,680 --> 00:51:08,640
是的，只要我这里的小画符合这些东西，好吗？所以对于第一个元素，
--we would take this and kind of put it here, right? We would multiply 0 by w1, so we don't multiply 00:51:08,640 --> 00:51:14,640
我们会把它放在这里，对吧？我们会将 0 乘以 w1，所以我们不乘
--w1 by anything, w2 by x1, w3 by x2, okay? So that, in other words, would be, well, we multiply x1 00:51:14,640 --> 00:51:25,360
w1 通过任何方式，w2 通过 x1，w3 通过 x2，好吗？换句话说，我们乘以 x1
--by w2, x2 by w3, and we don't multiply anything with the rest, right? The rest don't, don't have 00:51:25,360 --> 00:51:34,560
乘以 w2，x2 乘以 w3，我们不将任何东西与其余部分相乘，对吗？其余的没有，没有
--any, x3 through x5 don't have any impact on z1. Now let's think about z2, okay? So let's think 00:51:34,560 --> 00:51:43,760
any，x3 到 x5 对 z1 没有任何影响。现在让我们考虑一下 z2，好吗？所以让我们想想
--about z2. Well, we slide our filter over again, and z2 is produced by this sort of element-wise 00:51:43,760 --> 00:51:50,640
关于z2。好吧，我们再次滑动我们的过滤器，z2 是由这种元素产生的
--product. We multiply x1 by w1, x2 by w2, x3 by w3, right? And in, again, matrix form, what this would be 00:51:50,640 --> 00:51:58,080
产品。我们将 x1 乘以 w1，x2 乘以 w2，x3 乘以 w3，对吗？再次以矩阵形式，这将是什么
--is this would be, here we would have, we multiply x1 here by w1, x2 by w2, and x3 by w3, 00:51:58,080 --> 00:52:11,120
是这样吗，在这里我们将 x1 乘以 w1，x2 乘以 w2，x3 乘以 w3，
--and we don't multiply x4 or x5 by anything, okay? And one more time, I'll do this. So our next element, 00:52:11,120 --> 00:52:18,720
而且我们不会将 x4 或 x5 乘以任何东西，好吗？再一次，我会这样做。所以我们的下一个元素，
--z3, would be equal to sort of this product, x2 times w1, x3 times w2, x4 times w3, etc. 00:52:18,720 --> 00:52:28,160
 z3，等于此乘积的排序，x2 乘以 w1，x3 乘以 w2，x4 乘以 w3，等等。
--And so what this looks like in the, in sort of the matrix form is, well, we don't multiply 00:52:28,720 --> 00:52:34,480
所以这在某种矩阵形式中看起来像，好吧，我们不相乘
--anything by w1, so we would have a zero here. We multiply w, or x2 by w1, so we have a w1 here, 00:52:34,480 --> 00:52:43,680
w1 的任何东西，所以我们在这里有一个零。我们将 w 或 x2 乘以 w1，所以这里有一个 w1，
--and then similarly x3 by w2, x4 by w3, etc., right? And if I just fill this out, what you'll get is 00:52:43,680 --> 00:52:50,640
然后类似地 x3 乘以 w2，x4 乘以 w3，等等，对吗？如果我只是填写这个，你会得到的是
--you'll get this next row is going to be w1, w2, w3, and the final row would be this, w1, w2, okay? 00:52:50,640 --> 00:53:00,560
你会看到下一行是 w1、w2、w3，最后一行是 w1、w2，好吗？
--So this is the matrix form. This matrix operation here produces the exact same output as our 00:53:00,560 --> 00:53:09,040
所以这是矩阵形式。这里的矩阵运算产生与我们的完全相同的输出
--convolution. It is a matrix way of representing our convolution, okay? And that's the, that's sort 00:53:09,040 --> 00:53:16,640
卷积。这是表示卷积的矩阵方式，好吗？就是这样
--of the key idea here when you think about, you know, a, if we want to multiply by the transpose 00:53:16,640 --> 00:53:21,840
当你想到这里的关键思想时，你知道，a，如果我们想乘以转置
--of this convolution, well, it's, it's now doable because now we've written out sort of our convolution 00:53:21,840 --> 00:53:27,600
这个卷积，嗯，它现在是可行的，因为现在我们已经写出了我们的卷积
--as just this, this, this matrix here. And so, and this is a very general sort of state, this is a 00:53:27,600 --> 00:53:33,680
就像这个，这个，这个矩阵在这里。所以，这是一种非常普遍的状态，这是一个
--very general thing. We can really write any convolution just as this sort of matrix of all 00:53:33,680 --> 00:53:39,680
很一般的事情。我们真的可以写任何卷积就像这种所有的矩阵
--our weights, or matrix containing our weights in different locations. Now I want to be very clear 00:53:39,680 --> 00:53:44,560
我们的权重，或包含我们在不同位置的权重的矩阵。现在我想很清楚
--about one thing. We don't actually want to construct this matrix. This is maybe reasonable for this 00:53:44,560 --> 00:53:50,320
关于一件事。我们实际上并不想构造这个矩阵。这也许是合理的
--size, but if you have a really long sequence, like things like that, you would create a matrix with a 00:53:50,320 --> 00:53:54,160
大小，但是如果你有一个很长的序列，就像那样，你会创建一个矩阵
--whole bunch of zeros here, right? And so to be very clear, this is a conceptual thing that we're doing. 00:53:54,160 --> 00:53:58,480
这里有一大堆零，对吧？所以非常清楚，这是我们正在做的概念性的事情。
--We are not actually going to create this matrix. We actually are going to instantiate a, 00:53:59,280 --> 00:54:04,400
我们实际上并不打算创建这个矩阵。我们实际上要实例化一个，
--kind of a different but similar matrix when we, for efficiency purposes, but we won't be 00:54:04,400 --> 00:54:08,720
一种不同但相似的矩阵，当我们出于效率目的，但我们不会
--instantiating this matrix. What we're actually going to be doing is just using this sort of 00:54:08,720 --> 00:54:12,960
实例化这个矩阵。我们实际上要做的就是使用这种
--conceptual idea to represent what the transpose of a convolution is. Okay, so this is our, 00:54:12,960 --> 00:54:20,240
表示卷积转置的概念。好的，这是我们的，
--this is our sort of matrix here. And maybe actually, let me, let me do this again because 00:54:20,240 --> 00:54:26,480
这是我们这里的矩阵。也许实际上，让我，让我再做一次，因为
--I'm going to get on the next page. Let me copy it and go to my, my next page. So the question I 00:54:26,480 --> 00:54:33,200
我要进入下一页。让我复制它并转到我的下一页。所以我的问题
--have is that once we know what W is here, let me, let me paste it in here. Once we know here what W 00:54:33,200 --> 00:54:39,600
一旦我们知道 W 在这里，让我，让我把它粘贴在这里。一旦我们在这里知道什么 W
--is, how do we compute, and I'll put it kind of up there, how do we compute W transpose? 00:54:39,600 --> 00:54:46,080
是，我们如何计算，我会把它放在那里，我们如何计算 W 转置？
--Well, now that we know what W is matrix form, now it's easy because now we just 00:54:49,440 --> 00:54:52,240
好吧，既然我们知道 W 是什么矩阵形式，现在就很容易了，因为现在我们只是
--transpose W, right? So let's just create W transpose. I'll call this W hat. W hat transpose 00:54:52,800 --> 00:54:58,480
转置 W，对吗？所以让我们创建 W 转置。我将其称为 W 帽子。什么转置
--would be, well, what is it? So the first row would be W2, W1, and then zeros. 00:54:58,480 --> 00:55:06,000
会是什么？所以第一行是 W2、W1，然后是零。
--My pen is flicking out again. That's the first row because that's, that's this column here. 00:55:09,200 --> 00:55:16,640
我的笔又弹了出来。这是第一行，因为这是这里的这一列。
--The next row would be this column. So it would be W3, W, sorry, yeah, W3, W2, W1, and 0, 0. Next you 00:55:17,600 --> 00:55:32,080
下一行就是这一列。所以它会是 W3，W，对不起，是的，W3，W2，W1 和 0、0。接下来你
--would have this column here. So that would be 0, W3, W2, W1, and 0, and then 0, 0, W3, W2, W1, 00:55:32,320 --> 00:55:49,040
会在这里有这个专栏。所以这将是 0、W3、W2、W1 和 0，然后是 0、0、W3、W2、W1、
--and 0, 0, 0, W3, W2. Okay, so that's, that's our transpose. But now something really cool happens, 00:55:49,040 --> 00:56:00,480
和 0、0、0、W3、W2。好的，这就是我们的转置。但现在真的很酷的事情发生了，
--which is that this matrix here looks a whole lot like this one. It's just that the order 00:56:01,360 --> 00:56:12,320
这是这个矩阵看起来很像这个。只是顺序而已
--of, it has the exact same sort of, you know, elements on the, on the diagonal, on the, 00:56:14,000 --> 00:56:19,440
的，它具有完全相同类型的元素，在对角线上，在，
--on the sort of diagonal, and the bands are all, they're all the same, just like in this one. 00:56:19,440 --> 00:56:23,600
在某种对角线上，乐队都是，他们都是一样的，就像这个一样。
--The only difference is the ordering. So this one has the ordering W3, W2, W1. This one has 00:56:24,160 --> 00:56:30,400
唯一的区别是顺序。所以这个有顺序 W3、W2、W1。这个有
--the ordering W1, W2, W3. But the point is, multiplying by this matrix, the transpose of this, 00:56:30,400 --> 00:56:37,920
排序 W1、W2、W3。但关键是，乘以这个矩阵，这个矩阵的转置，
--well, this operator here is also a convolution, right? Multiplying this is exactly convolving 00:56:37,920 --> 00:56:44,320
嗯，这里的这个算子也是一个卷积对吧？乘以这个正好是卷积
--an input with the same filter, just the filter flipped. So instead of convolving kind of with 00:56:45,120 --> 00:56:53,760
具有相同过滤器的输入，只是过滤器翻转了。所以不是用
--W1, W2, W3, we convolve with the flipped left to right version of this filter. And that is 00:56:53,760 --> 00:57:03,520
W1、W2、W3，我们与此过滤器的从左到右翻转版本进行卷积。那就是
--sort of, and by the way, that's, that's the relationship I mentioned way before, 00:57:05,520 --> 00:57:09,840
有点，顺便说一下，这就是我之前提到的关系，
--sort of signal processing uses this flipped version, they actually call that a convolution. 00:57:09,840 --> 00:57:13,840
某种信号处理使用这种翻转版本，他们实际上称之为卷积。
--This is why this sort of flipping is actually quite common. The key idea here is that multiplying 00:57:14,480 --> 00:57:22,720
这就是为什么这种翻转实际上很常见的原因。这里的关键思想是乘以
--by the transpose of a convolution is equivalent to convolving with a flipped version of the filter. 00:57:22,720 --> 00:57:31,200
通过卷积的转置相当于与过滤器的翻转版本进行卷积。
--Right? So in other words, to actually compute this operation, say we're going to compute this sort of 00:57:33,040 --> 00:57:38,720
正确的？所以换句话说，为了实际计算这个操作，假设我们要计算这种
--derivative here, we wouldn't actually form the Jacobian or anything like that, right? 00:57:38,720 --> 00:57:46,080
在这里导数，我们实际上不会形成雅可比行列式或类似的东西，对吧？
--To compute this operation, nor do we even form this matrix, right? What we, what we do to compute 00:57:46,080 --> 00:57:54,080
要计算这个操作，我们甚至不会形成这个矩阵，对吧？我们，我们所做的计算
--this term here is we say that, well, our product between our adjoint term 00:57:54,080 --> 00:58:02,560
这里的这个词是我们说的，好吧，我们的伴随词之间的乘积
--with respect to x, because again, remember, to get our original derivative, like, that had W in it, 00:58:02,960 --> 00:58:09,440
关于 x，因为再次记住，要得到我们的原始导数，比如其中有 W，
--this is a few slides back, we were talking about derivatives with respect to x here. So that's our, 00:58:09,440 --> 00:58:15,200
这是几张幻灯片，我们在这里讨论关于 x 的导数。这就是我们的，
--that's, that's the, that's what we're doing. Well, this thing is just equal to the convolution 00:58:15,200 --> 00:58:22,880
那是，那是，这就是我们正在做的。嗯，这个东西正好等于卷积
--is just equal to the convolution of our adjoint term with, like, the flip of W. 00:58:22,880 --> 00:58:31,440
正好等于我们的伴随项与 W 的翻转的卷积。
--That's pretty, that's pretty impressive, right? That's pretty neat. That's all we're doing when 00:58:34,720 --> 00:58:40,400
这很漂亮，令人印象深刻，对吧？这很整洁。这就是我们所做的一切
--we're doing a convolution, when it's transpose of a convolution. We don't need to form this matrix, 00:58:40,400 --> 00:58:44,880
当它是卷积的转置时，我们正在做一个卷积。我们不需要形成这个矩阵，
--we don't need to do anything other than just flip our filter and convolve with that. And of course, 00:58:44,880 --> 00:58:50,720
除了翻转我们的过滤器并与之进行卷积之外，我们不需要做任何事情。而且当然，
--if you do this twice, you sort of get, you know, goes back to the original filter, right? 00:58:50,720 --> 00:58:54,320
如果你这样做两次，你就会回到原来的过滤器，对吧？
--So that's really, that, that, that's sort of really impressive, I think, 00:58:56,320 --> 00:58:59,680
所以那真的，那，那，那真的令人印象深刻，我认为，
--and a really nice property of convolutions is that in order to multiply by the transpose 00:58:59,680 --> 00:59:06,560
卷积的一个非常好的特性是为了乘以转置
--of convolution, you just convolve with a flipped convolution. And so this is how we compute, 00:59:06,560 --> 00:59:13,200
卷积，你只需用翻转卷积进行卷积。这就是我们计算的方式，
--in practice, our adjoints needed for convolutions without having to actually store, you know, 00:59:13,200 --> 00:59:22,560
在实践中，我们的伴随需要进行卷积而不需要实际存储，你知道的，
--either compute rank three tensors or stuff like this, or rank seven tensors, right? 00:59:23,280 --> 00:59:26,960
要么计算三阶张量或类似的东西，要么计算七阶张量，对吗？
--And without having to even form these matrices, because this, this matrix here, this construction, 00:59:28,080 --> 00:59:32,320
甚至不必形成这些矩阵，因为这个，这里的这个矩阵，这个结构，
--that was just sort of for, for illustration, right? That was just sort of to derive this fact. 00:59:32,320 --> 00:59:36,240
那只是为了说明，对吧？这只是推导出这个事实。
--Once we know this about it, we can just implement our, our backward pass as a convolution itself. 00:59:36,240 --> 00:59:41,760
一旦我们知道了这一点，我们就可以将我们的反向传递作为卷积本身来实现。
--Okay, and this is, by the way, this is also sort of setting off, setting up alarms that, you know, 00:59:44,160 --> 00:59:48,480
好的，顺便说一句，这也是一种触发，设置警报，你知道，
--you could implement the op then as calling the original function and stuff like this, right? 00:59:49,520 --> 00:59:53,680
您可以将 op 实现为调用原始函数和类似的东西，对吗？
--So there's a lot of very nice things about it. Okay, so this is almost the whole story, but the, 00:59:53,680 --> 00:59:59,840
所以它有很多非常好的东西。好的，这几乎就是整个故事，但是，
--the rest of the story actually involves the other adjoint we need to form, namely, 00:59:59,840 --> 01:00:05,760
故事的其余部分实际上涉及我们需要形成的另一个伴随，即
--the derivative with respect to w. So this whole one was for the derivative with respect to x, 01:00:05,760 --> 01:00:11,840
关于 w 的导数。所以这整个是关于 x 的导数，
--right? Because that was sort of how we derived this. What about the derivative with respect to w? 01:00:12,480 --> 01:00:18,320
正确的？因为这就是我们得出这一点的方式。关于 w 的导数呢？
--And for this, but actually not just for this, but also for sort of very practical purposes, 01:00:19,680 --> 01:00:25,680
为此，但实际上不仅仅是为了这个，也是为了某种非常实际的目的，
--because it turns out that this is exactly how we're going to, in fact, implement convolutions. 01:00:25,680 --> 01:00:29,600
因为事实证明这正是我们将要实现的卷积的方式。
--It turns out that we can also write convolutions in a different way. So if we have our z, 01:00:31,200 --> 01:00:37,280
事实证明，我们还可以用不同的方式编写卷积。所以如果我们有 z，
--maybe I'll even copy from our previous slide here. Yeah, I'm going to copy this whole thing. 01:00:37,680 --> 01:00:44,400
也许我什至会在这里复制我们之前的幻灯片。是的，我要复制这整件事。
--Again, trying to use the medium as effectively as I can. 01:00:50,320 --> 01:00:53,040
再次尝试尽可能有效地使用媒体。
--Let's put it down here. That's the place for it. 01:00:54,080 --> 01:00:56,880
让我们把它放在这里。那就是它的地方。
--We can also represent this operation, not just in terms of making w a matrix, 01:00:59,280 --> 01:01:04,080
我们也可以表示这个操作，不仅仅是在制作 wa 矩阵方面，
--but we can also represent it as z, our vector z here, z1, z2, z3, z4, and z5, 01:01:04,080 --> 01:01:14,480
但我们也可以将其表示为 z，这里是我们的向量 z，z1、z2、z3、z4 和 z5，
--can also be represented as some matrix, which I'm going to write in black now, 01:01:16,880 --> 01:01:22,480
也可以表示为一些矩阵，我现在要用黑色写，
--for reasons you'll see in a second, times the vector representation of our filters. 01:01:23,360 --> 01:01:29,040
由于您稍后会看到的原因，乘以我们过滤器的矢量表示。
--We can end up doing it this way too. And this is actually important because when you differentiate, 01:01:29,680 --> 01:01:35,280
我们最终也可以这样做。这实际上很重要，因为当你区分时，
--you know, based upon if you differentiate with respect to w or with respect to x, you kind of 01:01:35,280 --> 01:01:42,560
你知道，如果你区分 w 或 x，你有点
--want to write this, you want to be able to write this in either way, either as sort of a product 01:01:42,560 --> 01:01:47,200
想要写这个，你希望能够以任何一种方式写这个，或者作为一种产品
--with the x as a vector or with our weights as a vector. But this is actually doable too. 01:01:47,200 --> 01:01:55,600
将 x 作为向量或将我们的权重作为向量。但这实际上也是可行的。
--So we can write it also in this form here. Well, maybe I'll write this thing. I don't think I even 01:01:56,080 --> 01:01:59,840
所以我们也可以在这里写成这种形式。好吧，也许我会写这个东西。我不认为我什至
--labeled it in the slides, maybe, but let's say this thing here is called like x hat, big x hat, 01:01:59,840 --> 01:02:04,960
可能在幻灯片中标记了它，但是假设这里的这个东西叫做 x 帽子，大 x 帽子，
--or something like that. Okay, so how does this work? Well, again, let's just sort of do our 01:02:04,960 --> 01:02:09,760
或类似的东西。好的，那么这是如何工作的？好吧，再一次，让我们做我们的
--little operation here for multiplying the first entry z1 would be equal to 0 times w1 plus x1 01:02:10,640 --> 01:02:18,160
这里用于乘以第一个条目 z1 的小操作将等于 0 乘以 w1 加上 x1
--First entry z1 would be equal to 0 times w1 plus x1 times w2 plus x2 times w3. 01:02:18,240 --> 01:02:24,160
第一个条目 z1 等于 0 乘以 w1 加上 x1 乘以 w2 加上 x2 乘以 w3。
--Right, so that would be our first our first operation there. So what do we multiply? So, 01:02:24,720 --> 01:02:29,600
是的，那将是我们在那里的第一次手术。那么我们乘什么？所以，
--you know, what do we multiply by w1? Well, nothing. That's zero padded. So what, but, 01:02:29,600 --> 01:02:36,000
你知道，我们乘以 w1 是多少？好吧，没什么。那是零填充。那又怎样，但是，
--right, that multiplies this and this. What about w2? Well, w2 multiplies by x1, right? So let's 01:02:36,000 --> 01:02:44,160
对，这乘以这个和这个。 w2呢？那么，w2 乘以 x1，对吗？让我们
--put an x1 here. w3 multiplies by, well, w3 multiplies by x2. So let's put an x, uh, oops, 01:02:44,160 --> 01:02:56,320
在这里放一个x1。 w3 乘以，嗯，w3 乘以 x2。所以让我们放一个 x，呃，哎呀，
--sorry, this was, um, messed that up. This should be, uh, w1 should be 0. It's w2 that multiplies 01:02:56,320 --> 01:03:04,720
抱歉，这是，嗯，搞砸了。这个应该是，呃，w1应该是0，乘以w2
--by x1 and w3 multiplies by x2. All right, do one more and then I'll, I'll just fill it out after 01:03:04,720 --> 01:03:12,480
 x1 和 w3 乘以 x2。好的，再做一个然后我会，我会在之后填写它
--this. But if we, again, slide a filter over the first location, w1 will multiply x1, w2 x2, w3 01:03:12,480 --> 01:03:19,040
这。但是，如果我们再次在第一个位置上滑动过滤器，w1 将乘以 x1、w2 x2、w3
--x3, et cetera. All right, so we would have x1, x2, and x3, and I'll just finish this. Oh, yeah, 01:03:19,040 --> 01:03:26,160
 x3，等等。好吧，我们会有 x1、x2 和 x3，我会完成这个。哦耶，
--maybe didn't give myself quite enough space here, but, um, in the next row we would have x2, x3, 01:03:26,160 --> 01:03:31,920
也许这里没有给自己足够的空间，但是，嗯，在下一行我们会有 x2，x3，
--x4, x3, x4, x5, and x4, x5, and 0. And you can sort of just validate that that is, in fact, 01:03:31,920 --> 01:03:42,560
 x4、x3、x4、x5 和 x4、x5 和 0。你可以稍微验证一下，事实上，
--the right matrix. This is an operation here, this, this sort of expanding the vector in this way, 01:03:42,560 --> 01:03:49,760
正确的矩阵。这是这里的一个操作，这个，这种以这种方式扩展向量，
--or x vector this way, is an operation called, um, m-to-col. And this is important for two reasons. 01:03:49,760 --> 01:03:56,000
或这样的 x 向量，是一个称为，嗯，m-to-col 的操作。这很重要，原因有二。
--The first reason is that if we want to compute this vector here, it's very nice to be able to 01:03:56,720 --> 01:04:02,960
第一个原因是，如果我们想在这里计算这个向量，那么能够
--represent z, basically, um, as equal to, in this case, right, so this case what we're writing here 01:04:02,960 --> 01:04:09,760
代表 z，基本上，嗯，等于，在这种情况下，对，所以这种情况下我们在这里写的
--is we're writing z equals some big matrix x times w, because then we have that the derivative 01:04:09,760 --> 01:04:19,120
我们写的 z 等于某个大矩阵 x 乘以 w，因为这样我们就有了导数
--of, um, this operation with respect to w is equal to our big matrix x, right, so that's sort of why 01:04:19,760 --> 01:04:27,360
的，嗯，这个关于 w 的操作等于我们的大矩阵 x，对，所以这就是为什么
--we might want to do this. Um, but this actually also ends up being quite useful, unlike the 01:04:27,360 --> 01:04:34,560
我们可能想这样做。嗯，但这实际上也很有用，不像
--previous one, where sort of w, we wouldn't want to form this big w because this just has too many 01:04:34,560 --> 01:04:38,880
前一个，其中有点 w，我们不想形成这个大 w，因为它有太多
--zeros. This operator actually, it has some extra zeros, but it's, it's, it's much fewer, um, and 01:04:38,880 --> 01:04:44,720
零。这个运算符实际上，它有一些额外的零，但是它，它，它要少得多，嗯，而且
--you can kind of convince yourself that, you know, each element here is only going to have the 01:04:44,720 --> 01:04:48,640
你可以说服自己，你知道，这里的每个元素只会有
--elements we're multiplying our actual weights with, and so there's going to be many fewer zeros 01:04:48,640 --> 01:04:53,760
我们乘以实际权重的元素，因此零的数量会少很多
--in this matrix. And in fact, it turns out that in many cases, the most efficient way to implement 01:04:53,760 --> 01:05:01,120
在这个矩阵中。事实上，事实证明，在许多情况下，最有效的实施方式
--convolutions is to first explicitly construct this matrix, this m-to-col matrix, and then 01:05:01,840 --> 01:05:12,720
convolutions就是先显式构造这个矩阵，这个m-to-col矩阵，然后
--do our entire convolution as one big matrix-matrix product. All right, so it's almost surprisingly, 01:05:13,520 --> 01:05:21,440
将我们的整个卷积作为一个大的矩阵矩阵乘积来进行。好吧，这几乎令人惊讶，
--because you think that's, you know, this, this is definitely creating sort of wasted space, 01:05:21,440 --> 01:05:24,480
因为你认为那是，你知道，这，这绝对是在浪费空间，
--wasted space here, right, because this is sort of creating x1, x1 is, you know, x3, x2 is being 01:05:24,480 --> 01:05:29,520
这里浪费了空间，对吧，因为这是在创建 x1，x1 是，你知道的，x3，x2 是
--multiple, is, uh, being represented multiple times here. You end up actually replicating each 01:05:29,520 --> 01:05:34,400
multiple，就是，呃，在这里被代表多次。你最终实际上复制了每个
--location in your, in your signal, and in the case of 2D, you know, I should mention this all holds 01:05:35,200 --> 01:05:39,200
在你的位置，在你的信号中，在 2D 的情况下，你知道，我应该提到这一切
--for 2D cases too, so just like before, and in 2D, you know, the, um, you also have this property 01:05:40,080 --> 01:05:45,440
对于 2D 情况也是如此，所以就像以前一样，在 2D 中，你知道，嗯，你也有这个属性
--that the multiplication with the transpose is equal to the flipped, in this case flipped upside 01:05:45,440 --> 01:05:50,080
与转置的乘积等于翻转，在这种情况下翻转
--down and left right, and in 2D, you would also have sort of, you know, the similar kind of 01:05:50,080 --> 01:05:54,880
上下左右，在 2D 中，你也会有类似的，你知道的
--matrix operation for this, for this convolution. Um, but the, the surprising thing to a certain 01:05:54,880 --> 01:06:02,960
对于这个，对于这个卷积的矩阵运算。嗯，但是，对某些人来说令人惊讶的事情
--degree is that it often ends up being worthwhile to duplicate your memory in this way for the sake 01:06:02,960 --> 01:06:10,720
程度是，为了利益，以这种方式复制你的记忆通常最终是值得的
--of being a bit more efficient, um, when it comes to the computations of matrix-matrix multiplication. 01:06:10,720 --> 01:06:17,120
在计算矩阵-矩阵乘法时，效率会更高一点。
--Now, it's very important that this is, that this is sort of all defined in the op of convolutions. 01:06:17,120 --> 01:06:24,720
现在，非常重要的是，这是在卷积操作中定义的所有内容。
--You don't want to put this term in your, you know, do it explicitly in a computational graph, 01:06:24,720 --> 01:06:31,680
你不想把这个术语放在你的，你知道的，在计算图中明确地做，
--because that would create a lot of memory in your computational graph. It will create, you know, 01:06:31,680 --> 01:06:35,040
因为这会在您的计算图中创建大量内存。它会创造，你知道，
--if you have a 3x3 filter, it will create nine times, you know, as much, as much memory consumption 01:06:35,040 --> 01:06:39,360
如果你有一个 3x3 的过滤器，它会创建九倍，你知道，同样多，同样多的内存消耗
--in your computational graph. Um, but as a way of implementing the, the compute of your op, 01:06:39,360 --> 01:06:46,720
在你的计算图中。嗯，但是作为实现你的操作计算的一种方式，
--this winds up being kind of a very efficient method, and it will also help you in actually 01:06:46,720 --> 01:06:51,840
这是一种非常有效的方法，而且它实际上也会帮助你
--computing the derivatives and the, the, really the, the adjoints for your automatic differentiation 01:06:51,840 --> 01:06:58,240
计算导数以及自动微分的伴随物
--to do it sort of all this way. So that in fact is the, is the entirety of what, um, we're going 01:06:58,800 --> 01:07:05,680
以这种方式做到这一点。所以这实际上是，嗯，我们要去的全部
--to talk about today with convolutions. Uh, it covers sort of what the operations are and how 01:07:05,680 --> 01:07:11,120
今天用卷积来谈谈。呃，它涵盖了一些操作是什么以及如何操作
--you start to integrate them into automatic differentiation tools. And I even sort of 01:07:11,120 --> 01:07:15,520
您开始将它们集成到自动微分工具中。我什至有点
--pointed to this notion of implementing them like this, but it turns out to figure out how to 01:07:15,520 --> 01:07:20,480
指出了像这样实现它们的概念，但结果却弄清楚了如何
--implement convolutions properly, we first need to understand how matrices and vectors and tensors 01:07:20,480 --> 01:07:28,000
正确实现卷积，我们首先需要了解矩阵、向量和张量是如何
--are really stored in memory because it turns out that all these operations, despite seeming quite 01:07:28,000 --> 01:07:33,280
确实存储在内存中，因为事实证明所有这些操作，尽管看起来很
--complex, you know, mapping multiple things, they can all actually be done quite easily 01:07:33,280 --> 01:07:38,720
复杂，你知道，映射多个事物，它们实际上都可以很容易地完成
--by manipulating stride operations in the internal representation of matrices. And so all these 01:07:38,720 --> 01:07:45,920
通过在矩阵的内部表示中操纵步幅操作。所以所有这些
--things, if you have the right calls, namely the, the as strided call, the as strided call, 01:07:45,920 --> 01:07:51,440
事情，如果你有正确的调用，即，跨步调用，跨步调用，
--which is like this magic function that we'll talk about next time, um, or not next time, 01:07:51,440 --> 01:07:55,760
就像我们下次要讲的这个神奇的功能，嗯，还是下次不讲，
--but in a few lectures from now, actually introducing the convolutions, um, you can do 01:07:55,760 --> 01:08:01,040
但从现在开始的几节课中，实际上介绍了卷积，嗯，你可以做到
--this all in very few lines of code. So writing all these operations as it being a complex operation, 01:08:01,040 --> 01:08:05,360
这一切都在非常少的代码行中。所以把所有这些操作写成一个复杂的操作，
--certainly, but done in very few lines of code. All right. So that's, that's all for today and 01:08:05,360 --> 01:08:09,680
当然可以，但是只需很少几行代码即可完成。好的。这就是今天的全部内容
--see everyone next time when we talk about kind of the, the taking a pause now and talking next 01:08:09,680 --> 01:08:17,040
下次我们谈论的时候再见，现在暂停一下，然后再谈
--about the internals of linear algebra libraries so that we can efficiently implement things, 01:08:17,040 --> 01:08:24,400
关于线性代数库的内部结构，以便我们可以有效地实现事物，
--both like matrix, matrix products, but also things like convolutions. All right. See everyone soon. 01:08:24,400 --> 01:08:30,080
既喜欢矩阵，矩阵乘积，也喜欢卷积。好的。很快见到大家。
