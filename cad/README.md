<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# CAD Starter Notes

There is no OpenSCAD (or other CAD) master in this packet. This is a
deliberate, recorded gap rather than an omission.

## Why no `cad/portative-organ.scad` was authored

A V5 refresh pass (2026-07-01) checked every candidate source of dimensional
truth for this repo — `design.md`, `bom.csv`, `cut-list.csv`,
`decision-record.md`, and `visual-output-register.csv` — for real pipe-schedule
data (per-pipe length, diameter, or a scaling ratio across the rank) that
could drive a parametric envelope model. None exists:

- `design.md` states explicitly: "No pipe length or tuning value is specified
  in this L2 packet" and repeats the same boundary in its V5 Boundary section.
- `bom.csv` row `PO-BOM-010` (flue pipe rank) says "no pipe lengths or tuning
  values in this packet."
- `cut-list.csv` rows `PO-CUT-009`/`PO-CUT-010` (test-pipe and future-rank
  blanks) carry `estimate_size = TBD` and `quantity = TBD`.
- `visual-output-register.csv` already carries a planned-but-absent row for
  CAD (`PO-CAD-PLAN-001`, `cad/portative-organ.scad`,
  `authority=pending_measurement`, `dimension_claim=planned_missing_artifact`)
  and for a pipe-scale table (`PO-PIPE-PLAN-001`,
  `tables/pipe-scale.csv`) — both were already flagged as future, not present.

Authoring a parametric pipe-rank envelope requires at least one real number
per pipe (length, diameter, or a documented scaling ratio/geometric
progression by semitone) to drive the array. This repo has none — every
physical value in the wind system, windchest, keyboard, and pipe subsystems
is `pending_measurement` or `TBD`. Writing a `.scad` file under these
conditions would mean inventing pipe dimensions, which the V5 honesty rules
forbid.

## What would unblock a CAD master

Per `design.md` Parametric Intent and the wind-mule questions in
`validation.csv`, a scad master becomes possible once:

- a measured or reviewed pipe-scale table exists (`tables/pipe-scale.csv`,
  still `planned_missing_artifact`), with at least a scaling ratio or a
  per-pipe length/diameter schedule across the rank; and
- the open-vs-stopped pipe branch decision is made (see
  `decision-record.md` Open Questions).

At that point the envelope model (pipe array by rank position, driven by the
scaling equation) would be an appropriate first parametric CAD pass — pipe
mouth, languid, flue, and toe-hole/voicing geometry remain explicitly out of
scope for that future master, as they are for this note, since voicing is a
separate acoustic-development track from the rank envelope.

## Wolfram (already present, source-only)

`portative-organ-starter.wl` and `wolfram/portative-organ-wolfram-model.wl`
predate this refresh pass and remain source-only, `reference_only`/
`derived_preview` evidence (L2). They are symbolic/relationship models with
estimate constants, not executed, and not fabrication authority. See
`visual-output-register.csv` (`PO-WL-STARTER-001`, `PO-WL-MODEL-001`) and
`cad/mcp-session-log.md`.
