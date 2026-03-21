# Atuin Sync — Pending Steps

## On justine (host-001)

1. Rebuild: `just switch host_001`
2. Login: `atuin login -u pabloagn -p 'yourpassword'`
3. Sync: `atuin sync`
4. Verify: `atuin history list --cmd-only | head -5`

## After both machines sync

1. Set `openRegistration = false` in `modules/network/atuin-server.nix`
2. Rebuild alexandria: `just switch host_002`

## Recovery key

Run `atuin key` on alexandria and save it — needed if you ever re-register.
