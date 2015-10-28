// jonatan_liljedahl_1

(
SynthDef(
	\sawFilt,
	{
		|
		out = 0,
		freq,
		freq2,
		freq3,
		freq4,
		amp = 0.95,
		gate = 1,
		cf = 100,
		wobble = 3,
		t_bd,
		t_bd2,
		t_bd3,
		t_bd4,
		t_sd,
		t_sd2,
		t_sd3,
		t_sd4,
		pw = 0.4,
		bd_decayTime = 1,
		range_lo = 0.5,
		range_hi = 4,
		d1 = 1,
		d2 = 1,
		d3 = 1,
		d4 = 1,
		sd_freq = 120,
		sd_decay_time = 0.75,
		bd_mul
		|

		var base = Splay.ar(
			inArray: RLPF.ar(
				in: Pulse.ar(
					[freq,freq2,freq3,freq4] * [d1,d2,d3,d4],
					pw
		    ),
				freq: cf.lag(0.05),
				rq: 0.3
		  ).madd(SinOsc.ar(wobble).range(range_lo,range_hi)).sin) * 0.5;

		var env = Linen.kr(
			gate,
			attackTime: 0.01,
			releaseTime: 0.5,
			doneAction: 2
		);

		var sig = base;

		// bassdrum
		var bd = tanh(
			Ringz.ar(
				in: LPF.ar(
					in: Trig.ar(
						in: ([t_bd,t_bd2] + [t_bd3,t_bd4]) * 2,
						dur: SampleDur.ir
		      ),
					freq: 1000
		    ),
				freq: 15,
				decaytime: 0.25,
				mul: bd_mul
		  ).sin * 2);

		// snaredrum
		var sd = tanh(
			Ringz.ar(
				in: LPF.ar(
					in: Trig.ar(
						[t_sd,t_sd2] + [t_sd3,t_sd4],
						SampleDur.ir
		      ),
					freq: 1000
		    ),
				freq: sd_freq,
				decaytime: sd_decay_time,
				mul: PinkNoise.ar(4!2)
		  ).sin*2
		);

		sd = HPF.ar(
			in: sd,
			freq: 100
		);

		// reverb
		sig = tanh(
			GVerb.ar(
				in: HPF.ar(
					in: base * env,
					freq: 400
		    ),
				roomsize: 70,
				revtime: 13,
				damping: 0.5
		  ) * 0.5 + sig + bd + sd
		);

		// to turn reverb off
		// sig = sig + bd + sd;

		Out.ar(out, sig*amp*env);
}).add;
);

(
var t=TempoClock.new,
    halt_pos=144,
    num=0,
    num2=0,
		a = Pbind(
         \args, #[wobble],
			   \wobble, Pxrand([3,1.5,6],inf),
         \dur, Prand([2,1],inf)
    ),
    b = Pbind(
				 \args, #[cf],
				 \cf, Pseq([100,Prand([700,400,1100],3)],inf),
				 \stutter, Prand([1,2,4,8],inf),
				 \dur, PdurStutter(Pkey(\stutter)*2, 2),
    ),
		k = Pbind(
          \args, #[freq,freq3,range_lo,range_hi,d1,d2,d3,d4,cf],
    		  \freq,  Pseq([
		              Pseq([56,54,50]+12,10).midicps,
           		  ],inf),
       	  \freq3, Pseq([
 					         Pseq([49,47,50,73,97,56,85],1).midicps,
              	 ],inf),
				  \range_lo, 0.1, // use this :)
     		  \range_hi, 1.0, // use this too :)
				  \d1, 2,
				  \d2, 3.99,
				  \d3, 4.01,
    		  \d4, 1,
    		  \cf, Pseq([800,Prand([1700,2400,1100,1400,400]*7,5)],inf),
          \stutter, Prand([1,2,4,8],inf),
    		  \dur, Pseq([0.125,Prand([0.125,0.25,0.25,0.125,0.125,0.25,0.125],7)],inf)
    ),
    l = Pbind(
				  \args, #[freq,freq3,range_lo,range_hi,cf],
				  \freq, Pseq([
					         Pseq([49,47,50,73],4).midicps,
		               Pseq([49,47,50,73]+7,1).midicps,
			           ], inf),
				  \freq3, Pseq([
					         Pseq([49,47,50,73],8).midicps,
          				 Pseq([49,47,50,73]+7,1).midicps,
		              ], inf),
  				\range_lo, 0.5,
	  			\range_hi, 4.0,
		  		\cf, Pseq([100,Prand([300,400,700],3)],inf),
			  	\dur, 1.0
		),
    m = Pbind(
				  \args, #[freq2,freq4,range_lo,range_hi,cf],
				  \freq2, Pseq([
					         Pseq([49,47,50,73],4).midicps,
		               Pseq([49,47,50,73]+7,1).midicps,
			           ], inf),
				  \freq4, Pseq([
					         Pseq([49,47,50,73],8).midicps,
          				 Pseq([49,47,50,73]+7,1).midicps,
		              ], inf),
  				\range_lo, 0.5,
	  			\range_hi, 4.0,
		  		\cf, Pseq([100,Prand([300,400,700],3)],inf),
			  	\dur, 1.0
		);

p = Pproto(
    {
      ~id = (
        type: \on,
        dur: 0,
        instrument: \sawFilt,
        amp: 1.0,
      ).yield[\id];
      ~type = \set;
    },

	  Ppar([

     Pseq([
  	    Pbind(\dur, 0, \freq, Pseq([\rest]) ),
			  Psync(l,1,halt_pos)
  	 ],1),

     Pseq([
  	    Pbind(\dur, 0, \freq3, Pseq([\rest]) ),
			  Psync(m,1,halt_pos)
  	 ],1),

		Pseq([
			Pbind(\dur, 32, \freq, Pseq([\rest]) ),
			Pbind(
				\args, #[t_bd,t_bd2,bd_mul],
				\t_bd, Pseq([0.25,0,0.5], (halt_pos - 32.5)/(0.25 * 3)),
				\t_bd2, Pseq([0.25,0,0.5],(halt_pos - 32.5)/(0.25 * 3)),
				\bd_mul, 10,
				\dur, 0.25
			)
		],1),

		Pseq([
			Pbind(\dur, 16,\freq, Pseq([\rest]) ),
			Psync(b,1,halt_pos-16)
		],1),

		Pseq([
			Pbind(\dur, 16, \freq, Pseq([\rest]) ),
			Pbind(
				\args, #[t_bd3,t_bd4,bd_mul],
				\t_bd3, Pseq([
					Pseq([0.25,0,0.5,0.1,0.75],1),
					Pseq([0.25,0,0.5,0.1,0.75,1],1),
					Pseq([0.25,0,0.5,0.1,0.75,1,0.5],),
				],((halt_pos-16)/(0.125*18))),
				\t_bd4, Pseq([
					Pseq([0.25,0,0.5,0.1,0.75],1),
					Pseq([0.25,0,0.5,0.1,0.75,1],1),
					Pseq([0.25,0,0.5,0.1,0.75,1,0.5],),
				],((halt_pos-16)/(0.125*18))),
				\dur, 0.125,
				\bd_mul, 7
			)
		],1),

		Pseq([
			Pbind(\dur, 32, \freq, Pseq([\rest]) ),
			Psync(a,1,halt_pos-32)
		],1),

		Pseq([
			Pbind(\dur, 32, \freq, Pseq([\rest]) ),
			Pbind(
				\args, #[t_sd,t_sd2],
				\t_sd, Pseq([0.1,0,0.25,0],(halt_pos - 32)/(0.125 * 4)),
				\t_sd2, Pseq([0.35,0,0.25,0],(halt_pos - 32)/(0.125 * 4)),
				\sd_decay_time, 0.035,
				\dur, 0.125
			)
		],1),

		Pseq([
			Pbind(\dur, 48, \freq, Pseq([\rest]) ),
			Pbind(
				\args, #[freq,freq3,range_lo,range_hi,cf],
				\freq, Pseq([
					Pseq([49,47,50]+12,1).midicps,
					Pseq([49,47,50,73]+12,1).midicps,
					Pseq([49,47,50,73,97]+12,1).midicps,
				],(halt_pos-48)/(0.125 * 12)),
				\freq3, Pseq([
					Pseq([49,47,50]+12,1).midicps,
					Pseq([49,47,50,73]+12,1).midicps,
					Pseq([49,47,50,73,97]+12,1).midicps,
				],(halt_pos-48)/(0.125 * 12)),
				\range_lo, 3.1,
				\range_hi, 5.0,
				\cf, Pseq([100,Prand([700,400,1100],3)],inf),
				\dur, 0.125
			)
		],1),

	  Pseq([
			Pbind(\dur, 80, \freq, Pseq([\rest]) ),
			Pbind(
				\args, #[t_sd3,t_sd4,sd_freq],
				\t_sd3, Pseq([0.5,0,0.25,0,0.35]*2,((halt_pos-80)/(5*0.125))),
				\t_sd4, Pseq([0.35,0,0.25,0,0.5]*2,((halt_pos-80)/(5*0.125))),
				\sd_freq, 1100,
				\sd_decay_time, 0.035,
				\dur, 0.125
			)
		],1),

	 Pseq([
			Pbind(\dur, 96, \freq, Pseq([\rest]) ),
			Pbind(
				\args, #[freq2,freq4,range_lo,range_hi,cf,d1,d2,d3,d4],
				\freq, Pseq([
					Pseq([49,47,50],1).midicps,
					Pseq([49,47,50,73],1).midicps,
					Pseq([49,47,50,73,97],1).midicps,
				],(halt_pos-96)/(0.125 * 12)),
				\freq3, Pseq([
					Pseq([49,47,50],1).midicps,
					Pseq([49,47,50,73],1).midicps,
					Pseq([49,47,50,73,97],1).midicps,
				],(halt_pos-96)/(0.125 * 12)),
				\range_lo, 5.1,
				\range_hi, 7.0,
				\d1, 2,
				\d3, 4,
				\cf, Pseq([100,Prand([700,400,1100],3)],inf),
				\dur, 0.125
			)
			],1),

		/////////////

     Pseq([
  	    Pbind(\dur, halt_pos, \freq, Pseq([\rest]) ),
			  Psync(k,1,inf)
  	 ],1),

		 Pseq([
  	    Pbind(\dur, halt_pos, \freq, Pseq([\rest]) ),
        Pbind(
            \args, #[freq4,freq2,dur,range_lo,range_hi,d1,d2,d3,d4],
				    \freq2, Pseq([56,54,50,48]-24,inf).midicps,
            \freq4, Pseq([49,47,50,48]-24,inf).midicps,
            \dur, 4,
				    \range_lo, 8.1,
				    \range_hi, 10.0,
				    \d1, 1.01,
				    \d2, 2.0,
				    \d3, 0.99,
				    \d4, 1.0
        )
		 ],1),

      Pseq([
  	    Pbind(\dur, halt_pos, \freq, Pseq([\rest]) ),
        Pbind(
            \args, #[t_bd3,t_bd4,bd_mul],
    				\t_bd3, Pseq([1],inf),
    				\t_bd4, Pseq([1],inf),
				    \bd_mul, 5,
				    \dur, Pseq([0.125,0.5,0.5,0.5,0.25,0.125],inf)
        )
			],1),

     Pseq([
  	    Pbind(\dur, halt_pos+17, \freq, Pseq([\rest]) ),
        Pbind(
            \args, #[t_bd,t_bd2,bd_mul],
				\t_bd, Pseq([0,1,0,1,1,0],inf),
				\t_bd2, Pseq([1,0,1,1,0,1],inf),
				    \bd_mul, 5,
				    \dur, Pseq([0.125,0.5,0.5,0.5,0.25,0.125],inf)
        )
			],1),

     Pseq([
   	    Pbind(\dur, halt_pos+32, \freq, Pseq([\rest]) ),
        Pbind(
			     \args, #[t_sd,t_sd2,sd_decay_time,sd_freq],
      		 \t_sd,  Pseq([1,Prand([2,0,1.5,0,4,0]*3,inf)],inf),
			     \t_sd2, Pseq([1,Prand([2,0,1.5,0,3,0]*2,inf)],inf),
				   \sd_freq, 30,
				   \sd_decay_time, 0.035,
			     \dur, 0.125
		      )
		  ],1),

    ])
).play(t);
);