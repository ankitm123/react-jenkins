FROM scratch

EXPOSE 3000
COPY jenTest /
COPY ./build/ /build/
CMD ["/jenTest"]