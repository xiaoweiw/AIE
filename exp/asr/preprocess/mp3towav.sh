# params: input (wav); output (raw)

ffmpeg -i $1 -ar 8000 -ac 1 $2
