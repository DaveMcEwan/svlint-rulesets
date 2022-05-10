
BIN_DIR ?= bin
RULESETS := $(basename $(notdir $(wildcard toml/*.toml)))
SVLINT_BIN := $(addprefix $(BIN_DIR)/svlint-,${RULESETS})
SVLS_BIN := $(addprefix $(BIN_DIR)/svls-,${RULESETS})

# Create wrapper scripts for each TOML ruleset.
default: ${SVLINT_BIN}
default: ${SVLS_BIN}

$(BIN_DIR):
	mkdir -p ${BIN_DIR}

$(BIN_DIR)/svlint-%: | $(BIN_DIR)
	ln svlint-wrapperTemplate $@

$(BIN_DIR)/svls-%: | $(BIN_DIR)
	ln svls-wrapperTemplate $@

clean:
	rm -rf $(BIN_DIR)/

