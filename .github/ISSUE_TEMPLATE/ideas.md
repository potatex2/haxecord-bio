---
name: Ideas
about: For when you have something Potate can’t think of. (Suggestions)
title: 'Ideas: Add more stuff'
labels: improve
assignees: ''

---

Time for your usual CAPTCHA.
## Preliminary Checks
- [ ] My suggestion is unique and is not listed in previous proposals NOR the milestone page
- [ ] This can be relevant to improving the overall website
- [ ] I just HAD to repeat what was already clear enough
```hx
function checkIdeas(content:String) {
    if (checklist.VALID)
        ideas.push(content);
    else throw 'Invalid submission | ${getInvalid()}';
}
```
