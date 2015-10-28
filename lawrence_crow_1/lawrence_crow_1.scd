// lawrence_crow_1

(

(
SynthDef(\b,
  {
    arg lfpFrq=0.25,lfpIphse=0.25,lfpWdth=0.25,lfpMul=8,lfpAdd=4,lfcIphse=1,lfcMul=(-20),lfcAdd=55,wnFrq=8,wnIphse=0,wnLFPfq=2,wnLFPIphse=0.75,wnDiv=4,wnAdd=0.05,wnAmpDiv=8;

    Out.ar(0,
      LFCub.ar(
        freq: LFSaw.kr(
          freq: LFPulse.kr(
            freq: lfpFrq,
            iphase: lfpIphse,
            width: lfpWdth
          )*lfpMul+lfpAdd,
          iphase: lfcIphse,
          mul: lfcMul,
          add: lfcAdd
        )
      )*Line.kr(1,1,4, doneAction:2)+(
        WhiteNoise.ar(
          mul: LFPulse.kr(
            freq: wnFrq,
            iphase: wnIphse,
            width: LFPulse.kr(
              freq: wnLFPfq,
              iphase: wnLFPIphse
            )/wnDiv+wnAdd
          )
      )/wnAmpDiv)*Line.kr(1,1,4, doneAction:2)!2
    )
  }
).store;
);

(
SynthDef(\d,
  {
    arg lfpFrq=0.25,lfpIphse=0.25,lfpWdth=0.25,lfpMul=8,lfpAdd=4,lfcIphse=1,lfcMul=(-20),lfcAdd=55;
    Out.ar(0,
      LFCub.ar(
        freq: LFSaw.kr(
          freq: LFPulse.kr(
            freq: lfpFrq,
            iphase: lfpIphse,
            width: lfpWdth
          )*lfpMul+lfpAdd,
          iphase: lfcIphse,
          mul: lfcMul,
          add: lfcAdd
        )
      )*Line.kr(1,1,4, doneAction:2)!2
    )
  }
).store;
);

(
SynthDef(\f,
  {
    arg wnFrq=8,wnIphse=0,wnLFPfq=1,wnLFPIphse=0.75,wnDiv=4,wnAdd=0.0001,wnAmpDiv=8;

    Out.ar(0,
      (
        WhiteNoise.ar(
          mul: LFPulse.kr(
            freq: wnFrq,
            iphase: wnIphse,
            width: LFPulse.kr(
              freq: wnLFPfq,
              iphase: wnLFPIphse
            )/wnDiv+wnAdd
          )
      )/wnAmpDiv)*Line.kr(1,1,4, doneAction:2)!2
    )
  }
).store;
);

)

(
var x,y,z,t;
t = TempoClock(0.25);
x=8;
y = Array.new(x);
x.do {|z| y == y.add(Pseq([z/10],1)) };

Ppar([
  Pbind(
    \instrument,Pseq([
      Pseq([\f],x),
    ],1),
    \wnAdd,Pseq([Pseq([0.01],x/2),Pseq([0.02],x/2)],1),
    \wnDiv,Pseq([Pseq([64],x/4),Pseq([32],x/4),Pseq([16],x/4),Pseq([8],x/4)],1),
    \wnLFPfq,Pseq(y,1)
  ),

  Pseq([
    Pbind(\dur, x, \freq, Pseq([\rest]) ),

    Ppar([
      Pbind(\instrument,Pseq([\f],x),
        \wnIphse,Pseq(y,1)
      ),
      Pbind(\instrument,Pseq([\f],x))
    ])

  ], 1)
], 1).play(t);

);
