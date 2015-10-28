// juan_alzate_romero_1

(

SynthDef.new(\bass1,
	{
		arg numharm,adder,repeats,roomsize,revtime;
		var outArray;
		outArray = [
			GVerb.ar(
				in: Blip.ar(
					freq:
					Duty.kr(
						dur: 1/[1,2,4,8],
						reset: 0,
						level: Dseq(
							list: [0,3,5,12] + adder,
							repeats: repeats
						),
						doneAction: 2
					).midicps*[1,4,8,16],
					numharm: numharm
				).sum,
				roomsize: roomsize,
				revtime: revtime
			)
		];

		Out.ar([0,1], Pan2.ar(outArray,0,0.04));

	}
).add
)

(

SynthDef.new(\first,
	{
		arg numharm,adder,repeats,roomsize,revtime;
		var outArray;
		outArray = [
			GVerb.ar(
				in: Blip.ar(
					freq:
					Duty.kr(
						dur: 1/[1,2,4,8],
						reset: 0,
						level: Dseq(
							list: [19,17,12,7,3,0] + adder,
							repeats: repeats
						),
						doneAction: 2
					).midicps*[1,4,8],
					numharm: numharm
				).sum,
				roomsize: roomsize,
				revtime: revtime

			)
		];

		Out.ar([0,1], Pan2.ar(outArray,0,0.02));

	}
).add
)

(

SynthDef.new(\second,
	{
		arg numharm,adder,repeats,roomsize,revtime;
		var outArray;
		outArray = [
			GVerb.ar(
				in: Blip.ar(
					freq:
					Duty.kr(
						dur: 1/[1,2,4,8],
						reset: 0,
						level: Dseq(
							list: [0,3,7,12,17,19] + adder,
							repeats: repeats
						),
						doneAction: 2
					).midicps*[1,4,8],
					numharm: numharm
				).sum,
				roomsize: roomsize,
				revtime: revtime

			)
		];

		Out.ar([0,1], Pan2.ar(outArray,0,0.02));

	}
).add
)

(

SynthDef.new(\third,
	{
		arg numharm,adder,repeats,roomsize,revtime;
		var outArray;
		outArray = [
			GVerb.ar(
				in: Blip.ar(
					freq:
					Duty.kr(
						dur: 1/[1,2,4,8],
						reset: 0,
						level: Dseq(
							list: [0,3,7,12,17,19] + adder,
							repeats: repeats
						),
						doneAction: 2
					).midicps*[1,4,8,12],
					numharm: numharm
				).sum,
				roomsize: roomsize,
				revtime: revtime

			)
		];

		Out.ar([0,1], Pan2.ar(outArray,0,0.02));

	}
).add
)

(

SynthDef.new(\fourth,
	{
		arg numharm,adder,repeats,roomsize,revtime;
		var outArray;
		outArray = [
			GVerb.ar(
				in: Blip.ar(
					freq:
					Duty.kr(
						dur: 1/[4],
						reset: 0,
						level: Dseq(
							list: [0] + adder,
							repeats: repeats
						),
						doneAction: 2
					).midicps*[1,4,8,12],
					numharm: numharm
				).sum,
				roomsize: roomsize,
				revtime: revtime

			)
		];

		Out.ar([0,1], Pan2.ar(outArray,0,0.02));

	}
).add
)

(
var tempoclock = TempoClock(0.5);
{
	4.do {
		Synth(\second,[\adder,54,\numharm,0,\repeats,8,\roomsize,300,\revtime,1]);
		2.0.wait;
	};

	2.do {
		Synth(\second,[\adder,47,\numharm,0,\repeats,8,\roomsize,300,\revtime,1]);
		2.0.wait;
	};

	1.do {
		Synth(\second,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		2.0.wait;
	};

	1.do {
		Synth(\second,[\adder,78,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		2.0.wait;
	};

	2.do {
		Synth(\bass1,[\adder,54-(12*4),\numharm,0,\repeats,12,\roomsize,10,\revtime,0]);
		2.0.wait;
	};

	4.do {
		Synth(\second,[\adder,54,\numharm,0,\repeats,8,\roomsize,300,\revtime,1]);
		Synth(\bass1,[\adder,54-(12*4),\numharm,0,\repeats,12,\roomsize,10,\revtime,0]);
		1.0.wait;
	};

	4.do {
		Synth(\second,[\adder,54,\numharm,0,\repeats,8,\roomsize,300,\revtime,1]);
		Synth(\second,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\bass1,[\adder,54-(12*4),\numharm,0,\repeats,12,\roomsize,10,\revtime,0]);
		1.0.wait;
	};

	3.do {
		Synth(\second,[\adder,54,\numharm,0,\repeats,8,\roomsize,300,\revtime,1]);
		Synth(\second,[\adder,78,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\bass1,[\adder,54-(12*4),\numharm,0,\repeats,12,\roomsize,10,\revtime,0]);
		1.0.wait;
	};

	1.do {
		Synth(\second,[\adder,78-(12*2),\numharm,0,\repeats,5,\roomsize,300,\revtime,3]);
		1.0.wait;
	};

	4.do {
		Synth(\second,[\adder,78-(12*2),\numharm,0,\repeats,3,\roomsize,300,\revtime,3]);
		Synth(\first,[\adder,66,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
		Synth(\first,[\adder,61,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
	};

	4.do {
		Synth(\first,[\adder,66,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
		Synth(\first,[\adder,61,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,49,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
	};

	4.do {
		Synth(\first,[\adder,66,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,78-(12*2),\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
		Synth(\first,[\adder,61,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,49,\numharm,0,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,37,\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
	};

	1.do {
		Synth(\first,[\adder,78,\numharm,1,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,66,\numharm,1,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,1,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,78-(12*2),\numharm,1,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
		Synth(\first,[\adder,73,\numharm,1,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,1,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,49,\numharm,1,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,37,\numharm,1,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
	};

	1.do {
		Synth(\first,[\adder,78,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,66,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,78-(12*2),\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
		Synth(\first,[\adder,73,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,49,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,37,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
	};

	1.do {
		Synth(\first,[\adder,78,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,66,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,78-(12*2),\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
		Synth(\first,[\adder,73,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,49,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,37,\numharm,2,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
	};

	1.do {
		Synth(\first,[\adder,78,\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,66,\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,78-(12*2),\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
		Synth(\first,[\adder,73,\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,61,\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,49,\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,37,\numharm,3,\repeats,3,\roomsize,300,\revtime,4]);
		0.5.wait;
	};

	2.do {
		Synth(\third,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,78,\numharm,4,\repeats,8,\roomsize,300,\revtime,4]);
		1.0.wait;
	};

	2.do {
		Synth(\third,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		1.0.wait;
	};

	3.do {
		Synth(\first,[\adder,78,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,54,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		1.0.wait;
	};

	1.do {
		Synth(\first,[\adder,78,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,54,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		1.0.wait;
		Synth(\second,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,66,\numharm,1,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,80,\numharm,2,\repeats,8,\roomsize,300,\revtime,3]);
		1.0.wait;
	};

	1.do {
		Synth(\third,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\first,[\adder,78,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		1.0.wait;
		Synth(\second,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,66,\numharm,1,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,80,\numharm,2,\repeats,8,\roomsize,300,\revtime,3]);
		1.0.wait;
	};

	1.do {
		Synth(\third,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		Synth(\third,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		1.0.wait;
		Synth(\second,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,66,\numharm,1,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,80,\numharm,2,\repeats,8,\roomsize,300,\revtime,3]);
		1.0.wait;
	};

	1.do {
		Synth(\second,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,4]);
		1.0.wait;
		Synth(\second,[\adder,66,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,66,\numharm,1,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,80,\numharm,0,\repeats,8,\roomsize,300,\revtime,3]);
		Synth(\second,[\adder,80,\numharm,2,\repeats,8,\roomsize,300,\revtime,3]);
		1.0.wait;
	};

	1.do {
		Synth(\fourth,[\adder,90,\numharm,0,\repeats,5,\roomsize,300,\revtime,4]);
	};

}.fork(tempoclock);
)