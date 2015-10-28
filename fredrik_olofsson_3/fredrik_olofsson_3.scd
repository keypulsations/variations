// fredrik_olofsson_3

(

SynthDef(\new_synth,	{

  |
  freq1L=3,freq1R=4,mul1=32,add=64,
  freq2L=4,freq2R=3,mul2=99,
  dur=1,reset=0,
  listA=2,listC=4,listD=3,
  repeats=99,
  denominator=5,
  maxdelaytime=1,
  delaytime=(1/6),
  decaytime=2,
  base=4,masterMul=0.1
  |

  Out.ar([0,1], {

    Compander.ar(CombN.ar(
      in: SyncSaw.ar(
        syncFreq: Saw.ar(
          freq: [freq1L,freq1R],
          mul: mul1,
          add: add
        ),
        sawFreq: Saw.ar(
          freq: [freq2L,freq2R],
          mul: mul2,
          add: Duty.kr(
            dur: dur,
            reset: reset,

            level: flop(Dseq(
              listA!3++listC++listD,
              repeats
              )*(base**(0..4))
            ),
            doneAction: 3
          )
        )
      )/denominator,
      maxdelaytime: maxdelaytime,
      delaytime: 1/6,
      decaytime: decaytime,
      mul: masterMul
    ), thresh: 0.1, mul: 2);

  });

}).add;

);

s.quit;
s.options.memSize = 2.pow(16);
s.boot;
// s.prepareForRecord;
(

var tempoclock = TempoClock(0.5);
var wait_len = 4;

{

  1.do {

    // s.record;

    "a".postln;
    a = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1], inf), \repeats, 2, \dur, 0.5, \add, 68, \masterMul, Prand([0.25,0.5,0.75]/10, inf)).play;
    wait_len.wait;

    "b".postln;
    b = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1].reverse, inf), \repeats, 4, \dur, 1, \add, 68, \masterMul, Prand([0.25,0.5,0.75]/10;, inf)).play;
    (wait_len*2).wait;

    "j".postln;
    j = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1], inf), \repeats, 2, \add, 68, \dur, Pseq([0.5,1,0.25], inf), \masterMul, Pseq(([0.25,0.5,0.75].reverse)/10;, inf)).play;
    wait_len.wait;

    "i".postln;
    i = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1].reverse, inf), \repeats, 4, \add, 68, \dur, Pseq([0.5,1,2], inf), \masterMul, Pseq(([0.25,0.5,0.75].reverse)/10;, inf)).play;
    (wait_len*2).wait;

    "free all".postln;
    a.stop;
    b.stop;
    j.stop;
    i.stop;

    "pitch 1".postln;
    x = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1], inf), \repeats, 4, \add, Prand([300,600,1200], inf), \dur, Pseq([0.5,1,2], inf), \masterMul, Prand([0.25,0.5,0.75]/15, inf)).play;
    k = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1], inf), \repeats, 2, \dur, 1, \add, 68, \masterMul, Prand([0.25,0.5,0.75]/10, inf)).play;
    (wait_len*2).wait;

    "pitch 2".postln;
    y = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1].reverse, inf), \repeats, 4, \add, Prand([250,500,1000]/1.26, inf), \dur, Pseq([0.5,1,2], inf), \masterMul, Prand([0.25,0.5,0.75]/15, inf)).play;
    l = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1].reverse, inf), \repeats, 2, \dur, 0.5, \add, 68, \masterMul, Prand([0.25,0.5,0.75]/10;, inf)).play;
    (wait_len*2).wait;

    "pitch 3".postln;
    z = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1].reverse, inf), \repeats, 4, \add, Prand([200,400,800]/1.5, inf), \dur, Pseq([0.5,1,2], inf), \masterMul, Prand([0.25,0.5,0.75]/15, inf)).play;
    (wait_len*2).wait;

    "more beatz".postln;
    j = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1], inf), \repeats, 1, \add, 68, \dur, Pseq([0.5,1,0.25], inf), \masterMul, Pseq(([0.25,0.5,0.75])/10;, inf)).play;
    (wait_len*2).wait;

    i = Pbind(\instrument, "new_synth", \base, Pseq([0.25,0.5,1].reverse, inf), \repeats, 2, \add, 68, \dur, Pseq([0.5,1,2], inf), \masterMul, Pseq(([0.25,0.5,0.75].reverse)/10;, inf)).play;
    (wait_len*4).wait;

    k.stop;
    y.stop;
    l.stop;
    z.stop;
    j.stop;
    i.stop;
    x.stop;
    (wait_len).wait;

    // s.stopRecording;

  };

}.fork(tempoclock);

);