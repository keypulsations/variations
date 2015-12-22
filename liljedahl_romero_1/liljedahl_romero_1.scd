(
SynthDef.new(\synth, {

  |
  basePitch,roomsize=300,do=8,re=1,mi,so,la,gate=1,
  dcy=1.75,bd=1,sd=0.5,drmMul=0,impulseA=1,impulseB=2,phaseA=0,phaseB=0.5
  |

  ~sig =
  GVerb.ar(
    Blip.ar(
      Duty.kr(
        1/[re,mi,so,la],
        0,
        Dseq([0,3,7,12,17,19] + basePitch, inf)
      ).midicps*[1,4,do],
      0
    ).sum,
    roomsize,
    0,
    mul:0.075
  );

  ~drm =
  Ringz.ar(
    Impulse.ar(
      [impulseA,impulseB]/2,
      [phaseA,phaseB]).sum * bd,
    35,
    0.15,
    8
  ).sin.madd(LFTri.ar(4.5).range(1.5,0.2));
  ~drm = ~drm +
  RLPF.ar(
    Ringz.ar(
      Impulse.ar(0.5,0.5) * sd,
      6600,
      0.15,
      PinkNoise.ar(6!2)
    ).tanh.madd(LFTri.ar(2.25).range(0.5,0.3)),
    4000,
    0.4
  );

  ~drm = ~drm + RLPF.ar(CombL.ar(~drm.reverse,5/6,5/6,dcy),LFNoise1.kr(0.5).range(800,1200)*1.5,0.4);
  ~drm = HPF.ar(RLPF.ar(~drm,2000,0.7), 30);
  ~drm = [DelayL.ar(~drm,0.02,0.02) + Limiter.ar(~drm*5,0.6) * 0.9];

  ~seq = Dseq([46],inf);
  ~res = Demand.kr(Impulse.kr(1/4,0.65),0,~seq);

  ~drm = ~drm * drmMul;

  ~sig = ~sig + tanh(~drm*8) + LPF.ar(CombL.ar(tanh(~drm*4),0.1,1/[~res,92],1,0.4).mean,2500);
  ~sig = BPeakEQ.ar(~sig,2200,1,-6);
  ~sig = Limiter.ar(~sig * 2,1,0.001);

  Out.ar([0,1],Pan2.ar(~sig,0,0.15) * Env.asr(0, 1, 0.5).kr(2,gate));

  }

).add;

);

(
var clock;
TempoClock.default.tempo_(180/60);
clock = ExternalClock(TempoClock.default);
clock.play;

~path   = thisProcess.nowExecutingPath.dirname;
~sf1    = BBCutBuffer(~path +/+ "aahh.wav", 64);
~sf1a   = BBCutBuffer(~path +/+ "aahh.wav", 64);
~sf2    = BBCutBuffer(~path +/+ "uuhh.wav", 64);
~aahh   = CutGroup(CutBuf3(~sf1));
~aahhh  = CutGroup(CutBuf3(~sf1a));
~uuhh   = CutGroup(CutBuf3(~sf2));

~clockFace = ClockFace.new;
~clockFace.play;

Routine.run({

  s.sync;

  ~synthA = Synth(\synth, [\basePitch,30, \re,0.25, \mi,0.25, \so, 0.25, \la, 0.25,]);
  12.wait; ~synthB = Synth(\synth, [\basePitch,54, \mi,2, \so,1, \la,2, \do, 4]);
  12.wait; ~synthB.set(\drmMul, 0.5, \sd, 0.75, \bd, 0.1, \dcy, 3.5);
  12.wait; ~synthC = Synth(\synth, [\basePitch, 54, \mi, 1, \so, 8, \la, 4, \do, 2]);
  06.wait; ~synthC.set(\drmMul, 0.1, \phaseA, 0.25, \phaseB, 0);
  17.wait;
  ~cut1   = BBCut2(~aahh, BBCutProc11(2, 4, 1, 1, 0)).play(clock);
  ~aahh.add(CutRev1.new(0.5, 0.1));
  // ~aahh.add(CutBit1.new(64, 256, 1));
  1.wait;
  ~synthC.release; ~synthB.release;

  10.wait;
  ~cut2   = BBCut2(~uuhh, BBCutProc11(2, 4, 1, 1, 0)).play(clock);
  ~uuhh.add(CutRev1.new(0.5, 0.1));
  2.wait;

  ~synthB = Synth(\synth, [\basePitch,54, \mi,2, \so,1, \la,2, \do, 4]);
  ~synthC = Synth(\synth, [\basePitch, 42, \mi, 1, \so, 8, \la, 8, \do, 4]);
  ~synthC.set(\drmMul, 0.5, \sd, 0, \dcy, 2, \impulseA, 2, \impulseB, 2, \bd, 0.25);
  12.wait;
  ~synthB.set(\drmMul, 0.5, \sd, 0.75, \bd, 0.25, \dcy, 3.5);

});
)