.PHONY: build


TARGET := $(filter-out build,$(MAKECMDGOALS))

build: $(TARGET)
	flutter build $(TARGET)
%:
	@: