#!/bin/bash
MY_PYTHON="python"

CIFAR_100i="--n_layers 2 --n_hiddens 100 --data_path data/data_from_gem --save_path results/ --batch_size 10 --log_every 100 --samples_per_task 1000 --data_file cifar100.pt --cuda yes --n_epochs 1 --seed 0"


# build datasets
cd data/data_from_gem/
cd raw/

$MY_PYTHON raw.py

cd ..

$MY_PYTHON cifar100.py \
	--o cifar100.pt \
	--seed 0 \
	--n_tasks 20

cd ../..

$MY_PYTHON main-data-parallel.py $CIFAR_100i --model expansion --lr 0.1 --n_memories 25 --memory_strength 0.5 --expand_size 0.6 0.4 --task_num 5
$MY_PYTHON main-multi-gpu.py $CIFAR_100i --model expansion --lr 0.1 --n_memories 256 --memory_strength 0.5 --expand_size 0.4 0.2 --task_num 5
$MY_PYTHON main-multi-gpu.py $CIFAR_100i --model expansion --lr 0.1 --n_memories 256 --memory_strength 0.5 --expand_size 0.2 0.1 --task_num 5
$MY_PYTHON main-multi-gpu.py $CIFAR_100i --model ewc --task_num 5 --lr 0.1  --n_memories 10
$MY_PYTHON main.py $CIFAR_100i --model gem --task_num 5 --lr 0.1  --n_memories 256 --memory_strength 0.5
$MY_PYTHON main-multi-gpu.py $CIFAR_100i --model regular --task_num 5 --lr 0.1
$MY_PYTHON main.py $CIFAR_100i --model adam --task_num 5 --lr 0.001  