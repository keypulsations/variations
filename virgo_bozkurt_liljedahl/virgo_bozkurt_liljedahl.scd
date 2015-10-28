(

(SynthDef(\mainfx, {

  var sig = In.ar(0, 2);
  var out = Out.ar(0, Limiter.ar(sig));


}).add;);

(SynthDef(\virgo, { |divisor=256,divisorrr=4,fadeintime=1,scaler1=60,scaler2=120,offset1=1,offset2=1,numharm=3,ampdiv=4,gate=1| Out.ar(0, ({ |i| Blip.ar((i+2)/divisor, numharm, [-1,1].wrapAt(i+2)) * Gendy1.ar( 1, 6, 6, Impulse.ar( i*i+4*[0.5,0.5], 20 ), i+offset1*scaler1, i+offset2*scaler2, initCPs: 12 ) * Line.ar(0, 0.5, fadeintime) }!4).sum/ampdiv) * EnvGen.kr(Env.asr(0.1,1,0.5), gate, doneAction: 2 ) }).add;);

(SynthDef(\bozkurt, { |freq=82.41, pulse1freq=2, pulse2freq=1,fadeintimel=0,fadeintimer=0,add1=0,add2=0,gate=1| var in1, in2, amp1, amp2, freq1, freq2, hasFreq1, hasFreq2, out1, out2; Out.ar(0, in1 = Pulse.ar(pulse1freq,0.5+8e-6,1,-0.5)*Line.ar(0, 0.5, fadeintimel); in2 = Pulse.ar(pulse2freq,0.25+4e-3,1,-0.5)*Line.ar(0, 0.5, fadeintimer); amp1 = Amplitude.kr(in1, 0.1, 0.75, 0.5)*Line.ar(0, 0.5, fadeintimel); amp2 = Amplitude.kr(in2, 0.1, 0.75, 0.5)*Line.ar(0, 0.5, fadeintimer); # freq1, hasFreq1 = Pitch.kr(in1, initFreq: freq, maxFreq: freq, minFreq: freq); # freq2, hasFreq2 = Pitch.kr(in2, initFreq: freq, maxFreq: freq, minFreq: freq); out1 = VarSaw.ar(freq1, 0.25, LFNoise1.kr(0.3,0.1,add1), amp1)*Line.ar(0, 1, fadeintimel); out2 = VarSaw.ar(freq2, 0.5, LFNoise1.kr(0.3,0.1,add2), amp2)*Line.ar(0, 1, fadeintimer); AllpassL.ar( in: Pan2.ar(Mix.new([out1,out2]*0.75)), maxdelaytime: 0, delaytime: 0, decaytime: 0 ) ) * EnvGen.kr(Env.asr(0.1,1,0.5), gate, doneAction: 2 ); }).add;);

/*(SynthDef(\bozkurt, { |freq=82.41, pulse1freq=2, pulse2freq=1,fadeintimel=0,fadeintimer=0,add1=0,add2=0,gate=1| var in1, in2, amp1, amp2, freq1, freq2, hasFreq1, hasFreq2, out1, out2; Out.ar(0, in1 = Pulse.ar(pulse1freq,0.5+8e-6,1,-0.5)*Line.ar(0, 0.5, fadeintimel); in2 = Pulse.ar(pulse2freq,0.25+4e-3,1,-0.5)*Line.ar(0, 0.5, fadeintimer); amp1 = Amplitude.kr(in1, 0.1, 0.75, 0.5)*Line.ar(0, 0.5, fadeintimel); amp2 = Amplitude.kr(in2, 0.1, 0.75, 0.5)*Line.ar(0, 0.5, fadeintimer); # freq1, hasFreq1 = Pitch.kr(in1, initFreq: freq, maxFreq: freq, minFreq: freq); # freq2, hasFreq2 = Pitch.kr(in2, initFreq: freq, maxFreq: freq, minFreq: freq); out1 = VarSaw.ar(freq1, 0.25, LFNoise1.kr(0.3,0.1,add1), amp1)*Line.ar(0, 1, fadeintimel); out2 = VarSaw.ar(freq2, 0.5, LFNoise1.kr(0.3,0.1,add2), amp2)*Line.ar(0, 1, fadeintimer); AllpassL.ar( in: [out1,out2]*0.75, maxdelaytime: 0, delaytime: 0, decaytime: 0 ) ) * EnvGen.kr(Env.asr(0.1,1,0.5), gate, doneAction: 2 ); }).add;);*/

(SynthDef(\liljedahl, { |nom=2,revtime=2,freq=1e3,ampdiv=5,decaytime=0.3,divvy=0.75,drylevel=3,fadeintime=3,gate=1| Out.ar(0, GVerb.ar({ |i| Ringz.ar( LPF.ar( Impulse.ar(nom/(divvy+i)), 6e4 ), freq/(i+1), decaytime )}.dup(20).scramble.sum/ampdiv, 18, revtime, 0.75, drylevel: drylevel ).tanh.clip2 * Line.ar(1e-4, 1, fadeintime)) * EnvGen.kr(Env.asr(0.1,1,0.5), gate, doneAction: 2 ); }).add;);

);

(
var delta 		= 8;
var deltaTwo 	= 100;
var zero  		= 0;
var one = 0.125/8;
var two = 0.125/16;

Pseq([

  (instrument: \mainfx, delta: 0),

  (instrument: \bozkurt,   freq: [82.410, 82.410], fadeintimel: 0, fadeintimer: 0, pulse1freq: 2, pulse2freq: 2, dur: delta*13 + 26, delta: delta),
  (instrument: \bozkurt,   freq: [123.47, 123.47], fadeintimel: 8, fadeintimer: 8, pulse1freq: 4, pulse2freq: 1, dur: delta*12 + 24, delta: delta),
  (instrument: \bozkurt,   freq: [277.18, 277.18], fadeintimel: 8, fadeintimer: 8, pulse1freq: 4, pulse2freq: 1, dur: delta*11 + 22, delta: delta),
  (instrument: \bozkurt,   freq: [41.200, 41.200], fadeintimel: 8, fadeintimer: 8, pulse1freq: 2, pulse2freq: 1, dur: delta*10 + 20, delta: delta),
  (instrument: \bozkurt,   freq: [293.66, 293.66], fadeintimel: 8, fadeintimer: 8, pulse1freq: 1, pulse2freq: 2, dur: delta*9 + 18, delta: delta),
  (instrument: \bozkurt,   freq: [329.63, 329.63], fadeintimel: 8, fadeintimer: 8, pulse1freq: 2, pulse2freq: 2, dur: delta*8 + 16, delta: delta),
  (instrument: \bozkurt,   freq: [369.99, 369.99], fadeintimel: 8, fadeintimer: 8, pulse1freq: 1, pulse2freq: 2, dur: delta*7 + 14, delta: delta),
  (instrument: \bozkurt,   freq: [415.30, 415.30], fadeintimel: 8, fadeintimer: 8, pulse1freq: 1, pulse2freq: 2, dur: delta*6 + 12, delta: delta),
  (instrument: \bozkurt,   freq: [493.88, 493.88], fadeintimel: 8, fadeintimer: 8, pulse1freq: 2, pulse2freq: 1, dur: delta*5 + 10, delta: delta),
  (instrument: \bozkurt,   freq: [554.37, 554.37], fadeintimel: 8, fadeintimer: 8, pulse1freq: 4, pulse2freq: 1, dur: delta*4 + 08, delta: delta),
  (instrument: \bozkurt,   freq: [587.33, 587.33], fadeintimel: 8, fadeintimer: 8, pulse1freq: 4, pulse2freq: 1, dur: delta*3 + 06, delta: delta),
  (instrument: \bozkurt,   freq: [659.25, 659.25], fadeintimel: 8, fadeintimer: 8, pulse1freq: 0.5, pulse2freq: 1, dur: delta*4, delta: delta*2.25),

  // RESTART

  (instrument: \bozkurt,   freq: [123.47, 123.47], pulse1freq: 4, pulse2freq: 2, dur: delta + 1.5, delta: zero),
  (instrument: \bozkurt,   freq: [146.83, 146.83], pulse1freq: 2, pulse2freq: 2, dur: delta + 1.5, delta: zero),
  (instrument: \bozkurt,   freq: [82.410, 82.410], pulse1freq: 2, pulse2freq: 2, dur: delta + 1.5, delta: delta),

  (instrument: \bozkurt,   freq: [82.410, 82.410], 			pulse1freq: 1, pulse2freq: 1, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [41.200, 41.200], 			pulse1freq: 1, pulse2freq: 1, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [164.81, 164.81], 			pulse1freq: 4, pulse2freq: 2, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [82.410, 82.410], 			pulse1freq: 2, pulse2freq: 2, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [41.200, 41.200], 			pulse1freq: 2, pulse2freq: 2, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [164.81, 164.81], 			pulse1freq: 2, pulse2freq: 2, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [659.25, 659.25],   		pulse1freq: 1, pulse2freq: 2, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [369.99, 369.99]*2,   	pulse1freq: 2, pulse2freq: 2, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [277.18/2, 277.18]*2, 	pulse1freq: 1, pulse2freq: 2, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [246.94, 246.94], 			pulse1freq: 2, pulse2freq: 1, dur: delta*5 + 10, delta: zero),
  (instrument: \bozkurt,   freq: [123.47, 123.47], 			pulse1freq: 2, pulse2freq: 1, dur: delta*5 + 10, delta: delta),

  (instrument: \virgo,   	 scaler1: 41.20,  scaler2: 41.20,   fadeintime: 4, dur: delta*4, delta: 0),
  (instrument: \virgo,     scaler1: 82.41,  scaler2: 82.41,   fadeintime: 4, dur: delta*4, delta: 0),
  (instrument: \virgo,     scaler1: 98.00,  scaler2: 98.00,   fadeintime: 4, dur: delta*4, delta: 0),
  (instrument: \virgo,     scaler1: 123.47, scaler2: 123.47,  fadeintime: 4, dur: delta*4, delta: 0),
  (instrument: \virgo,     scaler1: 164.81, scaler2: 164.81,  fadeintime: 4, dur: delta*4, delta: delta),

  (instrument: \liljedahl, freq: 987.77, fadeintime: 8, drylevel: 3, revtime: 3, nom: 2, divvy: 0.75, dur: delta*3.75, delta: 0),
  (instrument: \liljedahl, freq: 493.88, fadeintime: 8, drylevel: 3, revtime: 3, nom: 1, divvy: 0.75, dur: delta*3.75, delta: 0),
  (instrument: \liljedahl, freq: 659.25, fadeintime: 8, drylevel: 3, revtime: 3, nom: 2, divvy: 1.0, dur: delta*3.75, delta: 0),
  (instrument: \liljedahl, freq: 1174.66, fadeintime: 8, drylevel: 3,  revtime: 3, nom: 1, divvy: 0.75, dur: delta*3.75, delta: 0),
  (instrument: \liljedahl, freq: 1318.51, fadeintime: 16, drylevel: 3, revtime: 3, nom: 2, divvy: 0.75, dur: delta*3.75, delta: delta*3),

  // NEXT

  (instrument: \bozkurt,   freq: [1318.51, 1318.51/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [1318.51, 1318.51], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [987.77, 987.77/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [987.77, 987.77], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [880.00, 880.00/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [880.00, 880.00], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [783.99, 783.99/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [783.99, 783.99], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [739.99, 739.99/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [739.99, 739.99], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [659.25, 659.25/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [659.25, 659.25], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),

  (instrument: \bozkurt,   freq: [369.99, 369.99]*2,   		pulse1freq: 1, pulse2freq: 2, dur: 29, delta: 2),

  (instrument: \virgo,   	 scaler1: 41.20,  scaler2: 41.20,   dur: 24, delta: 0),
  (instrument: \virgo,     scaler1: 82.41,  scaler2: 82.41,   dur: 24, delta: 0),
  (instrument: \virgo,     scaler1: 98.00,  scaler2: 98.00,   dur: 24, delta: 0),
  (instrument: \virgo,     scaler1: 123.47, scaler2: 123.47,  dur: 24, delta: 0),
  (instrument: \virgo,     scaler1: 164.81, scaler2: 164.81,  dur: 24, delta: 0),
  (instrument: \bozkurt,   freq: [369.99, 369.99]*2,   		pulse1freq: 2, pulse2freq: 2, dur: 24, delta: 0),
  (instrument: \bozkurt,   freq: [277.18/2, 277.18]*2, 		pulse1freq: 1, pulse2freq: 2, dur: 24, delta: 0),
  (instrument: \bozkurt,   freq: [82.41, 82.41],     		pulse1freq: 1, pulse2freq: 2, dur: 24, delta: 0),
  (instrument: \bozkurt,   freq: [246.94, 246.94], 			pulse1freq: 2, pulse2freq: 1, dur: 24, delta: 0),
  (instrument: \bozkurt,   freq: [123.47, 123.47], 			pulse1freq: 2, pulse2freq: 1, dur: 24, delta: 0),
  (instrument: \liljedahl, freq: 987.70, fadeintime: 3, revtime: 1, nom: 1, divvy: 0.75, dur: 24, delta: 0),
  (instrument: \liljedahl, freq: 493.88, fadeintime: 3, revtime: 1, nom: 1, divvy: 0.75, dur: 24, delta: 0),
  (instrument: \liljedahl, freq: 493.88, fadeintime: 3, revtime: 1, nom: 1, divvy: 0.75, dur: 24, delta: 0),
  (instrument: \liljedahl, freq: 659.25, fadeintime: 3, revtime: 1, nom: 1, divvy: 0.75, dur: 24, delta: 18),
  // TRIBAL

  (instrument: \bozkurt,   freq: [369.99, 369.99]*2, pulse1freq: 1, pulse2freq: 2, dur: 48, delta: 0),

  (instrument: \virgo,   	 scaler1: 41.20,  scaler2: 41.20,   dur: 48, delta: 0),
  (instrument: \virgo,   	 scaler1: 123.47*2,  scaler2: 123.47*2,   dur: 48, delta: 0),
  (instrument: \virgo,     scaler1: 98.00,  scaler2: 98.00,   dur: 48, delta: 0),
  (instrument: \virgo,     scaler1: 123.47, scaler2: 123.47,  dur: 48, delta: 0),
  (instrument: \virgo,     scaler1: 164.81, scaler2: 164.81,  dur: 48, delta: 4),

  (instrument: \bozkurt,   freq: [277.18/2, 277.18]*2, 		pulse1freq: 1, pulse2freq: 2, dur: 43, delta: 4),
  (instrument: \bozkurt,   freq: [329.63/2, 329.63]*2, 		pulse1freq: 1, pulse2freq: 2, dur: 38, delta: 8),

  (instrument: \liljedahl, freq: 739.99, dur: 30, fadeintime: 0, revtime: 1, dur: 28, nom: 1, delta: 0),
  (instrument: \virgo, scaler1: 82.41, scaler2: 82.41, fadeintime: 0, dur: 28, delta: 0),
  (instrument: \virgo, scaler1: 123.47, scaler2: 123.47, fadeintime: 0, dur: 28, delta: 0),
  (instrument: \virgo, scaler1: 98, scaler2: 98, fadeintime: 0, dur: 28, delta: 0),
  (instrument: \virgo, scaler1: 123.47*2, scaler2: 123.47*2, fadeintime: 0, dur: 28, delta: 0),
  (instrument: \bozkurt,   freq: [82.41, 82.41], 				pulse1freq: 2, pulse2freq: 2, dur: 28, delta: 0),
  (instrument: \bozkurt,   freq: [123.47, 123.47], 			pulse1freq: 4, pulse2freq: 1, dur: 28, delta: 0),
  (instrument: \bozkurt,   freq: [41.20, 41.20], 				pulse1freq: 2, pulse2freq: 1, dur: 28, delta: 0),
  (instrument: \bozkurt,   freq: [61.74, 61.74], 				pulse1freq: 1, pulse2freq: 2, dur: 28, delta: 0),
  (instrument: \bozkurt,   freq: [123.47*3, 82.41*3], 	pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 1, dur: 28, delta: 0),
  (instrument: \bozkurt,   freq: [392.00, 392.00], 			pulse1freq: 2, pulse2freq: 2, dur: 28, delta: 0),
  (instrument: \liljedahl, revtime: 0, nom: 2, ampdiv: 1, decaytime: 0.001, dur: 28, delta: 0),
  (instrument: \liljedahl, revtime: 0, nom: 1, ampdiv: 1, decaytime: 0.001, dur: 28, delta: 0),
  (instrument: \liljedahl, revtime: 7, nom: 1, decaytime: 0.2, drylevel: 5, freq: 659.25, divvy: 0.5, ampdiv: 14, dur: 28, delta: 0),
  (instrument: \liljedahl, revtime: 7, nom: 1, decaytime: 0.2, drylevel: 5, freq: 493.88, divvy: 0.75, ampdiv: 14, dur: 28, delta: 0),
  (instrument: \liljedahl, revtime: 7, nom: 1, decaytime: 0.2, drylevel: 5, freq: 739.99, divvy: 0.25, ampdiv: 14, dur: 28, delta: 21),

  // NEW STUFF

  (instrument: \bozkurt,   freq: [1318.51, 1318.51/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [1318.51, 1318.51], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [987.77, 987.77/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [987.77, 987.77], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [880.00, 880.00/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [880.00, 880.00], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [783.99, 783.99/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [783.99, 783.99], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [739.99, 739.99/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [739.99, 739.99], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [659.25, 659.25/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: two, delta: zero),
  (instrument: \bozkurt,   freq: [659.25, 659.25], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: two, delta: zero),

  (instrument: \bozkurt,   freq: [369.99, 369.99]*2, pulse1freq: 1, pulse2freq: 2, dur: 3.25, delta: 3),

  (instrument: \virgo,   	 scaler1: 41.20,  scaler2: 41.20,   dur: delta + 2, delta: 0),
  (instrument: \virgo,   	 scaler1: 123.47, scaler2: 123.47,   dur: delta + 2, delta: 0),
  (instrument: \virgo,     scaler1: 98.00,  scaler2: 98.00,   dur: delta + 2, delta: 0),
  (instrument: \virgo,     scaler1: 164.81, scaler2: 164.81,  dur: delta + 2, delta: 0),

  (instrument: \bozkurt,   freq: [659.25, 659.25], pulse1freq: 2, pulse2freq: 2, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [587.33, 587.33], pulse1freq: 2, pulse2freq: 1, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [554.37, 554.37], pulse1freq: 2, pulse2freq: 2, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [493.88, 493.88], pulse1freq: 2, pulse2freq: 1, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [392.00, 392.00], pulse1freq: 1, pulse2freq: 2, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [369.99, 369.99], pulse1freq: 1, pulse2freq: 2, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [329.63, 329.63], pulse1freq: 2, pulse2freq: 2, add1: 2, add2: 2, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [82.410, 82.410], pulse1freq: 2, pulse2freq: 2, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [41.200, 41.200], pulse1freq: 4, pulse2freq: 1, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [293.66, 293.66], pulse1freq: 1, pulse2freq: 2, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [277.18, 277.18], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 2, dur: delta + 02, delta: zero),
  (instrument: \bozkurt,   freq: [123.47, 123.47], pulse1freq: 2, pulse2freq: 2, add1: 2, add2: 2, dur: delta + 02, delta: delta),

  (instrument: \bozkurt,   freq: [1318.51, 1318.51/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [1318.51, 1318.51], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [987.77, 987.77/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [987.77, 987.77], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [880.00, 880.00/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [880.00, 880.00], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [783.99, 783.99/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [783.99, 783.99], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [739.99, 739.99/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [739.99, 739.99], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [659.25, 659.25/2], pulse1freq: 4, pulse2freq: 1, add1: 2, add2: 1, dur: one, delta: zero),
  (instrument: \bozkurt,   freq: [659.25, 659.25], pulse1freq: 2, pulse2freq: 2, add1: 1, add2: 2, dur: one, delta: zero),

  (instrument: \bozkurt,   freq: [123.47, 123.47]*2, pulse1freq: 1, pulse2freq: 2, add1: 1, add2: 2, dur: 2.25, delta: 2),

  // END

  (instrument: \virgo,     fadeintime: 0, scaler1: 41.20,  scaler2: 41.20,   dur: 16, delta: 0),
  (instrument: \virgo,     fadeintime: 0, scaler1: 82.41,  scaler2: 82.41,   dur: 16, delta: 0),
  (instrument: \virgo,     fadeintime: 0, scaler1: 98.00,  scaler2: 98.00,   dur: 16, delta: 0),
  (instrument: \virgo,     fadeintime: 0, scaler1: 123.47, scaler2: 123.47,  dur: 16, delta: 0),
  (instrument: \virgo,     fadeintime: 0, scaler1: 164.81, scaler2: 164.81,  dur: 16, delta: 0),
  (instrument: \bozkurt,   freq: [369.99, 369.99]/2,   pulse1freq: 2, pulse2freq: 2, dur: 15, delta: 0),
  (instrument: \bozkurt,   freq: [277.18/2, 277.18]/2, pulse1freq: 2, pulse2freq: 2, dur: 15, delta: 0),
  (instrument: \bozkurt,   freq: [82.41, 82.41],     pulse1freq: 4, pulse2freq: 2, dur: 15, delta: 0),
  (instrument: \bozkurt,   freq: [246.94, 246.94], 	 pulse1freq: 2, pulse2freq: 1, dur: 15, delta: 0),
  (instrument: \bozkurt,   freq: [123.47, 123.47],	 pulse1freq: 2, pulse2freq: 2, dur: 15, delta: 12),

  (instrument: \bozkurt,   freq: [369.99, 369.99]*4,   pulse1freq: 1, pulse2freq: 2, dur: 2, delta: 2),

]).play;

)