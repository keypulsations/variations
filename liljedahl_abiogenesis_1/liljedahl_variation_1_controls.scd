(
// Mastering FX
m.free;
m = {
	var in = In.ar(0, 2);
	var snd = LeakDC.ar(in);
	var brightness = HPF.ar(snd, 12000, 8).tanh;
	var basschain = LPF.ar(snd, 80);
	snd = HPF.ar(snd, 50); // remove the ultra low bass
	snd = Compander.ar(snd, basschain, 0.5, 1, 1/8, 0.05, 0.5, 2); // side chain comp
	snd = Compander.ar(snd, snd, 0.5, 1, 1/4, 0.025, 0.75, 1.25).tanh; // normal comp
	snd = snd + (brightness * 1.5);
	snd = BHiShelf.ar(snd, 8000, 2, 4);
	snd = MidEQ.ar(snd, 2800, 1, 2);
	snd = Limiter.ar(LeakDC.ar(snd));
	ReplaceOut.ar(0, snd);
}.play(addAction:\addToTail);
)


(
/*s.prepareForRecord;
s.record;*/
x = Synth(\lv1);
a = ClockFace.new;
a.play;
x.set(\melodyMult, 0.75);
x.set(\harmonix, 29);
x.set(\bd, 1);
x.set(\sd, 1);
x.set(\dcy, 1);
x.set(\padMul, 1);
x.set(\resMult, 1);
x.set(\brightness, 2000);
x.set(\room, 0.75);
);

(
x.set(\melodyMult, 1.0);
x.set(\sdMul2, 3);
x.set(\resMult, 1.25);
x.set(\brightness, 3000);
x.set(\room, 0.8);
);

(
x.set(\melodyMult, 1.25);
x.set(\sdMul1, 3);
x.set(\resMult, 1.5);
x.set(\brightness, 4000);
x.set(\room, 0.85);
);

(
x.set(\melodyMult, 1.5);
x.set(\sdMul2, 3);
x.set(\sdMul1, 3);
x.set(\dcy, 1.25);
x.set(\sd, 1.75);
x.set(\resMult, 1.75);
x.set(\brightness, 5000);
x.set(\room, 0.9);
);

// slow down briefly...

(
x.set(\melodyMult, 1.75);
x.set(\harmonix, 31);
x.set(\bd, 0);
x.set(\sd, 0);
x.set(\dcy, 1.5);
x.set(\padMul, 0.25);
x.set(\resMult, 2);
x.set(\brightness, 5000);
x.set(\room, 0.95);
);
x.set(\sd, 0.25);
(
x.set(\bd, 1);
x.set(\melodyMult, 2);
x.set(\sdPhase1, 0.5);
x.set(\sdMul1, 6);
x.set(\padMul, 0.5);
x.set(\resMult, 3);
x.set(\room, 0.75);
x.set(\dcy, 1.75);
x.set(\fuzz, 1);
x.set(\brightness, 5000);
x.set(\denom, 1);
x.set(\harmonix, 33);
x.set(\sdMul2, 6);
x.set(\melodyHighMult, 0);
x.set(\highHarmonix, 30);
x.set(\denomHigh, 0.5);
x.set(\sd, 1.75);
x.set(\sdPhase2, 0.5);
);

// quiet little beat...

(

// x = Synth(\kp);

x.set(
  \bd, 0.75,
  \melodyMult, 3,
  \sdPhase1, 0.5,
  \sdMul1, 0,
  \padMul, 0.5,
  \resMult, 3,
  \room, 0.7,
  \dcy, 1.75,
  \fuzz, 1.25,
  \brightness, 5000,
  \denom, 1,
  \harmonix, 60,
  \sdMul2, 0,
  \melodyHighMult, 1.5,
  \highHarmonix, 40,
  \denomHigh, 0.5,
  \sd, 0,
  \sdPhase2, 0.5
);
);

(
x.set(
  \bd, 0.5,
  \melodyMult, 3,
  \padMul, 0.6,
  \resMult, 4,
  \fuzz, 2,
  \room, 0.75
);
);

(
x.set(
  \bd, 0.25,
  \melodyMult, 4,
  \padMul, 0.7,
  \resMult, 5,
  \fuzz, 4,
  \room, 0.8
);
);

(
x.set(
  \bd, 0.1,
  \melodyMult, 5,
  \padMul, 0.8,
  \resMult, 6,
  \fuzz, 8,
  \room, 0.85
);
);

(
x.set(
  \bd, 0.025,
  \melodyMult, 6,
  \padMul, 0.9,
  \resMult, 7,
  \fuzz, 16,
  \room, 0.9
);
);

(
x.set(
  \bd, 0.01,
  \melodyMult, 7,
  \padMul, 1.0,
  \resMult, 8,
  \fuzz, 32,
  \room, 0.95
);
);

(
x.set(
  \bd, 0.001,
  \melodyMult, 12,
  \resMult, 16,
  \fuzz, 40,
  \room, 1
);
);


(

x.set(
  \bd, 1,
  \melodyMult, 3,
  \sdPhase1, 0.5,
  \sdMul1, 6,
  \padMul, 1,
  \resMult, 4,
  \room, 1,
  \dcy, 2.25,
  \fuzz, 40,
  \brightness, 5000,
  \denom, 1,
  \harmonix, 25,
  \sdMul2, 6,
  \melodyHighMult, 2,
  \highHarmonix, 100,
  \denomHigh, 0.5,
  \sd, 2,
  \sdPhase2, 0.5
);
)

(
x.set(
  \bd, 1,
  \melodyMult, 4,
  \sdPhase1, 0.5,
  \sdMul1, 12,
  \padMul, 1,
  \resMult, 4,
  \room, 1,
  \dcy, 2.25,
  \fuzz, 40,
  \brightness, 5000,
  \denom, 0.5,
  \harmonix, 11,
  \sdMul2, 12,
  \melodyHighMult, 2,
  \highHarmonix, 100,
  \denomHigh, 0.5,
  \sd, 2,
  \sdPhase2, 0.5
);
)

(
x.set(\melodyHighMult, 2);
x.set(\harmonix, 25);
x.set(\highHarmonix, 100);
x.set(\melodyMult, 2);
x.set(\resMult, 8);
x.set(\fuzz, 10);
x.set(\denomHigh, 0.25);
x.set(\brightness, 5000);
x.set(\dcy, 2.5);
x.set(\bd, 0);
x.set(\sd, 0);
x.set(\sdMul1, 6);
x.set(\sdMul2, 6);
x.set(\padMul, 0.5);
x.set(\room, 0.85);
);

(
x.set(\bd, 1);
x.set(\sd, 1);
x.set(\dcy, 1.5);
x.set(\fuzz, 5);
)

(
x.set(\dcy, 2);
x.release(23);
);

// s.stopRecording;