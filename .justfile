# Edit and decrypt Agenix secrets
mod secrets "./scripts/secrets.just"

export NH_ELEVATION_STRATEGY := if os() == "linux" { "run0" } else { "sudo" }
export NH_FLAKE := justfile_directory()
export NH_OS_FLAKE := justfile_directory()
export NH_DARWIN_FLAKE := justfile_directory()

caligula := require("caligula")
nh := require("nh")
nix := require("nix")
nixos-anywhere := require("nixos-anywhere")
hostname := `hostname`

[doc("Build the configuration for the specified host")]
[group("systems")]
build hostname=hostname: (builder "build" hostname)

[doc("Switch to the configuration for the specified host")]
[group("systems")]
switch hostname=hostname: (builder "switch" hostname)

[doc("Add the configuration for the specified host to the boot loader entries")]
[group("systems")]
boot hostname=hostname: (builder "boot" hostname)

[doc("Install the specified NixOS configuration on the host at the specified address")]
[group("servers")]
provision hostname address:
    {{ nixos-anywhere }} --flake .#{{ hostname }} --target-host {{ address }}

[arg("scope", pattern="all|profile|user")]
[doc("Run garbage collection on the current system and rebuild the configuration")]
[group("utilities")]
clean scope="all": && switch
    {{ nh }} clean {{ scope }}

[doc("Build the custom ISO image and burn it to a USB")]
[group("utilities")]
burn:
    {{ nix }} build .#soul-iso
    {{ caligula }} burn ./result/iso/soul-x86_64.iso

[arg("command", pattern="switch|build|boot")]
[private]
builder command hostname:
    {{ nh }} {{ if os() == "macos" { "darwin" } else { "os" } }} {{ command }} --hostname {{ hostname }} --out-link ./result --show-trace
