# Task 0007: Complete Atuin Cross-Host Shell History Sync

**Status**: Not Started
**Created**: 2026-03-22
**Priority**: MEDIUM
**Phase**: — Infrastructure

## Overview

Finalize the Atuin shell history sync setup between both hosts (justine/host_001 and alexandria/host_002). The Atuin server is already configured on alexandria, but justine still needs to be registered and synced. After both machines are syncing, open registration should be disabled to lock down the server.

## Objectives

1. Rebuild justine with the Atuin client configuration
2. Log in and sync justine's shell history with the Atuin server on alexandria
3. Verify bidirectional sync works between both hosts
4. Disable open registration on the Atuin server
5. Save the recovery key for disaster recovery

## Implementation

### Step 1 — On justine (host_001)

```bash
# Rebuild to pick up Atuin client config
just switch host_001

# Log in to the Atuin server
atuin login -u pabloagn -p '<password>'

# Initial sync
atuin sync

# Verify
atuin history list --cmd-only | head -5
```

### Step 2 — After Both Machines Sync

```nix
# In modules/network/atuin-server.nix, set:
openRegistration = false;
```

```bash
# Rebuild alexandria to apply
just switch host_002
```

### Step 3 — Save Recovery Key

```bash
# Run on alexandria and save the output securely
atuin key
```

The recovery key is needed if you ever need to re-register or recover the account.

## Files Created/Modified

### Created
None.

### Modified
- `modules/network/atuin-server.nix` — set `openRegistration = false` after both hosts are registered

## Success Criteria

1. `atuin sync` succeeds on both justine and alexandria
2. Shell history entered on one host appears on the other after sync
3. `openRegistration = false` is set and rebuilt on alexandria
4. Recovery key is saved securely (outside of this repo)
5. `ATUIN_PENDINGS.md` can be deleted from the repo root after completion
