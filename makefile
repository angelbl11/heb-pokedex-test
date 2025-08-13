FLUTTER?=flutter
DART?=dart

gen-code:
	@echo "Generating codes"
	$(DART) run build_runner build --delete-conflicting-outputs


run:
	@echo "Running the application"
	$(FLUTTER) run