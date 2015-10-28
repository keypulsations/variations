// nick_collins_1

(

var clock, sf1, sf2, sf3, sf4, sf5, sf6, sf7, sf8, sf9, sf10, sf11, sf12, sf13, sf14, cut1, cut2, cut3, cut4, cut5, cut6, cut7, cut8, cut9, cut10, cut11, cut12, cut14, group, group2, group3, group4, scale, buffer, mix;

// s.prepareForRecord;

TempoClock.default.tempo_(180/60);
clock = ExternalClock(TempoClock.default);
clock.play;

SynthDef(\bass, { |freq = 55, gate = 8, amp = 0.01, slideTime = 0, ffreq = 112.5, width = 0.15,
  detune = 1.005, preamp = 0.5|
  var    sig,
  env = Env.adsr(0.01, 0.3, 0.4, 0.1);
  freq = Lag.kr(freq, slideTime);
  sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort * amp
  * EnvGen.kr(env, gate, doneAction: 2);
  sig = LPF.ar(sig, ffreq);
  Out.ar(0, sig ! 2)
}).add;

SynthDef(\pulsepad,	{

  |left_a, right_a, left_b, right_b, mul|

  var scale = FloatArray[0, 2, 3.2, 5, 7, 9, 10]; // dorian scale
  var buffer = Buffer.alloc(s, scale.size,1, { |b| b.setnMsg(0, scale) });

  Out.ar([0,1], {

    var mix =
    // lead tone
    SinOsc.ar(
      (
        DegreeToKey.kr(
          buffer.bufnum,
          7,
          12,					// 12 notes per octave
          1,					// mul = 1
          60					// offset by 60 notes
        )
        + LFPulse.kr(3, -0.225, 0.125)
      ).midicps,
      0,
      0.15)

    + RLPF.ar(LFPulse.ar([48,55].midicps, 0.5),
      SinOsc.kr(0.1, 0, 1, 72).midicps, 0.1, 0.1);

    CombN.ar(mix, 0.31, 0.31, 2, 1, mix)*EnvGen.kr(Env([0.0001,0.125],40,\exp));
  });

}).add;

SynthDef(\pulsepad2,	{

  |left_a, right_a, left_b, right_b, mul|

  var scale = FloatArray[0, 2, 3.2, 5, 7, 9, 10]; // dorian scale
  var buffer = Buffer.alloc(s, scale.size,1, { |b| b.setnMsg(0, scale) });

  Out.ar([0,1], {

    var mix =
    // lead tone
    SinOsc.ar(
      (
        DegreeToKey.kr(
          buffer.bufnum,
          15,
          // 13,
          12,					// 12 notes per octave
          1,					// mul = 1
          72					// offset by 60 notes
        )
        + LFPulse.kr(6, -0.25, 0.05) // add some pulsy noise
        // + LFPulse.kr(12, 0, 0.0125) // add some pulsy noise
      ).midicps,
      0,
      0.1)

    + RLPF.ar(LFPulse.ar([48,55].midicps, 0.5),
      SinOsc.kr(0.1, 0, 12, 72).midicps, 0.1, 0.1);

    CombN.ar(mix, 0.31, 0.31, 2, 1, mix)*EnvGen.kr(Env([0.0001,0.075],40,\exp));
  });

}).add;

SynthDef(\pad,	{

  |left_a, right_a, left_b, right_b, mul|

  var scale = FloatArray[0, 2, 3.2, 5, 7, 9, 10]; // dorian scale
  var buffer = Buffer.alloc(s, scale.size,1, { |b| b.setnMsg(0, scale) });

  Out.ar([0,1], {

    var mix =
    // lead tone
    SinOsc.ar(
      (
        DegreeToKey.kr(
          buffer.bufnum,
          0,
          12,					// 12 notes per octave
          1,					// mul = 1
          48					// offset by 60 notes
        ) + LFNoise1.kr([3,3], 0.04)
      ).midicps,
      0,
      0.1)

    + RLPF.ar(LFPulse.ar([48,55].midicps, 0.5),
      SinOsc.kr(0.1, 0, 5, 72).midicps, 0.1, 0.1);

    CombN.ar(mix, 0.31, 0.31, 2, 1, mix)*EnvGen.kr(Env([0.0001,0.075],40,\exp));
  });

}).add;

s.volume.volume = 0.99;

sf1= BBCutBuffer("/Users/Osetinsky/desktop/nick/legato_1.wav",32);
sf2= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat1.aif",16);
sf3= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat3.aif",16);
sf4= BBCutBuffer("/Users/Osetinsky/desktop/nick/legato_2.wav",32);
sf5= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat2.aif",32);
sf6= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat4.aif",16);

sf8= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat1.aif",16);
sf9= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat3.aif",16);
sf10= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat2.aif",64);
sf11= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat4.aif",64);
sf12= BBCutBuffer("/Users/Osetinsky/desktop/nick/beat5.aif",64);

sf13= BBCutBuffer("/Users/Osetinsky/desktop/nick/legato_2.wav",64);
sf14= BBCutBuffer("/Users/Osetinsky/desktop/nick/legato_1.wav",64);

Routine.run({
  s.sync;
  // s.record;

  group = CutGroup(CutBuf3(sf1, 0));
  group2 = CutGroup(CutBuf3(sf4, 0));
  group3 = CutGroup(CutBuf3(sf13, 0.5));
  group4 = CutGroup(CutBuf3(sf14, 0.5));

  cut1 = BBCut2(group, BBCutProc11(8, 4, 4, 2, 0)).play(clock);
  group.add(CutRev1.new(0.075,0.1));

  20.wait;

  cut2 = BBCut2(CutBuf3(sf2, 0.5),
    BBCutProc11(4, 4, 2, 1, 0)).play(clock);

  20.wait;

  cut3 = BBCut2(CutBuf3(sf3, 0),
    BBCutProc11(8, 4, 2, 2, 0)).play(clock);

  20.wait;

  x = Synth(\pad);

  20.wait;

  cut5 = BBCut2(CutBuf3(sf5, 0),
    BBCutProc11(8, 4, 2, 4, 0)).play(clock);

  20.wait;

  cut4 = BBCut2(group2, BBCutProc11(8, 4, 2, 2, 0)).play(clock);
  group2.add(CutRev1.new(0.05,0.1));

  1.wait;

  cut1.stop;
  cut2.stop;
  cut3.stop;
  cut5.stop;
  cut6.stop;

  20.wait;

  y = Synth(\pulsepad);

  cut4 = BBCut2(group2, BBCutProc11(8, 4, 2, 1, 0)).play(clock);
  group2.add(CutRev1.new(0.05,0.1));

  cut4 = BBCut2(group3, BBCutProc11(8, 4, 2, 1, 0)).play(clock);
  group3.add(CutRev1.new(0.05,0.1));

  cut8 = BBCut2(CutBuf3(sf8, 0),
    BBCutProc11(8, 4, 8, 1, 0)).play(clock);

  cut9 = BBCut2(CutBuf3(sf9, 0),
    BBCutProc11(8, 4, 1, 4, 0)).play(clock);

  cut10 = BBCut2(CutBuf3(sf10, 0),
    BBCutProc11(8, 4, 8, 2, 1)).play(clock);

  cut11 = BBCut2(CutBuf3(sf11, 0),
    BBCutProc11(8, 4, 8, 2, 1)).play(clock);

  cut12 = BBCut2(CutBuf3(sf12, 0),
    BBCutProc11(8, 4, 2, 2, 1)).play(clock);

  // 20.wait;

  Pseq([
    Pbind(
      \instrument, \bass,
      \midinote, 36,
      \dur, Pseq([
        Pseq([0.75, 0.25, 0.25, 0.25, 0.5]*2, 1),
        Pseq([0.25, 0.75, 0.5, 0.25, 0.25]*2, 1),
      ], 1),
      \legato, Pseq([
        Pseq([0.9, 0.3, 0.3, 0.3, 0.3], 1),
        Pseq([0.9, 0.3, 0.3, 0.3, 0.3], 1),
      ],1),
      \amp, 0.5, \detune, 0
    )
  ], inf).play(quant: 0);

  z = Synth(\pulsepad2);

  60.wait;

  cut14 = BBCut2(group4, BBCutProc11(4, 4, 8, 4, 0.25)).play(clock);
  group4.add(CutRev1.new(0.05,0.1));

  20.wait;

  cut14 = BBCut2(group4, BBCutProc11(4, 4, 8, 8, 0)).play(clock);
  group4.add(CutRev1.new(0.05,0.1));

  20.wait;

  (
    s.volume.volume = -0.01;
    s.volume.lag = 40;
    s.volume.volume = -90;
  );

  40.wait;

  x.free;
  y.free;
  z.free;

  cut14.stop;
  cut12.stop;
  cut11.stop;
  cut10.stop;
  cut9.stop;
  cut8.stop;
  cut7.stop;
  cut6.stop;
  cut5.stop;
  cut4.stop;
  cut3.stop;
  cut2.stop;
  cut1.stop;

  // s.stopRecording;

})

);