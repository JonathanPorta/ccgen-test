gh_check_vars:
ifeq ($(GITHUB_ACCESS_TOKEN),)
	@echo "The env variable 'CIRCLECI_TOKEN' is not defined."
else ifeq ($(VERSION),)
	@echo "The env variable 'VERSION' is not defined. This should be of the format 'x.x.x'."
else ifeq ($(REPO_SLUG),)
	@echo "The env variable 'REPO_SLUG' is not defined. This should be of the format 'gh_user/repo_name'."
else ifeq ($(ARTIFACT_NAME),)
	@echo "The env variable 'ARTIFACT_NAME' is not defined."
else
	@echo "Looks like all of the necessary variables exist. Good Job."
	@echo ''
endif

gh_release: gh_check_vars
	./ops/gh.sh upload ${REPO_SLUG} ${VERSION} ./${ARTIFACT_NAME}

gh_unrelease: gh_check_vars
	./ops/gh.sh delete ${REPO_SLUG} ${VERSION}
