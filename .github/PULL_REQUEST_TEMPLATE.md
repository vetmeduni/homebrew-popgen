**Please, keep the template matching your PR and check the boxes that you have completed.**

---

# FORMULA UPDATE

- [ ] Changed download link (**url**)
- [ ] Changed **sha256** hash
- [ ] Changed **version**
- [ ] Changed aliases (if applicable)
- [ ] Run `brew uninstall --force ${formula} && brew install --build-from-source ${formula}` to test clean installation
- [ ] Run `brew test ${formula}` after clean installation to run the tests
- [ ] Run `brew audit --strict ${formula}` to check syntax (ignore aliases warnings)

---

# NEW FORMULA

- [ ] Added **description** and **homepage**
- [ ] Added **url**, **version** and **sha256**
- [ ] Added **caveats** (if applicable)
- [ ] Addes **tests**
- [ ] Run `brew install --build-from-source ${formula}` to test installation
- [ ] Run `brew test ${formula}` to run the tests
- [ ] Run `brew audit --new-formula ${formula} && brew audit --strict ${formula}` to check syntax

