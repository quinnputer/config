set working-directory := "../nix/secrets"

export AGENIX_RULES := "default.nix"

agenix := require("agenix")

[doc("Edit the secret at the specified path")]
edit path:
    {{ agenix }} --edit {{ path }}

[doc("Decrypt and show the secret at the specified path")]
show path:
    {{ agenix }} --decrypt {{ path }}
