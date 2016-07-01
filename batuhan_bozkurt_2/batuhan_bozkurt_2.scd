// batuhan_bozkurt_2

(

SynthDef(\beatz,	{

	|a=8,b=10,c=80,d=0.4,e=6,f=0.8,g=0.2,h=0.4,freq=55,decaytime=1,mul=1|

	var snd = {

		var arr1 = [a,b,c,d,e,f,g,h];
		var arr2 = [a,b,c,d,e,f,g,h].reverse;

		var y = Demand.ar(
			Impulse.ar(8),
			0,
			[
				Dseq(arr1,inf),
				Dseq(arr2,inf)
			]

		);

		AllpassC.ar(
			in: SinOsc.ar(freq,1).tanh,
			delaytime: y,
			decaytime: decaytime,
			mul: mul
		)

	};

	/* MASTERING by rukano */

	snd = LeakDC.ar(snd); // remove DC
	snd = CompanderD.ar(snd, 0.5, 1, 1/4, 0.01, 0.1).tanh; // soft comp
	snd = (snd * 0.75) + LPF.ar(snd, 220, 0.25) + BPF.ar(snd, 2000, 3, 0.5).tanh + HPF.ar(snd , 10000, 2).tanh; // EQing
	snd = Compander.ar(snd, snd, 0.95, 1, 0.01, 0.015, 0.1); // hard comp
	snd = Limiter.ar(snd); // limiter
	snd = LeakDC.ar(snd); // remove further DC if some was created in the chain

	Out.ar(0, snd);
}).add;

);

// s.prepareForRecord;
(

var tempoclock = TempoClock(0.5);
var wait_len = 4;

{

  1.do {

    // s.record;

    z = Synth(\beatz);
    wait_len.wait;

    z.set(\a, 4, \b, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \g, 0.2, \h, 0.4);
    wait_len.wait;

    z.set(\h, 4, \b, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \g, 0.2, \a, 0.4);
    wait_len.wait;

    z.set(\h, 4, \g, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \b, 0.2, \a, 0.4);
    wait_len.wait;

    z.set(\h, 4, \g, 5, \f, 40, \d, 0.2, \e, 6, \c, 0.8, \b, 0.2, \a, 0.4);
    wait_len.wait;

    z.set(\h, 4, \g, 5, \f, 40, \e, 0.2, \d, 6, \c, 0.8, \b, 0.2, \a, 0.4);
    // 5
    y = Synth(\beatz, [\freq, 56]);
    wait_len.wait;

    y.set(\a, 4, \b, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \g, 0.2, \h, 0.4);
    wait_len.wait;

    y.set(\h, 4, \b, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \g, 0.2, \a, 0.4);
    wait_len.wait;

    y.set(\h, 4, \g, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \b, 0.2, \a, 0.4);
    wait_len.wait;

    y.set(\h, 4, \g, 5, \f, 40, \d, 0.2, \e, 6, \c, 0.8, \b, 0.2, \a, 0.4);
    wait_len.wait;

    y.set(\h, 4, \g, 5, \f, 40, \e, 0.2, \d, 6, \c, 0.8, \b, 0.2, \a, 0.4);
    // 10
    x = Synth(\beatz, [\freq, 54]);
    wait_len.wait;

    x.set(\a, 4, \b, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \g, 0.2, \h, 0.4);
    wait_len.wait;

    x.set(\h, 4, \b, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \g, 0.2, \a, 0.4);
    wait_len.wait;

    x.set(\h, 4, \g, 5, \c, 40, \d, 0.2, \e, 6, \f, 0.8, \b, 0.2, \a, 0.4);
    wait_len.wait;

    x.set(\h, 4, \g, 5, \f, 40, \d, 0.2, \e, 6, \c, 0.8, \b, 0.2, \a, 0.4);
    wait_len.wait;

    // 16
    w = Synth(\beatz, [\freq, 622.25, \mul, 0.025]);
    (wait_len*2).wait;

    v = Synth(\beatz, [\freq, 466.16, \mul, 0.05]);
    (wait_len*2).wait;

    u = Synth(\beatz, [\freq, 493.88, \mul, 0.075]);
    (wait_len*2).wait;

    t = Synth(\beatz, [\freq, 369.99, \mul, 0.1]);
    (wait_len*2).wait;

    r = Synth(\beatz, [\freq, 415.3, \mul, 0.15]);
    (wait_len*2).wait;

    p = Synth(\beatz, [\freq, 349.23, \mul, 0.2]);
    (wait_len*2).wait;

    q = Synth(\beatz, [\freq, 311.13, \mul, 0.25, \h, 4, \g, 5, \f, 40, \d, 0.2, \e, 6, \c, 0.8, \b, 0.2, \a, 0.4, \decaytime, 2]);
    (wait_len).wait;

    z.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    y.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    x.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    w.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    v.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    u.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    t.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    r.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    p.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);
    q.set(\h, 0.004, \g, 0.005, \f, 20, \d, 0.2, \e, 60, \c, 0.08, \b, 0.02, \a, 6, \decaytime, 0.1);

    (wait_len*2).wait;

    w.set(\freq, 1244.5, \mul, 0.05, \decaytime, 1);
    (wait_len/2).wait;

    v.set(\freq, 932.32, \mul, 0.05, \decaytime, 1);
    (wait_len/2).wait;

    u.set(\freq, 987.76, \mul, 0.05, \decaytime, 1);
    (wait_len/2).wait;

    t.set(\freq, 739.98, \mul, 0.05, \decaytime, 1);
    (wait_len/2).wait;

    r.set(\freq, 830.6, \mul, 0.05, \decaytime, 1);
    (wait_len/2).wait;

    p.set(\freq, 698.46, \mul, 0.05, \decaytime, 1);
    (wait_len/2).wait;

    q.set(\freq, 622.26, \mul, 0.05, \decaytime, 1);

    i = Synth(\beatz, [\freq, 1243.5, \mul, 0.05]);
    j = Synth(\beatz, [\freq, 931.32, \mul, 0.05]);
    k = Synth(\beatz, [\freq, 986.76, \mul, 0.05]);
    l = Synth(\beatz, [\freq, 738.98, \mul, 0.05]);
    m = Synth(\beatz, [\freq, 829.6, \mul, 0.05]);
    n = Synth(\beatz, [\freq, 697.46, \mul, 0.05]);
    o = Synth(\beatz, [\freq, 621.26, \mul, 0.05]);

    wait_len.wait;

    32.do {
      1.do {
        var hh = round(rrand(0.0001, 1.0), 0.001);
        var gg = round(rrand(0.0001, 1.0), 0.001);
        var ff = round(rrand(0.0001, 1.0), 0.001);
        var ee = round(rrand(0.0001, 1.0), 0.001);
        var dd = round(rrand(0.0001, 1.0), 0.001);
        var cc = round(rrand(0.0001, 1.0), 0.001);
        var bb = round(rrand(0.0001, 1.0), 0.001);
        var aa = round(rrand(0.0001, 1.0), 0.001);

        z.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        y.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        x.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        w.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        v.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        u.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        t.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        r.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        p.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
        q.set(\h, hh, \g, gg, \f, ff, \e, ee, \d, dd, \c, cc, \b, bb, \a, aa, \decaytime, 1);
      };
      (wait_len/16).wait;
    };

    wait_len.wait;

    i.free;
    j.free;
    k.free;
    l.free;
    m.free;
    n.free;
    o.free;
    w.free;
    y.free;
    x.free;
    v.free;
    u.free;
    t.free;
    r.free;
    p.free;
    q.free;

    (wait_len/2).wait;

    z.free;

    // s.stopRecording;

  };

}.fork(tempoclock);

);
