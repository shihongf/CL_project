#!/usr/bin/env bash

#source activate mer
seed=1

PERM="--n_layers 2 --n_hiddens 100 --data_path data --save_path results --batch_size 1 --log_every 100 --samples_per_task 1000 --data_file mnist_permutations_20.pt --cuda no --seed "

python main.py $PERM $seed --model regular --lr 0.01 --task_num 6



