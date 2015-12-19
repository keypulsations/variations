(

SynthDef.new(\synth, {

  |
  numharm=0,basePitch,roomsize=300,revtime=1,do=8,re=1,mi,so,la,
  dcy=2.5,bd=1,sd=0,drmMul=0,impulse1a=1.5,impulse1b=1,phasea=0,phaseb=0.75,boingMul=0
  |

  var drm,seq,res,sig;
  sig =
  GVerb.ar(
    Blip.ar(
      Duty.kr(
        1/[re,mi,so,la],
        0,
        Dseq([0,3,7,12,17,19] + basePitch, inf)
      ).midicps*[1,4,do],
      numharm
    ).sum,
    roomsize,
    revtime,
    mul:0.075
  );

  drm =
  Ringz.ar(
    Impulse.ar(
      [impulse1a,impulse1b]/2,
      [phasea,phaseb]).sum * bd,
    35,
    0.15,
    8
  ).sin.madd(LFTri.ar(4.5).range(1.5,0.2));
  drm = drm +
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

  // drm = drm + RLPF.ar(CombL.ar(drm.reverse,5/6,5/6,dcy),LFNoise1.kr(0.5).range(800,1200)*1.5,0.4);
  drm = HPF.ar(RLPF.ar(drm,2000,0.7), 30);
  drm = [DelayL.ar(drm,0.02,0.02) + Limiter.ar(drm*5,0.6) * 0.9];

  seq = Dseq([46],inf);
  res = Demand.kr(Impulse.kr(1/4,0.65),0,seq);

  drm = drm * drmMul;

  sig = sig + tanh(drm*8) + LPF.ar(CombL.ar(tanh(drm*4),0.1,1/[res,92],1,0.4).mean,2500);
  sig = BPeakEQ.ar(sig,2200,1,-6);
  sig = Limiter.ar(sig * 2,1,0.001);

  Out.ar([0,1],Pan2.ar(sig,0,0.15) * Env.asr(0, 1,0.5).kr(2,1));

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
~sf2    = BBCutBuffer(~path +/+ "uuhh.wav", 32);
~group  = CutGroup(CutBuf3(~sf1, 0));
~group2 = CutGroup(CutBuf3(~sf2, 0));

// try 16 on these mi so la do

// ~syn = Synth(\synth, [\basePitch, 54, \drmMul, 1, \mi, 16, \so, 8, \la, 4, \do, 2, \sd, 1, \boingMul, 2, \impulse1a, 2, \impulse1b, 2, \phasea, 0.25, \phaseb, 0.75]);

Routine.run({
  ~synthA = Synth(\synth, [\basePitch,54, \revtime,1, \mi,2, \so,1, \la,2, \do, 4]);
  4.wait;  ~synthB = Synth(\synth, [\basePitch,30, \revtime,0, \re,0.25, \mi,0.25, \so, 0.25, \la, 0.25]);
  16.wait; ~synthA.set(\drmMul, 0.5, \impulse1a, 1, \impulse1b, 1, \phasea, 0, \phaseb, 0.75);
  20.wait; ~synthA.set(\drmMul, 1, \sd, 1, \boingMul, 1, \impulse1a, 1.5);
  1.wait;  ~synthA.set(\mi, 3, \so, 6, \la, 4, \numharm, 0, \do, 8);
  // 23.wait; ~cut2 = BBCut2(~group2, BBCutProc11(8, 8, 8, 2, 0)).play(clock);
  // ~group2.add(CutRev1.new(0.5,0.1));
  // ~cut1 = BBCut2(~group1, BBCutProc11(8, 4, 4, 4, 0)).play;
  // ~group1.add(CutRev1.new(0.5,0.1));
  // 23.wait;
});

)

~syn.set(\so, 8);
~syn.set(\mi, 16);
~syn.set(\la, 8);