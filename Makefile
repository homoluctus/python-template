BASE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

stage = dev

.PHONY: test
test:
	pipenv run pytest -v --cov=src $(BASE_DIR)/tests/

.PHONY: lint
lint:
	pipenv run pylint --rcfile=pylintrc $(BASE_DIR)/src/ $(BASE_DIR)/tests/

.PHONY: mypy
mypy:
	pipenv run mypy --config-file $(BASE_DIR)/mypy.ini

.PHONY: format
format:
	pipenv run black $(BASE_DIR)/src/ $(BASE_DIR)/tests/

.PHONY: install
install:
ifeq ($(stage),dev)
	pipenv sync -d
else
	pipenv sync --clear

.PHONY: clean
clean:
	pipenv --rm
