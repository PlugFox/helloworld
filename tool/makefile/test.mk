test-unit:
	@fvm flutter test \
		--coverage \
		test/unit_test.dart

test-widget:
	@fvm flutter test \
		--coverage \
		test/widget_test.dart

test-integration:
	@fvm flutter test \
		--coverage \
		integration_test/app_test.dart

coverage:
	@lcov --summary coverage/lcov.info

genhtml:
	@genhtml coverage/lcov.info -o coverage/html