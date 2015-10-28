// batuhan_bozkurt_1

(
(
SynthDef(\a,
  {
    arg freq,multiplier,rq,dur,randlist,fmul,left,right;
    Out.ar(0,
      LeakDC.ar( // This filter removes DC offset from a signal.
        in: BRF.ar( // A second order band reject filter.
          in: Saw.ar( // Band limited sawtooth.
            freq: freq,
            mul: Decay2.kr( // Exponential decay.
              in: x = Duty.kr( // Demand results from demand rate UGens.
                dur: 1/[8,16,32,64],
                reset: 0,
                level: Drand( // Demand rate random sequence generator.
                  list: [0,Drand((randlist))],
                  repeats: inf
                )
              ),
              attackTime: 0.1,
              decayTime: 0.4
            )
          )**multiplier,
          freq: x * fmul + [left,right],
          rq: rq
        )
      ).tanh
    )
  }
).send(s);
);

(
SynthDef(\b,
  {
    arg freq,multiplier,rq,dur,randlist,fmul,left,right;
    Out.ar(0,
      LeakDC.ar( // This filter removes DC offset from a signal.
        in: BRF.ar( // A second order band reject filter.
          in: Saw.ar( // Band limited sawtooth.
            freq: freq,
            mul: Decay2.kr( // Exponential decay.
              in: x = Duty.kr( // Demand results from demand rate UGens.
                dur: dur,
                reset: 0,
                level: Drand( // Demand rate random sequence generator.
                  list: [0, Drand((randlist))],
                  repeats: inf
                )
              ),
              attackTime: 0.1,
              decayTime: 0.4
            )
          )**multiplier,
          freq: x * fmul + [left,right],
          rq: rq
        )
      ).tanh
    )
  }
).send(s);
);

(
SynthDef(\c,
  {
    arg freq,multiplier,rq,dur,randlist,fmul,left,right;
    Out.ar(0,
      LeakDC.ar( // This filter removes DC offset from a signal.
        in: BRF.ar( // A second order band reject filter.
          in: Saw.ar( // Band limited sawtooth.
            freq: freq,
            mul: Decay2.kr( // Exponential decay.
              in: x = Duty.kr( // Demand results from demand rate UGens.
                dur: 1/[8,16],
                reset: 0,
                level: Drand( // Demand rate random sequence generator.
                  list: [0,Drand((randlist))],
                  repeats: inf
                ),
                doneAction: 0
              ),
              attackTime: 0.1,
              decayTime: 0.2
            )
          )**multiplier,
          freq: x * fmul + [left,right],
          rq: rq
        )
      )
    )
  }
).send(s);
);

(
SynthDef(\d,
  {
    arg freq1,freq2,freq3,freq4,multiplier,rq,dur,randlist,durMult,timeMult;
    Out.ar(0,
      FreeVerb.ar(
        in: LeakDC.ar( // This filter removes DC offset from a signal.
          in: BRF.ar( // A second order band reject filter.
            in: Impulse.ar(
              freq: [[freq1,freq2],[freq3,freq4]]*4,
              mul: Decay2.kr( // Exponential decay.
                in: x = Duty.kr( // Demand results from demand rate UGens.
                  dur: 1/[8,16]*durMult,
                  reset: 0,
                  level: Drand( // Demand rate random sequence generator.
                    list: [0,Drand((randlist))],
                    repeats: inf
                  ),
                  doneAction: 0
                ),
                attackTime: 0.001,
                decayTime: 0.002
              )
            )* multiplier, // no longer an exponential
            freq: x * 20 + [45.1,45],
            rq: rq
          )
        ),
        mix: 0.5,
        damp: 1.0,
        room: 1.0
      )
    )
  }
).send(s);
);

(
SynthDef(\e,
  {
    arg freq1,freq2,freq3,freq4,multiplier,rq,r1,r2,r3,r4;
    Out.ar(0,
      FreeVerb.ar(
        in: LeakDC.ar( // This filter removes DC offset from a signal.
          in: BRF.ar( // A second order band reject filter.
            in: Impulse.ar(
              freq: [[freq1,freq2],[freq3,freq4]]*4,
              mul: Decay2.kr( // Exponential decay.
                in: x = TDuty.kr( // Demand results from demand rate UGens.
                  dur: Dseq([r1,r2,r3,r4], inf)
                ),
                attackTime: 0.01,
                decayTime: 0.02
              )
            )**multiplier,
            freq: x * 20 + [45.1,45],
            rq: rq
          )
        ),
        mix: 0.5,
        damp: 0.5,
        room: 1.0
      )
    )
  }
).send(s);
);

(
SynthDef(\g,
  {
    arg freq1,freq2,freq3,freq4,multiplier,rq;
    Out.ar(0,
      LeakDC.ar( // This filter removes DC offset from a signal.
        in: BRF.ar( // A second order band reject filter.
          in: LFSaw.ar(
            freq: [[freq1,freq2],[freq3,freq4]]*2,
            mul: Decay2.kr( // Exponential decay.
              in: x = TDuty.kr( // Demand results from demand rate UGens.
                dur: Dser([0.1,0.2,0.3,0.2,0.1,0.2,0.1], inf),
                reset: 0,

                doneAction: 0
              ),
              attackTime: 0.01,
              decayTime: 0.02
            )
          )**multiplier,
          freq: x * 10 + [5.1,5],
          rq: rq
        )
      )
    )
  }
).send(s);
);

(
SynthDef(\h,
  {
    arg freq1,freq2,freq3,freq4,multiplier,rq,r1,r2,r3,r4,randlist,fmult,attackTime,decayTime;
    Out.ar(0,
      LeakDC.ar( // This filter removes DC offset from a signal.
        in: BRF.ar( // A second order band reject filter.
          in: LFSaw.ar(
            freq: [[freq1,freq2],[freq3,freq4]]*2,
            mul: Decay2.kr( // Exponential decay.
              in: x = TDuty.kr( // Demand results from demand rate UGens.
                dur: Dser([0.3,0.2,0.1,0.2,0.2,0.2], inf),
                reset: 0,

                doneAction: 0
              ),
              attackTime: attackTime,
              decayTime: decayTime
            )
          )**multiplier,
          freq: x * 20 + [55.1,55],
          rq: rq
        )
      )
    )
  }
).send(s);
);
)

// read a soundfile

r = Buffer.read(s, "/Users/Osetinsky/Desktop/fischers.wav");

(
SynthDef(\schubert, {| out = 0, bufnum = 0, amp |
  var buf = FreeVerb.ar(PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum), loop:1),mix:0.5,room:1.0,damp:1.0,mul:amp);
  Out.ar(out,buf)
}).play(s, [\out, 0, \bufnum, r.bufnum]);
)

t = Buffer.read(s, "/Users/Osetinsky/Desktop/fischerss.wav");

(
SynthDef(\schubertt, {| out = 0, bufnum = 0, amp |
  var buf = FreeVerb.ar(PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum),startPos:500, loop:1),mix:0.5,room:1.0,damp:1.0,mul:amp);
  Out.ar(out,buf)
}).play(s, [\out, 0, \bufnum, t.bufnum]);
)

(
var tempoclock = TempoClock(0.5);
{
  1.do {
    t.free;
    w.free;
    r.free;
    x.free;
    r = Buffer.read(s, "/Users/Osetinsky/Desktop/fischers.wav");
    z = Synth(\e,[\freq1,220,\freq2,220,\freq3,220,\freq4,220,\multiplier,0.01,\rq,1.1,\r1,0.1,\r2,0.2,\r3,0.4,\r4,0.3]);
    4.wait;
    y = Synth(\e,[\freq1,110,\freq2,110,\freq3,110,\freq4,110,\multiplier,0.01,\rq,1.1,\r1,0.3,\r2,0.3,\r3,0.2,\r4,0.4]);
    4.wait;
    z.set(\freq2,261.63);
    3.wait;
    y.set(\freq4,131.5);
    4.wait;
    z.set(\freq1,123.47);
    3.wait;
    y.set(\freq3,261.64);
    2.wait;
    z.set(\freq3,164);
    3.wait;
    y.set(\freq1,330);
    2.wait;
    z.set(\freq4,440);
    3.wait;
    y.set(\freq2,110);
    4.wait;
    a = Synth(\a,[\freq,5,\dur,1/8,\multiplier,1.5,\rq,0.1,\randlist,(0.1,0.2..1),\fmul,20,\left,55.1*2,\right,55*2]);
    8.wait;
    b = Synth(\b,[\freq,10,\dur,1/12,\multiplier,1.5,\rq,0.1,\randlist,(0.1,0.2..1),\fmul,20,\left,55.1,\right,55]);
    8.wait;

    d = Synth(\d,[\freq1,220,\freq2,220,\freq3,220,\freq4,220,\multiplier,1,\rq,2.0,\randlist,(0.1,0.2..1)]);

    {
      var mul = 1, count = 0;
      200.do {
        count = count + 8;
        1.do {
          d.set(\multiplier,mul + count);
          1.wait;
          (mul+count).postln;
        }
      }

    }.fork(TempoClock(4));

    16.wait;

    d.set(\freq4,440);
    2.wait;

    u = Synth(\h,[\freq1,27.5,\freq2,27.4,\freq3,27.3,\freq4,27.6,\multiplier,0.3,\rq,0.01,\attackTime,0.01,\decayTime,0.02]);
    2.wait;

    d.set(\freq2,660);
    4.wait;

    x = Synth(\schubert,[\delayTime,3,\feedback,1,\amp,0.001]);

    {
      var amp = 0.001, count = 0;
      199.do {
        count = count + 0.002;
        1.do {
          x.set(\amp,amp + count);
          1.wait;
          (amp+count).postln;
        }
      }

    }.fork(TempoClock(3));
    8.wait;

    d.set(\freq3,587);
    4.wait;
    d.set(\freq1,523);
    4.wait;
    d.set(\freq2,493);
    3.wait;

    u.set(\attackTime,0.01,\decayTime,0.03);
    2.wait;
    "u".postln;
    u.set(\attackTime,0.01,\decayTime,0.04);
    2.wait;
    "u".postln;
    u.set(\attackTime,0.01,\decayTime,0.05);
    2.wait;
    "u".postln;
    u.set(\attackTime,0.01,\decayTime,0.06);
    2.wait;
    "u".postln;
    u.set(\attackTime,0.01,\decayTime,0.07);
    2.wait;
    "u".postln;
    u.set(\attackTime,0.01,\decayTime,0.08);
    2.wait;
    "u".postln;
    u.set(\attackTime,0.01,\decayTime,0.09);
    2.wait;
    "u".postln;
    u.set(\attackTime,0.01,\decayTime,0.1);

    x.free;
    y.free;
    z.free;
    d.free;
    r.free;
    u.free;
    b.free;

    // build up stronger to this point and drop off more dramatically...

    t = Buffer.read(s, "/Users/Osetinsky/Desktop/fischerss.wav");
    w = Synth(\schubertt,[\delayTime,3,\feedback,1,\amp,0.5]);

  };

}.fork(tempoclock);
)

u = Synth(\h,[\freq1,27.5,\freq2,27.4,\freq3,27.3,\freq4,27.6,\multiplier,0.3,\rq,0.5,\attackTime,0.01,\decayTime,0.9]);
u.set(\attackTime,0.01,\decayTime,0.1); // increase this from 0.02 to 0.1 after mr. schubert comes in

a.free;
b.free;
d.free;
y.free;
z.free;
u.free;

w = Synth(\schubertt,[\delayTime,3,\feedback,1,\amp,0.33]);
a = Synth(\a,[\freq,5,\dur,1/8,\multiplier,1.5,\rq,0.1,\randlist,(0.1,0.2..1),\fmul,20,\left,55.1*2,\right,55*2]);
b = Synth(\b,[\freq,10,\dur,1/12,\multiplier,1.5,\rq,0.1,\randlist,(0.1,0.2..1),\fmul,20,\left,55.1,\right,55]);
c = Synth(\c,[\freq,2,\dur,1/100,\multiplier,1.0,\rq,0.01,\randlist,(1.1,1.2..2),\fmul,10,\left,55.1,\right,55]);
c.free;

a.set(\left,55.1,\right,55);
b.set(\left,110.1,\right,110);
c.set(\left,55,\right,55);

z.set(\r1,0.4,\r2,0.3,\r3,0.2,\r4,0.1);
y.set(\r1,0.1,\r2,0.2,\r3,0.1,\r4,0.1);

z.set(\freq2,261.63*1);

(
o = 220;
z.set(\freq1,o,\freq2,o,\freq3,o,\freq4,o);
y.set(\freq1,o,\freq2,o,\freq3,o,\freq4,o);
)

d.set([\multiplier, 1600,\randlist,(1.1,1.2..2)]);

d = Synth(\d,[\freq1,220,\freq2,220,\freq3,220,\freq4,220,\multiplier,105,\rq,2.0,\randlist,(0.1,0.2..1)]);

(
var tempoclock = TempoClock(4);
{
  var freq = 220, freak = 3520, freek = 220, friek = 220, count = 0;
  200.do {
    count = count + 1;
    1.do {
      d.set(\freq4,freq,\freq3,freak,\freq2,freek,\freq1,friek);
    };
    1.wait;
    freq = freq + 1;
    freq.postln;
    freak = freak * 1/1.01;
    freak.postln;
    freek = freek + 1;
    freek.postln;
    friek = friek * 1.01;
    friek.postln;
  }

}.fork(tempoclock);
)
d.free;