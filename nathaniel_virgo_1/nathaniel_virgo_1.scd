// nathaniel_virgo_1

// original tweet by nathaniel virgo: p={|f,a=1|LFPulse.ar(f)*a*[1,1.01]};{p.(p.(100-p.(1/16,20))+p.(2,1+p.(1/4))-0.5*200)+p.(100-p.(1/8,20),p.(8))*0.1}.play #supercollider

(

SynthDef(\pad,	{

  |xfreq=0,xphase=(1/8),xwidth=20,yfreq=0,yphase=2,zfreq=400,zphase=(1/16),zwidth=40,zmul=4,mul=200|

  Out.ar([0,1], {

    p = {
      |f,a=1|
      LFPulse.ar(f) * a * [1,1.001]
    };

    x = {
      p.(
        xfreq - p.(
          xphase,
          xwidth
        )
      )
    };

    y = {
      p.(
        yfreq, 1 + p.(
          yphase
        )
      )
    };

    z = {
      p.(
        zfreq - p.(
          zphase,
          zwidth
        ),
        p.(zmul)
      )
    };

    p.( x + y - 0.5 * mul ) + z * 0.2;

  });

}).add;

);

// s.prepareForRecord;

(

var tempoclock = TempoClock(1);
var wait_len = 8;

{

  1.do {

    // s.record;

    g = Synth(\pad, [\zfreq, 80, \mul, 0, \zphase, 1/2]);
    wait_len.wait;
    h = Synth(\pad, [\zfreq, 80, \mul, 0, \zphase, 1/8]);
    wait_len.wait;
    i = Synth(\pad, [\zfreq, 80, \mul, 0, \zphase, 1/16]);
    wait_len.wait;

    j = Synth(\pad, [\zfreq, 80, \mul, 0, \zphase, 1/2, \zmul, 1/2]);
    wait_len.wait;
    k = Synth(\pad, [\zfreq, 80, \mul, 0, \zphase, 1/8, \zmul, 1]);
    wait_len.wait;
    l = Synth(\pad, [\zfreq, 80, \mul, 0, \zphase, 1/16, \zmul, 2]);
    wait_len.wait;

    m = Synth(\pad, [\zfreq, 360, \mul, 0, \yphase, 1/2, \zmul, 4]);
    wait_len.wait;
    n = Synth(\pad, [\zfreq, 380, \mul, 0, \yphase, 1/8, \zmul, 8]);
    wait_len.wait;
    o = Synth(\pad, [\zfreq, 320, \mul, 0, \yphase, 1/16, \zmul, 16]);
    wait_len.wait;

    p = Synth(\pad, [\zfreq, 80, \mul, 0, \yphase, 1/2, \zmul, 4]);
    wait_len.wait;
    q = Synth(\pad, [\zfreq, 80, \mul, 0, \yphase, 1/8, \zmul, 4]);
    wait_len.wait;
    r = Synth(\pad, [\zfreq, 80, \mul, 0, \yphase, 1/16, \zmul, 4]);
    wait_len.wait;

    a = Synth(\pad, [\zfreq, 360*2, \mul, 0, \xphase, 1/128, \zmul, 8]);
    wait_len.wait;
    b = Synth(\pad, [\zfreq, 360*2, \mul, 0, \xphase, 1/8, \zmul, 16]);
    wait_len.wait;
    c = Synth(\pad, [\zfreq, 340*2, \mul, 0, \xphase, 1/16, \zmul, 32]);
    wait_len.wait;

    d = Synth(\pad, [\zfreq, 80, \mul, 0, \xphase, 1/2, \zmul, 8]);
    wait_len.wait;
    e = Synth(\pad, [\zfreq, 80, \mul, 0, \xphase, 1/8, \zmul, 8]);
    wait_len.wait;
    f = Synth(\pad, [\zfreq, 80, \mul, 0, \xphase, 1/16, \zmul, 8]);
    wait_len.wait;

    (wait_len*4).wait;

    a.free;
    b.free;
    c.free;
    d.free;
    e.free;
    f.free;
    g.free;
    h.free;
    i.free;
    j.free;
    k.free;
    l.free;
    m.free;
    n.free;
    o.free;
    p.free;
    q.free;
    r.free;

    g = Synth(\pad, [\zfreq, 1300, \mul, 0, \xphase, 1/16, \zmul, 10]);
    wait_len.wait;
    h = Synth(\pad, [\zfreq, 1050, \mul, 0, \xphase, 1/16, \zmul, 10]);
    (wait_len).wait;
    i = Synth(\pad, [\zfreq, 340*2, \mul, 0, \xphase, 1/16, \zmul, 32]);
    (wait_len/2).wait;
    j = Synth(\pad, [\zfreq, 900, \mul, 0, \xphase, 1/16, \zmul, 16]);
    (wait_len).wait;
    k = Synth(\pad, [\zfreq, 1000, \mul, 0, \xphase, 1/16, \zmul, 8]);
    (wait_len*2).wait;

    g.free;
    h.free;
    i.free;
    j.free;
    k.free;

    // s.stopRecording;

  };

}.fork(tempoclock);

);