set working-directory := "../config/quickshell"

quickshell := require("quickshell")

[doc("Start Quickshell with the configuration in this repository")]
[linux]
start:
    {{ quickshell }} --path .
