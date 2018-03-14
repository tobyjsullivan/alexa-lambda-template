SRC_DIR=src
INFRA_DIR=infra
BUILD_DIR=build
ZIP_FILE=$(BUILD_DIR)/skill.zip

.PHONY: build clean infra

build:
	cd $(SRC_DIR) && yarn install
	mkdir -p $(BUILD_DIR)
	cd $(SRC_DIR) && zip -r ../$(ZIP_FILE) ./*

deploy:
	terraform apply $(INFRA_DIR)

init:
	terraform init $(INFRA_DIR)

clean:
	rm -rf $(BUILD_DIR)