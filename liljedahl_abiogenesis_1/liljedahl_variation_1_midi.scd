(
o=s.options;
o.memSize;
o.memSize = 2.pow(16);
//you could also do this
//o.memSize_(2.pow(16));
// s.quit;
// s.boot;
o.memSize;
Server.default=s=Server.local;
s.boot;

MIDIClient.init;
MIDIIn.connect(0,MIDIClient.sources[0]);
MIDIIn.noteOn= { arg src, chan, num, vel;   [chan,num,vel / 127].postln; };
MIDIIn.control = { arg src, chan, num, val;   [chan,num,val/127].postln; };
MIDIIn.bend = { arg src, chan, bend;    [chan,bend/8192].postln; };
)

(
MIDIIn.control = { |src, chan, num, val|
  var arrg, mul;
  mul = 1;
  switch (num,
    0,   { arrg = \resMult; mul = 16; },
    1,   { arrg = \padMul; mul = 3; },
    2,   { arrg = \room; mul = 1; },
    3,   { arrg = \dcy; mul = 3; },

    4,   { arrg = \melodyMult; mul = 16; },
    5,   { arrg = \melodyHighMult; mul = 16; },
    6,   { arrg = \denom; mul = 1; },
    7,   { arrg = \denomHigh; },

    8,   { arrg = \harmonix; mul = 100; },
    9,   { arrg = \highHarmonix; mul = 100; },
    10,   { arrg = \brightness; mul = 5000; },
    11,   { arrg = \fuzz; mul = 40     ; },

    12,   { arrg = \bd; mul = 4; },
    13,   { arrg = \sd; mul = 4; },
    14,   { arrg = \sdMul1; mul = 8; },
    15,   { arrg = \sdMul2; mul = 8; }
  );

  x.set(arrg, val/127 * mul);
  [chan,num,val/127 * mul, arrg].postln;
};

);