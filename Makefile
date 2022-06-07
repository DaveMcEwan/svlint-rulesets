
RULESETS := $(basename $(notdir $(wildcard toml/*.toml)))
BIN_DIR ?= bin
BIN := $(addprefix ${BIN_DIR}/svlint-,${RULESETS})
BIN += $(addprefix ${BIN_DIR}/svls-,${RULESETS})

# Create wrapper scripts for each TOML ruleset.
default: ${BIN}

${BIN_DIR}:
	mkdir -p ${BIN_DIR}

${BIN_DIR}/%: | ${BIN_DIR}
	ln wrapperTemplate $@

clean:
	rm -rf ${BIN_DIR}/

