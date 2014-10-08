---
title: Duck.md
---

We have all been there. No matter how many things you try it's still there. Disruptive, frustrating, angering and 
haunting and most above all, unpredictable. The bug from hell. 

You will not be defeated so easily. You are dev! Devs do not cower in the face of any bug, we head first into the 
tests! No matter the project! No matter the bug!

You take a deep breath and rummage around for your secret weapon. Ahah! There it is. You place it on your desk and it 
squeaks under the force of your hand. You stare at it for a moment admiring its adorableness. You straighten its head 
so it faces the monitor.

> You see? 
> On every iteration it receives a stream and a state. 
> To parse, we move the stream along and update its position.
> Then we return a token and a new state 
> To iterate one char we need to call peek()

You squeeze it and it squeaks to acknowledge it has understood what you have said so far.

> We check the string (from the stream) against Regexes here.
> If it matches any of them then we eat (parse) the rest of the string
> In the else we just default to...

Then it hits you... WE HAVEN'T CALLED _stream.next()_ in the else statement. You jump up, you can feel the weight of 8 hours of debugging dropping from you. DUCK YEAH! 

You sit back down and run:

    $ grunt spec 

You stare anxiously as green passing lines echo out. You look at the duck expecting him to turn back and look at you
and empathetically share in your anxiousness, but he only stares ahead. He is obviously way more anxious than you. 
You want to hug him and tell him everything will be okay. Then you see the spec we have been waiting for and its...

*PASSING*

All your stress passes out of you into the ether. You squeeze the duck. It squeaks. A smile forms on your face.
You look at it and say "Once more into the specs old friend"

This is [rubber duck debugging](http://en.wikipedia.org/wiki/Rubber_duck_debugging)

Moments like these happen countless times a project. Projects are never smooth, they only seem that way when replayed. 
8 hours of debugging becomes a 2 line snippet and a mention of that gotcha you should look out for. The end result is 
only 10% of the story. The real skill, the real _how_ of that snippet is the process one went through to find it.

I have started recording my thoughts during a project in a _Duck.md_ file. They look like this:

    ofxTimeline implements some scrolling elements. Pretty sure I can handle the port of ofxPanZoom. 
    Will do that. We can then inherit from it and use it pan around in view ports. 
    Now we need to decide can we achieve one canvas? 
    I think yes. We just need to persist the viewport when editing.

    We can also easily utilize Box2d for panning. The helloworld examples are demonstrative enough of 
    panning. We may need a few different things for different canvases but I think this will all work in the end.

    viewCenter in Box2d is totally linked to the GLviewport. 
    Everytime we pan all we need to do is do make a call to gluOrtho2D which handles clipping planes. 

There are no rules for what you put in these files. They can be debugging moments, a list of pitfalls, explanations of 
development choices, todos you aren't sure should be todos yet, or just random thoughts.

Here are a few examples from my projects; [sqircle/duck.md](https://github.com/sqircle/sqircle/blob/master/Duck.md) 
[ErodosPad/Duck.md](https://github.com/erdosapp/ErdosPad/blob/master/DUCK.md) 
[Erods.web/Duck.md](https://github.com/erdosapp/Erdos.web/blob/master/Duck.md)

Right now my Duck files are a bit gibberishy but over time I expect they will improve. The better I get at writing 
down my thoughts the clearer they become. Clearer thinking equals clearer code.

If you don't have a rubber duck get one. Then talk to it.
