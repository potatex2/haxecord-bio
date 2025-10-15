---
name: Bugs
about: For when Potate needs to resolve these (skill) issues. (General bugs)
title: 'TOFIX: Put more things already'
labels: bug
assignees: potatex2

---

Time for your usual CAPTCHA.
## Preliminary Checks
- [ ] I have visited the actual site and the issue is evident
- [ ] My issue is unique and is not listed in previous issues NOR the milestone page
- [ ] This issue is relevant to the overall performance of the website
- [ ] I am the issue, just a silly little goober
```hx
function checkIssue(content:String, ?labels:Array<Label>):Dynamic {
    if (checklist.VALID)
        reportIssue(content, labels);
    else throw 'Invalid issue | ${getInvalid()}';
}
```
