
SRCS = $(shell find -X app bin config db features lib spec -name 'bootstrap*' -prune -o -type f -print)
TAGS: $(SRCS)
	etags $(SRCS)
