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
--Okay, so where we left off was on Wednesday, we were just, 00:00:17,000 --> 00:00:22,000
好的，所以我们在星期三离开的地方，我们只是，
--we looked at examples of functional parallel programs. 00:00:22,000 --> 00:00:27,000
我们查看了功能性并行程序的示例。
--We looked at the grid solver, which was a simplified version of the ocean simulation. 00:00:28,000 --> 00:00:33,000
我们查看了网格求解器，它是海洋模拟的简化版本。
--And we saw some basic parallel code in data parallel, 00:00:33,000 --> 00:00:37,000
我们在数据并行中看到了一些基本的并行代码，
--shared address space, and message passing frameworks. 00:00:37,000 --> 00:00:41,000
共享地址空间和消息传递框架。
--Okay, so today, actually today and then on Wednesday, 00:00:41,000 --> 00:00:46,000
好的，所以今天，实际上是今天，然后是星期三，
--so our next regular lecture after the recitation on Monday, 00:00:46,000 --> 00:00:49,000
所以我们周一朗诵后的下一次例行讲座，
--we're going to dive into some important issues related to how you get 00:00:49,000 --> 00:00:54,000
我们将深入探讨与您如何获得相关的一些重要问题
--better performance out of the parallel program. 00:00:54,000 --> 00:00:58,000
并行程序的性能更好。
--So today, we're sort of dividing that overall topic into two parts. 00:01:08,000 --> 00:01:14,000
所以今天，我们将整个主题分为两部分。
--So part one today, which we'll cover today, 00:01:14,000 --> 00:01:17,000
所以今天的第一部分，我们今天要讲的，
--is we're going to talk about how you divide up the work and schedule it on the processors. 00:01:17,000 --> 00:01:22,000
我们将讨论如何划分工作并在处理器上安排它。
--And then on Wednesday, we'll talk about how we, 00:01:22,000 --> 00:01:25,000
然后在星期三，我们将讨论我们如何，
--issues about communication and locality and how we want to do things to optimize the performance of that also. 00:01:25,000 --> 00:01:31,000
关于沟通和本地化的问题，以及我们希望如何做事来优化其性能。
--Okay, so one of the things I mentioned before is that parallel programming is a very iterative process, 00:01:33,000 --> 00:01:40,000
好的，我之前提到的一件事是并行编程是一个非常迭代的过程，
--meaning you're very unlikely to get it right the first time. 00:01:40,000 --> 00:01:43,000
这意味着您不太可能第一次就做对。
--In fact, you probably won't even get it right the second time or maybe even the third time. 00:01:43,000 --> 00:01:47,000
事实上，您甚至可能不会第二次甚至第三次都做对。
--So as you do the assignments, you'll get to experience the fact that you need to, 00:01:47,000 --> 00:01:54,000
所以当你做作业时，你会体验到你需要的事实，
--it's really important that you measure performance and learn things from those measurements 00:01:54,000 --> 00:01:59,000
测量性能并从这些测量中学习东西真的很重要
--and use the insights from that to improve things. 00:01:59,000 --> 00:02:04,000
并利用从中获得的见解来改进事情。
--Okay, even better. 00:02:04,000 --> 00:02:06,000
好吧，甚至更好。
--Okay, so here are a couple of goals that we're trying to accomplish here. 00:02:06,000 --> 00:02:11,000
好的，这里有几个我们正在努力实现的目标。
--So, and we're going to focus on really the first one mostly today, 00:02:11,000 --> 00:02:16,000
所以，我们今天主要关注第一个，
--which is we want to balance the work across all of the different threads 00:02:16,000 --> 00:02:21,000
这是我们想要平衡所有不同线程之间的工作
--so that they have the same amount of work to do. 00:02:21,000 --> 00:02:23,000
这样他们就有相同数量的工作要做。
--And sometimes that's easy and sometimes it's difficult. 00:02:23,000 --> 00:02:26,000
有时这很容易，有时却很困难。
--So that's, that's our major theme for today. 00:02:26,000 --> 00:02:28,000
这就是我们今天的主题。
--At the same time, we want to minimize communication because communicating is expensive. 00:02:28,000 --> 00:02:35,000
同时，我们希望尽量减少沟通，因为沟通很昂贵。
--So we prefer to communicate as. 00:02:35,000 --> 00:02:37,000
所以我们更喜欢交流为。
--And then finally, we have to worry about the fact that not only communicating, 00:02:38,000 --> 00:02:43,000
最后，我们不得不担心这样一个事实，不仅是沟通，
--but trying to be clever in any way to optimize the code often involves running more instructions in the program 00:02:43,000 --> 00:02:50,000
但是试图以任何方式聪明地优化代码通常涉及在程序中运行更多指令
--and that software overhead will also slow things down. 00:02:50,000 --> 00:02:53,000
并且软件开销也会减慢速度。
--So that's another source of overhead. 00:02:53,000 --> 00:02:56,000
所以这是另一个开销来源。
--Okay, so our number one, you know, pro tip here is when you're trying to write parallel software 00:02:57,000 --> 00:03:06,000
好的，所以我们的第一个，你知道，这里的专业提示是当你试图编写并行软件时
--for an assignment or for your project or anything, 00:03:06,000 --> 00:03:09,000
为了一项任务或你的项目或任何事情，
--always start by implementing the simplest thing that might work first. 00:03:10,000 --> 00:03:15,000
始终从实施可能首先起作用的最简单的事情开始。
--So it may be very tempting to start off by dreaming up some really creative, complicated solution, 00:03:15,000 --> 00:03:22,000
所以从构想一些真正有创意的、复杂的解决方案开始可能是非常诱人的，
--which you think might be very clever and make a very good performance. 00:03:22,000 --> 00:03:26,000
您认为这可能非常聪明并且性能非常好。
--But it's very likely, as I said, that the first thing that you try won't work very well. 00:03:26,000 --> 00:03:31,000
但正如我所说，您尝试的第一件事很可能不会奏效。
--So what you can do is get a measurement. 00:03:31,000 --> 00:03:34,000
所以你能做的就是测量一下。
--Use that measurement to learn what you need to tune and change when you do the second version. 00:03:34,000 --> 00:03:39,000
使用该度量来了解在执行第二个版本时需要调整和更改的内容。
--So since your goal is to get a good measurement as soon as possible, 00:03:39,000 --> 00:03:43,000
因此，由于您的目标是尽快获得良好的测量结果，
--then you want to start with something simple where, first of all, if it's simple, 00:03:43,000 --> 00:03:47,000
那么你想从一些简单的事情开始，首先，如果它很简单，
--you can implement it faster and get that measurement earlier. 00:03:47,000 --> 00:03:50,000
您可以更快地实施它并更早地进行测量。
--And second, it'll be easier to understand how to interpret the measurement 00:03:50,000 --> 00:03:56,000
其次，更容易理解如何解释测量结果
--if the thing that you're measuring is relatively simple. 00:03:56,000 --> 00:03:58,000
如果您要测量的东西相对简单。
--And then go from there. 00:03:58,000 --> 00:04:00,000
然后从那里去。
--If you need to make it more sophisticated, then you have a much better starting point at that point. 00:04:00,000 --> 00:04:05,000
如果你需要让它更复杂，那么你在那个时候就有了一个更好的起点。
--Okay, so one of the things we're going to be worrying about today is balancing the workload. 00:04:05,000 --> 00:04:13,000
好的，所以我们今天要担心的事情之一就是平衡工作量。
--So again, as we saw in the very first class, when we had the four volunteers up in the front of the room, 00:04:13,000 --> 00:04:21,000
再一次，正如我们在第一节课上看到的那样，当我们让四个志愿者站在教室前面时，
--when the workload is not balanced evenly, 00:04:21,000 --> 00:04:23,000
当工作量不平衡时，
--then some processors will end up sitting around doing nothing, waiting for other processors to finish. 00:04:24,000 --> 00:04:30,000
那么一些处理器最终将无所事事，等待其他处理器完成。
--So, in fact, even if you get this almost completely right but not quite right, it can be very costly. 00:04:30,000 --> 00:04:38,000
所以，事实上，即使你几乎完全正确但不是完全正确，它也可能会非常昂贵。
--So, for example, here we have four processors. 00:04:38,000 --> 00:04:43,000
因此，例如，这里我们有四个处理器。
--And you might think we've done a fairly good job of balancing the workload 00:04:43,000 --> 00:04:47,000
你可能认为我们在平衡工作量方面做得相当好
--because they're all within 20% of each other. 00:04:47,000 --> 00:04:50,000
因为它们都在彼此的 20% 以内。
--In fact, the first three were exactly the same. 00:04:50,000 --> 00:04:53,000
事实上，前三个是完全一样的。
--And it's just this fourth one that's just taking a little bit longer. 00:04:53,000 --> 00:04:57,000
只是这第四个需要更长的时间。
--But while it's taking that little bit of longer time, 00:04:57,000 --> 00:05:00,000
但是虽然它花费了一点点时间，
--that's hurting performance because all the other processors don't have anything to do. 00:05:00,000 --> 00:05:04,000
这会损害性能，因为所有其他处理器都无事可做。
--So we really want to try to balance the workload as evenly as possible. 00:05:04,000 --> 00:05:11,000
所以我们真的想尝试尽可能均衡地平衡工作量。
--Okay, so I'm going to talk about different strategies for dividing up the work 00:05:11,000 --> 00:05:17,000
好的，所以我要谈谈划分工作的不同策略
--and trying to balance the workload. 00:05:17,000 --> 00:05:19,000
并试图平衡工作量。
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
--Now, when I say it's determined ahead of time, 00:06:09,000 --> 00:06:12,000
现在，当我说它是提前确定的，
--there may still be a little bit of computation that occurs when the program runs 00:06:12,000 --> 00:06:16,000
程序运行时可能仍然会发生一些计算
--because you may need to know the size of the input file, the size of the matrix, or something like that, 00:06:16,000 --> 00:06:22,000
因为您可能需要知道输入文件的大小、矩阵的大小或类似的东西，
--and probably the number of processors, and do a little bit of computation based on that. 00:06:22,000 --> 00:06:26,000
可能还有处理器的数量，并在此基础上进行一些计算。
--But when you get to the point of actually doing the parallel work, 00:06:26,000 --> 00:06:29,000
但是当你真正做到并行工作时，
--you already have figured out exactly how everything's being carved up. 00:06:29,000 --> 00:06:34,000
您已经确切地弄清楚了一切是如何被分割的。
--Okay, now, the nice thing about this, 00:06:34,000 --> 00:06:38,000
好的，现在，这件事的好处是，
--the big selling point of static assignment is that it has close to zero runtime overhead. 00:06:38,000 --> 00:06:45,000
静态赋值的最大卖点是它的运行时开销几乎为零。
--Because since you've already decided ahead of time how you're dividing up the work, 00:06:45,000 --> 00:06:50,000
因为你已经提前决定好如何分工，
--there's not any extra work that you need to do while the program is running to think about this problem 00:06:50,000 --> 00:06:55,000
在程序运行时不需要做任何额外的工作来考虑这个问题
--because you've already finished thinking about it. 00:06:55,000 --> 00:06:58,000
因为你已经想完了。
--So that's the big advantage of this approach. 00:06:58,000 --> 00:07:02,000
这就是这种方法的一大优势。
--Okay, so that's a big advantage. 00:07:02,000 --> 00:07:06,000
好吧，这是一个很大的优势。
--What would be a disadvantage of this approach? 00:07:06,000 --> 00:07:09,000
这种方法的缺点是什么？
--When would you not want to do this? 00:07:12,000 --> 00:07:15,000
你什么时候不想这样做？
--One of those assignments unexpectedly takes longer than you're stuck with it. 00:07:15,000 --> 00:07:19,000
其中一项任务出乎意料地花费了比你坚持它更长的时间。
--Right, so in the grid solver, it turned out that the computation was identical across all the elements. 00:07:19,000 --> 00:07:27,000
是的，所以在网格求解器中，结果证明所有元素的计算都是相同的。
--And there may be cache misses, and who knows, maybe even page faults or things like that 00:07:27,000 --> 00:07:31,000
并且可能存在缓存未命中，谁知道呢，甚至可能是页面错误或类似的事情
--that may cause some of the memory accesses to take a little longer than other things. 00:07:31,000 --> 00:07:35,000
这可能会导致某些内存访问比其他事情花费更长的时间。
--But basically, we would expect it to be very uniform across all the computation. 00:07:35,000 --> 00:07:41,000
但基本上，我们希望它在所有计算中都非常统一。
--But that might not always be the case. 00:07:41,000 --> 00:07:44,000
但情况可能并非总是如此。
--So, okay, so we'll get to what you do in a minute. 00:07:44,000 --> 00:07:47,000
所以，好吧，我们会在一分钟内了解您的工作。
--I'll talk about what you do when you can't do a good job with static assignment. 00:07:47,000 --> 00:07:52,000
我就说说静态赋值搞不好的时候怎么办。
--But first, I want to just talk a little more about when we can apply static assignment 00:07:52,000 --> 00:07:58,000
但首先，我想多谈谈何时可以应用静态赋值
--or something very similar to it. 00:07:59,000 --> 00:08:01,000
或与之非常相似的东西。
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
--So, again, modulo cache misses or communication related to that, 00:08:27,000 --> 00:08:33,000
因此，再次模缓存未命中或与之相关的通信，
--we would expect every task to take basically the same amount of time. 00:08:33,000 --> 00:08:37,000
我们希望每项任务花费的时间基本相同。
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
--They don't necessarily have to be identical, though, 00:09:04,000 --> 00:09:07,000
不过，它们不一定必须相同，
--if you have a relatively inexpensive way to think about how long the different tasks will take. 00:09:07,000 --> 00:09:15,000
如果您有一种相对便宜的方法来考虑不同的任务需要多长时间。
--So let's, just as a really simple example, imagine that there's some input parameter to the task, 00:09:15,000 --> 00:09:21,000
所以让我们，作为一个非常简单的例子，假设任务有一些输入参数，
--and you can very quickly predict the execution time based on that. 00:09:21,000 --> 00:09:25,000
您可以基于此非常快速地预测执行时间。
--Let's say maybe it's just linear with respect to some parameter or something like that. 00:09:25,000 --> 00:09:30,000
假设它可能只是关于某些参数或类似参数的线性关系。
--So in this case, they may be different, but you have a good way to predict how long they're going to take. 00:09:30,000 --> 00:09:36,000
所以在这种情况下，它们可能不同，但您有一个很好的方法来预测它们将花费多长时间。
--So here we see there are a lot of different tasks of different sizes, 00:09:36,000 --> 00:09:41,000
所以在这里我们看到有很多不同大小的不同任务，
--but if they're predictable, then we have to do a little more work to make this work out. 00:09:41,000 --> 00:09:45,000
但如果它们是可预测的，那么我们必须做更多的工作才能解决这个问题。
--But you could potentially pack them together so that if you add up the expected time for all the tasks assigned to each processor, 00:09:45,000 --> 00:09:55,000
但是你可以将它们打包在一起，这样如果你将分配给每个处理器的所有任务的预期时间加起来，
--hopefully it will all balance out, like in this picture here. 00:09:55,000 --> 00:10:00,000
希望一切都会平衡，就像这里的这张照片一样。
--Okay. 00:10:00,000 --> 00:10:01,000
好的。
--So this may not be perfect, but again, the big advantage is very little runtime overhead. 00:10:01,000 --> 00:10:06,000
所以这可能并不完美，但同样，最大的优势是运行时开销非常小。
--So we're willing to give up maybe just a little bit of load and balance 00:10:06,000 --> 00:10:09,000
所以我们愿意放弃可能只是一点点的负载和平衡
--if we win more than that back with very low runtime overhead. 00:10:09,000 --> 00:10:15,000
如果我们以非常低的运行时开销赢回更多。
--Okay. 00:10:15,000 --> 00:10:16,000
好的。
--So here's one of these really good things to know about on this slide that you may not guess ordinarily, 00:10:16,000 --> 00:10:24,000
因此，这是这张幻灯片上您可能通常猜不到的非常好的事情之一，
--which is I'm going to talk about in a minute, I'm going to talk about dynamic assignment, 00:10:24,000 --> 00:10:28,000
这是我稍后要讲的，我要讲的是动态分配，
--where you are fairly frequently making decisions about how to balance the work. 00:10:28,000 --> 00:10:33,000
您经常决定如何平衡工作的地方。
--But there's something in between, which is called semi-static, which is a very good trick to know about. 00:10:33,000 --> 00:10:39,000
但是介于两者之间的东西称为半静态，这是一个非常好的技巧。
--The idea here is that in many systems, if you're, say, doing a simulation over time steps, 00:10:39,000 --> 00:10:46,000
这里的想法是，在许多系统中，如果你正在做一个时间步长的模拟，
--although the amount of work per task may be changing over time, 00:10:46,000 --> 00:10:51,000
尽管每项任务的工作量可能会随时间而变化，
--and that may seem like it's hopelessly difficult to do it statically, 00:10:51,000 --> 00:10:56,000
静态地做到这一点似乎是无可救药的困难，
--it may be the case that that work is changing relatively slowly. 00:10:56,000 --> 00:11:00,000
情况可能是这项工作的变化相对缓慢。
--So, for example, on Wednesday, I talked about the Barnes-Hutt galaxy simulation, 00:11:00,000 --> 00:11:07,000
因此，例如，在星期三，我谈到了 Barnes-Hutt 星系模拟，
--where we are modeling how stars are moving through galaxies over time, 00:11:07,000 --> 00:11:14,000
我们正在模拟恒星如何随时间穿过星系，
--and I said that the amount of work is not uniform, 00:11:14,000 --> 00:11:18,000
而且我说工作量不统一，
--because you do these pairwise comparisons to compute gravitational forces, 00:11:18,000 --> 00:11:24,000
因为你做这些成对比较来计算引力，
--and if you're in a neighborhood where there are a lot of other stars nearby, 00:11:24,000 --> 00:11:29,000
如果你所在的社区附近有很多其他星星，
--then you're going to have to do many more of these comparisons 00:11:29,000 --> 00:11:32,000
那么你将不得不做更多的这些比较
--than for a star that's off here more or less by itself, 00:11:32,000 --> 00:11:36,000
比起一颗或多或少独自离开这里的星星，
--because for the ones that are further away from other stars, 00:11:36,000 --> 00:11:39,000
因为对于离其他恒星较远的那些，
--it's just going to summarize the mass of these other stars as one big block. 00:11:39,000 --> 00:11:44,000
它只是将这些其他恒星的质量总结为一个大块。
--Okay, so the amount of work is non-uniform, 00:11:44,000 --> 00:11:49,000
好的，所以工作量是不均匀的，
--and it changes over time because the stars are moving around, 00:11:49,000 --> 00:11:54,000
它随着时间的推移而变化，因为星星在四处移动，
--but they're not moving that quickly, they're moving relatively slowly. 00:11:54,000 --> 00:11:58,000
但他们并没有那么快地移动，他们移动得相对缓慢。
--So what you can do, the trick with a semi-static technique, 00:11:58,000 --> 00:12:02,000
所以你可以做什么，半静态技巧，
--is that every now and then, you decide what parameter makes sense, 00:12:02,000 --> 00:12:06,000
是不是时不时地，你决定什么参数有意义，
--but you profile the time. 00:12:06,000 --> 00:12:10,000
但是你剖析了时间。
--Now, that doesn't necessarily mean you do expensive CPU wall-clock profiling, 00:12:10,000 --> 00:12:16,000
现在，这并不一定意味着您要进行昂贵的 CPU 挂钟分析，
--maybe you do something simple like recording how many different computations you had to, 00:12:16,000 --> 00:12:22,000
也许你做一些简单的事情，比如记录你必须进行多少次不同的计算，
--how many different stars did I have to compare against for a particular star. 00:12:22,000 --> 00:12:27,000
对于一颗特定的星星，我必须与多少颗不同的星星进行比较。
--So you capture some number that will allow you to estimate execution time, 00:12:27,000 --> 00:12:32,000
所以你捕获了一些可以让你估计执行时间的数字，
--and then you then divide up the work based on that, 00:12:32,000 --> 00:12:36,000
然后你再以此为基础划分工作，
--and then for some number of iterations, you basically proceed as though it's a static schedule. 00:12:36,000 --> 00:12:42,000
然后对于一些迭代，你基本上就好像它是一个静态计划一样进行。
--So you don't revisit how to schedule things for a while, 00:12:42,000 --> 00:12:46,000
所以你暂时不要重新考虑如何安排事情，
--and then after some amount of time goes by, you go back, 00:12:46,000 --> 00:12:49,000
然后过了一段时间，你回去，
--and then you re-instrument things, and you measure them, 00:12:49,000 --> 00:12:52,000
然后你重新安装仪器，然后测量它们，
--and then you possibly change the partitioning. 00:12:52,000 --> 00:12:56,000
然后您可能会更改分区。
--So galaxy simulation is one example. 00:12:56,000 --> 00:12:59,000
所以星系模拟就是一个例子。
--There are a lot of other things in physical simulations. 00:12:59,000 --> 00:13:03,000
物理模拟中还有很多其他的东西。
--For example, if you're modeling aircraft in a wind tunnel, 00:13:03,000 --> 00:13:07,000
例如，如果您在风洞中模拟飞机，
--things are moving around and changing a bit, 00:13:07,000 --> 00:13:11,000
事情正在四处移动并发生一些变化，
--but they tend not to change so radically that this technique is likely to still be useful in that case. 00:13:11,000 --> 00:13:19,000
但它们往往不会发生根本性的变化，以至于这种技术在那种情况下可能仍然有用。
--So this is a sort of midway point, 00:13:19,000 --> 00:13:22,000
所以这是一个中间点，
--but you can think of it as static scheduling over some fixed time period, 00:13:22,000 --> 00:13:27,000
但你可以将其视为某个固定时间段内的静态调度，
--and then you go back, and then you rethink how you're going to reschedule the assignment, that is. 00:13:27,000 --> 00:13:33,000
然后你回去，然后你重新考虑你将如何重新安排任务，就是这样。
--Okay, so that's static scheduling. 00:13:33,000 --> 00:13:35,000
好的，这就是静态调度。
--The other major option is dynamic scheduling. 00:13:35,000 --> 00:13:39,000
另一个主要选项是动态调度。
--You probably could have guessed that. 00:13:39,000 --> 00:13:41,000
你可能已经猜到了。
--So the idea here is that as the program is running, 00:13:41,000 --> 00:13:46,000
所以这里的想法是当程序运行时，
--the different threads are grabbing work as they need. 00:13:46,000 --> 00:13:51,000
不同的线程正在根据需要抓取工作。
--That's effectively what it means. 00:13:51,000 --> 00:13:53,000
这实际上就是它的意思。
--So this is dynamically balancing out the assignment of tasks to processors. 00:13:53,000 --> 00:13:59,000
所以这是动态地平衡分配给处理器的任务。
--So as one simple example of how you might code this up, 00:13:59,000 --> 00:14:02,000
因此，作为您如何编写代码的一个简单示例，
--if you had just a sequential program where you have a loop, 00:14:02,000 --> 00:14:10,000
如果你只有一个有循环的顺序程序，
--and the different iterations are independent of each other, and those are our tasks. 00:14:10,000 --> 00:14:16,000
并且不同的迭代是相互独立的，这些就是我们的任务。
--So we could do it statically. 00:14:16,000 --> 00:14:19,000
所以我们可以静态地做。
--We could just do it blockwise or interleave it, 00:14:19,000 --> 00:14:21,000
我们可以按块或交错进行，
--but if we want to do it dynamically, we might do something like this. 00:14:21,000 --> 00:14:25,000
但是如果我们想动态地做，我们可能会做这样的事情。
--So we will have some counter, and this will be a variable, 00:14:25,000 --> 00:14:32,000
所以我们会有一些计数器，这将是一个变量，
--and this is actually effectively the loop index. 00:14:32,000 --> 00:14:35,000
这实际上是循环索引。
--So when a thread wants a loop index, it's going to go read this counter and increment it, 00:14:35,000 --> 00:14:41,000
所以当一个线程想要一个循环索引时，它会去读取这个计数器并增加它，
--and we have to put a lock around that or use some other kind of atomic instruction 00:14:41,000 --> 00:14:46,000
我们必须锁定它或使用其他类型的原子指令
--so that it doesn't get corrupted. 00:14:46,000 --> 00:14:48,000
这样它就不会被损坏。
--But each thread will go grab an iteration, and now it will do work. 00:14:48,000 --> 00:14:52,000
但是每个线程都会去获取一个迭代，现在它会工作了。
--And if it turns out that some of the iterations take much longer than other ones, 00:14:52,000 --> 00:14:56,000
如果事实证明某些迭代比其他迭代花费的时间长得多，
--then hopefully this will all balance out in the end, 00:14:56,000 --> 00:14:59,000
然后希望这一切最终都会平衡，
--because you only go back and get more work when you're ready to grab more work. 00:14:59,000 --> 00:15:04,000
因为只有当你准备好接受更多的工作时，你才会回去做更多的工作。
--So that's one example of how dynamic scheduling works. 00:15:04,000 --> 00:15:10,000
这就是动态调度如何工作的一个例子。
--And this has a big advantage, which is it works when the amount of execution time is unpredictable 00:15:10,000 --> 00:15:17,000
这有一个很大的优势，那就是当执行时间量不可预测时它是有效的
--and is likely to vary, and you can't really predict the time very well. 00:15:17,000 --> 00:15:22,000
并且很可能会有所不同，您无法真正准确地预测时间。
--Okay. 00:15:22,000 --> 00:15:25,000
好的。
--Any concerns about this picture on the right, though? 00:15:25,000 --> 00:15:28,000
不过，对右边的这张照片有什么顾虑吗？
--Actually, just a related question. 00:15:28,000 --> 00:15:30,000
实际上，只是一个相关的问题。
--Sure. 00:15:30,000 --> 00:15:31,000
当然。
--In ISPC, when you launch tasks, so you use multiple cores, 00:15:31,000 --> 00:15:34,000
在 ISPC 中，当您启动任务时，您会使用多个内核，
--does it dynamically allocate the tasks to cores? 00:15:34,000 --> 00:15:39,000
它是否动态地将任务分配给核心？
--Yes. 00:15:39,000 --> 00:15:40,000
是的。
--So it's not statically doing that? 00:15:40,000 --> 00:15:42,000
所以它不是静态地这样做？
--That's right. 00:15:42,000 --> 00:15:43,000
这是正确的。
--I mean, the language doesn't – well, the implementation does it dynamically. 00:15:43,000 --> 00:15:47,000
我的意思是，语言不会——好吧，实现是动态的。
--The abstraction doesn't actually dictate how it does it, 00:15:47,000 --> 00:15:52,000
抽象实际上并没有规定它是如何做到的，
--but the implementation happens to do it dynamically. 00:15:52,000 --> 00:15:55,000
但是实现恰好是动态执行的。
--So when one core finishes what it's doing, it'll grab the next? 00:15:55,000 --> 00:15:58,000
所以当一个核心完成它正在做的事情时，它会抓住下一个？
--Yep. 00:15:58,000 --> 00:15:59,000
是的。
--That's right. 00:15:59,000 --> 00:16:00,000
这是正确的。
--Okay. 00:16:00,000 --> 00:16:01,000
好的。
--So, okay. 00:16:01,000 --> 00:16:03,000
所以，好吧。
--About this specific code here on the right, 00:16:03,000 --> 00:16:05,000
关于右边这个具体的代码，
--if you look at this and think about performance, 00:16:05,000 --> 00:16:08,000
如果你看看这个并考虑性能，
--does anything concern you here? 00:16:08,000 --> 00:16:16,000
有什么事与你有关吗？
--Okay. 00:16:16,000 --> 00:16:17,000
好的。
--Actually, hold that thought. 00:16:17,000 --> 00:16:18,000
实际上，请保持这种想法。
--I realize I have a good follow-up slide and two slides. 00:16:18,000 --> 00:16:21,000
我意识到我有一张很好的跟进幻灯片和两张幻灯片。
--Before I get to that, that code is showing the work as loop iterations, 00:16:21,000 --> 00:16:27,000
在开始之前，该代码将工作显示为循环迭代，
--but more generally, if you have things that aren't necessarily loop iterations, 00:16:27,000 --> 00:16:32,000
但更一般地说，如果你有一些不一定是循环迭代的东西，
--you may have to have a data structure or something that describes a piece of work. 00:16:33,000 --> 00:16:38,000
您可能必须有一个数据结构或描述一项工作的东西。
--And, for example, the stars. 00:16:38,000 --> 00:16:43,000
并且，例如，星星。
--Okay, the stars in the galaxy simulation. 00:16:43,000 --> 00:16:45,000
好的，银河模拟中的星星。
--Each one of these is a little node in a graph 00:16:45,000 --> 00:16:48,000
每一个都是图中的一个小节点
--or in that octree or quadtree data structure, 00:16:48,000 --> 00:16:52,000
或者在那个八叉树或四叉树数据结构中，
--and we want to go visit all the nodes. 00:16:52,000 --> 00:16:54,000
我们想去访问所有节点。
--So the way you can think of this is that we take all of the stars, 00:16:54,000 --> 00:16:57,000
所以你可以这样想，我们把所有的星星都拿走，
--if we want to do it dynamically, purely dynamically, 00:16:57,000 --> 00:17:00,000
如果我们想动态地，纯动态地，
--we would have little data structures that would describe each of these tasks, 00:17:00,000 --> 00:17:05,000
我们几乎没有数据结构来描述这些任务中的每一个，
--and we could put them all into some work queue. 00:17:05,000 --> 00:17:09,000
我们可以将它们全部放入某个工作队列中。
--So think of a big queue, throw all the work into the queue, 00:17:09,000 --> 00:17:13,000
所以想到一个大队列，把所有的工作都扔进队列里，
--and now you have worker threads. 00:17:13,000 --> 00:17:16,000
现在你有了工作线程。
--So if we have, say, four cores and each one has a thread, 00:17:16,000 --> 00:17:20,000
因此，如果我们有四个内核，每个内核都有一个线程，
--then when they want some work, they'll go find something in the queue, 00:17:20,000 --> 00:17:23,000
然后当他们需要一些工作时，他们会在队列中找东西，
--and they'll just go grab something out of the queue. 00:17:23,000 --> 00:17:27,000
他们会从队列中拿走一些东西。
--So that's another way to think of this. 00:17:27,000 --> 00:17:32,000
所以这是另一种思考方式。
--So, all right, now I'll get back to my question before. 00:17:32,000 --> 00:17:37,000
那么，好吧，现在我将回到我之前的问题。
--Any concerns about this performance-wise? 00:17:37,000 --> 00:17:39,000
对这种性能有任何担忧吗？
--Functionally, this is fine. 00:17:39,000 --> 00:17:41,000
从功能上讲，这很好。
--But how fast do you think this will run? 00:17:41,000 --> 00:17:46,000
但是你认为这会运行多快？
--I'm not looking for an exact number. 00:17:46,000 --> 00:17:48,000
我不是在寻找确切的数字。
--If you look at this, is there something that makes you, 00:17:48,000 --> 00:17:51,000
如果你看这个，是不是有什么东西让你，
--if you ran this and it was surprisingly slow, 00:17:51,000 --> 00:17:55,000
如果你运行它并且它出奇地慢，
--that might make sense to you. 00:17:55,000 --> 00:17:57,000
这对你来说可能有意义。
--And why might that be? 00:17:57,000 --> 00:17:59,000
为什么会这样？
--Yeah? 00:17:59,000 --> 00:18:00,000
是的？
--If the tasks are taking roughly the same amount of time, 00:18:00,000 --> 00:18:02,000
如果任务花费的时间大致相同，
--there's going to be a lot of threads pending for that lock, 00:18:02,000 --> 00:18:04,000
会有很多线程等待那个锁，
--so they can't get more work until a certain thread. 00:18:04,000 --> 00:18:07,000
所以他们不能得到更多的工作，直到某个线程。
--Right, so the question is, 00:18:07,000 --> 00:18:11,000
对了 那么问题来了
--how long is it going to really take to do the work for a task? 00:18:11,000 --> 00:18:15,000
完成一项任务真正需要多长时间？
--So we're giving each, the task size is one iteration in this case, 00:18:15,000 --> 00:18:20,000
所以我们给每一个，在这种情况下，任务大小是一次迭代，
--and if that work, for test primality, 00:18:21,000 --> 00:18:25,000
如果那有效，为了测试素数，
--if that just takes a very small amount of time, 00:18:25,000 --> 00:18:27,000
如果这只需要很短的时间，
--then almost immediately you're going to go back and ask for another task. 00:18:27,000 --> 00:18:31,000
然后你几乎马上就会回去要求另一项任务。
--And when you do that, there's a lock that's protecting that structure. 00:18:31,000 --> 00:18:35,000
当你这样做时，会有一把锁保护那个结构。
--So we could end up in a situation where 00:18:35,000 --> 00:18:37,000
所以我们可能会遇到这样的情况
--the threads are frequently contending for each other 00:18:37,000 --> 00:18:40,000
线程经常相互竞争
--or spending a lot of time trying to grab locks. 00:18:40,000 --> 00:18:44,000
或者花很多时间试图抢锁。
--So this is called a fine-grained dynamic assignment, 00:18:44,000 --> 00:18:51,000
所以这被称为细粒度动态赋值，
--where in the extreme, you know, 00:18:51,000 --> 00:18:54,000
在极端的地方，你知道，
--tasks are normally things that make sense intuitively to the programmer 00:18:54,000 --> 00:19:00,000
任务通常是程序员凭直觉就能理解的事情
--based on what the program's operating on, 00:19:00,000 --> 00:19:02,000
基于程序的运行，
--for example, stars in the galaxy simulation, 00:19:02,000 --> 00:19:05,000
例如，银河模拟中的恒星，
--or something like that, maybe elements in a grid. 00:19:05,000 --> 00:19:09,000
或类似的东西，也许是网格中的元素。
--So you may start off thinking, 00:19:09,000 --> 00:19:11,000
所以你可能会开始想，
--okay, here are my tasks. 00:19:11,000 --> 00:19:13,000
好的，这是我的任务。
--Throw the tasks into the queue. 00:19:13,000 --> 00:19:15,000
将任务放入队列。
--Let's let it run. 00:19:15,000 --> 00:19:16,000
让我们让它运行。
--Oh, boy, the performance is really disappointing. 00:19:16,000 --> 00:19:18,000
哦，男孩，表现真是令人失望。
--It's not very fast. 00:19:18,000 --> 00:19:20,000
它不是很快。
--But how could we fix this? 00:19:20,000 --> 00:19:22,000
但是我们怎么解决这个问题呢？
--So for this specific code, 00:19:22,000 --> 00:19:24,000
所以对于这个特定的代码，
--is there a simple thing you can do to this to make it faster? 00:19:24,000 --> 00:19:27,000
有什么简单的事情可以使它更快吗？
--Yep. 00:19:27,000 --> 00:19:28,000
是的。
--You could have each, like, 00:19:28,000 --> 00:19:30,000
你可以拥有每一个，比如，
--instead of computing only one, or checking only one prime, 00:19:30,000 --> 00:19:34,000
而不是只计算一个，或只检查一个素数，
--you could have it check, like, five, 00:19:34,000 --> 00:19:37,000
你可以让它检查，比如，五，
--and then that way they'll ask for locks less frequently. 00:19:37,000 --> 00:19:42,000
这样他们就不会那么频繁地要求锁了。
--Right, yep, that's right. 00:19:42,000 --> 00:19:44,000
对，对，没错。
--So, in fact, before I go and talk about that, 00:19:44,000 --> 00:19:46,000
所以，事实上，在我去谈论那个之前，
--so here's just a visualization of, 00:19:46,000 --> 00:19:48,000
所以这只是一个可视化，
--if we're going, if we're doing what's in this code here, 00:19:48,000 --> 00:19:52,000
如果我们要去，如果我们在这里做这段代码中的事情，
--and we are only grabbing one iteration at a time, 00:19:52,000 --> 00:19:55,000
我们一次只抓取一个迭代，
--then what you might see if you measured performance over time, 00:19:55,000 --> 00:19:58,000
那么如果你随着时间的推移衡量表现，你可能会看到什么，
--so this is time going like this, 00:19:58,000 --> 00:20:01,000
所以现在是这样的时间，
--is that the blue parts are time when it's actually doing useful work, 00:20:01,000 --> 00:20:06,000
是蓝色部分是它实际做有用工作的时间，
--and the white parts may be time when it's trying to go grab something off of the queue, 00:20:06,000 --> 00:20:11,000
白色部分可能是它试图从队列中拿东西的时候，
--and, or, you know, trying to grab the lock and access the counter, 00:20:11,000 --> 00:20:14,000
并且，或者，你知道，试图抓住锁并进入柜台，
--and you see a lot of white sections here, 00:20:14,000 --> 00:20:17,000
你在这里看到很多白色的部分，
--so it's possibly losing a lot of time, 00:20:17,000 --> 00:20:19,000
所以它可能会浪费很多时间，
--and this is all Amdahl's Law sequential time, effectively. 00:20:19,000 --> 00:20:23,000
这实际上是阿姆达尔定律的连续时间。
--It's not useful time. 00:20:23,000 --> 00:20:25,000
这不是有用的时间。
--So, an improvement, as she suggested, 00:20:25,000 --> 00:20:28,000
所以，正如她所建议的那样，一个改进，
--is why, instead of grabbing one task, grab up several tasks. 00:20:28,000 --> 00:20:33,000
这就是为什么，不是抢一个任务，而是抢几个任务。
--So, like, for example, we could set it to be 5 or 10 or whatever number, 00:20:33,000 --> 00:20:38,000
因此，例如，我们可以将其设置为 5 或 10 或任何数字，
--and now, when we need work, 00:20:38,000 --> 00:20:41,000
而现在，当我们需要工作时，
--and we go in and grab something from the counter, 00:20:41,000 --> 00:20:45,000
然后我们进去从柜台拿东西，
--we won't just get one iteration, we'll get several iterations, 00:20:45,000 --> 00:20:48,000
我们不会只进行一次迭代，我们将进行多次迭代，
--and now we'll walk over all of them. 00:20:48,000 --> 00:20:52,000
现在我们将遍历所有这些。
--And then the benefit of this is, well, it makes our tasks larger, 00:20:52,000 --> 00:20:57,000
然后这样做的好处是，它使我们的任务变得更大，
--so the sort of white part here, 00:20:57,000 --> 00:21:00,000
所以这里的白色部分，
--where you're wasting time going back and grabbing a new iteration, 00:21:00,000 --> 00:21:03,000
你浪费时间返回并抓住一个新的迭代，
--that happens less frequently. 00:21:03,000 --> 00:21:06,000
这种情况发生的频率较低。
--Okay, so it should decrease that overhead. 00:21:06,000 --> 00:21:10,000
好的，所以它应该减少开销。
--So, what's the downside of doing this? 00:21:10,000 --> 00:21:15,000
那么，这样做的缺点是什么？
--Okay. 00:21:15,000 --> 00:21:16,000
好的。
--Of course, you may get the worst workload distribution you're going to have, most likely. 00:21:16,000 --> 00:21:20,000
当然，您很可能会得到最差的工作负载分配。
--Yeah, so if we make our tasks too large, 00:21:20,000 --> 00:21:23,000
是的，所以如果我们的任务太大，
--then we may have load imbalance problems. 00:21:23,000 --> 00:21:26,000
那么我们可能会遇到负载不平衡问题。
--So, what we want is this nice sweet spot in between, 00:21:26,000 --> 00:21:28,000
所以，我们想要的是介于两者之间的这个甜蜜点，
--where we're spending relatively little overhead going and grabbing tasks, 00:21:28,000 --> 00:21:35,000
我们花费相对较少的开销去抓取任务，
--but we haven't made the tasks so big that we start to have load imbalance happening. 00:21:35,000 --> 00:21:40,000
但是我们还没有把任务做得太大以至于我们开始出现负载不平衡的情况。
--So, this is another really important lesson for parallel programming, 00:21:40,000 --> 00:21:47,000
所以，这是并行编程的另一个非常重要的教训，
--which is many novice parallel programmers think, 00:21:47,000 --> 00:21:51,000
许多新手并行程序员认为，
--okay, there's static and there's dynamic, 00:21:51,000 --> 00:21:54,000
好吧，有静态的，也有动态的，
--and when it's dynamic, a task is something that I grab, 00:21:54,000 --> 00:21:57,000
当它是动态的，任务就是我抓住的东西，
--but then these programs suffer from a whole lot of runtime overhead. 00:21:57,000 --> 00:22:02,000
但是这些程序会遭受大量的运行时开销。
--So, you should realize that this is a knob, 00:22:02,000 --> 00:22:05,000
所以，你应该意识到这是一个旋钮，
--and you can adjust the number of tasks that you grab each time. 00:22:05,000 --> 00:22:09,000
您可以调整每次抓取的任务数量。
--And so, that's a really powerful way to balance the overhead versus load balancing tradeoffs. 00:22:09,000 --> 00:22:17,000
因此，这是平衡开销与负载平衡权衡的一种非常有效的方法。
--Okay, so to summarize what we were just saying, 00:22:17,000 --> 00:22:20,000
好的，总结一下我们刚才说的，
--within this spectrum of setting the grain size for dynamic scheduling, 00:22:20,000 --> 00:22:27,000
在为动态调度设置粒度的范围内，
--on the one hand, we want to have at least, 00:22:27,000 --> 00:22:31,000
一方面，我们希望至少，
--we don't want to have so few tasks or such large tasks that we start to hurt load balance. 00:22:31,000 --> 00:22:38,000
我们不希望有太少的任务或如此大的任务，以至于我们开始损害负载平衡。
--So, that is going to cause you to want to have smaller tasks. 00:22:38,000 --> 00:22:42,000
因此，这将导致您想要完成较小的任务。
--At the same time, we want to minimize overhead, 00:22:42,000 --> 00:22:45,000
同时，我们希望尽量减少开销，
--and that will cause you to want to have larger tasks. 00:22:45,000 --> 00:22:48,000
这会让你想要完成更大的任务。
--Like many things in parallel programming, the ends of the spectrum are not good. 00:22:48,000 --> 00:22:52,000
与并行编程中的许多事情一样，频谱的两端并不好。
--It's somewhere in between. 00:22:52,000 --> 00:22:54,000
它介于两者之间。
--There's a sweet spot in the middle, and that's where you want to be. 00:22:54,000 --> 00:22:59,000
中间有一个甜蜜点，那就是你想去的地方。
--Okay, now, for fun, now that we've talked about that, 00:22:59,000 --> 00:23:05,000
好吧，现在，为了好玩，既然我们已经讨论过了，
--let's look at another scenario here, 00:23:05,000 --> 00:23:07,000
让我们看看这里的另一种情况，
--which is we have, say, a collection of work, 00:23:07,000 --> 00:23:11,000
也就是说，我们有一组作品，
--and we throw it all into our queue, and it's not predictable, 00:23:11,000 --> 00:23:15,000
然后我们将它们全部放入我们的队列中，这是不可预测的，
--and we enter it into the queue, you know, starting from left to right, 00:23:15,000 --> 00:23:19,000
然后我们将它放入队列中，你知道，从左到右开始，
--you know, so they're all in this order here, 00:23:19,000 --> 00:23:22,000
你知道，所以他们在这里都是这样的顺序，
--and we start handing out tasks, you know, this one gets handed out first, 00:23:22,000 --> 00:23:26,000
然后我们开始分发任务，你知道，这个首先分发，
--then this one, and this one, and this one, 00:23:26,000 --> 00:23:28,000
然后这个，这个，这个，这个，
--and the last task that we hand out is the one over here on the right. 00:23:28,000 --> 00:23:32,000
我们分发的最后一项任务是这里右边的任务。
--So, what could go wrong there? 00:23:32,000 --> 00:23:38,000
那么，那里可能出什么问题了？
--Okay, so we may end up with a picture that looks like this. 00:23:38,000 --> 00:23:43,000
好的，所以我们最终可能会得到一张看起来像这样的图片。
--So, what happened is we did dynamic scheduling, 00:23:43,000 --> 00:23:49,000
所以，发生的事情是我们进行了动态调度，
--and our grain size was often maybe okay, 00:23:49,000 --> 00:23:53,000
我们的晶粒尺寸通常可能还可以，
--but we got a little unlucky, 00:23:53,000 --> 00:23:56,000
但我们有点不走运，
--and the last task that we handed out here is going to run for a long time, 00:23:56,000 --> 00:24:01,000
我们在这里分发的最后一个任务将运行很长时间，
--and then the other processors finished relatively quickly after we started that task, 00:24:01,000 --> 00:24:06,000
然后其他处理器在我们开始该任务后相对较快地完成，
--so now everyone has to sit around and wait for that big task to finish. 00:24:06,000 --> 00:24:10,000
所以现在每个人都必须坐下来等待那个大任务完成。
--So, that was unfortunate. 00:24:11,000 --> 00:24:14,000
所以，那是不幸的。
--So, how can we address this? 00:24:14,000 --> 00:24:17,000
那么，我们该如何解决呢？
--Well, first of all, if there was a way to break up that big task a bit more, that would be nice, 00:24:17,000 --> 00:24:21,000
好吧，首先，如果有办法将这个大任务再分解一点，那就太好了，
--but maybe that's not practical for some reason, 00:24:21,000 --> 00:24:24,000
但也许出于某种原因这不切实际，
--maybe there's not a good way to do that. 00:24:24,000 --> 00:24:28,000
也许没有一个好的方法来做到这一点。
--Let's see. 00:24:28,000 --> 00:24:29,000
让我们来看看。
--So, what would have been a better way to have handled this queue? 00:24:29,000 --> 00:24:36,000
那么，处理这个队列的更好方法是什么？
--The work queue. 00:24:36,000 --> 00:24:38,000
工作队列。
--Maybe you can assign a priority to the tasks and schedule them that way. 00:24:38,000 --> 00:24:45,000
也许您可以为任务分配优先级并以此方式安排它们。
--Yeah, so if we had some way of knowing ahead of time that this was a large task, 00:24:45,000 --> 00:24:52,000
是的，所以如果我们有办法提前知道这是一项艰巨的任务，
--it would have been better to have handed it out early rather than at the end. 00:24:52,000 --> 00:24:57,000
早点分发比最后分发要好。
--So, if we had done the same work and had handed it out first, 00:24:57,000 --> 00:25:03,000
所以，如果我们做了同样的工作并先把它分发出去，
--like to P4 instead of as the last task to P4, 00:25:03,000 --> 00:25:07,000
喜欢 P4 而不是作为 P4 的最后一个任务，
--then the work could have balanced out just fine. 00:25:07,000 --> 00:25:10,000
那么这项工作就可以很好地平衡。
--It would have turned out that P4 would have spent a while operating on that long task, 00:25:10,000 --> 00:25:15,000
事实证明，P4 会花一段时间来完成那项漫长的任务，
--and meanwhile the other threads would have found other tasks to execute on, 00:25:15,000 --> 00:25:19,000
与此同时，其他线程会找到其他任务来执行，
--and it would have been fine. 00:25:19,000 --> 00:25:21,000
那样就好了。
--So, if you think about it, this is getting a little deep into this topic, 00:25:21,000 --> 00:25:27,000
所以，如果你仔细想想，这个话题有点深入了，
--but if the task sizes vary, like in this picture, 00:25:27,000 --> 00:25:33,000
但如果任务大小不同，就像这张照片，
--the optimal way to schedule tasks is that early on in the execution, 00:25:34,000 --> 00:25:39,000
安排任务的最佳方式是在执行的早期，
--it would be nice to have larger tasks, 00:25:39,000 --> 00:25:43,000
有更大的任务会很好，
--because really the only time that you need smaller tasks is at the end. 00:25:43,000 --> 00:25:49,000
因为真正需要较小任务的唯一时间是在最后。
--The point of having larger tasks has this advantage that you minimize run time overhead, 00:25:49,000 --> 00:25:55,000
拥有更大任务的好处是可以最大限度地减少运行时开销，
--and that's great until you get to the end and then, uh-oh, 00:25:55,000 --> 00:25:59,000
这很好，直到你走到尽头，然后，呃，哦，
--you know, the pieces of the puzzle don't fit very nicely anymore, 00:25:59,000 --> 00:26:02,000
你知道，拼图的碎片不再能很好地拼接起来，
--and now I'm wasting some time. 00:26:02,000 --> 00:26:04,000
现在我在浪费一些时间。
--So, in a perfect world, you would start with the big tasks, 00:26:04,000 --> 00:26:07,000
所以，在一个完美的世界里，你会从大任务开始，
--and as you get further and further along, you would start moving to the smaller and smaller tasks. 00:26:07,000 --> 00:26:12,000
随着你走得越来越远，你会开始转向越来越小的任务。
--So, you'd start with big boulders and end up with little grains of sand, 00:26:12,000 --> 00:26:15,000
所以，你会从大石头开始，到小沙粒结束，
--and then it would all hopefully smooth out nicely. 00:26:15,000 --> 00:26:19,000
然后一切都会顺利结束。
--Now, that requires that you have to have some rough knowledge of which ones are bigger or smaller. 00:26:19,000 --> 00:26:26,000
现在，这要求您必须对哪些更大或更小有一些粗略的了解。
--The other way that that insight might be helpful is sometimes you can dynamically adjust the grain size. 00:26:26,000 --> 00:26:32,000
这种洞察力可能有用的另一种方式是有时您可以动态调整粒度。
--So, in our example, a minute ago, I chose a static grain size of 10, 00:26:32,000 --> 00:26:39,000
所以，在我们的示例中，一分钟前，我选择了 10 的静态粒度，
--but you could imagine that if you could potentially adjust that over time 00:26:39,000 --> 00:26:43,000
但你可以想象，如果你可以随着时间的推移调整它
--and start with a larger grain size and then move it down to a smaller grain size, 00:26:43,000 --> 00:26:47,000
并从较大的粒度开始，然后将其向下移动到较小的粒度，
--possibly as you got closer to the end. 00:26:47,000 --> 00:26:51,000
可能当你接近尾声时。
--Okay. Now, here's another important concept to know about, 00:26:51,000 --> 00:26:55,000
好的。现在，还有一个重要的概念需要了解，
--which is when you actually implement dynamic scheduling, 00:26:55,000 --> 00:27:01,000
也就是你真正实现动态调度的时候，
--several slides ago, I'll back up, 00:27:01,000 --> 00:27:05,000
几张幻灯片之前，我会备份，
--so I showed you this picture, which is, I said, 00:27:05,000 --> 00:27:08,000
所以我给你看了这张照片，我说，
--we could take all of our work and throw it into a queue, 00:27:08,000 --> 00:27:12,000
我们可以把我们所有的工作都放到一个队列中，
--and when you need to get work, you go to the queue and you get work. 00:27:12,000 --> 00:27:16,000
当你需要上班时，你去排队，然后你就可以上班。
--And I said that going to the queue frequently is bad, 00:27:16,000 --> 00:27:20,000
而且我说经常去排队不好，
--but even if we're going to the queue relatively less frequently, 00:27:20,000 --> 00:27:23,000
但即使我们去排队的频率相对较低，
--maybe we're not going there crazy frequently, 00:27:23,000 --> 00:27:26,000
也许我们不会经常疯狂地去那里，
--but whenever we go there, if it really is one central queue, 00:27:26,000 --> 00:27:30,000
但无论何时我们去那里，如果它真的是一个中央队列，
--this has some disadvantages, which is, 00:27:30,000 --> 00:27:32,000
这有一些缺点，即
--we have to be communicating with the other threads frequently whenever we do this 00:27:32,000 --> 00:27:37,000
每当我们这样做时，我们必须经常与其他线程通信
--because there's a lock and somebody else has had the lock most recently 00:27:37,000 --> 00:27:41,000
因为有一把锁，而最近有人拿到了这把锁
--and it's going to involve potentially some contention and some overheads. 00:27:41,000 --> 00:27:46,000
并且它可能会涉及一些争用和一些开销。
--So, an alternative to that is instead of having one queue, 00:27:46,000 --> 00:27:51,000
所以，另一种方法是不用一个队列，
--we could split up the queues and give each thread its own work queue. 00:27:51,000 --> 00:27:57,000
我们可以拆分队列并为每个线程分配自己的工作队列。
--So, this is called a distributed work queue. 00:27:57,000 --> 00:28:00,000
所以，这被称为分布式工作队列。
--So, we take the tasks and we have a queue per processor or hardware thread. 00:28:00,000 --> 00:28:09,000
因此，我们接受任务并且每个处理器或硬件线程都有一个队列。
--So, everyone has their own queue and you start off, 00:28:09,000 --> 00:28:13,000
所以，每个人都有自己的队列，你开始吧，
--you take your best guess at how to divide up this work. 00:28:13,000 --> 00:28:16,000
您最好猜测如何划分这项工作。
--That didn't look very good. 00:28:16,000 --> 00:28:17,000
那看起来不太好。
--Okay, well, I divided it up three ways. 00:28:17,000 --> 00:28:20,000
好吧，我把它分成三种方式。
--So, anyway, you populate the queues with some work. 00:28:20,000 --> 00:28:24,000
所以，无论如何，你用一些工作来填充队列。
--Maybe I divide that some more. 00:28:24,000 --> 00:28:26,000
也许我再分一点。
--You take your initial guess at how to divide up the work 00:28:26,000 --> 00:28:30,000
您初步猜测如何分配工作
--and you spread it across the queues, and then they start running. 00:28:30,000 --> 00:28:34,000
然后你把它分布在队列中，然后他们开始运行。
--And now, the nice thing initially is, 00:28:34,000 --> 00:28:37,000
现在，最初的好处是，
--the deal is that the hardware thread will always go to its own queue. 00:28:37,000 --> 00:28:42,000
交易是硬件线程将始终进入自己的队列。
--And sometimes in these computations, 00:28:42,000 --> 00:28:46,000
有时在这些计算中，
--when you're computing on something, it ends up generating more work, 00:28:46,000 --> 00:28:49,000
当你在计算某事时，它最终会产生更多的工作，
--more things to put in a queue. 00:28:49,000 --> 00:28:51,000
更多的事情要排队。
--So, it will always put those back into its own queue. 00:28:51,000 --> 00:28:54,000
因此，它总是会将那些放回自己的队列中。
--So, for much of the execution, this is wonderful 00:28:54,000 --> 00:28:58,000
所以，对于大部分的执行，这是美妙的
--because you have great locality. 00:28:58,000 --> 00:29:00,000
因为你有很大的地方。
--You can go to your queue and no one else is contending for your queue. 00:29:00,000 --> 00:29:05,000
你可以去你的队列，没有其他人在争夺你的队列。
--So, it eliminates the problem of having this contention for a shared queue. 00:29:05,000 --> 00:29:10,000
因此，它消除了对共享队列的争用问题。
--Okay, but as you can probably guess, 00:29:10,000 --> 00:29:13,000
好吧，但正如你可能猜到的那样，
--maybe we use dynamic scheduling when it's difficult 00:29:13,000 --> 00:29:18,000
也许我们在困难的时候使用动态调度
--to do a great job of predicting execution time and carving it up evenly. 00:29:18,000 --> 00:29:23,000
很好地预测执行时间并将其平均分配。
--So, there's a good chance that some hardware threads are going to run out of work. 00:29:23,000 --> 00:29:28,000
因此，很有可能某些硬件线程将无法工作。
--And then what do we do? 00:29:28,000 --> 00:29:30,000
然后我们怎么办？
--Well, so the simple thing to do would be just sit and wait. 00:29:30,000 --> 00:29:34,000
好吧，所以最简单的事情就是坐下来等待。
--You could have a backup work queue for threads that finish early. 00:29:34,000 --> 00:29:40,000
您可以为提前完成的线程准备一个备份工作队列。
--You'd still have to use the lock thing, 00:29:40,000 --> 00:29:43,000
你仍然需要使用锁的东西，
--but they could pull from that queue while the other threads are still working. 00:29:43,000 --> 00:29:48,000
但是他们可以在其他线程仍在工作时从该队列中拉出。
--And because it's likely that not all threads are finished, 00:29:48,000 --> 00:29:53,000
而且因为很可能并非所有线程都已完成，
--you'd have less people contending for the locks. 00:29:53,000 --> 00:29:57,000
争夺锁的人会更少。
--Yeah, so actually, just to maybe try to illustrate what you said, 00:29:57,000 --> 00:30:02,000
是的，所以实际上，也许只是为了说明你所说的话，
--I can imagine creating another queue, like an extra work queue. 00:30:02,000 --> 00:30:07,000
我可以想象创建另一个队列，比如一个额外的工作队列。
--So, maybe I take, I don't know, three quarters of the work and put it in the queues 00:30:07,000 --> 00:30:11,000
所以，也许我拿走了，我不知道，四分之三的工作放在队列中
--and I set aside a quarter of it in another backup queue. 00:30:11,000 --> 00:30:15,000
我将其中的四分之一放在另一个备用队列中。
--You just do it from the other existing work queues. 00:30:32,000 --> 00:30:36,000
您只需从其他现有工作队列中执行即可。
--When a hardware thread runs out of work, it will steal it from the queue of another processor. 00:30:36,000 --> 00:30:42,000
当硬件线程用完工作时，它会从另一个处理器的队列中窃取它。
--So, that means you actually have locks on those queues, 00:30:42,000 --> 00:30:47,000
所以，这意味着你实际上锁定了这些队列，
--but it turns out that for the part of the program, for most of the execution, 00:30:47,000 --> 00:30:52,000
但事实证明，对于程序的一部分，对于大部分的执行，
--only one hardware thread is actually using that lock. 00:30:52,000 --> 00:30:56,000
实际上只有一个硬件线程在使用该锁。
--And it turns out, as you'll learn about later in the class, 00:30:56,000 --> 00:30:59,000
事实证明，正如你稍后将在课堂上了解到的那样，
--you can cache the lock in your primary cache, 00:30:59,000 --> 00:31:02,000
您可以将锁缓存在主缓存中，
--and it'll actually have almost no real overhead to go re-lock a queue 00:31:02,000 --> 00:31:07,000
它实际上几乎没有真正的开销来重新锁定队列
--that you just accessed recently yourself and that no one else has accessed. 00:31:07,000 --> 00:31:11,000
您最近自己刚刚访问过并且没有其他人访问过。
--So, it's okay to put the locks in there, 00:31:11,000 --> 00:31:14,000
所以，把锁放在那里是可以的，
--but the idea is that we can steal work from other queues when we run out of work. 00:31:14,000 --> 00:31:20,000
但我们的想法是，当我们用完工作时，我们可以从其他队列中窃取工作。
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
--So, for hopefully a lot of the execution, we don't have that overhead at all, 00:31:46,000 --> 00:31:50,000
所以，希望很多执行，我们根本没有开销，
--but we still need to be careful about that overhead once it happens. 00:31:50,000 --> 00:31:54,000
但是一旦发生这种开销，我们仍然需要小心。
--We don't want to suddenly shift into this super slow mode once we start having to steal work. 00:31:54,000 --> 00:31:59,000
一旦我们开始不得不窃取工作，我们不想突然切换到这种超慢模式。
--Where does the thread steal the work from? 00:31:59,000 --> 00:32:02,000
线程从哪里窃取工作？
--That's a good question. 00:32:02,000 --> 00:32:04,000
这是个好问题。
--So, later today, I'm going to talk about Cilk, 00:32:04,000 --> 00:32:07,000
所以，今天晚些时候，我要谈谈 Cilk，
--which is a language that implements this in its runtime system, and it does it randomly. 00:32:07,000 --> 00:32:12,000
这是一种在其运行时系统中实现此功能的语言，并且它是随机执行的。
--You could imagine stealing from the thread on your left or something like that and having a cycle, 00:32:12,000 --> 00:32:19,000
你可以想象从你左边的线程或类似的东西中窃取一个循环，
--but doing it randomly is actually probably fine. 00:32:19,000 --> 00:32:23,000
但随机做实际上可能没问题。
--The thing you want to avoid is if you... 00:32:23,000 --> 00:32:25,000
你要避免的事情是，如果你...
--A thing that would be bad, for example, is if everybody said, 00:32:25,000 --> 00:32:28,000
例如，如果每个人都说，
--okay, we're going to steal from thread zero first and then thread one and then thread two. 00:32:28,000 --> 00:32:33,000
好的，我们将首先从线程 0 窃取，然后是线程 1，然后是线程 2。
--Then you'd end up creating other imbalances. 00:32:33,000 --> 00:32:36,000
然后你最终会造成其他不平衡。
--So, either random or something that's likely to be evenly distributed. 00:32:36,000 --> 00:32:43,000
因此，随机或可能均匀分布的东西。
--So, a nice thing about this approach compared to the centralized approach is 00:32:43,000 --> 00:32:48,000
因此，与集中式方法相比，这种方法的一个好处是
--this is a good way to have both good load balancing, because it's dynamic, 00:32:48,000 --> 00:32:54,000
这是同时拥有良好负载平衡的好方法，因为它是动态的，
--but also good locality for most of the execution, 00:32:54,000 --> 00:32:57,000
但也是大部分执行的好地方，
--because until you actually have to start stealing, you're accessing your own work from your own queue. 00:32:57,000 --> 00:33:04,000
因为在您真正开始窃取之前，您是从自己的队列中访问自己的工作。
--So, that's good. 00:33:04,000 --> 00:33:06,000
所以，这很好。
--There are a lot of interesting questions. 00:33:06,000 --> 00:33:08,000
有很多有趣的问题。
--So, it's just asked, which thread should we steal from? 00:33:08,000 --> 00:33:13,000
那么，就问了，我们应该从哪个线程窃取呢？
--Another really interesting question is, how much should we steal? 00:33:13,000 --> 00:33:17,000
另一个非常有趣的问题是，我们应该偷多少？
--So, should we take one task if you steal work, or more than one task, probably? 00:33:17,000 --> 00:33:26,000
那么，如果你偷了工作，我们应该接一个任务，还是接多个任务？
--Yeah, it's better to take more than one task, because if you take one task, 00:33:26,000 --> 00:33:31,000
是的，最好接受不止一项任务，因为如果你接受一项任务，
--odds are you're going to immediately be stealing work again very soon. 00:33:31,000 --> 00:33:35,000
很可能您很快就会立即再次窃取工作。
--So, you... 00:33:35,000 --> 00:33:37,000
那么你...
--There can be more than one idle thread. 00:33:38,000 --> 00:33:41,000
可以有多个空闲线程。
--So, we can't allow more than one task to just one thread, 00:33:41,000 --> 00:33:45,000
所以，我们不能只允许一个线程完成一项以上的任务，
--because then the other thread could start contending for the other task. 00:33:45,000 --> 00:33:50,000
因为那时另一个线程可以开始竞争另一个任务。
--Yeah, so when we truly get to the very end and there's very, very little work left, 00:33:50,000 --> 00:33:55,000
是的，所以当我们真正走到最后，剩下的工作非常非常少时，
--and it's in one queue, then there is going to be a lot of contention as they're trying to grab it. 00:33:55,000 --> 00:34:00,000
它在一个队列中，然后在他们试图抓住它时会有很多争用。
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
--There's a little bit of a slightly non-trivial code there to figure out when you're done, 00:34:44,000 --> 00:34:50,000
那里有一些稍微重要的代码可以确定您何时完成，
--because you're only finished when there are no tasks anywhere. 00:34:50,000 --> 00:34:55,000
因为只有在任何地方都没有任务时你才完成。
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
--So, this may be really helpful for you later on in the class, 00:35:28,000 --> 00:35:31,000
所以，这可能对你以后的课堂很有帮助，
--either maybe in some of the more advanced programming assignments, or very likely in your project. 00:35:31,000 --> 00:35:38,000
可能在一些更高级的编程任务中，或者很可能在您的项目中。
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
--Is the quiz up yet? 00:37:29,000 --> 00:37:32,000
测验结束了吗？
--Oh. 00:37:33,000 --> 00:37:35,000
哦。
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
--So that was the first half of the day, was looking at what we just covered, and then 00:40:05,000 --> 00:40:34,000
所以那是一天的前半部分，在看我们刚刚介绍的内容，然后
--the next step is we're going to look specifically at assignment and scheduling for fork-joined 00:40:35,000 --> 00:40:41,000
下一步是我们将专门研究 fork-joined 的分配和调度
--parallelism. 00:40:41,000 --> 00:40:42,000
并行性。
--So, okay. 00:40:42,000 --> 00:40:43,000
所以，好吧。
--So, you know, one common scenario that we've mostly been talking about so far is you have 00:40:43,000 --> 00:40:53,000
所以，你知道，到目前为止我们主要讨论的一种常见情况是你有
--a collection of data, maybe you have an array of elements, and you just want to apply some 00:40:53,000 --> 00:40:58,000
一个数据集合，也许你有一个元素数组，你只想应用一些
--computation to all the data in your collection, and a loop is a good way to, you know, at 00:40:58,000 --> 00:41:04,000
计算你集合中的所有数据，循环是一个很好的方法，你知道，在
--a high level, we can think of this as just iterating over all the elements in your data. 00:41:04,000 --> 00:41:08,000
在高层次上，我们可以认为这只是迭代数据中的所有元素。
--So, what I've discussed so far has mostly been for this scenario where we have loops 00:41:08,000 --> 00:41:15,000
所以，到目前为止我所讨论的主要是针对我们有循环的场景
--or things like that, mapping computations to data, and that's our data parallel approach. 00:41:15,000 --> 00:41:20,000
或类似的东西，将计算映射到数据，这就是我们的数据并行方法。
--So another approach is that you create explicit threads per processor or hardware thread, 00:41:21,000 --> 00:41:29,000
所以另一种方法是为每个处理器或硬件线程创建显式线程，
--and in software you decide at a higher level how you want to, what you want them to do, 00:41:29,000 --> 00:41:35,000
在软件中，你可以在更高的层次上决定你想怎么做，你想让他们做什么，
--and they can do arbitrarily different things. 00:41:35,000 --> 00:41:37,000
他们可以做任意不同的事情。
--So this works especially well if the code is not simply a matter of mapping the same 00:41:37,000 --> 00:41:42,000
所以如果代码不仅仅是映射相同的问题，那么这特别有效
--computation across a whole lot of data. 00:41:42,000 --> 00:41:45,000
对大量数据进行计算。
--So, now, the thing I want to talk about now is another, you know, one, so how do we write 00:41:45,000 --> 00:41:54,000
所以，现在，我现在想谈的是另一个，你知道，一个，那么我们如何写
--a small amount of code that does something interesting with a large amount of data? 00:41:54,000 --> 00:41:57,000
少量代码对大量数据做一些有趣的事情？
--Well, a loop is one way to go visit a lot of data, but another way is to recurse or 00:41:57,000 --> 00:42:02,000
好吧，循环是访问大量数据的一种方式，但另一种方式是递归或
--have a recursive function that walks over your data. 00:42:02,000 --> 00:42:05,000
有一个遍历你的数据的递归函数。
--Maybe it's a graph or a tree or something like that. 00:42:05,000 --> 00:42:08,000
也许它是一个图表或一棵树或类似的东西。
--So, the interesting thing about that is usually when there's recursion, there are some dependencies 00:42:09,000 --> 00:42:16,000
所以，有趣的是，当有递归时，通常会有一些依赖关系
--as you're recursing. 00:42:16,000 --> 00:42:18,000
当你递归时。
--So you go down into a method, into some procedure, and you maybe have to calculate something 00:42:18,000 --> 00:42:23,000
所以你进入一个方法，进入一些过程，你可能需要计算一些东西
--first before you continue on. 00:42:23,000 --> 00:42:26,000
首先在你继续之前。
--So you can't simply say, oh, all of the things that I visit recursively, just throw them 00:42:26,000 --> 00:42:32,000
所以你不能简单地说，哦，我递归访问的所有东西，就把它们扔掉
--all into one big task queue and do them all independently, because they're not independent. 00:42:32,000 --> 00:42:37,000
全部放入一个大任务队列中并独立完成它们，因为它们不是独立的。
--There are dependencies as you're moving down. 00:42:37,000 --> 00:42:40,000
向下移动时存在依赖关系。
--So, as an example of this, we'll just look at quicksort. 00:42:40,000 --> 00:42:44,000
因此，作为这方面的一个例子，我们将只看快速排序。
--So, here's a very simple version of quicksort where we have, say, pointers to array elements, 00:42:44,000 --> 00:42:52,000
所以，这是一个非常简单的快速排序版本，其中我们有指向数组元素的指针，
--and so we're sorting all the elements within some range, and what we do is we partition 00:42:52,000 --> 00:42:58,000
所以我们对某个范围内的所有元素进行排序，我们所做的就是分区
--this data, and then we can basically recursively subdivide this into two parts. 00:42:58,000 --> 00:43:04,000
这些数据，然后我们基本上可以递归地将其细分为两部分。
--So now we're sorting the left half and the right half separately, and then we keep recursively 00:43:04,000 --> 00:43:09,000
所以现在我们分别对左半部分和右半部分进行排序，然后我们递归地保持
--going down over that again and again. 00:43:09,000 --> 00:43:12,000
一次又一次地谈论它。
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
--Once we've calculated middle, those two things can operate independently, and then once you 00:43:35,000 --> 00:43:41,000
一旦我们计算出中间值，这两件事就可以独立运行，然后一旦你
--get inside of them, they will also create more and more parallelism. 00:43:41,000 --> 00:43:46,000
进入它们内部，它们还将创建越来越多的并行性。
--So if you look at what happens over time, there are these dependencies, but we can quickly, 00:43:46,000 --> 00:43:52,000
所以如果你看看随着时间的推移会发生什么，就会发现这些依赖关系，但我们可以很快，
--after just a few levels, create potentially a lot of parallelism this way. 00:43:52,000 --> 00:43:58,000
在几个级别之后，以这种方式潜在地创建大量并行性。
--Okay. 00:43:58,000 --> 00:43:59,000
好的。
--So that's the scenario we want to talk about today, and then we're going to discuss specifically, 00:43:59,000 --> 00:44:05,000
所以这就是我们今天要谈的场景，然后我们要具体讨论，
--as a case study, we're going to look at what happens inside of Cilk+. 00:44:05,000 --> 00:44:10,000
作为案例研究，我们将了解 Cilk+ 内部发生的情况。
--So Cilk plus is a language developed by a CMU graduate who's a professor at MIT in his 00:44:10,000 --> 00:44:19,000
所以 Cilk plus 是由 CMU 毕业生开发的一种语言，他是麻省理工学院的教授
--group, so Charles Leisherson and friends, and it's in GCC and lots of other compilers. 00:44:19,000 --> 00:44:27,000
组，所以 Charles Leisherson 和朋友，它在 GCC 和许多其他编译器中。
--You've probably, maybe you've even used it already. 00:44:27,000 --> 00:44:30,000
你可能，也许你甚至已经使用过它。
--So first I'm going to talk about the semantics that are the part of the language that's relevant 00:44:30,000 --> 00:44:36,000
所以首先我要谈谈语义是相关语言的一部分
--for today. 00:44:36,000 --> 00:44:37,000
今天。
--So the most important primitives to think about, there's something called Cilk-spawn, 00:44:37,000 --> 00:44:44,000
所以要考虑的最重要的原语，有一种叫做 Cilk-spawn 的东西，
--and then there's also Cilk-sync, which you may or may not use sync, but you would definitely 00:44:44,000 --> 00:44:49,000
然后还有 Cilk-sync，你可能会也可能不会使用同步，但你肯定会
--use Cilk-spawn, and this is about exposing parallelism to the language. 00:44:49,000 --> 00:44:56,000
使用 Cilk-spawn，这是关于向语言公开并行性。
--So the meaning of Cilk-spawn is you put this in front of what would look like a normal 00:44:56,000 --> 00:45:03,000
所以 Cilk-spawn 的意思是你把它放在看起来像正常的东西前面
--procedure call, and the semantics are that you will in fact execute foo, that will happen, 00:45:03,000 --> 00:45:11,000
过程调用，语义是你实际上会执行 foo，那会发生，
--and you will also execute the code after the call of foo, but those two things may proceed 00:45:11,000 --> 00:45:17,000
并且您还将在调用 foo 之后执行代码，但是这两件事可能会继续
--concurrently. 00:45:17,000 --> 00:45:19,000
同时。
--So while foo is executing, the things after the call of foo may execute concurrently with 00:45:19,000 --> 00:45:25,000
所以当 foo 正在执行时，调用 foo 之后的事情可能与
--it. 00:45:25,000 --> 00:45:26,000
它。
--Whether that actually happens concurrently is up to the runtime system, and that's what 00:45:26,000 --> 00:45:31,000
这是否实际上同时发生取决于运行时系统，这就是
--we're going to dig into. 00:45:31,000 --> 00:45:33,000
我们要深入研究。
--Now, sync, what this does is it's a join, where I've used spawn to create potentially 00:45:33,000 --> 00:45:43,000
现在，同步，这是一个连接，在这里我使用 spawn 来创建潜在的
--a lot of concurrency, and now I want to bring all of that, I want to make sure that everything 00:45:43,000 --> 00:45:48,000
很多并发，现在我想带来所有这些，我想确保一切
--has gotten back together again, and what's Cilk-sync will stall until all of the concurrent 00:45:48,000 --> 00:45:56,000
又回到了一起，什么是 Cilk-sync 会停止，直到所有并发
--threads within this procedure have finished. 00:45:56,000 --> 00:45:59,000
此过程中的线程已完成。
--Now, another thing to know is if you don't include one explicitly, the end of every function 00:45:59,000 --> 00:46:06,000
现在，要知道的另一件事是，如果您不明确包含一个函数，则每个函数的结尾
--implicitly includes a sync. 00:46:06,000 --> 00:46:08,000
隐式包含一个同步。
--So you will never return current procedure before you've synced up all of the spawns 00:46:08,000 --> 00:46:14,000
因此，在同步所有 spawn 之前，您永远不会返回当前过程
--that you've created inside of the procedure. 00:46:14,000 --> 00:46:17,000
您在程序内部创建的。
--Okay, so then, that's a high-level picture. 00:46:17,000 --> 00:46:21,000
好的，那么，这是一张高级图片。
--So then, if you want to think about using this to create parallelism, so this is just 00:46:21,000 --> 00:46:26,000
那么，如果你想考虑使用它来创建并行性，那么这只是
--a very simple illustration here. 00:46:26,000 --> 00:46:28,000
这里有一个非常简单的例子。
--So what we might do is call spawn with foo, and then foo can execute concurrently, and 00:46:28,000 --> 00:46:35,000
所以我们可能做的是用 foo 调用 spawn，然后 foo 可以并发执行，并且
--then after that, we want to do var. 00:46:35,000 --> 00:46:38,000
然后在那之后，我们想要做 var。
--So this is a way to tell the Cilk plus runtime system that foo and var can run concurrently. 00:46:38,000 --> 00:46:46,000
所以这是一种告诉 Cilk plus 运行时系统 foo 和 var 可以同时运行的方法。
--Now, as a programmer, you might be tempted to do this. 00:46:46,000 --> 00:46:51,000
现在，作为一名程序员，您可能会想这样做。
--You might say, I want foo and var to run concurrently, so I will do a Cilk-spawn of foo and a Cilk-spawn 00:46:51,000 --> 00:46:58,000
您可能会说，我希望 foo 和 var 同时运行，所以我将执行 foo 的 Cilk-spawn 和 Cilk-spawn
--of var, and then I'll do a sync, because after all, that'll make two things run concurrently, 00:46:58,000 --> 00:47:03,000
 var，然后我会做一个同步，因为毕竟，这会让两件事情同时运行，
--and yes, it does, but also, the main thread now has really nothing to do, so you've actually 00:47:03,000 --> 00:47:10,000
是的，确实如此，而且，主线程现在真的无事可做，所以你实际上已经
--created three potentially concurrent things where one of them is very uninteresting. 00:47:10,000 --> 00:47:14,000
创建了三个可能并发的事物，其中一个非常无趣。
--It's just about to immediately hit the sync. 00:47:15,000 --> 00:47:17,000
它即将立即同步。
--So in fact, if you really wanted to just run foo and var in parallel, it'd probably look 00:47:17,000 --> 00:47:22,000
所以事实上，如果你真的想并行运行 foo 和 var，它可能看起来
--like the first thing and not the second thing, and then here's an example where there are 00:47:22,000 --> 00:47:26,000
喜欢第一件事而不是第二件事，然后这里有一个例子
--four things that you want to run in parallel, so you just have a whole set of spawns, and 00:47:26,000 --> 00:47:31,000
你想并行运行四件事，所以你只有一整套产卵，和
--then something else after it. 00:47:31,000 --> 00:47:33,000
然后是其他东西。
--So this is a way to express potential parallelism to the system, and the system gets to decide 00:47:34,000 --> 00:47:41,000
所以这是一种向系统表达潜在并行性的方法，系统可以决定
--which of those tasks it actually wants to run in parallel and in what order. 00:47:42,000 --> 00:47:47,000
它实际上想要并行运行哪些任务以及以什么顺序运行。
--So this is important to realize. 00:47:50,000 --> 00:47:52,000
所以认识到这一点很重要。
--A Cilk-spawn does not compel the runtime system to actually create any concurrency. 00:47:52,000 --> 00:47:58,000
 Cilk-spawn 不会强制运行时系统实际创建任何并发。
--It could just ignore all of the Cilk-spawns. 00:47:58,000 --> 00:48:01,000
它可以忽略所有 Cilk-spawns。
--In fact, you can take a Cilk program and just ignore every macro in it, Cilk-specific macro, 00:48:01,000 --> 00:48:07,000
事实上，您可以采用 Cilk 程序并忽略其中的每个宏，Cilk 特定的宏，
--and the program will just run normally. 00:48:07,000 --> 00:48:09,000
该程序将正常运行。
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
--As you start doing divide and conquer, you'll eventually reach a point where it doesn't 00:48:52,000 --> 00:48:57,000
当你开始分而治之时，你最终会达到一个分而治之的地步
--make any sense to keep dividing it further. 00:48:57,000 --> 00:49:00,000
继续进一步划分它是有意义的。
--Because once you have more than enough parallelism, you really don't need any more tasks. 00:49:00,000 --> 00:49:05,000
因为一旦您拥有足够多的并行性，您就真的不需要任何更多的任务了。
--But also, if you make your tasks very small, there's going to be a lot of runtime overhead 00:49:05,000 --> 00:49:09,000
而且，如果你让你的任务非常小，就会有很多运行时开销
--for managing these tiny tasks. 00:49:09,000 --> 00:49:11,000
用于管理这些微小的任务。
--So what we do is we say, okay, when the number of elements to sort becomes small enough, 00:49:11,000 --> 00:49:17,000
所以我们所做的就是说，好吧，当要排序的元素数量变得足够小时，
--just do it sequentially, and that will be just a sequential chunk of work. 00:49:17,000 --> 00:49:22,000
只需按顺序进行，这将只是一个连续的工作块。
--But hopefully, we will have already created a whole lot of parallelism above that. 00:49:22,000 --> 00:49:26,000
但希望我们已经在上面创建了大量的并行性。
--So what happens is... 00:49:27,000 --> 00:49:30,000
那么发生的事情是...
--The thing that's different here is we had two calls to quicksort, 00:49:30,000 --> 00:49:34,000
这里不同的是我们有两次调用快速排序，
--and we put a Cilk spawn in front of the first one, and that's telling the system 00:49:34,000 --> 00:49:37,000
我们在第一个之前放了一个 Cilk spawn，这就是在告诉系统
--that those two things can proceed concurrently. 00:49:37,000 --> 00:49:40,000
这两件事可以同时进行。
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
--Would Cilk spawn ever create a thread if there are not enough cores for it? 00:50:06,000 --> 00:50:13,000
如果没有足够的内核，Cilk spawn 会创建一个线程吗？
--I'm about to talk about that. 00:50:13,000 --> 00:50:15,000
我正要谈论那个。
--That's a good question. 00:50:15,000 --> 00:50:17,000
这是个好问题。
--And now, what we're about to do is look under the covers 00:50:17,000 --> 00:50:20,000
现在，我们要做的是深入了解
--at what really happens in the implementation of Cilk+. 00:50:20,000 --> 00:50:24,000
在 Cilk+ 的实施中真正发生了什么。
--So we're going to talk about threads and what it really does with all of them. 00:50:24,000 --> 00:50:28,000
因此，我们将讨论线程及其对所有线程的真正作用。
--So that's a good question. 00:50:28,000 --> 00:50:29,000
所以这是一个很好的问题。
--I'll get to that just very soon. 00:50:29,000 --> 00:50:33,000
我很快就会谈到这一点。
--Okay, so key thing. 00:50:33,000 --> 00:50:35,000
好的，所以关键的事情。
--Remember, in an earlier lecture, I talked about how it's important 00:50:35,000 --> 00:50:38,000
请记住，在之前的讲座中，我谈到了它的重要性
--not to confuse abstraction and implementation, 00:50:38,000 --> 00:50:41,000
不要混淆抽象和实现，
--and this is one of these situations. 00:50:41,000 --> 00:50:44,000
这就是其中一种情况。
--Spawn is not pthread create. 00:50:44,000 --> 00:50:47,000
 Spawn 不是 pthread 创建的。
--It does not mean we are creating a new thread. 00:50:47,000 --> 00:50:50,000
这并不意味着我们正在创建一个新线程。
--It means we're telling the system that this is potential parallelism. 00:50:50,000 --> 00:50:55,000
这意味着我们告诉系统这是潜在的并行性。
--Okay, now, how much parallelism do we want to create? 00:50:55,000 --> 00:51:01,000
好的，现在，我们要创建多少并行度？
--You... 00:51:01,000 --> 00:51:03,000
你...
--So in this picture here, you can see that with divide and conquer, 00:51:03,000 --> 00:51:08,000
所以在这张照片中，你可以看到分而治之，
--we may... 00:51:08,000 --> 00:51:09,000
我们可能...
--In fact, this is dividing it by a factor of two at every level 00:51:09,000 --> 00:51:13,000
事实上，这是在每个级别将其除以二
--if it was dividing it by an even larger factor than that. 00:51:13,000 --> 00:51:16,000
如果它除以比这更大的因素。
--You can imagine that after just a couple of levels of recursion, 00:51:16,000 --> 00:51:19,000
你可以想象在仅仅几层递归之后，
--you're exponentially creating a very large number of tasks. 00:51:19,000 --> 00:51:23,000
您正在以指数方式创建大量任务。
--So how many tasks do we actually need? 00:51:23,000 --> 00:51:26,000
那么我们实际需要多少任务呢？
--Well, we don't need vast numbers of tasks. 00:51:26,000 --> 00:51:29,000
好吧，我们不需要大量的任务。
--You want to have more tasks than you have hardware threads 00:51:29,000 --> 00:51:33,000
您想拥有比硬件线程更多的任务
--because if you don't, then you either have static scheduling 00:51:33,000 --> 00:51:37,000
因为如果你不这样做，那么你要么有静态调度
--or you don't even have enough work. 00:51:37,000 --> 00:51:38,000
或者你甚至没有足够的工作。
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
--I mean, some people think that if you have something 00:51:54,000 --> 00:51:56,000
我的意思是，有些人认为如果你有什么
--like eight times as many tasks as hardware threads, 00:51:56,000 --> 00:52:00,000
比如任务是硬件线程的八倍，
--maybe that's a good number. 00:52:00,000 --> 00:52:01,000
也许这是一个很好的数字。
--Now, your mileage will vary, 00:52:01,000 --> 00:52:03,000
现在，你的里程会有所不同，
--but we're thinking about something in that rough ballpark. 00:52:03,000 --> 00:52:06,000
但我们正在考虑那个粗略的范围内的事情。
--So a non-trivial number, but not a crazy large number of tasks. 00:52:06,000 --> 00:52:11,000
所以一个不平凡的数字，但不是一个疯狂的大量任务。
--Okay. 00:52:11,000 --> 00:52:12,000
好的。
--So we want to create these extra tasks. 00:52:12,000 --> 00:52:16,000
所以我们要创建这些额外的任务。
--Now, let's start with a very naive implementation of Cilk. 00:52:16,000 --> 00:52:22,000
现在，让我们从 Cilk 的一个非常简单的实现开始。
--So let's say we've described the semantics of Cilk 00:52:22,000 --> 00:52:26,000
假设我们已经描述了 Cilk 的语义
--and now you have to go build the run time system. 00:52:26,000 --> 00:52:28,000
现在你必须去构建运行时系统。
--And maybe the first thing you might try is, 00:52:28,000 --> 00:52:31,000
也许你可能会尝试的第一件事是，
--well, spawn sounds like creating a thread 00:52:31,000 --> 00:52:34,000
好吧，spawn 听起来像是在创建一个线程
--and sync sounds like doing joins, 00:52:34,000 --> 00:52:37,000
同步听起来像是在做连接，
--so let's just use pthread create and pthread join for those things. 00:52:37,000 --> 00:52:44,000
所以让我们只使用 pthread create 和 pthread join 来处理这些事情。
--Okay. 00:52:44,000 --> 00:52:45,000
好的。
--Well, so what's going to go wrong here? 00:52:45,000 --> 00:52:49,000
那么，这里会出什么问题呢？
--Yep. 00:52:49,000 --> 00:52:50,000
是的。
--You're going to have a whole bunch of pthreads, 00:52:50,000 --> 00:52:54,000
你将拥有一大堆 pthreads，
--so you're going to have to keep track of a whole bunch of thread states 00:52:54,000 --> 00:52:58,000
所以你将不得不跟踪一大堆线程状态
--and all their different stacks and registers and instruction pointers. 00:52:58,000 --> 00:53:04,000
以及它们所有不同的堆栈、寄存器和指令指针。
--Yep, that's right. 00:53:04,000 --> 00:53:05,000
是的，没错。
--So not only is it a problem, as I mentioned a minute ago, 00:53:05,000 --> 00:53:09,000
所以这不仅是一个问题，正如我刚才提到的，
--we don't necessarily need vast numbers of tasks. 00:53:09,000 --> 00:53:13,000
我们不一定需要大量的任务。
--Threads are even a different story. 00:53:13,000 --> 00:53:16,000
线程甚至是一个不同的故事。
--So a thread is something that probably the operating system 00:53:16,000 --> 00:53:19,000
所以线程可能是操作系统
--or at least the thread run time library has to manage. 00:53:19,000 --> 00:53:23,000
或者至少线程运行时库必须管理。
--And if you end up with more software threads than hardware threads, 00:53:23,000 --> 00:53:29,000
如果你最终得到的软件线程多于硬件线程，
--then you have to pause one thread 00:53:30,000 --> 00:53:34,000
那么你必须暂停一个线程
--and start another thread on the same hardware context, 00:53:34,000 --> 00:53:37,000
并在同一硬件上下文中启动另一个线程，
--and that's non-trivially expensive. 00:53:37,000 --> 00:53:40,000
这非常昂贵。
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
--So in fact, what CilkPlus does is, and this is a good general approach, 00:54:06,000 --> 00:54:12,000
所以实际上，CilkPlus 所做的是，这是一个很好的通用方法，
--is that when you start up the system, 00:54:12,000 --> 00:54:15,000
就是当你启动系统时，
--it will immediately create, using something like pfootcreate, 00:54:15,000 --> 00:54:19,000
它会立即创建，使用类似 pfootcreate 的东西，
--it will create software threads for all of your hardware threads. 00:54:19,000 --> 00:54:23,000
它将为所有硬件线程创建软件线程。
--Each of them gets one software thread. 00:54:23,000 --> 00:54:26,000
他们每个人都有一个软件线程。
--So the way that you deal with new work that's exposed because of a spawn 00:54:26,000 --> 00:54:32,000
因此，您处理因 spawn 而暴露的新工作的方式
--is not that you create a thread. 00:54:32,000 --> 00:54:34,000
不是你创建线程。
--It's that the thread goes and looks at a data structure, which is your task queue. 00:54:34,000 --> 00:54:38,000
就是线程去查看一个数据结构，也就是你的任务队列。
--So what these threads are doing is, 00:54:38,000 --> 00:54:41,000
所以这些线程正在做的是，
--each of these threads is looking for work in some implementation of a work queue, 00:54:41,000 --> 00:54:47,000
这些线程中的每一个都在工作队列的某个实现中寻找工作，
--similar to what we were just talking about before 00:54:47,000 --> 00:54:49,000
类似于我们之前所说的
--when I said we could have these distributed task queues or something like that. 00:54:49,000 --> 00:54:53,000
当我说我们可以拥有这些分布式任务队列或类似的东西时。
--Okay, so for example, if you have a quad core, 00:54:54,000 --> 00:55:00,000
好的，例如，如果你有一个四核，
--like a typical laptop these days might have a quad core, 00:55:00,000 --> 00:55:03,000
就像现在典型的笔记本电脑可能有四核，
--and it probably has two hardware threads with hyper-threading, 00:55:03,000 --> 00:55:08,000
它可能有两个带超线程的硬件线程，
--so maybe you want eight threads. 00:55:08,000 --> 00:55:10,000
所以也许你想要八个线程。
--So CilkPlus will just generate eight threads for you. 00:55:10,000 --> 00:55:14,000
所以 CilkPlus 只会为您生成八个线程。
--Okay, so this is not about creating threads. 00:55:16,000 --> 00:55:21,000
好的，所以这与创建线程无关。
--It's about pointing threads at work to do. 00:55:21,000 --> 00:55:25,000
它是关于指向工作中的线程。
--So now we're going to talk about some more low-level details 00:55:27,000 --> 00:55:30,000
所以现在我们要讨论一些更底层的细节
--about what's going on inside Cilk's runtime system. 00:55:30,000 --> 00:55:33,000
关于 Cilk 运行时系统内部发生的事情。
--What happens when we are executing this code? 00:55:37,000 --> 00:55:40,000
当我们执行这段代码时会发生什么？
--So we want to execute foo and var in parallel. 00:55:40,000 --> 00:55:44,000
所以我们想并行执行 foo 和 var。
--So first, a little bit of terminology. 00:55:45,000 --> 00:55:48,000
首先，了解一些术语。
--So there are two things that can be potentially executed concurrently. 00:55:48,000 --> 00:55:52,000
所以有两件事可以同时执行。
--In this example, both foo and var can be executed concurrently. 00:55:52,000 --> 00:55:57,000
在这个例子中，foo 和 var 可以并发执行。
--And we're going to call foo the spawned child. 00:55:57,000 --> 00:56:01,000
我们将调用 foo 生成的孩子。
--So it's really the method that we're calling immediately, 00:56:01,000 --> 00:56:05,000
所以这真的是我们立即调用的方法，
--but then there's work after it. 00:56:05,000 --> 00:56:07,000
但之后还有工作。
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
--And if we have two hardware threads, which threads should do which one? 00:56:28,000 --> 00:56:33,000
如果我们有两个硬件线程，哪个线程应该执行哪一个？
--Now, at some level, this may seem like a pointless question. 00:56:34,000 --> 00:56:37,000
现在，在某种程度上，这似乎是一个毫无意义的问题。
--Who cares where they're assigned just as long as they run in parallel? 00:56:37,000 --> 00:56:42,000
只要它们并行运行，谁在乎它们被分配到哪里？
--You don't really care, maybe. 00:56:42,000 --> 00:56:44,000
你真的不在乎，也许吧。
--But in general, if we look at... 00:56:44,000 --> 00:56:46,000
但总的来说，如果我们看...
--Remember, as this thing is running, 00:56:46,000 --> 00:56:48,000
记住，当这个东西运行时，
--it's going to be generating more and more potential work. 00:56:48,000 --> 00:56:51,000
它将产生越来越多的潜在工作。
--So we want to have some policy about where we're scheduling things. 00:56:51,000 --> 00:56:55,000
所以我们想制定一些关于我们在哪里安排事情的政策。
--And it turns out that this is interesting. 00:56:55,000 --> 00:56:58,000
事实证明这很有趣。
--So, okay. 00:56:58,000 --> 00:56:59,000
所以，好吧。
--Before I get into the details of how that works, 00:56:59,000 --> 00:57:02,000
在详细介绍其工作原理之前，
--let's just review quickly what happens when you run this on a single thread, 00:57:02,000 --> 00:57:06,000
让我们快速回顾一下在单线程上运行时会发生什么，
--just sequentially under normal execution. 00:57:06,000 --> 00:57:09,000
只是按顺序在正常执行下。
--So if I just got to the point of... 00:57:09,000 --> 00:57:12,000
所以如果我只是到了......
--If I just executed this code, 00:57:12,000 --> 00:57:15,000
如果我只是执行这段代码，
--and there was no Cilk spawn in front of it, 00:57:15,000 --> 00:57:18,000
而且它前面没有 Cilk 产卵，
--what I would normally do is I would go into foo and execute foo, 00:57:18,000 --> 00:57:22,000
我通常会做的是进入 foo 并执行 foo，
--and then I'd return from foo, and then I would do var. 00:57:22,000 --> 00:57:25,000
然后我会从 foo 返回，然后我会做 var。
--And when I'm in foo, when I'm in the middle of executing foo, 00:57:25,000 --> 00:57:31,000
当我在 foo 中，当我正在执行 foo 时，
--the way that I know what to do afterwards and how to get to var 00:57:31,000 --> 00:57:35,000
我知道之后该做什么以及如何到达 var 的方式
--is that in the thread stack, the continuation is there. 00:57:35,000 --> 00:57:39,000
就是在线程栈中，continuation就在那里。
--So this is something you learned about in detail in 2.13. 00:57:39,000 --> 00:57:43,000
所以这是你在 2.13 中详细了解的内容。
--So you know you store the context that you're coming back to, 00:57:43,000 --> 00:57:47,000
所以你知道你存储了你要返回的上下文，
--and that's how you know how to keep going. 00:57:47,000 --> 00:57:50,000
这就是你知道如何继续前进的方式。
--Okay. 00:57:50,000 --> 00:57:52,000
好的。
--So now, of course, if you're in the middle of... 00:57:52,000 --> 00:57:56,000
所以现在，当然，如果你正处于...
--If thread zero is off executing foo, 00:57:56,000 --> 00:57:59,000
如果线程 0 停止执行 foo，
--and so it's off executing foo, 00:57:59,000 --> 00:58:02,000
所以它停止执行 foo，
--and maybe at the time that it got to the Cilk spawn, 00:58:02,000 --> 00:58:05,000
也许在它到达 Cilk 产卵的时候，
--there were no other threads that were looking for work. 00:58:05,000 --> 00:58:09,000
没有其他线程正在寻找工作。
--So it's decided, okay, well, I will just go ahead and do foo, 00:58:09,000 --> 00:58:13,000
所以决定了，好吧，好吧，我就继续做foo，
--and then when I finish it, I will do var. 00:58:13,000 --> 00:58:15,000
然后当我完成它时，我会做 var。
--It doesn't look like any other thread is available, 00:58:15,000 --> 00:58:18,000
它看起来不像任何其他线程可用，
--so I'll just do all the work probably. 00:58:18,000 --> 00:58:20,000
所以我可能会做所有的工作。
--But if in the middle of this thread executing foo, 00:58:20,000 --> 00:58:24,000
但是如果在这个线程执行 foo 的中间，
--maybe now thread one becomes available, 00:58:24,000 --> 00:58:27,000
也许现在线程一可用了，
--and now it wants to do some work. 00:58:27,000 --> 00:58:30,000
现在它想做一些工作。
--Now thread zero is already doing foo, 00:58:30,000 --> 00:58:33,000
现在线程 0 已经在执行 foo，
--so thread one would hopefully figure out how to do var. 00:58:33,000 --> 00:58:36,000
所以第一个线程有希望弄清楚如何做 var。
--So how is it going to figure out how to do var? 00:58:36,000 --> 00:58:39,000
那么它将如何弄清楚如何做 var 呢？
--Well, in theory, maybe you could try to write some stack walking tool 00:58:39,000 --> 00:58:44,000
好吧，理论上，也许你可以尝试编写一些堆栈遍历工具
--and try to go look in the stack of thread zero 00:58:44,000 --> 00:58:48,000
并尝试查看线程 0 的堆栈
--and realize, oh, it's going to return to this address, 00:58:48,000 --> 00:58:51,000
然后意识到，哦，它会回到这个地址，
--and here is parameters in the stack, and maybe I'll steal them, 00:58:51,000 --> 00:58:54,000
这是堆栈中的参数，也许我会窃取它们，
--but then I have to stick something else into the stack 00:58:54,000 --> 00:58:57,000
但后来我不得不把别的东西塞进堆栈
--so when it returns, it doesn't do var also, 00:58:57,000 --> 00:59:00,000
所以当它返回时，它也不会做 var，
--and that would be ugly. 00:59:00,000 --> 00:59:03,000
那将是丑陋的。
--Conceptually, somehow thread one needs to figure out 00:59:03,000 --> 00:59:09,000
从概念上讲，线程一需要弄清楚
--that var is something that it can execute, 00:59:09,000 --> 00:59:12,000
那个 var 是它可以执行的东西，
--and this has to work nicely in some way. 00:59:12,000 --> 00:59:14,000
这必须以某种方式很好地工作。
--So instead of thread zero simply doing a normal call into foo, 00:59:14,000 --> 00:59:19,000
因此，不是线程零简单地对 foo 进行正常调用，
--what it does is it's going to do foo, say, for example, 00:59:19,000 --> 00:59:24,000
它所做的是它将做 foo，例如，
--but before it does that, it's going to put something special into a work queue. 00:59:24,000 --> 00:59:28,000
但在此之前，它会将一些特殊的东西放入工作队列中。
--So it'll say, here's some description of, 00:59:28,000 --> 00:59:32,000
所以它会说，这里有一些描述，
--if another thread wakes up, suddenly becomes idle, 00:59:32,000 --> 00:59:35,000
如果另一个线程醒来，突然变得空闲，
--and needs work to do, I will describe to it 00:59:35,000 --> 00:59:38,000
需要工作要做，我会向它描述
--how it could continue through my continuation point by doing var. 00:59:38,000 --> 00:59:43,000
它如何通过执行 var 来继续我的延续点。
--So you have some nice representation of, 00:59:43,000 --> 00:59:47,000
所以你有一些很好的代表，
--here is how you would continue on beyond the point where I'm working. 00:59:47,000 --> 00:59:52,000
这是你将如何在我工作的地方继续工作。
--Now, if you finish foo, and come back, 00:59:52,000 --> 00:59:57,000
现在，如果你完成 foo，然后回来，
--and notice that this is still in your queue, 00:59:57,000 --> 01:00:00,000
并注意这仍在您的队列中，
--then you simply go back and do that. 01:00:00,000 --> 01:00:02,000
然后您只需返回并执行此操作。
--So the thing that changes is when you return from a procedure for silk spawn, 01:00:02,000 --> 01:00:06,000
所以改变的是当你从产卵程序返回时，
--you don't just return like a normal return, 01:00:06,000 --> 01:00:09,000
你不只是像正常返回一样返回，
--you come back and then you look in your own queue, 01:00:09,000 --> 01:00:11,000
你回来然后查看自己的队列，
--and then you grab something out of it, and that's how you would continue on. 01:00:11,000 --> 01:00:14,000
然后你从中抓取一些东西，这就是你继续前进的方式。
--So there's a little more software overhead to do that. 01:00:14,000 --> 01:00:17,000
因此，执行此操作需要更多的软件开销。
--But the nice thing is now, if this thread, if it becomes idle, 01:00:17,000 --> 01:00:21,000
但现在的好处是，如果这个线程，如果它变得空闲，
--and needs work to do, it will notice, uh-oh, there's nothing in my queue, 01:00:21,000 --> 01:00:26,000
需要工作，它会注意到，呃，我的队列中没有任何东西，
--but now it can go steal work from the other queue. 01:00:26,000 --> 01:00:29,000
但现在它可以从另一个队列中窃取工作。
--So it can go over and look in thread 0's queue and say, 01:00:29,000 --> 01:00:32,000
所以它可以查看线程 0 的队列并说，
--ah, you have some more work to do, I will grab that, 01:00:32,000 --> 01:00:36,000
啊，你还有一些工作要做，我会抓住那个，
--I'll move it over to my queue, and now I can just start executing it. 01:00:36,000 --> 01:00:41,000
我将把它移到我的队列中，现在我可以开始执行它了。
--So now var has moved over to thread 1, 01:00:41,000 --> 01:00:44,000
所以现在 var 已经转移到线程 1，
--and now they really are running in parallel. 01:00:44,000 --> 01:00:46,000
现在他们真的在并行运行。
--So that's good. 01:00:46,000 --> 01:00:49,000
所以这很好。
--Any questions about that? 01:00:49,000 --> 01:00:53,000
有什么问题吗？
--So why not instead put foo on the queue and then continue with var? 01:00:53,000 --> 01:00:59,000
那么，为什么不将 foo 放入队列，然后继续使用 var 呢？
--Great. 01:00:59,000 --> 01:01:01,000
伟大的。
--So that's exactly what we're going to talk about next. 01:01:01,000 --> 01:01:04,000
这正是我们接下来要讨论的内容。
--That's a very good question. 01:01:04,000 --> 01:01:07,000
这是一个很好的问题。
--So I just sort of arbitrarily perhaps said 01:01:07,000 --> 01:01:11,000
所以我只是武断地说
--that thread 0 was going to do foo and put var on the queue. 01:01:11,000 --> 01:01:16,000
线程 0 将执行 foo 并将 var 放入队列。
--But it would have been equally valid to do it the other way around. 01:01:16,000 --> 01:01:19,000
但反过来也同样有效。
--I could have put foo on the queue and just done var. 01:01:19,000 --> 01:01:22,000
我本可以将 foo 放入队列中，然后完成 var。
--So now we're actually going to discuss this for a while, 01:01:22,000 --> 01:01:25,000
所以现在我们实际上要讨论一下这个，
--and just see which of these makes more sense. 01:01:25,000 --> 01:01:28,000
看看哪一个更有意义。
--So there are interesting tradeoffs between those two approaches. 01:01:28,000 --> 01:01:31,000
因此，这两种方法之间存在有趣的权衡。
--So our choices are either do foo first, which is our child. 01:01:31,000 --> 01:01:40,000
所以我们的选择是先做 foo，这是我们的孩子。
--So in our terminology, that's our child. 01:01:40,000 --> 01:01:45,000
所以用我们的术语来说，那就是我们的孩子。
--So we would do the child first, or we would do var, 01:01:45,000 --> 01:01:49,000
所以我们会先做孩子，或者我们会做 var，
--and that's the continuation. 01:01:49,000 --> 01:01:51,000
这就是延续。
--So it's either continuation first or child first, 01:01:51,000 --> 01:01:55,000
所以它要么是延续优先，要么是孩子优先，
--and whichever one thread 0 is going to actually do, 01:01:55,000 --> 01:01:58,000
并且无论线程 0 实际要做什么，
--it's going to put the other one into its queue, 01:01:58,000 --> 01:02:01,000
它会将另一个放入队列中，
--and then that's the thing that will be stolen by another thread. 01:02:01,000 --> 01:02:05,000
然后这就是将被另一个线程窃取的东西。
--So if you do the continuation first, another thread will steal the child. 01:02:05,000 --> 01:02:10,000
所以如果你先做延续，另一个线程会偷走孩子。
--If you do the child first, the other thread will steal the continuation. 01:02:10,000 --> 01:02:14,000
如果你先做孩子，另一个线程会窃取延续。
--But basically, either foo or var, one of them you do, 01:02:14,000 --> 01:02:17,000
但基本上，无论是 foo 还是 var，你都会做其中之一，
--and one of them you put in your queue. 01:02:17,000 --> 01:02:19,000
其中一个是您放入队列中的。
--Does that choice matter? 01:02:19,000 --> 01:02:25,000
这个选择重要吗？
--Okay, so let's look first at doing the continuation first. 01:02:25,000 --> 01:02:30,000
好吧，让我们先看看做延续。
--This is the opposite of what I described a little while ago. 01:02:30,000 --> 01:02:33,000
这与我刚才描述的相反。
--So what if we actually did do the equivalent of var first? 01:02:33,000 --> 01:02:37,000
那么，如果我们确实首先执行了与 var 等效的操作呢？
--Now, to make this more interesting, I'm not just going to have two things. 01:02:37,000 --> 01:02:40,000
现在，为了让这更有趣，我不会只做两件事。
--I'm going to have a loop. 01:02:40,000 --> 01:02:42,000
我要有一个循环。
--I'm going to iterate over n instances where we're going to spawn a foo, 01:02:42,000 --> 01:02:48,000
我将迭代 n 个实例，在这些实例中我们将生成一个 foo，
--and so it's going to tell the system that there are a lot of things 01:02:48,000 --> 01:02:51,000
所以它会告诉系统有很多事情
--you can potentially do in parallel. 01:02:51,000 --> 01:02:54,000
您可以并行进行。
--There are lots of iterations here. 01:02:54,000 --> 01:02:56,000
这里有很多迭代。
--So if we did the continuation first, in practical terms, 01:02:56,000 --> 01:03:01,000
因此，如果我们先进行延续，实际上，
--what would happen over time when we look at our queue? 01:03:01,000 --> 01:03:05,000
当我们查看我们的队列时，随着时间的推移会发生什么？
--So we get to iteration 0, 01:03:05,000 --> 01:03:08,000
所以我们到了第 0 次迭代，
--and we are going to put foo with 0 as the argument into our queue. 01:03:08,000 --> 01:03:14,000
我们将把带有 0 作为参数的 foo 放入我们的队列中。
--So that will go into our queue, and we set that aside, 01:03:14,000 --> 01:03:18,000
所以这将进入我们的队列，我们把它放在一边，
--and then we keep going because we're going to do the continuation 01:03:18,000 --> 01:03:20,000
然后我们继续前进，因为我们要继续
--and not the thing that we would have called, not the child. 01:03:20,000 --> 01:03:23,000
而不是我们所谓的东西，不是孩子。
--So then we go around the loop, hit iteration 1, 01:03:23,000 --> 01:03:26,000
那么我们绕过循环，点击迭代 1，
--and notice, okay, here's another silk spawn. 01:03:26,000 --> 01:03:29,000
注意，好吧，这是另一个丝产卵。
--Now I put foo 1 in the queue, and foo 2, and so on. 01:03:29,000 --> 01:03:34,000
现在我将 foo 1 和 foo 2 放入队列中，依此类推。
--So what it would do, in effect, is it would run through the loop 01:03:35,000 --> 01:03:40,000
所以它会做什么，实际上，它会在循环中运行
--and queue up all of the calls to foo that you see inside of the loop. 01:03:40,000 --> 01:03:46,000
并将您在循环内看到的所有对 foo 的调用排队。
--Okay, so this is a little bit like breadth-first traversal of the call graph 01:03:46,000 --> 01:03:50,000
好的，所以这有点像调用图的广度优先遍历
--because it's going to kind of eagerly put all of the work 01:03:50,000 --> 01:03:55,000
因为它会急切地把所有的工作
--that you're about to call at a certain level into the queue right away. 01:03:55,000 --> 01:04:00,000
您即将在某个级别呼叫到队列中。
--So that's what this does. 01:04:00,000 --> 01:04:03,000
这就是它的作用。
--One thing to notice about this is if you think about the order 01:04:03,000 --> 01:04:07,000
需要注意的一件事是，如果您考虑顺序
--in which things would be executed, 01:04:07,000 --> 01:04:09,000
事情将在其中执行，
--this is not going to be that similar to sequential execution. 01:04:09,000 --> 01:04:13,000
这与顺序执行不会那么相似。
--Normally in sequential execution, when you call a method, 01:04:13,000 --> 01:04:17,000
通常在顺序执行中，当你调用一个方法时，
--you do that method first, and then you come back and do the thing after it. 01:04:17,000 --> 01:04:20,000
你先做那个方法，然后你回来做它之后的事情。
--But here, we're potentially going to reorder that by the call. 01:04:20,000 --> 01:04:26,000
但在这里，我们可能会通过电话重新排序。
--Now, in fact, these are currently parallel, so there's concurrency there anyway. 01:04:26,000 --> 01:04:31,000
现在，事实上，这些目前是并行的，所以无论如何都存在并发性。
--So that's if we do the continuation first. 01:04:31,000 --> 01:04:34,000
如果我们先进行延续，那就是这样。
--Now what would happen in the other scenario? 01:04:34,000 --> 01:04:36,000
现在在另一种情况下会发生什么？
--What if we do the child first, meaning that we are going to actually do foo. 01:04:36,000 --> 01:04:42,000
如果我们先做 child 会怎样，这意味着我们实际上要做 foo。
--Sorry, we're actually going to do the foo sub i call immediately, 01:04:42,000 --> 01:04:47,000
抱歉，我们实际上要立即执行我调用的 foo sub，
--and the thing that will queue up is the continuation 01:04:47,000 --> 01:04:51,000
排队的是续集
--of what would happen in the iteration after that point. 01:04:51,000 --> 01:04:55,000
在那一点之后的迭代中会发生什么。
--So what would happen here is the thread reaches the Cilk spawn. 01:04:55,000 --> 01:05:02,000
所以这里会发生的是线程到达 Cilk spawn。
--The thing that it puts into its queue is something that says, 01:05:02,000 --> 01:05:06,000
它放入队列的东西是这样说的，
--oh, this corresponds to being right here with i equal to zero. 01:05:06,000 --> 01:05:14,000
哦，这相当于就在这里，我等于零。
--So then what it would do is it would then go do foo sub i, foo sub zero. 01:05:14,000 --> 01:05:21,000
那么它会做的是它会去做 foo sub i, foo sub zero。
--And when it comes back, it would realize, 01:05:22,000 --> 01:05:24,000
当它回来时，它会意识到，
--okay, now I'm just past that point in the loop, 01:05:24,000 --> 01:05:27,000
好的，现在我刚刚过了循环中的那个点，
--and now I'll loop around again, and then I will do foo with one as an argument. 01:05:27,000 --> 01:05:35,000
现在我将再次循环，然后我将 foo 与 one 作为参数。
--So this is a bit like depth-first traversal. 01:05:35,000 --> 01:05:38,000
所以这有点像深度优先遍历。
--It's actually likely to visit the methods in the same order 01:05:38,000 --> 01:05:43,000
它实际上很可能以相同的顺序访问这些方法
--that you would visit them in a sequential program. 01:05:43,000 --> 01:05:47,000
您将在顺序程序中访问它们。
--So does it matter which of these ways you do it? 01:05:48,000 --> 01:05:53,000
那么，您采用哪种方式重要吗？
--Any thoughts from these two pictures? 01:05:53,000 --> 01:05:58,000
这两张照片有什么想法吗？
--Yeah? 01:05:58,000 --> 01:05:59,000
是的？
--Well, if you do the second one, if another thread picks up your continuation, 01:05:59,000 --> 01:06:04,000
好吧，如果你做第二个，如果另一个线程接你的继续，
--then you have no work, and you have to wait until some other thread 01:06:04,000 --> 01:06:09,000
那么你没有工作，你必须等到其他线程
--has something to do for you. 01:06:09,000 --> 01:06:11,000
有事要为你做。
--Right. 01:06:11,000 --> 01:06:12,000
正确的。
--So interestingly, if you look at these two pictures, 01:06:12,000 --> 01:06:14,000
有趣的是，如果你看这两张照片，
--if you look at this picture versus this picture from before, 01:06:14,000 --> 01:06:17,000
如果你看看这张照片和之前的这张照片，
--so in this continuation-first approach, at first glance, 01:06:17,000 --> 01:06:22,000
所以在这种持续优先的方法中，乍一看，
--this might look like a much better approach, 01:06:22,000 --> 01:06:24,000
这可能看起来是一个更好的方法，
--because we've just queued up all this work. 01:06:24,000 --> 01:06:27,000
因为我们刚刚对所有这些工作进行了排队。
--So if other threads come in and they need work, 01:06:27,000 --> 01:06:31,000
所以如果其他线程进来并且他们需要工作，
--they can pull some work out of the queue. 01:06:31,000 --> 01:06:33,000
他们可以从队列中抽出一些工作。
--I've put an abundant amount of work into my own queue, 01:06:33,000 --> 01:06:36,000
我已经将大量工作放入自己的队列中，
--and there's a good chance that even if they steal some of the work, 01:06:36,000 --> 01:06:39,000
很有可能即使他们偷了一些工作，
--they'll probably work sitting there still for me to do when I finish doing food, 01:06:39,000 --> 01:06:44,000
当我吃完饭后，他们可能会坐在那里继续工作，让我去做，
--or whichever food I'm doing right now. 01:06:44,000 --> 01:06:46,000
或者我现在正在做的任何食物。
--And if you compare it with this case, what's sitting in my queue? 01:06:46,000 --> 01:06:50,000
如果你将它与这个案例进行比较，我的队列中有什么？
--Only one thing, which is to continue on, and that's it. 01:06:50,000 --> 01:06:54,000
只有一件事，就是继续下去，仅此而已。
--And if somebody steals that, then my queue is empty. 01:06:54,000 --> 01:06:57,000
如果有人偷了它，那么我的队列就空了。
--There's nothing for me to do. 01:06:57,000 --> 01:06:59,000
我没有什么可做的。
--So at first glance, this may seem like the less good approach. 01:06:59,000 --> 01:07:05,000
所以乍一看，这似乎不是很好的方法。
--So any thoughts on that? 01:07:05,000 --> 01:07:07,000
那么对此有什么想法吗？
--Any other? 01:07:07,000 --> 01:07:09,000
任何其他？
--So what do you think SILK does? 01:07:09,000 --> 01:07:12,000
那么您认为 SILK 的作用是什么？
--You may have guessed that I'm setting you up for a surprise. 01:07:12,000 --> 01:07:15,000
你可能已经猜到我是在给你一个惊喜。
--So it does the second thing, actually. 01:07:15,000 --> 01:07:18,000
所以它实际上做了第二件事。
--But one thing about, as you'll see in a second, 01:07:18,000 --> 01:07:23,000
但是有一件事，你马上就会看到，
--the first approach is more eager. 01:07:23,000 --> 01:07:26,000
第一种方法更急切。
--It's going to eagerly queue up lots of things, 01:07:26,000 --> 01:07:29,000
它会急切地排队很多东西，
--and it will potentially do things in a slightly funny order. 01:07:29,000 --> 01:07:32,000
而且它可能会以一种有点滑稽的顺序做事。
--In a way, it's legal, but it will throw lots of work into the queue. 01:07:33,000 --> 01:07:38,000
在某种程度上，这是合法的，但它会把很多工作排入队列。
--But a potential problem is, in fact, that this may cause the queues to grow to be quite large, 01:07:38,000 --> 01:07:44,000
但实际上，一个潜在的问题是，这可能会导致队列变得非常大，
--because it's going to aggressively fill up queues. 01:07:44,000 --> 01:07:47,000
因为它会积极地填满队列。
--Whereas the second one is much more lazy. 01:07:47,000 --> 01:07:50,000
而第二个要懒惰得多。
--It's only putting the minimum amount of work into the queue. 01:07:50,000 --> 01:07:54,000
它只是将最少量的工作放入队列中。
--It's not eagerly filling the queue. 01:07:54,000 --> 01:07:56,000
它并没有急切地填补队列。
--So it turns out, in terms of queue size, 01:07:56,000 --> 01:07:59,000
所以事实证明，就队列大小而言，
--you can make sure that the amount of space in all of the queues 01:07:59,000 --> 01:08:04,000
您可以确保所有队列中的空间量
--is nicely bounded in this child-first approach. 01:08:04,000 --> 01:08:09,000
在这种以孩子为先的方法中有很好的界限。
--And I'm going to then walk through what this looks like for a quick chart, 01:08:09,000 --> 01:08:14,000
然后我将浏览一下这看起来像一个快速图表，
--and you can see why it is that this actually is reasonable. 01:08:14,000 --> 01:08:19,000
你会明白为什么这实际上是合理的。
--Yeah, question there? 01:08:19,000 --> 01:08:20,000
是的，有问题吗？
--Question being asked. 01:08:20,000 --> 01:08:48,000
被问到的问题。
--Okay. 01:08:48,000 --> 01:08:49,000
好的。
--Yeah, so maybe what you're asking is, 01:08:49,000 --> 01:08:51,000
是的，所以也许你要问的是，
--if you just had, like, say, foo and bar, in some sense, 01:08:51,000 --> 01:08:54,000
如果你只是有，比如说，foo 和 bar，在某种意义上，
--if they were really concurrent anyway, 01:08:54,000 --> 01:08:57,000
如果它们真的是并发的，
--does it even matter which one was the continuation and which one was the child? 01:08:57,000 --> 01:09:02,000
哪一个是延续，哪一个是孩子，这有关系吗？
--And according to... 01:09:02,000 --> 01:09:03,000
并且根据...
--Is that what you're asking, partly? 01:09:03,000 --> 01:09:06,000
这就是你要问的部分吗？
--Or is that...? 01:09:06,000 --> 01:09:08,000
还是那是……？
--Well, yeah, that's true. 01:09:08,000 --> 01:09:09,000
嗯，是的，这是真的。
--So for the foo and bar case, it's really somewhat arbitrary 01:09:09,000 --> 01:09:12,000
所以对于 foo 和 bar 的情况，它确实有点武断
--which one I put in this following chart and which one I put after it. 01:09:12,000 --> 01:09:16,000
我把哪一个放在下面的图表中，哪一个放在它后面。
--I could have switched them. 01:09:16,000 --> 01:09:19,000
我本可以切换它们。
--So at some level, semantically, in terms of program correctness, 01:09:19,000 --> 01:09:23,000
所以在某种程度上，语义上，就程序正确性而言，
--it doesn't matter. 01:09:23,000 --> 01:09:24,000
没关系。
--It really doesn't matter which of these two things we do. 01:09:24,000 --> 01:09:27,000
我们做这两件事中的哪一件并不重要。
--So all we're talking about now is, like, run-time performance issues, 01:09:27,000 --> 01:09:30,000
所以我们现在谈论的只是运行时性能问题，
--not correctness. 01:09:30,000 --> 01:09:32,000
不正确。
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
--And let's take a look at QuickSort, the code I showed you before, 01:09:51,000 --> 01:09:55,000
让我们看一下 QuickSort，我之前向您展示的代码，
--and see what happens to the queue. 01:09:55,000 --> 01:09:59,000
看看队列发生了什么。
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
--If it's starting with 200 elements, 01:10:14,000 --> 01:10:16,000
如果它以 200 个元素开始，
--what it'll actually do is it will get in here, 01:10:16,000 --> 01:10:20,000
它实际上会做的是它会进入这里，
--and it'll start in the middle. 01:10:20,000 --> 01:10:22,000
它会从中间开始。
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
--And then what happens with that? 01:11:01,000 --> 01:11:03,000
然后会发生什么？
--Well, then we recurse. 01:11:03,000 --> 01:11:05,000
好吧，那我们递归。
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
--So as we've been recursively going down the levels of recursion, 01:11:21,000 --> 01:11:26,000
因此，当我们递归地降低递归级别时，
--we've been storing some of our work in the queue. 01:11:26,000 --> 01:11:29,000
我们一直在队列中存储我们的一些工作。
--Okay, now... 01:11:29,000 --> 01:11:33,000
好吧，现在...
--All right, so then the way that this works, you have to... 01:11:33,000 --> 01:11:36,000
好吧，那么它的工作方式，你必须......
--This would not work well at all if it weren't for the fact that it does work stealing, 01:11:36,000 --> 01:11:40,000
如果不是因为它确实可以偷窃，这根本就不会奏效，
--and it does it in a specific way. 01:11:40,000 --> 01:11:42,000
它以特定的方式进行。
--So now, let's say we do these other threads, and they need work. 01:11:42,000 --> 01:11:46,000
所以现在，假设我们处理这些其他线程，它们需要工作。
--So what work should they steal? 01:11:46,000 --> 01:11:49,000
那么他们应该偷什么工作呢？
--So in particular... 01:11:49,000 --> 01:11:52,000
所以特别...
--So thread 1 wants to steal some work, and here's some work that it might steal. 01:11:52,000 --> 01:11:57,000
所以线程 1 想要窃取一些工作，这是它可能窃取的一些工作。
--Should it steal the work from this end of the queue or this end of the queue? 01:11:57,000 --> 01:12:02,000
它应该从队列的这一端窃取工作还是从队列的这一端窃取工作？
--The top or the bottom of the queue? 01:12:02,000 --> 01:12:08,000
队列的顶部还是底部？
--Well, top or bottom in the picture. 01:12:08,000 --> 01:12:11,000
好吧，在图片的顶部或底部。
--Higher up and vertically or lower vertically. 01:12:11,000 --> 01:12:14,000
垂直向上或垂直向下。
--Any thoughts? 01:12:14,000 --> 01:12:16,000
有什么想法吗？
--Yeah? 01:12:16,000 --> 01:12:17,000
是的？
--I would say higher, because that way you're taking a bigger task size 01:12:17,000 --> 01:12:21,000
我会说更高，因为那样你就承担了更大的任务规模
--instead of leaving the longer tasks to last. 01:12:21,000 --> 01:12:25,000
而不是让较长的任务持续下去。
--Right. 01:12:25,000 --> 01:12:26,000
正确的。
--Exactly. 01:12:26,000 --> 01:12:27,000
确切地。
--Remember we said it would be better to have larger tasks early on and then smaller ones later. 01:12:27,000 --> 01:12:32,000
请记住，我们说过，最好尽早完成较大的任务，然后再完成较小的任务。
--So that's what CilkPlus does. 01:12:32,000 --> 01:12:34,000
这就是 CilkPlus 所做的。
--It will take the larger task, which is the thing that was queued up earlier, 01:12:34,000 --> 01:12:38,000
会接更大的任务，也就是之前排队的东西，
--and it will actually grab this. 01:12:38,000 --> 01:12:43,000
它实际上会抓住这个。
--So in fact, this thread jumps in also, so it grabs what was on the top, 01:12:43,000 --> 01:12:48,000
所以事实上，这个线程也跳进去了，所以它抓住了最上面的东西，
--this grabs what was over here. 01:12:48,000 --> 01:12:50,000
这抓住了这里的东西。
--And now the nice thing... 01:12:50,000 --> 01:12:51,000
现在好事...
--There are a couple of nice things about this. 01:12:51,000 --> 01:12:53,000
这有一些好处。
--Yeah. 01:12:53,000 --> 01:12:54,000
是的。
--You don't actually inform Cilk how large a task is, right? 01:12:54,000 --> 01:12:58,000
您实际上并没有告知 Cilk 任务有多大，对吧？
--So how would it know? 01:12:58,000 --> 01:13:01,000
那它怎么会知道呢？
--Oh, it doesn't know. 01:13:01,000 --> 01:13:02,000
哦，它不知道。
--It just happens to be... 01:13:02,000 --> 01:13:05,000
它恰好是...
--So it doesn't know how much work is involved with doing the task. 01:13:05,000 --> 01:13:09,000
所以它不知道完成任务涉及多少工作。
--Its policy is just, okay, which end of the work queue do we steal from? 01:13:09,000 --> 01:13:13,000
它的策略是，好吧，我们从工作队列的哪一端窃取？
--It's either the top or the bottom. 01:13:13,000 --> 01:13:15,000
它要么是顶部，要么是底部。
--You pick one or the other. 01:13:15,000 --> 01:13:17,000
你选择一个或另一个。
--So do you steal the most recently enqueued thing or the least recently enqueued thing? 01:13:17,000 --> 01:13:23,000
那么你是窃取最近入队的东西还是最近最少入队的东西？
--And it steals the least recently enqueued task, 01:13:23,000 --> 01:13:26,000
它窃取了最近最少排队的任务，
--the thing that was enqueued longest ago, not most recently. 01:13:26,000 --> 01:13:30,000
排队时间最长的东西，不是最近排队的。
--And that, in this case, is the bigger amount of work. 01:13:30,000 --> 01:13:33,000
而且，在这种情况下，工作量更大。
--Because it turns out that in Divide and Conquer, if you're doing Divide and Conquer, 01:13:33,000 --> 01:13:37,000
因为事实证明在分而治之中，如果你正在做分而治之，
--you enqueue bigger things early and smaller things later. 01:13:37,000 --> 01:13:40,000
你尽早排入更大的东西，然后排入更小的东西。
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
--Okay, and then a question earlier was, 01:14:02,000 --> 01:14:06,000
好的，然后之前的一个问题是，
--which one of the queues does it steal from? 01:14:06,000 --> 01:14:08,000
它从哪个队列中窃取？
--And it does this randomly. 01:14:08,000 --> 01:14:09,000
它随机执行此操作。
--Like, you know, maybe random... 01:14:09,000 --> 01:14:12,000
就像，你知道的，也许是随机的……
--So the only thing that you really want to avoid 01:14:12,000 --> 01:14:14,000
所以你真正想要避免的唯一一件事
--is systematically causing imbalance when you're stealing. 01:14:14,000 --> 01:14:17,000
当你偷东西的时候系统地造成不平衡。
--So if you're doing it randomly, 01:14:17,000 --> 01:14:19,000
所以如果你是随机的，
--odds are that you're probably not causing some systematic problem like that by stealing. 01:14:19,000 --> 01:14:23,000
很可能你可能不会通过偷窃造成像这样的系统性问题。
--Question? 01:14:23,000 --> 01:14:24,000
问题？
--Does Cilk always take the task that was used in the past? 01:14:24,000 --> 01:14:28,000
 Cilk 是否总是接受过去使用的任务？
--Yes. 01:14:28,000 --> 01:14:29,000
是的。
--So there can be algorithms which compute and merge. 01:14:29,000 --> 01:14:33,000
所以可以有计算和合并的算法。
--In that case, newer tasks will be the bigger ones. 01:14:33,000 --> 01:14:38,000
在这种情况下，较新的任务将是更大的任务。
--So wouldn't that be a bit disruptive in that case? 01:14:38,000 --> 01:14:44,000
那么在那种情况下会不会有点破坏性？
--Yeah, potentially. 01:14:44,000 --> 01:14:45,000
是的，有可能。
--So it doesn't actually think about what the size is. 01:14:45,000 --> 01:14:48,000
所以它实际上并没有考虑大小是多少。
--It just takes the things that were enqueued longest ago. 01:14:48,000 --> 01:14:51,000
它只需要排队时间最长的东西。
--This happens to generally work out well as you're going down and dividing across it. 01:14:51,000 --> 01:14:57,000
当您向下并跨越它时，这通常会很好地解决问题。
--Okay, so a couple of advantages of taking the thing from the top are that it tends to... 01:14:57,000 --> 01:15:03,000
好的，所以从顶部拿东西的几个优点是它往往......
--Well, first of all, it's also nice because the thread that owns the queue is busy 01:15:04,000 --> 01:15:10,000
好吧，首先，这也很好，因为拥有队列的线程很忙
--putting things on to this end of the queue. 01:15:10,000 --> 01:15:13,000
把事情放到队列的这一端。
--It also enqueues things down here. 01:15:13,000 --> 01:15:15,000
它也在这里排队。
--So you're not contending for the same end of the queue. 01:15:15,000 --> 01:15:20,000
所以你们不会争夺队列的同一端。
--Other threads are stealing from the top, 01:15:20,000 --> 01:15:22,000
其他线程正在从顶部窃取，
--but the local thread is accessing the bottom of the queue. 01:15:22,000 --> 01:15:25,000
但是本地线程正在访问队列的底部。
--It also tends to be good for locality 01:15:25,000 --> 01:15:28,000
它也往往对当地有好处
--because when you grab something, a big thing, and start dividing it further, 01:15:28,000 --> 01:15:33,000
因为当你抓住某样东西，一件大东西，并开始进一步分割它时，
--spatial locality and dependencies are more likely to be preserved 01:15:33,000 --> 01:15:36,000
空间局部性和依赖性更有可能被保留
--within that contiguous chunk of work, hopefully. 01:15:36,000 --> 01:15:42,000
希望在那连续的工作中。
--So anyway, this works out reasonably well. 01:15:42,000 --> 01:15:46,000
所以无论如何，这很有效。
--They made these choices because it's often used for divide-and-conquer parallelism, 01:15:46,000 --> 01:15:50,000
他们做出这些选择是因为它通常用于分而治之的并行性，
--and this happens to be the right set of choices for divide-and-conquer parallelism. 01:15:50,000 --> 01:15:56,000
这恰好是分而治之并行性的正确选择集。
--Okay, so that's... 01:15:56,000 --> 01:15:58,000
好吧，那就是...
--So I only have, like, two minutes, so that was the more interesting thing to talk about. 01:15:58,000 --> 01:16:02,000
所以我只有大约两分钟的时间，所以这是更有趣的话题。
--The other thing to talk about is sync, 01:16:02,000 --> 01:16:04,000
另一件事要谈的是同步，
--and I'm going to give you a slightly accelerated version of this part of the talk. 01:16:04,000 --> 01:16:11,000
我将为您提供这部分谈话的一个稍微加速的版本。
--So there's really only one important point here. 01:16:11,000 --> 01:16:14,000
所以这里真的只有一点很重要。
--So we talked about what happens at spawn. 01:16:14,000 --> 01:16:17,000
所以我们讨论了 spawn 发生的事情。
--Now what happens here at sync? 01:16:17,000 --> 01:16:19,000
现在这里同步发生了什么？
--At sync time, you have to make sure that all the threads are finished 01:16:19,000 --> 01:16:23,000
在同步时，您必须确保所有线程都已完成
--and that we don't continue on past that point until we know everything is finished. 01:16:23,000 --> 01:16:27,000
在我们知道一切都完成之前，我们不会继续超过那个点。
--So there's a data structure that's keeping track of the fact that 01:16:27,000 --> 01:16:31,000
所以有一个数据结构可以跟踪这个事实
--other things are happening concurrently and they all need to come together. 01:16:31,000 --> 01:16:35,000
其他事情同时发生，它们都需要走到一起。
--So now first of all, one thing to realize... 01:16:35,000 --> 01:16:40,000
所以现在首先要意识到一件事......
--Okay, so we're going to have a picture here, 01:16:40,000 --> 01:16:42,000
好的，所以我们要在这里拍照，
--so all of our threads are working on various things, 01:16:42,000 --> 01:16:45,000
所以我们所有的线程都在处理各种事情，
--and maybe there's a continuation here, 01:16:45,000 --> 01:16:48,000
也许这里有一个延续，
--and we have to somehow figure out that everybody's finished. 01:16:48,000 --> 01:16:51,000
我们必须以某种方式弄清楚每个人都完成了。
--Okay, so first, a really simple case, which is, 01:16:51,000 --> 01:16:54,000
好的，首先，一个非常简单的案例，就是，
--if you put a continuation into your... 01:16:54,000 --> 01:16:58,000
如果你在你的...
--If you did a spawn, if you reached a spawn, 01:16:58,000 --> 01:17:01,000
如果你做了一个出生点，如果你到达了一个出生点，
--and put something into your queue, 01:17:01,000 --> 01:17:04,000
把一些东西放到你的队列中，
--and no other threads stole it from you, 01:17:04,000 --> 01:17:07,000
没有其他线程从你那里偷走它，
--then when you hit the sync, 01:17:07,000 --> 01:17:09,000
然后当你点击同步时，
--you actually don't have to do anything to coordinate with other threads. 01:17:09,000 --> 01:17:13,000
你实际上不需要做任何事情来协调其他线程。
--If you can remember the fact that nobody ever stole from you, 01:17:13,000 --> 01:17:16,000
如果你记得没有人偷过你的东西，
--then there's no other coordination that's needed, 01:17:16,000 --> 01:17:20,000
那么就不需要其他协调了，
--because you actually did all the work yourself, sequentially. 01:17:20,000 --> 01:17:24,000
因为您实际上是按顺序自己完成了所有工作。
--So that's an easy case, but that's probably not a very common case. 01:17:24,000 --> 01:17:28,000
所以这是一个简单的案例，但可能不是很常见的案例。
--So what happens if someone else actually steals it from you? 01:17:28,000 --> 01:17:32,000
那么，如果其他人真的从您那里窃取了它，会发生什么？
--Turns out that there are two interesting choices. 01:17:32,000 --> 01:17:35,000
事实证明，有两个有趣的选择。
--One choice is the thread that originally entered this... 01:17:35,000 --> 01:17:40,000
一个选择是最初进入这个的线程......
--started spawning things, 01:17:40,000 --> 01:17:42,000
开始产卵，
--you could say that that thread is always the one that will finish up. 01:17:42,000 --> 01:17:46,000
你可以说那个线程总是会结束的线程。
--The question is, after the sync, 01:17:46,000 --> 01:17:48,000
问题是，在同步之后，
--on which hardware thread do we continue executing? 01:17:48,000 --> 01:17:51,000
我们继续在哪个硬件线程上执行？
--So one choice is, you spawn off other things, 01:17:51,000 --> 01:17:54,000
所以一个选择是，你产生其他东西，
--and then they all come back, and they coordinate with that original thread. 01:17:54,000 --> 01:17:57,000
然后他们都回来了，他们与原来的线程协调。
--So that's one approach. 01:17:57,000 --> 01:17:59,000
所以这是一种方法。
--That's called a stalling policy. 01:17:59,000 --> 01:18:03,000
这就是所谓的拖延政策。
--Okay, so there's a little animation of that. 01:18:03,000 --> 01:18:06,000
好的，所以有一点动画。
--So for that, you have a little data structure, 01:18:06,000 --> 01:18:08,000
所以为此，你有一点数据结构，
--where you keep track of the fact that somebody stole work from me, 01:18:08,000 --> 01:18:11,000
你在哪里记录有人偷了我的工作，
--I need to remember how many things that were spawned, 01:18:11,000 --> 01:18:14,000
我需要记住产生了多少东西，
--how many things have finished, and acknowledge that they finished, 01:18:14,000 --> 01:18:17,000
有多少事情已经完成，并承认它们已经完成，
--and when you see as many things acknowledging you as you need to see, 01:18:17,000 --> 01:18:21,000
当你看到尽可能多的认可你的东西时，
--then you know that you're finished, and that thread can continue executing. 01:18:21,000 --> 01:18:25,000
然后你知道你已经完成了，那个线程可以继续执行。
--So that's basically how that happens. 01:18:25,000 --> 01:18:28,000
所以这基本上就是这样发生的。
--There's a little animation here, which you can look through later. 01:18:28,000 --> 01:18:31,000
这里有一个小动画，你可以稍后再看。
--And then finally, the other option is a greedy policy, 01:18:31,000 --> 01:18:35,000
最后，另一种选择是贪婪政策，
--which is that the thing that can happen with the interesting thing here 01:18:36,000 --> 01:18:41,000
这是这里有趣的事情可能发生的事情
--is that the thread that continues on after a sync 01:18:41,000 --> 01:18:45,000
是同步后继续的线程
--is not necessarily the same hardware thread 01:18:45,000 --> 01:18:48,000
不一定是同一个硬件线程
--that entered the spawn to begin with. 01:18:48,000 --> 01:18:52,000
一开始就进入了 spawn。
--So in other words, you still have a data structure 01:18:52,000 --> 01:18:55,000
所以换句话说，你仍然有一个数据结构
--that's keeping track of all of the synchronization that needs to occur 01:18:55,000 --> 01:19:00,000
跟踪所有需要发生的同步
--for the sync to be finished, but that thing can move around. 01:19:00,000 --> 01:19:04,000
同步完成，但那东西可以四处移动。
--And so the advantage of that is that the last thread that finishes 01:19:05,000 --> 01:19:10,000
所以这样做的好处是最后一个线程完成
--has actually stolen that structure, 01:19:10,000 --> 01:19:13,000
实际上偷了那个结构，
--so as soon as the last one finishes, it just continues on, 01:19:13,000 --> 01:19:17,000
所以一旦最后一个完成，它就会继续，
--and at that point it's already gotten acknowledgments from the other threads, 01:19:17,000 --> 01:19:20,000
那时它已经得到了其他线程的确认，
--so you don't waste any time then waiting for synchronization. 01:19:20,000 --> 01:19:24,000
所以你不会浪费任何时间等待同步。
--So that's the disadvantage of the first policy, 01:19:24,000 --> 01:19:27,000
这就是第一个策略的缺点，
--which is it sounds simpler to implement, it is simpler to implement, 01:19:27,000 --> 01:19:30,000
听起来实施起来更简单，实施起来更简单，
--but it's a little slower, because by saying 01:19:30,000 --> 01:19:33,000
但它有点慢，因为通过说
--it's always the first thread that continues on, 01:19:33,000 --> 01:19:35,000
它总是第一个继续的线程，
--and it may just be waiting around for someone to come synchronize with it, 01:19:35,000 --> 01:19:39,000
它可能只是在等待某人与它同步，
--whereas the greedy case continues on with whoever just happens to finish last. 01:19:39,000 --> 01:19:44,000
而贪婪的情况会继续发生在恰好最后完成的人身上。
--So it's a little more complexity to implement this, 01:19:44,000 --> 01:19:47,000
所以实现这个有点复杂，
--but that's what Cilk does. 01:19:47,000 --> 01:19:50,000
但这就是 Cilk 所做的。
--It does the greedy approach for performance reasons. 01:19:50,000 --> 01:19:54,000
出于性能原因，它采用贪心方法。
--Okay, so that was the quick version of that. 01:19:54,000 --> 01:19:57,000
好的，这就是它的快速版本。
--And to wrap this up, we looked at fork-joined parallelism 01:19:57,000 --> 01:20:02,000
最后，我们研究了 fork-joined 并行性
--and we saw that there are some interesting trade-offs 01:20:02,000 --> 01:20:05,000
我们看到有一些有趣的权衡
--in terms of how we manage the parallelism, 01:20:05,000 --> 01:20:08,000
就我们如何管理并行性而言，
--and the goal was to have enough tasks but not too many tasks, 01:20:08,000 --> 01:20:12,000
目标是有足够的任务但不是太多的任务，
--and we saw how Cilk does this with continuation stealing 01:20:12,000 --> 01:20:17,000
我们看到了 Cilk 如何通过持续窃取来做到这一点
--and greedy drawings and things. 01:20:17,000 --> 01:20:20,000
和贪婪的图画和东西。
--And that's it for today. 01:20:20,000 --> 01:20:22,000
这就是今天的内容。
