<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Portative Organ

Status: L2 V5 build-packet candidate

This repository is a V5 L2 build-packet candidate for a portable portative organ: a compact flue-pipe instrument played with one hand on a single row of keys while the other hand works a bellows. The bellows feeds a reservoir, the reservoir supplies a windchest, and each key opens a pallet valve to admit wind to a selected flue pipe.

This packet is not build-ready. It contains an L2 review scaffold for wind-path relationships, estimated part families, cut-list placeholders, mechanism questions, and measurement gates. It contains no fabricated dimensions, pipe lengths, tuning tables, wind-pressure values, CAD geometry, DXF coordinates, or measured validation data. All physical proportions, pipe scaling, wind behavior, and ergonomics remain pending measurement and prototype review.

## Packet Map

- `design.md` - mechanism, wind path, pipe/rank concept, and parametric intent.
- `bom.csv` - estimated parts families only.
- `cut-list.csv` - estimated blank and coupon families only.
- `sourcing.csv` - sourcing placeholders; all prices/lead-times TBD.
- `validation.csv` - measurement-gate checklist for the wind-system mule, pallets, keys, and pipe speech; all measured/result fields TBD.
- `risks.md` - risk narrative drawn from the failure modes and open questions below.
- `drawing-brief.md` - required first drawings once a wind-system mule and pipe-scale table exist; no drawings are released yet.
- `visual-output-register.csv` - V5 authority register; every row is concept-only or pending measurement.
- `cad/mcp-session-log.md` - provenance log for every text/CSV/wolfram authoring pass; no MCP, CAD, or image-generation tool session has produced dimensional artifacts.
- `cad/README.md` - honest no-scad gap record: no real pipe-schedule data exists in this repo, so no parametric CAD master was authored.
- `decision-record.md` - decisions, qmd Step 0 result, family placement, and open questions.
- `evolution/` - Stage 0 evolution-pipeline intake (manifest, design intent, revision register) recording the current baseline honestly, including the absence of a CAD master.

## Readiness Boundary

The next useful step is a non-playing wind-system mule: bellows feel, reservoir steadiness, pallet sealing, and windchest leakage. Only after that should the pipe scale, key spacing, valve travel, portable case geometry, and tuning plan be turned into measured design tables. L2 means this repo is organized for that review; it does not authorize fabrication.
