# Idea not tested and useless
# Instead configured travis-ci/more options/settings/cron jobs :
# on branch travis, run daily

# Synchronize from the official public repository.
git pull origin develop

# Push the changes to produce a build on Travis-ci server.
git push travis-ci travis

