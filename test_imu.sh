#!/bin/bash

if [[ ( $@ == "--help") ||  $@ == "-h" ]]
then
	echo "Testing script for NILoc"
	echo "Usage: \"$0 [building] [checkpoint files] [extra hydra overrides ...]\""
	echo "Example: \"$0 avalon_2nd_floor checkpoints.txt test_cfg.test_name=my_eval test_cfg.ffmpeg_path=/usr/bin/ffmpeg\""
	echo "Buildings should be configured in niloc/config. Default options=[A, B, C]"
	exit 0
fi

echo $1 'Building'
echo $#

EXTRA_ARGS="${@:3}"

python niloc/cmd_test_file.py \
	run_name=$1 \
	dataset=$1 \
	grid=$1 \
	data=test \
	task=scheduled_2branch \
	test_cfg.test_name=out \
	test_cfg.minimal=false \
	test_cfg.save_output_trajectory=true \
	test_cfg.full_traj_heatmap=true \
	test_cfg.individual_traj_heatmap=true \
	test_cfg.full_error_bar=true \
	$EXTRA_ARGS \
	ckpt_file=${2}
