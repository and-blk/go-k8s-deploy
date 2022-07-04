FROM golang:1.18.3
ADD go_source/main .

ENTRYPOINT ["./main"]