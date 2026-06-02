@echo off
setlocal

REM Create the ruleset JSON
(
echo {
echo   "name": "block-unsafe-files",
echo   "target": "push",
echo   "enforcement": "active",
echo   "bypass_actors": [],
echo   "rules": [
echo     {
echo       "type": "file_extension_restriction",
echo       "parameters": {
echo         "restricted_file_extensions": ["*.exe", "*.dll", "*.zip", "*.tar.gz"]
echo       }
echo     },
echo     {
echo       "type": "max_file_size",
echo       "parameters": {
echo         "max_file_size": 10
echo       }
echo     }
echo   ]
echo }
) > push-ruleset.json

for /f "delims=" %%R in ('gh repo view --json nameWithOwner --jq ".nameWithOwner"') do set "REPO=%%R"
for /f "delims=" %%V in ('gh repo view --json visibility --jq ".visibility"') do set "VISIBILITY=%%V"

if not defined REPO (
  echo Could not determine GitHub repository. Check gh auth status and git remote -v.
  exit /b 1
)

if "%VISIBILITY%"=="PUBLIC" (
  echo GitHub does not allow push rulesets on public repositories.
  echo Repo %REPO% is PUBLIC. Make it private or use a different enforcement mechanism.
  exit /b 1
)

echo Creating ruleset on %REPO%...
gh api "/repos/%REPO%/rulesets" -X POST --input push-ruleset.json
