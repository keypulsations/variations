// based on code by Jonatan Liljedahl for ABIOGENESIS Ex0529201421

(SynthDef(\lv1, {

  |
  dcy=1.5,
  bd=1,
  sd=1.5,
  fuzz=1,
  sdMul1=0,
  sdMul2=0,
  sdPhase1=0.5,
  sdPhase2=0.5,
  melodyMult=0.25,
  harmonix=1,
  highHarmonix=1,
  resMult=1,
  melodyHighMult=0,
  denom=1,
  denomHigh=1,
  room=1,
  padMul=1,
  brightness=5000,
  gate=1
  |

  var seq, res, drm, sig, mseq, melody, mseqHigh, melodyHigh;

  seq = Dseq([Dseq([98.5],4),Dseq([117.25],2),Dseq([110.5],1),Dseq([104.25],1)],inf);
  res = Demand.kr(Impulse.kr(1/2,0.75),0,seq);

  mseq = Dseq([392,587,523,466,440]*2,inf);
  melody = Demand.kr(Blip.kr(1/4,harmonix),0,mseq);
  mseqHigh = Dseq([390,587,523,466,440,784,1174],inf);
  melodyHigh = Demand.kr(Blip.kr(1/4,highHarmonix),0,mseqHigh);

  drm =
  Ringz.ar(Impulse.ar([1.5,0.75],[0,0.5]).sum*bd,35,0.15,8).sin.madd(LFTri.ar(4.5).range(1.5,0.2)) +
  Ringz.ar(Impulse.ar(1.5,0.75),800,0.02,SinOsc.ar(100*LFNoise1.kr(1/16).range(1,4).round)*fuzz).sin.madd(LFSaw.ar([1.5,2]).range(0.6,0)) +
  RLPF.ar(Ringz.ar(Impulse.ar(0.75,sdPhase1)*sd,6600,0.15,PinkNoise.ar(6!2)).tanh.madd(LFTri.ar(2.25).range(0.5,0.3)),4000,0.1, mul: sdMul1) +
  RLPF.ar(Ringz.ar(Impulse.ar(0.25,sdPhase2)*sd,6600,0.15,PinkNoise.ar(6!2)).tanh.madd(LFTri.ar(2.25).range(0.5,0.3)),4000,0.1, mul: sdMul2);

  drm = drm + RLPF.ar(CombL.ar(drm.reverse,5/6,5/6,dcy),LFNoise1.kr(0.5).range(800,1200)*1.5,0.4);
  drm = HPF.ar(RLPF.ar(drm,2000,0.7),30);
  drm = DelayN.ar(drm,0.02,0.02) + Limiter.ar(drm*5,0.6) * 0.9;

  sig = HPF.ar(drm,100) * Line.kr(0,0.35,180);
  sig = sig + tanh(drm*8) + LPF.ar(CombL.ar(tanh(drm*4),0.1,2/[res,res*100],1,0.4).mean,1000)*resMult;
  sig = sig + FreeVerb.ar(RLPF.ar(CombL.ar(tanh(drm*4),0.1,2/[melody/denom,melody],0.5,0.5),brightness)*melodyMult,0.25,room,0.1);
  sig = sig + FreeVerb.ar(RLPF.ar(CombL.ar(tanh(drm*4),0.1,2/[melodyHigh/denomHigh,melodyHigh],0.5,0.5),brightness)*melodyHighMult,0.25,room,0.1);
  sig = BPeakEQ.ar(sig,2200,1,-6);
  sig = sig + (Ringz.ar(PinkNoise.ar(0.01!2),1600/[2,3,4,5]!2,0.5,padMul).flop.sum*Line.kr(0,0.5,90));

  Out.ar(0, Limiter.ar(sig * 2,1,0.015) * Env.asr(0.1,1,0.5).kr(2,gate));

}).add);