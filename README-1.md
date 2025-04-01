# MT Exercise 2: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/marpng/mt-exercise-02
    cd mt-exercise-02

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

Download and preprocess data:

    ./scripts/download_data.sh

Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh

# some changes about ex_2.1
The Yellow Wallpaper, a famous short story by Charlotte Perkins Gilman. It's a powerful narrative about a woman suffering from postpartum depression who is confined to a room with yellow wallpaper, which begins to drive her mad.
Because my computer system is windows systems. so I use git bash to help me run some command lines. In the download_data.sh, wegt does not work in the git bash, so I use curl-o to download data set from Gutenberg Project. 
In the train.sh and generate.sh, I changed book variables. In the main.py, I changed this code line,  model = torch.load(f, weights_only=False) ,because I had some errors when I trained the models.


# some changes about ex2.2
In the train.sh, I made some changes, for example, I add 5 different drop rate and embeding and hidden size, I also add some log-file different model code lines to save different drop rate text.

I also changed main.py, add parser.add_argument('--log-perplexity', type=str, default='', help='path to save the perplexity log file') and changed try part.

In the generate.sh, I changed the variables about model and sample, to generate different text with different model and drop out rate.

In conclusion, becasue I chose a short story with Gutenberg advertisement, so the generated texts have some sentences about Gutenberg project
