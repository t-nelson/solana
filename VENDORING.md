1. reserve the new crate name with an anza- prefix
2. have a github org owner fork the upstream repo under the anza-xyz gh org
3. have the org owner create a new branch based off the target release tag
4. create a pr against the new upstream branch
    * renaming the crate to match anza-prefixed, reserved name
    * appending a descriptive semver prerelease string to the version
    * fixing up the repo throughout as impacted by these changes
5. land rename/reversion pr
6. create a pr against the new upstream branch
    * cherry-picking desired commit(s)
    * fixing up thre repo throught as impacted by the changes
7. land chery-pick pr

