.DEFAULT_GOAL := build

clean:
					go clean ./...

fclean:				clean
					rm -f tests/result/*.log

fmt:
					go fmt ./...

vet:				fmt
					go vet ./...

build:				clean vet
					go build -o main

run:				build
					./main

test:				test_readiness test_err

test_readiness:
					http -phbm GET :9999/v1/healthz > tests/result/healthz.log
					@echo -ne "Headers_StatusCode:\t"
					@awk 'NR==1' tests/expected/healthz.log > tests/result/exp.log
					@awk 'NR==1' tests/result/healthz.log > tests/result/rst.log
					@sh tests/check_result.sh
					@echo -ne "Headers_ContentType:\t"
					@awk 'NR==2' tests/expected/healthz.log > tests/result/exp.log
					@awk 'NR==2' tests/result/healthz.log > tests/result/rst.log
					@sh tests/check_result.sh
					@echo -ne "Headers_ContentLenght:\t"
					@awk 'NR==5' tests/expected/healthz.log > tests/result/exp.log
					@awk 'NR==5' tests/result/healthz.log > tests/result/rst.log
					@sh tests/check_result.sh
					@echo -ne "Body_Content:\t\t"
					@awk 'NR==7' tests/expected/healthz.log > tests/result/exp.log
					@awk 'NR==7' tests/result/healthz.log > tests/result/rst.log
					@sh tests/check_result.sh

test_err:
					http -phbm GET :9999/v1/err > tests/result/err.log
					@echo -ne "Headers_StatusCode:\t"
					@awk 'NR==1' tests/expected/err.log > tests/result/exp.log
					@awk 'NR==1' tests/result/err.log > tests/result/rst.log
					@sh tests/check_result.sh
					@echo -ne "Headers_ContentType:\t"
					@awk 'NR==2' tests/expected/err.log > tests/result/exp.log
					@awk 'NR==2' tests/result/err.log > tests/result/rst.log
					@sh tests/check_result.sh
					@echo -ne "Headers_ContentLenght:\t"
					@awk 'NR==5' tests/expected/err.log > tests/result/exp.log
					@awk 'NR==5' tests/result/err.log > tests/result/rst.log
					@sh tests/check_result.sh
					@echo -ne "Body_Content:\t\t"
					@awk 'NR==7' tests/expected/err.log > tests/result/exp.log
					@awk 'NR==7' tests/result/err.log > tests/result/rst.log
					@sh tests/check_result.sh

.PHONY:clean fclen fmt vet build run test test_readiness test_err
