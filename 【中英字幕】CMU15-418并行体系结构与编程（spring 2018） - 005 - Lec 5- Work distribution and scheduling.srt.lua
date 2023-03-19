--All right, so welcome back. 00:00:00,000 --> 00:00:05,000
好的，欢迎回来。
--So today, we are actually going to move the recitation to Monday. 00:00:05,000 --> 00:00:10,000
所以今天，我们实际上要把朗诵移到星期一。
--That's what's going to happen today. 00:00:10,000 --> 00:00:12,000
这就是今天要发生的事情。
--So today is just going to be a normal lecture. 00:00:12,000 --> 00:00:15,000
所以今天只是一个普通的讲座。
--We'll talk more about parallel programming. 00:00:15,000 --> 00:00:17,000
我们将更多地讨论并行编程。
--Okay, so where we left off was on Wednesday, we were just, we looked at examples of functional parallel programs. 00:00:17,000 --> 00:00:27,000
好吧，我们在星期三停下来，我们只是看了函数式并行程序的例子。
--We looked at the grid solver, which was a simplified version of the ocean simulation. 00:00:28,000 --> 00:00:33,000
我们查看了网格求解器，它是海洋模拟的简化版本。
--And we saw some basic parallel code in data parallel, shared address space, and message passing frameworks. 00:00:33,000 --> 00:00:41,000
我们在数据并行、共享地址空间和消息传递框架中看到了一些基本的并行代码。
--Okay, so today, actually today and then on Wednesday, so our next regular lecture after the recitation on Monday, we're going to dive into some important issues related to how you get better performance out of the parallel program. 00:00:41,000 --> 00:00:58,000
好的，所以今天，实际上是今天，然后是星期三，所以我们在星期一的背诵之后的下一次常规讲座，我们将深入探讨一些与如何从并行程序中获得更好的性能相关的重要问题。
--So today, we're sort of dividing that overall topic into two parts. 00:01:08,000 --> 00:01:14,000
所以今天，我们将整个主题分为两部分。
--So part one today, which we'll cover today, is we're going to talk about how you divide up the work and schedule it on the processors. 00:01:14,000 --> 00:01:22,000
所以今天的第一部分，我们今天将要讨论的是，我们将讨论如何划分工作并将其安排在处理器上。
--And then on Wednesday, we'll talk about how we, issues about communication and locality and how we want to do things to optimize the performance of that also. 00:01:22,000 --> 00:01:31,000
然后在星期三，我们将讨论有关沟通和本地化的问题，以及我们希望如何做事来优化其性能。
--Okay, so one of the things I mentioned before is that parallel programming is a very iterative process, meaning you're very unlikely to get it right the first time. 00:01:33,000 --> 00:01:43,000
好吧，我之前提到的一件事是并行编程是一个非常迭代的过程，这意味着您不太可能第一次就把它做对。
--In fact, you probably won't even get it right the second time or maybe even the third time. 00:01:43,000 --> 00:01:47,000
事实上，您甚至可能不会第二次甚至第三次都做对。
--So as you do the assignments, you'll get to experience the fact that you need to, it's really important that you measure performance and learn things from those measurements and use the insights from that to improve things. 00:01:47,000 --> 00:02:04,000
所以当你做作业时，你会体验到你需要的事实，衡量绩效并从这些衡量中学习东西并利用从中获得的见解来改进事情是非常重要的。
--Okay, even better. 00:02:04,000 --> 00:02:06,000
好吧，甚至更好。
--Okay, so here are a couple of goals that we're trying to accomplish here. 00:02:06,000 --> 00:02:11,000
好的，这里有几个我们正在努力实现的目标。
--So, and we're going to focus on really the first one mostly today, which is we want to balance the work across all of the different threads so that they have the same amount of work to do. 00:02:11,000 --> 00:02:23,000
因此，我们今天主要关注第一个问题，即我们希望平衡所有不同线程之间的工作，以便它们有相同数量的工作要做。
--And sometimes that's easy and sometimes it's difficult. 00:02:23,000 --> 00:02:26,000
有时这很容易，有时却很困难。
--So that's, that's our major theme for today. 00:02:26,000 --> 00:02:28,000
这就是我们今天的主题。
--At the same time, we want to minimize communication because communicating is expensive. 00:02:28,000 --> 00:02:35,000
同时，我们希望尽量减少沟通，因为沟通很昂贵。
--So we prefer to communicate as. 00:02:35,000 --> 00:02:37,000
所以我们更喜欢交流为。
--And then finally, we have to worry about the fact that not only communicating, but trying to be clever in any way to optimize the code often involves running more instructions in the program and that software overhead will also slow things down. 00:02:38,000 --> 00:02:53,000
最后，我们不得不担心这样一个事实，不仅是沟通，而且试图以任何方式聪明地优化代码通常涉及在程序中运行更多的指令，而且软件开销也会减慢速度。
--So that's another source of overhead. 00:02:53,000 --> 00:02:56,000
所以这是另一个开销来源。
--Okay, so our number one, you know, pro tip here is when you're trying to write parallel software for an assignment or for your project or anything, always start by implementing the simplest thing that might work first. 00:02:57,000 --> 00:03:15,000
好吧，所以我们的第一个，你知道，这里的专业提示是当你试图为一项任务或你的项目或任何东西编写并行软件时，总是从实现最简单的事情开始，这可能首先起作用。
--So it may be very tempting to start off by dreaming up some really creative, complicated solution, which you think might be very clever and make a very good performance. 00:03:15,000 --> 00:03:26,000
因此，从构思一些真正有创意、复杂的解决方案开始可能非常诱人，您认为这些解决方案可能非常聪明并且表现出色。
--But it's very likely, as I said, that the first thing that you try won't work very well. 00:03:26,000 --> 00:03:31,000
但正如我所说，您尝试的第一件事很可能不会奏效。
--So what you can do is get a measurement. 00:03:31,000 --> 00:03:34,000
所以你能做的就是测量一下。
--Use that measurement to learn what you need to tune and change when you do the second version. 00:03:34,000 --> 00:03:39,000
使用该度量来了解在执行第二个版本时需要调整和更改的内容。
--So since your goal is to get a good measurement as soon as possible, then you want to start with something simple where, first of all, if it's simple, you can implement it faster and get that measurement earlier. 00:03:39,000 --> 00:03:50,000
因此，由于您的目标是尽快获得良好的测量结果，因此您希望从简单的事情开始，首先，如果它很简单，您可以更快地实施它并更早地获得测量结果。
--And second, it'll be easier to understand how to interpret the measurement if the thing that you're measuring is relatively simple. 00:03:50,000 --> 00:03:58,000
其次，如果你测量的东西相对简单，就更容易理解如何解释测量结果。
--And then go from there. 00:03:58,000 --> 00:04:00,000
然后从那里去。
--If you need to make it more sophisticated, then you have a much better starting point at that point. 00:04:00,000 --> 00:04:05,000
如果你需要让它更复杂，那么你在那个时候就有了一个更好的起点。
--Okay, so one of the things we're going to be worrying about today is balancing the workload. 00:04:05,000 --> 00:04:13,000
好的，所以我们今天要担心的事情之一就是平衡工作量。
--So again, as we saw in the very first class, when we had the four volunteers up in the front of the room, when the workload is not balanced evenly, then some processors will end up sitting around doing nothing, waiting for other processors to finish. 00:04:13,000 --> 00:04:30,000
因此，正如我们在第一节课上看到的那样，当我们让四个志愿者坐在教室前面时，当工作量不平衡时，一些处理器最终会无所事事，等待其他处理器结束。
--So, in fact, even if you get this almost completely right but not quite right, it can be very costly. 00:04:30,000 --> 00:04:38,000
所以，事实上，即使你几乎完全正确但不是完全正确，它也可能会非常昂贵。
--So, for example, here we have four processors. 00:04:38,000 --> 00:04:43,000
因此，例如，这里我们有四个处理器。
--And you might think we've done a fairly good job of balancing the workload because they're all within 20% of each other. 00:04:43,000 --> 00:04:50,000
您可能会认为我们在平衡工作量方面做得相当好，因为它们彼此相差不到 20%。
--In fact, the first three were exactly the same. 00:04:50,000 --> 00:04:53,000
事实上，前三个是完全一样的。
--And it's just this fourth one that's just taking a little bit longer. 00:04:53,000 --> 00:04:57,000
只是这第四个需要更长的时间。
--But while it's taking that little bit of longer time, that's hurting performance because all the other processors don't have anything to do. 00:04:57,000 --> 00:05:04,000
但是，虽然它花费了一点点时间，但它会损害性能，因为所有其他处理器都无事可做。
--So we really want to try to balance the workload as evenly as possible. 00:05:04,000 --> 00:05:11,000
所以我们真的想尝试尽可能均衡地平衡工作量。
--Okay, so I'm going to talk about different strategies for dividing up the work and trying to balance the workload. 00:05:11,000 --> 00:05:19,000
好的，所以我要谈谈划分工作和尝试平衡工作量的不同策略。
--And the first approach is what we call static assignment. 00:05:19,000 --> 00:05:24,000
第一种方法就是我们所说的静态赋值。
--So the idea here is that we decide up front how we're going to divide up the work across all the processors. 00:05:24,000 --> 00:05:32,000
所以这里的想法是我们预先决定我们将如何在所有处理器之间分配工作。
--So we saw an example of this on Wednesday for the grid solver. 00:05:32,000 --> 00:05:38,000
所以我们在星期三看到了一个关于网格求解器的例子。
--We divided the work up in the code that we finally looked at at the end. 00:05:38,000 --> 00:05:43,000
我们把工作分成了我们最后看到的代码。
--We used this type of block assignment. 00:05:43,000 --> 00:05:46,000
我们使用了这种类型的块分配。
--And we also discussed having an interleaved assignment. 00:05:46,000 --> 00:05:51,000
我们还讨论了交错作业。
--And there were some tradeoffs between the two of those things. 00:05:51,000 --> 00:05:54,000
这两件事之间有一些权衡。
--But in either case, we've written into our code already the logic for assigning the computation this way. 00:05:54,000 --> 00:06:02,000
但无论哪种情况，我们都已经将以这种方式分配计算的逻辑写入代码中。
--So it will always assign it this way to the processors. 00:06:02,000 --> 00:06:07,000
所以它总是会以这种方式将它分配给处理器。
--So it's determined ahead of time. 00:06:07,000 --> 00:06:09,000
所以提前决定了。
--Now, when I say it's determined ahead of time, there may still be a little bit of computation that occurs when the program runs because you may need to know the size of the input file, the size of the matrix, or something like that, and probably the number of processors, and do a little bit of computation based on that. 00:06:09,000 --> 00:06:26,000
现在，当我说它提前确定时，程序运行时可能仍然会发生一些计算，因为您可能需要知道输入文件的大小、矩阵的大小或类似的东西，可能还有处理器的数量，并在此基础上进行一些计算。
--But when you get to the point of actually doing the parallel work, you already have figured out exactly how everything's being carved up. 00:06:26,000 --> 00:06:34,000
但是，当您真正进行并行工作时，您已经确切地弄清楚了所有内容是如何被分割的。
--Okay, now, the nice thing about this, the big selling point of static assignment is that it has close to zero runtime overhead. 00:06:34,000 --> 00:06:45,000
好的，现在，这件事的好处是，静态赋值的最大卖点是它的运行时开销几乎为零。
--Because since you've already decided ahead of time how you're dividing up the work, there's not any extra work that you need to do while the program is running to think about this problem because you've already finished thinking about it. 00:06:45,000 --> 00:06:58,000
因为你已经提前决定好如何分工了，所以在程序运行的时候你不需要做任何额外的工作来思考这个问题，因为你已经思考完了。
--So that's the big advantage of this approach. 00:06:58,000 --> 00:07:02,000
这就是这种方法的一大优势。
--Okay, so that's a big advantage. 00:07:02,000 --> 00:07:06,000
好吧，这是一个很大的优势。
--What would be a disadvantage of this approach? When would you not want to do this? One of those assignments unexpectedly takes longer than you're stuck with it. 00:07:06,000 --> 00:07:19,000
这种方法的缺点是什么？你什么时候不想这样做？其中一项任务出乎意料地花费了比你坚持它更长的时间。
--Right, so in the grid solver, it turned out that the computation was identical across all the elements. 00:07:19,000 --> 00:07:27,000
是的，所以在网格求解器中，结果证明所有元素的计算都是相同的。
--And there may be cache misses, and who knows, maybe even page faults or things like that that may cause some of the memory accesses to take a little longer than other things. 00:07:27,000 --> 00:07:35,000
并且可能存在缓存未命中，谁知道呢，甚至可能是页面错误或类似的事情可能导致某些内存访问比其他事情花费更长的时间。
--But basically, we would expect it to be very uniform across all the computation. 00:07:35,000 --> 00:07:41,000
但基本上，我们希望它在所有计算中都非常统一。
--But that might not always be the case. 00:07:41,000 --> 00:07:44,000
但情况可能并非总是如此。
--So, okay, so we'll get to what you do in a minute. 00:07:44,000 --> 00:07:47,000
所以，好吧，我们会在一分钟内了解您的工作。
--I'll talk about what you do when you can't do a good job with static assignment. 00:07:47,000 --> 00:07:52,000
我就说说静态赋值搞不好的时候怎么办。
--But first, I want to just talk a little more about when we can apply static assignment or something very similar to it. 00:07:52,000 --> 00:08:01,000
但首先，我想多谈谈何时可以应用静态赋值或类似的东西。
--Because it's very low runtime overhead is very appealing. 00:08:01,000 --> 00:08:05,000
因为它非常低的运行时开销非常吸引人。
--So the key thing that we need in order for this to work is that the runtimes of the tasks need to be predictable. 00:08:05,000 --> 00:08:14,000
因此，为了使它起作用，我们需要的关键是任务的运行时间需要是可预测的。
--Now, let's see. 00:08:14,000 --> 00:08:17,000
现在，让我们看看。
--Now, the easiest way for them to be predictable is if they're all the same. 00:08:17,000 --> 00:08:21,000
现在，要让它们变得可预测，最简单的方法就是它们是否完全相同。
--So in the grid solver, each computation at each grid point involves identical computations. 00:08:21,000 --> 00:08:27,000
所以在网格求解器中，每个网格点的每个计算都涉及相同的计算。
--So, again, modulo cache misses or communication related to that, we would expect every task to take basically the same amount of time. 00:08:27,000 --> 00:08:37,000
因此，同样，模缓存未命中或与之相关的通信，我们希望每个任务花费的时间基本相同。
--So that's an easy case. 00:08:37,000 --> 00:08:39,000
所以这是一个简单的案例。
--So if that's the case, this is fairly easy to think about it. 00:08:39,000 --> 00:08:43,000
所以如果是这样的话，这很容易考虑。
--Then it's just a matter of assigning the same number of tasks to each processor. 00:08:43,000 --> 00:08:49,000
然后只需为每个处理器分配相同数量的任务即可。
--So, for example, if you have 12 tasks and 4 processors, then each of them will just get 3 tasks. 00:08:49,000 --> 00:08:57,000
因此，例如，如果您有 12 个任务和 4 个处理器，那么每个处理器将只获得 3 个任务。
--And we expect that that should work out fairly well. 00:08:57,000 --> 00:09:01,000
我们希望这能很好地解决问题。
--Okay. 00:09:01,000 --> 00:09:02,000
好的。
--Now, I said predictable. 00:09:02,000 --> 00:09:04,000
现在，我说的是可预测的。
--They don't necessarily have to be identical, though, if you have a relatively inexpensive way to think about how long the different tasks will take. 00:09:04,000 --> 00:09:15,000
但是，如果您有一种相对便宜的方法来考虑不同任务需要多长时间，则它们不一定必须相同。
--So let's, just as a really simple example, imagine that there's some input parameter to the task, and you can very quickly predict the execution time based on that. 00:09:15,000 --> 00:09:25,000
因此，让我们举一个非常简单的例子，假设任务有一些输入参数，您可以根据它非常快速地预测执行时间。
--Let's say maybe it's just linear with respect to some parameter or something like that. 00:09:25,000 --> 00:09:30,000
假设它可能只是关于某些参数或类似参数的线性关系。
--So in this case, they may be different, but you have a good way to predict how long they're going to take. 00:09:30,000 --> 00:09:36,000
所以在这种情况下，它们可能不同，但您有一个很好的方法来预测它们将花费多长时间。
--So here we see there are a lot of different tasks of different sizes, but if they're predictable, then we have to do a little more work to make this work out. 00:09:36,000 --> 00:09:45,000
所以在这里我们看到有很多不同规模的不同任务，但如果它们是可预测的，那么我们必须做更多的工作才能完成这项工作。
--But you could potentially pack them together so that if you add up the expected time for all the tasks assigned to each processor, hopefully it will all balance out, like in this picture here. 00:09:45,000 --> 00:10:00,000
但是你可以将它们打包在一起，这样如果你将分配给每个处理器的所有任务的预期时间加起来，希望它会全部平衡，就像这里的这张照片一样。
--Okay. 00:10:00,000 --> 00:10:01,000
好的。
--So this may not be perfect, but again, the big advantage is very little runtime overhead. 00:10:01,000 --> 00:10:06,000
所以这可能并不完美，但同样，最大的优势是运行时开销非常小。
--So we're willing to give up maybe just a little bit of load and balance if we win more than that back with very low runtime overhead. 00:10:06,000 --> 00:10:15,000
因此，如果我们以非常低的运行时开销赢得更多的回报，我们愿意放弃可能只是一点点的负载和平衡。
--Okay. 00:10:15,000 --> 00:10:16,000
好的。
--So here's one of these really good things to know about on this slide that you may not guess ordinarily, which is I'm going to talk about in a minute, I'm going to talk about dynamic assignment, where you are fairly frequently making decisions about how to balance the work. 00:10:16,000 --> 00:10:33,000
因此，在这张幻灯片上，有一个你可能通常猜不到的非常好的事情要知道，我稍后会谈到，我将要谈论动态分配，你经常在其中做关于如何平衡工作的决定。
--But there's something in between, which is called semi-static, which is a very good trick to know about. 00:10:33,000 --> 00:10:39,000
但是介于两者之间的东西称为半静态，这是一个非常好的技巧。
--The idea here is that in many systems, if you're, say, doing a simulation over time steps, although the amount of work per task may be changing over time, and that may seem like it's hopelessly difficult to do it statically, it may be the case that that work is changing relatively slowly. 00:10:39,000 --> 00:11:00,000
这里的想法是，在许多系统中，如果你在时间步长上进行模拟，尽管每个任务的工作量可能会随着时间而变化，而且静态地完成它似乎是无可救药的困难，它可能是这项工作的变化相对缓慢。
--So, for example, on Wednesday, I talked about the Barnes-Hutt galaxy simulation, where we are modeling how stars are moving through galaxies over time, and I said that the amount of work is not uniform, because you do these pairwise comparisons to compute gravitational forces, and if you're in a neighborhood where there are a lot of other stars nearby, then you're going to have to do many more of these comparisons than for a star that's off here more or less by itself, because for the ones that are further away from other stars, it's just going to summarize the mass of these other stars as one big block. 00:11:00,000 --> 00:11:44,000
因此，例如，在星期三，我谈到了 Barnes-Hutt 星系模拟，我们正在模拟恒星如何随时间穿过星系，我说工作量并不统一，因为你进行这些成对比较计算引力，如果你所在的社区附近有很多其他恒星，那么你将不得不做更多的这些比较，而不是对一颗或多或少单独离开这里的恒星进行比较，因为对于离其他恒星较远的那些，它只是将这些其他恒星的质量概括为一个大块。
--Okay, so the amount of work is non-uniform, and it changes over time because the stars are moving around, but they're not moving that quickly, they're moving relatively slowly. 00:11:44,000 --> 00:11:58,000
好的，所以工作量是不均匀的，它会随着时间的推移而变化，因为星星在四处移动，但它们移动的速度并不快，它们移动得相对较慢。
--So what you can do, the trick with a semi-static technique, is that every now and then, you decide what parameter makes sense, but you profile the time. 00:11:58,000 --> 00:12:10,000
所以你可以做的，半静态技术的诀窍，是时不时地，你决定什么参数有意义，但你分析时间。
--Now, that doesn't necessarily mean you do expensive CPU wall-clock profiling, maybe you do something simple like recording how many different computations you had to, how many different stars did I have to compare against for a particular star. 00:12:10,000 --> 00:12:27,000
现在，这并不一定意味着你要做昂贵的 CPU 挂钟分析，也许你做一些简单的事情，比如记录你必须进行多少次不同的计算，我必须与多少颗不同的星星进行比较才能得到一颗特定的星星。
--So you capture some number that will allow you to estimate execution time, and then you then divide up the work based on that, and then for some number of iterations, you basically proceed as though it's a static schedule. 00:12:27,000 --> 00:12:42,000
因此，您捕获了一些可以让您估算执行时间的数字，然后您可以根据该数字划分工作，然后对于一些迭代次数，您基本上可以像静态计划一样继续进行。
--So you don't revisit how to schedule things for a while, and then after some amount of time goes by, you go back, and then you re-instrument things, and you measure them, and then you possibly change the partitioning. 00:12:42,000 --> 00:12:56,000
所以你暂时不会重新考虑如何安排事情，然后在一段时间过去后，你回去，然后你重新检测事情，测量它们，然后你可能会改变分区。
--So galaxy simulation is one example. 00:12:56,000 --> 00:12:59,000
所以星系模拟就是一个例子。
--There are a lot of other things in physical simulations. 00:12:59,000 --> 00:13:03,000
物理模拟中还有很多其他的东西。
--For example, if you're modeling aircraft in a wind tunnel, things are moving around and changing a bit, but they tend not to change so radically that this technique is likely to still be useful in that case. 00:13:03,000 --> 00:13:19,000
例如，如果您在风洞中为飞机建模，事物会四处移动并发生一些变化，但它们往往不会发生根本性变化，以至于这种技术在这种情况下可能仍然有用。
--So this is a sort of midway point, but you can think of it as static scheduling over some fixed time period, and then you go back, and then you rethink how you're going to reschedule the assignment, that is. 00:13:19,000 --> 00:13:33,000
所以这是一种中间点，但你可以把它看作是某个固定时间段内的静态调度，然后你回去，然后你重新考虑你将如何重新安排任务，也就是说。
--Okay, so that's static scheduling. 00:13:33,000 --> 00:13:35,000
好的，这就是静态调度。
--The other major option is dynamic scheduling. 00:13:35,000 --> 00:13:39,000
另一个主要选项是动态调度。
--You probably could have guessed that. 00:13:39,000 --> 00:13:41,000
你可能已经猜到了。
--So the idea here is that as the program is running, the different threads are grabbing work as they need. 00:13:41,000 --> 00:13:51,000
所以这里的想法是，随着程序的运行，不同的线程会根据需要获取工作。
--That's effectively what it means. 00:13:51,000 --> 00:13:53,000
这实际上就是它的意思。
--So this is dynamically balancing out the assignment of tasks to processors. 00:13:53,000 --> 00:13:59,000
所以这是动态地平衡分配给处理器的任务。
--So as one simple example of how you might code this up, if you had just a sequential program where you have a loop, and the different iterations are independent of each other, and those are our tasks. 00:13:59,000 --> 00:14:16,000
因此，作为一个如何编写代码的简单示例，如果您只有一个顺序程序，其中有一个循环，并且不同的迭代彼此独立，这就是我们的任务。
--So we could do it statically. 00:14:16,000 --> 00:14:19,000
所以我们可以静态地做。
--We could just do it blockwise or interleave it, but if we want to do it dynamically, we might do something like this. 00:14:19,000 --> 00:14:25,000
我们可以按块或交错来做，但如果我们想动态地做，我们可能会做这样的事情。
--So we will have some counter, and this will be a variable, and this is actually effectively the loop index. 00:14:25,000 --> 00:14:35,000
所以我们会有一些计数器，这将是一个变量，这实际上是循环索引。
--So when a thread wants a loop index, it's going to go read this counter and increment it, and we have to put a lock around that or use some other kind of atomic instruction so that it doesn't get corrupted. 00:14:35,000 --> 00:14:48,000
所以当一个线程想要一个循环索引时，它会去读取这个计数器并递增它，我们必须在它周围加一个锁或使用一些其他类型的原子指令，这样它就不会被破坏。
--But each thread will go grab an iteration, and now it will do work. 00:14:48,000 --> 00:14:52,000
但是每个线程都会去获取一个迭代，现在它会工作了。
--And if it turns out that some of the iterations take much longer than other ones, then hopefully this will all balance out in the end, because you only go back and get more work when you're ready to grab more work. 00:14:52,000 --> 00:15:04,000
如果事实证明某些迭代比其他迭代花费的时间长得多，那么希望这一切最终都会平衡，因为只有当您准备好接受更多工作时，您才会返回并获得更多工作。
--So that's one example of how dynamic scheduling works. 00:15:04,000 --> 00:15:10,000
这就是动态调度如何工作的一个例子。
--And this has a big advantage, which is it works when the amount of execution time is unpredictable and is likely to vary, and you can't really predict the time very well. 00:15:10,000 --> 00:15:22,000
这有一个很大的优势，那就是当执行时间量不可预测并且可能会发生变化时，它会起作用，而且您无法真正很好地预测时间。
--Okay. 00:15:22,000 --> 00:15:25,000
好的。
--Any concerns about this picture on the right, though? Actually, just a related question. 00:15:25,000 --> 00:15:30,000
不过，对右边的这张照片有什么顾虑吗？实际上，只是一个相关的问题。
--Sure. 00:15:30,000 --> 00:15:31,000
当然。
--In ISPC, when you launch tasks, so you use multiple cores, does it dynamically allocate the tasks to cores? Yes. 00:15:31,000 --> 00:15:40,000
在 ISPC 中，当您启动任务时，您使用多个内核，它是否动态地将任务分配给内核？是的。
--So it's not statically doing that? That's right. 00:15:40,000 --> 00:15:43,000
所以它不是静态地这样做？这是正确的。
--I mean, the language doesn't – well, the implementation does it dynamically. 00:15:43,000 --> 00:15:47,000
我的意思是，语言不会——好吧，实现是动态的。
--The abstraction doesn't actually dictate how it does it, but the implementation happens to do it dynamically. 00:15:47,000 --> 00:15:55,000
抽象实际上并没有规定它是如何做的，但实现恰好是动态地做的。
--So when one core finishes what it's doing, it'll grab the next? Yep. 00:15:55,000 --> 00:15:59,000
所以当一个核心完成它正在做的事情时，它会抓住下一个？是的。
--That's right. 00:15:59,000 --> 00:16:00,000
这是正确的。
--Okay. 00:16:00,000 --> 00:16:01,000
好的。
--So, okay. 00:16:01,000 --> 00:16:03,000
所以，好吧。
--About this specific code here on the right, if you look at this and think about performance, does anything concern you here? Okay. 00:16:03,000 --> 00:16:17,000
关于右边这个特定的代码，如果你看看这个并考虑性能，这里有什么你关心的吗？好的。
--Actually, hold that thought. 00:16:17,000 --> 00:16:18,000
实际上，请保持这种想法。
--I realize I have a good follow-up slide and two slides. 00:16:18,000 --> 00:16:21,000
我意识到我有一张很好的跟进幻灯片和两张幻灯片。
--Before I get to that, that code is showing the work as loop iterations, but more generally, if you have things that aren't necessarily loop iterations, you may have to have a data structure or something that describes a piece of work. 00:16:21,000 --> 00:16:38,000
在我开始之前，该代码将工作显示为循环迭代，但更一般地说，如果您有一些不一定是循环迭代的东西，您可能必须有一个数据结构或描述某项工作的东西。
--And, for example, the stars. 00:16:38,000 --> 00:16:43,000
并且，例如，星星。
--Okay, the stars in the galaxy simulation. 00:16:43,000 --> 00:16:45,000
好的，银河模拟中的星星。
--Each one of these is a little node in a graph or in that octree or quadtree data structure, and we want to go visit all the nodes. 00:16:45,000 --> 00:16:54,000
其中每一个都是图中或八叉树或四叉树数据结构中的一个小节点，我们想要访问所有节点。
--So the way you can think of this is that we take all of the stars, if we want to do it dynamically, purely dynamically, we would have little data structures that would describe each of these tasks, and we could put them all into some work queue. 00:16:54,000 --> 00:17:09,000
所以你可以这么想，我们把所有的星星都拿走，如果我们想动态地做，纯粹动态地，我们会有很少的数据结构来描述这些任务中的每一个，我们可以把它们全部放入一些工作队列。
--So think of a big queue, throw all the work into the queue, and now you have worker threads. 00:17:09,000 --> 00:17:16,000
所以想想一个大队列，把所有的工作都扔进队列，现在你有了工作线程。
--So if we have, say, four cores and each one has a thread, then when they want some work, they'll go find something in the queue, and they'll just go grab something out of the queue. 00:17:16,000 --> 00:17:27,000
因此，如果我们有四个核心，每个核心都有一个线程，那么当他们需要一些工作时，他们会去队列中寻找一些东西，然后他们就会从队列中抓取一些东西。
--So that's another way to think of this. 00:17:27,000 --> 00:17:32,000
所以这是另一种思考方式。
--So, all right, now I'll get back to my question before. 00:17:32,000 --> 00:17:37,000
那么，好吧，现在我将回到我之前的问题。
--Any concerns about this performance-wise? Functionally, this is fine. 00:17:37,000 --> 00:17:41,000
对这种性能有任何担忧吗？从功能上讲，这很好。
--But how fast do you think this will run? I'm not looking for an exact number. 00:17:41,000 --> 00:17:48,000
但是你认为这会运行多快？我不是在寻找确切的数字。
--If you look at this, is there something that makes you, if you ran this and it was surprisingly slow, that might make sense to you. 00:17:48,000 --> 00:17:57,000
如果你看看这个，有什么东西让你，如果你运行这个并且它出奇地慢，那对你来说可能是有意义的。
--And why might that be? Yeah? If the tasks are taking roughly the same amount of time, there's going to be a lot of threads pending for that lock, so they can't get more work until a certain thread. 00:17:57,000 --> 00:18:07,000
为什么会这样？是的？如果这些任务花费的时间大致相同，那么将会有很多线程等待该锁，因此在某个线程之前它们无法获得更多工作。
--Right, so the question is, how long is it going to really take to do the work for a task? So we're giving each, the task size is one iteration in this case, and if that work, for test primality, if that just takes a very small amount of time, then almost immediately you're going to go back and ask for another task. 00:18:07,000 --> 00:18:31,000
是的，所以问题是，完成一项任务真正需要多长时间？所以我们给每一个，在这种情况下，任务大小是一次迭代，如果这有效，对于测试素数，如果这只需要很少的时间，那么几乎立即你会回去要求另一个任务。
--And when you do that, there's a lock that's protecting that structure. 00:18:31,000 --> 00:18:35,000
当你这样做时，会有一把锁保护那个结构。
--So we could end up in a situation where the threads are frequently contending for each other or spending a lot of time trying to grab locks. 00:18:35,000 --> 00:18:44,000
因此，我们最终可能会遇到这样一种情况，即线程经常相互争用或花费大量时间尝试获取锁。
--So this is called a fine-grained dynamic assignment, where in the extreme, you know, tasks are normally things that make sense intuitively to the programmer based on what the program's operating on, for example, stars in the galaxy simulation, or something like that, maybe elements in a grid. 00:18:44,000 --> 00:19:09,000
所以这被称为细粒度的动态分配，在极端情况下，你知道，任务通常是程序员根据程序的操作直观地理解的事情，例如，银河系模拟中的恒星，或类似的东西那，也许是网格中的元素。
--So you may start off thinking, okay, here are my tasks. 00:19:09,000 --> 00:19:13,000
所以你可能会开始想，好吧，这是我的任务。
--Throw the tasks into the queue. 00:19:13,000 --> 00:19:15,000
将任务放入队列。
--Let's let it run. 00:19:15,000 --> 00:19:16,000
让我们让它运行。
--Oh, boy, the performance is really disappointing. 00:19:16,000 --> 00:19:18,000
哦，男孩，表现真是令人失望。
--It's not very fast. 00:19:18,000 --> 00:19:20,000
它不是很快。
--But how could we fix this? So for this specific code, is there a simple thing you can do to this to make it faster? Yep. 00:19:20,000 --> 00:19:28,000
但是我们怎么解决这个问题呢？那么对于这个特定的代码，有什么简单的事情可以让它更快吗？是的。
--You could have each, like, instead of computing only one, or checking only one prime, you could have it check, like, five, and then that way they'll ask for locks less frequently. 00:19:28,000 --> 00:19:42,000
你可以让每个，比如，而不是只计算一个，或者只检查一个素数，你可以让它检查，比如，五个，这样他们就不会那么频繁地请求锁。
--Right, yep, that's right. 00:19:42,000 --> 00:19:44,000
对，对，没错。
--So, in fact, before I go and talk about that, so here's just a visualization of, if we're going, if we're doing what's in this code here, and we are only grabbing one iteration at a time, then what you might see if you measured performance over time, so this is time going like this, is that the blue parts are time when it's actually doing useful work, and the white parts may be time when it's trying to go grab something off of the queue, and, or, you know, trying to grab the lock and access the counter, and you see a lot of white sections here, so it's possibly losing a lot of time, and this is all Amdahl's Law sequential time, effectively. 00:19:44,000 --> 00:20:23,000
所以，事实上，在我开始谈论那个之前，这里只是一个可视化，如果我们要这样做，如果我们在这里做这段代码中的事情，并且我们一次只抓取一个迭代，那么会怎样你可能会看到你是否随着时间的推移测量了性能，所以现在是这样的时间，蓝色部分是它实际做有用工作的时间，而白色部分可能是它试图从队列中拿走一些东西的时间，或者，你知道，试图抓住锁并进入柜台，你会看到这里有很多白色部分，所以它可能会浪费很多时间，这实际上是阿姆达尔定律的连续时间。
--It's not useful time. 00:20:23,000 --> 00:20:25,000
这不是有用的时间。
--So, an improvement, as she suggested, is why, instead of grabbing one task, grab up several tasks. 00:20:25,000 --> 00:20:33,000
因此，正如她所建议的那样，一项改进就是为什么不是抓住一项任务，而是抓住多项任务。
--So, like, for example, we could set it to be 5 or 10 or whatever number, and now, when we need work, and we go in and grab something from the counter, we won't just get one iteration, we'll get several iterations, and now we'll walk over all of them. 00:20:33,000 --> 00:20:52,000
所以，例如，我们可以将它设置为 5 或 10 或任何数字，现在，当我们需要工作时，我们进去从柜台拿东西，我们不会只得到一次迭代，我们我们将进行多次迭代，现在我们将遍历所有迭代。
--And then the benefit of this is, well, it makes our tasks larger, so the sort of white part here, where you're wasting time going back and grabbing a new iteration, that happens less frequently. 00:20:52,000 --> 00:21:06,000
然后这样做的好处是，它使我们的任务更大，所以这里的白色部分，你浪费时间返回并抓住新的迭代，这种情况发生的频率较低。
--Okay, so it should decrease that overhead. 00:21:06,000 --> 00:21:10,000
好的，所以它应该减少开销。
--So, what's the downside of doing this? Okay. 00:21:10,000 --> 00:21:16,000
那么，这样做的缺点是什么？好的。
--Of course, you may get the worst workload distribution you're going to have, most likely. 00:21:16,000 --> 00:21:20,000
当然，您很可能会得到最差的工作负载分配。
--Yeah, so if we make our tasks too large, then we may have load imbalance problems. 00:21:20,000 --> 00:21:26,000
是的，所以如果我们让我们的任务太大，那么我们可能会遇到负载不平衡的问题。
--So, what we want is this nice sweet spot in between, where we're spending relatively little overhead going and grabbing tasks, but we haven't made the tasks so big that we start to have load imbalance happening. 00:21:26,000 --> 00:21:40,000
所以，我们想要的是介于两者之间的这个很好的甜蜜点，在那里我们花费相对较少的开销来获取任务，但我们没有让任务变得太大以至于我们开始出现负载不平衡。
--So, this is another really important lesson for parallel programming, which is many novice parallel programmers think, okay, there's static and there's dynamic, and when it's dynamic, a task is something that I grab, but then these programs suffer from a whole lot of runtime overhead. 00:21:40,000 --> 00:22:02,000
所以，这是并行编程的另一个非常重要的教训，许多新手并行程序员认为，好吧，有静态的，也有动态的，当它是动态的时候，任务就是我抓住的东西，但是这些程序会受到很多影响运行时开销。
--So, you should realize that this is a knob, and you can adjust the number of tasks that you grab each time. 00:22:02,000 --> 00:22:09,000
所以，你应该意识到这是一个旋钮，你可以调整每次抓取任务的数量。
--And so, that's a really powerful way to balance the overhead versus load balancing tradeoffs. 00:22:09,000 --> 00:22:17,000
因此，这是平衡开销与负载平衡权衡的一种非常有效的方法。
--Okay, so to summarize what we were just saying, within this spectrum of setting the grain size for dynamic scheduling, on the one hand, we want to have at least, we don't want to have so few tasks or such large tasks that we start to hurt load balance. 00:22:17,000 --> 00:22:38,000
好的，总结一下我们刚才说的，在为动态调度设置粒度的范围内，一方面，我们至少希望，我们不希望有这么少的任务或这么大的任务我们开始损害负载平衡。
--So, that is going to cause you to want to have smaller tasks. 00:22:38,000 --> 00:22:42,000
因此，这将导致您想要完成较小的任务。
--At the same time, we want to minimize overhead, and that will cause you to want to have larger tasks. 00:22:42,000 --> 00:22:48,000
同时，我们希望最小化开销，这会导致您希望拥有更大的任务。
--Like many things in parallel programming, the ends of the spectrum are not good. 00:22:48,000 --> 00:22:52,000
与并行编程中的许多事情一样，频谱的两端并不好。
--It's somewhere in between. 00:22:52,000 --> 00:22:54,000
它介于两者之间。
--There's a sweet spot in the middle, and that's where you want to be. 00:22:54,000 --> 00:22:59,000
中间有一个甜蜜点，那就是你想去的地方。
--Okay, now, for fun, now that we've talked about that, let's look at another scenario here, which is we have, say, a collection of work, and we throw it all into our queue, and it's not predictable, and we enter it into the queue, you know, starting from left to right, you know, so they're all in this order here, and we start handing out tasks, you know, this one gets handed out first, then this one, and this one, and this one, and the last task that we hand out is the one over here on the right. 00:22:59,000 --> 00:23:32,000
好的，现在，为了好玩，既然我们已经讨论过了，让我们看看这里的另一个场景，比如说，我们有一组工作，我们将它们全部放入我们的队列中，这是不可预测的，并且我们把它放入队列中，你知道，从左到右，所以他们在这里都是这样的顺序，我们开始分发任务，你知道，这个先分发，然后这个，这一项，这一项，也是我们交给的最后一项任务，就是右边这一项。
--So, what could go wrong there? Okay, so we may end up with a picture that looks like this. 00:23:32,000 --> 00:23:43,000
那么，那里可能出什么问题了？好的，所以我们最终可能会得到一张看起来像这样的图片。
--So, what happened is we did dynamic scheduling, and our grain size was often maybe okay, but we got a little unlucky, and the last task that we handed out here is going to run for a long time, and then the other processors finished relatively quickly after we started that task, so now everyone has to sit around and wait for that big task to finish. 00:23:43,000 --> 00:24:10,000
所以，发生的事情是我们做了动态调度，我们的粒度通常可能还可以，但是我们有点不走运，我们在这里分发的最后一个任务要运行很长时间，然后其他处理器就完成了在我们开始那个任务之后相对较快，所以现在每个人都必须坐下来等待那个大任务完成。
--So, that was unfortunate. 00:24:11,000 --> 00:24:14,000
所以，那是不幸的。
--So, how can we address this? Well, first of all, if there was a way to break up that big task a bit more, that would be nice, but maybe that's not practical for some reason, maybe there's not a good way to do that. 00:24:14,000 --> 00:24:28,000
那么，我们该如何解决呢？好吧，首先，如果有办法将这个大任务再分解一点，那就太好了，但也许出于某种原因这不切实际，也许没有好的方法来做到这一点。
--Let's see. 00:24:28,000 --> 00:24:29,000
让我们来看看。
--So, what would have been a better way to have handled this queue? The work queue. 00:24:29,000 --> 00:24:38,000
那么，处理这个队列的更好方法是什么？工作队列。
--Maybe you can assign a priority to the tasks and schedule them that way. 00:24:38,000 --> 00:24:45,000
也许您可以为任务分配优先级并以此方式安排它们。
--Yeah, so if we had some way of knowing ahead of time that this was a large task, it would have been better to have handed it out early rather than at the end. 00:24:45,000 --> 00:24:57,000
是的，所以如果我们有办法提前知道这是一项艰巨的任务，那么最好早点把它交出来，而不是在最后交出来。
--So, if we had done the same work and had handed it out first, like to P4 instead of as the last task to P4, then the work could have balanced out just fine. 00:24:57,000 --> 00:25:10,000
因此，如果我们完成了相同的工作并首先将其分发给 P4，而不是作为 P4 的最后一项任务，那么工作可能会很好地平衡。
--It would have turned out that P4 would have spent a while operating on that long task, and meanwhile the other threads would have found other tasks to execute on, and it would have been fine. 00:25:10,000 --> 00:25:21,000
事实证明，P4 会在那个长任务上运行一段时间，同时其他线程会找到其他任务来执行，这样就没问题了。
--So, if you think about it, this is getting a little deep into this topic, but if the task sizes vary, like in this picture, the optimal way to schedule tasks is that early on in the execution, it would be nice to have larger tasks, because really the only time that you need smaller tasks is at the end. 00:25:21,000 --> 00:25:49,000
所以，如果你考虑一下，这个话题有点深入了，但是如果任务大小不同，就像这张图片，安排任务的最佳方式是在执行的早期，最好有更大的任务，因为真正需要小任务的唯一时间是在最后。
--The point of having larger tasks has this advantage that you minimize run time overhead, and that's great until you get to the end and then, uh-oh, you know, the pieces of the puzzle don't fit very nicely anymore, and now I'm wasting some time. 00:25:49,000 --> 00:26:04,000
拥有更大任务的好处是可以最大限度地减少运行时开销，这很好，直到你走到尽头，然后，呃，哦，你知道，拼图的各个部分不再很合适了，现在我在浪费时间。
--So, in a perfect world, you would start with the big tasks, and as you get further and further along, you would start moving to the smaller and smaller tasks. 00:26:04,000 --> 00:26:12,000
所以，在一个完美的世界里，你会从大任务开始，随着你走得越来越远，你会开始转向越来越小的任务。
--So, you'd start with big boulders and end up with little grains of sand, and then it would all hopefully smooth out nicely. 00:26:12,000 --> 00:26:19,000
所以，你会从大石头开始，以小沙粒结束，然后一切都会顺利结束。
--Now, that requires that you have to have some rough knowledge of which ones are bigger or smaller. 00:26:19,000 --> 00:26:26,000
现在，这要求您必须对哪些更大或更小有一些粗略的了解。
--The other way that that insight might be helpful is sometimes you can dynamically adjust the grain size. 00:26:26,000 --> 00:26:32,000
这种洞察力可能有用的另一种方式是有时您可以动态调整粒度。
--So, in our example, a minute ago, I chose a static grain size of 10, but you could imagine that if you could potentially adjust that over time and start with a larger grain size and then move it down to a smaller grain size, possibly as you got closer to the end. 00:26:32,000 --> 00:26:51,000
因此，在我们的示例中，一分钟前，我选择了 10 的静态粒度，但你可以想象，如果你可以随着时间的推移调整它并从较大的粒度开始，然后将其降低到较小的粒度，可能当你接近尾声时。
--Okay. Now, here's another important concept to know about, which is when you actually implement dynamic scheduling, several slides ago, I'll back up, so I showed you this picture, which is, I said, we could take all of our work and throw it into a queue, and when you need to get work, you go to the queue and you get work. 00:26:51,000 --> 00:27:16,000
好的。现在，这是另一个需要了解的重要概念，当你实际实施动态调度时，几张幻灯片之前，我会备份，所以我给你看了这张图片，我说，我们可以把我们所有的工作和把它放到一个队列中，当你需要工作时，你去排队，然后你就可以工作了。
--And I said that going to the queue frequently is bad, but even if we're going to the queue relatively less frequently, maybe we're not going there crazy frequently, but whenever we go there, if it really is one central queue, this has some disadvantages, which is, we have to be communicating with the other threads frequently whenever we do this because there's a lock and somebody else has had the lock most recently and it's going to involve potentially some contention and some overheads. 00:27:16,000 --> 00:27:46,000
我说经常去排队是不好的，但即使我们去排队的频率相对较低，也许我们不会经常去那里疯狂，但无论何时去那里，如果它真的是一个中央队列，这有一些缺点，也就是说，每当我们这样做时，我们都必须经常与其他线程通信，因为有一个锁，而其他人最近获得了锁，这可能会涉及一些争用和一些开销。
--So, an alternative to that is instead of having one queue, we could split up the queues and give each thread its own work queue. 00:27:46,000 --> 00:27:57,000
因此，另一种替代方法是不使用一个队列，而是拆分队列并为每个线程提供自己的工作队列。
--So, this is called a distributed work queue. 00:27:57,000 --> 00:28:00,000
所以，这被称为分布式工作队列。
--So, we take the tasks and we have a queue per processor or hardware thread. 00:28:00,000 --> 00:28:09,000
因此，我们接受任务并且每个处理器或硬件线程都有一个队列。
--So, everyone has their own queue and you start off, you take your best guess at how to divide up this work. 00:28:09,000 --> 00:28:16,000
所以，每个人都有自己的队列，你开始时，你最好猜测如何划分这项工作。
--That didn't look very good. 00:28:16,000 --> 00:28:17,000
那看起来不太好。
--Okay, well, I divided it up three ways. 00:28:17,000 --> 00:28:20,000
好吧，我把它分成三种方式。
--So, anyway, you populate the queues with some work. 00:28:20,000 --> 00:28:24,000
所以，无论如何，你用一些工作来填充队列。
--Maybe I divide that some more. 00:28:24,000 --> 00:28:26,000
也许我再分一点。
--You take your initial guess at how to divide up the work and you spread it across the queues, and then they start running. 00:28:26,000 --> 00:28:34,000
您初步猜测如何划分工作并将其分布在队列中，然后它们开始运行。
--And now, the nice thing initially is, the deal is that the hardware thread will always go to its own queue. 00:28:34,000 --> 00:28:42,000
现在，最初的好处是，硬件线程将始终进入自己的队列。
--And sometimes in these computations, when you're computing on something, it ends up generating more work, more things to put in a queue. 00:28:42,000 --> 00:28:51,000
有时在这些计算中，当你在计算某些东西时，它最终会产生更多的工作，更多的东西要放在队列中。
--So, it will always put those back into its own queue. 00:28:51,000 --> 00:28:54,000
因此，它总是会将那些放回自己的队列中。
--So, for much of the execution, this is wonderful because you have great locality. 00:28:54,000 --> 00:29:00,000
所以，对于大部分的执行来说，这很棒，因为你有很好的地方性。
--You can go to your queue and no one else is contending for your queue. 00:29:00,000 --> 00:29:05,000
你可以去你的队列，没有其他人在争夺你的队列。
--So, it eliminates the problem of having this contention for a shared queue. 00:29:05,000 --> 00:29:10,000
因此，它消除了对共享队列的争用问题。
--Okay, but as you can probably guess, maybe we use dynamic scheduling when it's difficult to do a great job of predicting execution time and carving it up evenly. 00:29:10,000 --> 00:29:23,000
好的，但正如您可能猜到的那样，当很难很好地预测执行时间并将其平均分配时，我们可能会使用动态调度。
--So, there's a good chance that some hardware threads are going to run out of work. 00:29:23,000 --> 00:29:28,000
因此，很有可能某些硬件线程将无法工作。
--And then what do we do? Well, so the simple thing to do would be just sit and wait. 00:29:28,000 --> 00:29:34,000
然后我们怎么办？好吧，所以最简单的事情就是坐下来等待。
--You could have a backup work queue for threads that finish early. 00:29:34,000 --> 00:29:40,000
您可以为提前完成的线程准备一个备份工作队列。
--You'd still have to use the lock thing, but they could pull from that queue while the other threads are still working. 00:29:40,000 --> 00:29:48,000
您仍然必须使用锁定的东西，但他们可以在其他线程仍在工作时从该队列中拉出。
--And because it's likely that not all threads are finished, you'd have less people contending for the locks. 00:29:48,000 --> 00:29:57,000
而且因为很可能并非所有线程都已完成，所以争用锁的人会更少。
--Yeah, so actually, just to maybe try to illustrate what you said, I can imagine creating another queue, like an extra work queue. 00:29:57,000 --> 00:30:07,000
是的，所以实际上，也许只是为了说明您所说的内容，我可以想象创建另一个队列，比如一个额外的工作队列。
--So, maybe I take, I don't know, three quarters of the work and put it in the queues and I set aside a quarter of it in another backup queue. 00:30:07,000 --> 00:30:15,000
所以，也许我不知道，四分之三的工作放在队列中，我把四分之一放在另一个备用队列中。
--You just do it from the other existing work queues. 00:30:32,000 --> 00:30:36,000
您只需从其他现有工作队列中执行即可。
--When a hardware thread runs out of work, it will steal it from the queue of another processor. 00:30:36,000 --> 00:30:42,000
当硬件线程用完工作时，它会从另一个处理器的队列中窃取它。
--So, that means you actually have locks on those queues, but it turns out that for the part of the program, for most of the execution, only one hardware thread is actually using that lock. 00:30:42,000 --> 00:30:56,000
所以，这意味着你实际上在这些队列上有锁，但事实证明，对于程序的一部分，对于大部分执行，只有一个硬件线程实际使用该锁。
--And it turns out, as you'll learn about later in the class, you can cache the lock in your primary cache, and it'll actually have almost no real overhead to go re-lock a queue that you just accessed recently yourself and that no one else has accessed. 00:30:56,000 --> 00:31:11,000
事实证明，正如您稍后将在课程中了解到的那样，您可以将锁缓存在主缓存中，实际上几乎没有真正的开销来重新锁定您最近自己刚刚访问过的队列，并且没有其他人访问过。
--So, it's okay to put the locks in there, but the idea is that we can steal work from other queues when we run out of work. 00:31:11,000 --> 00:31:20,000
所以，把锁放在那里是可以的，但想法是当我们用完工作时，我们可以从其他队列中窃取工作。
--So, in this way, we don't have to sit around and do nothing when we run out of work. 00:31:20,000 --> 00:31:25,000
所以，这样一来，我们就不用在工作用完的时候无所事事了。
--We steal work from other queues. 00:31:25,000 --> 00:31:28,000
我们从其他队列窃取工作。
--Now, stealing work is not totally cheap. 00:31:28,000 --> 00:31:36,000
现在，窃取工作并不便宜。
--That's going to involve some communication and so on. 00:31:36,000 --> 00:31:41,000
这将涉及一些沟通等等。
--But the good news is we don't have to do that until somebody runs out of work. 00:31:41,000 --> 00:31:46,000
但好消息是，在有人失业之前，我们不必这样做。
--So, for hopefully a lot of the execution, we don't have that overhead at all, but we still need to be careful about that overhead once it happens. 00:31:46,000 --> 00:31:54,000
所以，对于很多执行来说，我们根本没有这种开销，但一旦发生这种开销，我们仍然需要小心。
--We don't want to suddenly shift into this super slow mode once we start having to steal work. 00:31:54,000 --> 00:31:59,000
一旦我们开始不得不窃取工作，我们不想突然切换到这种超慢模式。
--Where does the thread steal the work from? That's a good question. 00:31:59,000 --> 00:32:04,000
线程从哪里窃取工作？这是个好问题。
--So, later today, I'm going to talk about Cilk, which is a language that implements this in its runtime system, and it does it randomly. 00:32:04,000 --> 00:32:12,000
因此，今天晚些时候，我将讨论 Cilk，这是一种在其运行时系统中实现此功能的语言，它是随机执行的。
--You could imagine stealing from the thread on your left or something like that and having a cycle, but doing it randomly is actually probably fine. 00:32:12,000 --> 00:32:23,000
你可以想象从你左边的线程或类似的东西中窃取一个循环，但随机地做实际上可能没问题。
--The thing you want to avoid is if you... 00:32:23,000 --> 00:32:25,000
你要避免的事情是，如果你...
--A thing that would be bad, for example, is if everybody said, okay, we're going to steal from thread zero first and then thread one and then thread two. 00:32:25,000 --> 00:32:33,000
例如，如果每个人都说，好吧，我们将首先从线程 0 窃取，然后是线程 1，然后是线程 2，这会很糟糕。
--Then you'd end up creating other imbalances. 00:32:33,000 --> 00:32:36,000
然后你最终会造成其他不平衡。
--So, either random or something that's likely to be evenly distributed. 00:32:36,000 --> 00:32:43,000
因此，随机或可能均匀分布的东西。
--So, a nice thing about this approach compared to the centralized approach is this is a good way to have both good load balancing, because it's dynamic, but also good locality for most of the execution, because until you actually have to start stealing, you're accessing your own work from your own queue. 00:32:43,000 --> 00:33:04,000
所以，与集中式方法相比，这种方法的一个好处是，这是一种既有良好的负载平衡的好方法，因为它是动态的，而且对于大多数执行来说也是很好的局部性，因为在你真正开始窃取之前，你&#39;从您自己的队列中访问您自己的工作。
--So, that's good. 00:33:04,000 --> 00:33:06,000
所以，这很好。
--There are a lot of interesting questions. 00:33:06,000 --> 00:33:08,000
有很多有趣的问题。
--So, it's just asked, which thread should we steal from? Another really interesting question is, how much should we steal? So, should we take one task if you steal work, or more than one task, probably? Yeah, it's better to take more than one task, because if you take one task, odds are you're going to immediately be stealing work again very soon. 00:33:08,000 --> 00:33:35,000
那么，就问了，我们应该从哪个线程窃取呢？另一个非常有趣的问题是，我们应该偷多少？那么，如果你偷了工作，我们应该接一个任务，还是接多个任务？是的，最好接受不止一项任务，因为如果你接受一项任务，你很可能很快就会再次偷工作。
--So, you... 00:33:35,000 --> 00:33:37,000
那么你...
--There can be more than one idle thread. 00:33:38,000 --> 00:33:41,000
可以有多个空闲线程。
--So, we can't allow more than one task to just one thread, because then the other thread could start contending for the other task. 00:33:41,000 --> 00:33:50,000
因此，我们不能只允许一个线程执行多个任务，因为那样的话另一个线程可能会开始争用另一个任务。
--Yeah, so when we truly get to the very end and there's very, very little work left, and it's in one queue, then there is going to be a lot of contention as they're trying to grab it. 00:33:50,000 --> 00:34:00,000
是的，所以当我们真正走到最后，剩下的工作非常非常少，而且它排在一个队列中时，就会有很多争论，因为他们试图抓住它。
--Usually, once threads start stealing, there's usually a decent amount of work in many of the queues. 00:34:00,000 --> 00:34:08,000
通常，一旦线程开始窃取，许多队列中通常会有大量工作。
--So, often what you do is, you take some proportion of the work. 00:34:08,000 --> 00:34:14,000
所以，通常你所做的是，你承担了一部分工作。
--You don't take just, say, half of it, or something like that. 00:34:14,000 --> 00:34:19,000
你不能只拿，比方说，一半，或类似的东西。
--You look at how much work is in the queue. 00:34:19,000 --> 00:34:21,000
你看看队列中有多少工作。
--You don't take one task. 00:34:21,000 --> 00:34:23,000
你不接受一项任务。
--You also don't take all the tasks. 00:34:23,000 --> 00:34:24,000
您也不会承担所有任务。
--That would be bad. 00:34:24,000 --> 00:34:26,000
那会很糟糕。
--That would cause that thread to suddenly run out of work. 00:34:26,000 --> 00:34:28,000
那将导致该线程突然用完工作。
--So, maybe you take some reasonable fraction of the work. 00:34:28,000 --> 00:34:32,000
所以，也许你会承担一些合理的工作。
--That's what you typically do. 00:34:32,000 --> 00:34:34,000
这就是你通常所做的。
--Now, again, at the very, very end, there will be not enough tasks eventually, and then you'll terminate. 00:34:34,000 --> 00:34:41,000
现在，再一次，在非常非常结束时，最终将没有足够的任务，然后您将终止。
--So, speaking of that, that actually... 00:34:41,000 --> 00:34:44,000
所以，说起来，那其实...
--There's a little bit of a slightly non-trivial code there to figure out when you're done, because you're only finished when there are no tasks anywhere. 00:34:44,000 --> 00:34:55,000
那里有一些稍微重要的代码可以确定您何时完成，因为只有在任何地方都没有任务时您才完成。
--So, to figure that out, you have to go look at the queues, all of them, probably. 00:34:55,000 --> 00:35:00,000
因此，要弄清楚这一点，您可能必须查看所有队列。
--Usually, you cycle around through all of them. 00:35:00,000 --> 00:35:03,000
通常，您会循环浏览所有这些内容。
--And the other complication is that sometimes tasks can cause a thread to generate more tasks. 00:35:03,000 --> 00:35:09,000
另一个复杂情况是，有时任务会导致线程生成更多任务。
--So, you may go look at a queue, and it may go put things back in it after you've finished. 00:35:09,000 --> 00:35:14,000
因此，您可以查看队列，它可能会在您完成后将内容放回其中。
--So, there's a little bit of complexity there. 00:35:14,000 --> 00:35:16,000
所以，那里有点复杂。
--But, anyway, this is a solvable problem. 00:35:16,000 --> 00:35:20,000
但是，无论如何，这是一个可以解决的问题。
--So, this idea of having distributed queues with tasks dealing is a powerful mechanism to know about. 00:35:21,000 --> 00:35:28,000
因此，这种让分布式队列处理任务的想法是一种需要了解的强大机制。
--So, this may be really helpful for you later on in the class, either maybe in some of the more advanced programming assignments, or very likely in your project. 00:35:28,000 --> 00:35:38,000
因此，这可能对您以后的课程非常有帮助，可能在一些更高级的编程作业中，或者很可能在您的项目中。
--Okay, so, we're almost done talking about task queues. 00:35:38,000 --> 00:35:41,000
好的，所以，我们几乎完成了对任务队列的讨论。
--But, finally, one last thing to say about them is the things that we put in the queues... 00:35:41,000 --> 00:35:48,000
但是，最后，关于它们的最后一件事是我们放在队列中的东西......
--I said the other day that it's really good when tasks are independent. 00:35:48,000 --> 00:35:54,000
我前几天说过，当任务独立时，它真的很好。
--Ideally, the tasks are completely independent of each other, and we can just do the tasks in any order. 00:35:54,000 --> 00:36:00,000
理想情况下，任务之间是完全独立的，我们可以按任意顺序执行任务。
--But, sometimes, it's very difficult to figure out a way to have fully independent tasks. 00:36:00,000 --> 00:36:05,000
但是，有时很难找到一种方法来完成完全独立的任务。
--So, another thing you can potentially do is have some... 00:36:05,000 --> 00:36:09,000
所以，你可以做的另一件事是有一些......
--You can put information in your data structures where you describe any dependencies between tasks. 00:36:09,000 --> 00:36:16,000
您可以将信息放入数据结构中，在其中描述任务之间的任何依赖关系。
--And then, you only want to pull out tasks where all of their inputs are ready. 00:36:16,000 --> 00:36:20,000
然后，您只想在所有输入都准备就绪的情况下提取任务。
--So, now, the downside is that that adds some more overhead to thinking about that. 00:36:20,000 --> 00:36:25,000
所以，现在，缺点是这会增加一些额外的开销来考虑这个问题。
--But, it's a way to potentially use this approach, even when there are dependencies that you can't eliminate. 00:36:25,000 --> 00:36:32,000
但是，这是一种潜在地使用这种方法的方法，即使存在您无法消除的依赖性。
--Okay, so, this is the first half of today. 00:36:34,000 --> 00:36:37,000
好的，所以，这是今天的上半场。
--We're about to take our intermission break in just a second after this slide. 00:36:37,000 --> 00:36:40,000
放完这张幻灯片后，我们马上就要休息了。
--But, what we saw so far is, in order to do a good job balancing work, we looked at both static and dynamic assignments. 00:36:40,000 --> 00:36:50,000
但是，到目前为止我们看到的是，为了做好平衡工作，我们同时查看了静态和动态分配。
--And, we saw some interesting things. 00:36:50,000 --> 00:36:53,000
而且，我们看到了一些有趣的事情。
--So, first of all, there's something called semi-static, where you periodically measure things and then do something that's effectively static for some period of time. 00:36:53,000 --> 00:37:02,000
所以，首先，有一种叫做半静态的东西，你可以在其中定期测量事物，然后在一段时间内做一些有效静态的事情。
--Then, you go back and do it again. 00:37:02,000 --> 00:37:04,000
然后，你回去再做一次。
--And then, we looked at dynamic assignment. 00:37:05,000 --> 00:37:07,000
然后，我们研究了动态分配。
--We also saw that dynamic assignment doesn't just mean fine-grained dynamic assignment. 00:37:07,000 --> 00:37:12,000
我们还看到动态分配不仅仅意味着细粒度的动态分配。
--It can be arbitrarily coarse-grained. 00:37:12,000 --> 00:37:14,000
它可以是任意粗粒度的。
--In fact, that's a parameter that you can control. 00:37:14,000 --> 00:37:17,000
事实上，这是一个您可以控制的参数。
--And, in an ideal world, things would start out coarse and then maybe get a little finer over time. 00:37:17,000 --> 00:37:22,000
而且，在一个理想的世界里，事情一开始会很粗糙，然后随着时间的推移可能会变得更精细。
--So, okay. 00:37:22,000 --> 00:37:24,000
所以，好吧。
--With that, we'll take our two-minute intermission break. 00:37:24,000 --> 00:37:27,000
这样，我们将进行两分钟的中场休息。
--And, we will start up after that. 00:37:27,000 --> 00:37:29,000
而且，我们将在那之后开始。
--Is the quiz up yet? Oh. 00:37:29,000 --> 00:37:35,000
测验结束了吗？哦。
--Well, we weren't actually because this is in the recitation. 00:37:35,000 --> 00:37:38,000
好吧，我们实际上不是因为这是在朗诵中。
--Okay. 00:37:38,000 --> 00:37:39,000
好的。
--Well, maybe we'll quiz you on that during recitation. 00:37:39,000 --> 00:37:43,000
好吧，也许我们会在背诵时对你进行测验。
--Okay. 00:37:44,000 --> 00:37:45,000
好的。
--No quiz today. 00:37:45,000 --> 00:37:47,000
今天没有测验。
--Okay. 00:38:02,000 --> 00:38:05,000
好的。
--Okay. 00:38:32,000 --> 00:38:35,000
好的。
--Okay. 00:39:02,000 --> 00:39:05,000
好的。
--Okay. 00:39:32,000 --> 00:39:34,000
好的。
--Okay. 00:39:34,000 --> 00:39:36,000
好的。
--Okay. 00:40:03,000 --> 00:40:05,000
好的。
--So that was the first half of the day, was looking at what we just covered, and then the next step is we're going to look specifically at assignment and scheduling for fork-joined parallelism. 00:40:05,000 --> 00:40:42,000
这就是今天的前半天，研究我们刚刚介绍的内容，然后下一步我们将专门研究 fork-joined 并行性的分配和调度。
--So, okay. 00:40:42,000 --> 00:40:43,000
所以，好吧。
--So, you know, one common scenario that we've mostly been talking about so far is you have a collection of data, maybe you have an array of elements, and you just want to apply some computation to all the data in your collection, and a loop is a good way to, you know, at a high level, we can think of this as just iterating over all the elements in your data. 00:40:43,000 --> 00:41:08,000
所以，你知道，到目前为止我们主要讨论的一个常见场景是你有一个数据集合，也许你有一个元素数组，你只想对集合中的所有数据应用一些计算，循环是一种很好的方法，你知道，在高层次上，我们可以认为这只是迭代数据中的所有元素。
--So, what I've discussed so far has mostly been for this scenario where we have loops or things like that, mapping computations to data, and that's our data parallel approach. 00:41:08,000 --> 00:41:20,000
所以，到目前为止我所讨论的主要是针对这种情况，我们有循环或类似的东西，将计算映射到数据，这就是我们的数据并行方法。
--So another approach is that you create explicit threads per processor or hardware thread, and in software you decide at a higher level how you want to, what you want them to do, and they can do arbitrarily different things. 00:41:21,000 --> 00:41:37,000
所以另一种方法是你为每个处理器或硬件线程创建显式线程，在软件中你在更高的层次上决定你想要做什么，你想让它们做什么，它们可以做任意不同的事情。
--So this works especially well if the code is not simply a matter of mapping the same computation across a whole lot of data. 00:41:37,000 --> 00:41:45,000
因此，如果代码不仅仅是将相同的计算映射到大量数据的问题，那么这种方法尤其有效。
--So, now, the thing I want to talk about now is another, you know, one, so how do we write a small amount of code that does something interesting with a large amount of data? Well, a loop is one way to go visit a lot of data, but another way is to recurse or have a recursive function that walks over your data. 00:41:45,000 --> 00:42:05,000
所以，现在，我现在想谈的是另一个，你知道，一个，那么我们如何编写少量代码来处理大量数据的有趣事情呢？好吧，循环是一种访问大量数据的方法，但另一种方法是递归或具有遍历数据的递归函数。
--Maybe it's a graph or a tree or something like that. 00:42:05,000 --> 00:42:08,000
也许它是一个图表或一棵树或类似的东西。
--So, the interesting thing about that is usually when there's recursion, there are some dependencies as you're recursing. 00:42:09,000 --> 00:42:18,000
因此，有趣的是，通常当存在递归时，在递归时会存在一些依赖关系。
--So you go down into a method, into some procedure, and you maybe have to calculate something first before you continue on. 00:42:18,000 --> 00:42:26,000
所以你进入一个方法，进入一些过程，你可能必须先计算一些东西，然后才能继续。
--So you can't simply say, oh, all of the things that I visit recursively, just throw them all into one big task queue and do them all independently, because they're not independent. 00:42:26,000 --> 00:42:37,000
所以你不能简单地说，哦，我递归访问的所有东西，就把它们都扔到一个大任务队列中，然后全部独立完成，因为它们不是独立的。
--There are dependencies as you're moving down. 00:42:37,000 --> 00:42:40,000
向下移动时存在依赖关系。
--So, as an example of this, we'll just look at quicksort. 00:42:40,000 --> 00:42:44,000
因此，作为这方面的一个例子，我们将只看快速排序。
--So, here's a very simple version of quicksort where we have, say, pointers to array elements, and so we're sorting all the elements within some range, and what we do is we partition this data, and then we can basically recursively subdivide this into two parts. 00:42:44,000 --> 00:43:04,000
所以，这里有一个非常简单的快速排序版本，比如说，我们有指向数组元素的指针，所以我们对某个范围内的所有元素进行排序，我们所做的是对这些数据进行分区，然后我们基本上可以递归地细分这分为两部分。
--So now we're sorting the left half and the right half separately, and then we keep recursively going down over that again and again. 00:43:04,000 --> 00:43:12,000
所以现在我们分别对左半部分和右半部分进行排序，然后我们一次又一次地递归地向下排序。
--So this is called divide-and-conquer. 00:43:12,000 --> 00:43:14,000
所以这叫做分而治之。
--It's one way to do things in parallel. 00:43:14,000 --> 00:43:18,000
这是并行处理事情的一种方式。
--Now, notice that there's a dependence here, so we have to complete this step. 00:43:18,000 --> 00:43:23,000
现在，注意这里有一个依赖关系，所以我们必须完成这一步。
--We need to know what middle is before we can move on to calling this method. 00:43:23,000 --> 00:43:29,000
在我们继续调用这个方法之前，我们需要知道中间是什么。
--Okay. 00:43:30,000 --> 00:43:32,000
好的。
--But those two things are independent. 00:43:32,000 --> 00:43:35,000
但这两件事是独立的。
--Once we've calculated middle, those two things can operate independently, and then once you get inside of them, they will also create more and more parallelism. 00:43:35,000 --> 00:43:46,000
一旦我们计算出中间，这两个东西就可以独立运行，然后一旦你进入它们内部，它们也会产生越来越多的并行性。
--So if you look at what happens over time, there are these dependencies, but we can quickly, after just a few levels, create potentially a lot of parallelism this way. 00:43:46,000 --> 00:43:58,000
所以如果你看看随着时间的推移会发生什么，就会发现这些依赖关系，但我们可以很快地，在几个级别之后，以这种方式潜在地创建大量的并行性。
--Okay. 00:43:58,000 --> 00:43:59,000
好的。
--So that's the scenario we want to talk about today, and then we're going to discuss specifically, as a case study, we're going to look at what happens inside of Cilk+. 00:43:59,000 --> 00:44:10,000
这就是我们今天要讨论的场景，然后我们将具体讨论，作为一个案例研究，我们将看看 Cilk+ 内部发生了什么。
--So Cilk plus is a language developed by a CMU graduate who's a professor at MIT in his group, so Charles Leisherson and friends, and it's in GCC and lots of other compilers. 00:44:10,000 --> 00:44:27,000
所以 Cilk plus 是由 CMU 毕业生开发的一种语言，他是麻省理工学院的教授，在他的团队中，还有 Charles Leisherson 和朋友，它在 GCC 和许多其他编译器中。
--You've probably, maybe you've even used it already. 00:44:27,000 --> 00:44:30,000
你可能，也许你甚至已经使用过它。
--So first I'm going to talk about the semantics that are the part of the language that's relevant for today. 00:44:30,000 --> 00:44:37,000
所以首先我要谈谈语义，它是与今天相关的语言的一部分。
--So the most important primitives to think about, there's something called Cilk-spawn, and then there's also Cilk-sync, which you may or may not use sync, but you would definitely use Cilk-spawn, and this is about exposing parallelism to the language. 00:44:37,000 --> 00:44:56,000
所以要考虑的最重要的原语，有一个叫做 Cilk-spawn 的东西，然后还有 Cilk-sync，你可能会也可能不会使用同步，但你肯定会使用 Cilk-spawn，这是关于将并行性暴露给语言。
--So the meaning of Cilk-spawn is you put this in front of what would look like a normal procedure call, and the semantics are that you will in fact execute foo, that will happen, and you will also execute the code after the call of foo, but those two things may proceed concurrently. 00:44:56,000 --> 00:45:19,000
所以 Cilk-spawn 的意思是你把它放在看起来像正常过程调用的前面，语义是你实际上会执行 foo，那会发生，你也会在调用之后执行代码foo，但是这两件事可以同时进行。
--So while foo is executing, the things after the call of foo may execute concurrently with it. 00:45:19,000 --> 00:45:26,000
所以当foo在执行的时候，foo调用之后的东西可能会和它并发执行。
--Whether that actually happens concurrently is up to the runtime system, and that's what we're going to dig into. 00:45:26,000 --> 00:45:33,000
这是否实际上同时发生取决于运行时系统，这就是我们要深入研究的内容。
--Now, sync, what this does is it's a join, where I've used spawn to create potentially a lot of concurrency, and now I want to bring all of that, I want to make sure that everything has gotten back together again, and what's Cilk-sync will stall until all of the concurrent threads within this procedure have finished. 00:45:33,000 --> 00:45:59,000
现在，sync，这是一个连接，我已经使用 spawn 来创建潜在的大量并发，现在我想带来所有这些，我想确保一切都重新组合在一起，并且什么是 Cilk-sync 将停止，直到此过程中的所有并发线程都完成。
--Now, another thing to know is if you don't include one explicitly, the end of every function implicitly includes a sync. 00:45:59,000 --> 00:46:08,000
现在，要知道的另一件事是，如果您不显式包含一个，则每个函数的末尾都会隐式包含一个同步。
--So you will never return current procedure before you've synced up all of the spawns that you've created inside of the procedure. 00:46:08,000 --> 00:46:17,000
因此，在同步您在过程中创建的所有生成之前，您永远不会返回当前过程。
--Okay, so then, that's a high-level picture. 00:46:17,000 --> 00:46:21,000
好的，那么，这是一张高级图片。
--So then, if you want to think about using this to create parallelism, so this is just a very simple illustration here. 00:46:21,000 --> 00:46:28,000
那么，如果您想考虑使用它来创建并行性，那么这里只是一个非常简单的示例。
--So what we might do is call spawn with foo, and then foo can execute concurrently, and then after that, we want to do var. 00:46:28,000 --> 00:46:38,000
所以我们可能做的是用 foo 调用 spawn，然后 foo 可以并发执行，然后我们想做 var。
--So this is a way to tell the Cilk plus runtime system that foo and var can run concurrently. 00:46:38,000 --> 00:46:46,000
所以这是一种告诉 Cilk plus 运行时系统 foo 和 var 可以同时运行的方法。
--Now, as a programmer, you might be tempted to do this. 00:46:46,000 --> 00:46:51,000
现在，作为一名程序员，您可能会想这样做。
--You might say, I want foo and var to run concurrently, so I will do a Cilk-spawn of foo and a Cilk-spawn of var, and then I'll do a sync, because after all, that'll make two things run concurrently, and yes, it does, but also, the main thread now has really nothing to do, so you've actually created three potentially concurrent things where one of them is very uninteresting. 00:46:51,000 --> 00:47:14,000
你可能会说，我希望 foo 和 var 同时运行，所以我将执行 foo 的 Cilk-spawn 和 var 的 Cilk-spawn，然后我将进行同步，因为毕竟这会产生两件事并发运行，是的，确实如此，而且，主线程现在真的无事可做，因此您实际上已经创建了三个可能并发的事物，其中一个非常无趣。
--It's just about to immediately hit the sync. 00:47:15,000 --> 00:47:17,000
它即将立即同步。
--So in fact, if you really wanted to just run foo and var in parallel, it'd probably look like the first thing and not the second thing, and then here's an example where there are four things that you want to run in parallel, so you just have a whole set of spawns, and then something else after it. 00:47:17,000 --> 00:47:33,000
所以事实上，如果你真的想并行运行 foo 和 var，它可能看起来像第一件事而不是第二件事，然后这是一个你想并行运行四件事情的例子，所以你只有一整套产卵，然后是其他东西。
--So this is a way to express potential parallelism to the system, and the system gets to decide which of those tasks it actually wants to run in parallel and in what order. 00:47:34,000 --> 00:47:47,000
所以这是一种向系统表达潜在并行性的方法，系统可以决定它实际上想要并行运行哪些任务以及以什么顺序运行。
--So this is important to realize. 00:47:50,000 --> 00:47:52,000
所以认识到这一点很重要。
--A Cilk-spawn does not compel the runtime system to actually create any concurrency. 00:47:52,000 --> 00:47:58,000
 Cilk-spawn 不会强制运行时系统实际创建任何并发。
--It could just ignore all of the Cilk-spawns. 00:47:58,000 --> 00:48:01,000
它可以忽略所有 Cilk-spawns。
--In fact, you can take a Cilk program and just ignore every macro in it, Cilk-specific macro, and the program will just run normally. 00:48:01,000 --> 00:48:09,000
事实上，您可以采用 Cilk 程序并忽略其中的每个宏，即 Cilk 特定的宏，程序将正常运行。
--It won't run sequentially, but it'll behave correctly. 00:48:09,000 --> 00:48:13,000
它不会按顺序运行，但会正确运行。
--The sync has more of a firm contract than spawn. 00:48:16,000 --> 00:48:22,000
与 spawn 相比，sync 具有更多的固定合同。
--Spawn can be ignored whenever you want to. 00:48:22,000 --> 00:48:25,000
您可以随时忽略 Spawn。
--You can't ignore a sync. 00:48:25,000 --> 00:48:26,000
您不能忽略同步。
--A sync means, no, we really do have to bring together any thread if you have any concurrent threads. 00:48:26,000 --> 00:48:32,000
同步意味着，不，如果您有任何并发线程，我们确实必须将任何线程聚集在一起。
--So let's go back and look at quicksort and how you might implement that in Cilk+. 00:48:33,000 --> 00:48:40,000
因此，让我们回头看看快速排序以及如何在 Cilk+ 中实现它。
--One thing to realize, this looks very much like the code we saw before. 00:48:42,000 --> 00:48:46,000
需要注意的一件事是，这看起来非常像我们之前看到的代码。
--There's one parameter here, which is... 00:48:46,000 --> 00:48:49,000
这里有一个参数，它是...
--And this is a good thing to know about as a parallel programmer. 00:48:49,000 --> 00:48:52,000
作为并行程序员，了解这一点是一件好事。
--As you start doing divide and conquer, you'll eventually reach a point where it doesn't make any sense to keep dividing it further. 00:48:52,000 --> 00:49:00,000
当你开始分而治之时，你最终会到达一个点，在这个点上继续进一步划分是没有任何意义的。
--Because once you have more than enough parallelism, you really don't need any more tasks. 00:49:00,000 --> 00:49:05,000
因为一旦您拥有足够多的并行性，您就真的不需要任何更多的任务了。
--But also, if you make your tasks very small, there's going to be a lot of runtime overhead for managing these tiny tasks. 00:49:05,000 --> 00:49:11,000
而且，如果您使任务非常小，那么管理这些小任务将会产生大量的运行时开销。
--So what we do is we say, okay, when the number of elements to sort becomes small enough, just do it sequentially, and that will be just a sequential chunk of work. 00:49:11,000 --> 00:49:22,000
所以我们要做的是说，好吧，当要排序的元素数量足够少时，按顺序进行，这将只是一个连续的工作块。
--But hopefully, we will have already created a whole lot of parallelism above that. 00:49:22,000 --> 00:49:26,000
但希望我们已经在上面创建了大量的并行性。
--So what happens is... 00:49:27,000 --> 00:49:30,000
那么发生的事情是...
--The thing that's different here is we had two calls to quicksort, and we put a Cilk spawn in front of the first one, and that's telling the system that those two things can proceed concurrently. 00:49:30,000 --> 00:49:40,000
这里的不同之处在于我们对快速排序进行了两次调用，我们将 Cilk spawn 放在第一个之前，这告诉系统这两件事可以同时进行。
--So what probably happens is they do, in fact, start off going concurrently. 00:49:40,000 --> 00:49:45,000
所以可能发生的事情是他们实际上开始并发进行。
--At some point, they get small enough, and then that's a sequential task. 00:49:45,000 --> 00:49:49,000
在某些时候，它们变得足够小，然后这是一个顺序任务。
--But we have a lot of these. 00:49:49,000 --> 00:49:51,000
但是我们有很多这样的。
--Hopefully, we can keep all the parallel hardware busy this way. 00:49:51,000 --> 00:49:56,000
希望我们可以通过这种方式让所有并行硬件保持忙碌。
--Okay, so that's an illustration of the big picture here. 00:49:56,000 --> 00:50:03,000
好的，这就是这里大图的说明。
--Okay, so... 00:50:03,000 --> 00:50:05,000
可以，然后呢...
--Oh, yeah, question. 00:50:05,000 --> 00:50:06,000
哦，是的，问题。
--Would Cilk spawn ever create a thread if there are not enough cores for it? I'm about to talk about that. 00:50:06,000 --> 00:50:15,000
如果没有足够的内核，Cilk spawn 会创建一个线程吗？我正要谈论那个。
--That's a good question. 00:50:15,000 --> 00:50:17,000
这是个好问题。
--And now, what we're about to do is look under the covers at what really happens in the implementation of Cilk+. 00:50:17,000 --> 00:50:24,000
现在，我们要做的是深入了解 Cilk+ 实施过程中到底发生了什么。
--So we're going to talk about threads and what it really does with all of them. 00:50:24,000 --> 00:50:28,000
因此，我们将讨论线程及其对所有线程的真正作用。
--So that's a good question. 00:50:28,000 --> 00:50:29,000
所以这是一个很好的问题。
--I'll get to that just very soon. 00:50:29,000 --> 00:50:33,000
我很快就会谈到这一点。
--Okay, so key thing. 00:50:33,000 --> 00:50:35,000
好的，所以关键的事情。
--Remember, in an earlier lecture, I talked about how it's important not to confuse abstraction and implementation, and this is one of these situations. 00:50:35,000 --> 00:50:44,000
请记住，在之前的讲座中，我谈到了不要混淆抽象和实现是多么重要，这就是其中一种情况。
--Spawn is not pthread create. 00:50:44,000 --> 00:50:47,000
 Spawn 不是 pthread 创建的。
--It does not mean we are creating a new thread. 00:50:47,000 --> 00:50:50,000
这并不意味着我们正在创建一个新线程。
--It means we're telling the system that this is potential parallelism. 00:50:50,000 --> 00:50:55,000
这意味着我们告诉系统这是潜在的并行性。
--Okay, now, how much parallelism do we want to create? You... 00:50:55,000 --> 00:51:03,000
好的，现在，我们要创建多少并行度？你...
--So in this picture here, you can see that with divide and conquer, we may... 00:51:03,000 --> 00:51:09,000
所以在这张照片中，你可以看到分而治之，我们可以...
--In fact, this is dividing it by a factor of two at every level if it was dividing it by an even larger factor than that. 00:51:09,000 --> 00:51:16,000
事实上，如果它除以比这更大的因数，这就是在每个级别将它除以两倍。
--You can imagine that after just a couple of levels of recursion, you're exponentially creating a very large number of tasks. 00:51:16,000 --> 00:51:23,000
您可以想象，仅经过几级递归，您就会以指数方式创建大量任务。
--So how many tasks do we actually need? Well, we don't need vast numbers of tasks. 00:51:23,000 --> 00:51:29,000
那么我们实际需要多少任务呢？好吧，我们不需要大量的任务。
--You want to have more tasks than you have hardware threads because if you don't, then you either have static scheduling or you don't even have enough work. 00:51:29,000 --> 00:51:38,000
你希望拥有比硬件线程更多的任务，因为如果你不这样做，那么你要么有静态调度，要么你甚至没有足够的工作。
--So we want more tasks than hardware threads. 00:51:38,000 --> 00:51:42,000
所以我们想要比硬件线程更多的任务。
--We don't need a million times more tasks than hardware threads probably. 00:51:42,000 --> 00:51:46,000
我们可能不需要比硬件线程多一百万倍的任务。
--That would be... 00:51:46,000 --> 00:51:47,000
那会是...
--That would mean we'd have a lot of run time overhead to manage them. 00:51:47,000 --> 00:51:50,000
这意味着我们将有大量的运行时开销来管理它们。
--So just as a very rough rule of thumb, having... 00:51:50,000 --> 00:51:54,000
因此，作为一个非常粗略的经验法则，有...
--I mean, some people think that if you have something like eight times as many tasks as hardware threads, maybe that's a good number. 00:51:54,000 --> 00:52:01,000
我的意思是，有些人认为，如果您的任务数量是硬件线程数量的八倍，也许这是一个不错的数字。
--Now, your mileage will vary, but we're thinking about something in that rough ballpark. 00:52:01,000 --> 00:52:06,000
现在，你的里程会有所不同，但我们正在考虑那个粗略的范围内的事情。
--So a non-trivial number, but not a crazy large number of tasks. 00:52:06,000 --> 00:52:11,000
所以一个不平凡的数字，但不是一个疯狂的大量任务。
--Okay. 00:52:11,000 --> 00:52:12,000
好的。
--So we want to create these extra tasks. 00:52:12,000 --> 00:52:16,000
所以我们要创建这些额外的任务。
--Now, let's start with a very naive implementation of Cilk. 00:52:16,000 --> 00:52:22,000
现在，让我们从 Cilk 的一个非常简单的实现开始。
--So let's say we've described the semantics of Cilk and now you have to go build the run time system. 00:52:22,000 --> 00:52:28,000
假设我们已经描述了 Cilk 的语义，现在您必须构建运行时系统。
--And maybe the first thing you might try is, well, spawn sounds like creating a thread and sync sounds like doing joins, so let's just use pthread create and pthread join for those things. 00:52:28,000 --> 00:52:44,000
也许您首先要尝试的是，spawn 听起来像是创建线程，而 sync 听起来像是连接，所以让我们只使用 pthread create 和 pthread join 来处理这些事情。
--Okay. 00:52:44,000 --> 00:52:45,000
好的。
--Well, so what's going to go wrong here? Yep. 00:52:45,000 --> 00:52:50,000
那么，这里会出什么问题呢？是的。
--You're going to have a whole bunch of pthreads, so you're going to have to keep track of a whole bunch of thread states and all their different stacks and registers and instruction pointers. 00:52:50,000 --> 00:53:04,000
您将拥有一大堆 pthread，因此您将不得不跟踪一大堆线程状态及其所有不同的堆栈、寄存器和指令指针。
--Yep, that's right. 00:53:04,000 --> 00:53:05,000
是的，没错。
--So not only is it a problem, as I mentioned a minute ago, we don't necessarily need vast numbers of tasks. 00:53:05,000 --> 00:53:13,000
所以这不仅是一个问题，正如我刚才提到的，我们不一定需要大量的任务。
--Threads are even a different story. 00:53:13,000 --> 00:53:16,000
线程甚至是一个不同的故事。
--So a thread is something that probably the operating system or at least the thread run time library has to manage. 00:53:16,000 --> 00:53:23,000
所以线程可能是操作系统或至少线程运行时库必须管理的东西。
--And if you end up with more software threads than hardware threads, then you have to pause one thread and start another thread on the same hardware context, and that's non-trivially expensive. 00:53:23,000 --> 00:53:40,000
如果你最终得到的软件线程多于硬件线程，那么你必须暂停一个线程并在相同的硬件上下文中启动另一个线程，这非常昂贵。
--You have to save and restore the register state and this other stuff. 00:53:40,000 --> 00:53:44,000
你必须保存和恢复寄存器状态和其他东西。
--It involves the operating system. 00:53:44,000 --> 00:53:46,000
它涉及操作系统。
--You may be trapping it in the kernel. 00:53:46,000 --> 00:53:48,000
您可能将其困在内核中。
--So we don't want to be generating lots of threads. 00:53:48,000 --> 00:53:52,000
所以我们不想生成很多线程。
--We really don't want to have more threads than cores or hardware threads. 00:53:52,000 --> 00:53:58,000
我们真的不希望拥有比内核或硬件线程更多的线程。
--Okay, so if we did this, we would have lots of threads switching overhead. 00:53:58,000 --> 00:54:04,000
好的，如果我们这样做，我们会有很多线程切换开销。
--So that wouldn't be good. 00:54:04,000 --> 00:54:06,000
这样就不好了。
--So in fact, what CilkPlus does is, and this is a good general approach, is that when you start up the system, it will immediately create, using something like pfootcreate, it will create software threads for all of your hardware threads. 00:54:06,000 --> 00:54:23,000
所以实际上，CilkPlus 所做的是，这是一个很好的通用方法，当您启动系统时，它会立即创建，使用 pfootcreate 之类的东西，它会为您的所有硬件线程创建软件线程。
--Each of them gets one software thread. 00:54:23,000 --> 00:54:26,000
他们每个人都有一个软件线程。
--So the way that you deal with new work that's exposed because of a spawn is not that you create a thread. 00:54:26,000 --> 00:54:34,000
因此，您处理因 spawn 而暴露的新工作的方式并不是创建线程。
--It's that the thread goes and looks at a data structure, which is your task queue. 00:54:34,000 --> 00:54:38,000
就是线程去查看一个数据结构，也就是你的任务队列。
--So what these threads are doing is, each of these threads is looking for work in some implementation of a work queue, similar to what we were just talking about before when I said we could have these distributed task queues or something like that. 00:54:38,000 --> 00:54:53,000
所以这些线程正在做的是，这些线程中的每一个都在工作队列的某种实现中寻找工作，类似于我们之前所说的，当我说我们可以拥有这些分布式任务队列或类似的东西时。
--Okay, so for example, if you have a quad core, like a typical laptop these days might have a quad core, and it probably has two hardware threads with hyper-threading, so maybe you want eight threads. 00:54:54,000 --> 00:55:10,000
好的，例如，如果你有一个四核，就像现在典型的笔记本电脑可能有一个四核，它可能有两个带超线程的硬件线程，所以你可能需要八个线程。
--So CilkPlus will just generate eight threads for you. 00:55:10,000 --> 00:55:14,000
所以 CilkPlus 只会为您生成八个线程。
--Okay, so this is not about creating threads. 00:55:16,000 --> 00:55:21,000
好的，所以这与创建线程无关。
--It's about pointing threads at work to do. 00:55:21,000 --> 00:55:25,000
它是关于指向工作中的线程。
--So now we're going to talk about some more low-level details about what's going on inside Cilk's runtime system. 00:55:27,000 --> 00:55:33,000
所以现在我们将讨论一些关于 Cilk 运行时系统内部发生的事情的更底层的细节。
--What happens when we are executing this code? So we want to execute foo and var in parallel. 00:55:37,000 --> 00:55:44,000
当我们执行这段代码时会发生什么？所以我们想并行执行 foo 和 var。
--So first, a little bit of terminology. 00:55:45,000 --> 00:55:48,000
首先，了解一些术语。
--So there are two things that can be potentially executed concurrently. 00:55:48,000 --> 00:55:52,000
所以有两件事可以同时执行。
--In this example, both foo and var can be executed concurrently. 00:55:52,000 --> 00:55:57,000
在这个例子中，foo 和 var 可以并发执行。
--And we're going to call foo the spawned child. 00:55:57,000 --> 00:56:01,000
我们将调用 foo 生成的孩子。
--So it's really the method that we're calling immediately, but then there's work after it. 00:56:01,000 --> 00:56:07,000
所以它确实是我们立即调用的方法，但之后还有工作。
--So we'll call the work... 00:56:07,000 --> 00:56:09,000
所以我们会称工作...
--We'll have two words, child and continuation. 00:56:10,000 --> 00:56:14,000
我们有两个词，child 和 continuation。
--Continuation is the work you would do after the call to foo. 00:56:14,000 --> 00:56:18,000
继续是您在调用 foo 之后要做的工作。
--So in this case, it's var. 00:56:18,000 --> 00:56:20,000
所以在这种情况下，它是 var。
--Okay, so that's some terminology. 00:56:20,000 --> 00:56:23,000
好的，这是一些术语。
--And when we have a spawn, we can do foo and var concurrently. 00:56:23,000 --> 00:56:28,000
当我们有一个 spawn 时，我们可以同时执行 foo 和 var。
--And if we have two hardware threads, which threads should do which one? Now, at some level, this may seem like a pointless question. 00:56:28,000 --> 00:56:37,000
如果我们有两个硬件线程，哪个线程应该执行哪一个？现在，在某种程度上，这似乎是一个毫无意义的问题。
--Who cares where they're assigned just as long as they run in parallel? You don't really care, maybe. 00:56:37,000 --> 00:56:44,000
只要它们并行运行，谁在乎它们被分配到哪里？你真的不在乎，也许吧。
--But in general, if we look at... 00:56:44,000 --> 00:56:46,000
但总的来说，如果我们看...
--Remember, as this thing is running, it's going to be generating more and more potential work. 00:56:46,000 --> 00:56:51,000
记住，随着这个东西的运行，它会产生越来越多的潜在工作。
--So we want to have some policy about where we're scheduling things. 00:56:51,000 --> 00:56:55,000
所以我们想制定一些关于我们在哪里安排事情的政策。
--And it turns out that this is interesting. 00:56:55,000 --> 00:56:58,000
事实证明这很有趣。
--So, okay. 00:56:58,000 --> 00:56:59,000
所以，好吧。
--Before I get into the details of how that works, let's just review quickly what happens when you run this on a single thread, just sequentially under normal execution. 00:56:59,000 --> 00:57:09,000
在我深入了解它是如何工作的细节之前，让我们快速回顾一下当您在单个线程上运行它时会发生什么，只是在正常执行下顺序执行。
--So if I just got to the point of... 00:57:09,000 --> 00:57:12,000
所以如果我只是到了......
--If I just executed this code, and there was no Cilk spawn in front of it, what I would normally do is I would go into foo and execute foo, and then I'd return from foo, and then I would do var. 00:57:12,000 --> 00:57:25,000
如果我只是执行这段代码，并且它前面没有 Cilk spawn，我通常会做的是进入 foo 并执行 foo，然后从 foo 返回，然后我会执行 var。
--And when I'm in foo, when I'm in the middle of executing foo, the way that I know what to do afterwards and how to get to var is that in the thread stack, the continuation is there. 00:57:25,000 --> 00:57:39,000
当我在 foo 中，当我正在执行 foo 时，我知道之后要做什么以及如何到达 var 的方式是在线程堆栈中，延续就在那里。
--So this is something you learned about in detail in 2.13. 00:57:39,000 --> 00:57:43,000
所以这是你在 2.13 中详细了解的内容。
--So you know you store the context that you're coming back to, and that's how you know how to keep going. 00:57:43,000 --> 00:57:50,000
所以你知道你存储了你要返回的上下文，这就是你知道如何继续前进的方式。
--Okay. 00:57:50,000 --> 00:57:52,000
好的。
--So now, of course, if you're in the middle of... 00:57:52,000 --> 00:57:56,000
所以现在，当然，如果你正处于...
--If thread zero is off executing foo, and so it's off executing foo, and maybe at the time that it got to the Cilk spawn, there were no other threads that were looking for work. 00:57:56,000 --> 00:58:09,000
如果线程 0 停止执行 foo，因此它停止执行 foo，并且可能在它到达 Cilk spawn 时，没有其他线程正在寻找工作。
--So it's decided, okay, well, I will just go ahead and do foo, and then when I finish it, I will do var. 00:58:09,000 --> 00:58:15,000
所以就决定了，好吧，好吧，我就直接先做foo，等做完了再做var。
--It doesn't look like any other thread is available, so I'll just do all the work probably. 00:58:15,000 --> 00:58:20,000
看起来没有任何其他线程可用，所以我可能会完成所有工作。
--But if in the middle of this thread executing foo, maybe now thread one becomes available, and now it wants to do some work. 00:58:20,000 --> 00:58:30,000
但是如果在这个线程执行 foo 的过程中，也许现在线程 1 变得可用，现在它想要做一些工作。
--Now thread zero is already doing foo, so thread one would hopefully figure out how to do var. 00:58:30,000 --> 00:58:36,000
现在线程 0 已经在执行 foo，因此线程 1 有望弄清楚如何执行 var。
--So how is it going to figure out how to do var? Well, in theory, maybe you could try to write some stack walking tool and try to go look in the stack of thread zero and realize, oh, it's going to return to this address, and here is parameters in the stack, and maybe I'll steal them, but then I have to stick something else into the stack so when it returns, it doesn't do var also, and that would be ugly. 00:58:36,000 --> 00:59:03,000
那么它将如何弄清楚如何做 var 呢？好吧，理论上，也许你可以尝试编写一些堆栈遍历工具，然后尝试去查看线程 0 的堆栈，然后意识到，哦，它会返回到这个地址，这里是堆栈中的参数，也许我会窃取它们，但随后我必须将其他东西插入堆栈中，这样当它返回时，它也不会做 var，那会很丑陋。
--Conceptually, somehow thread one needs to figure out that var is something that it can execute, and this has to work nicely in some way. 00:59:03,000 --> 00:59:14,000
从概念上讲，线程 1 需要以某种方式弄清楚 var 是它可以执行的东西，并且这必须以某种方式很好地工作。
--So instead of thread zero simply doing a normal call into foo, what it does is it's going to do foo, say, for example, but before it does that, it's going to put something special into a work queue. 00:59:14,000 --> 00:59:28,000
因此，线程 0 不是简单地对 foo 进行正常调用，而是它会调用 foo，例如，但在此之前，它会将一些特殊的东西放入工作队列。
--So it'll say, here's some description of, if another thread wakes up, suddenly becomes idle, and needs work to do, I will describe to it how it could continue through my continuation point by doing var. 00:59:28,000 --> 00:59:43,000
所以它会说，这里有一些描述，如果另一个线程醒来，突然变得空闲，并且需要工作要做，我将向它描述它如何通过执行 var 来继续我的延续点。
--So you have some nice representation of, here is how you would continue on beyond the point where I'm working. 00:59:43,000 --> 00:59:52,000
所以你有一些很好的代表，这就是你将如何继续超越我的工作点。
--Now, if you finish foo, and come back, and notice that this is still in your queue, then you simply go back and do that. 00:59:52,000 --> 01:00:02,000
现在，如果您完成 foo 并返回，并注意到它仍在您的队列中，那么您只需返回并执行该操作。
--So the thing that changes is when you return from a procedure for silk spawn, you don't just return like a normal return, you come back and then you look in your own queue, and then you grab something out of it, and that's how you would continue on. 01:00:02,000 --> 01:00:14,000
所以改变的是，当你从 silk spawn 程序返回时，你不只是像正常返回那样返回，你回来然后查看你自己的队列，然后你从中抓取一些东西，这就是你将如何继续。
--So there's a little more software overhead to do that. 01:00:14,000 --> 01:00:17,000
因此，执行此操作需要更多的软件开销。
--But the nice thing is now, if this thread, if it becomes idle, and needs work to do, it will notice, uh-oh, there's nothing in my queue, but now it can go steal work from the other queue. 01:00:17,000 --> 01:00:29,000
但现在的好处是，如果这个线程，如果它变得空闲，并且需要工作来做，它会注意到，呃，哦，我的队列中没有任何东西，但现在它可以从另一个队列中窃取工作。
--So it can go over and look in thread 0's queue and say, ah, you have some more work to do, I will grab that, I'll move it over to my queue, and now I can just start executing it. 01:00:29,000 --> 01:00:41,000
所以它可以查看线程 0 的队列并说，啊，你还有一些工作要做，我会抓住它，我会把它移到我的队列中，现在我可以开始执行它了。
--So now var has moved over to thread 1, and now they really are running in parallel. 01:00:41,000 --> 01:00:46,000
所以现在 var 已经转移到线程 1，现在它们真的是并行运行的。
--So that's good. 01:00:46,000 --> 01:00:49,000
所以这很好。
--Any questions about that? So why not instead put foo on the queue and then continue with var? Great. 01:00:49,000 --> 01:01:01,000
有什么问题吗？那么，为什么不将 foo 放入队列，然后继续使用 var 呢？伟大的。
--So that's exactly what we're going to talk about next. 01:01:01,000 --> 01:01:04,000
这正是我们接下来要讨论的内容。
--That's a very good question. 01:01:04,000 --> 01:01:07,000
这是一个很好的问题。
--So I just sort of arbitrarily perhaps said that thread 0 was going to do foo and put var on the queue. 01:01:07,000 --> 01:01:16,000
所以我只是有点武断地说线程 0 将执行 foo 并将 var 放入队列。
--But it would have been equally valid to do it the other way around. 01:01:16,000 --> 01:01:19,000
但反过来也同样有效。
--I could have put foo on the queue and just done var. 01:01:19,000 --> 01:01:22,000
我本可以将 foo 放入队列中，然后完成 var。
--So now we're actually going to discuss this for a while, and just see which of these makes more sense. 01:01:22,000 --> 01:01:28,000
所以现在我们实际上要讨论这个问题，看看哪个更有意义。
--So there are interesting tradeoffs between those two approaches. 01:01:28,000 --> 01:01:31,000
因此，这两种方法之间存在有趣的权衡。
--So our choices are either do foo first, which is our child. 01:01:31,000 --> 01:01:40,000
所以我们的选择是先做 foo，这是我们的孩子。
--So in our terminology, that's our child. 01:01:40,000 --> 01:01:45,000
所以用我们的术语来说，那就是我们的孩子。
--So we would do the child first, or we would do var, and that's the continuation. 01:01:45,000 --> 01:01:51,000
所以我们会先做child，或者我们先做var，这就是continuation。
--So it's either continuation first or child first, and whichever one thread 0 is going to actually do, it's going to put the other one into its queue, and then that's the thing that will be stolen by another thread. 01:01:51,000 --> 01:02:05,000
所以它要么是 continuation first，要么是 child first，无论一个线程 0 实际要做什么，它都会将另一个线程放入它的队列中，然后这就是另一个线程将窃取的东西。
--So if you do the continuation first, another thread will steal the child. 01:02:05,000 --> 01:02:10,000
所以如果你先做延续，另一个线程会偷走孩子。
--If you do the child first, the other thread will steal the continuation. 01:02:10,000 --> 01:02:14,000
如果你先做孩子，另一个线程会窃取延续。
--But basically, either foo or var, one of them you do, and one of them you put in your queue. 01:02:14,000 --> 01:02:19,000
但基本上，要么是 foo 要么是 var，其中一个是你做的，其中一个是你放入你的队列中的。
--Does that choice matter? Okay, so let's look first at doing the continuation first. 01:02:19,000 --> 01:02:30,000
这个选择重要吗？好吧，让我们先看看做延续。
--This is the opposite of what I described a little while ago. 01:02:30,000 --> 01:02:33,000
这与我刚才描述的相反。
--So what if we actually did do the equivalent of var first? Now, to make this more interesting, I'm not just going to have two things. 01:02:33,000 --> 01:02:40,000
那么，如果我们确实首先执行了与 var 等效的操作呢？现在，为了让这更有趣，我不会只做两件事。
--I'm going to have a loop. 01:02:40,000 --> 01:02:42,000
我要有一个循环。
--I'm going to iterate over n instances where we're going to spawn a foo, and so it's going to tell the system that there are a lot of things you can potentially do in parallel. 01:02:42,000 --> 01:02:54,000
我将迭代 n 个实例，在这些实例中我们将生成一个 foo，因此它将告诉系统您可以并行执行很多事情。
--There are lots of iterations here. 01:02:54,000 --> 01:02:56,000
这里有很多迭代。
--So if we did the continuation first, in practical terms, what would happen over time when we look at our queue? So we get to iteration 0, and we are going to put foo with 0 as the argument into our queue. 01:02:56,000 --> 01:03:14,000
因此，如果我们首先进行延续，实际上，当我们查看我们的队列时，随着时间的推移会发生什么？所以我们到了第 0 次迭代，我们将把带有 0 作为参数的 foo 放入我们的队列中。
--So that will go into our queue, and we set that aside, and then we keep going because we're going to do the continuation and not the thing that we would have called, not the child. 01:03:14,000 --> 01:03:23,000
所以这将进入我们的队列，我们将其放在一边，然后我们继续前进，因为我们将继续进行，而不是我们会调用的东西，而不是孩子。
--So then we go around the loop, hit iteration 1, and notice, okay, here's another silk spawn. 01:03:23,000 --> 01:03:29,000
然后我们绕过循环，点击迭代 1，然后注意，好吧，这是另一个 silk spawn。
--Now I put foo 1 in the queue, and foo 2, and so on. 01:03:29,000 --> 01:03:34,000
现在我将 foo 1 和 foo 2 放入队列中，依此类推。
--So what it would do, in effect, is it would run through the loop and queue up all of the calls to foo that you see inside of the loop. 01:03:35,000 --> 01:03:46,000
所以它实际上会做什么，它会运行整个循环并将您在循环内部看到的所有对 foo 的调用排队。
--Okay, so this is a little bit like breadth-first traversal of the call graph because it's going to kind of eagerly put all of the work that you're about to call at a certain level into the queue right away. 01:03:46,000 --> 01:04:00,000
好的，所以这有点像调用图的广度优先遍历，因为它会急切地将您将要在某个级别调用的所有工作立即放入队列中。
--So that's what this does. 01:04:00,000 --> 01:04:03,000
这就是它的作用。
--One thing to notice about this is if you think about the order in which things would be executed, this is not going to be that similar to sequential execution. 01:04:03,000 --> 01:04:13,000
关于这一点需要注意的一件事是，如果您考虑事情的执行顺序，这与顺序执行并不相似。
--Normally in sequential execution, when you call a method, you do that method first, and then you come back and do the thing after it. 01:04:13,000 --> 01:04:20,000
通常在顺序执行中，当你调用一个方法时，你先执行那个方法，然后再回来执行它之后的事情。
--But here, we're potentially going to reorder that by the call. 01:04:20,000 --> 01:04:26,000
但在这里，我们可能会通过电话重新排序。
--Now, in fact, these are currently parallel, so there's concurrency there anyway. 01:04:26,000 --> 01:04:31,000
现在，事实上，这些目前是并行的，所以无论如何都存在并发性。
--So that's if we do the continuation first. 01:04:31,000 --> 01:04:34,000
如果我们先进行延续，那就是这样。
--Now what would happen in the other scenario? What if we do the child first, meaning that we are going to actually do foo. 01:04:34,000 --> 01:04:42,000
现在在另一种情况下会发生什么？如果我们先做 child 会怎样，这意味着我们实际上要做 foo。
--Sorry, we're actually going to do the foo sub i call immediately, and the thing that will queue up is the continuation of what would happen in the iteration after that point. 01:04:42,000 --> 01:04:55,000
抱歉，我们实际上将立即执行 foo sub i 调用，将排队的是在那一点之后迭代中发生的事情的延续。
--So what would happen here is the thread reaches the Cilk spawn. 01:04:55,000 --> 01:05:02,000
所以这里会发生的是线程到达 Cilk spawn。
--The thing that it puts into its queue is something that says, oh, this corresponds to being right here with i equal to zero. 01:05:02,000 --> 01:05:14,000
它放入队列的东西是这样说的，哦，这对应于就在这里，i 等于 0。
--So then what it would do is it would then go do foo sub i, foo sub zero. 01:05:14,000 --> 01:05:21,000
那么它会做的是它会去做 foo sub i, foo sub zero。
--And when it comes back, it would realize, okay, now I'm just past that point in the loop, and now I'll loop around again, and then I will do foo with one as an argument. 01:05:22,000 --> 01:05:35,000
当它返回时，它会意识到，好吧，现在我刚刚过了循环中的那个点，现在我将再次循环，然后我将 foo 与 one 作为参数。
--So this is a bit like depth-first traversal. 01:05:35,000 --> 01:05:38,000
所以这有点像深度优先遍历。
--It's actually likely to visit the methods in the same order that you would visit them in a sequential program. 01:05:38,000 --> 01:05:47,000
它实际上很可能按照您在顺序程序中访问它们的相同顺序访问这些方法。
--So does it matter which of these ways you do it? Any thoughts from these two pictures? Yeah? Well, if you do the second one, if another thread picks up your continuation, then you have no work, and you have to wait until some other thread has something to do for you. 01:05:48,000 --> 01:06:11,000
那么，您采用哪种方式重要吗？这两张照片有什么想法吗？是的？好吧，如果你做第二个，如果另一个线程接手了你的继续，那么你就没有工作了，你必须等到其他线程有事为你做。
--Right. 01:06:11,000 --> 01:06:12,000
正确的。
--So interestingly, if you look at these two pictures, if you look at this picture versus this picture from before, so in this continuation-first approach, at first glance, this might look like a much better approach, because we've just queued up all this work. 01:06:12,000 --> 01:06:27,000
有趣的是，如果你看这两张图片，如果你看这张图片与之前这张图片的对比，那么在这种延续优先的方法中，乍一看，这可能看起来是一种更好的方法，因为我们刚刚排队完成所有这些工作。
--So if other threads come in and they need work, they can pull some work out of the queue. 01:06:27,000 --> 01:06:33,000
因此，如果其他线程进来并且它们需要工作，它们可以从队列中拉出一些工作。
--I've put an abundant amount of work into my own queue, and there's a good chance that even if they steal some of the work, they'll probably work sitting there still for me to do when I finish doing food, or whichever food I'm doing right now. 01:06:33,000 --> 01:06:46,000
我已经将大量工作放入自己的队列中，即使他们偷了一些工作，他们也很有可能在我做完食物或任何食物后坐在那里继续工作让我做我现在正在做。
--And if you compare it with this case, what's sitting in my queue? Only one thing, which is to continue on, and that's it. 01:06:46,000 --> 01:06:54,000
如果你将它与这个案例进行比较，我的队列中有什么？只有一件事，就是继续下去，仅此而已。
--And if somebody steals that, then my queue is empty. 01:06:54,000 --> 01:06:57,000
如果有人偷了它，那么我的队列就空了。
--There's nothing for me to do. 01:06:57,000 --> 01:06:59,000
我没有什么可做的。
--So at first glance, this may seem like the less good approach. 01:06:59,000 --> 01:07:05,000
所以乍一看，这似乎不是很好的方法。
--So any thoughts on that? Any other? So what do you think SILK does? You may have guessed that I'm setting you up for a surprise. 01:07:05,000 --> 01:07:15,000
那么对此有什么想法吗？任何其他？那么您认为 SILK 的作用是什么？你可能已经猜到我是在给你一个惊喜。
--So it does the second thing, actually. 01:07:15,000 --> 01:07:18,000
所以它实际上做了第二件事。
--But one thing about, as you'll see in a second, the first approach is more eager. 01:07:18,000 --> 01:07:26,000
但是有一件事，您马上就会看到，第一种方法更急切。
--It's going to eagerly queue up lots of things, and it will potentially do things in a slightly funny order. 01:07:26,000 --> 01:07:32,000
它会急切地排队很多事情，而且它可能会以一种有点滑稽的顺序做事。
--In a way, it's legal, but it will throw lots of work into the queue. 01:07:33,000 --> 01:07:38,000
在某种程度上，这是合法的，但它会把很多工作排入队列。
--But a potential problem is, in fact, that this may cause the queues to grow to be quite large, because it's going to aggressively fill up queues. 01:07:38,000 --> 01:07:47,000
但事实上，一个潜在的问题是，这可能会导致队列变得非常大，因为它会积极地填满队列。
--Whereas the second one is much more lazy. 01:07:47,000 --> 01:07:50,000
而第二个要懒惰得多。
--It's only putting the minimum amount of work into the queue. 01:07:50,000 --> 01:07:54,000
它只是将最少量的工作放入队列中。
--It's not eagerly filling the queue. 01:07:54,000 --> 01:07:56,000
它并没有急切地填补队列。
--So it turns out, in terms of queue size, you can make sure that the amount of space in all of the queues is nicely bounded in this child-first approach. 01:07:56,000 --> 01:08:09,000
所以事实证明，就队列大小而言，您可以确保所有队列中的空间量在这种子优先方法中得到很好的限制。
--And I'm going to then walk through what this looks like for a quick chart, and you can see why it is that this actually is reasonable. 01:08:09,000 --> 01:08:19,000
然后我将通过快速图表来浏览这看起来像什么，你会明白为什么这实际上是合理的。
--Yeah, question there? Question being asked. 01:08:19,000 --> 01:08:48,000
是的，有问题吗？被问到的问题。
--Okay. 01:08:48,000 --> 01:08:49,000
好的。
--Yeah, so maybe what you're asking is, if you just had, like, say, foo and bar, in some sense, if they were really concurrent anyway, does it even matter which one was the continuation and which one was the child? And according to... 01:08:49,000 --> 01:09:03,000
是的，所以也许你要问的是，如果你只是有，比如说，foo 和 bar，在某种意义上，如果它们真的是并发的，那么哪一个是延续，哪一个是孩子，这有关系吗？并且根据...
--Is that what you're asking, partly? Or is that...? Well, yeah, that's true. 01:09:03,000 --> 01:09:09,000
这就是你要问的部分吗？还是那是……？嗯，是的，这是真的。
--So for the foo and bar case, it's really somewhat arbitrary which one I put in this following chart and which one I put after it. 01:09:09,000 --> 01:09:16,000
所以对于 foo 和 bar 的情况，我把哪个放在下面的图表中，哪个放在它后面确实有点随意。
--I could have switched them. 01:09:16,000 --> 01:09:19,000
我本可以切换它们。
--So at some level, semantically, in terms of program correctness, it doesn't matter. 01:09:19,000 --> 01:09:24,000
所以在某种程度上，在语义上，就程序正确性而言，这并不重要。
--It really doesn't matter which of these two things we do. 01:09:24,000 --> 01:09:27,000
我们做这两件事中的哪一件并不重要。
--So all we're talking about now is, like, run-time performance issues, not correctness. 01:09:27,000 --> 01:09:32,000
所以我们现在谈论的只是运行时性能问题，而不是正确性。
--There's no correctness problem with either of these approaches. 01:09:32,000 --> 01:09:36,000
这两种方法都没有正确性问题。
--Okay, so what I want to show you is what happens at run-time. 01:09:36,000 --> 01:09:41,000
好的，所以我想向您展示的是运行时发生的情况。
--So the loop, it turns out that you don't... 01:09:41,000 --> 01:09:44,000
所以循环，事实证明你不...
--The loop case was a little bit funny. 01:09:44,000 --> 01:09:46,000
循环案例有点滑稽。
--So Cilk is more typically used... 01:09:46,000 --> 01:09:48,000
所以 Cilk 更常被使用...
--Well, it's often used for recursive programs. 01:09:48,000 --> 01:09:51,000
好吧，它通常用于递归程序。
--And let's take a look at QuickSort, the code I showed you before, and see what happens to the queue. 01:09:51,000 --> 01:09:59,000
让我们看一下 QuickSort，我之前向您展示的代码，看看队列发生了什么。
--And this is with the second approach. 01:09:59,000 --> 01:10:01,000
这是第二种方法。
--So this is where we are doing... 01:10:01,000 --> 01:10:04,000
所以这就是我们正在做的......
--Where we're only putting the immediate continuation into the queue. 01:10:04,000 --> 01:10:08,000
我们只是将立即延续放入队列中。
--Okay, so then what happens is it... 01:10:08,000 --> 01:10:11,000
好吧，那么接下来会发生什么……
--Over time, it starts off with... 01:10:11,000 --> 01:10:14,000
随着时间的推移，它开始于...
--If it's starting with 200 elements, what it'll actually do is it will get in here, and it'll start in the middle. 01:10:14,000 --> 01:10:22,000
如果它从 200 个元素开始，它实际上会做的是它会进入这里，并且会从中间开始。
--The middle value initially will be, say, 100. 01:10:22,000 --> 01:10:26,000
中间值最初为 100。
--So then we need to do... 01:10:26,000 --> 01:10:31,000
那么我们需要做...
--The first part will be 0 to 100. 01:10:31,000 --> 01:10:34,000
第一部分是 0 到 100。
--And then the second part will be 101 to... 01:10:35,000 --> 01:10:38,000
然后第二部分将是 101 到...
--Well, I guess it says 200, but... 01:10:38,000 --> 01:10:41,000
好吧，我想它说的是 200，但是...
--Probably 199. 01:10:41,000 --> 01:10:43,000
应该是199吧
--So if we're doing child first, or continuation first, rather... 01:10:43,000 --> 01:10:48,000
所以如果我们先做孩子，或者先做延续，而不是......
--Sorry, child first. 01:10:48,000 --> 01:10:50,000
对不起，孩子第一。
--So we will put this into our queue. 01:10:50,000 --> 01:10:53,000
所以我们将把它放入我们的队列中。
--So that ends up in our queue. 01:10:53,000 --> 01:10:55,000
所以这最终会出现在我们的队列中。
--And then we continue on, and we're going to start doing 0 through 100. 01:10:55,000 --> 01:11:01,000
然后我们继续，我们将开始从 0 到 100。
--And then what happens with that? Well, then we recurse. 01:11:01,000 --> 01:11:05,000
然后会发生什么？好吧，那我们递归。
--And then we come back, and we divide that down again. 01:11:05,000 --> 01:11:08,000
然后我们回来，我们再把它分开。
--And then we continue with half of it, and we put the other half in the queue. 01:11:08,000 --> 01:11:11,000
然后我们继续其中的一半，将另一半放入队列中。
--So now half of it's gone in the queue. 01:11:11,000 --> 01:11:14,000
所以现在有一半已经排在队列中了。
--We continue on with the other half. 01:11:14,000 --> 01:11:16,000
我们继续另一半。
--That happens again. 01:11:16,000 --> 01:11:17,000
那又发生了。
--Eventually, we drop below our threshold, whatever that is. 01:11:17,000 --> 01:11:21,000
最终，我们会跌破我们的门槛，不管那是什么。
--So as we've been recursively going down the levels of recursion, we've been storing some of our work in the queue. 01:11:21,000 --> 01:11:29,000
因此，当我们递归地降低递归级别时，我们一直将一些工作存储在队列中。
--Okay, now... 01:11:29,000 --> 01:11:33,000
好吧，现在...
--All right, so then the way that this works, you have to... 01:11:33,000 --> 01:11:36,000
好吧，那么它的工作方式，你必须......
--This would not work well at all if it weren't for the fact that it does work stealing, and it does it in a specific way. 01:11:36,000 --> 01:11:42,000
如果不是因为它确实可以窃取并且以特定方式进行窃取，那么这根本就不会奏效。
--So now, let's say we do these other threads, and they need work. 01:11:42,000 --> 01:11:46,000
所以现在，假设我们处理这些其他线程，它们需要工作。
--So what work should they steal? So in particular... 01:11:46,000 --> 01:11:52,000
那么他们应该偷什么工作呢？所以特别...
--So thread 1 wants to steal some work, and here's some work that it might steal. 01:11:52,000 --> 01:11:57,000
所以线程 1 想要窃取一些工作，这是它可能窃取的一些工作。
--Should it steal the work from this end of the queue or this end of the queue? The top or the bottom of the queue? Well, top or bottom in the picture. 01:11:57,000 --> 01:12:11,000
它应该从队列的这一端窃取工作还是从队列的这一端窃取工作？队列的顶部还是底部？好吧，在图片的顶部或底部。
--Higher up and vertically or lower vertically. 01:12:11,000 --> 01:12:14,000
垂直向上或垂直向下。
--Any thoughts? Yeah? I would say higher, because that way you're taking a bigger task size instead of leaving the longer tasks to last. 01:12:14,000 --> 01:12:25,000
有什么想法吗？是的？我会说更高，因为这样你就可以完成更大的任务，而不是让更长的任务持续下去。
--Right. 01:12:25,000 --> 01:12:26,000
正确的。
--Exactly. 01:12:26,000 --> 01:12:27,000
确切地。
--Remember we said it would be better to have larger tasks early on and then smaller ones later. 01:12:27,000 --> 01:12:32,000
请记住，我们说过，最好尽早完成较大的任务，然后再完成较小的任务。
--So that's what CilkPlus does. 01:12:32,000 --> 01:12:34,000
这就是 CilkPlus 所做的。
--It will take the larger task, which is the thing that was queued up earlier, and it will actually grab this. 01:12:34,000 --> 01:12:43,000
它会拿更大的任务，也就是之前排队的那个东西，它实际上会抓住这个。
--So in fact, this thread jumps in also, so it grabs what was on the top, this grabs what was over here. 01:12:43,000 --> 01:12:50,000
所以事实上，这个线程也跳进去了，所以它抓住了上面的东西，这个抓住了这里的东西。
--And now the nice thing... 01:12:50,000 --> 01:12:51,000
现在好事...
--There are a couple of nice things about this. 01:12:51,000 --> 01:12:53,000
这有一些好处。
--Yeah. 01:12:53,000 --> 01:12:54,000
是的。
--You don't actually inform Cilk how large a task is, right? So how would it know? Oh, it doesn't know. 01:12:54,000 --> 01:13:02,000
您实际上并没有告知 Cilk 任务有多大，对吧？那它怎么会知道呢？哦，它不知道。
--It just happens to be... 01:13:02,000 --> 01:13:05,000
它恰好是...
--So it doesn't know how much work is involved with doing the task. 01:13:05,000 --> 01:13:09,000
所以它不知道完成任务涉及多少工作。
--Its policy is just, okay, which end of the work queue do we steal from? It's either the top or the bottom. 01:13:09,000 --> 01:13:15,000
它的策略是，好吧，我们从工作队列的哪一端窃取？它要么是顶部，要么是底部。
--You pick one or the other. 01:13:15,000 --> 01:13:17,000
你选择一个或另一个。
--So do you steal the most recently enqueued thing or the least recently enqueued thing? And it steals the least recently enqueued task, the thing that was enqueued longest ago, not most recently. 01:13:17,000 --> 01:13:30,000
那么你是窃取最近入队的东西还是最近最少入队的东西？它会窃取最近最少入队的任务，即最早入队而不是最近入队的任务。
--And that, in this case, is the bigger amount of work. 01:13:30,000 --> 01:13:33,000
而且，在这种情况下，工作量更大。
--Because it turns out that in Divide and Conquer, if you're doing Divide and Conquer, you enqueue bigger things early and smaller things later. 01:13:33,000 --> 01:13:40,000
因为事实证明，在分而治之中，如果你正在做分而治之，你会先入队大的东西，然后入队小的东西。
--So it's better to take the things that were enqueued earlier. 01:13:40,000 --> 01:13:43,000
所以最好把早先入队的东西拿走。
--They're likely to be bigger things. 01:13:43,000 --> 01:13:45,000
它们很可能是更大的东西。
--So the way this is implemented in Cilk Plus is you have a double-ended queue. 01:13:45,000 --> 01:13:50,000
所以在 Cilk Plus 中实现的方式是你有一个双端队列。
--And it steals from... 01:13:50,000 --> 01:13:54,000
它偷...
--So you push things on to the bottom, but you steal from the top. 01:13:54,000 --> 01:13:58,000
所以你把东西推到底部，但你从顶部偷东西。
--And so it does what you see in this picture. 01:13:58,000 --> 01:14:02,000
所以它会做你在这张照片中看到的事情。
--Okay, and then a question earlier was, which one of the queues does it steal from? And it does this randomly. 01:14:02,000 --> 01:14:09,000
好的，然后前面的一个问题是，它从哪个队列中窃取？它随机执行此操作。
--Like, you know, maybe random... 01:14:09,000 --> 01:14:12,000
就像，你知道的，也许是随机的……
--So the only thing that you really want to avoid is systematically causing imbalance when you're stealing. 01:14:12,000 --> 01:14:17,000
所以你真正想要避免的唯一一件事就是在你偷窃时系统地造成不平衡。
--So if you're doing it randomly, odds are that you're probably not causing some systematic problem like that by stealing. 01:14:17,000 --> 01:14:23,000
因此，如果您是随机进行的，那么很可能您不会通过偷窃造成类似的系统性问题。
--Question? Does Cilk always take the task that was used in the past? Yes. 01:14:23,000 --> 01:14:29,000
问题？ Cilk 是否总是接受过去使用的任务？是的。
--So there can be algorithms which compute and merge. 01:14:29,000 --> 01:14:33,000
所以可以有计算和合并的算法。
--In that case, newer tasks will be the bigger ones. 01:14:33,000 --> 01:14:38,000
在这种情况下，较新的任务将是更大的任务。
--So wouldn't that be a bit disruptive in that case? Yeah, potentially. 01:14:38,000 --> 01:14:45,000
那么在那种情况下会不会有点破坏性？是的，有可能。
--So it doesn't actually think about what the size is. 01:14:45,000 --> 01:14:48,000
所以它实际上并没有考虑大小是多少。
--It just takes the things that were enqueued longest ago. 01:14:48,000 --> 01:14:51,000
它只需要排队时间最长的东西。
--This happens to generally work out well as you're going down and dividing across it. 01:14:51,000 --> 01:14:57,000
当您向下并跨越它时，这通常会很好地解决问题。
--Okay, so a couple of advantages of taking the thing from the top are that it tends to... 01:14:57,000 --> 01:15:03,000
好的，所以从顶部拿东西的几个优点是它往往......
--Well, first of all, it's also nice because the thread that owns the queue is busy putting things on to this end of the queue. 01:15:04,000 --> 01:15:13,000
好吧，首先，这也很好，因为拥有队列的线程正忙于将东西放到队列的这一端。
--It also enqueues things down here. 01:15:13,000 --> 01:15:15,000
它也在这里排队。
--So you're not contending for the same end of the queue. 01:15:15,000 --> 01:15:20,000
所以你们不会争夺队列的同一端。
--Other threads are stealing from the top, but the local thread is accessing the bottom of the queue. 01:15:20,000 --> 01:15:25,000
其他线程正在从顶部窃取，但本地线程正在访问队列底部。
--It also tends to be good for locality because when you grab something, a big thing, and start dividing it further, spatial locality and dependencies are more likely to be preserved within that contiguous chunk of work, hopefully. 01:15:25,000 --> 01:15:42,000
它也往往对局部性有好处，因为当你抓住一些东西，一个大东西，并开始进一步划分它时，空间局部性和依赖性更有可能保留在连续的工作块中，希望如此。
--So anyway, this works out reasonably well. 01:15:42,000 --> 01:15:46,000
所以无论如何，这很有效。
--They made these choices because it's often used for divide-and-conquer parallelism, and this happens to be the right set of choices for divide-and-conquer parallelism. 01:15:46,000 --> 01:15:56,000
他们做出这些选择是因为它通常用于分而治之的并行性，而这恰好是分而治之并行性的正确选择集。
--Okay, so that's... 01:15:56,000 --> 01:15:58,000
好吧，那就是...
--So I only have, like, two minutes, so that was the more interesting thing to talk about. 01:15:58,000 --> 01:16:02,000
所以我只有大约两分钟的时间，所以这是更有趣的话题。
--The other thing to talk about is sync, and I'm going to give you a slightly accelerated version of this part of the talk. 01:16:02,000 --> 01:16:11,000
另一件要谈的事情是同步，我将为您提供这部分谈话的一个稍微加速的版本。
--So there's really only one important point here. 01:16:11,000 --> 01:16:14,000
所以这里真的只有一点很重要。
--So we talked about what happens at spawn. 01:16:14,000 --> 01:16:17,000
所以我们讨论了 spawn 发生的事情。
--Now what happens here at sync? At sync time, you have to make sure that all the threads are finished and that we don't continue on past that point until we know everything is finished. 01:16:17,000 --> 01:16:27,000
现在这里同步发生了什么？在同步时，您必须确保所有线程都已完成，并且在我们知道一切都已完成之前我们不会继续超过该点。
--So there's a data structure that's keeping track of the fact that other things are happening concurrently and they all need to come together. 01:16:27,000 --> 01:16:35,000
所以有一个数据结构可以跟踪其他事情同时发生并且它们都需要聚集在一起的事实。
--So now first of all, one thing to realize... 01:16:35,000 --> 01:16:40,000
所以现在首先要意识到一件事......
--Okay, so we're going to have a picture here, so all of our threads are working on various things, and maybe there's a continuation here, and we have to somehow figure out that everybody's finished. 01:16:40,000 --> 01:16:51,000
好的，所以我们要在这里放一张照片，所以我们所有的线程都在处理各种事情，也许这里还有一个延续，我们必须以某种方式弄清楚每个人都已经完成了。
--Okay, so first, a really simple case, which is, if you put a continuation into your... 01:16:51,000 --> 01:16:58,000
好的，首先，一个非常简单的案例，如果你在你的......
--If you did a spawn, if you reached a spawn, and put something into your queue, and no other threads stole it from you, then when you hit the sync, you actually don't have to do anything to coordinate with other threads. 01:16:58,000 --> 01:17:13,000
如果您执行了一次生成，如果您到达了一个生成，并将一些东西放入您的队列中，并且没有其他线程从您那里窃取它，那么当您达到同步时，您实际上不需要做任何事情来与其他线程进行协调。
--If you can remember the fact that nobody ever stole from you, then there's no other coordination that's needed, because you actually did all the work yourself, sequentially. 01:17:13,000 --> 01:17:24,000
如果您记得没有人从您那里偷过东西这一事实，那么就不需要其他协调，因为您实际上是按顺序自己完成了所有工作。
--So that's an easy case, but that's probably not a very common case. 01:17:24,000 --> 01:17:28,000
所以这是一个简单的案例，但可能不是很常见的案例。
--So what happens if someone else actually steals it from you? Turns out that there are two interesting choices. 01:17:28,000 --> 01:17:35,000
那么，如果其他人真的从您那里窃取了它，会发生什么？事实证明，有两个有趣的选择。
--One choice is the thread that originally entered this... 01:17:35,000 --> 01:17:40,000
一个选择是最初进入这个的线程......
--started spawning things, you could say that that thread is always the one that will finish up. 01:17:40,000 --> 01:17:46,000
开始生成东西，你可以说那个线程总是会结束的线程。
--The question is, after the sync, on which hardware thread do we continue executing? So one choice is, you spawn off other things, and then they all come back, and they coordinate with that original thread. 01:17:46,000 --> 01:17:57,000
问题是，同步之后，我们继续在哪个硬件线程上执行？所以一个选择是，你产生其他东西，然后它们都回来，并且它们与那个原始线程协调。
--So that's one approach. 01:17:57,000 --> 01:17:59,000
所以这是一种方法。
--That's called a stalling policy. 01:17:59,000 --> 01:18:03,000
这就是所谓的拖延政策。
--Okay, so there's a little animation of that. 01:18:03,000 --> 01:18:06,000
好的，所以有一点动画。
--So for that, you have a little data structure, where you keep track of the fact that somebody stole work from me, I need to remember how many things that were spawned, how many things have finished, and acknowledge that they finished, and when you see as many things acknowledging you as you need to see, then you know that you're finished, and that thread can continue executing. 01:18:06,000 --> 01:18:25,000
因此，为此，您有一个小数据结构，您可以在其中跟踪有人窃取我的工作这一事实，我需要记住生成了多少东西，完成了多少东西，并确认它们完成了，以及何时你看到了很多你需要看到的确认你的东西，然后你就知道你已经完成了，并且那个线程可以继续执行。
--So that's basically how that happens. 01:18:25,000 --> 01:18:28,000
所以这基本上就是这样发生的。
--There's a little animation here, which you can look through later. 01:18:28,000 --> 01:18:31,000
这里有一个小动画，你可以稍后再看。
--And then finally, the other option is a greedy policy, which is that the thing that can happen with the interesting thing here is that the thread that continues on after a sync is not necessarily the same hardware thread that entered the spawn to begin with. 01:18:31,000 --> 01:18:52,000
最后，另一种选择是贪婪策略，这里有趣的事情可能发生的事情是同步后继续运行的线程不一定是开始时进入 spawn 的同一硬件线程。
--So in other words, you still have a data structure that's keeping track of all of the synchronization that needs to occur for the sync to be finished, but that thing can move around. 01:18:52,000 --> 01:19:04,000
所以换句话说，您仍然有一个数据结构来跟踪完成同步所需的所有同步，但它可以四处移动。
--And so the advantage of that is that the last thread that finishes has actually stolen that structure, so as soon as the last one finishes, it just continues on, and at that point it's already gotten acknowledgments from the other threads, so you don't waste any time then waiting for synchronization. 01:19:05,000 --> 01:19:24,000
所以这样做的好处是，最后一个完成的线程实际上窃取了那个结构，所以一旦最后一个完成，它就会继续，到那时它已经得到了其他线程的确认，所以你不需要不要浪费任何时间等待同步。
--So that's the disadvantage of the first policy, which is it sounds simpler to implement, it is simpler to implement, but it's a little slower, because by saying it's always the first thread that continues on, and it may just be waiting around for someone to come synchronize with it, whereas the greedy case continues on with whoever just happens to finish last. 01:19:24,000 --> 01:19:44,000
所以这就是第一个策略的缺点，它听起来更容易实现，实现起来更简单，但速度有点慢，因为它总是第一个线程继续，它可能只是在等待某人与它同步，而贪婪的情况继续与恰好最后完成的人一起进行。
--So it's a little more complexity to implement this, but that's what Cilk does. 01:19:44,000 --> 01:19:50,000
所以实现这个有点复杂，但这就是 Cilk 所做的。
--It does the greedy approach for performance reasons. 01:19:50,000 --> 01:19:54,000
出于性能原因，它采用贪心方法。
--Okay, so that was the quick version of that. 01:19:54,000 --> 01:19:57,000
好的，这就是它的快速版本。
--And to wrap this up, we looked at fork-joined parallelism and we saw that there are some interesting trade-offs in terms of how we manage the parallelism, and the goal was to have enough tasks but not too many tasks, and we saw how Cilk does this with continuation stealing and greedy drawings and things. 01:19:57,000 --> 01:20:20,000
总结一下，我们研究了 fork-joined 并行性，我们看到在我们如何管理并行性方面有一些有趣的权衡，目标是有足够的任务但不是太多任务，我们看到Cilk 如何通过持续窃取和贪婪的绘图和其他东西来做到这一点。
--And that's it for today. 01:20:20,000 --> 01:20:22,000
这就是今天的内容。
