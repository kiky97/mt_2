#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# link default training data for easier access

mkdir -p $data/wikitext-2

for corpus in train valid test; do
    absolute_path=$(realpath $tools/pytorch-examples/word_language_model/data/wikitext-2/$corpus.txt)
    ln -snf $absolute_path $data/wikitext-2/$corpus.txt
done

# download a different interesting data set!

mkdir -p $data/yellow_wallpaper

mkdir -p $data/yellow_wallpaper/raw

curl -o pg1952.txt https://www.gutenberg.org/cache/epub/1952/pg1952.txt
mv pg1952.txt $data/yellow_wallpaper/raw/yellow_wallpaper.txt

# preprocess slightly

cat $data/yellow_wallpaper/raw/yellow_wallpaper.txt | python $base/scripts/preprocess_raw.py > $data/yellow_wallpaper/raw/yellow_wallpaper.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/yellow_wallpaper/raw/yellow_wallpaper.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > \
    $data/yellow_wallpaper/raw/yellow_wallpaper.preprocessed.txt

# split into train, valid and test

head -n 440 $data/yellow_wallpaper/raw/yellow_wallpaper.preprocessed.txt | tail -n 400 > $data/yellow_wallpaper/valid.txt
head -n 840 $data/yellow_wallpaper/raw/yellow_wallpaper.preprocessed.txt | tail -n 400 > $data/yellow_wallpaper/test.txt
tail -n 3075 $data/yellow_wallpaper/raw/yellow_wallpaper.preprocessed.txt | head -n 2955 > $data/yellow_wallpaper/train.txt
