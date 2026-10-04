export NH_ELEVATION_STRATEGY := "run0"
export NH_FLAKE := justfile_directory()
export NH_OS_FLAKE := justfile_directory()
export NH_DARWIN_FLAKE := justfile_directory()

nh := require("nh")
hostname := `hostname`

[doc("Build the configuration for the specified host.")]
[group("systems")]
build hostname=hostname: (builder "build" hostname)

[doc("Switch to the configuration for the specified host.")]
[group("systems")]
switch hostname=hostname: (builder "switch" hostname)

[doc("Add the configuration for the specified host to the boot loader entries.")]
[group("systems")]
boot hostname=hostname: (builder "boot" hostname)

[arg("command", pattern="switch|build|boot")]
[doc("Run the specified NH command for the specified host.")]
[private]
builder command hostname:
    {{ nh }} {{ if os() == "macos" { "darwin" } else { "os" } }} {{ command }} --hostname {{ hostname }} --out-link ./result --show-trace
