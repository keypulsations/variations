// nathaniel_virgo_2

// original tweet: play{GVerb.ar(Pulse.ar(Duty.ar(1/8,0,Dseq(x=[5,2,7,3];1/flat(allTuples(x/.t x).reject(any(_,{|i|i%1==0}))%1)*.x[1,3,2,6]*40++0))),165,7)/2}

(

(
SynthDef(\melody,	{

  |tempo=0.25,e=8,f=1,g=6,h=3,mul=44,roomsize=200,revtime=5,damping=0.1,inputbw=0.1,spread=15,drylevel=0.9,earlyreflevel=0.3,taillevel=0.7,mull=0.25|

  Out.ar([0,1], {
    GVerb.ar(
      Pulse.ar(
        Duty.ar(
          tempo,
          1,
          Dseq(
            /*						x=[5,2,7,3];*/
            x=[5,1,7,3];
            1/flat(allTuples(x/.t x).reject(
              any(
                _
                ,
                { |i|
                  i%1==0
                }
              )
              )
              %1
            )*.x[e,f,g,h]*mul;
          )
        )
      ),
      roomsize: roomsize,
      revtime: revtime,
      damping: damping,
      inputbw: inputbw,
      spread: spread,
      drylevel: drylevel,
      earlyreflevel: earlyreflevel,
      taillevel: taillevel,
      mul: mull
    )
  });

}).add;
);

(
SynthDef(\bass,	{

  |mulll=0.25|

  Out.ar([0,1],
    LPF18.ar(
      Pulse.ar(
        Duty.ar(
          1/64,
          0,
          Dseq(
            1/flat(allTuples(x/.t x);
              x=[4,3,3,3]/4; // /4 or /2
            )*.x[4,3,3,3]/3; // 1, 3 or 5
          )
        )
      )*16,
      Duty.ar(
        1,
        1,
        Dseq([62,62,62,50]+50,inf)
      ),
      4.5,
      0.1
    )*0.25;
  )
}).add;
);

(
SynthDef(\bassdrum,	{
  Out.ar([0,1],
    LPF.ar(
      Pulse.ar(
        Duty.ar(
          1/64,
          0,
          Dseq(
            1/flat(allTuples(x/.t x);
              x=[4,3,3,3]/4; // /4 or /2
            )*.x[4,3,3,3]/3 // /3 or 5
          )
        )
      ),
      44*2,
      0.5
    )
  )
}).add;
);

(
SynthDef(\snare,	{

  |iphase=0.25,mul=0.5|

  Out.ar([0,1],
    LFPulse.ar(
      freq: Duty.ar(
        1/64,
        0,
        Dseq(
          1/flat(allTuples(x/.t x);
            x=[4,3,3,3]/2;
          )*.x[4,3,3,3]/2
        )
      ),
      iphase: iphase,
      mul: mul
    )
  )
}).add;
);

);

s.prepareForRecord;

(

var tempoclock = TempoClock(0.5);
var wait_len = 8;

{

  s.record;

  1.do {

    // e=8,f=1,g=6,h=3
    var melody = Synth(\melody);
    wait_len.wait;

    melody.set(\e, 4, \f, 2, \g, 3, \h, 6);
    wait_len.wait;

    melody.set(\e, 16, \f, 0, \g, 12, \h, 6);
    wait_len.wait;

    melody.free;
  };

  1.do {

    var bass = Synth(\bass);
    var melody = Synth(\melody);
    wait_len.wait;

    melody.set(\e, 4, \f, 2, \g, 3, \h, 6);
    wait_len.wait;

    bass.free;
    melody.set(\e, 16, \f, 2, \g, 12, \h, 6);

    melody.free;

  };

  1.do {

    var bass = Synth(\bass);
    var melody = Synth(\melody);
    var bassdrum = Synth(\bassdrum);
    var snare = Synth(\snare);
    wait_len.wait;

    melody.set(\e, 4, \f, 2, \g, 3, \h, 6);
    wait_len.wait;

    bassdrum.free;
    snare.free;
    melody.set(\e, 16, \f, 2, \g, 12, \h, 6);

    wait_len.wait;

    melody.free;
    bass.free;

  };

  1.do {

    var bass = Synth(\bass);
    var melody = Synth(\melody, [\e, 8, \f, 1, \g, 6, \h, 4]);
    var bassdrum = Synth(\bassdrum);
    var snare_one = Synth(\snare, [\iphase, 0.25, \mul, 0.5]);
    var snare_two = Synth(\snare, [\iphase, 0.5, \mul, 0.75]);

    wait_len.wait;

    melody.set(\e, 4, \f, 2, \g, 3, \h, 6);
    wait_len.wait;

    bass.free;
    bassdrum.free;
    snare_one.free;

    melody.set(\e, 16, \f, 2, \g, 12, \h, 6);

    wait_len.wait;

    melody.free;
    snare_two.free;

  };

  1.do {

    m = Synth(\melody, [\e, 9, \f, 2, \g, 3, \h, 1]);
    r = Synth(\snare, [\iphase, 0.25, \mul, 0.5]);
    wait_len.wait;

    b = Synth(\bass);
    y = Synth(\snare, [\iphase, 0.5, \mul, 0.75]);
    z = Synth(\bassdrum);
    wait_len.wait;

    m.free;
    n = Synth(\melody, [\e, 8, \f, 1, \g, 6, \h, 4]);
    x = Synth(\snare, [\iphase, 0.75, \mul, 1]);
    wait_len.wait;

    n.free;

    m.free;
    r.free;
    b.free;
    y.free;
    z.free;
    n.free;
    x.free;

    o = Synth(\melody, [\e, 8, \f, 1, \g, 6, \h, 3]*2);
    (wait_len*2).wait;
    o.free;

  };

  s.stopRecording;

}.fork(tempoclock);

);