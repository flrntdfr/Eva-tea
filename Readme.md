# Eva tea

Generates a sheet of affirmations you can print, cut, and use to make tea bags.

### Make your own affirmations

1. Save 1 affirmation per line (template under `./data/affirmation_template.txt`)
1. Name it `affirmations.txt`

### Generate the output:

* Run the sketch from processing
OR
* Run in the terminal `processing-java --sketch=/path/to/sketch_folder --run`

The output is saved under `.out/render.pdf` (the canevas does not show, it's normal)

### Hack

* Global variables are set at the head of the file (paper size, colors, font, margin, padding...)

To do:

- [ ] Add CLI: path for output / Font to use?
- [ ] Add multi-page support?
