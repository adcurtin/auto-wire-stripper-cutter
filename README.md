# remix

this is my remix of [ProjectswithRed](https://www.youtube.com/c/ProjectswithRed)'s automatic wire stripper. I've recreated (almost) all of the 3d models with openscad, to allow for parameter tweaking. I switched the extruder to an openscad model, and tweaked that extensively as well.




# Automatic Wire Stripper and Cutter

A 3D printed automatic wire stripper and cutter. I had some old 3d printers that had been retired, I reused those parts for this project. I used a mainboard from a wanhao i3, and 24v steppers from a makerbot replicator 1 (though the wanhao steppers would've been fine at 12v). I'm using a 20V 65W lenovo laptop power supply that had a frayed end.

I'm running Marlin on this, since that can already do everything I need and I don't have to write or maintain any code :).

# Marlin notes

X and Y endstops are always triggered, so `G28` won't fail.
I modified the Z endstop to be optical, so that's inverted from the wanhao's config.





# Components

- I used some parts from old, dead 3d printers. mainboard, lcd, and rotary encode from a wanhao i3, steppers from a makerbot replicator 1, and a power supply from a lenovo laptop that had the end frayed / broken.


- [D8mm L100mm lead screw](https://www.amazon.co.uk/dp/B07QWKG317?ref_=cm_sw_r_cp_ud_dp_JMAC4EKE28W5Z3GSZSN8) (x2), for the linear motion.
- [D8mm lead screw nut](https://www.amazon.co.uk/dp/B07QWKG317?ref_=cm_sw_r_cp_ud_dp_JMAC4EKE28W5Z3GSZSN8) (x2), to attach the top blade housing to the lead screws.
- [5x8mm rigid shaft coupler](https://www.amazon.co.uk/dp/B096G1GZH5?ref_=cm_sw_r_cp_ud_dp_VWE1T2SQZQB0X13TQ1F7) (x2), to attach the lead screws to the stepper motors.
- [10mm magnets](https://www.amazon.co.uk/dp/B08FSTRRDR?ref_=cm_sw_r_cp_ud_dp_13WEC590XVADQKN2RJ0W) (x2), to attach the container.
- [KNIPEX V-blades](https://www.amazon.co.uk/dp/B00161GBDW?ref_=cm_sw_r_cp_ud_dp_S63KK1ZZ8DPRHWMBEFJC), to cut and strip the wires.


# 3D printing

Please refer to the `/3d_printing` directory.

# Assembly layout
This is the layout of the components on the board. Use this only for reference on roughly where you should fix the components to the board. I don't suggest using this for exact measurements as you should position the components where it is appropriate for your version of the project.

[Layout PDF](./assembly_layout.pdf).
