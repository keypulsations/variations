// jonatan_liljeadhl_3.scd

(

SynthDef(\l_synth,	{
  |
  freq1=1,freq2=1,freq3=1,freq4=1,freak=60,adder=0.15,mul=3,add=100,decaytime=0
  |
  Out.ar([0,0], {

    j=Impulse;

    x=Demand.kr(
      trig: j.kr(
        freq: 1
      ),
      reset: 0,
      demandUGens:
      [Dseq(
        [
          Dseq(list: 0.1/[freq1,freq2,freq3,freq4]+adder,repeats: 1)

        ], inf
        ),
        Dseq(
          [

            Dseq(list: 0.1/[freq1,freq2,freq3,freq4]+adder,repeats: 1)

          ], inf
        )

      ],
    );

    ({ |i|
      Pluck.ar(
        in: LPF.ar(
          in: Ringz.ar(
            in: Blip.ar(
              freq: freak,
              // phase: -1
            ),
            freq: freak,
            mul: 0.2
          )
          ,
          freq: freak
        ) * 0.1,
        trig: j.ar(
          freq: 4/(i/2)
        ),
        maxdelaytime: 1,
        delaytime: x,
        decaytime: decaytime,
        coef: 0,
        mul: mul,
        add: add
      )
      }!7;
    ).sum.sin!7;

  });
  }

).add;
);

(

SynthDef(\r_synth,	{
  |
  freq1=1,freq2=1,freq3=1,freq4=1,freak=60,adder=0.15,mul=3,add=100,decaytime=0
  |

  Out.ar([1,1], {

    j=Impulse;

    x=Demand.kr(
      trig: j.kr(
        freq: 1,
        mul: 0.0001
      ),
      reset: 0,
      demandUGens:
      [Dseq(
        [

          Dseq(list: 0.1/[freq1,freq2,freq3,freq4]+adder,repeats: 1)

        ], inf
        ),
        Dseq(
          [

            Dseq(list: 0.1/[freq1,freq2,freq3,freq4]+adder,repeats: 1)

          ], inf
        )

      ],
    );

    ({ |i|
      Pluck.ar(
        in: LPF.ar(
          in: Ringz.ar(
            in: Blip.ar(
              freq: freak,
              // phase: -1
            ),
            freq: freak,
            mul: 0.2
          )
          ,
          freq: freak
        ) * 0.1,
        trig: j.ar(
          freq: 4/(i/2)
        ),
        maxdelaytime: 1,
        delaytime: x,
        decaytime: decaytime,
        coef: 0,
        mul: mul,
        add: add
      )
      }!7;
    ).sum.sin!7;

  });
  }

).add;
);

(

var tempoclock = TempoClock(0.5);
var wait_len = 5;

/*s.prepareForRecord;
s.record;*/

{

  1.do {
    y = Synth(\l_synth);
    z = Synth(\r_synth);
    (wait_len*2).wait;
  };

  1.do {
    y.set(\mul, 2.0);
    wait_len.wait;
  };

  1.do {
    z.set(\mul, 2.25);
    wait_len.wait;
  };

  1.do {
    y.set(\mul, 2.5);
    wait_len.wait;
  };

  1.do {
    z.set(\mul, 3.0);
    wait_len.wait;
  };

  1.do {
    z.set(\adder, 0.16);
    wait_len.wait;
  };

  1.do {
    y.set(\adder, 0.04);
    y.set(\mul, 3.0);
    wait_len.wait;
  };

  1.do {
    y.set(\adder, 0.16);
    z.set(\adder, 0.04);
    wait_len.wait;
  };

  1.do {
    y.set(\mul, 4.0);
    wait_len.wait;
  };

  1.do {
    z.set(\mul, 4.5);
    z.set(\adder, 0.02);
    wait_len.wait;
  };

  1.do {
    y.set(\mul, 5);
    z.set(\mul, 5.8);
    wait_len.wait;
  };

  1.do {
    y.set(\mul, 6.5);
    z.set(\mul, 7.0);
    wait_len.wait;
  };

  1.do {
    y.set(\adder, 0.02);
    wait_len.wait;
  };

  1.do {
    y.set(\mul, 9);
    z.set(\mul, 8.5);
    wait_len.wait;
  };

  1.do {
    y.set(\mul, 11);
    z.set(\mul, 13);
    y.set(\adder, 0.005);
    z.set(\adder, 0.001);
    wait_len*1.5.wait;
  };

  1.do {
    y.free;
    z.free;
  };

}.fork(tempoclock);
)