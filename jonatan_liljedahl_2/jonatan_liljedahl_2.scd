// jonatan_liljedahl_2

(
	var tempoclock = TempoClock(0.5);
	var wait = 10.0;
	{
		1.do {
			play{
				x=0;
				(50..120).do { |f|
					f = f/2;
					x = SinOsc.ar(
						f+[0,1],
						x * Line.kr(
							start: 1,
							end: 2,
							dur: tempoclock.beatDur * 120,
							doneAction:2
						)
					)
				};
				tanh(
					x + Ringz.ar(
						in: Impulse.ar(2),
						freq: 45,
						decaytime: 0.3,
						mul: 3
					)
				)
			};
			wait.wait;
		};
		1.do {
			play{
				y=0;
				(50..120).do { |f|
					f = f/2;
					y = SinOscFB.ar(
						f+60+[0,1],
						y + Line.kr(
							start: 1,
							end: 2,
							dur: tempoclock.beatDur * 110,
							doneAction:2
						)
					);
				};
				tanh(
					y + Ringz.ar(
						in: Impulse.ar(2),
						freq: 45,
						decaytime: 0.3,
						mul: 3
					)
				)
			};
			wait.wait;
		};
		1.do {
			play{
				z=0;
				(50..120).do { |f|
					f = f/2;
					z = SinOsc.ar(
						f+180+[0,1],
						z + Line.kr(
							start: 1,
							end: 2,
							dur: tempoclock.beatDur * 100,
							doneAction:2
						)
					);
				};
				tanh(
					z + Ringz.ar(
						in: Impulse.ar(2),
						freq: 90,
						decaytime: 0.3,
						mul: 3
					)
				)
			};
			wait.wait;
		};
		1.do {
			play{
				a=0;
				(50..120).do { |f|
					f = f/2;
					a = SinOscFB.ar(
						f+475+[0,1],
						a + Line.kr(
							start: 1,
							end: 2,
							dur: tempoclock.beatDur * 90,
							doneAction:2
						)
					);
				};
				tanh(
					a + Formlet.ar(
						in: Impulse.ar(3),
						freq: 90,
						decaytime: 0.3,
						mul: 3
					)
				)
			};
			wait.wait;
		};
		1.do {
			play{
				b=0;
				(50..120).do { |f|
					f = f/2;
					b = SinOscFB.ar(
						f+360+[0,1],
						b + Line.kr(
							start: 1,
							end: 2,
							dur: tempoclock.beatDur * 80,
							doneAction:2
						)
					);
				};
				tanh(
					b + Ringz.ar(
						in: Impulse.ar(3),
						freq: 90,
						decaytime: 0.1,
						mul: 5
					)
				)
			};
			wait.wait;
		};
		1.do {
			play{
				c=0;
				(50..120).do { |f|
					f = f/2;
					c = SinOscFB.ar(
						f+300+[0,1],
						c + Line.kr(
							start: 1,
							end: 2,
							dur: tempoclock.beatDur * 70,
							doneAction:2
						)
					);
				};
				tanh(
					c + Ringz.ar(
						in: Impulse.ar(3),
						freq: 90,
						decaytime: 0.1,
						mul: 5
					)
				)
			};
			wait.wait;
		};
		1.do {
			play{
				d=0;
				(50..120).do { |f|
					f = f/2;
					d = SinOscFB.ar(
						f+240+[0,1],
						d + Line.kr(
							start: 1,
							end: 2,
							dur: tempoclock.beatDur * 60,
							doneAction:2
						)
					);
				};
				tanh(
					d + Ringz.ar(
						in: Impulse.ar(4),
						freq: 45,
						decaytime: 0.1,
						mul: 5
					)
				)
			};
			(wait * 2).wait;
		};
		1.do {
			play{
				e=0;
				(50..120).do { |f|
					f = f/2;
					e = SinOscFB.ar(
						f+220+[0,1],
						e + Line.kr(
							start: 1,
							end: 3,
							dur: tempoclock.beatDur * 40,
							doneAction:2
						)
					);
				};
				tanh(
					e + Ringz.ar(
						in: Impulse.ar(5),
						freq: 90,
						decaytime: 0.1,
						mul: 5
					)
				)
			};
			39.65.wait;
			play{
				g=0;
				h=0;
				i=0;
				j=0;
				(50..120).do { |f|
					f = f/2;
					g = SinOsc.ar(
						f+300+[0,1],
						g * Line.kr(
							start: 1,
							end: 2,
							dur: 40,
							doneAction:2
						)
					)
				};
				(50..120).do { |f|
					f = f/2;
					h = SinOsc.ar(
						f+240+[0,1],
						h * Line.kr(
							start: 1,
							end: 3,
							dur: tempoclock.beatDur * 20,
							doneAction:2
						)
					)
				};
				(50..120).do { |f|
					f = f/2;
					i = SinOsc.ar(
						f+475+[0,1],
						i * Line.kr(
							start: 1,
							end: 3,
							dur: tempoclock.beatDur * 20,
							doneAction:2
						)
					)
				};
				(50..120).do { |f|
					f = f/2;
					j = SinOsc.ar(
						f+535+[0,1],
						j * Line.kr(
							start: 1,
							end: 3,
							dur: tempoclock.beatDur * 20,
							doneAction:2
						)
					)
				};
				tanh(
					g + h + i + j + Ringz.ar(
						in: Impulse.ar(1),
						freq: 45,
						decaytime: 0.3,
						mul: 3
					)
				)
			};
		};
	}.fork(tempoclock);
)