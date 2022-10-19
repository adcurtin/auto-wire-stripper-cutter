# remix

this is my remix of [ProjectswithRed](https://www.youtube.com/c/ProjectswithRed)'s automatic wire stripper. I've recreated (almost) all of the 3d models with openscad, to allow for parameter tweaking. I switched the extruder to an openscad model, and tweaked that extensively as well.


# todo

my encoder sucks, i don't think it's hooked up to interrupt pins or something. the lcd is wired to the i2c pins, despite it being spi. I think marlin uses software spi to drive it. Ultimately I'd like to see if I can repurpose marlin for this, but I want the ability to have a "conversational CNC" interface like the original project.



# Automatic Wire Stripper and Cutter

A 3D printed automatic wire stripper and cutter. You simply choose your measurements on a screen, press a button, and it does it all for you. It will strip the wire and cut the wire depending on the options you chose.


There is a [video](https://youtu.be/pbuzLy1ktKM) associated with this repository/project, I highly recommend watching it before using this repo.

[![Video](readme_imgs/thumbnail.png)](https://youtu.be/pbuzLy1ktKM "Automatic_wire_stripper_cutter")


# Arduino

You can find the Arduino sketch in the `/AutoWireCutterStripper` directory.



## Libraries needed

All these libraries can be easily installed using the Arduino IDE library manager.

- `Stepper` by Arduino.
- `Encoder` by Paul Stoffregen.
- `Adafruit GFX Library` by Adafruit.
- `ST7920_GFX_Library` 



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
