--Hi everyone, welcome back to the next lecture in Deep Learning Systems, Algorithms, and 00:00:00,000 --> 00:00:07,480
大家好，欢迎回到深度学习系统、算法和深度学习的下一课
--Implementation. 00:00:07,480 --> 00:00:09,480
执行。
--This lecture is going to pick up on the thread we started last time, where we manually derived 00:00:09,480 --> 00:00:15,640
本讲座将继续我们上次启动的线程，我们在该线程中手动导出
--the softmax regression algorithm. 00:00:15,640 --> 00:00:18,680
softmax回归算法。
--This time around we're going to do this essentially in the same way, just for basic fully connected 00:00:18,680 --> 00:00:24,900
这一次我们将以同样的方式来做这件事，只是为了基本的完全连接
--networks instead of softmax regression. 00:00:24,900 --> 00:00:28,640
网络而不是 softmax 回归。
--Now this is going to be the last lecture where we're kind of doing this in what I would call 00:00:28,640 --> 00:00:32,380
现在这将是最后一堂课，我们将以我称之为的方式来做这件事
--the sort of old-fashioned or manual way of deriving all these derivatives. 00:00:32,380 --> 00:00:38,300
推导所有这些导数的那种老式或手动方法。
--And starting next lecture, we'll pick up on a much more general technique for accomplishing 00:00:38,300 --> 00:00:42,940
从下一课开始，我们将学习一种更通用的技术来完成
--these things, namely automatic differentiation. 00:00:42,940 --> 00:00:45,580
这些东西，就是自动微分。
--However, in this lecture, we're going to do things the slightly more painful way, I would 00:00:45,580 --> 00:00:51,300
然而，在这个讲座中，我们将以稍微痛苦的方式来做事，我会
--say. 00:00:51,300 --> 00:00:52,420
说。
--And if you've seen neural networks before or implemented backpropagation before, there's 00:00:52,420 --> 00:00:56,660
如果您以前见过神经网络或以前实施过反向传播，那么
--a good chance you implemented something like this. 00:00:56,660 --> 00:00:59,540
你很有可能实现了这样的东西。
--Again, the exact notation could be a bit different, but it was probably something fairly similar. 00:00:59,540 --> 00:01:05,540
同样，确切的符号可能有点不同，但它可能非常相似。
--So we're going to go through this, but as I said, the intention here in some sense is 00:01:05,540 --> 00:01:09,460
所以我们要经历这个，但正如我所说，这里的意图在某种意义上是
--to highlight how complex these things can be and motivate why we want a more general 00:01:09,460 --> 00:01:16,760
强调这些事情有多复杂，并激发我们为什么想要一个更通用的
--generic form. 00:01:16,760 --> 00:01:18,980
通用形式。
--Now this lecture really has three parts. 00:01:18,980 --> 00:01:21,780
现在这个讲座真的分为三个部分。
--We're going to start off talking about the basic idea of nonlinear hypothesis classes 00:01:21,780 --> 00:01:26,440
我们将从谈论非线性假设类的基本概念开始
--and why we might want to do that in the first place. 00:01:26,440 --> 00:01:29,440
以及为什么我们可能首先要这样做。
--Last time for soft mass regression, of course, we used a linear hypothesis class. 00:01:29,440 --> 00:01:33,240
上次软质量回归，当然，我们使用了线性假设类。
--We want something now more powerful, and so we'll motivate this a little bit. 00:01:33,240 --> 00:01:37,200
我们现在想要更强大的东西，所以我们会稍微激励一下。
--And then talk about the particular form of hypothesis class that really is going to make 00:01:37,200 --> 00:01:41,040
然后谈谈真正要做出的特定形式的假设类
--up the majority of this course, which is neural networks. 00:01:41,040 --> 00:01:43,880
本课程的大部分内容是神经网络。
--Of course, neural networks themselves are very generic at this point, what we mean by 00:01:43,880 --> 00:01:47,800
当然，神经网络本身在这一点上是非常通用的，我们的意思是
--that term, but this is going to form the basis of the course. 00:01:47,800 --> 00:01:50,720
那个术语，但这将构成课程的基础。
--And so we'll at least introduce this concept and why we might want to use it. 00:01:50,720 --> 00:01:54,800
因此，我们至少会介绍这个概念以及我们可能想要使用它的原因。
--And finally, we'll spend the majority of this class talking about backpropagation, 00:01:54,800 --> 00:02:00,000
最后，我们将用这节课的大部分时间来讨论反向传播，
--which basically boils down to how we compute gradients for neural networks. 00:02:00,000 --> 00:02:06,720
这基本上归结为我们如何计算神经网络的梯度。
--Remember, most everything we're doing here is the same as last time. 00:02:06,720 --> 00:02:10,120
请记住，我们在这里所做的大部分事情都与上次相同。
--We have a hypothesis function, we have a loss function, which is going to be the same, and 00:02:10,120 --> 00:02:13,080
我们有一个假设函数，我们有一个损失函数，它们将是相同的，并且
--we're optimizing with gradient descent. 00:02:13,080 --> 00:02:15,040
我们正在使用梯度下降进行优化。
--So all that really we need to do differently is be able to compute the gradient of this 00:02:15,040 --> 00:02:19,840
所以我们真正需要做的不同的是能够计算这个的梯度
--more powerful hypothesis class. 00:02:19,840 --> 00:02:22,520
更强大的假设类。
--We'll get to all of that in a moment. 00:02:23,520 --> 00:02:25,200
我们稍后会谈到所有这些。
--Let me jump in by first talking about nonlinear hypothesis classes, kind of in the abstract 00:02:25,200 --> 00:02:30,600
让我先谈谈非线性假设类，有点抽象
--here. 00:02:30,600 --> 00:02:32,480
这里。
--And to motivate this switch to nonlinear hypotheses, we're going to recall our basic linear hypothesis 00:02:32,480 --> 00:02:41,680
为了促使这种转向非线性假设，我们将回顾我们的基本线性假设
--class that we started with last time. 00:02:41,680 --> 00:02:43,040
我们上次开始的课程。
--So remember last lecture, we said our hypothesis class, the predictions we make on X, is some 00:02:43,040 --> 00:02:49,920
所以记得上一课，我们说过我们的假设类，我们对 X 做出的预测，是一些
--linear function, some matrix theta, transposed times our input X, where theta here is a matrix 00:02:49,920 --> 00:02:56,560
线性函数，一些矩阵 theta，转置乘以我们的输入 X，这里的 theta 是一个矩阵
--that is N by K. 00:02:56,560 --> 00:02:58,800
即 N 乘以 K。
--So we're mapping from N-dimensional inputs to K-dimensional outputs, which are what we 00:02:58,800 --> 00:03:03,440
所以我们从 N 维输入映射到 K 维输出，这就是我们
--call the logits of the different classes here, the K different classes. 00:03:03,440 --> 00:03:09,240
在这里调用不同类别的logits，K个不同的类别。
--Now what this function does, as we described last time, is it basically forms K different 00:03:09,240 --> 00:03:13,760
现在这个函数的作用，正如我们上次描述的，它基本上形成了 K 个不同的
--linear functions of the input, and then predicts the class as whichever has the highest value, 00:03:13,920 --> 00:03:22,160
输入的线性函数，然后将类别预测为具有最高值的类别，
--whichever of those K different functions has the highest value. 00:03:22,160 --> 00:03:25,600
这 K 个不同函数中的那个具有最高值。
--And the picture you should have in mind for this is what this really does is it kind of 00:03:25,600 --> 00:03:28,680
你应该记住的是这真的是什么
--chops up space into K different linear regions. 00:03:28,680 --> 00:03:32,320
将空间分割成 K 个不同的线性区域。
--So really what's happening here is if we have these points on the right here, what we're 00:03:32,320 --> 00:03:36,480
所以这里真正发生的事情是，如果我们在右边有这些点，我们就是
--doing with these hypothesis classes is we're having kind of one direction, which points 00:03:36,480 --> 00:03:39,720
处理这些假设类别是我们有一个方向，它指出
--sort of this way, one direction which maybe points this way, and one direction which points 00:03:39,720 --> 00:03:43,720
有点这样，一个方向可能指向这个方向，一个方向指向
--this way. 00:03:43,720 --> 00:03:44,720
这边走。
--And whichever direction is most heavily aligned with the input, that's the class we predict. 00:03:44,720 --> 00:03:51,200
无论哪个方向与输入最一致，这就是我们预测的类别。
--And so for two classes, this would just be a line that separates out the positive and 00:03:51,200 --> 00:03:54,800
所以对于两个类，这只是一条线，将积极的和
--negative examples. 00:03:54,800 --> 00:03:56,000
反面例子。
--But for more classes, this would be still just sort of linear directions that we predict 00:03:56,000 --> 00:04:01,000
但是对于更多的类，这仍然只是我们预测的线性方向
--based upon which of these three directions basically is more closely aligned with our 00:04:01,000 --> 00:04:05,520
基于这三个方向中的哪一个基本上更符合我们的要求
--class. 00:04:05,520 --> 00:04:07,040
班级。
--Now, the problem, of course, is that this is a very limited hypothesis class. 00:04:07,080 --> 00:04:10,920
现在，问题当然是这是一个非常有限的假设类别。
--And there are many sorts of data you could imagine that don't really fit this mold, right? 00:04:10,920 --> 00:04:16,320
您可以想象有很多种数据并不真正适合这种模式，对吗？
--So consider instead of our previous example, where we had our data basically clustered 00:04:16,320 --> 00:04:20,400
因此，请考虑我们之前的示例，我们的数据基本上是集群的
--into these three clusters here, consider a setting like this, where we have a different 00:04:20,400 --> 00:04:26,400
进入这三个集群，考虑这样的设置，我们有一个不同的
--form of data. 00:04:26,400 --> 00:04:28,160
数据形式。
--And now it turns out, so all our green examples here are in this, the blue examples are kind 00:04:28,160 --> 00:04:33,640
现在事实证明，所以我们这里所有的绿色例子都在里面，蓝色的例子很好
--of in this band here, and then the orange examples are in a band surrounding that circle 00:04:33,640 --> 00:04:38,280
在这里的这个带中，然后橙色的例子在那个圆圈周围的带中
--surrounding that. 00:04:38,280 --> 00:04:39,280
围绕那个。
--Now, it shouldn't be very hard to convince yourself that there's no linear classifier 00:04:39,280 --> 00:04:46,080
现在，不难说服自己没有线性分类器
--that could actually correctly classify all these three sets of examples here, right? 00:04:46,080 --> 00:04:52,560
这实际上可以正确地对所有这三组示例进行分类，对吗？
--You can't form three different directions, where the closest direction always predicts 00:04:52,560 --> 00:04:56,520
你不能形成三个不同的方向，其中最近的方向总是预测
--one class, right? 00:04:56,520 --> 00:04:57,520
一个班，对吧？
--It's just not possible. 00:04:57,520 --> 00:05:00,520
这是不可能的。
--But nonetheless, we would like ways of separating out regions like this or points like this. 00:05:00,520 --> 00:05:05,600
但是尽管如此，我们还是希望有办法像这样分离出这样的区域或像这样的点。
--And of course, this is relatively low dimensional space. 00:05:05,600 --> 00:05:08,680
当然，这是相对低维的空间。
--But in higher dimensional spaces, we still believe that our actual classes that we're 00:05:08,680 --> 00:05:13,040
但在更高维度的空间中，我们仍然相信我们的实际类别
--trying to separate here are going to be separated via nonlinear relationships. 00:05:13,040 --> 00:05:18,560
试图在这里分离将通过非线性关系分离。
--And therefore, we would like ways of separating out data that doesn't rely, that goes beyond 00:05:18,560 --> 00:05:23,880
因此，我们想要分离出不依赖、超出范围的数据的方法
--just linear hypothesis classes. 00:05:23,880 --> 00:05:28,080
只是线性假设类。
--So the kind of initial and very natural extension of a linear hypothesis class, and I should 00:05:28,080 --> 00:05:35,400
所以线性假设类的初始和非常自然的扩展，我应该
--really emphasize this is in some sense what, how machine learning was done for many, many 00:05:35,400 --> 00:05:40,560
真正强调这在某种意义上是什么，机器学习是如何为很多很多人完成的
--years, is that we no longer, we form a function where we no longer have just a linear function 00:05:40,560 --> 00:05:47,320
年，是我们不再，我们形成一个函数，我们不再只是一个线性函数
--of the inputs, but we actually have a linear function of this function phi of the inputs. 00:05:47,320 --> 00:05:55,760
输入的，但实际上我们有一个输入函数 phi 的线性函数。
--And phi here is a function mapping from Rn to Rd. 00:05:55,760 --> 00:06:00,640
而这里的 phi 是一个从 Rn 到 Rd 的函数映射。
--Remember, Rn is our input space. 00:06:00,640 --> 00:06:03,160
请记住，Rn 是我们的输入空间。
--And Rd is some other dimensional space here, I'm just using a d as another, can be any 00:06:03,160 --> 00:06:07,920
 Rd 在这里是其他维度空间，我只是将 ad 用作另一个维度空间，可以是任何
--number of, can be any integer here, any positive integer, where d, this function phi is known 00:06:07,920 --> 00:06:16,520
number of，这里可以是任意整数，任意正整数，其中d，这个函数phi是已知的
--as a feature mapping. 00:06:16,520 --> 00:06:18,440
作为特征映射。
--It basically is just some function that takes our inputs and maps them to some higher dimensional 00:06:18,440 --> 00:06:25,200
它基本上只是一些接受我们的输入并将它们映射到更高维度的函数
--or lower dimensional, just some different representation, d dimensional representation 00:06:25,320 --> 00:06:29,320
或更低维，只是一些不同的表示，d维表示
--of that space. 00:06:29,320 --> 00:06:31,960
那个空间。
--And this is what's known as a feature mapping, or phi of x is sometimes known as the features 00:06:31,960 --> 00:06:36,880
这就是所谓的特征映射，或者 x 的 phi 有时被称为特征
--of the data. 00:06:36,880 --> 00:06:38,320
的数据。
--And then our final hypothesis is just going to be a linear function of those features. 00:06:38,320 --> 00:06:44,000
然后我们的最终假设将只是这些特征的线性函数。
--And of course, the only difference between this and our original function is that now 00:06:44,000 --> 00:06:47,480
当然，这个函数和我们原来的函数唯一的区别是现在
--theta would be d by k, because we have a d dimensional feature vector that we're trying 00:06:47,480 --> 00:06:51,840
theta 将是 k 的 d，因为我们有我们正在尝试的广告维度特征向量
--to map to our k outputs, to our k different output classes. 00:06:51,840 --> 00:06:57,760
映射到我们的 k 个输出，映射到我们的 k 个不同的输出类。
--It's not an exaggeration to say that this really is how the majority of machine learning 00:06:57,760 --> 00:07:02,720
毫不夸张地说，这确实是大多数机器学习的方式
--was done for a long time, at least, again, in practice or when it was practically described. 00:07:02,720 --> 00:07:08,640
至少在实践中或在实际描述时再次完成了很长时间。
--Because and I should also emphasize that a lot of machine learning is still done this 00:07:08,640 --> 00:07:12,120
因为而且我还应该强调，很多机器学习仍然是这样做的
--way, where what we do to run machine learning algorithms is we construct some sort of function 00:07:12,120 --> 00:07:19,160
方式，我们运行机器学习算法的地方是我们构造某种函数
--of our inputs, right? 00:07:19,160 --> 00:07:20,280
我们的投入，对吗？
--Where phi here can be really any sort of feature mapping that in some sense describes our inputs 00:07:20,280 --> 00:07:27,120
这里的 phi 实际上可以是某种意义上描述我们输入的任何类型的特征映射
--in a way that we believe to be more amenable to linear classification. 00:07:27,120 --> 00:07:32,800
以我们认为更适合线性分类的方式。
--And that's really the key point here. 00:07:32,800 --> 00:07:34,840
这才是真正的关键点。
--We won't dive into sort of precise natures of what these functions can be when we do 00:07:34,840 --> 00:07:39,000
当我们这样做时，我们不会深入探讨这些功能的确切性质
--them by hand. 00:07:39,000 --> 00:07:40,000
他们用手。
--We'll give a few examples, but and then we'll, the majority will cover a much more generic 00:07:40,000 --> 00:07:44,640
我们会举几个例子，但是然后我们会，大多数人会涵盖一个更通用的
--formulation. 00:07:44,640 --> 00:07:46,320
公式。
--But this notion of taking our raw data, our raw X, and manually extracting some set of 00:07:46,320 --> 00:07:53,920
但是这种获取我们的原始数据，我们的原始 X，并手动提取一些数据集的概念
--features from it, which we then feed into a linear machine learning classifier is actually 00:07:53,920 --> 00:08:00,040
它的特征，然后我们将其输入线性机器学习分类器实际上是
--a very powerful paradigm. 00:08:00,040 --> 00:08:02,360
一个非常强大的范例。
--And when you know how to extract valuable features of your data, it's still a very useful 00:08:02,360 --> 00:08:08,000
当您知道如何从数据中提取有价值的特征时，它仍然非常有用
--way of doing a lot of machine learning in practice. 00:08:08,000 --> 00:08:11,940
在实践中进行大量机器学习的方法。
--So we're not really going to focus on this approach, or rather, we're going to focus 00:08:11,940 --> 00:08:14,800
所以我们不会真正专注于这种方法，或者更确切地说，我们将专注于
--on, I guess you could say we're going to focus on using neural networks to extract 00:08:14,800 --> 00:08:19,640
关于，我想你可以说我们将专注于使用神经网络来提取
--these features. 00:08:19,640 --> 00:08:20,640
这些功能。
--But that's a very sort of different notion in some sense than doing it in a manual way. 00:08:20,640 --> 00:08:24,760
但在某种意义上，这与手动方式完全不同。
--But I should emphasize that the sort of manual feature engineering still plays a very large 00:08:24,760 --> 00:08:29,600
但我要强调的是，这种手动特征工程仍然发挥着很大的作用
--role in a lot of machine learning. 00:08:29,600 --> 00:08:33,200
在很多机器学习中发挥作用。
--But let's think a little bit more deeply now about what we could choose for this feature 00:08:33,200 --> 00:08:38,880
但是现在让我们更深入地考虑一下我们可以为此功能选择什么
--mapping. 00:08:38,880 --> 00:08:41,120
映射。
--Because while it's all well and good to say, okay, we just manually come up with these 00:08:41,120 --> 00:08:45,920
因为虽然一切都很好，但好吧，我们只是手动想出这些
--things. 00:08:45,920 --> 00:08:46,920
事物。
--I mean, maybe in this example here, you would take, say, suppose this is the origin here, 00:08:46,920 --> 00:08:50,400
我的意思是，也许在这个例子中，你会假设这里是原点，
--then maybe a good feature vector for this case would be something like the X squared 00:08:50,400 --> 00:08:55,960
那么对于这种情况，一个好的特征向量可能类似于 X 平方
--plus Y squared, right? 00:08:55,960 --> 00:08:57,640
加上 Y 平方，对吗？
--X1 squared, sorry, not X1 plus Y1, X1 squared plus X2 squared, right? 00:08:57,640 --> 00:09:03,400
 X1 平方，抱歉，不是 X1 加 Y1，X1 平方加 X2 平方，对吧？
--That would be a good feature mapping that would in some sense, that value actually does 00:09:03,400 --> 00:09:08,400
这将是一个很好的特征映射，在某种意义上，该值实际上确实如此
--let us separate these classes out with a linear classifier. 00:09:08,400 --> 00:09:11,680
让我们用线性分类器将这些类别分开。
--So maybe we would choose this V of X, this thing. 00:09:11,680 --> 00:09:15,960
所以也许我们会选择这个 V of X，这个东西。
--But we want to move beyond kind of these very specific cases that we use for particular 00:09:15,960 --> 00:09:21,600
但是我们想要超越我们用于特定的这些非常具体的案例
--settings to think about more generic forms of features. 00:09:21,600 --> 00:09:25,040
设置以考虑更通用的功能形式。
--How could we form in some sense, a generic set of features that we can apply kind of 00:09:25,040 --> 00:09:29,840
在某种意义上，我们如何形成一组通用的特征，我们可以应用这些特征
--to any problem? 00:09:29,840 --> 00:09:32,880
有什么问题吗？
--And as I said, the first way we can create this function is just through manual engineering, 00:09:32,880 --> 00:09:37,360
正如我所说，我们创建此功能的第一种方法是通过手动工程，
--right? 00:09:37,360 --> 00:09:38,360
正确的？
--That is in some sense, the old way of doing machine learning. 00:09:38,360 --> 00:09:40,680
从某种意义上说，这是进行机器学习的旧方法。
--This was the approach that people followed for a very long time. 00:09:40,680 --> 00:09:44,560
这是人们长期遵循的方法。
--However, what we would like to have in some sense, or move towards at least, is a way 00:09:44,560 --> 00:09:52,060
然而，从某种意义上说，我们想要的，或者至少是朝着这样的方向发展，是一种方式
--to also learn these features from data. 00:09:52,060 --> 00:09:58,160
也可以从数据中学习这些特征。
--And that actually is one way of motivating the entire notion of neural networks. 00:09:58,160 --> 00:10:03,160
这实际上是激发整个神经网络概念的一种方式。
--Neural networks are a way, in some sense, of extracting good features from input data, 00:10:03,160 --> 00:10:11,400
在某种意义上，神经网络是一种从输入数据中提取好的特征的方法，
--but doing it in a way that is automated, where we don't have to hand-tune them ourselves. 00:10:11,400 --> 00:10:16,640
但以一种自动化的方式进行，我们不必自己手动调整它们。
--And I'm calling this kind of the old and new way of doing machine learning. 00:10:16,640 --> 00:10:19,720
我将这种新旧的机器学习方式称为机器学习。
--That's a bit tongue-in-cheek. 00:10:19,720 --> 00:10:21,040
这有点开玩笑。
--The reality is these are both very powerful techniques here. 00:10:21,040 --> 00:10:24,160
事实上，这些都是非常强大的技术。
--But this course really, for the most part, is going to focus on thinking about if we 00:10:24,160 --> 00:10:29,840
但是这门课程实际上，在大多数情况下，将专注于思考我们是否
--can learn this feature extractor, in some sense, a way of finding good features directly 00:10:29,840 --> 00:10:36,800
可以学习这个特征提取器，在某种意义上，一种直接找到好的特征的方法
--from the data. 00:10:36,800 --> 00:10:38,760
从数据。
--So as a first take on this, you know, linear functions for predictions were so powerful. 00:10:38,760 --> 00:10:46,040
因此，作为第一个尝试，您知道，用于预测的线性函数非常强大。
--I mean, we were able to get 8% error on the MNIST digit classification problem using just 00:10:46,040 --> 00:10:51,900
我的意思是，我们能够在 MNIST 数字分类问题上仅使用 8% 的错误率
--a linear classifier. 00:10:51,900 --> 00:10:54,200
线性分类器。
--Maybe as kind of a first guess, you know, we have a function that needs to map from 00:10:54,200 --> 00:10:58,360
也许作为第一个猜测，你知道，我们有一个函数需要从
--Rn to Rd. 00:10:58,360 --> 00:11:00,640
Rn 到 Rd。
--Maybe we just try another linear function here, right? 00:11:00,640 --> 00:11:02,640
也许我们只是在这里尝试另一个线性函数，对吗？
--So we just try another function, B, is equal to some matrix W transpose times x, where 00:11:02,640 --> 00:11:11,400
所以我们只是尝试另一个函数 B，它等于某个矩阵 W 的转置乘以 x，其中
--here W, in order for this to work, W would need to be a vector which was an n by d-dimensional 00:11:11,400 --> 00:11:18,880
这里 W，为了让它起作用，W 需要是一个向量，它是 n x d 维
--matrix with the size of W, right? 00:11:18,880 --> 00:11:21,760
大小为 W 的矩阵，对吗？
--So that W transpose times x gave you a d-dimensional vector. 00:11:21,760 --> 00:11:26,680
所以 W 转置 x 给你一个 d 维向量。
--However, probably, hopefully, apparently to everyone, this doesn't, of course, actually 00:11:26,760 --> 00:11:31,760
然而，可能，希望，显然对每个人来说，这当然不是，实际上
--work because if you use this definition of a feature along with a linear classifier appended 00:11:31,760 --> 00:11:39,840
之所以有效，是因为如果您使用此特征定义以及附加的线性分类器
--to this or after this feature extractor, something very sort of unfortunate happens, which is 00:11:39,840 --> 00:11:45,200
在此或此特征提取器之后，发生了一些非常不幸的事情，即
--the following. 00:11:45,200 --> 00:11:46,200
下列。
--So let's think about our new hypothesis class, which is the theta transpose phi of x with 00:11:46,200 --> 00:11:50,840
所以让我们考虑一下我们的新假设类，它是 x 的 theta 转置 phi
--this choice of phi of x. 00:11:50,840 --> 00:11:51,960
 x 的 phi 选择。
--So that would be equal to theta transpose W transpose x. 00:11:52,280 --> 00:11:59,960
所以这将等于 theta 转置 W 转置 x。
--But the whole point here is that theta transpose times W transpose is just some other matrix, 00:11:59,960 --> 00:12:06,920
但这里的重点是 theta 转置乘以 W 转置只是其他矩阵，
--right? 00:12:06,920 --> 00:12:07,920
正确的？
--That's just an n by k, with the transposes, it would be a k by n dimensional matrix, i.e. 00:12:07,920 --> 00:12:18,960
这只是一个 n 乘 k，通过转置，它将是 ak 乘 n 维矩阵，即
--All we're doing here is we're just applying some other linear classifier. 00:12:18,960 --> 00:12:23,840
我们在这里所做的只是应用一些其他线性分类器。
--In other words, we haven't actually expanded the set of hypotheses that we're considering 00:12:23,840 --> 00:12:29,080
换句话说，我们实际上并没有扩展我们正在考虑的假设集
--with this particular choice of feature. 00:12:29,080 --> 00:12:31,560
有了这个特殊的功能选择。
--So this doesn't actually work. 00:12:31,560 --> 00:12:33,080
所以这实际上行不通。
--Fortunately, though, something very, very similar does work, which is the following. 00:12:33,080 --> 00:12:38,920
不过，幸运的是，一些非常非常相似的东西确实有效，如下所示。
--We can define our feature, our feature mapping, to be basically the same thing, some linear 00:12:38,920 --> 00:12:45,640
我们可以定义我们的特征，我们的特征映射，基本上是一样的，一些线性的
--function applied to our input, but then followed by some nonlinear function, sigma, applied 00:12:45,640 --> 00:12:53,920
函数应用于我们的输入，但随后是一些非线性函数，西格玛，应用
--to this new feature vector. 00:12:53,920 --> 00:12:59,040
到这个新的特征向量。
--So here, W would, like in the previous example, be n by d. 00:12:59,040 --> 00:13:04,200
所以在这里，就像前面的例子一样，W 是 n 乘以 d。
--And sigma here, which I'm writing as rd to the rd, is really just any function we apply. 00:13:04,200 --> 00:13:12,560
这里的 sigma，我写为 rd 到 rd，实际上只是我们应用的任何函数。
--And usually we apply it element-wise to this feature vector, or to this vector W transpose 00:13:12,560 --> 00:13:20,440
通常我们将它按元素应用到这个特征向量，或者这个向量 W 转置
--x. 00:13:20,440 --> 00:13:21,440
X。
--But it really doesn't have to be element-wise, it could be sort of any sort of thing. 00:13:21,440 --> 00:13:27,120
但它真的不必是元素方面的，它可以是任何类型的东西。
--And the interesting thing here is that when we essentially apply almost any nonlinear 00:13:27,120 --> 00:13:33,880
有趣的是，当我们基本上应用几乎所有非线性
--function as our choice of sigma, we basically allow ourselves to get much richer representations 00:13:33,880 --> 00:13:42,400
作为我们对 sigma 的选择，我们基本上允许自己获得更丰富的表示
--than we can with this linear classifier. 00:13:42,400 --> 00:13:44,960
比我们用这个线性分类器能做的还要多。
--So this problem I mentioned in the last slide, this fact that we sort of, everything reduces 00:13:44,960 --> 00:13:48,680
所以我在上一张幻灯片中提到的这个问题，这个事实，我们有点，一切都减少了
--to just a linear classifier, that of course goes away if we have some feature vector there, 00:13:48,680 --> 00:13:54,160
只是一个线性分类器，如果我们在那里有一些特征向量，那当然会消失，
--right? 00:13:54,160 --> 00:13:55,160
正确的？
--Because, or sorry, some nonlinear function there. 00:13:55,160 --> 00:13:58,040
因为，或者抱歉，那里有一些非线性函数。
--Because of course, if we have this setup, then h theta of x is now equal to theta transpose 00:13:58,040 --> 00:14:08,080
因为当然，如果我们有这个设置，那么 x 的 h theta 现在等于 theta 转置
--times sigma W transpose x. 00:14:08,080 --> 00:14:12,120
乘以 sigma W 转置 x。
--And we cannot reduce that, this does not equal some linear, alternative linear function of 00:14:12,120 --> 00:14:18,280
我们不能减少，这不等于一些线性的，替代线性函数
--x. 00:14:18,280 --> 00:14:19,280
X。
--And in fact, for almost, as I said, for almost any choice of nonlinear function other than 00:14:19,280 --> 00:14:24,280
事实上，正如我所说，对于几乎所有的非线性函数选择，除了
--really trivial ones, this actually does give us a much more powerful feature vector. 00:14:24,280 --> 00:14:33,320
非常微不足道的，这实际上确实给了我们一个更强大的特征向量。
--And there are in fact a lot of very simple things you can do here, which nonetheless 00:14:33,320 --> 00:14:37,280
事实上，您可以在这里做很多非常简单的事情，尽管如此
--result in very, very powerful types of features that describe inputs. 00:14:37,280 --> 00:14:44,360
导致描述输入的非常非常强大的特征类型。
--So for example, if we let W actually be a fixed, just randomly sample entries from a 00:14:44,360 --> 00:14:51,280
因此，例如，如果我们让 W 实际上是一个固定值，则只需从 a 中随机抽取条目
--Gaussian to create W, you might have scaled them to be so that the output's in the right 00:14:51,280 --> 00:14:58,120
Gaussian 来创建 W，您可能已经将它们缩放为使输出在正确的位置
--space here, but actually that's not that important an issue there. 00:14:58,120 --> 00:15:01,720
这里的空间，但实际上这并不是那么重要的问题。
--So just let W be essentially a fixed matrix of random samples from a Gaussian, just a 00:15:01,720 --> 00:15:06,520
所以让 W 本质上是一个固定的高斯随机样本矩阵，只是一个
--random matrix. 00:15:06,760 --> 00:15:08,760
随机矩阵。
--And let sigma be the cosine function. 00:15:08,760 --> 00:15:12,920
并让 sigma 为余弦函数。
--This winds up being a type of feature vector called random Fourier features, and this approach 00:15:12,920 --> 00:15:25,440
这最终成为一种称为随机傅里叶特征的特征向量，这种方法
--works great for many problems using these random Fourier features. 00:15:25,440 --> 00:15:30,400
使用这些随机傅立叶特征可以很好地解决许多问题。
--But having said that, we don't want to always limit ourselves to kind of picking this. 00:15:30,400 --> 00:15:37,160
但话虽如此，我们不想总是局限于选择这个。
--This is still a way of picking phi in advance, right? 00:15:37,160 --> 00:15:42,600
这还是提前挑选phi的一种方式吧？
--We specify some mapping, and then all we learn in our algorithm, in our learning algorithm, 00:15:42,600 --> 00:15:48,080
我们指定一些映射，然后我们在我们的算法中学习的所有内容，在我们的学习算法中，
--the only parameters of our learning algorithm, would still be theta. 00:15:48,080 --> 00:15:52,440
我们学习算法的唯一参数，仍然是 theta。
--That would be still our parameters there, because W here is considered fixed. 00:15:52,440 --> 00:15:59,720
那仍然是我们的参数，因为这里的 W 被认为是固定的。
--But this comes to a natural question. 00:15:59,720 --> 00:16:01,920
但这是一个很自然的问题。
--If we have a setting like this, if we have a hypothesis like this, maybe we want to also 00:16:01,920 --> 00:16:06,560
如果我们有这样的设置，如果我们有这样的假设，也许我们也想
--optimize W, right? 00:16:06,560 --> 00:16:09,040
优化W吧？
--Maybe by, in some sense, training W or optimizing W to also decrease our loss, we could do better 00:16:09,040 --> 00:16:18,840
也许在某种意义上，通过训练 W 或优化 W 来减少我们的损失，我们可以做得更好
--than if we just treat it as some fixed matrix or treating phi essentially as a fixed feature 00:16:18,840 --> 00:16:24,840
而不是我们只是将其视为某个固定矩阵或将 phi 本质上视为一个固定特征
--extractor. 00:16:24,840 --> 00:16:26,720
提取器。
--And this is exactly what neural networks are going to do. 00:16:26,720 --> 00:16:31,000
而这正是神经网络要做的。
--Neural networks effectively, in this interpretation, can be viewed as a way of extracting features 00:16:31,000 --> 00:16:36,120
在这种解释中，神经网络可以有效地被视为一种提取特征的方法
--of our data in a manner where we train simultaneously both the final linear classifier, both this 00:16:36,120 --> 00:16:44,720
我们的数据以一种我们同时训练最终线性分类器的方式，这两个
--theta here, as well as all the parameters of the feature vector itself, the feature 00:16:44,720 --> 00:16:51,480
这里的theta，以及特征向量本身的所有参数，特征
--extractor itself, i.e., in this case, W, but in later cases, potentially much more 00:16:51,480 --> 00:16:57,440
提取器本身，即，在这种情况下，W，但在以后的情况下，可能更多
--complex sets of parameters. 00:16:57,440 --> 00:17:00,800
复杂的参数集。
--So this leads us, then, to this notion of neural networks. 00:17:00,800 --> 00:17:05,560
因此，这将我们引向神经网络的概念。
--Because in fact, in the last case, if you treat a network like this, if you consider 00:17:05,560 --> 00:17:15,400
因为实际上在最后一种情况下，如果你这样对待一个网络，如果你考虑
--a network like this, or a hypothesis class like this, where both theta and W are the 00:17:15,400 --> 00:17:22,160
像这样的网络，或像这样的假设类，其中 theta 和 W 都是
--parameters of your network, this winds up being kind of the simplest case of what we 00:17:22,160 --> 00:17:27,280
您的网络参数，这最终成为我们最简单的情况
--call a two-layer neural network. 00:17:27,280 --> 00:17:30,440
调用一个双层神经网络。
--So let's talk about neural networks, then. 00:17:30,440 --> 00:17:33,320
那么让我们来谈谈神经网络吧。
--Now in the general term, this term, the term neural network is a great term, right? 00:17:33,320 --> 00:17:38,480
现在在一般术语中，这个术语，术语神经网络是一个伟大的术语，对吧？
--It evokes these, I always say that machine learning is very good at advertising and coming 00:17:38,480 --> 00:17:43,920
它唤起了这些，我总是说机器学习非常擅长广告和到来
--up with clever names for our algorithms, not just neural networks, but also things 00:17:43,920 --> 00:17:47,360
为我们的算法起个聪明的名字，不仅是神经网络，还有其他东西
--like gradient boosting, I guess that came from stats, but support vector machine, right? 00:17:47,360 --> 00:17:52,080
像梯度提升，我猜那是来自统计数据，但支持向量机，对吧？
--These are great, great names. 00:17:52,080 --> 00:17:53,880
这些都是伟大的，伟大的名字。
--They just sound so cool. 00:17:53,880 --> 00:17:55,760
他们听起来很酷。
--And neural network is no exception. 00:17:55,760 --> 00:17:57,600
神经网络也不例外。
--I think the first time I heard about neural networks, it was probably from like Star Trek 00:17:57,600 --> 00:18:01,240
我想我第一次听说神经网络，可能是从《星际迷航》之类的
--or something like that, right? 00:18:01,240 --> 00:18:02,240
或者类似的东西，对吧？
--Where one of the data, the robot, right, or the Android had like a neural network for 00:18:02,240 --> 00:18:07,720
其中一个数据，机器人，对，或者 Android 就像一个神经网络
--his programming. 00:18:07,720 --> 00:18:09,280
他的编程。
--And it's a great, great name. 00:18:09,280 --> 00:18:10,720
这是一个伟大的名字。
--It evokes this notion of the brain, all those kind of things. 00:18:10,720 --> 00:18:14,000
它唤起了大脑的概念，所有这些东西。
--But what really is a neural network? 00:18:14,000 --> 00:18:16,000
但真正的神经网络是什么？
--Well, it's just to sort of preview what I'm going to say in a second. 00:18:16,000 --> 00:18:19,720
好吧，这只是为了预习一下我要说的内容。
--It's not related to the brain or things like this, at least in its current form, there's 00:18:19,720 --> 00:18:24,520
它与大脑或类似的东西无关，至少在目前的形式下，有
--a very, very, there's very, very tenuous connections here. 00:18:24,520 --> 00:18:29,080
这里有非常非常脆弱的联系。
--Instead, what a neural network refers to is a particular type of hypothesis class that 00:18:29,080 --> 00:18:35,440
相反，神经网络指的是一种特定类型的假设类
--we use in machine learning, right? 00:18:35,440 --> 00:18:37,120
我们在机器学习中使用，对吗？
--So that's what a neural network is. 00:18:37,120 --> 00:18:38,120
这就是神经网络。
--It is a particular form of hypothesis class. 00:18:38,520 --> 00:18:41,680
它是假设类的一种特殊形式。
--And not one that's categorized by learning like the brain or simulating the brain or 00:18:41,680 --> 00:18:46,800
而不是像大脑一样学习或模拟大脑或
--like that. 00:18:46,800 --> 00:18:47,960
像那样。
--It's characterized by having multiple parametrized differentiable functions, which we call layers, 00:18:47,960 --> 00:18:56,640
它的特点是具有多个参数化的可微函数，我们称之为层，
--that are composed together to map from inputs to outputs. 00:18:56,640 --> 00:19:02,640
它们组合在一起以从输入映射到输出。
--That is what a neural network is. 00:19:03,520 --> 00:19:10,240
这就是神经网络。
--Now this term, as I said, does stem from biological inspiration. 00:19:10,240 --> 00:19:16,040
现在，正如我所说，这个术语确实源于生物学灵感。
--But at this point, really any type of function like the above is referred to as a neural 00:19:16,040 --> 00:19:21,800
但在这一点上，实际上像上面这样的任何类型的函数都被称为神经网络
--network. 00:19:21,800 --> 00:19:23,800
网络。
--And I actually don't want to, I don't want to dismiss the biological inspiration because 00:19:23,800 --> 00:19:30,640
我实际上不想，我不想忽视生物学的灵感，因为
--it is definitely the case that a lot of the development of neural networks did come from 00:19:30,720 --> 00:19:36,920
神经网络的很多发展确实来自
--thinking about analogs in biological processes. 00:19:36,920 --> 00:19:41,320
思考生物过程中的类似物。
--And really a lot of the innovations in neural networks, very much so, came from thinking 00:19:41,320 --> 00:19:46,640
神经网络中的很多创新，在很大程度上，都来自于思考
--about how the brain might work, right? 00:19:46,640 --> 00:19:48,680
关于大脑如何工作，对吧？
--The brain is, is in fact one example where we have kind of an existence proof of, of 00:19:48,680 --> 00:19:54,200
大脑实际上是一个例子，我们有一种存在证明，
--an intelligent system. 00:19:54,200 --> 00:19:57,520
一个智能系统。
--But I also need to emphasize that at this point in sort of practical engineering, there 00:19:57,520 --> 00:20:02,520
但我还需要强调，在这一点上，在实际工程中，有
--is not much connection between the actual sorts of networks we really develop and use 00:20:02,520 --> 00:20:07,160
我们真正开发和使用的实际网络类型之间并没有太多联系
--in practice and what we know about the brain so far. 00:20:07,160 --> 00:20:09,760
在实践中以及我们目前对大脑的了解。
--So this, this connection is, is very tenuous at best, and I don't want to emphasize this 00:20:09,760 --> 00:20:15,120
所以这个，这个联系充其量是非常脆弱的，我不想强调这个
--connection. 00:20:15,120 --> 00:20:16,120
联系。
--I really want to emphasize the composed differentiable functions point of view of a neural network 00:20:16,120 --> 00:20:22,040
我真的很想强调神经网络的组合可微函数的观点
--because that is what a neural network is from an engineering standpoint. 00:20:22,240 --> 00:20:27,760
因为从工程的角度来看，这就是神经网络。
--Now the term deep network, that is just a synonym for neural network. 00:20:27,760 --> 00:20:33,360
现在术语深度网络，那只是神经网络的同义词。
--And the term deep learning, so it's deep network, really means the exact same thing as neural 00:20:33,360 --> 00:20:39,720
深度学习这个术语，所以它是深度网络，与神经网络的含义完全相同
--network. 00:20:39,720 --> 00:20:41,240
网络。
--And deep learning really just means machine learning using neural network hypothesis classes. 00:20:41,240 --> 00:20:50,160
深度学习实际上只是意味着使用神经网络假设类进行机器学习。
--So this is now maybe somewhat opinionated, but I think we need to cease with pretending 00:20:50,160 --> 00:20:56,560
所以这现在可能有点自以为是，但我认为我们需要停止假装
--that there is some amount of depth required in neural networks in order for them to be 00:20:56,560 --> 00:21:01,760
神经网络需要一定的深度才能使它们成为
--called deep learning. 00:21:01,760 --> 00:21:03,760
称为深度学习。
--Plenty of people will refer to using two layer neural networks as a deep learning approach, 00:21:03,760 --> 00:21:10,160
很多人会提到使用两层神经网络作为深度学习方法，
--and I think it's fine. 00:21:10,160 --> 00:21:11,920
我认为这很好。
--I think that the big difference when it comes to learning is between single layer networks, 00:21:11,920 --> 00:21:16,880
我认为学习方面的最大区别在于单层网络之间，
--i.e. linear hypothesis classes, and anything beyond that. 00:21:16,880 --> 00:21:21,920
即线性假设类，以及除此之外的任何东西。
--And so although this, there has been some debate about this term, I think it is perfectly 00:21:21,920 --> 00:21:26,800
因此，尽管如此，关于这个术语存在一些争论，但我认为它是完美的
--valid to refer to deep learning really as any machine learning that uses neural networks. 00:21:26,800 --> 00:21:34,120
将深度学习真正称为任何使用神经网络的机器学习是有效的。
--There actually is a debate about whether that could be more general than this. 00:21:34,120 --> 00:21:37,160
实际上有一个关于是否可以比这更普遍的争论。
--So in the original instantiation of deep learning, there was some sort of use of this term occasionally 00:21:37,160 --> 00:21:42,160
所以在深度学习的最初实例中，偶尔会以某种方式使用这个术语
--to talk about things like deep generative models, or maybe even things like multistep 00:21:42,160 --> 00:21:47,600
谈论诸如深度生成模型之类的事情，甚至可以谈论诸如多步之类的事情
--Bayesian networks. 00:21:47,600 --> 00:21:48,880
贝叶斯网络。
--But really at this point, again, the vast majority of the term deep learning refers 00:21:48,880 --> 00:21:54,200
但实际上，在这一点上，深度学习这个术语的绝大部分是指
--to using these multilayer neural networks as the hypothesis class for machine learning. 00:21:54,200 --> 00:22:02,920
使用这些多层神经网络作为机器学习的假设类。
--And this is actually not, and despite the fact that this may be a misnomer in some cases, 00:22:02,920 --> 00:22:06,920
这实际上不是，尽管在某些情况下这可能是用词不当，
--if you use a two layer network or something like this, the truth is that in a lot of applications, 00:22:07,480 --> 00:22:13,160
如果你使用双层网络或类似的东西，事实是在很多应用程序中，
--we actually do use networks and neural networks that are quite deep. 00:22:13,160 --> 00:22:17,760
我们实际上确实使用了非常深的网络和神经网络。
--And so deep is usually an appropriate qualifier. 00:22:17,760 --> 00:22:20,720
 so deep 通常是一个合适的限定词。
--But hopefully this sort of shed some light on how I use these terms here, and how I think 00:22:20,720 --> 00:22:25,080
但希望这能阐明我在这里如何使用这些术语，以及我的想法
--they're typically used in practice, even if some people would disagree and say, no, they 00:22:25,080 --> 00:22:29,520
他们通常在实践中使用，即使有些人不同意并说，不，他们
--have to be so many layers deep before it's really deep learning and things like this. 00:22:29,520 --> 00:22:33,120
在真正的深度学习之类的东西之前必须有这么多层的深度。
--I think there's no agreed upon standard there. 00:22:33,120 --> 00:22:35,360
我认为那里没有商定的标准。
--So I think we just call all neural networks at this point, deep learning, again, a really 00:22:35,360 --> 00:22:39,560
所以我想我们现在就把所有的神经网络都称为深度学习，再次，一个真正的
--great marketing term, right? 00:22:39,560 --> 00:22:41,560
很棒的营销术语，对吧？
--We're really good at these things in machine learning. 00:22:41,560 --> 00:22:44,000
我们非常擅长机器学习中的这些事情。
--All right, so this brings us to in fact, the exact hypothesis class that we started to 00:22:44,000 --> 00:22:50,720
好吧，所以这实际上把我们带到了我们开始的确切假设类
--introduce before, which was a two layer neural network. 00:22:50,720 --> 00:22:54,960
之前介绍过，这是一个二层神经网络。
--And what the two layer neural network is basically is, is essentially just exactly the set of 00:22:54,960 --> 00:23:01,960
两层神经网络基本上是，本质上就是一组
--nonlinear features we proposed earlier, right? 00:23:01,960 --> 00:23:04,360
我们之前提出的非线性特征，对吧？
--So if you look at this, the hypothesis we're defining here is some linear function of a 00:23:04,360 --> 00:23:09,960
所以如果你看这个，我们在这里定义的假设是一些线性函数
--nonlinear function applied to a linear transformation of the inputs. 00:23:09,960 --> 00:23:14,400
应用于输入的线性变换的非线性函数。
--And this would be exactly what we had before, if this thing here was just equal to our feature 00:23:14,400 --> 00:23:23,480
如果这里的这个东西正好等于我们的功能，这将是我们之前拥有的
--vector phi of x. 00:23:23,480 --> 00:23:28,600
x 的矢量 phi。
--Because it's more standard from now on, we're going to move to not having sort of an outer 00:23:28,600 --> 00:23:34,920
因为从现在开始它更标准了，我们将不再有某种外部
--linear parameter theta and inner linear parameter w. 00:23:34,920 --> 00:23:39,600
线性参数 theta 和内部线性参数 w。
--In fact, because theta typically refers to, in some sense, all the parameters of the network, 00:23:39,600 --> 00:23:45,600
事实上，因为 theta 在某种意义上通常指的是网络的所有参数，
--what we're going to do now is actually say that theta, the parameters, we still want 00:23:45,600 --> 00:23:49,680
我们现在要做的实际上是说 theta，参数，我们仍然想要
--to write things like this for the hypothesis, which is a function of our parameters of our 00:23:49,680 --> 00:23:53,320
为假设写这样的东西，这是我们的参数的函数
--input. 00:23:53,320 --> 00:23:54,320
输入。
--But the difference here is that theta now refers to the set of both our parameters, 00:23:54,880 --> 00:24:00,440
但这里的区别在于 theta 现在指的是我们两个参数的集合，
--namely w1 and w2. 00:24:00,440 --> 00:24:02,880
即w1和w2。
--So the notation is a bit different from what you saw last time. 00:24:02,880 --> 00:24:06,640
所以符号与你上次看到的有点不同。
--Because both w1 and w2 in this formulation are parameters, they are tunable parameters 00:24:06,640 --> 00:24:11,680
因为这个公式中的 w1 和 w2 都是参数，所以它们是可调参数
--that we're going to optimize in order to solve our machine learning problem. 00:24:11,680 --> 00:24:16,600
我们将对其进行优化以解决我们的机器学习问题。
--We think of both of them as being in our set of parameters, and we think of theta as just 00:24:16,600 --> 00:24:21,640
我们认为它们都在我们的参数集中，我们认为 theta 只是
--sort of the set of all our parameters here. 00:24:21,640 --> 00:24:26,240
这里是我们所有参数的集合。
--And again, as I said before, sigma here is really just some nonlinear function applied 00:24:26,240 --> 00:24:31,480
再一次，正如我之前所说，这里的 sigma 实际上只是应用了一些非线性函数
--element-wise to the vector. 00:24:31,480 --> 00:24:33,560
逐元素到向量。
--Sometimes people use sigma to specifically refer to one type of nonlinearity, which is 00:24:33,560 --> 00:24:37,320
有时人们用 sigma 来特指一类非线性，即
--the sigmoid nonlinearity, but really in this formulation it can mean anything. 00:24:37,320 --> 00:24:41,120
sigmoid 非线性，但实际上在这个公式中它可以意味着任何东西。
--So it can mean things like the ReLU, it can mean sigmoid, it can mean the sine function, 00:24:41,120 --> 00:24:44,800
所以它可以表示像 ReLU 这样的东西，它可以表示 sigmoid，它可以表示正弦函数，
--it can mean the tanh function, really anything is allowed here. 00:24:44,800 --> 00:24:48,280
它可能意味着 tanh 函数，实际上这里允许任何东西。
--I'm just using it to refer to some arbitrary nonlinear function, and in fact in this formulation 00:24:48,280 --> 00:24:54,080
我只是用它来指代一些任意的非线性函数，事实上在这个公式中
--I will even make the additional restriction that this function is applied element-wise 00:24:54,080 --> 00:24:59,200
我什至会额外限制这个函数是按元素应用的
--to the vector, to w1 transpose x. 00:24:59,200 --> 00:25:03,760
到向量，到 w1 转置 x。
--Now sometimes the way we write this is using figures like this one on the right here. 00:25:03,760 --> 00:25:08,680
现在有时我们写这篇文章的方式是使用像右边这个这样的数字。
--So we sort of think of this network as taking x and transforming it via w1, and of course 00:25:08,680 --> 00:25:16,320
所以我们可以把这个网络看作是获取 x 并通过 w1 转换它，当然
--also sigma, to some other set of features here, and then using w2 to transform this 00:25:16,520 --> 00:25:23,520
也是 sigma，到这里的其他一些特征集，然后使用 w2 来转换它
--into our output. 00:25:25,840 --> 00:25:28,240
进入我们的输出。
--And in fact, when we need to track these things more carefully, when we have many, many layers, 00:25:28,240 --> 00:25:32,440
事实上，当我们需要更仔细地跟踪这些东西时，当我们有很多很多层时，
--we will introduce terminology for the value of each of these sort of different features 00:25:32,440 --> 00:25:36,520
我们将介绍这些不同特征中每一种的价值的术语
--at different layers of the network. 00:25:36,520 --> 00:25:38,360
在网络的不同层。
--But here it's easy enough just to write this out explicitly, so we'll just write it like 00:25:38,360 --> 00:25:41,400
但是在这里很容易明确地写出来，所以我们就这样写
--this, we'll just write the whole function as h theta equals w2 transpose of sigma of 00:25:41,440 --> 00:25:48,440
这个，我们将把整个函数写成 h theta 等于 w2 sigma 的转置
--w1 transpose times x. 00:25:49,120 --> 00:25:51,840
w1 转置 x。
--And in fact, we're very quickly going to abandon this even and write this whole thing always 00:25:51,840 --> 00:25:55,520
事实上，我们很快就会放弃这个甚至写下这整件事
--in batch form, so we're actually going to write this as h theta applied to big X, remember 00:25:55,520 --> 00:26:00,320
以批处理的形式，所以我们实际上要把它写成应用于大 X 的 h theta，记住
--big X here would be an m by n dimensional matrix, where m is the number of examples 00:26:00,320 --> 00:26:07,320
这里的大 X 将是一个 m x n 维矩阵，其中 m 是示例数
--in our training set, or the batch size, maybe we use big B for that, but some collection 00:26:08,320 --> 00:26:13,400
在我们的训练集中，或者批量大小，也许我们为此使用 big B，但是一些集合
--of examples. 00:26:13,400 --> 00:26:15,320
的例子。
--And this notation would basically mean applying that to the, applying our network to every 00:26:15,320 --> 00:26:22,320
这个符号基本上意味着将其应用于，将我们的网络应用于每个
--element in our vector, in our matrix here, or every element in our data set. 00:26:22,840 --> 00:26:28,840
向量中的元素，此处矩阵中的元素，或数据集中的每个元素。
--Again remember the elements in our data set are the rows of this matrix X, so when you 00:26:28,840 --> 00:26:34,080
再次记住我们数据集中的元素是这个矩阵 X 的行，所以当你
--do this properly, you kind of no longer have the transposes to the w's, you have this form 00:26:34,080 --> 00:26:39,440
正确地做到这一点，你不再有 w 的转置，你有这种形式
--here on the right. 00:26:39,440 --> 00:26:41,320
在右边。
--And if that's confusing again, I would just suggest going back to the previous lecture 00:26:41,320 --> 00:26:43,920
如果这又令人困惑，我建议回到上一课
--where we covered this for the case of soft mass regression, it ends up staying exactly 00:26:43,920 --> 00:26:47,320
我们在软质量回归的情况下涵盖了这一点，它最终保持不变
--the same here, right? 00:26:47,320 --> 00:26:48,680
这里也一样吧？
--So essentially in this, in the dimensions here, let's just check everything makes sense, 00:26:48,680 --> 00:26:52,680
所以从本质上讲，在这里的维度中，让我们检查一下一切是否有意义，
--X would be m by n, w1 would be n by d, so this whole thing here, and actually I would 00:26:52,680 --> 00:26:59,680
 X 将是 m 乘以 n，w1 将是 n 乘以 d，所以这整件事在这里，实际上我会
--even say, well, let me move it over a bit, this whole thing here would be, and also sigma, 00:27:00,680 --> 00:27:07,680
甚至说，好吧，让我把它移过来一点，这里的整个事情都是，还有西格玛，
--because we just apply sigma element wise to the matrix, sigma of X1, w1 would be m by 00:27:09,960 --> 00:27:16,960
因为我们只是将 sigma 元素明智地应用于矩阵，X1、w1 的 sigma 将是 m
--d, and then w2 is d by k, so this whole term here, as desired, would be m by k. 00:27:17,400 --> 00:27:24,400
 d，然后 w2 是 d 乘以 k，所以这里的整个项，根据需要，将是 m 乘以 k。
--It would be the class logic prediction for each class, for each example in our data set. 00:27:25,400 --> 00:27:32,400
对于我们数据集中的每个示例，这将是每个类的类逻辑预测。
--All right, now before I dive into the kind of more complex forms of neural networks, 00:27:34,400 --> 00:27:41,400
好吧，在我深入研究更复杂形式的神经网络之前，
--and then finally backpropagation, how you compute gradients here, I want to take a brief 00:27:42,400 --> 00:27:49,400
最后是反向传播，这里是如何计算梯度的，我想简单介绍一下
--detour and talk about one property of neural networks, which we actually already know enough 00:27:50,400 --> 00:27:56,400
绕道而行，谈谈神经网络的一个特性，我们其实已经足够了解了
--to give a basic proof of. I'm actually going to only say this for the 1D case, for the 00:27:56,400 --> 00:28:01,400
给出一个基本的证明。实际上，我只会针对一维情况说这个，因为
--case of neural networks that take in scalar-valued inputs and produce scalar-valued outputs, 00:28:01,400 --> 00:28:06,400
接受标量值输入并产生标量值输出的神经网络的情况，
--but the general theorem is not that much more, that is for arbitrary dimensional inputs, 00:28:06,400 --> 00:28:10,400
但一般定理并没有那么多，即对于任意维度的输入，
--it's actually not that much more complicated. 00:28:10,400 --> 00:28:13,400
实际上并没有那么复杂。
--And the claim here is that a two-layer network, so that's the network of this form you saw 00:28:14,400 --> 00:28:20,400
而这里声明的是一个二层网络，所以就是你看到的这种形式的网络
--in the previous page here, so this form here, and actually even in a simpler form, which 00:28:20,400 --> 00:28:26,400
在上一页中，这里是这个表格，实际上是一个更简单的表格，
--I'll mention in a second, a two-layer network is what we call a universal function approximator. 00:28:26,400 --> 00:28:33,400
我稍后会提到，双层网络就是我们所说的通用函数逼近器。
--And what this means is a two-layer neural network is capable of representing arbitrarily 00:28:34,400 --> 00:28:41,400
这意味着一个双层神经网络能够任意表示
--well any function over some closed region. And it's actually important this is a closed 00:28:41,400 --> 00:28:48,400
以及一些封闭区域的任何功能。这实际上很重要，这是一个封闭的
--region, it is some finite state, finite set of the inputs, a finite subset of the input 00:28:48,400 --> 00:28:55,400
区域，它是一些有限状态，输入的有限集，输入的有限子集
--space. But over this sort of finite subset of the input space, we can construct a two-layer 00:28:55,400 --> 00:29:05,400
空间。但是在输入空间的这种有限子集上，我们可以构造一个两层
--network, or we also call it a one-hidden layer network sometimes, which I'm calling 00:29:05,400 --> 00:29:09,400
网络，或者我们有时也称它为单隐藏层网络，我称之为
--f-hat, that can approximate any function, any smooth function f, arbitrarily well. 00:29:09,400 --> 00:29:18,400
f-hat，可以任意逼近任何函数，任何平滑函数 f。
--And what I mean by that is if we pick some epsilon, so we pick some sort of error approximation 00:29:19,400 --> 00:29:24,400
我的意思是如果我们选择一些 epsilon，那么我们选择某种误差近似
--quantity beforehand, then given this epsilon, we can find some neural network, some two-layer 00:29:24,400 --> 00:29:31,400
预先确定数量，然后给定这个 epsilon，我们可以找到一些神经网络，一些双层
--neural network, i.e. a one-hidden layer neural network, such that the difference between 00:29:32,400 --> 00:29:39,400
神经网络，即单隐藏层神经网络，使得两者之间的差异
--our true function and our approximation is always bounded by everywhere by epsilon. 00:29:39,400 --> 00:29:44,400
我们的真实函数和我们的近似值总是以 epsilon 为界。
--And what this means intuitively is that this network, the one you saw on the last page, 00:29:45,400 --> 00:29:50,400
直觉上这意味着这个网络，你在上一页看到的那个，
--can approximate any function arbitrarily well. And this kind of, at least at a high level, 00:29:50,400 --> 00:29:59,400
可以很好地逼近任意函数。这种，至少在高层次上，
--demonstrates the power of these networks, right? You might think that, okay, linear 00:29:59,400 --> 00:30:03,400
展示了这些网络的力量，对吧？你可能会认为，好吧，线性的
--functions have some power, but all we've done is sort of introduced one more slightly complex 00:30:03,400 --> 00:30:09,400
函数有一些强大的功能，但我们所做的只是引入了一个稍微复杂一点的函数
--function, right? All we did was we just went from a linear function to this function. 00:30:09,400 --> 00:30:14,400
函数对吧？我们所做的只是从一个线性函数转到这个函数。
--This doesn't seem that much more powerful than a linear function, but it turns out it is. 00:30:15,400 --> 00:30:20,400
这似乎并不比线性函数强大多少，但事实证明确实如此。
--It's much, much more powerful. In fact, it can represent any function, whereas, of course, 00:30:20,400 --> 00:30:23,400
它要强大得多。事实上，它可以表示任何函数，当然，
--linear function can only represent, essentially, lines or planes in n dimensions. 00:30:23,400 --> 00:30:29,400
线性函数本质上只能表示 n 维的直线或平面。
--So this is a really powerful statement, but at the same time, I also want to emphasize that it's 00:30:30,400 --> 00:30:35,400
所以这是一个非常有力的声明，但与此同时，我也想强调这是
--maybe not as powerful as it might first seem. So people often, I think, kind of misinterpret 00:30:35,400 --> 00:30:40,400
也许并不像乍看起来那么强大。所以人们经常，我认为，有点误解
--these universal function approximation statements and think this means that this is some sort 00:30:40,400 --> 00:30:44,400
这些通用函数逼近语句并认为这意味着这是某种
--of magical property about these functions, and it's really not. 00:30:44,400 --> 00:30:49,400
这些功能的神奇属性，但事实并非如此。
--So I actually want to run through a little bit the proof of this fact, both to show you 00:30:50,400 --> 00:30:55,400
所以我实际上想通过一点点证明这个事实，既向你展示
--why adding this non-linearity is able to increase our representational power so much, 00:30:55,400 --> 00:31:03,400
为什么添加这种非线性能够极大地提高我们的表征能力，
--but also to kind of pull back the curtain a bit on the mystery of this universal function 00:31:03,400 --> 00:31:11,400
同时也稍微揭开这个通用功能的神秘面纱
--approximation property, because really it's a very trivial property in another sense, right? 00:31:11,400 --> 00:31:17,400
近似属性，因为在另一种意义上它确实是一个非常微不足道的属性，对吧？
--It's just sort of saying that a lot of function classes have this exact same property, 00:31:17,400 --> 00:31:23,400
这只是说很多函数类都有这个完全相同的属性，
--like, for example, nearest neighbor or polynomials and things like this. 00:31:23,400 --> 00:31:28,400
例如，最近的邻居或多项式之类的东西。
--A lot of functions have the same property, and no one cares about them, right? 00:31:28,400 --> 00:31:32,400
很多函数具有相同的属性，没有人关心它们，对吧？
--No one really thinks this is an amazing function class. 00:31:32,400 --> 00:31:36,400
没有人真的认为这是一个了不起的函数类。
--People just use, you know, they don't really use these kind of other classes, 00:31:37,400 --> 00:31:46,400
人们只是使用，你知道，他们并没有真正使用这些其他类，
--and so this property is not why neural networks are so great. 00:31:46,400 --> 00:31:52,400
所以这个属性并不是神经网络如此伟大的原因。
--It really is something very different here. 00:31:52,400 --> 00:31:56,400
这里真的很不一样。
--Polynomials actually is tricky. They're only universal functions in some quantities, 00:31:56,400 --> 00:31:59,400
多项式实际上很棘手。它们只是一些数量上的通用函数，
--but things like nearest neighbor or even spline approximations are in fact universal function approximators. 00:31:59,400 --> 00:32:05,400
但诸如最近邻甚至样条近似之类的东西实际上是通用函数逼近器。
--Okay, so here's the basic idea. 00:32:06,400 --> 00:32:08,400
好的，这是基本的想法。
--Suppose we have some function. This is our function, function f, 00:32:08,400 --> 00:32:11,400
假设我们有一些功能。这是我们的函数，函数f，
--and I'll actually show an example on the next page, but suppose we have some function. 00:32:11,400 --> 00:32:14,400
实际上，我将在下一页展示一个示例，但假设我们有一些功能。
--What we're going to do is we're going to, and this is going to be a 1D function, right? 00:32:14,400 --> 00:32:19,400
我们要做的是我们要做的，这将是一个一维函数，对吧？
--So this is going to be here on the x-axis, I'm showing x, and the y-axis I'm showing f of x. 00:32:19,400 --> 00:32:25,400
所以这将在 x 轴上，我显示 x，而 y 轴我显示 x 的 f。
--What we're going to do is we're going to first sample this function at a number of points. 00:32:26,400 --> 00:32:34,400
我们要做的是首先在多个点对该函数进行采样。
--I'm going to actually use a different color here for the sample points. 00:32:34,400 --> 00:32:37,400
实际上，我将在这里为样本点使用不同的颜色。
--We're going to sample this function at a number of different points. 00:32:37,400 --> 00:32:40,400
我们将在多个不同点对该函数进行采样。
--I think I used the opposite colors on the next slide, but that's okay. 00:32:40,400 --> 00:32:44,400
我想我在下一张幻灯片中使用了相反的颜色，但这没关系。
--Okay, and because our set D we're trying to approximate over is finite, 00:32:45,400 --> 00:32:49,400
好的，因为我们试图近似的集合 D 是有限的，
--you know, think of like this whole set here as together being the set we're trying to approximate it over. 00:32:49,400 --> 00:32:55,400
你知道，把这里的整个集合想象成我们试图对其进行近似的集合。
--So this set here is D. 00:32:55,400 --> 00:32:57,400
所以这里的这个集合是D。
--What we're going to do is we're just going to form some essentially grid of our function over this space. 00:32:58,400 --> 00:33:07,400
我们要做的是在这个空间上形成一些基本的函数网格。
--Now, 1D is just sort of a set of points, in 2D it would be a grid, 00:33:07,400 --> 00:33:10,400
现在，1D 只是一组点，在 2D 中它是一个网格，
--in 3D it would be sort of, you know, n-dimensional grids, or in D it would be n-dimensional grids. 00:33:10,400 --> 00:33:14,400
在 3D 中，它会有点像 n 维网格，或者在 D 中它会是 n 维网格。
--So there would be a lot of points here, to be clear, but this is all we're going to do. 00:33:14,400 --> 00:33:18,400
所以这里会有很多要点，要清楚，但这就是我们要做的。
--And now, at least in the 1D case, what we're going to do next, 00:33:19,400 --> 00:33:22,400
现在，至少在一维情况下，我们接下来要做的，
--we're going to construct just a linear function that will just sort of step between all these points. 00:33:22,400 --> 00:33:29,400
我们将构建一个线性函数，它将在所有这些点之间进行某种步骤。
--Like this. 00:33:31,400 --> 00:33:32,400
像这样。
--And this is going to be, this is actually what is going to be our approximation f-hat to this function. 00:33:33,400 --> 00:33:37,400
这将是，这实际上是我们对该函数的近似 f-hat。
--We're going to construct this sort of linear interpolation, 00:33:37,400 --> 00:33:40,400
我们将构建这种线性插值，
--and because the function is continuous, 00:33:40,400 --> 00:33:43,400
又因为函数是连续的，
--we actually can form an arbitrarily close approximation to the underlying function 00:33:43,400 --> 00:33:48,400
我们实际上可以对基础函数形成任意接近的近似值
--with this linear, kind of piecewise linear approximation. 00:33:48,400 --> 00:33:52,400
用这种线性的，一种分段线性近似。
--So, first of all, one thing you should be kind of thinking right away is, 00:33:53,400 --> 00:33:57,400
所以，首先，你应该马上想到的一件事是，
--well, okay, you know, the first thing we're doing is forming a linear spline approximation to this function. 00:33:57,400 --> 00:34:04,400
好吧，你知道的，我们要做的第一件事是形成一个线性样条逼近这个函数。
--That implies, of course, that linear splines have all the same universal function approximation qualities. 00:34:04,400 --> 00:34:09,400
当然，这意味着线性样条具有所有相同的通用函数逼近特性。
--But what we're going to do, in this particular case, 00:34:09,400 --> 00:34:12,400
但是我们要做的，在这种特殊情况下，
--is show that a neural network can also represent this linear spline. 00:34:12,400 --> 00:34:17,400
表明神经网络也可以表示这种线性样条。
--In particular, a neural network using the relu operator. 00:34:17,400 --> 00:34:20,400
特别是使用 relu 运算符的神经网络。
--So essentially, again, what we're doing is we're taking the function, sampling it a lot, 00:34:20,400 --> 00:34:25,400
所以本质上，再一次，我们正在做的是我们正在获取函数，对其进行大量采样，
--constructing a linear spline, and then showing that this can be approximated by a neural network. 00:34:25,400 --> 00:34:30,400
构造一个线性样条，然后证明这可以用神经网络来近似。
--But this should already be a bit kind of unsatisfying to you, 00:34:30,400 --> 00:34:33,400
但这对你来说应该已经有点不满意了，
--because, of course, to do this well, you would need a whole lot of sample points. 00:34:33,400 --> 00:34:38,400
因为，当然，要做到这一点，您需要大量的样本点。
--And it turns out that to form a neural network that can do this, 00:34:38,400 --> 00:34:41,400
事实证明，要形成一个可以做到这一点的神经网络，
--you need the number, the dimensionality of that hidden unit, or the feature vector. 00:34:41,400 --> 00:34:46,400
您需要数字、隐藏单元的维数或特征向量。
--We also call this a hidden unit sometimes. 00:34:46,400 --> 00:34:47,400
我们有时也称其为隐藏单元。
--To be as big as the number of sample points we have. 00:34:47,400 --> 00:34:50,400
与我们拥有的样本点数量一样大。
--i.e., the size of the neural network that actually approximates this can kind of grow arbitrarily large. 00:34:50,400 --> 00:34:58,400
也就是说，实际近似于此的神经网络的大小可以任意增长。
--And so it's a nice property, but not that practical. 00:34:58,400 --> 00:35:02,400
所以这是一个不错的财产，但不是那么实用。
--Alright, so how do we do this? 00:35:05,400 --> 00:35:06,400
好吧，那我们该怎么做呢？
--How do we form a neural network that actually approximates this linear spline here? 00:35:06,400 --> 00:35:11,400
我们如何在这里形成一个实际上逼近这个线性样条的神经网络？
--Now, the way we do it is, what we're going to do is, 00:35:12,400 --> 00:35:15,400
现在，我们这样做的方式是，我们要做的是，
--we're going to use a one-hidden-layer relu network. 00:35:15,400 --> 00:35:18,400
我们将使用单隐藏层 relu 网络。
--And we actually are going to use a bias here. 00:35:18,400 --> 00:35:20,400
我们实际上要在这里使用偏差。
--One thing I didn't mention before is that our functions we used before 00:35:20,400 --> 00:35:24,400
我之前没有提到的一件事是我们之前使用的功能
--actually don't include what we call a bias term. 00:35:24,400 --> 00:35:26,400
实际上不包括我们所说的偏差项。
--We'll get back to that when we start talking about more generic neural networks. 00:35:26,400 --> 00:35:29,400
当我们开始谈论更通用的神经网络时，我们会回到这一点。
--But actually here, in this lecture, for the most part, we're not going to use a bias term. 00:35:29,400 --> 00:35:32,400
但实际上，在本次讲座中，在大多数情况下，我们不会使用偏差项。
--So we're just taking our features as some linear function input. 00:35:32,400 --> 00:35:36,400
所以我们只是将我们的特征作为一些线性函数输入。
--We're not adding this what we call bias here. 00:35:36,400 --> 00:35:38,400
我们不会在这里添加我们称之为偏见的东西。
--But for this proof, we actually do need a bias. 00:35:38,400 --> 00:35:40,400
但是对于这个证明，我们实际上确实需要一个偏差。
--Okay, so our function f-hat is going to be some sum of individual elements that look like this. 00:35:41,400 --> 00:35:49,400
好的，所以我们的函数 f-hat 将是一些看起来像这样的单个元素的总和。
--Alright, so it's going to be plus or minus the max of 0 and a linear function of our input. 00:35:49,400 --> 00:35:57,400
好的，所以它将加上或减去 0 的最大值和我们输入的线性函数。
--And remember, our input is 1d, so it's just a slope and a bias for our input. 00:35:57,400 --> 00:36:02,400
请记住，我们的输入是 1d，所以它只是我们输入的斜率和偏差。
--Okay, now before I get into sort of how we construct this function, 00:36:03,400 --> 00:36:08,400
好的，现在在我开始讨论我们如何构造这个函数之前，
--I kind of want to go over what these functions look like. 00:36:08,400 --> 00:36:10,400
我有点想回顾一下这些功能是什么样的。
--So what does this function here actually look like? 00:36:10,400 --> 00:36:13,400
那么这里的这个函数实际上是什么样子的呢？
--What does this function here actually look like? 00:36:14,400 --> 00:36:16,400
这个功能实际上是什么样子的？
--Well, the function inside, what it looks like basically is functions like this. 00:36:17,400 --> 00:36:23,400
嗯，里面的函数，看样子基本上就是这样的函数。
--It looks like functions that are constant up to some point. 00:36:23,400 --> 00:36:26,400
它看起来像是在某个点上保持不变的函数。
--Right, because there's 0 here, so there's 0 everywhere. 00:36:27,400 --> 00:36:33,400
对，因为这里是 0，所以到处都是 0。
--There's 0 up to some point. 00:36:34,400 --> 00:36:36,400
有 0 到某个点。
--And then, after that 0 point, so basically whenever this term inside here is negative, 00:36:36,400 --> 00:36:42,400
然后，在那个 0 点之后，所以基本上只要这里的这个项是负数，
--right, those functions would be 0. 00:36:42,400 --> 00:36:45,400
对，那些函数应该是 0。
--And then after that, they have some linear slope, and that linear slope can go up or down. 00:36:46,400 --> 00:36:53,400
在那之后，它们有一些线性斜率，并且该线性斜率可以上升或下降。
--And this is what I mean, by the way, by this sort of plus or minus here. 00:36:53,400 --> 00:36:56,400
顺便说一句，这就是我在这里所说的加号或减号的意思。
--We let basically the function, so the function can look like this, or they can look like this. 00:36:56,400 --> 00:37:01,400
我们基本上让功能，所以功能可以看起来像这样，或者它们可以像这样。
--I should probably write it out separately because this gets a bit confusing otherwise. 00:37:01,400 --> 00:37:05,400
我可能应该单独写出来，否则会有点混乱。
--So it's 0 and some left half, you know, when x is below some value, 00:37:06,400 --> 00:37:10,400
所以它是 0 和一些左半部分，你知道，当 x 低于某个值时，
--and then all of a sudden it kind of comes up and it becomes like one of these two cases. 00:37:10,400 --> 00:37:15,400
然后突然间它出现了，它变成了这两种情况之一。
--And by controlling the bias and the slope, we can control kind of where on the x-axis 00:37:16,400 --> 00:37:21,400
通过控制偏差和斜率，我们可以控制 x 轴上的某种位置
--we switch from being 0 to being positive or negative. 00:37:21,400 --> 00:37:24,400
我们从 0 切换为正或负。
--But basically, you know, functions on the inside there, they just look like one of these two cases. 00:37:24,400 --> 00:37:28,400
但基本上，你知道，在里面发挥作用，它们看起来就像这两种情况中的一种。
--Okay, so what do we then do? 00:37:29,400 --> 00:37:33,400
好的，那我们怎么办？
--All right, what does this actually look like? 00:37:33,400 --> 00:37:36,400
好吧，这实际上是什么样的？
--So how do we approximate a function like this with elements like this? 00:37:37,400 --> 00:37:42,400
那么我们如何用这样的元素来近似这样的函数呢？
--Well, one thing we can do is, first of all, we can take our function and just sort of take, you know, 00:37:44,400 --> 00:37:50,400
好吧，我们可以做的一件事是，首先，我们可以接受我们的功能，只是接受，你知道的，
--let's say we want to approximate it over this region here. 00:37:50,400 --> 00:37:53,400
比方说，我们想在此处对这个区域进行近似。
--We can start with just a constant function. 00:37:53,400 --> 00:37:56,400
我们可以从一个常量函数开始。
--And that function actually would be just by, in the first function, you set w equal to 0. 00:37:56,400 --> 00:38:00,400
该函数实际上只是在第一个函数中将 w 设置为 0。
--You make b, i, a positive thing. 00:38:01,400 --> 00:38:03,400
你让 b, i 成为一件积极的事情。
--So assuming, you know, this, we're at 0 here, 0 is down here. 00:38:03,400 --> 00:38:07,400
所以假设，你知道，我们这里是 0，这里是 0。
--So this whole function, at least at the start point, is positive. 00:38:07,400 --> 00:38:10,400
所以这整个功能，至少在起点，是积极的。
--If it's not, it's trivial to fix this, by the way. 00:38:10,400 --> 00:38:12,400
如果不是，顺便说一句，解决这个问题很简单。
--It's not hard to do, but it's just, let's assume that for simplicity. 00:38:12,400 --> 00:38:15,400
这并不难做到，但只是为了简单起见，让我们假设一下。
--We start off basically with just the function f hat of x would be equal to, 00:38:15,400 --> 00:38:21,400
我们基本上只从 x 的函数 f hat 开始，它等于，
--well, it would be equal to the max of 0 and, you know, whatever this value is here. 00:38:22,400 --> 00:38:27,400
好吧，它等于 0 的最大值，你知道，无论这里的值是多少。
--Call this value 1, x is equal to 1, which would be equal to 1. 00:38:27,400 --> 00:38:30,400
将此值称为 1，x 等于 1，这将等于 1。
--So this function, at least at first, is just some constant value. 00:38:30,400 --> 00:38:33,400
所以这个函数，至少一开始，只是一些常数值。
--Okay, now let's sort of play our kind of game. 00:38:34,400 --> 00:38:37,400
好的，现在让我们来玩我们的游戏吧。
--So that's the first one. 00:38:37,400 --> 00:38:39,400
所以这是第一个。
--I'll erase this here, but that's sort of the first value of this function. 00:38:39,400 --> 00:38:42,400
我将在这里删除它，但这是该函数的第一个值。
--Actually, maybe I'll leave it there for one more time. 00:38:43,400 --> 00:38:46,400
实际上，也许我会再把它留在那里一次。
--Okay, now what we're going to do is we're going to pick our next kind of grid point on the function, 00:38:47,400 --> 00:38:53,400
好的，现在我们要做的是在函数上选择下一种网格点，
--and we're going to add to this function some other function, 00:38:53,400 --> 00:38:57,400
我们将向这个函数添加一些其他函数，
--which is going to be 0 everywhere until this point right here, 00:38:57,400 --> 00:39:04,400
直到此时这里都是 0，
--at which point it turns negative, 00:39:04,400 --> 00:39:07,400
在这一点上它变成负数，
--with a slope that exactly passes through our next point here. 00:39:08,400 --> 00:39:13,400
斜坡恰好通过我们这里的下一个点。
--All right? 00:39:14,400 --> 00:39:16,400
好的？
--And so this next one, I mean, I don't know what the slope or bias would be, 00:39:16,400 --> 00:39:20,400
所以下一个，我的意思是，我不知道斜率或偏差是多少，
--but it's some other function now we've added to this, 00:39:20,400 --> 00:39:23,400
但现在我们已经添加了一些其他功能，
--which equals the max of, really, it would be negative, right? 00:39:23,400 --> 00:39:27,400
这等于最大值，真的，它会是负数，对吧？
--In this particular case, we have negative slopes, 00:39:27,400 --> 00:39:29,400
在这种特殊情况下，我们有负斜率，
--and minus the max of 0 and some w1 times x plus b1. 00:39:29,400 --> 00:39:35,400
并减去 0 的最大值和一些 w1 乘以 x 加上 b1。
--And that sort of formulation is enough to make our new function, 00:39:35,400 --> 00:39:39,400
那种公式足以使我们的新功能，
--our total function, kind of in red here, look basically like this. 00:39:39,400 --> 00:39:44,400
我们的总功能，在这里有点像红色，看起来基本上是这样的。
--It's this function value here, it's this function value here, 00:39:44,400 --> 00:39:49,400
这里是这个函数值，这里是这个函数值，
--and at this point it becomes this function here. 00:39:49,400 --> 00:39:52,400
而此时这里就变成了这个函数。
--And the whole point, of course, is that we can keep playing this game, right? 00:39:54,400 --> 00:39:58,400
当然，重点是我们可以继续玩这个游戏，对吧？
--I can keep playing this game here, where I just pick my next point, 00:39:58,400 --> 00:40:01,400
我可以在这里继续玩这个游戏，我只是选择下一个点，
--then add a function that is 0 all the way up to this point, 00:40:01,400 --> 00:40:05,400
然后添加一个一直为0的函数，
--and then has some slope to basically cancel out this negative slope 00:40:05,400 --> 00:40:09,400
然后有一些斜率基本上可以抵消这个负斜率
--and become, you know, essentially makes our function equal to this, 00:40:09,400 --> 00:40:14,400
并成为，你知道，本质上使我们的功能等于这个，
--here, and then there. 00:40:14,400 --> 00:40:16,400
这里，然后那里。
--Right? And we just keep doing that process 00:40:20,400 --> 00:40:22,400
正确的？我们只是继续做这个过程
--until our function passes through all the points. 00:40:22,400 --> 00:40:25,400
直到我们的函数通过所有的点。
--So that's the idea. 00:40:25,400 --> 00:40:27,400
这就是我们的想法。
--It's a really simple idea, to be frank. 00:40:27,400 --> 00:40:29,400
坦率地说，这是一个非常简单的想法。
--It's just sort of a constructive argument 00:40:29,400 --> 00:40:32,400
这只是一种建设性的论点
--about how you make this particular function 00:40:32,400 --> 00:40:35,400
关于你如何实现这个特定功能
--pass through some set of sampling points 00:40:37,400 --> 00:40:43,400
通过一组采样点
--of our underlying function. 00:40:43,400 --> 00:40:45,400
我们的基本功能。
--And because of our assumption about the underlying function, 00:40:45,400 --> 00:40:47,400
由于我们对基础功能的假设，
--this thing is as good an approximation as we want. 00:40:47,400 --> 00:40:51,400
这个东西是我们想要的最好的近似值。
--All right, so... 00:40:53,400 --> 00:40:55,400
好吧，所以...
--This... 00:40:56,400 --> 00:40:58,400
这...
--Again, this theorem here is both sort of trivial. 00:40:58,400 --> 00:41:02,400
同样，这里的这个定理都是微不足道的。
--Again, it's just saying that we can kind of approximate 00:41:02,400 --> 00:41:05,400
再一次，它只是说我们可以近似
--some number of points. 00:41:05,400 --> 00:41:07,400
一些点。
--Okay, that doesn't seem like a very... 00:41:07,400 --> 00:41:09,400
好吧，这似乎不是一个非常...
--To actually do this, of course, you need to have a whole bunch of samples 00:41:09,400 --> 00:41:12,400
当然，要真正做到这一点，您需要有一大堆样本
--of your underlying function to cover it over some space. 00:41:12,400 --> 00:41:15,400
你的底层功能覆盖它在一些空间。
--But it is also kind of worth realizing 00:41:15,400 --> 00:41:20,400
但它也有点值得实现
--what this actually implies. 00:41:20,400 --> 00:41:22,400
这实际上意味着什么。
--So linear functions in 1D, 00:41:22,400 --> 00:41:24,400
所以一维的线性函数，
--they just look like lines, right? 00:41:24,400 --> 00:41:26,400
它们看起来就像线条，对吧？
--They look like this over the input space. 00:41:26,400 --> 00:41:29,400
它们在输入空间上看起来像这样。
--That's all a linear function in 1D can do. 00:41:29,400 --> 00:41:32,400
这就是 1D 中的线性函数所能做的。
--But having this nonlinearity we apply 00:41:32,400 --> 00:41:37,400
但是有了这种非线性我们应用
--in the intermediate cases, 00:41:37,400 --> 00:41:39,400
在中间情况下，
--this enables us to now approximate 00:41:39,400 --> 00:41:42,400
这使我们现在可以近似
--any 1D function arbitrarily well, right? 00:41:42,400 --> 00:41:44,400
任意 1D 函数都可以，对吧？
--So we can approximate crazy functions like this, 00:41:44,400 --> 00:41:46,400
所以我们可以像这样近似疯狂的函数，
--continuous functions. 00:41:46,400 --> 00:41:48,400
连续函数。
--And so this is both kind of emphasizing 00:41:48,400 --> 00:41:51,400
所以这两者都在强调
--that it's not magic here. 00:41:51,400 --> 00:41:53,400
这不是魔法。
--To do this well, we're going to, of course, 00:41:53,400 --> 00:41:55,400
为了做好这件事，我们当然要，
--have complexities of our function that grow exponentially 00:41:55,400 --> 00:41:57,400
我们函数的复杂性呈指数级增长
--in the input dimension, 00:41:57,400 --> 00:41:58,400
在输入维度中，
--and how well we have to approximate things, 00:41:58,400 --> 00:42:00,400
以及我们对事物的近似程度，
--all that kind of stuff. 00:42:00,400 --> 00:42:01,400
所有这些东西。
--It's not a practical way of approximating functions. 00:42:01,400 --> 00:42:03,400
这不是逼近函数的实用方法。
--But it also does hopefully emphasize 00:42:03,400 --> 00:42:06,400
但它也确实希望强调
--the power of even this one nonlinearity 00:42:06,400 --> 00:42:10,400
即使是这个非线性的力量
--that we have in our feature vector. 00:42:10,400 --> 00:42:12,400
我们的特征向量中有。
--All right, so with that out of the way, 00:42:14,400 --> 00:42:17,400
好吧，让开这个，
--let me come back now to 00:42:17,400 --> 00:42:19,400
让我现在回到
--the kind of neural networks we actually use, 00:42:19,400 --> 00:42:21,400
我们实际使用的神经网络类型，
--and then talk about backprop finally. 00:42:21,400 --> 00:42:25,400
然后最后谈谈反向传播。
--Because what we're actually going to do very shortly 00:42:27,400 --> 00:42:31,400
因为我们实际上很快就会做
--is use not just this two-layer network, 00:42:31,400 --> 00:42:34,400
不只是使用这个两层网络，
--but also think about more generic forms 00:42:34,400 --> 00:42:36,400
但也要考虑更通用的形式
--of L-layer networks, 00:42:36,400 --> 00:42:38,400
L层网络，
--where big L here represents the number of layers 00:42:38,400 --> 00:42:42,400
这里的大L代表层数
--in a network. 00:42:42,400 --> 00:42:43,400
在网络中。
--Because, and I should admit, 00:42:43,400 --> 00:42:45,400
因为，我应该承认，
--even though I emphasized in the beginning 00:42:45,400 --> 00:42:47,400
虽然我一开始就强调
--that deep learning really referred to 00:42:47,400 --> 00:42:49,400
深度学习真正指的是
--kind of any machine learning with neural networks, 00:42:49,400 --> 00:42:51,400
任何一种使用神经网络的机器学习，
--the reality is most deep learning, 00:42:51,400 --> 00:42:55,400
现实是最深度的学习，
--as we sort of use the term today, 00:42:55,400 --> 00:42:57,400
当我们今天使用这个词时，
--is predicated upon networks 00:42:57,400 --> 00:42:59,400
基于网络
--that have more than just one layer. 00:42:59,400 --> 00:43:01,400
不止一层。
--They are more than just one hidden layer, 00:43:01,400 --> 00:43:03,400
它们不仅仅是一个隐藏层，
--i.e. more than just two layers, 00:43:03,400 --> 00:43:04,400
即不止两层，
--that sort of transform between the input and the output. 00:43:04,400 --> 00:43:08,400
输入和输出之间的那种转换。
--And the way we often write that is as a kind of, 00:43:08,400 --> 00:43:12,400
我们经常写的方式是，
--or at least the simplest form of such a network, 00:43:12,400 --> 00:43:14,400
或者至少是这种网络的最简单形式，
--will be what we call a multi-layer perceptron, 00:43:14,400 --> 00:43:17,400
将是我们所说的多层感知器，
--or MLP, 00:43:17,400 --> 00:43:19,400
或多层板，
--which is essentially just a sequence 00:43:19,400 --> 00:43:21,400
这本质上只是一个序列
--of these same transformations 00:43:21,400 --> 00:43:23,400
这些相同的转变
--applied one after the other. 00:43:23,400 --> 00:43:25,400
一个接一个地应用。
--Okay? 00:43:25,400 --> 00:43:26,400
好的？
--So we start with our first, 00:43:26,400 --> 00:43:28,400
所以我们从第一个开始，
--and the reason why I'm interested in this here 00:43:28,400 --> 00:43:30,400
以及我对此感兴趣的原因
--is that we're going to use this terminology 00:43:30,400 --> 00:43:32,400
是我们要使用这个术语
--a little bit later when we talk about 00:43:32,400 --> 00:43:33,400
稍后当我们谈论
--backpropagation in general. 00:43:33,400 --> 00:43:34,400
一般反向传播。
--And it's worth thinking about these networks, 00:43:34,400 --> 00:43:37,400
值得考虑这些网络，
--not just in terms of sort of a fixed function 00:43:37,400 --> 00:43:39,400
不仅仅是在某种固定功能方面
--that happens to have two layers, 00:43:39,400 --> 00:43:41,400
恰好有两层，
--but in terms of kind of iterations 00:43:41,400 --> 00:43:43,400
但就迭代类型而言
--that are applied sequentially throughout the network. 00:43:43,400 --> 00:43:47,400
在整个网络中顺序应用。
--Okay, so what we're going to define here, 00:43:47,400 --> 00:43:49,400
好的，所以我们要在这里定义的，
--we're going to define, as I said, 00:43:49,400 --> 00:43:50,400
正如我所说，我们将定义
--this L-layer network, 00:43:50,400 --> 00:43:52,400
这个L层网络，
--where the first, the input to the function, 00:43:52,400 --> 00:43:55,400
其中第一个是函数的输入，
--X, this is again just our input matrix, 00:43:55,400 --> 00:43:58,400
 X，这又是我们的输入矩阵，
--we actually call that just directly, 00:43:58,400 --> 00:44:01,400
我们实际上直接调用它，
--call that Z1. 00:44:01,400 --> 00:44:03,400
称其为Z1。
--And these things here, 00:44:03,400 --> 00:44:04,400
而这里的这些东西，
--these values, you know, Z1 and beyond, 00:44:04,400 --> 00:44:08,400
这些值，你知道，Z1 及以后，
--we're going to call these things layers. 00:44:08,400 --> 00:44:12,400
我们将称这些东西为层。
--Now, whether we refer to the activations 00:44:13,400 --> 00:44:17,400
现在，我们是否参考激活
--or I just say layers, sometimes activations, 00:44:17,400 --> 00:44:21,400
或者我只是说层，有时是激活，
--sometimes, I'll try to avoid it, 00:44:21,400 --> 00:44:23,400
有时候，我会尽量避免，
--but sometimes they're also called neurons. 00:44:23,400 --> 00:44:26,400
但有时它们也被称为神经元。
--These are the intermediate features 00:44:26,400 --> 00:44:28,400
这些是中间特征
--that are formed at the different stages of the network. 00:44:28,400 --> 00:44:31,400
在网络的不同阶段形成。
--Now, probably layer is actually the wrong term. 00:44:31,400 --> 00:44:33,400
现在，可能层实际上是错误的术语。
--I'll still use that. 00:44:33,400 --> 00:44:34,400
我仍然会使用它。
--Also something called the hidden layer, 00:44:34,400 --> 00:44:36,400
还有一种叫做隐藏层的东西，
--but there's a lot of terms for this. 00:44:36,400 --> 00:44:38,400
但是有很多术语。
--I probably shouldn't use the word layer by itself 00:44:38,400 --> 00:44:41,400
我可能不应该单独使用图层这个词
--because layer can sometimes also refer to the actual weight 00:44:41,400 --> 00:44:43,400
因为layer有时也可以参考实际重量
--that transform one thing to the next. 00:44:43,400 --> 00:44:45,400
将一件事变成另一件事。
--I should probably try to use hidden layer 00:44:45,400 --> 00:44:47,400
我应该尝试使用隐藏层
--or activation as much as I can, 00:44:47,400 --> 00:44:48,400
或尽可能多地激活，
--but all these things are kind of used 00:44:48,400 --> 00:44:50,400
但所有这些东西都有点用
--to describe what these things are. 00:44:50,400 --> 00:44:52,400
来描述这些东西是什么。
--And actually, maybe even more precisely, 00:44:52,400 --> 00:44:54,400
实际上，也许更准确地说，
--I should probably not call Z1 that 00:44:54,400 --> 00:44:55,400
我可能不应该这样称呼 Z1
--because Z1 is the one that is typically not a layer. 00:44:55,400 --> 00:44:57,400
因为 Z1 通常不是一层。
--I should call sort of the intermediate layers 00:44:57,400 --> 00:44:59,400
我应该调用中间层
--that we form the layers or activations or neurons 00:44:59,400 --> 00:45:02,400
我们形成层或激活或神经元
--or hidden layers of the network. 00:45:02,400 --> 00:45:05,400
或网络的隐藏层。
--Okay, so what is, 00:45:05,400 --> 00:45:06,400
好的，那是什么，
--let me actually clear this here 00:45:06,400 --> 00:45:07,400
让我在这里真正清除这个
--so we can see it a bit better. 00:45:07,400 --> 00:45:10,400
所以我们可以更好地看到它。
--What is a network like this? 00:45:10,400 --> 00:45:12,400
什么是这样的网络？
--What is an L-layer network? 00:45:12,400 --> 00:45:14,400
什么是L层网络？
--Well, we typically define it 00:45:14,400 --> 00:45:15,400
好吧，我们通常定义它
--as the first layer is equal to the input. 00:45:15,400 --> 00:45:17,400
因为第一层等于输入。
--So that's sort of the easiest thing. 00:45:17,400 --> 00:45:20,400
所以这是最简单的事情。
--For ease of writing it, 00:45:20,400 --> 00:45:22,400
为了写的方便，
--we want to sort of have the same terminology for each layer. 00:45:22,400 --> 00:45:26,400
我们希望每一层都有相同的术语。
--So I'm just going to call 00:45:26,400 --> 00:45:28,400
所以我要打电话
--or define Z1 to just be equal to X. 00:45:28,400 --> 00:45:32,400
或者将 Z1 定义为正好等于 X。
--And ZIs are going to be the layers of this network 00:45:32,400 --> 00:45:34,400
 ZIs 将成为这个网络的层
--or the hidden layers of this network. 00:45:34,400 --> 00:45:36,400
或该网络的隐藏层。
--The real crux of this network here is this equation here. 00:45:37,400 --> 00:45:42,400
这个网络的真正症结在于这个等式。
--So this says that ZI plus one, 00:45:42,400 --> 00:45:45,400
所以这表示 ZI 加一，
--the I plus one hidden layer of the network 00:45:45,400 --> 00:45:48,400
 I 加上网络的一个隐藏层
--is going to be equal to ZI times our matrix WI 00:45:48,400 --> 00:45:55,400
将等于 ZI 乘以我们的矩阵 WI
--with some non-linearity applied. 00:45:55,400 --> 00:45:57,400
应用了一些非线性。
--So basically, this is just a generalization 00:45:57,400 --> 00:45:59,400
所以基本上，这只是一个概括
--of that what we call a two-layer network we saw before. 00:45:59,400 --> 00:46:05,400
我们之前看到的所谓的双层网络。
--To an L-layer network. 00:46:05,400 --> 00:46:07,400
到一个L层网络。
--So it should be apparent that if you take a L equals, 00:46:07,400 --> 00:46:11,400
所以很明显，如果你取一个 L 等于，
--in that case, two, 00:46:11,400 --> 00:46:14,400
在那种情况下，两个，
--and you have your last, I guess, non-linearity, 00:46:14,400 --> 00:46:16,400
我猜你有最后一个非线性，
--it'll just be the identity function. 00:46:16,400 --> 00:46:18,400
它只是身份函数。
--So it's actually not a non-linear function. 00:46:18,400 --> 00:46:20,400
所以它实际上不是非线性函数。
--Then this would be exactly the same 00:46:20,400 --> 00:46:21,400
那么这将完全相同
--as the function we had before. 00:46:21,400 --> 00:46:22,400
作为我们之前的功能。
--But this allows for not just a single kind of mapping 00:46:22,400 --> 00:46:26,400
但这不仅允许单一类型的映射
--or feature mapping, 00:46:26,400 --> 00:46:27,400
或特征映射，
--but multiple feature mappings kind of applied sequentially. 00:46:27,400 --> 00:46:30,400
但是多个特征映射是按顺序应用的。
--So we take our input, we transform it to one type of feature. 00:46:30,400 --> 00:46:34,400
所以我们接受我们的输入，我们将其转换为一种类型的特征。
--We transform that to another type of feature, et cetera. 00:46:34,400 --> 00:46:36,400
我们将其转换为另一种类型的特征，等等。
--And we'll talk in a second 00:46:36,400 --> 00:46:37,400
我们一会儿再谈
--about why this might be a good idea. 00:46:37,400 --> 00:46:38,400
关于为什么这可能是个好主意。
--But this is the kind of form 00:46:38,400 --> 00:46:40,400
但就是这种形式
--people often start with in deep learning. 00:46:40,400 --> 00:46:43,400
人们通常从深度学习开始。
--Now, just for completeness, 00:46:43,400 --> 00:46:45,400
现在，为了完整起见，
--I do want to talk about the size of these. 00:46:45,400 --> 00:46:46,400
我确实想谈谈这些的大小。
--Oh, and I should finally mention 00:46:46,400 --> 00:46:48,400
哦，我最后应该提一下
--the actual output of hypothesis class 00:46:48,400 --> 00:46:50,400
假设类的实际输出
--that we consider here 00:46:50,400 --> 00:46:52,400
我们在这里考虑
--would just be the Z, the L plus one layer. 00:46:52,400 --> 00:46:58,400
只是Z，L加一层。
--I'll be considering this terminology here, by the way. 00:46:58,400 --> 00:47:00,400
顺便说一句，我将在这里考虑这个术语。
--Some people would say that an L layer network 00:47:00,400 --> 00:47:03,400
有人会说L层网络
--goes from Z1 to ZL, 00:47:03,400 --> 00:47:06,400
从 Z1 到 ZL，
--and therefore would have L minus one sets of weights. 00:47:06,400 --> 00:47:10,400
因此会有 L 减去一组权重。
--The convention I'm using is that 00:47:10,400 --> 00:47:12,400
我使用的约定是
--the last layer of a L layer network 00:47:12,400 --> 00:47:17,400
L层网络的最后一层
--is the layer ZL plus one, 00:47:17,400 --> 00:47:19,400
是ZL层加一，
--but this is just convention here. 00:47:19,400 --> 00:47:21,400
但这只是这里的惯例。
--Now, again, just for convenience, 00:47:21,400 --> 00:47:26,400
现在，再次，只是为了方便，
--I'm going to need to define sizes for all these things. 00:47:26,400 --> 00:47:28,400
我将需要为所有这些东西定义尺寸。
--So I will say that ZI, 00:47:28,400 --> 00:47:30,400
所以我会说 ZI，
--which again is our collection of kind of features 00:47:30,400 --> 00:47:33,400
这又是我们的一种特征的集合
--applied to our entire input matrix X, 00:47:33,400 --> 00:47:35,400
应用于我们的整个输入矩阵 X，
--remember X is sort of a collection of all our inputs, 00:47:35,400 --> 00:47:37,400
记住 X 是我们所有输入的集合，
--would be M by NI. 00:47:37,400 --> 00:47:40,400
将是 NI 的 M。
--So NI is the dimensionality of the features 00:47:40,400 --> 00:47:44,400
所以NI是特征的维度
--or hidden unit at layer I. 00:47:44,400 --> 00:47:47,400
或第一层的隐藏单元。
--And this would necessitate then that WI, 00:47:47,400 --> 00:47:50,400
这将需要 WI，
--which is the mapping from one layer to the next, 00:47:50,400 --> 00:47:53,400
这是从一层到下一层的映射，
--would be NI by NI plus one. 00:47:53,400 --> 00:47:56,400
将是 NI 乘 NI 加一。
--So I won't dwell on that, 00:47:56,400 --> 00:47:58,400
那我就不多说了
--because again, all these sizes become unimportant shortly, 00:47:58,400 --> 00:48:01,400
因为，所有这些尺寸很快就会变得不重要，
--but this is the size that I'm going to use at least initially. 00:48:01,400 --> 00:48:04,400
但这是我至少一开始要使用的尺寸。
--And here our parameters 00:48:04,400 --> 00:48:06,400
这是我们的参数
--would just be the collection of all those weights. 00:48:06,400 --> 00:48:09,400
只是所有这些权重的集合。
--We can optionally add a bias term, 00:48:09,400 --> 00:48:11,400
我们可以选择添加一个偏置项，
--meaning what that means is that we can also add a term there 00:48:11,400 --> 00:48:14,400
这意味着我们也可以在那里添加一个术语
--that's something like plus B, 00:48:14,400 --> 00:48:17,400
就像加B一样，
--where B naturally would be a matrix 00:48:17,400 --> 00:48:19,400
其中 B 自然是一个矩阵
--in the form of all those bias terms stacked. 00:48:19,400 --> 00:48:21,400
以所有这些偏置项的形式叠加。
--So I'm not going to do that right here, 00:48:21,400 --> 00:48:23,400
所以我不打算在这里这样做，
--but you actually don't need this as much as people think. 00:48:23,400 --> 00:48:25,400
但实际上你并不像人们想象的那么需要它。
--People seem to think that you always need these bias terms. 00:48:25,400 --> 00:48:28,400
人们似乎认为你总是需要这些偏见条款。
--Most networks actually work fine if you don't have bias terms. 00:48:28,400 --> 00:48:31,400
如果您没有偏差项，大多数网络实际上都可以正常工作。
--But you can add that, 00:48:31,400 --> 00:48:32,400
但你可以补充一点，
--and we will actually add that in a few lectures. 00:48:32,400 --> 00:48:34,400
我们实际上会在几节课中添加这一点。
--But only do we do so 00:48:34,400 --> 00:48:35,400
但只有我们这样做
--after we've dealt with automatic differentiation, 00:48:35,400 --> 00:48:37,400
在我们处理完自动微分之后，
--because frankly, I don't even... 00:48:37,400 --> 00:48:39,400
因为坦率地说，我什至不...
--You're going to see how gross the math is 00:48:39,400 --> 00:48:42,400
你会看到数学有多粗
--for even this simple case, 00:48:42,400 --> 00:48:44,400
即使对于这种简单的情况，
--and you're going to be glad that we don't have bias terms here. 00:48:44,400 --> 00:48:47,400
你会很高兴我们这里没有偏见条款。
--But we are going to do this in batch form. 00:48:47,400 --> 00:48:50,400
但是我们将以批处理的形式进行。
--So we are talking in this whole case 00:48:50,400 --> 00:48:52,400
所以我们正在谈论整个案例
--about the entire set of inputs, 00:48:52,400 --> 00:48:55,400
关于整组输入，
--because again, that's very key 00:48:55,400 --> 00:48:57,400
因为这很关键
--to sort of applying these things efficiently. 00:48:57,400 --> 00:49:00,400
有效地应用这些东西。
--Now, one thing you might want to be... 00:49:00,400 --> 00:49:02,400
现在，你可能想成为一件事......
--might kind of immediately be asking yourself here 00:49:02,400 --> 00:49:04,400
可能会立即在这里问自己
--when we talk about deep networks 00:49:04,400 --> 00:49:06,400
当我们谈论深度网络时
--is why do we actually use deep networks, right? 00:49:06,400 --> 00:49:08,400
就是为什么我们实际上使用深度网络，对吗？
--Well, why do we... 00:49:08,400 --> 00:49:11,400
那么，为什么我们...
--We just showed that a single layer or single hidden layer, 00:49:11,400 --> 00:49:14,400
我们刚刚展示了单层或单隐藏层，
--i.e. two-layer network, 00:49:14,400 --> 00:49:16,400
即双层网络，
--is already a universal function approximator. 00:49:16,400 --> 00:49:19,400
已经是通用函数逼近器。
--Why are we using deep networks? 00:49:19,400 --> 00:49:21,400
我们为什么要使用深度网络？
--And there actually are a lot of reasons for this that people give. 00:49:21,400 --> 00:49:24,400
人们实际上给出了很多理由。
--And I want to at least mention some of these reasons 00:49:24,400 --> 00:49:27,400
我想至少提一下其中的一些原因
--about why it does seem to be the case 00:49:27,400 --> 00:49:30,400
关于为什么会这样
--that we're so focused on deep learning 00:49:30,400 --> 00:49:32,400
我们如此专注于深度学习
--and why do we use deep architectures 00:49:32,400 --> 00:49:34,400
以及为什么我们使用深度架构
--when I just showed that in some sense, 00:49:34,400 --> 00:49:36,400
当我刚刚在某种意义上展示了这一点时，
--one architect, one hidden layer, right, 00:49:36,400 --> 00:49:39,400
一位架构师，一个隐藏层，对，
--is enough to represent any function. 00:49:39,400 --> 00:49:41,400
足以代表任何功能。
--I'll watch it up for 1D, but it's true in general. 00:49:41,400 --> 00:49:43,400
我会注意它的一维，但总的来说是这样。
--So there's a few reasons people give. 00:49:43,400 --> 00:49:45,400
所以人们给出了几个原因。
--And the first one of these, again, 00:49:45,400 --> 00:49:47,400
而其中的第一个，再次，
--kind of harks back to some of that motivation 00:49:47,400 --> 00:49:50,400
有点让人想起那种动机
--I mentioned earlier about neural networks 00:49:50,400 --> 00:49:52,400
我之前提到过神经网络
--at least being loosely inspired by the operation of the brain. 00:49:52,400 --> 00:49:55,400
至少受到大脑运作的松散启发。
--The brain, as far as we can tell, 00:49:55,400 --> 00:49:57,400
据我们所知，大脑
--does do multistage processing of its inputs 00:49:57,400 --> 00:50:00,400
确实对其输入进行多级处理
--before it reaches our final sort of decision-making center. 00:50:00,400 --> 00:50:04,400
在它到达我们最终的决策中心之前。
--However, again, you know, 00:50:04,400 --> 00:50:08,400
然而，你又知道，
--not harping on this too much, 00:50:08,400 --> 00:50:10,400
不要在这上面喋喋不休，
--but this is a great sort of motivational, 00:50:10,400 --> 00:50:13,400
但这是一种很好的激励，
--inspirational argument perhaps, 00:50:13,400 --> 00:50:15,400
也许鼓舞人心的论点，
--but it doesn't really capture 00:50:15,400 --> 00:50:17,400
但它并没有真正捕捉到
--how these networks really work in practice. 00:50:17,400 --> 00:50:19,400
这些网络在实践中是如何运作的。
--And so I think it's sort of a bad argument to just say, 00:50:19,400 --> 00:50:21,400
所以我认为只是说，这是一个糟糕的论点，
--oh, the brain has layers, therefore we need layers too. 00:50:21,400 --> 00:50:24,400
哦，大脑有层次，所以我们也需要层次。
--Another argument you often see 00:50:26,400 --> 00:50:28,400
你经常看到的另一个论点
--comes from circuit theory. 00:50:28,400 --> 00:50:30,400
来自电路理论。
--So it turns out there are certain functions 00:50:30,400 --> 00:50:32,400
所以事实证明有某些功能
--that can be represented much more efficiently 00:50:32,400 --> 00:50:34,400
可以更有效地表示
--using a multistage architecture 00:50:34,400 --> 00:50:37,400
使用多级架构
--than a sort of essentially a multilayer circuit 00:50:37,400 --> 00:50:41,400
而不是一种本质上是多层电路
--than a single-layer circuit. 00:50:41,400 --> 00:50:44,400
比单层电路。
--A classic example, though I won't get into it too much, 00:50:44,400 --> 00:50:47,400
一个经典的例子，虽然我不会过多地讨论它，
--is the parity function. 00:50:47,400 --> 00:50:48,400
是奇偶函数。
--The parity function, given a string of bits, 00:50:48,400 --> 00:50:50,400
给定一串位的奇偶校验函数，
--just counts how many, 00:50:50,400 --> 00:50:51,400
只数多少，
--if there are an even or odd number of ones in the string. 00:50:51,400 --> 00:50:55,400
如果字符串中有偶数或奇数个。
--And this function, it turns out, for various reasons, 00:50:55,400 --> 00:50:59,400
事实证明，由于各种原因，这个功能，
--if you represent it with a, 00:50:59,400 --> 00:51:01,400
如果你用一个代表它，
--you can represent it with either a two-layer circuit, 00:51:01,400 --> 00:51:04,400
你可以用两层电路来表示它，
--essentially like a two-layer neural network 00:51:04,400 --> 00:51:06,400
本质上就像一个双层神经网络
--or a multilayer neural network. 00:51:06,400 --> 00:51:08,400
或多层神经网络。
--And it turns out if you represent it 00:51:08,400 --> 00:51:09,400
事实证明，如果你代表它
--with a multilayer neural network, 00:51:09,400 --> 00:51:10,400
使用多层神经网络，
--you can do it much more efficiently. 00:51:10,400 --> 00:51:12,400
你可以更有效地做到这一点。
--So if you have a length n string, 00:51:12,400 --> 00:51:16,400
所以如果你有一个长度为 n 的字符串，
--it turns out you need 2 to the n hidden units 00:51:16,400 --> 00:51:19,400
事实证明你需要 2 到 n 个隐藏单元
--if you want to, 00:51:19,400 --> 00:51:20,400
如果你想，
--basically 2 to the n dimensions for your feature vector. 00:51:20,400 --> 00:51:24,400
基本上是特征向量的 2 到 n 维。
--If you do this with a two-layer network, 00:51:24,400 --> 00:51:29,400
如果你用一个两层网络这样做，
--but if you do it even with a log n layer network 00:51:29,400 --> 00:51:32,400
但是如果你甚至使用 log n 层网络也这样做
--where n's the size of the string, 00:51:32,400 --> 00:51:33,400
其中 n 是字符串的大小，
--you can do it in only order n number of hidden units, 00:51:33,400 --> 00:51:40,400
你可以只订购 n 个隐藏单元，
--basically dimensionality. 00:51:40,400 --> 00:51:41,400
基本上是维度。
--So you can get an exponential savings 00:51:41,400 --> 00:51:43,400
所以你可以获得指数级的节省
--in the representation of this function. 00:51:43,400 --> 00:51:46,400
在这个函数的表示中。
--And this is true, but I think it's a bad example 00:51:46,400 --> 00:51:49,400
这是真的，但我认为这是一个不好的例子
--because parity is famously a function 00:51:49,400 --> 00:51:52,400
因为奇偶校验是一个著名的函数
--that neural networks are really, really bad at learning. 00:51:52,400 --> 00:51:56,400
神经网络真的非常不擅长学习。
--Basically gradient descent is horrible 00:51:56,400 --> 00:51:58,400
基本上梯度下降是可怕的
--at learning functions like parity. 00:51:58,400 --> 00:52:00,400
在学习奇偶校验等功能时。
--And so it's great that you have this efficiency 00:52:00,400 --> 00:52:03,400
所以你有这种效率真是太好了
--kind of argument, 00:52:03,400 --> 00:52:04,400
一种论点，
--but this is not necessarily indicative of the way 00:52:04,400 --> 00:52:07,400
但这不一定表示方式
--and the kind of networks 00:52:07,400 --> 00:52:08,400
和网络的种类
--that are actually learned in practice. 00:52:08,400 --> 00:52:10,400
实际上是在实践中学到的。
--And so the argument that I really actually think 00:52:10,400 --> 00:52:12,400
所以我真正认为的论点
--is honestly best 00:52:12,400 --> 00:52:13,400
老实说是最好的
--is just that empirically, 00:52:13,400 --> 00:52:14,400
只是根据经验，
--if we look at sort of a fixed size parameter count, 00:52:14,400 --> 00:52:17,400
如果我们看一下固定大小的参数计数，
--so we have a certain amount of parameters we can store, 00:52:17,400 --> 00:52:21,400
所以我们有一定数量的参数可以存储，
--and it seems like it is better 00:52:21,400 --> 00:52:24,400
似乎更好
--to have some depth to our networks, 00:52:24,400 --> 00:52:26,400
对我们的网络有一定的深度，
--especially when we have structured networks 00:52:26,400 --> 00:52:29,400
特别是当我们有结构化网络时
--like convolutional networks 00:52:29,400 --> 00:52:30,400
像卷积网络
--or recurrent networks 00:52:30,400 --> 00:52:31,400
或循环网络
--or transformer networks 00:52:31,400 --> 00:52:33,400
或变压器网络
--as we'll talk about later in this class, 00:52:33,400 --> 00:52:35,400
正如我们稍后将在本课程中讨论的那样，
--this seems much better 00:52:35,400 --> 00:52:37,400
这看起来好多了
--than if you just have a single layer. 00:52:37,400 --> 00:52:40,400
比起只有一层。
--Okay. 00:52:40,400 --> 00:52:41,400
好的。
--So this is the final sort of setting here. 00:52:41,400 --> 00:52:45,400
所以这是这里的最后一种设置。
--And essentially it is the least satisfying 00:52:45,400 --> 00:52:50,400
本质上它是最不令人满意的
--but probably most realistic description 00:52:50,400 --> 00:52:53,400
但可能是最现实的描述
--about why we actually use 00:52:53,400 --> 00:52:55,400
关于我们实际使用的原因
--multilayer neural networks in practice. 00:52:55,400 --> 00:52:58,400
多层神经网络在实践中。
--All right. 00:52:59,400 --> 00:53:00,400
好的。
--So this is actually a good sort of pausing point 00:53:00,400 --> 00:53:02,400
所以这实际上是一个很好的暂停点
--for the kind of first half of this lecture. 00:53:02,400 --> 00:53:05,400
对于本讲前半部分的那种。
--But now I'm going to sort of dive in 00:53:05,400 --> 00:53:08,400
但现在我要潜入
--in the next half of this lecture, 00:53:08,400 --> 00:53:10,400
在本次讲座的下半部分，
--and maybe we'll even break this up 00:53:10,400 --> 00:53:11,400
也许我们甚至会打破它
--into two separate videos 00:53:11,400 --> 00:53:12,400
分为两个独立的视频
--just for the sake of it. 00:53:12,400 --> 00:53:14,400
只是为了它。
--Now I'm going to talk about 00:53:15,400 --> 00:53:19,400
现在我要谈谈
--how we train networks 00:53:19,400 --> 00:53:22,400
我们如何训练网络
--like the ones you saw before, 00:53:22,400 --> 00:53:24,400
就像你之前看到的那些，
--both actually the two-layer case 00:53:24,400 --> 00:53:26,400
实际上都是双层的情况
--and the general L-layer case, 00:53:26,400 --> 00:53:28,400
和一般的 L 层情况，
--using gradient descent, 00:53:28,400 --> 00:53:31,400
使用梯度下降，
--which necessitates that we find a way 00:53:31,400 --> 00:53:33,400
这需要我们找到一种方法
--of computing these gradients, 00:53:33,400 --> 00:53:34,400
计算这些梯度，
--and that will lead us to an algorithm 00:53:34,400 --> 00:53:35,400
这将引导我们找到一个算法
--we call backpropagation. 00:53:35,400 --> 00:53:37,400
我们称之为反向传播。
