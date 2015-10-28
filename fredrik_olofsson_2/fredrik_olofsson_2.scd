// fredik_olofsson_2

(

SynthDef(\asynth,	{

  |

  freq1=3,mul1=64,add1=99,
  freqArrayL=3,freqArrayR=4,
  freq2=1,mul2=32,add2=128,delaytime=(1/6)

  |

  Out.ar([0,1], {

    CombN.ar(
      in: SinOsc.ar(
        Saw.ar(
          freq: freq1,
          mul: mul1,
          add: add1
        ),
        Saw.ar(
          freq: [freqArrayL,freqArrayR],
          mul: Saw.ar(
            freq: freq2,
            mul: mul2,
            add: add2
          ),
          add: Duty.ar(
            dur: 1,
            reset: 0,
            level: flop(
              Dseq(
                [0,8,1,5]
              )/[8,4,1]
            )
          )
        )
      )/9,
      maxdelaytime: 1,
      delaytime: delaytime
    )
  });
}).add;

);

// s.prepareForRecord;
// s.record;

(

var tempoclock = TempoClock(0.5);
var wait_len = 4;

{

  1.do {

    a = Synth(\asynth);
    a.set(\add1, 1, \freq1, 1, \mul1, 1, \add2, 1, \freq2, 1, \mul2, 1);
    wait_len.wait;

    a.set(\add1, 16, \freq1, 1, \mul1, 1);
    wait_len.wait;
    a.set(\add1, 32, \freq1, 1, \mul1, 1);
    wait_len.wait;

    a.set(\add1, 32, \freq1, 1, \mul1, 16);
    wait_len.wait;
    a.set(\add1, 32, \freq1, 1, \mul1, 32);
    wait_len.wait;

    a.set(\add1, 32, \freq1, 2, \mul1, 32);
    wait_len.wait;
    a.set(\add2, 1, \freq2, 6, \mul2, 10);
    wait_len.wait;

    a.set(\add1, 32, \freq1, 6, \mul1, 32);
    wait_len.wait;
    a.set(\add2, 5, \freq2, 6, \mul2, 25);
    wait_len.wait;

    a.set(\add1, 32, \freq1, 12, \mul1, 64);
    wait_len.wait;
    a.set(\add2, 10, \freq2, 6, \mul2, 50);
    wait_len.wait;

    a.set(\add1, 32, \freq1, 32, \mul1, 128);
    wait_len.wait;
    a.set(\add2, 10, \freq2, 6, \mul2, 100);
    wait_len.wait;

    a.set(\add1, 32, \freq1, 64, \mul1, 128);
    wait_len.wait;
    a.set(\add2, 25, \freq2, 6, \mul2, 250);
    wait_len.wait;

    a.set(\add1, 3, \freq1, 64, \mul1, 99, \add2, 1, \freq2, 32, \mul2, 128);
    wait_len.wait;

    a.set(\add1, 1, \freq1, 1, \mul1, 1, \add2, 1, \freq2, 1, \mul2, 1);
    1.wait;

    a.free;

  };

}.fork(tempoclock);

);

// s.stopRecording;