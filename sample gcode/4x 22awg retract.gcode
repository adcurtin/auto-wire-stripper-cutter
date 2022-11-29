; 26 awg wire
; 1mm strip, 100 mm center, 5mm strip
; cuts 4 wires



M201 Z200 E10000 ; sets maximum accelerations, mm/sec^2
M203 Z12 E10000 ; sets maximum feedrates, mm / sec

; M204 P1250 R1250 T1250 ; sets printing and travels acceleration (P, T) and retract acceleration (R), mm/sec^2

; M205 Z0.40 E4.50 ; sets the jerk limits, mm/sec

; M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec

G90 ; use absolute coordinates
M83 ; extruder relative mode


G28 Z; home Z

G1 Z20 F720 ; Z axis to 20mm, need to clear wire diameter (should be by a bunch)
G92 E0 ; set E axis to 0

M221 S96 ; set extruder override percentage

G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion


M808 L3 ; it's off by one in marlin

;; cut a wire
G1 E8 F4000  ; 8mm
G1 Z1.5 ; strip

G1 E-6 ; retract to remove insulation
G1 Z10 ; lift
G1 E6 ; unretract
G1 E50 ; 50mm
G1 Z1.5 ; strip
G1 E-4 ; retract to remove insulation

G1 Z10 ; lift
G1 E8   ; 3.5mm
G1 Z0 ; cut
G1 Z10 ; lift
G92 E0 ; set E axis to 0

M808







G4 ; wait
M221 S100 ; reset extrusion percentage
M107 ; turn off fan

G1 Z ; Move print head up
M84 ; disable motors


; play end tune
M300 S880 P188
M300 S0 P188
M300 S1760 P188
M300 S0 P188
M300 S1976 P188
M300 S0 P188
M300 S2093 P188
M300 S2217 P188
M300 S0 P188
M300 S3520 P333
