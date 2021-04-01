#!/bin/bash

INPUT="syslog.log"

# 1a
regex_type="(INFO|ERROR)"
regex_msgs="(?<=[INFO|ERROR] ).*(?<=\ )"
regex_err_msgs="(?<=ERROR ).*(?<=\ )"
regex_info_msgs="(?<=INFO ).*(?<=\ )"
regex_username="(?<=\().*(?=\))"

type=$(grep -oP "$regex_type" "$INPUT")
err_msgs=$(grep -oP "$regex_err_msgs" "$INPUT")
info_msgs=$(grep -oP "$regex_info_msg" "$INPUT")
msgs=$(grep -oP "$regex_msgs" "$INPUT")
username=$(grep -oP "$regex_username" "$INPUT")

# 1b
uniq_err_msgs=$(grep -oP "$regex_err_msgs" "$INPUT" | sort | uniq -c | sort -nr)

# 1c
regex_err="(?<=ERROR ).*(?<=\))"
regex_info="(?<=INFO ).*(?<=\))"
err=$(grep -oP "$regex_err" "$INPUT")
info=$(grep -oP "$regex_info" "$INPUT")


# 1d
printf "Error,Count\n" > "error_message.csv"
grep -oP "$regex_err_msgs" "$INPUT" | sort | uniq -c | sort -nr | while read count msgs;
do
	printf "%s,%d\n" "$msgs" "$count" >> "error_message.csv"
done

# 1e
printf "Username,INFO,ERROR\n" > "user_statistic.csv"
grep -oP "$regex_username" "$INPUT" | sort | uniq | while read user;
do
	n_info=$(grep -w "$user" <<< "$info" | wc -l);
	n_error=$(grep -w "$user" <<< "$err" | wc -l);
	printf "%s,%d,%d\n" "$user" "$n_info" "$n_error" >> "user_statistic.csv"
done
