**Please, keep the template matching your Pull-Request (PR) and check the boxes
that you have completed. You can also include a short description of the PR
(required for formula fixes)**

---

# FORMULA FIX

## Description
*Add here the description of the fix*

## Required
- [ ] Run `brew uninstall --force ${formula} && brew install --build-from-source ${formula}` to test clean installation
- [ ] Run `brew test ${formula}` after clean installation to run the tests
- [ ] Run `brew audit --strict ${formula}` to check syntax (ignore aliases warnings)

# FORMULA UPDATE

## Required
- [ ] Changed **url** download link
- [ ] Changed **sha256** hash
- [ ] Run `brew uninstall --force ${formula} && brew install --build-from-source ${formula}` to test clean installation
- [ ] Run `brew test ${formula}` after clean installation to run the tests
- [ ] Run `brew audit --strict ${formula}` to check syntax (ignore aliases warnings)

## If applicable
- [ ] Changed **version**
- [ ] Renamed `Aliases/${formula}` link
- [ ] Maintained `Formula/${formula}@{previous_version}` link and removed **head** on it

---

# NEW FORMULA

## Required
- [ ] Added **description** and **homepage**
- [ ] Added **url** and **sha256**
- [ ] Added **tests**
- [ ] Run `brew install --build-from-source ${formula}` to test installation
- [ ] Run `brew test ${formula}` to run the tests
- [ ] Run `brew audit --new-formula ${formula}` to check syntax

## If applicable
- [ ] Added **version**
- [ ] Added `Aliases/${formula}@{version}` link (if not under development version)
- [ ] Added **caveats**
- [ ] Added **head**
