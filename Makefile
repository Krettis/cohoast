# VAR
RONN := ronn
PAGES := cohoast.1
BATS := bats
CHECK:= shellcheck
ALL:= test lint
LINT_FILES := run.sh
COMMIT := test lint

# GROUPED
all: $(ALL)
commit: $(COMMIT)

# CODE CHECKS
test: tests/
	$(BATS) $<

lint:
	$(CHECK) -e 2048,2046,2086,2034  $(LINT_FILES)

lintc:
	$(CHECK) $(LINT_FILES)


# DOCUMENTATION
man: $(PAGES)

cohoast.1: man/cohoast.1.ronn
	$(RONN) -r $<

