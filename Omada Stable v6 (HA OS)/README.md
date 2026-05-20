# Omada Controller Stable v6 (HA OS)

This variant is for **Raspberry Pi 5 users running Home Assistant OS**.

## When to use this variant

| Setup | Use |
|---|---|
| Raspberry Pi 5 + Home Assistant OS | **This variant** |
| Raspberry Pi 5 + HA Supervised (Pi OS + Docker) | Omada Stable v6 |
| x86-64 (any HA install) | Omada Stable v6 |
| Older x86-64 without AVX | Omada Stable v6 NO-AVX |

## Why a separate variant?

MongoDB 8.0 (used by the standard Stable v6 image) requires 1 GB-aligned `mmap` regions for its
memory allocator (tcmalloc). HA OS runs add-ons in containers with security restrictions that prevent
these allocations from succeeding, causing MongoDB to crash on startup with:

```
MmapAligned() failed - unable to allocate with tag
FATAL ERROR: Out of memory trying to allocate internal tcmalloc data
```

This variant uses **MongoDB 7.0** (on an Ubuntu 22.04 base), which does not have this requirement
and works correctly inside HA OS containers.

Users running HA Supervised on Raspberry Pi OS are unaffected by this issue and should continue
using the standard Stable v6 add-on to avoid a MongoDB data format compatibility break.

## Configuration

Configuration options are identical to the standard Stable v6 variant. See the
[main README](../README.md) for details.
